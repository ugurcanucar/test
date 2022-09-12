import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:signalr_core/signalr_core.dart';
import 'package:terapizone/core/enums/enum.dart';
import 'package:terapizone/core/services/endpoint.dart';
import 'package:terapizone/core/services/service_api.dart';
import 'package:terapizone/core/utils/general_data.dart';
import 'package:terapizone/core/utils/utilities.dart';
import 'package:terapizone/ui/controllers/controller_base.dart';
import 'package:record/record.dart';
import 'package:just_audio/just_audio.dart' as ap;
import 'package:http/http.dart' as http;
import 'package:terapizone/ui/controllers/message_signal_controller.dart';

import 'package:terapizone/ui/models/chat_detail_model.dart';
import 'package:terapizone/ui/models/response_data_model.dart';
import 'package:terapizone/ui/models/send_message_model.dart';
import 'package:terapizone/ui/models/test_list_model.dart';

class _HttpClient extends http.BaseClient {
  final _httpClient = http.Client();
  final Map<String, String> defaultHeaders;

  _HttpClient({required this.defaultHeaders});

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers.addAll(defaultHeaders);
    return _httpClient.send(request);
  }
}

class ControllerChat extends BaseController {
  String? messageGroupId;
  ControllerChat({this.messageGroupId});

  @override
  void onInit() async {
    super.onInit();
    init();
  }

  Future<void> init() async {
    /* send('Testi çözmek için tıklayınız', MessagePosition.L,
        MessageFileTypes.test); */

    await getDetail();
    setBusy(false);
    // await 5.delay();

    //bu kapalıydı
    //setRepeat();
  }

  void setRepeat() async {
    // while (repeat) {
    //   await 5.delay();
    //   await getDetail();
    // }
  }

  //controllers
  final TextEditingController _msgController = TextEditingController();
  TextEditingController get msgController => _msgController;

  //states
  bool repeat = true;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController _scrollController = ScrollController();
  final RxBool _isSendActive = false.obs;
  final RxList<ChatDetailModel> _chatList = <ChatDetailModel>[].obs;
  final RxBool _isUplaodingFile = false.obs;

  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;
  ScrollController get scrollController => _scrollController;
  bool get isSendActive => _isSendActive.value;
  List<ChatDetailModel> get chatList => _chatList;
  bool get isUplaodingFile => _isUplaodingFile.value;

  //get list of consultants (therapists)
  Future<void> getDetail() async {
    if (messageGroupId != null && messageGroupId!.isNotEmpty) {
      ResponseData<List<ChatDetailModel>> response =
          await ApiService.apiRequest(Get.context!, ApiMethod.get,
              endpoint: Endpoint.chatDetails(messageGroupId: messageGroupId!));
      if (response.success && response.data != null) {
        if (response.data.isNotEmpty) {
          _chatList.value = response.data;
        }
      } else {
        Utilities.showToast(response.message!);
      }
    }
  }

  setIsSendActive() {
    if (_msgController.text.isEmpty) {
      _isSendActive.value = false;
    } else if (_msgController.text.isNotEmpty) {
      _isSendActive.value = true;
    }
  }

  void getNotificationMsg(ChatDetailModel m) {
    _chatList.insert(0, m);
    update();
  }

  HubConnection connection = HubConnectionBuilder()
      .withUrl(
        "https://testapi.terapizone.com/chatHub",
        HttpConnectionOptions(
            logging: (level, message) => print(message),
            skipNegotiation: true,
            client: _HttpClient(defaultHeaders: {
              'Authorization': "Bearer ${GeneralData.getAccessToken()}"
            }),
            transport: HttpTransportType.webSockets),
      )
      .build();

//send Message
  Future<void> send(String messageContent, MessagePosition messagePosition,
      MessageFileTypes fileType,
      {XFile? xfile, int? testId}) async {
    _msgController.clear();
    // find file extension
    String? fileExtension;
    if (fileType == MessageFileTypes.gorsel && xfile != null) {
      fileExtension = xfile.path.split('.').last;
    } else if (fileType == MessageFileTypes.seskaydi) {
      fileExtension = _recordedFile.path.split('.').last;
    }
    //convert file to base64 (from camera, gallery, audio)
    final bytes = xfile != null ? File(xfile.path).readAsBytesSync() : null;
    String? base64Image = bytes != null ? base64Encode(bytes) : null;

    final audioBytes = _recordedFile.path.isEmpty
        ? null
        : await File(_recordedFile.path).readAsBytes();
    String? base64Audio = audioBytes != null ? base64Encode(audioBytes) : null;
    SendMessageModel postitem = SendMessageModel(
      messageGroupId: messageGroupId,
      text: messageContent,
      file: fileType == MessageFileTypes.text
          ? null
          : FileClassModel(
              type: fileType == MessageFileTypes.gorsel
                  ? 1
                  : fileType == MessageFileTypes.seskaydi
                      ? 2
                      : fileType == MessageFileTypes.test
                          ? 4
                          : null,
              testId: testId ?? 0,
              file: fileType == MessageFileTypes.gorsel
                  ? base64Image
                  : fileType == MessageFileTypes.seskaydi
                      ? base64Audio
                      : null,
              fileExtension: fileExtension != null ? '.' + fileExtension : null,
            ),
    );
    if (fileType == MessageFileTypes.gorsel ||
        fileType == MessageFileTypes.seskaydi ||
        fileType == MessageFileTypes.test) {
      // _isUplaodingFile.value = true;
    }
    await connection
        .invoke("SendToRoom", args: [postitem]).then((value) => print("a"));
    // ResponseData<String> response = await ApiService.apiRequest(
    //     Get.context!, ApiMethod.post,
    //     endpoint: Endpoint.sendMessage, body: postitem.toJson());

    // if (fileType == MessageFileTypes.gorsel ||
    //     fileType == MessageFileTypes.seskaydi ||
    //     fileType == MessageFileTypes.test) {
    //   _isUplaodingFile.value = false;
    // }
    // if (response.success) {
    //   String url = response.message ?? '';
    //   _chatList.insert(
    //       0,
    //       ChatDetailModel(
    //           text: messageContent,
    //           position: messagePosition,
    //           nickname: '',
    //           type: fileType,
    //           testId: testId ?? 0,
    //           fileUrl: url,
    //           created: DateTime.now().toIso8601String(),
    //           audioPlayer: fileType == MessageFileTypes.seskaydi
    //               ? ap.AudioPlayer()
    //               : null));
    // } else {
    //   Utilities.showToast(response.message ?? '');
    // }
  }

/* send camera photo */

  sendPhoto(XFile xfile) async {
    send('', MessagePosition.R, MessageFileTypes.gorsel, xfile: xfile);
    Get.back();
  }

  /*sound record */
  final RxBool _isRecording = false.obs;
  final RxBool _isPaused = false.obs;
  RxInt _recordDuration = 0.obs;
  Timer? _timer;
  Timer? _ampTimer;
  final _audioRecorder = Record();
  Amplitude? _amplitude;
  bool showPlayer = false;
  ap.AudioSource? audioSource;
  File _recordedFile = File('');

  bool get isRecording => _isRecording.value;
  bool get isPaused => _isPaused.value;
  int get recordDuration => _recordDuration.value;
  Timer? get timer => _timer;
  Timer? get ampTimer => _ampTimer;
  Record get audioRecorder => _audioRecorder;
  Amplitude? get amplitude => _amplitude;

  Future<void> start() async {
    try {
      if (await _audioRecorder.hasPermission()) {
        await _audioRecorder.start();

        bool isRecording = await _audioRecorder.isRecording();
        _isRecording.value = isRecording;
        _recordDuration.value = 0;

        _startTimer();
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> stop() async {
    final SignalRMessageController messageController = Get.find();
    _timer?.cancel();
    _ampTimer?.cancel();
    final path = await _audioRecorder.stop();
    audioSource = ap.AudioSource.uri(Uri.parse(path!));
    showPlayer = true;
    _isRecording.value = false;
    _recordedFile = File.fromUri(Uri.parse(path));
    final bytes = await File(_recordedFile.path).readAsBytes();
    String aud = base64Encode(bytes);
    String extension = _recordedFile.path.split('.').last;
    messageController.sendAudio(aud, extension);

    //initAudio();
  }

  Future<void> pause() async {
    _timer?.cancel();
    _ampTimer?.cancel();
    await _audioRecorder.pause();

    _isPaused.value = true;
  }

  Future<void> resume() async {
    _startTimer();
    await _audioRecorder.resume();
    _isPaused.value = false;
  }

  void _startTimer() {
    _timer?.cancel();
    _ampTimer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      _recordDuration++;
    });

    _ampTimer =
        Timer.periodic(const Duration(milliseconds: 200), (Timer t) async {
      _amplitude = await _audioRecorder.getAmplitude();
    });
  }

  void disposeRecord() {
    _timer?.cancel();
    _ampTimer?.cancel();
    _audioRecorder.dispose();
    super.dispose();
  }

  /* play sound */
  double controlSize = 36;

  //final Rx<ap.AudioPlayer> _audioPlayer = ap.AudioPlayer().obs;

  // ignore: cancel_subscriptions
  late StreamSubscription<ap.PlayerState> _playerStateChangedSubscription;
  // ignore: cancel_subscriptions
  late StreamSubscription<Duration?> _durationChangedSubscription;
  // ignore: cancel_subscriptions
  late StreamSubscription<Duration> _positionChangedSubscription;
  ap.AudioPlayer audioPlayer() => _chatList[_selectedIndex].audioPlayer!;
  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  void initAudio() {
    _playerStateChangedSubscription = _chatList[_selectedIndex]
        .audioPlayer!
        .playerStateStream
        .listen((state) async {
      if (state.processingState == ap.ProcessingState.completed) {
        await stopSound();
      }
    });

    _positionChangedSubscription = _chatList[_selectedIndex]
        .audioPlayer!
        .positionStream
        .listen((position) => update());
    _durationChangedSubscription = _chatList[_selectedIndex]
        .audioPlayer!
        .durationStream
        .listen((duration) => update());

    log(_playerStateChangedSubscription.toString());
    log(_positionChangedSubscription.toString());
    log(_durationChangedSubscription.toString());
  }

  Future<void> playSound({required int index}) {
    _selectedIndex = index;
    String url = _chatList[_selectedIndex].fileUrl ?? '';

    _chatList[_selectedIndex].audioPlayer!.setUrl('${Endpoint.baseUrl}/' + url);
    initAudio();
    return _chatList[_selectedIndex].audioPlayer!.play();
  }

  Future<void> pauseSound() {
    return _chatList[_selectedIndex].audioPlayer!.pause();
  }

  Future<void> stopSound() async {
    await _chatList[_selectedIndex].audioPlayer!.stop();
    return _chatList[_selectedIndex]
        .audioPlayer!
        .seek(const Duration(milliseconds: 0));
  }

  @override
  void dispose() {
    _playerStateChangedSubscription.cancel();
    _positionChangedSubscription.cancel();
    _durationChangedSubscription.cancel();
    _chatList[_selectedIndex].audioPlayer!.dispose();
    super.dispose();
  }

  disposeOnWillPop() {
    if (_chatList[_selectedIndex].audioPlayer != null) {
      _chatList[_selectedIndex].audioPlayer!.dispose();
    }
  }

  /* Tests */
  //states
  final RxList<TestListModel> _testList = <TestListModel>[].obs;

  List<TestListModel> get testList => _testList;

  //get list of tests
  Future<void> getTestList() async {
    setBusy(true);
    ResponseData<List<TestListModel>> response = await ApiService.apiRequest(
        Get.context!, ApiMethod.get,
        endpoint: Endpoint.testsGetall);
    setBusy(false);
    if (response.success && response.data != null) {
      if (response.data.isNotEmpty) {
        _testList.value = response.data;
      }
    } else {
      Utilities.showToast(response.message!);
    }
  }

  Future<void> sendTest({int? testId, String? name}) async {
    Get.back();
    Get.back();

    await send('$name', MessagePosition.R, MessageFileTypes.test,
        testId: testId);
  }
}
