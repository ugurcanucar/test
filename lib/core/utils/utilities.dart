import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:terapizone/core/utils/general_data.dart';
import 'package:terapizone/ui/shared/uicolor.dart';
import 'package:terapizone/ui/shared/uitext.dart';

class Utilities {
  static Future<bool> isOnline() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } on SocketException catch (_) {
      return false;
    }
  }

  static void hideKeyboard() {
    //FocusScope.of(Get.context!).unfocus();
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }

  static dynamic getUserSp(String id, {dynamic defaultValue}) {
    if (GeneralData.hive != null) {
      return GeneralData.hive!.get(id);
    } else {
      return null;
    }
  }

  static void setUserSp(String id, dynamic value) async {
    if (GeneralData.hive != null) {
      return await GeneralData.hive!.put(id, value);
    } else {
      return null;
    }
  }

  //toasts
  static showToast(String msg) {
    Get.snackbar(UIText.toaastTitle1, msg,
        backgroundColor: UIColor.azureRadiance,
        colorText: UIColor.white,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
        margin: const EdgeInsets.all(16));
  }

  static void showDefaultDialogConfirmCancel(
      {required String title,
      required String content,
      required Function() onConfirm,
      required Function() onCancel}) {
    Get.defaultDialog(
      title: title,
      titleStyle:
          TextStyle(fontWeight: FontWeight.bold, color: UIColor.azureRadiance),
      content: Text(content,
          style: TextStyle(fontWeight: FontWeight.w500, color: UIColor.tuna)),
      confirm: TextButton(
        onPressed: onConfirm,
        child: Text(UIText.textOK,
            style: TextStyle(
                fontWeight: FontWeight.w500, color: UIColor.azureRadiance)),
      ),
      cancel: TextButton(
        onPressed: onCancel,
        child: Text(UIText.textCancel,
            style: TextStyle(
                fontWeight: FontWeight.w500, color: UIColor.redOrange)),
      ),
    );
  }

  static void showDefaultDialogConfirm({
    required String title,
    required String content,
    required Function()? onConfirm,
  }) {
    Get.defaultDialog(
      title: title,
      titleStyle:
          TextStyle(fontWeight: FontWeight.bold, color: UIColor.azureRadiance),
      content: Text(content,
          style: TextStyle(fontWeight: FontWeight.w500, color: UIColor.tuna)),
      confirm: GestureDetector(
        onTap: onConfirm,
        child: Text(UIText.textOK,
            style: TextStyle(
                fontWeight: FontWeight.w500, color: UIColor.azureRadiance)),
      ),
    );
  }

//cancel appointment alert
  static void showCancelAppointmentDialog(
      {required Function() onConfirm, required Function() onCancel}) {
    Get.defaultDialog(
      title: UIText.textSure,
      titleStyle:
          TextStyle(fontWeight: FontWeight.bold, color: UIColor.azureRadiance),
      content: Text(UIText.textCancelAppointmentWarning,
          style: TextStyle(fontWeight: FontWeight.w500, color: UIColor.tuna)),
      confirm: TextButton(
        onPressed: onConfirm,
        child: Text(UIText.videoTherapyCancel,
            style: TextStyle(
                fontWeight: FontWeight.w500, color: UIColor.redOrange)),
      ),
      cancel: TextButton(
        onPressed: onCancel,
        child: Text(UIText.textAbort,
            style: TextStyle(fontWeight: FontWeight.w500, color: UIColor.tuna)),
      ),
    );
  }
}
