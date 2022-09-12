class PostWorkscheduleSettingModel {
    PostWorkscheduleSettingModel({
        required this.isOfficialDayWorking,
        required this.maxAppointmentCount,
        required this.earliestAppointmentHour,
    });

    bool isOfficialDayWorking;
    int maxAppointmentCount;
    int earliestAppointmentHour;

    factory PostWorkscheduleSettingModel.fromJson(Map<String, dynamic> json) => PostWorkscheduleSettingModel(
        isOfficialDayWorking: json["isOfficialDayWorking"],
        maxAppointmentCount: json["maxAppointmentCount"],
        earliestAppointmentHour: json["earliestAppointmentHour"],
    );

    Map<String, dynamic> toJson() => {
        "isOfficialDayWorking": isOfficialDayWorking,
        "maxAppointmentCount": maxAppointmentCount,
        "earliestAppointmentHour": earliestAppointmentHour,
    };
}
