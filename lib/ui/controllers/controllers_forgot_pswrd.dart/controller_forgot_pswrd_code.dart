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
import 'package:terapizone/ui/models/post_reset_password_model.dart';
import 'package:terapizone/ui/models/response_data_model.dart';
import 'package:terapizone/ui/shared/uitext.dart';
import 'package:terapizone/ui/views/view_splash.dart';

class ControllerForgotPasswordCode extends BaseController {
  @override
  void onInit() async {
    super.onInit();
    init();
  }

  Future<void> init() async {
    setBusy(false);
  }

  //Controllers

  final TextEditingController _passwordCodeController = TextEditingController();
  TextEditingController get passwordCodeController => _passwordCodeController;
  final TextEditingController _newPasswordController = TextEditingController();
  TextEditingController get newPasswordController => _newPasswordController;
  final TextEditingController _newPasswordAgainController =
      TextEditingController();
  TextEditingController get newPasswordAgainController =>
      _newPasswordAgainController;
  final focusCode = FocusNode();

  final focusNewPassword = FocusNode();
  final focusNewPasswordAgain = FocusNode();

  //states
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;

  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;
  GlobalKey get formKey => _formKey;
  AutovalidateMode get autoValidateMode => _autoValidateMode;

  Future<void> resetPassword() async {
    if (!_formKey.currentState!.validate()) {
      _autoValidateMode =
          AutovalidateMode.always; // Start validating on every change.
      inspect("hata burda");

      Utilities.showToast(UIText.toastRedSign);

      return;
    } else {
      PostResetPasswordModel postItem = PostResetPasswordModel(
        code: _passwordCodeController.text,
        newPassword: _newPasswordController.text,
        newPasswordAgain: _newPasswordAgainController.text,
      );
      setBusy(true);

      ResponseData<dynamic> response = await ApiService.apiRequest(
        Get.context!,
        ApiMethod.post,
        endpoint: Endpoint.resetPassword,
        body: postItem.toJson(),
      );
      setBusy(false);
      if (response.success) {
        GeneralData.setPassword('');
        Get.reset;
        Get.offAll(() => const ViewSplash());
        Utilities.showDefaultDialogConfirm(
            title: UIText.textSuccess,
            content: UIText.textChangePswrdSuccess,
            onConfirm: () => Get.back());
      } else {
        Utilities.showDefaultDialogConfirm(
            title: UIText.textError,
            content: UIText.genericError + ' ${response.message}',
            onConfirm: () => Get.back());
      }
    }
  }
}
