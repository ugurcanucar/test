import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:terapizone/ui/controllers/controllers_user/controller_payment_success.dart';
import 'package:terapizone/ui/shared/uicolor.dart';
import 'package:terapizone/ui/shared/uipath.dart';
import 'package:terapizone/ui/shared/uitext.dart';
import 'package:terapizone/ui/views/view_base.dart';
import 'package:terapizone/ui/views/views_user/view_dashboard.dart';
import 'package:terapizone/ui/widgets/widget_buttons.dart';
import 'package:terapizone/ui/widgets/widget_state.dart';
import 'package:terapizone/ui/widgets/widget_text.dart';

class ViewPaymentSuccess extends StatelessWidget {
  const ViewPaymentSuccess({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final c = Get.put(ControllerPaymentSuccess());

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
                  leadingWidth: 90, //padding+icon width + cancel title
                  automaticallyImplyLeading: false,
                  centerTitle: true,
                  title: TextBasic(
                    text: UIText.terapizone,
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                  actions: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () => Get.to(() => const ViewDashboard()),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: TextBasic(
                            text: UIText.paymentSuccessClose,
                            color: UIColor.azureRadiance,
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ),
                  ],
                  systemOverlayStyle: SystemUiOverlayStyle.dark,
                ),
                body: body())),
      ),
    );
  }

  Widget body() {
    return Container(
      width: double.infinity,
      color: UIColor.wildSand.withOpacity(.92),
      height: Get.height * .95,
      child: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Divider(color: UIColor.tuna.withOpacity(.38), height: 16),
            const SizedBox(height: 30),
            SvgPicture.asset(UIPath.roundedCheck,
                width: 120, height: 70, fit: BoxFit.cover),
            const SizedBox(height: 30),
            TextBasic(
              text: UIText.paymentSuccessText,
              fontSize: 28,
              fontWeight: FontWeight.w700,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            TextBasic(
              text: UIText.paymentSuccessSubText,
              color: UIColor.azureRadiance,
              fontSize: 22,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            //send message button
            ButtonBasic(
                buttonText: UIText.paymentSuccessBtn,
                bgColor: UIColor.azureRadiance,
                textColor: UIColor.white,
                onTap: () => Get.to(() => const ViewDashboard())),
          ],
        ),
      )),
    );
  }
}
