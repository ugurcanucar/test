import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:terapizone/core/utils/utilities.dart';
import 'package:terapizone/ui/controllers/controller_base.dart';
import 'package:terapizone/ui/shared/uitext.dart';

class ControllerNickname extends BaseController {
  @override
  void onInit() async {
    super.onInit();
    init();
  }

  Future<void> init() async {
    setBusy(false);
  }

  //controllers
  final TextEditingController _nicknameController = TextEditingController();
  TextEditingController get nicknameController => _nicknameController;

  final focusNickname = FocusNode();

  //states
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;
  GlobalKey get formKey => _formKey;

  clearText() {
    _nicknameController.text = '';
  }

  void saveNickname() async {
    if (!_formKey.currentState!.validate()) {
      Utilities.showToast(UIText.toastRedSign);

      return;
    } else {
      log('save nickname !!!');
      Navigator.pop(Get.context!);
    }
  }
}
