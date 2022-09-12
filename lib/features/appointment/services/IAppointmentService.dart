// ignore_for_file: file_names

import 'package:terapizone/features/appointment/model/active_appointments_response_model.dart';
import 'package:terapizone/features/appointment/model/appointment_calender_response_model.dart';
import 'package:terapizone/features/appointment/model/appointment_request_model.dart';
import 'package:terapizone/features/appointment/model/appointment_response_model.dart';
import 'package:terapizone/features/appointment/model/cancel-appointment/cancel_appointment_response_model.dart';
import 'package:terapizone/features/appointment/model/my_appointment_settings_response_model.dart';
import 'package:terapizone/features/appointment/model/past_appointments_response_model.dart';
import 'package:terapizone/features/appointment/model/session_join_request_model.dart';
import 'package:terapizone/features/appointment/model/video_call_error_log_request_model.dart';

abstract class IAppointmentService {
  final String errorLogPath = IAppointmentServicePath.errorLog.rawValue;

  Future<void> videoErrorLog(VideoCallErrorLogRequestModel model);
}

enum IAppointmentServicePath {
  baseUrl,

  appointmentBaseUrl,

  errorLog
}

extension IAppointmentServiceExtension on IAppointmentServicePath {
  String get rawValue {
    switch (this) {
      case IAppointmentServicePath.baseUrl:
        return '/AppointmentCalendar';

      case IAppointmentServicePath.appointmentBaseUrl:
        return '/Appointment';

      case IAppointmentServicePath.errorLog:
        return "${IAppointmentServicePath.appointmentBaseUrl.rawValue}/VideoCallErrorLog";
    }
  }
}
