// import 'dart:convert';
// import 'dart:developer';
// import 'dart:io';

// import 'package:flutter/material.dart'; 
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:image_picker/image_picker.dart';
// import 'package:signalr_core/signalr_core.dart';
// import 'package:terapizone/features/messages/model/chat_details_response_model.dart';
// import 'package:terapizone/features/messages/model/chat_list_model.dart';
// import 'package:terapizone/features/messages/services/MessageService.dart'; 
// import 'package:webviewx/webviewx.dart';

// class _HttpClient extends http.BaseClient {
//   final _httpClient = http.Client();
//   final Map<String, String> defaultHeaders;

//   _HttpClient({required this.defaultHeaders});

//   @override
//   Future<http.StreamedResponse> send(http.BaseRequest request) {
//     request.headers.addAll(defaultHeaders);
//     return _httpClient.send(request);
//   }
// }

// class MessageController extends GetxController {
//   final MessageService _messageService = MessageService();

//   RxBool isEditMode = RxBool(false);

//   var allMessages = Rx<List<ChatListModel>>([]);
//   var selectedMessages = Rx<List<ChatListModel>>([]);

//   RxBool isOpen = RxBool(false);

//   void openEditMode() => isEditMode.value = true;
//   void closeEditMode() {
//     isEditMode.value = false;
//     selectedMessages.value.clear();
//   }

//   void selectMessage(ChatListModel message) {
//     selectedMessages.value.add(message);
//     selectedMessages.refresh();
//   }

//   void removeMessage(ChatListModel message) {
//     selectedMessages.value.remove(message);
//     selectedMessages.refresh();
//   }

//   void selectAllMessages() {
//     selectedMessages.value = allMessages.value.toList();
//     selectedMessages.refresh();
//   }

//   void readMessage() {
//     if (selectedMessages.value.isEmpty) {
//       selectedMessages.value = allMessages.value.toList();
//     }
//     for (var item in selectedMessages.value) {
//       // item.isRead = true;
//     }
//     selectedMessages.refresh();
//   }

//   void deleteMessage() {
//     for (var item in selectedMessages.value) {
//       // allMessages.value.removeWhere((element) => element.id == item.id);
//     }

//     allMessages.refresh();
//     selectedMessages.refresh();
//   }

//   bool isSelectedMessage(ChatListModel message) => false;
//   // selectedMessages.value.any((element) => element.id == message.id);

//   void getAllMessages() async {
//     final ChatListResponseModel? response = await _messageService.getChatList();

//     if (response != null) {
//       allMessages.value = response.data!;
//       allMessages.refresh();
//       isOpen.value = true;
//     }
//   }

// //--------------------------- SignalR Hub ---------------- //

//   Rx<List<ChatDetailsModel>> messageList = Rx<List<ChatDetailsModel>>([]);
//   Rxn<HubConnection> connection = Rxn<HubConnection>();
//   RxnString roomGroupId = RxnString();
//   RxBool isHubConnected = RxBool(false);
//   RxBool messageLoading = RxBool(false);
//   RxString currentMessage = RxString("");
//   Rx<TextEditingController> msgController =
//       Rx<TextEditingController>(TextEditingController());
//   Rxn<User> userInfo = Rxn<User>();

//   Rxn<WebViewXController> webViewController = Rxn<WebViewXController>();

//   Future<void> initSignalR() async {
//     final String token = await getAccessToken();
//     HubConnection connectBuilder = HubConnectionBuilder()
//         .withUrl(
//           "https://testapi.terapizone.com/chatHub",
//           HttpConnectionOptions(
//               logging: (level, message) => print(message),
//               skipNegotiation: true,
//               client: _HttpClient(defaultHeaders: {'Authorization': token}),
//               transport: HttpTransportType.webSockets),
//         )
//         .build();
//     connection.value = connectBuilder;

//     connection.value!.on("newMessage", (arguments) {
//       ChatDetailsModel model = ChatDetailsModel.fromJson(arguments![0]["data"]);

//       inspect(model);

//       messageList.value.insert(0, model);
//       messageList.refresh();
//     });

//     connection.value!.on("newMessageInChatList", (arguments) {
//       print("listening");
//     });

//     await connection.value!
//         .start()!
//         .then((value) => isHubConnected.value = true);
//   }

//   void openConnection() {
//     initSignalR();
//   }

//   Future<void> closeConnection() async {
//     await connection.value!.stop();
//     isHubConnected.value = false;
//   }

//   Future<String> getAccessToken() async {
//     final token = await UserSecureStorage.getField("token");
//     return "Bearer $token";
//   }

//   void checkUserInfo() async {
//     final user = await UserSecureStorage.getField("user");
//     final userModel = User.fromJson(json.decode(user!));
//     userInfo.value = userModel;
//   }

//   void joinRoom(String groupId) async {
//     messageLoading.value = true;
//     final List<ChatDetailsModel>? resp =
//         await _messageService.getChatDetails(groupId);

//     roomGroupId.value = groupId;
//     messageLoading.value = false;

//     messageList.value = resp!;
//     await connection.value!.invoke("JoinToRoom",
//         args: [groupId]).then((value) => print("Giriş Yapıldı"));
//   }

//   void sendMessage() async {
//     SendMessageModel postitem = SendMessageModel(
//         messageGroupId: roomGroupId.value,
//         text: currentMessage.value,
//         file: null);
//     msgController.value.clear();
//     currentMessage.value = "";
//     await connection.value!.invoke("SendToRoom",
//         args: [postitem]).then((value) => print("Message Sent"));
//   }

//   void sendImage(XFile? image) async {
//     final String bytes = base64Encode(File(image!.path).readAsBytesSync());
//     final String extension = image.path.split(".").last;
//     SendMessageModel postitem = SendMessageModel(
//         messageGroupId: roomGroupId.value,
//         text: currentMessage.value,
//         file: FileClassModel(
//           type: 1,
//           file: bytes,
//           fileExtension: ".$extension",
//         ));
//     await connection.value!.invoke("SendToRoom",
//         args: [postitem]).then((value) => print("Image Sent"));
//   }

//   void sendAudio(String base64Sound, String extension) async {
//     // inspect(base64Sound);
//     // inspect(extension);
//     SendMessageModel postitem = SendMessageModel(
//         messageGroupId: roomGroupId.value,
//         text: currentMessage.value,
//         file: FileClassModel(
//           type: 2,
//           file: base64Sound,
//           fileExtension: ".$extension",
//         ));
//     msgController.value.clear();
//     currentMessage.value = "";
//     await connection.value!.invoke("SendToRoom",
//         args: [postitem]).then((value) => print("Message Sent"));
//   }

//   void onPageFinished() async {
//     try {
//       WebViewContent c = await webViewController.value!.getContent();
//       String result = c.source;
//       inspect(c);
//       inspect(result);
//       if (result.isNotEmpty && result.startsWith("http")) {
//         bool isSuccess = result.contains('/Payment/PayWith3D_Payment_Success');
//         bool isFailure = result.contains('/Payment/PayWith3D_Payment_Fail');

//         if (isSuccess) {
//           print("Success!!");
//           // Get.offAll(() => const ViewPaymentSuccess());
//           return;
//         } else if (isFailure) {
//           print("FALSE!!!");
//           // Get.back();
//           // return Utilities.showDefaultDialogConfirm(
//           //     title: UIText.textError,
//           //     content: UIText.textPaymentError,
//           //     onConfirm: () {
//           //       Get.back();
//           //     });
//         }
//       }
//     } catch (e) {
//       log(e.toString());
//     }
//   }
// }
