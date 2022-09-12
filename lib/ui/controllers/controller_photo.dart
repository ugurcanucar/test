import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:terapizone/ui/controllers/controller_base.dart';
import 'package:terapizone/ui/shared/uipath.dart';

class ControllerPhoto extends BaseController {
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
  final RxInt _currentIndex = 0.obs;
  final List<String> imgList = [
    UIPath.w1,
    UIPath.w1,
    UIPath.w1,
  ];
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;
  int get currentIndex => _currentIndex.value;
  setCurrenIndex(int index) {
    _currentIndex.value = index;
  }
}
