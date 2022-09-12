import 'package:terapizone/core/enums/enum.dart';

class DayAvailabilityListForClientModel {
  DayAvailabilityListForClientModel({
    this.availabilityStatus,
    this.date,
    this.startTime,
    this.endTime,
    this.isSelected,
  });

  AvailabilityStatus? availabilityStatus;
  String? date;
  String? startTime;
  String? endTime;
  bool? isSelected;

  factory DayAvailabilityListForClientModel.fromJson(
          Map<String, dynamic> json) =>
      DayAvailabilityListForClientModel(
        availabilityStatus: json["availabilityStatus"] == 1 ? AvailabilityStatus.available : AvailabilityStatus.notAvailable,
        date: json["date"],
        startTime: json["startTime"],
        endTime: json["endTime"],
        isSelected: false,
      );

  Map<String, dynamic> toJson() => {
        "availabilityStatus": availabilityStatus,
        "date": date,
        "startTime": startTime,
        "endTime": endTime,
      };
}
