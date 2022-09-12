import 'package:terapizone/core/services/service_json_convert.dart';

class ResponseData<T> {
  bool success;
  String? message;
  dynamic data;

  ResponseData({required this.success, this.message, this.data});

  factory ResponseData.fromJson(Map<String, dynamic> json) {
    return ResponseData(
      success: json['success'],
      message: json['message'] ?? '',
      data: json['data'] !=null ? JsonConvertService.getModel<T>(json['data']) :null,
    );
  }
}
