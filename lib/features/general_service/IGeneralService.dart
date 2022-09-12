// ignore_for_file: file_names

import 'package:terapizone/ui/models/client_appointment_settings_request_model.dart';
import 'package:terapizone/ui/models/client_appointment_settings_response_model.dart';

abstract class IGeneralService {
  final String getUserAppointmentSettingPath =
      IMessageServicePath.userAppointment.rawValue;
  final String updateUserAppointmentSettingPath =
      IMessageServicePath.updateUserAppointment.rawValue;

  Future<ClientAppointmentSetting?> getUserAppointmentSetting(String userId);
  Future<ClientAppointmentSetting?> updateUserAppointmentSetting(
      ClientAppointmentSettingRequestModel model);
}

enum IMessageServicePath { userAppointment, updateUserAppointment }

extension IMessageServiceExtension on IMessageServicePath {
  String get rawValue {
    switch (this) {
      case IMessageServicePath.userAppointment:
        return '/Appointment/ClientAppointmentSetting?clientUserId=';
      case IMessageServicePath.updateUserAppointment:
        return '/Appointment/ClientAppointmentSetting';
    }
  }
}
