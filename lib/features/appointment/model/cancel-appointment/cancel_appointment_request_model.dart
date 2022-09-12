class CancelAppointmentRequestModel {
  String? cancellationReason;

  CancelAppointmentRequestModel({this.cancellationReason});

  CancelAppointmentRequestModel.fromJson(Map<String, dynamic> json) {
    cancellationReason = json['cancellationReason'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cancellationReason'] = cancellationReason;
    return data;
  }
}
