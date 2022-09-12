import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:terapizone/ui/controllers/controllers_user/controller_delete_account.dart';
import 'package:terapizone/ui/shared/decoration.dart';
import 'package:terapizone/ui/shared/uicolor.dart';
import 'package:terapizone/ui/shared/uipath.dart';
import 'package:terapizone/ui/shared/uitext.dart';
import 'package:terapizone/ui/views/view_base.dart';
import 'package:terapizone/ui/widgets/widget_buttons.dart';
import 'package:terapizone/ui/widgets/widget_state.dart';
import 'package:terapizone/ui/widgets/widget_text.dart';

class ViewDeleteAccount extends StatelessWidget {
  const ViewDeleteAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final c = Get.put(ControllerDeleteAccount());

    return ViewBase(
      statusbarBrightness: SystemUiOverlayStyle.light,
      child: Container(
        height: Get.size.height,
        width: Get.size.width,
        alignment: Alignment.center,
        color: UIColor.wildSand.withOpacity(.92),
        child: Obx(() => c.busy
            ? const ActivityIndicator()
            : Scaffold(
                key: c.scaffoldKey,
                backgroundColor: UIColor.wildSand.withOpacity(.92),
                appBar: AppBar(
                  backgroundColor: UIColor.wildSand.withOpacity(.92),
                  elevation: 0,
                  automaticallyImplyLeading: false,
                  centerTitle: true,
                  leading: Align(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () => Get.back(),
                      child: TextBasic(
                        text: UIText.deleteAccountCancel,
                        color: UIColor.azureRadiance,
                        fontSize: 17,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  title: TextBasic(
                    text: UIText.deleteAccountTitle,
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    textAlign: TextAlign.center,
                  ),
                  systemOverlayStyle: SystemUiOverlayStyle.dark,
                ),
                body: body())),
      ),
    );
  }

  Widget body() {
    final ControllerDeleteAccount c = Get.find();

    return Container(
      height: Get.height,
      width: Get.width,
      decoration: BoxDecoration(
        color: UIColor.mercury,
      ),
      child: SingleChildScrollView(
          child: !c.isAsked ? getSureContainer() : getReasonContainer()),
    );
  }

  Widget getSureContainer() {
    final ControllerDeleteAccount c = Get.find();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 30),
        SvgPicture.asset(UIPath.deleteAccount,
            width: 74, height: 70, fit: BoxFit.cover),
        const SizedBox(height: 30),
        TextBasic(
          text: UIText.deleteAccountText,
          color: UIColor.manatee,
          fontSize: 22,
          fontWeight: FontWeight.w700,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 30),
        TextBasic(
          text: UIText.deleteAccountSubtext,
          color: UIColor.manatee,
          fontSize: 17,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 30),
        //send message button
        ButtonBasic(
            buttonText: UIText.deleteAccountBtn,
            bgColor: UIColor.azureRadiance,
            textColor: UIColor.white,
            onTap: () => c.setIsAsked(true)),
      ],
    );
  }

  Widget getReasonContainer() {
    final ControllerDeleteAccount c = Get.find();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding:
              const EdgeInsets.only(top: 30, bottom: 20, left: 16, right: 16),
          child: TextBasic(
            text: UIText.deleteAccountWhy,
            fontSize: 22,
            fontWeight: FontWeight.w700,
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          decoration: whiteDecoration(),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Obx(() => Column(
                children: [
                  getLine(
                      title: UIText.deleteAccountReason1,
                      value: 0,
                      isDivider: true),
                  getLine(
                      title: UIText.deleteAccountReason2,
                      value: 1,
                      isDivider: true),
                  getLine(
                      title: UIText.deleteAccountReason3,
                      value: 2,
                      isDivider: true),
                  getLine(
                      title: UIText.deleteAccountReason4,
                      value: 3,
                      isDivider: true),
                  getLine(
                      title: UIText.deleteAccountReason5,
                      value: 4,
                      isDivider: true),
                  getLine(title: UIText.deleteAccountReason6, value: 5),
                  if (c.groupValue == 5) getTextField()
                ],
              )),
        ),
      ],
    );
  }

  Widget getLine(
      {required String title, required int value, bool? isDivider = false}) {
    final ControllerDeleteAccount c = Get.find();

    return Column(
      children: [
        const SizedBox(height: 18),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextBasic(
              text: title,
              fontSize: 17,
              textAlign: TextAlign.left,
            ),
            SizedBox(
              width: 24,
              height: 24,
              child: Radio(
                  groupValue: c.groupValue,
                  value: value,
                  onChanged: (value) => c.setRadioButton(value)),
            )
          ],
        ),
        const SizedBox(height: 18),
        if (isDivider!)
          Divider(color: UIColor.tuna.withOpacity(.38), height: 1),
      ],
    );
  }

  Widget getTextField(
      {List<TextInputFormatter>? inputFormatters,
      Function(String?)? onFieldSubmitted,
      String? Function(String?)? validate,
      Function(String?)? onChanged,
      Function(String?)? onSaved}) {
    final ControllerDeleteAccount c = Get.find();

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextFormField(
        controller: c.controller,
        inputFormatters: inputFormatters,
        onFieldSubmitted: onFieldSubmitted,
        onChanged: onChanged,
        onSaved: onSaved,
        cursorColor: UIColor.azureRadiance,
        validator: validate,
        style: TextStyle(fontSize: 13, color: UIColor.black),
        maxLines: 3,
        decoration: InputDecoration(
          hintText: UIText.deleteAccountWhy,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: UIColor.frenchGray)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: UIColor.azureRadiance)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: UIColor.redOrange)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: UIColor.redOrange)),
        ),
      ),
    );
  }
}
