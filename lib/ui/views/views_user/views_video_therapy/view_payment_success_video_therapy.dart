import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:terapizone/ui/controllers/controllers_user/controllers_video_therapy/controller_payment_success_video_therapy.dart';
import 'package:terapizone/ui/shared/uicolor.dart';
import 'package:terapizone/ui/shared/uipath.dart';
import 'package:terapizone/ui/shared/uitext.dart';
import 'package:terapizone/ui/views/views_user/views_video_therapy/view_new_appointment.dart';
import 'package:terapizone/ui/widgets/widget_buttons.dart';
import 'package:terapizone/ui/widgets/widget_text.dart';

void viewPaymentSuccessVideoTherapy(String amounInfo) {
  Get.put(ControllerPaymentSuccessVideoTherapy());
  showModalBottomSheet(
      context: Get.context!,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
      backgroundColor: UIColor.wildSand.withOpacity(.92),
      isScrollControlled: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      builder: (context) {
        return _body(amounInfo);
      });
}

Widget _body(String amounInfo) {
  return Container(
    width: double.infinity,
    color: UIColor.white,
    height: Get.height * .95,
    child: SingleChildScrollView(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AppBar(
          backgroundColor: UIColor.wildSand.withOpacity(.92),
          elevation: 0,
          leadingWidth: 90, //padding+icon width + cancel title
          automaticallyImplyLeading: false,
          centerTitle: false,
          title: Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () => Get.back(),
              child: TextBasic(
                text: UIText.paymentVideoTherapySuccessClose,
                color: UIColor.azureRadiance,
                fontSize: 17,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),
        const SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.only(top: 30, bottom: 30),
          child: SvgPicture.asset(UIPath.roundedCheck,
              width: 120, height: 70, fit: BoxFit.cover),
        ),
        Padding(
          padding:
              const EdgeInsets.only(top: 30, bottom: 30, left: 16, right: 16),
          child: TextBasic(
            text: UIText.paymentVideoTherapySuccessText,
            fontSize: 28,
            fontWeight: FontWeight.w700,
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 30, left: 16, right: 16),
          child: TextBasic(
            text: amounInfo + UIText.paymentVideoTherapySuccessSubText,
            fontSize: 22,
            textAlign: TextAlign.center,
          ),
        ),
        //new aappointment button
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: ButtonBasic(
              buttonText: UIText.paymentVideoTherapySuccessBtn,
              bgColor: UIColor.azureRadiance,
              textColor: UIColor.white,
              onTap: () {
                Get.back();
                Get.to(() => const ViewnNewAppointment());
              }),
        ),
      ],
    )),
  );
}
