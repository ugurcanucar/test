class ActiveAppointmentsModel {
  ActiveAppointmentsModel({
    this.id,
    this.clientFirstName,
    this.clientLastName,
    this.clientNickName,
    this.therapistFirstName,
    this.therapistLastName,
    this.therapistNickName,
    this.date,
    this.startTime,
    this.endTime,
  });

  String? id;
  String? clientFirstName;
  String? clientLastName;
  String? clientNickName;
  String? therapistFirstName;
  String? therapistLastName;
  String? therapistNickName;
  DateTime? date;
  String? startTime;
  String? endTime;

  factory ActiveAppointmentsModel.fromJson(Map<String, dynamic> json) =>
      ActiveAppointmentsModel(
        id: json["id"],
        clientFirstName: json["clientFirstName"],
        clientLastName: json["clientLastName"],
        clientNickName: json["clientNickName"],
        therapistFirstName: json["therapistFirstName"],
        therapistLastName: json["therapistLastName"],
        therapistNickName: json["therapistNickName"],
        date: DateTime.parse(json["date"]),
        startTime: json["startTime"],
        endTime: json["endTime"],
      );
}
