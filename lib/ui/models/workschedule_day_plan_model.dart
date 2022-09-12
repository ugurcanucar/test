class WorkscheduleDayplanModel {
  WorkscheduleDayplanModel({
    this.dayNumbers,
    this.startTime,
    this.endTime,
  });

  List<int>? dayNumbers;
  String? startTime;
  String? endTime;

  factory WorkscheduleDayplanModel.fromJson(Map<String, dynamic> json) =>
      WorkscheduleDayplanModel(
        dayNumbers: json["dayNumbers"] != null
            ? List<int>.from(json["dayNumbers"].map((x) => x))
            : [],
        startTime: json["startTime"] ?? '',
        endTime: json["endTime"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "dayNumbers": List<dynamic>.from(dayNumbers!.map((x) => x)),
        "startTime": startTime,
        "endTime": endTime,
      };
}
