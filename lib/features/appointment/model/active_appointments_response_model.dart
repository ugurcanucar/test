class ActiveAppointmentsResponseModel {
  int? pageNumber;
  int? pageSize;
  int? totalPages;
  int? totalRecords;
  List<ActiveAppointments>? data;
  bool? success;
  String? message;

  ActiveAppointmentsResponseModel(
      {this.pageNumber,
      this.pageSize,
      this.totalPages,
      this.totalRecords,
      this.data,
      this.success,
      this.message});

  ActiveAppointmentsResponseModel.fromJson(Map<String, dynamic> json) {
    pageNumber = json['pageNumber'];
    pageSize = json['pageSize'];
    totalPages = json['totalPages'];
    totalRecords = json['totalRecords'];
    if (json['data'] != null) {
      data = <ActiveAppointments>[];
      json['data'].forEach((v) {
        data!.add(ActiveAppointments.fromJson(v));
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

class ActiveAppointments {
  String? id;
  String? clientFirstName;
  String? clientLastName;
  String? clientNickName;
  String? therapistFirstName;
  String? therapistLastName;
  String? therapistNickName;
  String? therapistTitle;
  String? therapistImageUrl;
  String? therapistVideoUrl;
  String? date;
  String? startTime;
  String? endTime;

  ActiveAppointments(
      {this.id,
      this.clientFirstName,
      this.clientLastName,
      this.clientNickName,
      this.therapistFirstName,
      this.therapistLastName,
      this.therapistNickName,
      this.therapistTitle,
      this.therapistImageUrl,
      this.therapistVideoUrl,
      this.date,
      this.startTime,
      this.endTime});

  ActiveAppointments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clientFirstName = json['clientFirstName'];
    clientLastName = json['clientLastName'];
    clientNickName = json['clientNickName'];
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
    data['id'] = id;
    data['clientFirstName'] = clientFirstName;
    data['clientLastName'] = clientLastName;
    data['clientNickName'] = clientNickName;
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
