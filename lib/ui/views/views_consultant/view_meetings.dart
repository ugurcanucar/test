import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:terapizone/core/services/service_chronos.dart';
import 'package:terapizone/core/utils/utilities.dart';
import 'package:terapizone/ui/controllers/controllers_consultant/controller_meetings.dart';
import 'package:terapizone/ui/shared/uicolor.dart';
import 'package:terapizone/ui/shared/uipath.dart';
import 'package:terapizone/ui/shared/uitext.dart';
import 'package:terapizone/ui/views/view_base.dart';
import 'package:terapizone/ui/widgets/widget_state.dart';
import 'package:terapizone/ui/widgets/widget_text.dart';
import 'package:terapizone/core/services/extensions.dart';

class ViewMeetings extends StatelessWidget {
  const ViewMeetings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final c = Get.put(ControllerMeetings());

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
                    body: body()),
              )),
      ),
    );
  }

  Widget body() {
    ControllerMeetings c = Get.find();
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // meetings title
            getMeetingsTitle(),
            if (c.activeAppointments.isEmpty)
              Divider(color: UIColor.tuna.withOpacity(.38), height: 16),

            //no upcoming meetings text
            if (c.activeAppointments.isEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 8, top: 8),
                child: TextBasic(
                  text: UIText.dashboardNoUpcomingsMeeting,
                  color: UIColor.tuna.withOpacity(.6),
                  fontSize: 13,
                  textAlign: TextAlign.center,
                ),
              ),
            Divider(color: UIColor.tuna.withOpacity(.38), height: 16),

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
                        : ChronosService.getDateLong(c
                            .activeAppointments[index].date!
                            .toIso8601String());
                    return getLine(
                        icon: UIPath.check,
                        title:
                            '$dateText, ${c.activeAppointments[index].startTime}',
                        subtitle:
                            '${c.activeAppointments[index].clientNickName}',
                        text: (DateCompare(DateTime.now())
                                .isSameDate(c.activeAppointments[index].date!))
                            ? UIText.videoTherapyJoin
                            : UIText.videoTherapyCancel,
                        textColor: isSameDay
                            ? UIColor.azureRadiance
                            : UIColor.redOrange,
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
                            await c.joinAppointment(
                                c.activeAppointments[index].id ?? '');

                            // Get.to(() => const ViewVideoCall2());
                          }
                        });
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Widget getMeetingsTitle() {
    return Padding(
      padding: const EdgeInsets.only(top: 30, left: 16, bottom: 8),
      child: TextBasic(
        text: UIText.cMeetingsTitle,
        fontWeight: FontWeight.w700,
        fontSize: 34,
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
