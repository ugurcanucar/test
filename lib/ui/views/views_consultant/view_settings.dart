import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:terapizone/core/utils/general_data.dart';
import 'package:terapizone/core/utils/utilities.dart';
import 'package:terapizone/ui/controllers/controllers_consultant/controller_settings.dart';
import 'package:terapizone/ui/shared/decoration.dart';
import 'package:terapizone/ui/shared/uicolor.dart';
import 'package:terapizone/ui/shared/uipath.dart';
import 'package:terapizone/ui/shared/uitext.dart';
import 'package:terapizone/ui/views/view_base.dart';
import 'package:terapizone/ui/views/view_splash.dart';
import 'package:terapizone/ui/views/views_consultant/view_calendar_settings.dart';
import 'package:terapizone/ui/views/views_consultant/view_match_choices.dart';
import 'package:terapizone/ui/views/views_consultant/view_security.dart';
import 'package:terapizone/ui/widgets/widget_setting_line.dart';
import 'package:terapizone/ui/widgets/widget_state.dart';
import 'package:terapizone/ui/widgets/widget_text.dart';

class ViewSettings extends StatelessWidget {
  const ViewSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final c = Get.put(ControllerSettings());
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
            : SafeArea(
                child: Scaffold(
                    key: _scaffoldKey,
                    backgroundColor: UIColor.wildSand,
                    body: body()),
              )),
      ),
    );
  }

  Widget body() {
    return SingleChildScrollView(
      child: Column(
        children: [
          //settings title
          Container(
            color: UIColor.wildSand,
            padding: const EdgeInsets.only(left: 16),
            width: Get.width,
            child: TextBasic(
              text: UIText.cSettingsTitle,
              fontSize: 34,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 37),
          //notifications
          /*   Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: whiteDecoration(),
            child: getSetting(
                icon: UIPath.settingsNotification,
                title: UIText.cSettingsNotifications,
                onTap: () => Get.to(() => const ViewNotifications()),
                isDivider: false),
          ),
          const SizedBox(height: 30),
          //finance
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: whiteDecoration(),
            child: getSetting(
                icon: UIPath.settingsFinance,
                title: UIText.cSettingsFinance,
                onTap: () => Get.to(() => const ViewFinance()),
                isDivider: false),
          ),
          const SizedBox(height: 30), */
          //calendar seattings && scales && scripted messages && match choices && NotificationSettings
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: whiteDecoration(),
            child: Column(
              children: [
                //calendar seattings
                getSetting(
                    icon: UIPath.settingsCalendar,
                    title: UIText.cSettingCalendarSettings,
                    onTap: () => Get.to(() => const ViewCalendarSettings()),
                    isDivider: true),
                //scales
                /*  getSetting(
                    icon: UIPath.settingsScales,
                    title: UIText.cSettingsScales,
                    onTap: () {},
                    isDivider: true), */
                //scripted messages
                /* getSetting(
                    icon: UIPath.settingsScriptedMsg,
                    title: UIText.cSettingsScriptedMsg,
                    onTap: () {},
                    isDivider: true), */
                //match choices
                getSetting(
                    icon: UIPath.settingsMatch,
                    title: UIText.cSettingsMeetChoices,
                    onTap: () => Get.to(() => const ViewMatchChoices()),
                    isDivider: true),
                //NotificationSettings
                /*   getSetting(
                    icon: UIPath.settingsNotificationSettings,
                    title: UIText.cSettingsNotificationSettings,
                    onTap: () {},
                    isDivider: true), */
                //security
                getSetting(
                    icon: UIPath.settingsSecurity,
                    title: UIText.cSettingsSecurity,
                    onTap: () => Get.to(() => const ViewSecurity())),
              ],
            ),
          ),
          const SizedBox(height: 30),
          //help
          /*   Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            width: Get.width,
            decoration: whiteDecoration(),
            alignment: Alignment.center,
            child: getSetting(
              icon: UIPath.settingsHelp,
              title: UIText.cSettingsHelp,
              onTap: () {},
            ),
          ),
          const SizedBox(height: 30), */
          //exit
          GestureDetector(
            onTap: () => Utilities.showDefaultDialogConfirmCancel(
                title: UIText.textSure,
                content: UIText.textExitAppContent,
                onConfirm: () {
                  GeneralData.setPassword('');
                  Get.reset;
                  Get.offAll(() => const ViewSplash());
                },
                onCancel: () {
                  Get.back();
                }),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
              width: Get.width,
              decoration: whiteDecoration(),
              alignment: Alignment.center,
              child: TextBasic(
                text: UIText.cSettingsExit,
                color: UIColor.redOrange,
                fontSize: 17,
              ),
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
