import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:ui';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as rtc_local_view;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as rtc_remote_view;
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:snapping_sheet/snapping_sheet.dart';
import 'package:terapizone/config/api_constants.dart';
import 'package:terapizone/core/services/assets_service.dart';
import 'package:terapizone/features/appointment/model/video_call_error_log_request_model.dart';
import 'package:terapizone/features/appointment/services/AppointmentService.dart';
import 'package:terapizone/ui/models/appointment_join_model.dart';

class ViewVideoCall extends StatefulWidget {
  const ViewVideoCall({Key? key, required this.session, required this.appointmendId}) : super(key: key);
  final AppointmentJoinModel session;
  final String appointmendId;

  @override
  _ViewVideoCallState createState() => _ViewVideoCallState();
}

class _ViewVideoCallState extends State<ViewVideoCall> {
  final _users = <int>[];
  final _infoStrings = <String>[];
  bool muted = false;
  bool remoteMuted = false;
  bool localVideoStop = false;
  String userName = "TZ";
  bool remoteVideoStop = false;
  late RtcEngine _engine;
  final SnappingSheetController _snappingSheetController = SnappingSheetController();

  double left = window.physicalSize.width / window.devicePixelRatio - 185;
  double top = window.physicalSize.height / window.devicePixelRatio - 270;
  final AppointmentService appointmentService = AppointmentService();

  @override
  void dispose() {
    // clear users
    _users.clear();
    // destroy sdk
    _engine.leaveChannel();
    _engine.destroy();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // initialize agora sdk
    inspect(widget.session);
    initialize();
  }

  Future<void> initialize() async {
    if (ApiConstants.appId.isEmpty) {
      setState(() {
        _infoStrings.add(
          'APP_ID missing, please provide your APP_ID in settings.dart',
        );
        _infoStrings.add('Agora Engine is not starting');
      });
      return;
    }
    await _initAgoraRtcEngine();
    _addAgoraEventHandlers();
    // await _engine.enableWebSdkInteroperability(true);

    // var userString = await UserSecureStorage.getField("user");
    // var json = jsonDecode(userString!);
    // setState(() {
    //   userName = json["nickName"];
    // });

    inspect(widget.session);
    VideoEncoderConfiguration configuration = VideoEncoderConfiguration();
    configuration.dimensions = VideoDimensions(width: 1920, height: 1080);
    await _engine.setVideoEncoderConfiguration(configuration);
    await _engine.joinChannel(widget.session.token, widget.session.channel!, null, widget.session.uid!);
  }

  Future<void> _initAgoraRtcEngine() async {
    var status = await [
      Permission.camera,
      Permission.microphone,
    ].request();
    inspect(status);
    _engine = await RtcEngine.create(ApiConstants.appId);
    await _engine.enableVideo();
    await _engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    await _engine.setClientRole(ClientRole.Broadcaster);
  }

  void _addAgoraEventHandlers() {
    _engine.setEventHandler(RtcEngineEventHandler(
      error: (code) {
        setState(() {
          final info = 'onError: $code';
          _infoStrings.add(info);
        });
      },
      joinChannelSuccess: (channel, uid, elapsed) {
        inspect(widget.session);
        setState(() {
          final info = 'onJoinChannel: $channel, uid: $uid';
          _infoStrings.add(info);
        });
      },
      leaveChannel: (stats) {
        setState(() {
          _infoStrings.add('onLeaveChannel');
          _users.clear();
        });
      },
      userJoined: (uid, elapsed) {
        setState(() {
          final info = 'userJoined: $uid';
          _infoStrings.add(info);
          _users.add(uid);
        });
      },
      remoteAudioStateChanged: (uid, AudioRemoteState state, AudioRemoteStateReason reason, elapsed) {
        if (reason == AudioRemoteStateReason.RemoteMuted) {
          setState(() {
            remoteMuted = true;
          });
        }
        if (reason == AudioRemoteStateReason.RemoteUnmuted) {
          setState(() {
            remoteMuted = false;
          });
        }
      },
      remoteVideoStateChanged: (uid, VideoRemoteState state, VideoRemoteStateReason reason, elapsed) async {
        if (reason == VideoRemoteStateReason.NetworkRecovery) {
          final VideoCallErrorLogRequestModel model = VideoCallErrorLogRequestModel(
            appointmentId: widget.appointmendId,
            errorCode: elapsed.toString(),
            errorText: "Uid $uid is ${elapsed.toString()}",
          );
          await appointmentService.videoErrorLog(model);
        }
        if (reason == VideoRemoteStateReason.RemoteMuted) {
          setState(() {
            remoteVideoStop = true;
          });
        }
        if (reason == VideoRemoteStateReason.RemoteUnmuted) {
          setState(() {
            remoteVideoStop = false;
          });
        }
      },
      userOffline: (uid, elapsed) async {
        inspect("user offline $uid $elapsed");
        if (elapsed == UserOfflineReason.Dropped || elapsed == UserOfflineReason.Quit) {
          final VideoCallErrorLogRequestModel model = VideoCallErrorLogRequestModel(
            appointmentId: widget.appointmendId,
            errorCode: elapsed.toString(),
            errorText: "Uid $uid is ${elapsed.toString()}",
          );
          inspect(model);
          await appointmentService.videoErrorLog(model);
        }
        setState(() {
          final info = 'userOffline: $uid';
          _infoStrings.add(info);
          _users.remove(uid);
        });
      },
      firstRemoteVideoFrame: (uid, width, height, elapsed) {
        setState(() {
          final info = 'firstRemoteVideo: $uid ${width}x $height';
          _infoStrings.add(info);
        });
      },
    ));
  }

  List<Widget> _getRenderViews() {
    final List<StatefulWidget> list = [];

    list.add(const rtc_local_view.SurfaceView());

    for (var uid in _users) {
      list.add(rtc_remote_view.SurfaceView(
        uid: uid,
        channelId: widget.session.channel!,
      ));
    }
    return list;
  }

  Widget _videoView(view) {
    return Expanded(child: Container(child: view));
  }

  void toggleSnappingPanel() {
    var position = _snappingSheetController.currentPosition;
    if (position < 100) {
      _snappingSheetController.snapToPosition(
        const SnappingPosition.factor(positionFactor: 0.15),
      );
    } else {
      _snappingSheetController.snapToPosition(const SnappingPosition.factor(positionFactor: 0.018));
    }
  }

  Widget _viewRows() {
    final views = _getRenderViews();
    inspect(_infoStrings);
    return Stack(
      children: <Widget>[
        remoteVideoStop
            ? GestureDetector(
                onTap: () => toggleSnappingPanel(),
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromRGBO(10, 12, 21, 1),
                        Color.fromRGBO(22, 26, 44, 1),
                        Color.fromRGBO(10, 12, 21, 1),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.all(18),
                      width: MediaQuery.of(context).size.width * .5,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                            radius: 0.7,
                            colors: [
                              Colors.white.withOpacity(0.05),
                              Colors.white.withOpacity(0.1),
                              Colors.white.withOpacity(0.0),
                            ],
                            stops: const [0.4, 0.6, 0.8],
                            center: Alignment.center),
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width * .5,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(0.04),
                        ),
                        child: const ClipOval(
                          child: Image(
                            image: NetworkImage("https://i.pravatar.cc/300"),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            : GestureDetector(
                onTap: () => toggleSnappingPanel(),
                child: Container(
                  color: Colors.black,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        child: views.length > 1
                            ? _videoView(views[1])
                            : Stack(
                                alignment: Alignment.center,
                                children: [
                                  _videoView(views[0]),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        width: MediaQuery.of(context).size.width * .4,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white.withOpacity(0.04),
                                        ),
                                        child: const ClipOval(
                                          child: Image(
                                            image: NetworkImage("https://i.pravatar.cc/300"),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "Seda Bilgin",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 24,
                                          letterSpacing: -0.2,
                                          height: 1.6,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        "Aranıyor...",
                                        style: TextStyle(
                                          fontSize: 14,
                                          letterSpacing: 0.1,
                                          color: Colors.white.withOpacity(0.56),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                      ),
                      if (remoteMuted)
                        Positioned(
                          top: 60,
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(0, 0, 0, 0.32),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SvgPicture.asset(
                                  AssetService.liveMicOff,
                                  height: 14,
                                ),
                                const SizedBox(width: 12),
                                const Text(
                                  "Seda Bilgin susturdu",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                    ],
                  ),
                ),
              ),
        if (views.length > 1)
          Positioned(
            left: left,
            top: top,
            child: Draggable(
              feedback: Container(
                color: Colors.green,
              ),
              childWhenDragging:
                  LocalCameraView(localVideoStop: localVideoStop, userName: userName, views: views, muted: muted),
              onDragUpdate: (details) {
                setState(() {
                  left = details.localPosition.dx - 70;
                  top = details.localPosition.dy - 105;
                });
              },
              onDragStarted: () {
                setState(() {
                  top = top;
                  left = left;
                });
              },
              onDragEnd: (details) {
                setState(() {
                  var coordinate = (details.offset.dx + 70) / MediaQuery.of(context).size.width;
                  bool isLeft = coordinate < 0.5;
                  left = isLeft ? 10 : MediaQuery.of(context).size.width - 160;

                  top = details.offset.dy + 140 > MediaQuery.of(context).size.height - 120
                      ? MediaQuery.of(context).size.height - 255
                      : details.offset.dy > 0
                          ? details.offset.dy
                          : 30;
                });
              },
              child: LocalCameraView(localVideoStop: localVideoStop, userName: userName, views: views, muted: muted),
            ),
          ),
      ],
    );
  }

  Widget _toolbar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        RawMaterialButton(
          onPressed: _onSwitchCamera,
          child: SvgPicture.asset(
            AssetService.liveSwitchCamera,
            width: 30,
            height: 25,
          ),
          shape: const CircleBorder(),
          elevation: 2.0,
          fillColor: Colors.white.withOpacity(0.24),
          padding: const EdgeInsets.all(17),
        ),
        RawMaterialButton(
          onPressed: () {
            setState(() {
              localVideoStop = !localVideoStop;
            });
            _engine.muteLocalVideoStream(localVideoStop);
          },
          child: localVideoStop
              ? SvgPicture.asset(
                  AssetService.liveCameraOff,
                  width: 30,
                  height: 25,
                )
              : SvgPicture.asset(
                  AssetService.liveCameraOn,
                  width: 30,
                  height: 25,
                ),
          shape: const CircleBorder(),
          elevation: 1.0,
          fillColor: Colors.white.withOpacity(0.24),
          padding: const EdgeInsets.all(17),
        ),
        RawMaterialButton(
          onPressed: _onToggleMute,
          child: muted
              ? SvgPicture.asset(
                  AssetService.liveMicOff,
                  width: 30,
                  height: 25,
                )
              : SvgPicture.asset(
                  AssetService.liveMicOn,
                  width: 30,
                  height: 25,
                ),
          shape: const CircleBorder(),
          elevation: 1.0,
          fillColor: Colors.white.withOpacity(0.24),
          padding: const EdgeInsets.all(17),
        ),
        RawMaterialButton(
          onPressed: () => _onCallEnd(context),
          child: SvgPicture.asset(AssetService.liveCloseSvg),
          shape: const CircleBorder(),
          elevation: 2.0,
          fillColor: Colors.red,
          padding: const EdgeInsets.all(12),
        ),
      ],
    );
  }

  Widget _panel() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 48),
      alignment: Alignment.bottomCenter,
      child: FractionallySizedBox(
        heightFactor: 0.5,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 48),
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            reverse: true,
            itemCount: _infoStrings.length,
            itemBuilder: (BuildContext context, int index) {
              if (_infoStrings.isEmpty) {
                return const Text("null"); // return type can't be null, a widget was required
              }
              return Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 3,
                  horizontal: 10,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 2,
                          horizontal: 5,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.yellowAccent,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          _infoStrings[index],
                          style: const TextStyle(color: Colors.blueGrey),
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _onCallEnd(BuildContext context) {
    Navigator.pop(context);
  }

  void _onToggleMute() {
    setState(() {
      muted = !muted;
    });
    _engine.muteLocalAudioStream(muted);
  }

  void _onSwitchCamera() {
    _engine.switchCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: SnappingSheet(
          controller: _snappingSheetController,
          lockOverflowDrag: true,
          child: Center(child: _viewRows()),
          grabbingHeight: 30,
          sheetBelow: SnappingSheetContent(
            draggable: true,
            sizeBehavior: SheetSizeStatic(expandOnOverflow: true, size: 100),
            child: Stack(
              fit: StackFit.expand,
              alignment: Alignment.center,
              children: [
                ClipRRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                    child: Container(),
                  ),
                ),
                Container(color: const Color.fromARGB(90, 0, 0, 0), child: _toolbar()),
              ],
            ),
          ),
          snappingPositions: const [
            SnappingPosition.factor(positionFactor: 0.018),
            SnappingPosition.factor(positionFactor: 0.15),
          ],
          grabbing: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                decoration: const BoxDecoration(
                    color: Color.fromARGB(90, 0, 0, 0),
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12))),
              ),
              Positioned(
                child: Container(
                  width: 40,
                  height: 5,
                  decoration:
                      BoxDecoration(color: Colors.white.withOpacity(0.24), borderRadius: BorderRadius.circular(100)),
                ),
                top: 10,
              )
            ],
          ),
        ));
  }
}

class LocalCameraView extends StatelessWidget {
  const LocalCameraView({
    Key? key,
    required this.localVideoStop,
    required this.userName,
    required this.views,
    required this.muted,
  }) : super(key: key);

  final bool localVideoStop;
  final String userName;
  final List<Widget> views;
  final bool muted;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 210,
        decoration: const BoxDecoration(
          color: Colors.grey,
        ),
        width: 140,
        child: Stack(
          alignment: Alignment.center,
          children: [
            localVideoStop
                ? Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromRGBO(76, 78, 92, 1),
                          Color.fromRGBO(17, 18, 21, 1),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: Center(
                        child: Container(
                      padding: const EdgeInsets.all(24),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        userName[0].toUpperCase(),
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 32,
                          letterSpacing: -0.2,
                        ),
                      ),
                    )),
                  )
                : views[0],
            muted
                ? Positioned(
                    bottom: 10,
                    child: SvgPicture.asset(
                      AssetService.liveMicOff,
                      width: 20,
                    ))
                : const SizedBox()
          ],
        ),
      ),
    );
  }
}
