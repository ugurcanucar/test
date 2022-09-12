class PastAppointmentsModel {
  PastAppointmentsModel({
    this.firstName,
    this.lastName,
    this.nickName,
    this.date,
    this.startTime,
    this.endTime,
  });

  String? firstName;
  String? lastName;
  String? nickName;
  DateTime? date;
  String? startTime;
  String? endTime;

  factory PastAppointmentsModel.fromJson(Map<String, dynamic> json) =>
      PastAppointmentsModel(
        firstName: json["firstName"],
        lastName: json["lastName"],
        nickName: json["nickName"],
        date: DateTime.parse(json["date"]),
        startTime: json["startTime"],
        endTime: json["endTime"],
      );
}
