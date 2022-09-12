import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:terapizone/core/utils/general_data.dart';
import 'package:terapizone/ui/controllers/controllers_consultant/controller_change_password.dart';
import 'package:terapizone/ui/shared/decoration.dart';
import 'package:terapizone/ui/shared/uicolor.dart';
import 'package:terapizone/ui/shared/uitext.dart';
import 'package:terapizone/ui/views/view_base.dart';
import 'package:terapizone/ui/widgets/widget_buttons.dart';
import 'package:terapizone/ui/widgets/widget_state.dart';
import 'package:terapizone/ui/widgets/widget_text.dart';
import 'package:terapizone/ui/widgets/widget_text_field.dart';

class ViewChangePasswordConsultant extends StatelessWidget {
  const ViewChangePasswordConsultant({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final c = Get.put(ControllerChangePasswordConsultant());

    final _scaffoldKey = GlobalKey<ScaffoldState>();

    return ViewBase(
      statusbarBrightness: SystemUiOverlayStyle.dark,
      child: Container(
        height: Get.size.height,
        width: Get.size.width,
        alignment: Alignment.center,
        color: UIColor.wildSand,
        child: Obx(() => c.busy
            ? const ActivityIndicator()
            : Scaffold(
                key: _scaffoldKey,
                backgroundColor: UIColor.wildSand,
                appBar: AppBar(
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
                body: body())),
      ),
    );
  }

  Widget body() {
    final ControllerChangePasswordConsultant c = Get.find();

    return Container(
      height: Get.height,
      width: Get.width,
      decoration: BoxDecoration(
        color: UIColor.athensGray,
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Form(
              key: c.formKey,
              autovalidateMode: c.autoValidateMode,
              child: Container(
                margin: const EdgeInsets.only(top: 50, bottom: 30),
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
        ),
      ),
    );
  }
}
