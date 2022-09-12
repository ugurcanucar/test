import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:terapizone/ui/controllers/controllers_consultant/controller_security.dart';
import 'package:terapizone/ui/shared/decoration.dart';
import 'package:terapizone/ui/shared/uicolor.dart';
import 'package:terapizone/ui/shared/uipath.dart';
import 'package:terapizone/ui/shared/uitext.dart';
import 'package:terapizone/ui/views/view_base.dart';
import 'package:terapizone/ui/views/views_consultant/view_change_password.dart';
import 'package:terapizone/ui/widgets/widget_buttons.dart';
import 'package:terapizone/ui/widgets/widget_state.dart';
import 'package:terapizone/ui/widgets/widget_text.dart';

class ViewSecurity extends StatelessWidget {
  const ViewSecurity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final c = Get.put(ControllerSecurity());

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
                    appBar: AppBar(
                      backgroundColor: UIColor.wildSand.withOpacity(.92),
                      elevation: 0,
                      automaticallyImplyLeading: false,
                      centerTitle: false,
                      title: Row(
                        children: [
                          const Spacer(),
                          TextBasic(
                            text: UIText.cSecurityTitle,
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
                    body: body()),
              )),
      ),
    );
  }

  Widget body() {
    //final ControllerSecurity c = Get.find();

    return Container(
      height: Get.height,
      width: Get.width,
      decoration: BoxDecoration(
        color: UIColor.athensGray,
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: whiteDecoration(),
              padding: const EdgeInsets.only(left: 16, right: 16),
              margin: const EdgeInsets.only(top: 50),
              child: getLine(
                  leftIcon: UIPath.securityChangePswrd,
                  title: UIText.cSecurityChangePswrd,
                  subtitle: UIText.cSecurityChangePswrdHint,
                  onTap: () =>
                      Get.to(() => const ViewChangePasswordConsultant())),
            ),
             /*
            Container(
              decoration: whiteDecoration(),
              padding: const EdgeInsets.only(left: 16, right: 16),
              margin: const EdgeInsets.only(top: 50, bottom: 30),
              child: Column(
                children: [
                  getLine(
                      leftIcon: UIPath.securityLocker,
                      title: UIText.cSecurityAppPswrd,
                      subtitle: UIText.cSecurityAppPswrdHint,
                      onTap: () {},
                      rightIcon: SizedBox(
                          width: 51,
                          height: 31,
                          child: CupertinoSwitch(
                              value: c.appPswrd,
                              onChanged: (value) => c.setAppPswrd(value))),
                      isDivider: true),
                    getLine(
                      leftIcon: UIPath.securityFaceId,
                      title: UIText.cSecurityFaceId,
                      onTap: () {},
                      rightIcon: SizedBox(
                          width: 51,
                          height: 31,
                          child: CupertinoSwitch(
                              value: c.faceId,
                              onChanged: (value) => c.setFaceId(value))),
                      isDivider: true),
                  getLine(
                    leftIcon: UIPath.securityChangePswrd,
                    title: UIText.cSecurityChangeAppPswrd,
                    onTap: () {}, 
                  ),
                ],
              ),
            ),*/
          ],
        ),
      ),
    );
  }

  Widget getLine(
      {required String leftIcon,
      required String title,
      String? subtitle,
      required Function() onTap,
      Widget? rightIcon,
      bool? isDivider = false}) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.translucent,
      child: Row(
        children: [
          SvgPicture.asset(
            leftIcon,
            width: 29,
            height: 29,
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                          ),
                      ],
                    ),
                    if (rightIcon == null)
                      SvgPicture.asset(
                        UIPath.right,
                        width: 10,
                        height: 24,
                        fit: BoxFit.scaleDown,
                      )
                    else
                      rightIcon
                  ],
                ),
                const SizedBox(height: 10),
                if (isDivider!)
                  Divider(color: UIColor.tuna.withOpacity(.38), height: 1),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
