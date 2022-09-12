import 'dart:async';
import 'package:get/get.dart';
import 'package:terapizone/ui/controllers/controller_base.dart';

class ControllerSecurity extends BaseController {
  @override
  void onInit() async {
    super.onInit();
    init();
  }

  Future<void> init() async {
    setBusy(false);
  }

  //controllers

  //states
  final RxBool _appPswrd = false.obs;
  final RxBool _faceId = false.obs;
  bool get appPswrd => _appPswrd.value;
  bool get faceId => _faceId.value;

  setAppPswrd(bool value) {
    _appPswrd.value = value;
  }

  setFaceId(bool value) {
    _faceId.value = value;
  }
}
