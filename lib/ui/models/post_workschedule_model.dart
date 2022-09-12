import 'package:terapizone/ui/models/workschedule_day_plan_model.dart';

class PostWorkscheduleModel {
  PostWorkscheduleModel({
    required this.workscheduleDayplan,
  });

  WorkscheduleDayplanModel workscheduleDayplan;

  factory PostWorkscheduleModel.fromJson(Map<String, dynamic> json) =>
      PostWorkscheduleModel(
        workscheduleDayplan:
            WorkscheduleDayplanModel.fromJson(json["workscheduleDayplan"]),
      );

  Map<String, dynamic> toJson() => {
        "workscheduleDayplan": workscheduleDayplan.toJson(),
      };
}
