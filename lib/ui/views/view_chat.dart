import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:terapizone/core/services/service_chronos.dart';
import 'package:terapizone/core/utils/general_data.dart';
import 'package:terapizone/core/utils/utilities.dart';
import 'package:terapizone/ui/controllers/controller_chat.dart';
import 'package:terapizone/ui/controllers/controller_login_register.dart';
import 'package:terapizone/ui/controllers/message_signal_controller.dart';
import 'package:terapizone/ui/models/chat_detail_model.dart';
import 'package:terapizone/ui/shared/uicolor.dart';
import 'package:terapizone/ui/shared/uipath.dart';
import 'package:terapizone/ui/shared/uitext.dart';
import 'package:terapizone/ui/views/audio_container.dart';
import 'package:terapizone/ui/views/view_base.dart';
import 'package:terapizone/ui/views/view_photo.dart';
import 'package:terapizone/ui/views/views_consultant/view_client_profile.dart';
import 'package:terapizone/ui/widgets/widget_buttons.dart';
import 'package:terapizone/ui/widgets/widget_profil_photo.dart';
import 'package:terapizone/ui/widgets/widget_state.dart';
import 'package:terapizone/ui/widgets/widget_text.dart';

bool isChatOpen = false;

class ViewChat extends StatelessWidget {
  final String? messageGroupId;
  const ViewChat({Key? key, required this.messageGroupId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final c = Get.put(ControllerChat(messageGroupId: messageGroupId));

    isChatOpen = true;
    return WillPopScope(
      onWillPop: () async {
        isChatOpen = false;
        c.disposeOnWillPop();
        return true;
      },
      child: ViewBase(
        statusbarBrightness: SystemUiOverlayStyle.dark,
        child: Container(
          height: Get.size.height,
          width: Get.size.width,
          alignment: Alignment.center,
          color: UIColor.wildSand,
          child: Obx(() => c.busy
              ? const ActivityIndicator()
              : SafeArea(
                  child: Scaffold(
                      //key: c.scaffoldKey,
                      backgroundColor: UIColor.wildSand,
                      appBar: TerapizoneUser.user != null && TerapizoneUser.user!.user!.accountTypeId == 2
                          ? getAppBarConsultant(
                              title: c.chatList.isNotEmpty ? c.chatList[0].title ?? '' : '',
                              clientId: c.chatList.isNotEmpty ? c.chatList[0].receiverId ?? '' : '',
                              list: c.chatList)
                          : getAppBarUser(title: c.chatList.isNotEmpty ? c.chatList[0].title ?? '' : ''),
                      body: body()),
                )),
        ),
      ),
    );
  }

  AppBar getAppBarUser({required String title}) {
    return AppBar(
      elevation: 0,
      automaticallyImplyLeading: false,
      backgroundColor: UIColor.wildSand,
      leadingWidth: 30,
      leading: const GetBackButton(isChatView: true),
      centerTitle: true,
      title: TextBasic(
        text: title,
        fontWeight: FontWeight.w600,
        fontSize: 17,
      ),
      systemOverlayStyle: SystemUiOverlayStyle.light,
    );
  }

  AppBar getAppBarConsultant({required String title, required String clientId, required List<ChatDetailModel> list}) {
    return AppBar(
      elevation: 0,
      automaticallyImplyLeading: false,
      backgroundColor: UIColor.wildSand,
      leadingWidth: 30,
      leading: const GetBackButton(isChatView: true),
      centerTitle: false,
      title: Row(
        children: [
          getProfilPhoto(
              'https://static.wixstatic.com/media/b88739_e711f50959d3412aa5c1f9490b4f85af~mv2.jpg/v1/fill/w_508,h_610,al_c,q_80,usm_0.66_1.00_0.01/b88739_e711f50959d3412aa5c1f9490b4f85af~mv2.webp',
              title),
          const SizedBox(width: 15),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextBasic(
                text: title,
                fontSize: 15,
                fontWeight: FontWeight.w600,
                maxLines: 1,
              ),
              /*    TextBasic(
                text: 'Depresyon/Mutsuzluk',
                color: UIColor.tuna.withOpacity(.6),
                fontSize: 13,
                maxLines: 2,
              ), */
            ],
          ),
        ],
      ),
      actions: [
        Align(
          alignment: Alignment.centerRight,
          child: GestureDetector(
            onTap: () {
              if (clientId.isNotEmpty) {
                Get.to(() => ViewClientProfile(
                      id: list.last.receiverId!,
                      name: title,
                    ));
              }
            },
            behavior: HitTestBehavior.translucent,
            child: Padding(
                padding: const EdgeInsets.only(right: 16),
                child: SvgPicture.asset(
                  UIPath.more,
                  fit: BoxFit.scaleDown,
                )),
          ),
        ),
      ],
      systemOverlayStyle: SystemUiOverlayStyle.light,
    );
  }

  Widget body() {
    final ControllerChat c = Get.find();

    return Container(
      height: Get.height,
      width: Get.width,
      decoration: BoxDecoration(color: UIColor.white),
      child: Stack(
        children: <Widget>[
          getMessageList(),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: const EdgeInsets.only(left: 16, bottom: 10, top: 10),
              height: 60,
              width: double.infinity,
              color: Colors.white,
              child: c.isUplaodingFile
                  ? const ChatLoadingIndicator()
                  : c.isRecording
                      ? getAudioContainer()
                      : getBottomBar(),
            ),
          ),
        ],
      ),
    );
  }

  Widget getMessageList() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 60.0),
      child: GetX<SignalRMessageController>(
        init: SignalRMessageController(),
        initState: (initController) {
          initController.controller!.getMessageDetails();
        },
        builder: (controller) {
          if (controller.messageList.value == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          var messages = controller.messageList.value!;
          return ListView.builder(
            reverse: messages.length == 1 ? false : true,
            shrinkWrap: true,
            itemCount: messages.length,
            itemBuilder: (context, index) {
              final message = messages[index];
              final String userId = GeneralData.getUserInfo();
              final bool isSender = message.senderUserId == userId;
              return Container(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
                child: Align(
                  alignment: (!isSender ? Alignment.topLeft : Alignment.topRight),
                  child:
                      //if message is photo
                      message.type == 1
                          ? SizedBox(
                              width: Get.width * .3,
                              child: GestureDetector(
                                onTap: () => Get.to(() => ViewPhoto(file: message.fileUrl!)),
                                child: FadeInImage(
                                  image: NetworkImage(message.fileUrl!),
                                  placeholder: AssetImage(UIPath.spinnerGif),
                                  fit: BoxFit.scaleDown,
                                  placeholderErrorBuilder: (context, error, stackTrace) {
                                    return Card(child: Image.asset(UIPath.placeholderImage));
                                  },
                                  imageErrorBuilder: (context, error, stackTrace) {
                                    return Card(child: Image.asset(UIPath.placeholderImage));
                                  },
                                ),
                              ),
                            )
                          : Column(
                              // crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Align(
                                  alignment: !isSender ? Alignment.centerLeft : Alignment.centerRight,
                                  child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: (!isSender ? UIColor.iron : UIColor.azureRadiance),
                                      ),
                                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                                      child: //if message is text
                                          message.type == null
                                              ? TextBasic(
                                                  text: message.text!,
                                                  fontSize: 17,
                                                  color: !isSender ? UIColor.black : UIColor.white,
                                                )
                                              : message.type == 4
                                                  ? GestureDetector(
                                                      onTap: () {
                                                        if (TerapizoneUser.user != null &&
                                                            TerapizoneUser.user!.user!.accountTypeId == 1) {
                                                          // Get.to(() => ViewTest(
                                                          //       testId: message.test
                                                          //               .testId ??
                                                          //           0,
                                                          //     ));
                                                        }
                                                      },
                                                      child: TextBasic(
                                                        text: message.text!,
                                                        fontSize: 17,
                                                        color: !isSender ? UIColor.black : UIColor.white,
                                                        underline: true,
                                                      ),
                                                    )
                                                  :
                                                  //if messages is sound
                                                  AudioMessageContainer(message: message)),
                                ),
                                //time
                                Row(
                                  mainAxisAlignment: !isSender ? MainAxisAlignment.start : MainAxisAlignment.end,
                                  children: [
                                    TextBasic(
                                      text: ChronosService.getTime(message.created!),
                                      fontSize: 11,
                                      color: UIColor.black,
                                      textAlign: TextAlign.right,
                                    ),
                                    const SizedBox(width: 4),
                                    const Icon(Icons.done_all_outlined, size: 16),
                                  ],
                                ),
                              ],
                            ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget getBottomBar() {
    return Row(
      children: <Widget>[
        getFileButton(),
        const SizedBox(width: 12),
        getMsgTextField(),
        const SizedBox(width: 15),
        getSendMsgButton(),
      ],
    );
  }

  GestureDetector getFileButton() {
    final ControllerChat c = Get.find();
    final SignalRMessageController messageController = Get.find();

    return GestureDetector(
      onTap: () {
        Get.bottomSheet(
            Container(
              color: UIColor.transparent,
              alignment: Alignment.bottomCenter,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(13),
                        color: UIColor.abbey,
                      ),
                      width: Get.width - 16,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(13),
                          color: UIColor.abbey.withOpacity(.8),
                        ),
                        width: Get.width - 16,
                        child: Column(
                          children: [
                            const SizedBox(height: 16),
                            //camera photo
                            getLine(
                              icon: UIPath.camera,
                              title: UIText.chatCamera,
                              onTap: () async {
                                try {
                                  final ImagePicker _picker = ImagePicker();

                                  final xfile = await _picker.pickImage(source: ImageSource.camera);
                                  if (xfile != null) {
                                    messageController.sendImage(xfile);
                                  } else {
                                    log("NULL");
                                  }
                                } catch (e) {
                                  Utilities.showToast(e.toString());
                                }
                              },
                              isDivider: true,
                            ),
                            //gallery photo
                            getLine(
                              icon: UIPath.photo,
                              title: UIText.chatPhoto,
                              onTap: () async {
                                try {
                                  final ImagePicker _picker = ImagePicker();

                                  final xfile = await _picker.pickImage(source: ImageSource.gallery);
                                  if (xfile != null) {
                                    messageController.sendImage(xfile);
                                  } else {
                                    log("NULL");
                                  }
                                } catch (e) {
                                  Utilities.showToast(e.toString());
                                }
                              },
                              isDivider: true,
                            ),
                            //document
                            /* getLine(
                              icon: UIPath.document,
                              title: UIText.chatDocument,
                              onTap: () {},
                              isDivider: true,
                            ), */
                            //sound
                            getLine(
                                icon: UIPath.voice,
                                title: UIText.chatVoiceMessage,
                                onTap: () async {
                                  Get.back();
                                  c.isRecording ? c.stop() : c.start();
                                },
                                isDivider: TerapizoneUser.user!.user!.accountTypeId == 2 ? true : false),
                            //test
                            // accountTypeId == 2 -> therapist
                            if (TerapizoneUser.user!.user!.accountTypeId == 2)
                              getLine(
                                icon: UIPath.pen,
                                title: UIText.chatSendTest,
                                onTap: () => getTextBottomSheet(),
                              ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: Get.width - 8,
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: ButtonBasic(
                        buttonText: UIText.chatButtonCancel,
                        textColor: UIColor.azureRadiance,
                        onTap: () => Get.back(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            backgroundColor: UIColor.transparent);
      },
      child: Icon(
        Icons.add,
        color: UIColor.azureRadiance,
        size: 36,
      ),
    );
  }

  Expanded getMsgTextField() {
    final ControllerChat c = Get.find();

    return Expanded(
      child: TextFormField(
        controller: c.msgController,
        onFieldSubmitted: (val) => FocusScope.of(Get.context!).requestFocus(FocusNode()),
        cursorColor: UIColor.azureRadiance,
        style: TextStyle(fontSize: 13, color: UIColor.black),
        onChanged: (val) => c.setIsSendActive(),
        decoration: InputDecoration(
          hintText: UIText.chatMsgHint,
          contentPadding: const EdgeInsets.only(left: 8),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14), borderSide: BorderSide(color: UIColor.frenchGray)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14), borderSide: BorderSide(color: UIColor.azureRadiance)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14), borderSide: BorderSide(color: UIColor.redOrange)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14), borderSide: BorderSide(color: UIColor.redOrange)),
        ),
      ),
    );
  }

  Widget getAudioContainer() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Spacer(),
            _buildRecordStopControl(),
            const SizedBox(width: 20),
            _buildPauseResumeControl(),
            const SizedBox(width: 20),
            _buildText(),
            const Spacer(),
            getSendMsgButton(),
          ],
        ),
      ],
    );
  }

  Widget _buildRecordStopControl() {
    final ControllerChat c = Get.find();

    late Icon icon;
    late Color color;

    if (c.isRecording || c.isPaused) {
      icon = const Icon(Icons.stop, color: Colors.red, size: 30);
      color = Colors.red.withOpacity(0.1);
    } else {
      final theme = Theme.of(Get.context!);
      icon = Icon(Icons.mic, color: theme.primaryColor, size: 30);
      color = theme.primaryColor.withOpacity(0.1);
    }

    return ClipOval(
      child: Material(
        color: color,
        child: InkWell(
          child: SizedBox(width: 40, height: 40, child: icon),
          onTap: () {
            c.isRecording ? c.stop() : c.start();
          },
        ),
      ),
    );
  }

  Widget _buildPauseResumeControl() {
    final ControllerChat c = Get.find();

    if (!c.isRecording && !c.isPaused) {
      return const SizedBox.shrink();
    }

    late Icon icon;
    late Color color;

    if (!c.isPaused) {
      icon = const Icon(Icons.pause, color: Colors.red, size: 30);
      color = Colors.red.withOpacity(0.1);
    } else {
      final theme = Theme.of(Get.context!);
      icon = const Icon(Icons.play_arrow, color: Colors.red, size: 30);
      color = theme.primaryColor.withOpacity(0.1);
    }

    return ClipOval(
      child: Material(
        color: color,
        child: InkWell(
          child: SizedBox(width: 40, height: 40, child: icon),
          onTap: () {
            c.isPaused ? c.resume() : c.pause();
          },
        ),
      ),
    );
  }

  Widget _buildText() {
    final ControllerChat c = Get.find();

    if (c.isRecording || c.isPaused) {
      return _buildTimer();
    }

    return const Text("Waiting to record");
  }

  Widget _buildTimer() {
    final ControllerChat c = Get.find();

    final String minutes = _formatNumber(c.recordDuration ~/ 60);
    final String seconds = _formatNumber(c.recordDuration % 60);

    return Text(
      '$minutes : $seconds',
      style: const TextStyle(color: Colors.red),
    );
  }

  String _formatNumber(int number) {
    String numberStr = number.toString();
    if (number < 10) {
      numberStr = '0' + numberStr;
    }

    return numberStr;
  }

  Padding getSendMsgButton() {
    final ControllerChat c = Get.find();

    final SignalRMessageController signalRMessageController = Get.find();
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: GestureDetector(
        onTap: () {
          if (c.isRecording) {
            c.stop();
          } else if (!c.isRecording && c.msgController.text.isNotEmpty) {
            signalRMessageController.sendMessage(c.msgController.text);
            c.msgController.clear();
            // c.send(
            //     c.msgController.text, MessagePosition.R, MessageFileTypes.text);
          }
        },
        child: Obx(() => SvgPicture.asset(
            c.isSendActive || c.isRecording ? UIPath.sendMessageActive : UIPath.sendMessageDefault,
            width: 36,
            height: 36)),
      ),
    );
  }

  Widget getLine({
    required String icon,
    required String title,
    required Function() onTap,
    bool? isDivider = false,
  }) {
    return Column(
      children: [
        const SizedBox(height: 16),
        GestureDetector(
          onTap: onTap,
          behavior: HitTestBehavior.translucent,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 24.0, right: 16),
                child: SvgPicture.asset(
                  icon,
                  width: 24,
                  height: 24,
                  fit: BoxFit.scaleDown,
                ),
              ),
              Expanded(
                child: TextBasic(
                  text: title,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        if (isDivider!) Divider(color: UIColor.tuna.withOpacity(.38), height: 1),
      ],
    );
  }

  Widget getAudioPlayer({required String messagePosition, required int index}) {
    // return Row(
    //   mainAxisSize: MainAxisSize.min,
    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //   children: <Widget>[
    //     _buildControl(messagePosition, index),
    //     Expanded(child: _buildSlider(messagePosition, index)),
    //   ],
    // );
    return SizedBox();
  }

  Widget _buildControl(String messagePosition, int index) {
    return ClipOval(
      child: GetBuilder<ControllerChat>(
        init: ControllerChat(),
        initState: (_) {},
        builder: (c) {
          Icon icon;
          Color color;

          if (c.chatList[index].audioPlayer!.playerState.playing && c.selectedIndex == index) {
            icon = const Icon(Icons.pause, color: Colors.red, size: 30);
            color = UIColor.white;
          } else {
            final theme = Theme.of(Get.context!);
            icon = Icon(Icons.play_arrow, color: theme.primaryColor, size: 30);
            color = UIColor.white;
          }
          return Material(
            color: color,
            child: InkWell(
              child: SizedBox(width: c.controlSize, height: c.controlSize, child: icon),
              onTap: () {
                if (c.chatList[index].audioPlayer!.playerState.playing) {
                  c.pauseSound();
                } else {
                  c.playSound(index: index);
                }
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildSlider(String messageType, int index) {
    return GetBuilder<ControllerChat>(
      init: ControllerChat(),
      initState: (_) {},
      builder: (c) {
        final position =
            c.selectedIndex == index ? c.chatList[index].audioPlayer!.position : const Duration(seconds: 0);
        final duration = c.chatList[index].audioPlayer!.duration;
        bool canSetValue = false;
        if (duration != null) {
          canSetValue = position.inMilliseconds > 0;
          canSetValue &= position.inMilliseconds < duration.inMilliseconds;
        }
        return Slider(
          activeColor: messageType == "L" ? UIColor.azureRadiance : UIColor.white,
          inactiveColor: messageType == "L" ? UIColor.azureRadiance : UIColor.white,
          onChanged: (v) {
            if (duration != null) {
              final position = v * duration.inMilliseconds;
              c.chatList[index].audioPlayer!.seek(Duration(milliseconds: position.round()));
            }
          },
          value: canSetValue && duration != null ? position.inMilliseconds / duration.inMilliseconds : 0.0,
        );
      },
    );
  }

  void getTextBottomSheet() async {
    final ControllerChat c = Get.find();
    final SignalRMessageController messageController = Get.find();

    Get.back();
    await c.getTestList();
    Get.bottomSheet(
      Wrap(
        children: [
          /*  Container(
            color: UIColor.white,
            width: Get.width,
            alignment: Alignment.centerRight,
            child: IconButton(
              iconSize: 36,
              onPressed: () => Get.back(),
              icon: Icon(
                Icons.cancel,
                color: UIColor.redOrange,
              ),s
            ),
          ), */
          Container(
            color: UIColor.white,
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: c.testList.length,
                  controller: c.scrollController,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: TextBasic(
                                text: c.testList[index].name!,
                                fontSize: 20,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                return Utilities.showDefaultDialogConfirmCancel(
                                    title: UIText.textSure,
                                    content: c.testList[index].name! + UIText.textSendTest,
                                    onConfirm: () {
                                      messageController.sendTest(c.testList[index].id!, c.testList[index].name!);
                                      Get.back();
                                      Get.back();
                                    },
                                    onCancel: () => Get.back());
                              },
                              child: SvgPicture.asset(UIPath.sendMessageActive, width: 36, height: 36),
                            )
                          ],
                        ),
                        const SizedBox(height: 16),
                        Divider(color: UIColor.tuna.withOpacity(.38), height: 1),
                      ],
                    );
                  }),
            ),
          ),
        ],
      ),
      isScrollControlled: true,
    );
  }
}
