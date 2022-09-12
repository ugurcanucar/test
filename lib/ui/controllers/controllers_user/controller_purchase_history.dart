import 'dart:async';
import 'package:flutter/material.dart';
import 'package:terapizone/ui/controllers/controller_base.dart';

class ControllerPurchaseHistory extends BaseController {
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
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;
 
}
