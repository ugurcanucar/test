class AppointmentCalenderResponseModel {
  List<AppointmentCalender>? data;
  bool? success;
  String? message;

  AppointmentCalenderResponseModel({this.data, this.success, this.message});

  AppointmentCalenderResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <AppointmentCalender>[];
      json['data'].forEach((v) {
        data!.add(AppointmentCalender.fromJson(v));
      });
    }
    success = json['success'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['success'] = success;
    data['message'] = message;
    return data;
  }
}

class AppointmentCalender {
  int? availabilityStatus;
  String? date;
  String? startTime;
  String? endTime;

  AppointmentCalender({this.availabilityStatus, this.date, this.startTime, this.endTime});

  AppointmentCalender.fromJson(Map<String, dynamic> json) {
    availabilityStatus = json['availabilityStatus'];
    date = json['date'];
    startTime = json['startTime'];
    endTime = json['endTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['availabilityStatus'] = availabilityStatus;
    data['date'] = date;
    data['startTime'] = startTime;
    data['endTime'] = endTime;
    return data;
  }
}
