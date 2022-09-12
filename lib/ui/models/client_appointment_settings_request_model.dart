class ClientAppointmentSettingRequestModel {
  int? dayFrequency;
  String? packageEndDate;
  String? defaultPackageEndDate;
  String? clientUserId;

  ClientAppointmentSettingRequestModel(
      {this.dayFrequency, this.packageEndDate, this.clientUserId});

  ClientAppointmentSettingRequestModel.fromJson(Map<String, dynamic> json) {
    dayFrequency = json['dayFrequency'];
    packageEndDate = json['packageEndDate'];
    defaultPackageEndDate = json['defaultPackageEndDate'];
    clientUserId = json['clientUserId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['dayFrequency'] = dayFrequency;
    data['packageEndDate'] = packageEndDate;
    data['defaultPackageEndDate'] = defaultPackageEndDate;
    data['clientUserId'] = clientUserId;
    return data;
  }
}
