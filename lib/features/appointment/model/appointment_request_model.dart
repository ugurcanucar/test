class AppointmentRequestModel {
  String? date;
  String? startTime;
  String? endTime;

  AppointmentRequestModel({this.date, this.startTime, this.endTime});

  AppointmentRequestModel.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    startTime = json['startTime'];
    endTime = json['endTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['startTime'] = startTime;
    data['endTime'] = endTime;
    return data;
  }
}
