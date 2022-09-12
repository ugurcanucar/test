class ClientAppointmentSettingResponseModel {
  ClientAppointmentSetting? data;
  bool? success;
  String? message;

  ClientAppointmentSettingResponseModel(
      {this.data, this.success, this.message});

  ClientAppointmentSettingResponseModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null
        ? ClientAppointmentSetting.fromJson(json['data'])
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

class ClientAppointmentSetting {
  int? dayFrequency;
  String? packageEndDate;
  String? defaultPackageEndDate;

  ClientAppointmentSetting(
      {this.dayFrequency, this.packageEndDate, this.defaultPackageEndDate});

  ClientAppointmentSetting.fromJson(Map<String, dynamic> json) {
    dayFrequency = json['dayFrequency'];
    packageEndDate = json['packageEndDate'];
    defaultPackageEndDate = json['defaultPackageEndDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['dayFrequency'] = dayFrequency;
    data['packageEndDate'] = packageEndDate;
    data['defaultPackageEndDate'] = defaultPackageEndDate;
    return data;
  }
}
