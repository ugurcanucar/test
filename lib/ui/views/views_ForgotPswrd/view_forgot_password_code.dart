import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:terapizone/ui/controllers/controllers_forgot_pswrd.dart/controller_forgot_pswrd_code.dart';
import 'package:terapizone/ui/shared/uicolor.dart';
import 'package:terapizone/ui/shared/uitext.dart';
import 'package:terapizone/ui/views/view_base.dart';
import 'package:terapizone/ui/widgets/widget_buttons.dart';
import 'package:terapizone/ui/widgets/widget_state.dart';
import 'package:terapizone/ui/widgets/widget_text.dart';
import 'package:terapizone/ui/widgets/widget_text_field.dart';

class ViewForgotPasswordCode extends StatelessWidget {
  const ViewForgotPasswordCode({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final c = Get.put(ControllerForgotPasswordCode());

    return ViewBase(
      statusbarBrightness: SystemUiOverlayStyle.dark,
      child: Container(
        height: Get.size.height,
        width: Get.size.width,
        alignment: Alignment.center,
        color: UIColor.wildSand.withOpacity(.92),
        child: Obx(
          () => c.busy
              ? const ActivityIndicator()
              : Scaffold(
                  key: c.scaffoldKey,
                  backgroundColor: UIColor.wildSand.withOpacity(.92),
                  appBar: getAppBar(),
                  body: body()),
        ),
      ),
    );
  }

  AppBar getAppBar() {
    return AppBar(
      elevation: 0,
      automaticallyImplyLeading: false,
      backgroundColor: UIColor.wildSand.withOpacity(.92),
      leadingWidth: 30,
      leading: const GetBackButton(),
      centerTitle: true,
      title: TextBasic(
        text: UIText.loginButton1,
        fontWeight: FontWeight.w600,
        fontSize: 17,
      ),
      systemOverlayStyle: SystemUiOverlayStyle.dark,
    );
  }

  Widget body() {
    ControllerForgotPasswordCode c = Get.find();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          const SizedBox(height: 31),
          TextBasic(
            textAlign: TextAlign.center,
            text: UIText.forgotPasswordEnterCodeThisFieldTitle2,
            fontSize: 20,
            fontWeight: FontWeight.w400,
            color: UIColor.tuna.withOpacity(.6),
          ),
          const SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
              color: UIColor.white,
              borderRadius: const BorderRadius.all(
                Radius.circular(8),
              ),
            ),
            padding: const EdgeInsets.all(2.5),
            child: Form(
              key: c.formKey,
              autovalidateMode: c.autoValidateMode,
              child: Column(
                children: [
                  //code
                  getTextField(
                    hint: UIText.forgotPasswordEnterCodeHint2,
                    controller: c.passwordCodeController,
                    focusNode: c.focusCode,
                    requestFocus: c.focusNewPassword,
                  ),
                  Divider(
                    color: UIColor.tuna.withOpacity(.38),
                    indent: 12,
                  ),
                  //new password textfield
                  getTextField(
                      hint: UIText.forgotPasswordNewPasswordHint3,
                      controller: c.newPasswordController,
                      focusNode: c.focusNewPassword,
                      requestFocus: c.focusNewPasswordAgain),
                  Divider(
                    color: UIColor.tuna.withOpacity(.38),
                    indent: 12,
                  ),
                  //again new password textfield
                  getTextField(
                    hint: UIText.forgotPasswordNewPasswordAgainHint4,
                    controller: c.newPasswordAgainController,
                    focusNode: c.focusNewPasswordAgain,
                    requestFocus: FocusNode(),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          ButtonBorder(
            borderColor: UIColor.azureRadiance,
            buttonText: UIText.forgotPasswordRefreshPasswordButton,
            textColor: UIColor.azureRadiance,
            radius: 8,
            onTap: () => c.resetPassword()
          ),
          const SizedBox(height: 20),
          ButtonBasic(
            buttonText: UIText.forgotPasswordSendAgainButton,
            bgColor: UIColor.wildSand.withOpacity(.92),
            textColor: UIColor.azureRadiance,
            onTap: () => Get.back(),
          )
        ],
      ),
    );
  }
}

Widget getTextField({
  String? hint,
  required TextEditingController controller,
  FocusNode? focusNode,
  FocusNode? requestFocus,
  bool? enabled,
  bool isPicker = false,
  bool isEmail = false,
}) {
  return SizedBox(
    height: 45,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        //textformfield
        Expanded(
          flex: 1,
          child: LoginTextField(
            enabled: enabled,
            controller: controller,
            focusNode: focusNode,
            requestFocus: requestFocus,
            hint: hint,
            validator: (t) {
              if (t != null) {
                if (t.isEmpty) {
                  return UIText.forgotPasswordThisFieldCantBeEmpty.toString();
                } else {
                  return null;
                }
              }
            },
            obscureText: false,
          ),
        ),
      ],
    ),
  );
}
