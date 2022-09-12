class PostAppointmentModel {
  PostAppointmentModel({
    this.date,
    this.startTime,
    this.endTime,
  });

  String? date;
  String? startTime;
  String? endTime;

  factory PostAppointmentModel.fromJson(Map<String, dynamic> json) =>
      PostAppointmentModel(
        date: json["date"],
        startTime: json["startTime"],
        endTime: json["endTime"],
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "startTime": startTime,
        "endTime": endTime,
      };
}
