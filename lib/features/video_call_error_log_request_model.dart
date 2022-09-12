class VideoCallErrorLogRequestModel {
  String? errorCode;
  String? errorText;
  String? appointmentId;

  VideoCallErrorLogRequestModel(
      {this.errorCode, this.errorText, this.appointmentId});

  VideoCallErrorLogRequestModel.fromJson(Map<String, dynamic> json) {
    errorCode = json['errorCode'];
    errorText = json['errorText'];
    appointmentId = json['appointmentId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['errorCode'] = errorCode;
    data['errorText'] = errorText;
    data['appointmentId'] = appointmentId;
    return data;
  }
}
