// ignore_for_file: file_names

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:terapizone/features/api_service.dart';
import 'package:terapizone/features/general_service/IGeneralService.dart';
import 'package:terapizone/ui/models/client_appointment_settings_request_model.dart';
import 'package:terapizone/ui/models/client_appointment_settings_response_model.dart';

class GeneralService extends IGeneralService {
  final ApiService repository = ApiService();

  @override
  Future<ClientAppointmentSetting?> getUserAppointmentSetting(String userId) async {
    final Response? response = await repository.get(getUserAppointmentSettingPath + userId);

    if (response?.statusCode == 200) {
      final model = ClientAppointmentSettingResponseModel.fromJson(response!.data);
      return model.data;
    }
    return null;
  }

  @override
  Future<ClientAppointmentSetting?> updateUserAppointmentSetting(ClientAppointmentSettingRequestModel model) async {
    final Response? response = await repository.put(updateUserAppointmentSettingPath, model);
    if (response?.statusCode == 200) {
      final model = ClientAppointmentSettingResponseModel.fromJson(response!.data);
      return model.data;
    }
    return null;
  }

  // @override
  // Future<TherapistModel?> getTherapistList() async {
  //   final Response? response = await repository.get(getAllTherapistPath);
  //   if (response?.statusCode == 200) {
  //     return TherapistModel.fromJson(response!.data);
  //   }
  //   return null;
  // }

}
