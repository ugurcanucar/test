// ignore_for_file: file_names

import 'package:terapizone/features/api_service.dart';
import 'package:terapizone/features/appointment/model/video_call_error_log_request_model.dart';

import 'package:terapizone/features/appointment/services/IAppointmentService.dart';

class AppointmentService extends IAppointmentService {
  final ApiService repository = ApiService();

  @override
  Future<void> videoErrorLog(VideoCallErrorLogRequestModel model) async {
    await repository.post(errorLogPath, model);
  }
}
