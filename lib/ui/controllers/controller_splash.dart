import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:terapizone/core/services/service_fcm.dart';
import 'package:terapizone/core/utils/general_data.dart';
import 'package:terapizone/ui/controllers/controller_base.dart';
import 'package:terapizone/ui/controllers/controller_login_register.dart';
import 'package:terapizone/ui/shared/uipath.dart';

class ControllerSplash extends BaseController {
  @override
  void onInit() async {
    super.onInit();
    init();
  }

  Future<void> init() async {
    FCMService.notificataionSettings(Get.context!);

    if (GeneralData.getEmail().isNotEmpty &&
        GeneralData.getPassword().isNotEmpty) {
      setBusy(true);
      final cLogin = Get.put(ControllerLoginRegister());
      cLogin.setTabIndex(0);
      await cLogin.login(GeneralData.getEmail(), GeneralData.getPassword());
      setBusy(false);
    }
    setBusy(false);
  }

  //states
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final RxInt _currentIndex = 0.obs;
  final List<String> imgList = [
    UIPath.w1,
    UIPath.w2,
    UIPath.w3,
  ];
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;
  int get currentIndex => _currentIndex.value;
  setCurrenIndex(int index) {
    _currentIndex.value = index;
  }
}
