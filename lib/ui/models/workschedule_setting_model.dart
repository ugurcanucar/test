class WorkscheduleSettingModel {
  WorkscheduleSettingModel({
    this.id,
    this.isOfficialDayWorking,
    this.maxAppointmentCount,
    this.earliestAppointmentHour,
  });

  String? id;
  bool? isOfficialDayWorking;
  int? maxAppointmentCount;
  int? earliestAppointmentHour;

  factory WorkscheduleSettingModel.fromJson(Map<String, dynamic> json) =>
      WorkscheduleSettingModel(
        id: json["id"],
        isOfficialDayWorking: json["isOfficialDayWorking"],
        maxAppointmentCount: json["maxAppointmentCount"],
        earliestAppointmentHour: json["earliestAppointmentHour"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "isOfficialDayWorking": isOfficialDayWorking,
        "maxAppointmentCount": maxAppointmentCount,
        "earliestAppointmentHour": earliestAppointmentHour,
      };
}
