import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:terapizone/ui/controllers/controller_base.dart';

class ControllerNotificationsSettings extends BaseController {
  @override
  void onInit() async {
    super.onInit();
    init();
  }

  Future<void> init() async {
    setBusy(false);
  }

  //states
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final values = <bool>[false, false, false, false].obs;
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;
  setValue(int i, bool value) {
    values[i] = value;
  }
}
