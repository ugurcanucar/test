class PastAppointmentsResponseModel {
  int? pageNumber;
  int? pageSize;
  int? totalPages;
  int? totalRecords;
  List<PastAppointments>? data;
  bool? success;
  String? message;

  PastAppointmentsResponseModel(
      {this.pageNumber,
      this.pageSize,
      this.totalPages,
      this.totalRecords,
      this.data,
      this.success,
      this.message});

  PastAppointmentsResponseModel.fromJson(Map<String, dynamic> json) {
    pageNumber = json['pageNumber'];
    pageSize = json['pageSize'];
    totalPages = json['totalPages'];
    totalRecords = json['totalRecords'];
    if (json['data'] != null) {
      data = <PastAppointments>[];
      json['data'].forEach((v) {
        data!.add(PastAppointments.fromJson(v));
      });
    }
    success = json['success'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pageNumber'] = pageNumber;
    data['pageSize'] = pageSize;
    data['totalPages'] = totalPages;
    data['totalRecords'] = totalRecords;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['success'] = success;
    data['message'] = message;
    return data;
  }
}

class PastAppointments {
  String? firstName;
  String? lastName;
  String? nickName;
  String? therapistFirstName;
  String? therapistLastName;
  String? therapistNickName;
  String? therapistTitle;
  String? therapistImageUrl;
  String? therapistVideoUrl;
  String? date;
  String? startTime;
  String? endTime;

  PastAppointments(
      {this.firstName,
      this.lastName,
      this.nickName,
      this.therapistFirstName,
      this.therapistLastName,
      this.therapistNickName,
      this.therapistTitle,
      this.therapistImageUrl,
      this.therapistVideoUrl,
      this.date,
      this.startTime,
      this.endTime});

  PastAppointments.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    nickName = json['nickName'];
    therapistFirstName = json['therapistFirstName'];
    therapistLastName = json['therapistLastName'];
    therapistNickName = json['therapistNickName'];
    therapistTitle = json['therapistTitle'];
    therapistImageUrl = json['therapistImageUrl'];
    therapistVideoUrl = json['therapistVideoUrl'];
    date = json['date'];
    startTime = json['startTime'];
    endTime = json['endTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['nickName'] = nickName;
    data['therapistFirstName'] = therapistFirstName;
    data['therapistLastName'] = therapistLastName;
    data['therapistNickName'] = therapistNickName;
    data['therapistTitle'] = therapistTitle;
    data['therapistImageUrl'] = therapistImageUrl;
    data['therapistVideoUrl'] = therapistVideoUrl;
    data['date'] = date;
    data['startTime'] = startTime;
    data['endTime'] = endTime;
    return data;
  }
}
