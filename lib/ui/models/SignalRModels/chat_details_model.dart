class ChatDetailsResponseModel {
  int? pageNumber;
  int? pageSize;
  int? totalPages;
  int? totalRecords;
  List<ChatDetailsModel>? data;
  bool? success;
  String? message;

  ChatDetailsResponseModel(
      {this.pageNumber,
      this.pageSize,
      this.totalPages,
      this.totalRecords,
      this.data,
      this.success,
      this.message});

  ChatDetailsResponseModel.fromJson(Map<String, dynamic> json) {
    pageNumber = json['pageNumber'];
    pageSize = json['pageSize'];
    totalPages = json['totalPages'];
    totalRecords = json['totalRecords'];
    if (json['data'] != null) {
      data = <ChatDetailsModel>[];
      json['data'].forEach((v) {
        data!.add(ChatDetailsModel.fromJson(v));
      });
    }
    success = json['success'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pageNumber'] = pageNumber;
    data['pageSize'] = pageSize;
    data['totalPages'] = totalPages;
    data['totalRecords'] = totalRecords;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['success'] = success;
    data['message'] = message;
    return data;
  }
}

class ChatDetailsModel {
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
  Test? test;

  ChatDetailsModel(
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

  ChatDetailsModel.fromJson(Map<String, dynamic> json) {
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
    test = json['test'] != null ? Test.fromJson(json['test']) : null;
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
    if (test != null) {
      data['test'] = test!.toJson();
    }
    return data;
  }
}

class Test {
  int? completionRate;
  int? completionStatus;
  String? completionStatusText;
  String? clientTestSessionId;
  String? testName;
  int? questionCount;
  int? answeredQuestionCount;
  bool? clientTestSessionIsCompleted;

  Test(
      {this.completionRate,
      this.completionStatus,
      this.completionStatusText,
      this.clientTestSessionId,
      this.testName,
      this.questionCount,
      this.answeredQuestionCount,
      this.clientTestSessionIsCompleted});

  Test.fromJson(Map<String, dynamic> json) {
    completionRate = json['completionRate'];
    completionStatus = json['completionStatus'];
    completionStatusText = json['completionStatusText'];
    clientTestSessionId = json['clientTestSessionId'];
    testName = json['testName'];
    questionCount = json['questionCount'];
    answeredQuestionCount = json['answeredQuestionCount'];
    clientTestSessionIsCompleted = json['clientTestSessionIsCompleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['completionRate'] = completionRate;
    data['completionStatus'] = completionStatus;
    data['completionStatusText'] = completionStatusText;
    data['clientTestSessionId'] = clientTestSessionId;
    data['testName'] = testName;
    data['questionCount'] = questionCount;
    data['answeredQuestionCount'] = answeredQuestionCount;
    data['clientTestSessionIsCompleted'] = clientTestSessionIsCompleted;
    return data;
  }
}
