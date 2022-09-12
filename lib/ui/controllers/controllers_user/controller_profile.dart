import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:terapizone/core/enums/enum.dart';
import 'package:terapizone/core/services/endpoint.dart';
import 'package:terapizone/core/services/service_api.dart';
import 'package:terapizone/core/utils/utilities.dart';
import 'package:terapizone/ui/controllers/controller_base.dart';
import 'package:terapizone/ui/models/my_profile_model.dart';
import 'package:terapizone/ui/models/response_data_model.dart';

class ControllerProfile extends BaseController {
  @override
  void onInit() async {
    super.onInit();
    init();
  }

  Future<void> init() async {
    await getMyProfile();
  }

  //states
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final Rx<MyProfileModel> _myProfile = MyProfileModel().obs;

  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;
  MyProfileModel get myProfile => _myProfile.value;

  //get my profile
  Future<void> getMyProfile() async {
    ResponseData<MyProfileModel> response = await ApiService.apiRequest(
        Get.context!, ApiMethod.get,
        endpoint: Endpoint.myProfile);
    setBusy(false);
    if (response.success && response.data != null) {
      _myProfile.value = response.data;
    } else {
      Utilities.showToast(response.message!);
    }
  }
}
