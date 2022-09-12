class SessionJoinRequestModel {
  SessionJoinModel? data;
  bool? success;
  String? message;

  SessionJoinRequestModel({this.data, this.success, this.message});

  SessionJoinRequestModel.fromJson(Map<String, dynamic> json) {
    data =
        json['data'] != null ? SessionJoinModel.fromJson(json['data']) : null;
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

class SessionJoinModel {
  String? channel;
  int? uid;
  String? token;

  SessionJoinModel({this.channel, this.uid, this.token});

  SessionJoinModel.fromJson(Map<String, dynamic> json) {
    channel = json['channel'];
    uid = json['uid'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['channel'] = channel;
    data['uid'] = uid;
    data['token'] = token;
    return data;
  }
}
