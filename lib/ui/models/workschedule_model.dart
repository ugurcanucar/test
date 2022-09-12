import 'package:terapizone/ui/models/workschedule_day_plan_model.dart';

class WorkscheduleModel {
  WorkscheduleModel({
    this.workscheduleId,
    this.therapistId,
    this.workscheduleDayplan,
  });

  String? workscheduleId;
  String? therapistId;
  WorkscheduleDayplanModel? workscheduleDayplan;

  factory WorkscheduleModel.fromJson(Map<String, dynamic> json) =>
      WorkscheduleModel(
        workscheduleId: json["workscheduleId"],
        therapistId: json["therapistId"],
        workscheduleDayplan:
            WorkscheduleDayplanModel.fromJson(json["workscheduleDayplan"]),
      );
}
