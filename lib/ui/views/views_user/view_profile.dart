import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:terapizone/ui/controllers/controllers_user/controller_profile.dart';
import 'package:terapizone/ui/shared/decoration.dart';
import 'package:terapizone/ui/shared/uicolor.dart';
import 'package:terapizone/ui/shared/uipath.dart';
import 'package:terapizone/ui/shared/uitext.dart';
import 'package:terapizone/ui/views/view_base.dart';
import 'package:terapizone/ui/views/views_user/view_change_password.dart';
import 'package:terapizone/ui/views/views_user/view_delete_account.dart';
//import 'package:terapizone/ui/views/views_user/view_nickname.dart';
import 'package:terapizone/ui/widgets/widget_buttons.dart';
import 'package:terapizone/ui/widgets/widget_state.dart';
import 'package:terapizone/ui/widgets/widget_text.dart';

class ViewProfile extends StatelessWidget {
  const ViewProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final c = Get.put(ControllerProfile());

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
                  leadingWidth: 65, //padding+icon width + back text
                  automaticallyImplyLeading: false,
                  centerTitle: true,
                  leading: GetBackButton(title: UIText.back),
                  title: TextBasic(
                    text: UIText.profileTitle,
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                  systemOverlayStyle: SystemUiOverlayStyle.dark,
                ),
                body: body())),
      ),
    );
  }

  Widget body() {
    ControllerProfile c = Get.find();
    return Container(
      height: Get.height,
      width: Get.width,
      decoration: BoxDecoration(
        color: UIColor.mercury,
      ),
      child: c.myProfile.email != null
          ? SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                          colors: [UIColor.osloGray, UIColor.iron]),
                    ),
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(top: 20, bottom: 6),
                    child: TextBasic(
                      text: c.myProfile.nickName!.substring(0, 1),
                      color: UIColor.white,
                      fontSize: 34,
                      fontWeight: FontWeight.w700,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  //change
                  /*  TextBasic(
              text: UIText.profileChange,
              color: UIColor.azureRadiance,
              fontSize: 13,
              textAlign: TextAlign.center,
            ), */
                  const SizedBox(height: 30),

                  Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
                      width: Get.width,
                      decoration: whiteDecoration(),
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          Column(
                            children: [
                              //nickname
                              getLine(
                                  title: UIText.profileNickname,
                                  text: c.myProfile.nickName,
                                  onTap: () {
                                    //viewNickname();
                                  },
                                  isDivider: true),
                              //password
                              getLine(
                                title: UIText.profilePswrd,
                                onTap: () => viewChangePassword(),
                                isDivider: true,
                              ),
                              getLine(
                                  title: UIText.profileEmail,
                                  text: c.myProfile.email!,
                                  onTap: () {},
                                  isDivider: false,
                                  icon: UIPath.roundedCheck),
                            ],
                          ),
                        ],
                      )),

                  const SizedBox(height: 30),

                  //email & phone
                  /*   Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
                width: Get.width,
                decoration: whiteDecoration(),
                alignment: Alignment.center,
                child: getLine(
                   title: UIText.profilePhone,
                   text: UIText.profileAdd,
                   onTap: () {},
                   icon: UIPath.warning)),
            const SizedBox(height: 30), */
                  //birthdate & gender
                  /*     Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
                width: Get.width,
                decoration: whiteDecoration(),
                alignment: Alignment.center,
                child: Column(
                  children: [
                    getLine(
                        title: UIText.profileBirthdate,
                        text: '01/01/1960',
                        onTap: () {},
                        isDivider: true),
                    getLine(
                        title: UIText.profileGender,
                        text: 'Söylemek İstemiyorum',
                        onTap: () {}),
                  ],
                )),
         */ //match choices title
                  /*  Padding(
              padding: const EdgeInsets.only(left: 16, top: 30, bottom: 6),
              child: Align(
                alignment: Alignment.centerLeft,
                child: TextBasic(
                  text: UIText.profileMatchChoices,
                  color: UIColor.tuna.withOpacity(.6),
                  fontSize: 13,
                ),
              ),
            ), */
                  //complaints & consultant gender
                  /*       Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
                width: Get.width,
                decoration: whiteDecoration(),
                alignment: Alignment.center,
                child: Column(
                  children: [
                    getLine(
                        title: UIText.profileComplaint,
                        subtitle: UIText.profileComplaintSub,
                        onTap: () {},
                        isDivider: true),
                    getLine(
                        title: UIText.profileConsultantGender,
                        text: 'Farketmez',
                        onTap: () {}),
                  ],
                )),
       */ //delete account
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    child: GestureDetector(
                      onTap: () => Get.to(() => const ViewDeleteAccount()),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
                        width: Get.width,
                        decoration: whiteDecoration(),
                        alignment: Alignment.center,
                        child: TextButton(
                          onPressed: () => Get.to(() => const ViewDeleteAccount()),
                          child: TextBasic(
                            text: UIText.profileDeleteAccount,
                            color: UIColor.redOrange,
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          : const SizedBox(),
    );
  }

  Widget getLine(
      {required String title,
      String? subtitle,
      String? text,
      required Function() onTap,
      bool? isDivider = false,
      String? icon}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: onTap,
          behavior: HitTestBehavior.translucent,
          child: Row(
            children: [
              Expanded(
                child: Column(
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
                      ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (text != null)
                      Expanded(
                        child: TextBasic(
                          text: text,
                          color: UIColor.tuna.withOpacity(.6),
                          fontSize: 17,
                          textAlign: TextAlign.right,
                        ),
                      ),
                    if (icon != null)
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: SvgPicture.asset(
                          icon,
                          width: 24,
                          height: 24,
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    const SizedBox(width: 8),
                    SvgPicture.asset(
                      UIPath.right,
                      width: 10,
                      height: 24,
                      fit: BoxFit.scaleDown,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        if (isDivider!) Divider(color: UIColor.tuna.withOpacity(.38), height: 16),
      ],
    );
  }
}
