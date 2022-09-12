class PostChangeTimeStatusModel {
  PostChangeTimeStatusModel({
    this.status,
    this.date,
    this.startTime,
    this.endTime,
  });

  bool? status;
  String? date;
  String? startTime;
  String? endTime;

  factory PostChangeTimeStatusModel.fromJson(Map<String, dynamic> json) =>
      PostChangeTimeStatusModel(
        status: json["status"],
        date: json["date"],
        startTime: json["startTime"],
        endTime: json["endTime"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "date": date,
        "startTime": startTime,
        "endTime": endTime,
      };
}
