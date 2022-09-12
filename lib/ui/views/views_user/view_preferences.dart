import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:terapizone/ui/controllers/controllers_user/controller_preferences.dart';
import 'package:terapizone/ui/shared/decoration.dart';
import 'package:terapizone/ui/shared/uicolor.dart';
import 'package:terapizone/ui/shared/uitext.dart';
import 'package:terapizone/ui/widgets/widget_buttons.dart';
import 'package:terapizone/ui/widgets/widget_text.dart';

void viewPreferences() {
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
  final viewInsets = EdgeInsets.fromWindowPadding(
      WidgetsBinding.instance!.window.viewInsets,
      WidgetsBinding.instance!.window.devicePixelRatio);
  final c = Get.put(ControllerPreferences());

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
              leadingWidth: 23,
              automaticallyImplyLeading: false,
              centerTitle: true,
              leading: const GetBackButton(),
              title: TextBasic(
                text: UIText.preferencesTitle,
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ), systemOverlayStyle: SystemUiOverlayStyle.dark,
            ),
            Divider(color: UIColor.tuna.withOpacity(.38), height: 1),
            //notifications title
            Padding(
              padding: const EdgeInsets.only(left: 16, bottom: 6, top: 30),
              child: TextBasic(
                text: UIText.preferencesNotifications,
                color: UIColor.tuna.withOpacity(.6),
                fontSize: 13,
              ),
            ),
            //new message & session reminder
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                width: Get.width,
                decoration: whiteDecoration(),
                alignment: Alignment.center,
                child: Obx(() => Column(
                      children: [
                        _getLine(
                            value: c.values[0],
                            title: UIText.preferencesNewMessage,
                            index: 0,
                            isDivider: true),
                        _getLine(
                            value: c.values[1],
                            title: UIText.preferencesVideoTherapy,
                            index: 1,
                            isDivider: true),
                        _getLine(
                            value: c.values[2],
                            title: UIText.preferencesCampaign,
                            index: 1,
                            isDivider: false),
                      ],
                    ))),
          ],
        ),
      ),
    ),
  );
}

Widget _getLine({
  required bool value,
  required String title,
  String? subtitle,
  required int index,
  bool? isDivider = false,
}) {
  final ControllerPreferences c = Get.find();

  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextBasic(
                text: title,
                fontSize: 17,
              ),
              if (subtitle != null)
                TextBasic(
                  text: subtitle,
                  color: UIColor.tuna.withOpacity(.6),
                  fontSize: 13,
                )
            ],
          ),
          CupertinoSwitch(
            value: value,
            onChanged: (bool value) {
              c.setValue(index, value);
            },
          ),
        ],
      ),
      if (isDivider!) Divider(color: UIColor.tuna.withOpacity(.38), height: 16),
    ],
  );
}
