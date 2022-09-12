import 'package:terapizone/core/enums/enum.dart';

class DayAvailabilityListForTherapistModel {
  DayAvailabilityListForTherapistModel({
    this.availabilityStatus,
    this.appointment,
    this.date,
    this.startTime,
    this.endTime,
  });

  AvailabilityStatus? availabilityStatus;
  AppointmentModel? appointment;
  String? date;
  String? startTime;
  String? endTime;

  factory DayAvailabilityListForTherapistModel.fromJson(
          Map<String, dynamic> json) =>
      DayAvailabilityListForTherapistModel(
        availabilityStatus: json["availabilityStatus"] == 1
            ? AvailabilityStatus.available
            : json["availabilityStatus"] == 2
                ? AvailabilityStatus.notAvailable
                : AvailabilityStatus.appointment,
        appointment: json["appointment"] == null
            ? null
            : AppointmentModel.fromJson(json["appointment"]),
        date: json["date"],
        startTime: json["startTime"],
        endTime: json["endTime"],
      );
}

class AppointmentModel {
  AppointmentModel({
    this.id,
    this.clientFirstName,
    this.clientLastName,
    this.clientNickName,
    this.therapistFirstName,
    this.therapistLastName,
    this.therapistNickName,
    this.date,
    this.startTime,
    this.endTime,
  });

  String? id;
  String? clientFirstName;
  String? clientLastName;
  String? clientNickName;
  String? therapistFirstName;
  String? therapistLastName;
  String? therapistNickName;
  DateTime? date;
  String? startTime;
  String? endTime;

  factory AppointmentModel.fromJson(Map<String, dynamic> json) => AppointmentModel(
        id: json["id"],
        clientFirstName: json["clientFirstName"],
        clientLastName: json["clientLastName"],
        clientNickName: json["clientNickName"],
        therapistFirstName: json["therapistFirstName"],
        therapistLastName: json["therapistLastName"],
        therapistNickName: json["therapistNickName"],
        date: DateTime.parse(json["date"]),
        startTime: json["startTime"],
        endTime: json["endTime"],
      );
}
