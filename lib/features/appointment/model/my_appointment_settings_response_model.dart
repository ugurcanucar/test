class MyAppointmentSettingsResponseModel {
  MyAppointmentSettings? data;
  bool? success;
  String? message;

  MyAppointmentSettingsResponseModel({this.data, this.success, this.message});

  MyAppointmentSettingsResponseModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null
        ? MyAppointmentSettings.fromJson(json['data'])
        : null;
    success = json['success'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['success'] = success;
    data['message'] = message;
    return data;
  }
}

class MyAppointmentSettings {
  int? dayFrequency;
  String? packageEndDate;

  MyAppointmentSettings({this.dayFrequency, this.packageEndDate});

  MyAppointmentSettings.fromJson(Map<String, dynamic> json) {
    dayFrequency = json['dayFrequency'];
    packageEndDate = json['packageEndDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['dayFrequency'] = dayFrequency;
    data['packageEndDate'] = packageEndDate;
    return data;
  }
}
