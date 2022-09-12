import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:terapizone/core/utils/utilities.dart';
import 'package:terapizone/ui/controllers/controller_base.dart';
import 'package:terapizone/ui/shared/uitext.dart';
import 'package:terapizone/ui/views/views_user/view_payment_success.dart';
import 'package:webviewx/webviewx.dart';

class ControllerHtmlPayment extends BaseController {
  @override
  void onInit() async {
    super.onInit();
    init();
  }

  Future<void> init() async {
    setBusy(false);
  }

  void onPageFinished() async {
    try {
      WebViewContent c = await webviewController.getContent();
      String result = c.source;
      if (result.isNotEmpty && result.startsWith("http")) {
        bool isSuccess = result.contains('/Payment/PayWith3D_Payment_Success');
        bool isFailure = result.contains('/Payment/PayWith3D_Payment_Fail');

        if (isSuccess) {
          Get.offAll(() => const ViewPaymentSuccess());
          return;
        } else if (isFailure) {
          Get.back();
          return Utilities.showDefaultDialogConfirm(
              title: UIText.textError,
              content: UIText.textPaymentError,
              onConfirm: () {
                Get.back();
              });
        }
      }
    } catch (e) {
      log(e.toString());
    }
  }

  //controllers
  late WebViewXController webviewController;
  //states
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
}
