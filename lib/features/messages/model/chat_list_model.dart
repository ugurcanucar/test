class ChatListResponseModel {
  List<ChatListModel>? data;
  bool? success;
  String? message;

  ChatListResponseModel({this.data, this.success, this.message});

  ChatListResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <ChatListModel>[];
      json['data'].forEach((v) {
        data!.add(ChatListModel.fromJson(v));
      });
    }
    success = json['success'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['success'] = success;
    data['message'] = message;
    return data;
  }
}

class ChatListModel {
  String? title;
  String? text;
  String? messageGroupId;
  String? senderUserId;
  String? receiverId;
  int? unreadMessageCount;
  String? sendDate;
  String? therapistImageUrl;

  ChatListModel(
      {this.title,
      this.text,
      this.messageGroupId,
      this.senderUserId,
      this.receiverId,
      this.unreadMessageCount,
      this.sendDate,
      this.therapistImageUrl});

  ChatListModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    text = json['text'];
    messageGroupId = json['messageGroupId'];
    senderUserId = json['senderUserId'];
    receiverId = json['receiverId'];
    unreadMessageCount = json['unreadMessageCount'];
    sendDate = json['sendDate'];
    therapistImageUrl = json['therapistImageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['text'] = text;
    data['messageGroupId'] = messageGroupId;
    data['senderUserId'] = senderUserId;
    data['receiverId'] = receiverId;
    data['unreadMessageCount'] = unreadMessageCount;
    data['sendDate'] = sendDate;
    data['therapistImageUrl'] = therapistImageUrl;
    return data;
  }
}
