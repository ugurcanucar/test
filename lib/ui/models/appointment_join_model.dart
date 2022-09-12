class AppointmentJoinModel {
  AppointmentJoinModel({
    this.channel,
    this.uid,
    this.token,
  });

  String? channel;
  int? uid;
  String? token;

  factory AppointmentJoinModel.fromJson(Map<String, dynamic> json) =>
      AppointmentJoinModel(
        channel: json["channel"] ?? '',
        uid: json["uid"] ?? 0,
        token: json["token"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "channel": channel,
        "uid": uid,
        "token": token,
      };
}
