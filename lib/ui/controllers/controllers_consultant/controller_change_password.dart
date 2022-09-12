import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:terapizone/core/enums/enum.dart';
import 'package:terapizone/core/services/endpoint.dart';
import 'package:terapizone/core/services/service_api.dart';
import 'package:terapizone/core/utils/general_data.dart';
import 'package:terapizone/core/utils/utilities.dart';
import 'package:terapizone/ui/controllers/controller_base.dart';
import 'package:terapizone/ui/models/post_auth_change_password_model.dart';
import 'package:terapizone/ui/models/response_data_model.dart';
import 'package:terapizone/ui/shared/uitext.dart';

class ControllerChangePasswordConsultant extends BaseController {
  @override
  void onInit() async {
    super.onInit();
    init();
  }

  Future<void> init() async {
    setBusy(false);
  }

  //controllers
  final TextEditingController _currentPswrdController = TextEditingController();
  TextEditingController get currentPswrdController => _currentPswrdController;
  final TextEditingController _newPswrdController = TextEditingController();
  TextEditingController get newPswrdController => _newPswrdController;
  final TextEditingController _newPswrdController2 = TextEditingController();
  TextEditingController get newPswrdController2 => _newPswrdController2;

  final focusCurrentPswrd = FocusNode();
  final focusNewPswrd = FocusNode();
  final focusNewPswrd2 = FocusNode();

  //states
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;

  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;
  GlobalKey get formKey => _formKey;
  AutovalidateMode get autoValidateMode => _autoValidateMode;

  clearText(int i) {
    if (i == 0) {
      _currentPswrdController.text = '';
    } else if (i == 1) {
      _newPswrdController.text = '';
    } else if (i == 2) {
      _newPswrdController2.text = '';
    }
    update();
  }

  Future<void> changePassword() async {
    if (!_formKey.currentState!.validate()) {
      _autoValidateMode =
          AutovalidateMode.always; // Start validating on every change.
      inspect("hata burda");

      Utilities.showToast(UIText.toastRedSign);

      return;
    } else {
      PostAuthChangePasswordModel postitem = PostAuthChangePasswordModel(
        newPassword: _newPswrdController.text,
        newPasswordAgain: _newPswrdController2.text,
      );
      ResponseData<dynamic> response = await ApiService.apiRequest(
          Get.context!, ApiMethod.post,
          endpoint: Endpoint.changePassword, body: postitem.toJson());
      setBusy(false);
      if (response.success) {
        GeneralData.setPassword(_newPswrdController2.text);
        Get.back();
        _currentPswrdController.clear();
        _newPswrdController.clear();
        _newPswrdController2.clear();
        Utilities.showDefaultDialogConfirm(
            title: UIText.textSuccess,
            content: UIText.textChangePswrdSuccess,
            onConfirm: () => Get.back());
      } else {
        Utilities.showDefaultDialogConfirm(
            title: UIText.textError,
            content: UIText.textChangePswrdError + ' ${response.message}',
            onConfirm: () => Get.back());
      }
    }
  }
}
