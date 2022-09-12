import 'dart:async';
import 'package:flutter/material.dart';
import 'package:terapizone/ui/controllers/controller_base.dart';

class ControllerPaymentSuccess extends BaseController {
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
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
}
