class SendMessageResponseModel {
  SendMessageResponse? data;
  bool? success;
  String? message;

  SendMessageResponseModel({this.data, this.success, this.message});

  SendMessageResponseModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null
        ? SendMessageResponse.fromJson(json['data'])
        : null;
    success = json['success'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['success'] = success;
    data['message'] = message;
    return data;
  }
}

class SendMessageResponse {
  String? id;
  String? text;
  String? position;
  String? nickname;
  int? type;
  String? fileUrl;
  String? created;
  String? senderUserId;
  String? title;
  String? imageUrl;
  String? messageGroupId;
  String? receiverId;
  String? userType;
  Null? test;

  SendMessageResponse(
      {this.id,
      this.text,
      this.position,
      this.nickname,
      this.type,
      this.fileUrl,
      this.created,
      this.senderUserId,
      this.title,
      this.imageUrl,
      this.messageGroupId,
      this.receiverId,
      this.userType,
      this.test});

  SendMessageResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    text = json['text'];
    position = json['position'];
    nickname = json['nickname'];
    type = json['type'];
    fileUrl = json['fileUrl'];
    created = json['created'];
    senderUserId = json['senderUserId'];
    title = json['title'];
    imageUrl = json['imageUrl'];
    messageGroupId = json['messageGroupId'];
    receiverId = json['receiverId'];
    userType = json['userType'];
    test = json['test'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['text'] = text;
    data['position'] = position;
    data['nickname'] = nickname;
    data['type'] = type;
    data['fileUrl'] = fileUrl;
    data['created'] = created;
    data['senderUserId'] = senderUserId;
    data['title'] = title;
    data['imageUrl'] = imageUrl;
    data['messageGroupId'] = messageGroupId;
    data['receiverId'] = receiverId;
    data['userType'] = userType;
    data['test'] = test;
    return data;
  }
}
