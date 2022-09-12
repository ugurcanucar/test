import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:signalr_core/signalr_core.dart';
import 'package:terapizone/core/utils/general_data.dart';
import 'package:terapizone/features/api_service.dart' as API;
import 'package:terapizone/features/messages/model/chat_details_response_model.dart';
import 'package:terapizone/features/messages/services/MessageService.dart';
import 'package:terapizone/ui/models/send_message_model.dart';

import '../../core/enums/enum.dart';
import '../../core/services/endpoint.dart';
import '../../core/services/service_api.dart';
import '../../features/messages/model/chat_list_model.dart';
import '../models/response_data_model.dart';

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

class SignalRMessageController extends GetxController {
  final MessageService _messageService = MessageService();

  RxnString messageGroupId = RxnString();
  Rxn<List<ChatDetailsModel>> messageList = Rxn<List<ChatDetailsModel>>();
  Rxn<HubConnection> connection = Rxn<HubConnection>();
  var allMessages = Rx<List<ChatListModel>>([]);

  @override
  void onInit() {
    super.onInit();

    initSignalR();
  }

  Future<void> initSignalR() async {
    HubConnection connectBuilder = HubConnectionBuilder()
        .withUrl(
          "https://testapi.terapizone.com/chatHub",
          HttpConnectionOptions(
              logging: (level, message) => print(message),
              skipNegotiation: true,
              client: _HttpClient(defaultHeaders: {'Authorization': "Bearer ${GeneralData.getAccessToken()}"}),
              transport: HttpTransportType.webSockets),
        )
        .build();
    connection.value = connectBuilder;
    connection.value!.onclose((exception) {});
    connection.value!.on("newMessageInChatList", (arguments) {
      ChatListModel model =
          allMessages.value.firstWhere((element) => element.messageGroupId == arguments![0]["messageGroupId"]);
      int index = allMessages.value.indexOf(model);

      log(arguments.toString());
      model.text = arguments![0]["text"];
      model.sendDate = arguments[0]["sendDate"];

      allMessages.value[index] = model;
      allMessages.refresh();
    });
    connection.value!.on("newMessage", (arguments) {
      ChatDetailsModel msgModel = ChatDetailsModel.fromJson(arguments![0]["data"]);
      messageList.value!.insert(0, msgModel);
      messageList.refresh();
    });
    await connection.value!.start()!.then((value) => print("astas"));
  }

  void getChatList() async {
    final response = await API.ApiService().get("/Message/ChatList");
    if (response?.statusCode == 200) {
      final model = ChatListResponseModel.fromJson(response!.data);

      allMessages.value = model.data ?? [];
    }
  }

  void startConnection() async {
    if (connection.value!.state != HubConnectionState.connected) {
      await connection.value!.start()!;
    }
  }

  void joinRoom(String groupId) async {
    // if (HubConnectionState.connected != connection.value!.state) {
    //   startConnection();
    // }
    print(groupId);
    messageGroupId.value = groupId;

    await connection.value!.invoke("JoinToRoom", args: [groupId]).then((value) => print("Giriş Yapıldı"));
  }

  void sendMessage(String message) async {
    SendMessageModel postitem = SendMessageModel(messageGroupId: messageGroupId.value, text: message, file: null);

    await connection.value!.invoke("SendToRoom", args: [postitem]).then((value) => print("Message Sent"));
  }

  void sendTest(int testId, String name) async {
    SendMessageModel postitem = SendMessageModel(
      messageGroupId: messageGroupId.value,
      text: "",
      file: FileClassModel(file: null, fileExtension: null, testId: testId, type: 4),
    );
    log(postitem.toJson().toString());
    await connection.value!.invoke("SendToRoom", args: [postitem]).then((value) => print("Message Sent"));
  }

  void sendImage(XFile? image) async {
    final String bytes = base64Encode(File(image!.path).readAsBytesSync());
    final String extension = image.path.split(".").last;
    SendMessageModel postitem = SendMessageModel(
        messageGroupId: messageGroupId.value,
        text: "",
        file: FileClassModel(
          type: 1,
          file: bytes,
          fileExtension: ".$extension",
        ));
    await connection.value!.invoke("SendToRoom", args: [postitem]).then((value) => print("Image Sent"));
  }

  void sendAudio(String base64Sound, String extension) async {
    final SendMessageModel postitem = SendMessageModel(
      messageGroupId: messageGroupId.value,
      text: "",
      file: FileClassModel(
        type: 2,
        file: base64Sound,
        fileExtension: ".$extension",
      ),
    );
    await connection.value!.invoke("SendToRoom", args: [postitem]).then((value) => print("Audio Sent"));
  }

  void getMessageDetails() async {
    if (messageGroupId.value != null) {
      log(messageGroupId.value!);
      final List<ChatDetailsModel>? response = await _messageService.getChatDetails(messageGroupId.value!);

      messageList.value = response;
    }
  }
}
