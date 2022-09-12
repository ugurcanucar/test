import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:terapizone/core/enums/enum.dart';
import 'package:terapizone/core/services/endpoint.dart';
import 'package:terapizone/core/services/service_api.dart';
import 'package:terapizone/core/utils/utilities.dart';
import 'package:terapizone/ui/controllers/controller_base.dart';
import 'package:terapizone/ui/models/response_data_model.dart';
import 'package:terapizone/ui/shared/uitext.dart';
import 'package:terapizone/ui/views/views_ForgotPswrd/view_forgot_password_code.dart';

class ControllerForgotPassword extends BaseController {
  @override
  void onInit() async {
    super.onInit();
    init();
  }

  Future<void> init() async {
    setBusy(false);
  }

  //controllers
  final TextEditingController _forgotPasswordController =
      TextEditingController();
  TextEditingController get forgotPasswordCodeController =>
      _forgotPasswordController;

  //states
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;

  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;
  GlobalKey get formKey => _formKey;
  AutovalidateMode get autoValidateMode => _autoValidateMode;

  Future<void> sendCode() async {
    if (!_formKey.currentState!.validate()) {
      _autoValidateMode =
          AutovalidateMode.always; // Start validating on every change.
      inspect("hata burda");

      Utilities.showToast(UIText.toastRedSign);

      return;
    } else {
      setBusy(true);

      ResponseData<dynamic> response = await ApiService.apiRequest(
          Get.context!, ApiMethod.post,
          endpoint:
              Endpoint.sendPasswordCode(email: _forgotPasswordController.text));
      setBusy(false);
      if (response.success) {
        Get.back();
        _forgotPasswordController.clear();
        Get.to(() => const ViewForgotPasswordCode());
      } else {
        Utilities.showDefaultDialogConfirm(
            title: UIText.textError,
            content: UIText.genericError + ' ${response.message}',
            onConfirm: () => Get.back());
      }
    }
  }
}
