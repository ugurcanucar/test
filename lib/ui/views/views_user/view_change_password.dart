import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:terapizone/core/utils/general_data.dart';
import 'package:terapizone/ui/controllers/controllers_user/controller_change_password.dart';
import 'package:terapizone/ui/shared/decoration.dart';
import 'package:terapizone/ui/shared/uicolor.dart';
import 'package:terapizone/ui/shared/uitext.dart';
import 'package:terapizone/ui/widgets/widget_buttons.dart';
import 'package:terapizone/ui/widgets/widget_text.dart';
import 'package:terapizone/ui/widgets/widget_text_field.dart';

void viewChangePassword() {
  // ignore: unused_local_variable
  final c = Get.put(ControllerChangePassword());
  showModalBottomSheet(
      context: Get.context!,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
      backgroundColor: UIColor.wildSand.withOpacity(.92),
      isScrollControlled: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      builder: (context) {
        return _body();
      });
}

Widget _body() {
  final ControllerChangePassword c = Get.find();

  final viewInsets = EdgeInsets.fromWindowPadding(
      WidgetsBinding.instance!.window.viewInsets,
      WidgetsBinding.instance!.window.devicePixelRatio);

  return AnimatedPadding(
    duration: const Duration(milliseconds: 200),
    curve: Curves.fastOutSlowIn,
    padding: EdgeInsets.only(bottom: viewInsets.bottom),
    child: Container(
      width: double.infinity,
      color: UIColor.mercury,
      height: Get.height * .95,
      child: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              color: UIColor.wildSand.withOpacity(.92),
              height: 10,
              width: Get.width),
          AppBar(
            backgroundColor: UIColor.wildSand.withOpacity(.92),
            elevation: 0,
            automaticallyImplyLeading: false,
            centerTitle: false,
            title: Row(
              children: [
                const Spacer(),
                TextBasic(
                  text: UIText.changePswrdTitle,
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  textAlign: TextAlign.center,
                ),
                const Spacer(),
                InkWell(
                  onTap: () => c.changePassword(),
                  child: TextBasic(
                    text: UIText.save,
                    color: UIColor.azureRadiance,
                    fontSize: 17,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            leading: GetBackButton(title: UIText.back),
            systemOverlayStyle: SystemUiOverlayStyle.dark,
          ),
          const SizedBox(height: 30),
          Form(
            key: c.formKey,
            autovalidateMode: c.autoValidateMode,
            child: Container(
              decoration: whiteDecoration(),
              child: Column(
                children: [
                  LoginTextField(
                    enabled: true,
                    controller: c.currentPswrdController,
                    focusNode: c.focusCurrentPswrd,
                    requestFocus: c.focusNewPswrd,
                    obscureText: true,
                    hint: UIText.changePswrdCurrentHint,
                    validator: (t) {
                      if (t != null) {
                        if (t.isEmpty) {
                          return UIText.changePswrdFieldReq;
                        } else if (GeneralData.getPassword() != t) {
                          return UIText.changePswrdCurrentPswrdError;
                        } else {
                          return null;
                        }
                      }
                    },
                    suffixIcon: c.currentPswrdController.text.isNotEmpty
                        ? IconButton(
                            onPressed: () => c.clearText(0),
                            icon: const Icon(Icons.cancel_rounded))
                        : null,
                  ),
                  Divider(color: UIColor.tuna.withOpacity(.38), height: 1),
                  LoginTextField(
                    enabled: true,
                    controller: c.newPswrdController,
                    focusNode: c.focusNewPswrd,
                    requestFocus: c.focusNewPswrd2,
                    obscureText: true,
                    hint: UIText.changePswrdNewHint,
                    validator: (t) {
                      if (t != null) {
                        if (t.isEmpty) {
                          return UIText.changePswrdFieldReq;
                        } else {
                          return null;
                        }
                      }
                    },
                    suffixIcon: c.newPswrdController.text.isNotEmpty
                        ? IconButton(
                            onPressed: () => c.clearText(1),
                            icon: const Icon(Icons.cancel_rounded))
                        : null,
                  ),
                  Divider(color: UIColor.tuna.withOpacity(.38), height: 1),
                  LoginTextField(
                    enabled: true,
                    controller: c.newPswrdController2,
                    focusNode: c.focusNewPswrd2,
                    requestFocus: FocusNode(),
                    obscureText: true,
                    hint: UIText.changePswrdNewHint2,
                    validator: (t) {
                      if (t != null) {
                        if (t.isEmpty) {
                          return UIText.changePswrdFieldReq;
                        } else {
                          return null;
                        }
                      }
                    },
                    suffixIcon: c.newPswrdController2.text.isNotEmpty
                        ? IconButton(
                            onPressed: () => c.clearText(2),
                            icon: const Icon(Icons.cancel_rounded))
                        : null,
                  ),
                ],
              ),
            ),
          ),
        ],
      )),
    ),
  );
}
