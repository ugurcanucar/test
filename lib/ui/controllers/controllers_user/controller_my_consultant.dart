import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:terapizone/core/enums/enum.dart';
import 'package:terapizone/core/services/endpoint.dart';
import 'package:terapizone/core/services/service_api.dart';
import 'package:terapizone/core/utils/utilities.dart';
import 'package:terapizone/ui/controllers/controller_base.dart';
import 'package:terapizone/ui/models/my_therapist_model.dart';
import 'package:terapizone/ui/models/response_data_model.dart';

class ControllerMyConsultant extends BaseController {
  @override
  void onInit() async {
    super.onInit();
    init();
  }

  Future<void> init() async {
    await getMyTherapist();
  }

  //states
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final Rx<MyTherapistModel> _myTherapist = MyTherapistModel().obs;

  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;
  MyTherapistModel get myTherapist => _myTherapist.value;

  //get detail of my therapist
  Future<void> getMyTherapist() async {
    ResponseData<MyTherapistModel> response = await ApiService.apiRequest(
        Get.context!, ApiMethod.get,
        endpoint: Endpoint.myTherapist);
    setBusy(false);
    if (response.success && response.data != null) {
      _myTherapist.value = response.data;
    } else {
      Utilities.showToast(response.message!);
    }
  }
}
