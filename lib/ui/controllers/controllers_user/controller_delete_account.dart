import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:terapizone/ui/controllers/controller_base.dart';

class ControllerDeleteAccount extends BaseController {
  @override
  void onInit() async {
    super.onInit();
    init();
  }

  Future<void> init() async {
    setBusy(false);
  }

  //controllers
  final TextEditingController _controller = TextEditingController();
  TextEditingController get controller => _controller;

  //states
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final RxBool _isAsked = false.obs;
  final RxInt _groupValue = 0.obs; //selected reason

  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;
  bool get isAsked => _isAsked.value;
  int get groupValue => _groupValue.value;

  setIsAsked(bool value) {
    _isAsked.value = value;
  }

  setRadioButton(ind) {
    _groupValue.value = ind;
  }

  delete() async {
    setBusy(true);
    await 2.delay();
    setBusy(false);

    Get.back();
  }
}
