import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:terapizone/core/enums/enum.dart';
import 'package:terapizone/core/services/endpoint.dart';
import 'package:terapizone/core/services/service_api.dart';
import 'package:terapizone/core/utils/utilities.dart';
import 'package:terapizone/ui/controllers/controller_base.dart';
import 'package:terapizone/ui/models/past_appointments_model.dart';
import 'package:terapizone/ui/models/response_data_model.dart';

class ControllerPastAppointments extends BaseController {
  @override
  void onInit() async {
    super.onInit();
    init();
  }

  Future<void> init() async {
    await getPastAppointments();
  }

  //states
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final RxList<PastAppointmentsModel> _pastAppointments =
      <PastAppointmentsModel>[].obs;

  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;
  List<PastAppointmentsModel> get pastAppointments => _pastAppointments;

//past appointmnets
  Future<void> getPastAppointments() async {
    ResponseData<PastAppointmentsModel> response = await ApiService.apiRequest(
        Get.context!, ApiMethod.get,
        endpoint: Endpoint.pastAppointments);
    setBusy(false);

    if (response.success && response.data != null) {
      if (response.data.isNotEmpty) {
        _pastAppointments.value = response.data;
        update();
      }
    } else {
      Utilities.showToast(response.message!);
    }
  }
}
