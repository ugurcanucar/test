import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:terapizone/ui/controllers/controllers_consultant/controller_notifications_settings.dart';
import 'package:terapizone/ui/shared/decoration.dart';
import 'package:terapizone/ui/shared/uicolor.dart';
import 'package:terapizone/ui/shared/uitext.dart';
import 'package:terapizone/ui/views/view_base.dart';
import 'package:terapizone/ui/widgets/widget_buttons.dart';
import 'package:terapizone/ui/widgets/widget_state.dart';
import 'package:terapizone/ui/widgets/widget_text.dart';

class ViewNotificationsSettings extends StatelessWidget {
  const ViewNotificationsSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final c = Get.put(ControllerNotificationsSettings());
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
                        text: UIText.cnotificationsTitle,
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        textAlign: TextAlign.center,
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: null,
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
    final ControllerNotificationsSettings c = Get.find();

    return Container(
      height: Get.height,
      width: Get.width,
      decoration: BoxDecoration(
        color: UIColor.athensGray,
      ),
      child: SingleChildScrollView(
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            margin: const EdgeInsets.only(top: 50, bottom: 30),
            width: Get.width,
            decoration: whiteDecoration(),
            alignment: Alignment.center,
            child: Column(
              children: [
                getLine(
                    value: c.values[0],
                    title: UIText.cnotificationsNewMsg,
                    index: 0,
                    isDivider: true),
                getLine(
                    value: c.values[1],
                    title: UIText.cnotificationsNewClient,
                    index: 1,
                    isDivider: true),
                getLine(
                    value: c.values[2],
                    title: UIText.cnotificationsNewSession,
                    index: 2,
                    isDivider: true),
                getLine(
                    value: c.values[3],
                    title: UIText.cnotificationsJoinSession,
                    index: 3,
                    isDivider: false),
              ],
            )),
      ),
    );
  }

  Widget getLine({
    required bool value,
    required String title,
    String? subtitle,
    required int index,
    bool? isDivider = false,
  }) {
    final ControllerNotificationsSettings c = Get.find();

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
        if (isDivider!)
          Divider(color: UIColor.tuna.withOpacity(.38), height: 16),
      ],
    );
  }
}
