class RoutineBreakListModel {
  RoutineBreakListModel({
    this.id,
    this.name,
    this.dayNumbers,
    this.startTime,
    this.endTime,
  });

  String? id;
  String? name;
  List<int>? dayNumbers;
  String? startTime;
  String? endTime;

  factory RoutineBreakListModel.fromJson(Map<String, dynamic> json) =>
      RoutineBreakListModel(
        id: json["id"],
        name: json["name"] ?? '',
        dayNumbers: json["dayNumbers"] != null
            ? List<int>.from(json["dayNumbers"].map((x) => x))
            : [],
        startTime: json["startTime"] ?? '',
        endTime: json["endTime"] ?? '',
      );
}
