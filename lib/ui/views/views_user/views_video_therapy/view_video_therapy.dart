import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:terapizone/core/services/service_chronos.dart';
import 'package:terapizone/core/utils/utilities.dart';
import 'package:terapizone/ui/controllers/controllers_user/controllers_video_therapy/controller_video_therapy.dart';
import 'package:terapizone/ui/shared/decoration.dart';
import 'package:terapizone/ui/shared/uicolor.dart';
import 'package:terapizone/ui/shared/uipath.dart';
import 'package:terapizone/ui/shared/uitext.dart';
import 'package:terapizone/ui/views/view_base.dart';
import 'package:terapizone/ui/views/views_user/view_past_appointments.dart';
import 'package:terapizone/ui/views/views_user/views_video_therapy/view_new_appointment.dart';
import 'package:terapizone/ui/widgets/widget_buttons.dart';
import 'package:terapizone/ui/widgets/widget_state.dart';
import 'package:terapizone/ui/widgets/widget_text.dart';
import 'package:terapizone/core/services/extensions.dart';

class ViewVideoTherapy extends StatelessWidget {
  const ViewVideoTherapy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final c = Get.put(ControllerVideoTherapy());

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
                  leadingWidth: 23,
                  leading: const GetBackButton(),
                  title: TextBasic(
                    text: UIText.videoTherapyTitle,
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
    return Container(
      height: Get.height,
      width: Get.width,
      decoration: BoxDecoration(
        color: UIColor.mercury,
      ),
      child: SingleChildScrollView(
        child: Column(children: [
          //upcoming appointments title
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 30, bottom: 8),
            child: Align(
              alignment: Alignment.centerLeft,
              child: TextBasic(
                text: UIText.videoTherapyAppointments,
                color: UIColor.tuna.withOpacity(.6),
                fontSize: 13,
              ),
            ),
          ),
          //upcoming appointments list & new appointment button
          getUpcomingAppointments(),
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 8, bottom: 8),
            child: Align(
              alignment: Alignment.centerLeft,
              child: TextBasic(
                text: UIText.videoTherapyAppointmentsNote,
                color: UIColor.tuna.withOpacity(.6),
                fontSize: 13,
              ),
            ),
          ),
          //past appointments title button
          getPastAppointments(),
        ]),
      ),
    );
  }

/*   Container getRemainingSessions() {
    return Container(
      decoration: whiteDecoration(),
      margin: const EdgeInsets.only(top: 30),
      padding: const EdgeInsets.only(top: 10, left: 16, right: 16, bottom: 10),
      child: Column(
        children: [
          /* getLine(
              title: UIText.videoTherapySession,
              onTap: () {},
              text: '0 Adet',
              isDivider: true), */ //TODO:servis bekleniyor
        /*   getLine(
            title: UIText.videoTherapyBuy,
            onTap: () => viewBuyVideoTherapy(),
          ) */
        ],
      ),
    );
  } */

  Widget getPastAppointments() {
    return Container(
        decoration: whiteDecoration(),
        width: Get.width,
        margin: const EdgeInsets.only(top: 30),
        padding:
            const EdgeInsets.only(top: 11, left: 16, right: 16, bottom: 11),
        child: GestureDetector(
          onTap: () => Get.to(() => const ViewPastAppointments()),
          child: Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    SvgPicture.asset(
                      UIPath.pastAppointments,
                      width: 10,
                      height: 24,
                      fit: BoxFit.scaleDown,
                    ),
                    const SizedBox(width: 8),
                    TextBasic(
                      text: UIText.videoTherapyPastAppointments,
                      fontSize: 17,
                    ),
                  ],
                ),
              ),
              SvgPicture.asset(
                UIPath.right,
                width: 10,
                height: 24,
                fit: BoxFit.scaleDown,
              ),
            ],
          ),
        ));
  }

  Widget getUpcomingAppointments() {
    final ControllerVideoTherapy c = Get.find();

    return Container(
      decoration: whiteDecoration(),
      width: Get.width,
      padding: const EdgeInsets.only(/* top: 19,  */ left: 16, right: 16),
      child: Column(
        children: [
          //no appointment warning
          if (c.activeAppointments.isEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 19, bottom: 8),
              child: TextBasic(
                text: UIText.videoTherapyNoAppointments,
                color: UIColor.tuna.withOpacity(.6),
                fontSize: 13,
              ),
            ),
          //create new appointment
          TextButton(
            onPressed: () => Get.to(() => const ViewnNewAppointment()),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.add_circle_outline_rounded,
                  color: UIColor.azureRadiance,
                  size: 22,
                ),
                const SizedBox(width: 8),
                TextBasic(
                  text: UIText.videoTherapyNewAppointments,
                  color: UIColor.azureRadiance,
                  fontSize: 17,
                ),
              ],
            ),
          ),
          //upcoming list
          Divider(color: UIColor.tuna.withOpacity(.38), height: 1),

          Padding(
            padding: const EdgeInsets.only(bottom: 8, top: 8),
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: c.activeAppointments.length,
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemBuilder: (context, index) {
                  bool isSameDay = DateCompare(DateTime.now())
                      .isSameDate(c.activeAppointments[index].date!);
                  String dateText = isSameDay
                      ? UIText.videoTherapyToday
                      : ChronosService.getDateLong(
                          c.activeAppointments[index].date!.toIso8601String());
                  return getLine(
                      icon: UIPath.check,
                      title:
                          '$dateText, ${c.activeAppointments[index].startTime}',
                      subtitle:
                          '${c.activeAppointments[index].therapistFirstName} ${c.activeAppointments[index].therapistLastName}',
                      text: (DateCompare(DateTime.now())
                              .isSameDate(c.activeAppointments[index].date!))
                          ? UIText.videoTherapyJoin
                          : UIText.videoTherapyCancel,
                      textColor:
                          isSameDay ? UIColor.azureRadiance : UIColor.redOrange,
                      onTap: () async {
                        if (!isSameDay) {
                          Utilities.showCancelAppointmentDialog(
                              onConfirm: () async {
                                Get.back();
                                await c.cancelAppointment(
                                    c.activeAppointments[index]);
                              },
                              onCancel: () => Get.back());
                        } else {
                          await c
                              .joinAppointment(c.activeAppointments[index].id!);
                        }
                      });
                }),
          ),
        ],
      ),
    );
  }

  Widget getLine({
    String? icon,
    required String title,
    String? subtitle,
    String? text,
    Color? textColor,
    required Function() onTap,
    bool? isDivider = true,
  }) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          behavior: HitTestBehavior.translucent,
          child: Row(
            children: [
              if (icon != null)
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: SvgPicture.asset(
                    icon,
                    color: UIColor.tuna.withOpacity(.6),
                    width: 24,
                    height: 24,
                    fit: BoxFit.scaleDown,
                  ),
                ),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (text != null)
                    TextBasic(
                      text: text,
                      color: textColor ?? UIColor.tuna.withOpacity(.6),
                      fontSize: 17,
                    ),
                  const SizedBox(width: 8),
                  SvgPicture.asset(
                    UIPath.right,
                    color: textColor ?? UIColor.tuna.withOpacity(.6),
                    width: 10,
                    height: 24,
                    fit: BoxFit.scaleDown,
                  ),
                ],
              )
            ],
          ),
        ),
        if (isDivider!)
          Divider(color: UIColor.tuna.withOpacity(.38), height: 16),
      ],
    );
  }
}
