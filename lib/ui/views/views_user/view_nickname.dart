import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:terapizone/ui/controllers/controllers_user/controller_nickname.dart';
import 'package:terapizone/ui/shared/decoration.dart';
import 'package:terapizone/ui/shared/uicolor.dart';
import 'package:terapizone/ui/shared/uitext.dart';
import 'package:terapizone/ui/widgets/widget_buttons.dart';
import 'package:terapizone/ui/widgets/widget_text.dart';
import 'package:terapizone/ui/widgets/widget_text_field.dart';

void viewNickname() {
  // ignore: unused_local_variable
  final c = Get.put(ControllerNickname());
  showModalBottomSheet(
      context: Get.context!,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
      backgroundColor: UIColor.wildSand.withOpacity(.92),
      isScrollControlled: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      builder: (context) {
        return _body();
      });
}

Widget _body() {
  final ControllerNickname c = Get.find();

  final viewInsets = EdgeInsets.fromWindowPadding(
      WidgetsBinding.instance!.window.viewInsets, WidgetsBinding.instance!.window.devicePixelRatio);

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
          Container(color: UIColor.wildSand.withOpacity(.92), height: 10, width: Get.width),
          AppBar(
            backgroundColor: UIColor.wildSand.withOpacity(.92),
            elevation: 0,
            automaticallyImplyLeading: false,
            centerTitle: false,
            title: Row(
              children: [
                const Spacer(),
                TextBasic(
                  text: "UIText.nicknameTitle",
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  textAlign: TextAlign.center,
                ),
                const Spacer(),
                InkWell(
                  onTap: () => c.saveNickname(),
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
          Divider(color: UIColor.tuna.withOpacity(.38), height: 16),
          const SizedBox(height: 30),
          Form(
            key: c.formKey,
            child: Container(
              decoration: whiteDecoration(),
              child: LoginTextField(
                enabled: true,
                controller: c.nicknameController,
                focusNode: c.focusNickname,
                requestFocus: FocusNode(),
                obscureText: false,
                hint: 'Fındık',
                validator: (t) {
                  if (t != null) {
                    if (t.isEmpty) {
                      return UIText.toastRedSign;
                    } else {
                      return null;
                    }
                  }
                },
                suffixIcon: c.nicknameController.text.isNotEmpty
                    ? IconButton(onPressed: () => c.clearText(), icon: const Icon(Icons.cancel_rounded))
                    : null,
              ),
            ),
          ),
        ],
      )),
    ),
  );
}
