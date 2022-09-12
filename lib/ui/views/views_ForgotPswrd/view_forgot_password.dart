import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:terapizone/ui/controllers/controllers_forgot_pswrd.dart/controller_forgot_pswrd.dart';
import 'package:terapizone/ui/shared/uicolor.dart';
import 'package:terapizone/ui/shared/uitext.dart';
import 'package:terapizone/ui/views/view_base.dart';
import 'package:terapizone/ui/widgets/widget_buttons.dart';
import 'package:terapizone/ui/widgets/widget_state.dart';
import 'package:terapizone/ui/widgets/widget_text.dart';
import 'package:terapizone/ui/widgets/widget_text_field.dart';

class ViewForgotPassword extends StatelessWidget {
  const ViewForgotPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final c = Get.put(ControllerForgotPassword());

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
    ControllerForgotPassword c = Get.find();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          const SizedBox(height: 31),
          TextBasic(
            textAlign: TextAlign.center,
            text: UIText.forgotPasswordTitle1CodeToMail,
            fontSize: 20,
            fontWeight: FontWeight.w400,
            color: UIColor.tuna.withOpacity(.6),
          ),
          const SizedBox(height: 20),
          Form(
            key: c.formKey,
            autovalidateMode: c.autoValidateMode,
            child: Center(
              child: Container(
                  decoration: BoxDecoration(
                    color: UIColor.white,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                  padding: const EdgeInsets.all(2.5),
                  child: LoginTextField(
                    enabled: true,
                    controller: c.forgotPasswordCodeController,
                    hint: UIText.forgotPasswordHint1EnterYourMail,
                    validator: (t) {
                      if (t != null) {
                        if (t.isEmpty) {
                          return UIText.forgotPasswordThisFieldCantBeEmpty;
                        } else {
                          return null;
                        }
                      }
                    },
                    obscureText: false,
                  )),
            ),
          ),
          const SizedBox(height: 20),
          ButtonBorder(
            borderColor: UIColor.azureRadiance,
            buttonText: UIText.forgotPasswordSendButton,
            textColor: UIColor.azureRadiance,
            radius: 8,
            onTap: () =>c.sendCode()
          )
        ],
      ),
    );
  }
}


