import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:terapizone/core/enums/enum.dart';
import 'package:terapizone/core/services/endpoint.dart';
import 'package:terapizone/core/services/service_api.dart';
import 'package:terapizone/core/utils/utilities.dart';
import 'package:terapizone/features/api_service.dart' as api;
import 'package:terapizone/features/general_service/GeneralService.dart';
import 'package:terapizone/ui/controllers/controller_base.dart';
import 'package:terapizone/ui/models/client_appointment_settings_request_model.dart';
import 'package:terapizone/ui/models/client_appointment_settings_response_model.dart';
import 'package:terapizone/ui/models/client_test_score_response_model.dart';
import 'package:terapizone/ui/models/list_test_scrore_model.dart';
import 'package:terapizone/ui/models/response_data_model.dart';

class ControllerClientProfile extends BaseController {
  final String id;
  final GeneralService generalService = GeneralService();
  ControllerClientProfile(this.id);
  @override
  void onInit() async {
    log(id);
    super.onInit();
    init();
  }

  Future<void> init() async {
    await getTestResults();
    await getUserAppointmentSettings();
  }

  //controllers

  //states
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final RxList<ClientTestScoreResponse> list = RxList<ClientTestScoreResponse>();

  Rx<ClientAppointmentSettingRequestModel> clientAppointmentRequestModel = Rx<ClientAppointmentSettingRequestModel>(
      ClientAppointmentSettingRequestModel(clientUserId: "", dayFrequency: 0, packageEndDate: ""));

  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  RxBool isLoading = RxBool(false);
  //get list of consultants (therapists)
  Future<void> getTestResults() async {
    // ResponseData<ClientTestScoreResponseModel> response =
    //     await ApiService.apiRequest(Get.context!, ApiMethod.get, endpoint: Endpoint.getClientTestScore(clientId: id));
    log(Endpoint.getClientTestScore(clientId: id));
    var response = await api.ApiService().get(Endpoint.getClientTestScore(clientId: id));
    ClientTestScoreResponseModel model = ClientTestScoreResponseModel.fromJson(response!.data);

    setBusy(false);
    if (model.success! && model.data != null) {
      if (model.data!.isNotEmpty) {
        list.value = model.data ?? [];
      }
    } else {
      Utilities.showToast(model.message!);
    }
  }

  void increaseFrequency() async {
    isLoading.value = true;

    final frequency = clientAppointmentRequestModel.value.dayFrequency!;

    if (frequency < 15) {
      clientAppointmentRequestModel.value.dayFrequency = frequency + 1;
      await updateAppointmentSetting();
      clientAppointmentRequestModel.refresh();
    }
    isLoading.value = false;
  }

  Future<void> updateAppointmentSetting() async {
    await generalService.updateUserAppointmentSetting(clientAppointmentRequestModel.value);
  }

  void decreaseFrequency() async {
    final frequency = clientAppointmentRequestModel.value.dayFrequency!;
    isLoading.value = true;
    if (frequency != 0) {
      clientAppointmentRequestModel.value.dayFrequency = frequency - 1;
      await updateAppointmentSetting();
      clientAppointmentRequestModel.refresh();
    }
    isLoading.value = false;
  }

  Future<void> getUserAppointmentSettings() async {
    final resp = await generalService.getUserAppointmentSetting(id);
    if (resp != null) {
      log(resp.toJson().toString());
      clientAppointmentRequestModel.value.clientUserId = id;
      clientAppointmentRequestModel.value.dayFrequency = resp.dayFrequency;
      clientAppointmentRequestModel.value.packageEndDate = resp.packageEndDate;
      clientAppointmentRequestModel.value.defaultPackageEndDate = resp.defaultPackageEndDate;
      clientAppointmentRequestModel.refresh();
    }
  }

  Future<void> getClientTestScores(String clientId) async {
    ResponseData<ClientTestScoreResponseModel> response = await ApiService.apiRequest(Get.context!, ApiMethod.get,
        endpoint: Endpoint.getClientTestScore(clientId: clientId));

    inspect(response);
    setBusy(false);
    if (response.success && response.data != null) {
      if (response.data.isNotEmpty) {
        list.value = response.data;
      }
    } else {
      Utilities.showToast(response.message!);
    }
  }
}
