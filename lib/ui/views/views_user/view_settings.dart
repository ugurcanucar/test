import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:terapizone/core/utils/general_data.dart';
import 'package:terapizone/core/utils/utilities.dart';
import 'package:terapizone/ui/controllers/controllers_user/controller_settings.dart';
import 'package:terapizone/ui/shared/decoration.dart';
import 'package:terapizone/ui/shared/uicolor.dart';
import 'package:terapizone/ui/shared/uipath.dart';
import 'package:terapizone/ui/shared/uitext.dart';
import 'package:terapizone/ui/views/view_base.dart';
import 'package:terapizone/ui/views/view_splash.dart';
import 'package:terapizone/ui/views/views_user/view_change_password.dart';
import 'package:terapizone/ui/views/views_user/view_my_consultant.dart';
//import 'package:terapizone/ui/views/views_user/view_preferences.dart';
import 'package:terapizone/ui/views/views_user/view_profile.dart';
import 'package:terapizone/ui/views/views_user/view_subscription.dart';
import 'package:terapizone/ui/views/views_user/views_video_therapy/view_buy_video_therapy.dart';
import 'package:terapizone/ui/views/views_user/views_video_therapy/view_video_therapy.dart';
import 'package:terapizone/ui/widgets/widget_buttons.dart';
import 'package:terapizone/ui/widgets/widget_setting_line.dart';
import 'package:terapizone/ui/widgets/widget_state.dart';
import 'package:terapizone/ui/widgets/widget_text.dart';

class ViewSettings extends StatelessWidget {
  const ViewSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final c = Get.put(ControllerSettings());

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
                    key: c.scaffoldKey,
                    backgroundColor: UIColor.wildSand,
                    appBar: AppBar(
                      backgroundColor: UIColor.wildSand,
                      elevation: 0,
                      leadingWidth: 23, //padding+icon width
                      automaticallyImplyLeading: false,
                      centerTitle: true,
                      leading: const GetBackButton(),
                      systemOverlayStyle: SystemUiOverlayStyle.light,
                    ),
                    body: body()),
              )),
      ),
    );
  }

  Widget body() {
    ControllerSettings c = Get.find();
    return Container(
      height: Get.height,
      width: Get.width,
      decoration: BoxDecoration(
        color: UIColor.mercury,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //settings title
            Container(
              color: UIColor.wildSand,
              padding: const EdgeInsets.only(left: 16, bottom: 14),
              width: Get.width,
              child: TextBasic(
                text: UIText.settingsTitle,
                fontSize: 34,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 30),
            //my info & my consultants & subscription & video therapy
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
              decoration: whiteDecoration(),
              child: Column(
                children: [
                  //my info
                  getSetting(
                      icon: UIPath.settingsInfo,
                      title: UIText.settingsInfo,
                      onTap: () => Get.to(() => const ViewProfile()),
                      isDivider: true),
                  //my consultant
                  getSetting(
                      icon: UIPath.settingsConsultant,
                      title: UIText.settingsConsultant,
                      onTap: () => Get.to(() => const ViewMyConsultant()),
                      isDivider: true),

                  //buy new package
                  getSetting(
                      icon: UIPath.settingsFinance,
                      title: UIText.settingsBuyNewPackage,
                      onTap: () => viewBuyVideoTherapy(),
                      isDivider: true),
                  //subscription
                  getSetting(
                      icon: UIPath.settingsSubscription,
                      title: UIText.settingsSubscription,
                      onTap: () => viewSubscription(),
                      isDivider: true),
                  //video therapy
                  getSetting(
                      icon: UIPath.settingsVideoTherapy,
                      title: UIText.settingsVideoTherapy,
                      onTap: () => Get.to(() => const ViewVideoTherapy()),
                      isDivider: true),
                  //contact
                  getSetting(
                      icon: UIPath.settingsScriptedMsg,
                      title: UIText.settingsContact,
                      onTap: () {
                        Get.bottomSheet(
                          Wrap(
                            children: [
                              Container(
                                color: UIColor.white,
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    children: [
                                      getSetting(
                                          icon: UIPath.settingsEmail,
                                          title: UIText.settingsEmail,
                                          onTap: () => c.launchEmail(),
                                          isDivider: true),
                                      getSetting(
                                          icon: UIPath.settingsPhoneCall,
                                          title: UIText.settingsPhoneCall,
                                          onTap: () => c.launchPhoneCall(),
                                          isDivider: true),
                                      getSetting(
                                          icon: UIPath.settingsWhatsapp,
                                          title: UIText.settingsWhatsapp,
                                          onTap: () => c.launchWhatsapp(),
                                          isDivider: true),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          isScrollControlled: true,
                        );
                      }),
                ],
              ),
            ),
            const SizedBox(height: 30),
            //Notifications & change password
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
              decoration: BoxDecoration(
                color: UIColor.white,
                border: Border(
                  top: BorderSide(
                      width: 1, color: UIColor.tuna.withOpacity(.33)),
                  bottom: BorderSide(
                      width: 1, color: UIColor.tuna.withOpacity(.33)),
                ),
              ),
              child: Column(
                children: [
                  //notifications
                  /* getSetting(
                      icon: UIPath.settingsNotificationSettings,
                      title: UIText.settingsNotification,
                      isDivider: true,
                      onTap: () => viewPreferences()), */
                  //change password
                  getSetting(
                      icon: UIPath.settingsChangePswrd,
                      title: UIText.settingsChangePswrd,
                      onTap: () => viewChangePassword()),
                ],
              ),
            ),
            const SizedBox(height: 30),
            //help & recommend
            /*    Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
              decoration: BoxDecoration(
                color: UIColor.white,
                border: Border(
                  top: BorderSide(
                      width: 1, color: UIColor.tuna.withOpacity(.33)),
                  bottom: BorderSide(
                      width: 1, color: UIColor.tuna.withOpacity(.33)),
                ),
              ),
              child: Column(
                children: [
                  //help
                  getSetting(
                      icon: UIPath.settingsHelp,
                      title: UIText.settingsHelp,
                      onTap: () {},
                      isDivider: true),
                  //recommend
                  getSetting(
                      icon: UIPath.settingsRecommend,
                      title: UIText.settingsRecommend,
                      onTap: () {}),
                ],
              ),
            ),
          */
            const SizedBox(height: 30),
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 17),
                width: Get.width,
                decoration: whiteDecoration(),
                alignment: Alignment.center,
                child: TextBasic(
                  text: UIText.settingsExit,
                  color: UIColor.redOrange,
                  fontSize: 17,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30),
              child: TextBasic(
                text: UIText.settingsWarning,
                fontSize: 13,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
