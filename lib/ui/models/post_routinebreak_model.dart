class PostRoutineBreakModel {
  PostRoutineBreakModel({
    required this.routineBreakplan,
  });

  RoutineBreakDayplanModel routineBreakplan;

  factory PostRoutineBreakModel.fromJson(Map<String, dynamic> json) =>
      PostRoutineBreakModel(
        routineBreakplan:
            RoutineBreakDayplanModel.fromJson(json["routineBreakplan"]),
      );

  Map<String, dynamic> toJson() => {
        "routineBreakplan": routineBreakplan.toJson(),
      };
}

class RoutineBreakDayplanModel {
  RoutineBreakDayplanModel({
    required this.name,
    required this.dayNumbers,
    required this.startTime,
    required this.endTime,
  });
  String name;
  List<int> dayNumbers;
  String startTime;
  String endTime;

  factory RoutineBreakDayplanModel.fromJson(Map<String, dynamic> json) =>
      RoutineBreakDayplanModel(
        name: json['name'],
        dayNumbers: List<int>.from(json["dayNumbers"].map((x) => x)),
        startTime: json["startTime"],
        endTime: json["endTime"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "dayNumbers": List<dynamic>.from(dayNumbers.map((x) => x)),
        "startTime": startTime,
        "endTime": endTime,
      };
}
