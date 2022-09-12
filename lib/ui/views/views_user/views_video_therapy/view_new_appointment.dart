import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:terapizone/core/enums/enum.dart';
import 'package:terapizone/core/services/service_chronos.dart';
import 'package:terapizone/ui/controllers/controllers_user/controllers_video_therapy/controller_new_appointment.dart';
import 'package:terapizone/ui/shared/uicolor.dart';
import 'package:terapizone/ui/shared/uipath.dart';
import 'package:terapizone/ui/shared/uitext.dart';
import 'package:terapizone/ui/views/view_base.dart';
import 'package:terapizone/ui/widgets/widget_buttons.dart';
import 'package:terapizone/ui/widgets/widget_calendar.dart';
import 'package:terapizone/ui/widgets/widget_state.dart';
import 'package:terapizone/ui/widgets/widget_text.dart';

class ViewnNewAppointment extends StatelessWidget {
  const ViewnNewAppointment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final c = Get.put(ControllerNewAppointment());

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
                  leadingWidth: 60,
                  leading: GetBackButton(title: UIText.textCancel),
                  title: TextBasic(
                    text: UIText.newAppointmentTitle,
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
    final ControllerNewAppointment c = Get.find();

    return Container(
      height: Get.height,
      width: Get.width,
      decoration: BoxDecoration(
        color: UIColor.white,
      ),
      child: Column(
        children: [
          //calendar
          Obx(() => WidgetCalendar(
              onDaySelected: (selectedDay, focusedDay) {
                c.setSelectedDay(selectedDay);
                c.setFocusedDay(focusedDay);
              },
              onPageChanged: (focusedDay) {
                c.setFocusedDay(focusedDay);
              },
              selectedDay: c.selectedDay,
              focusedDay: c.focusedDay)),
          Divider(
              color: UIColor.tuna.withOpacity(.38), height: 1, thickness: 1),
          GetBuilder<ControllerNewAppointment>(
            init: ControllerNewAppointment(),
            initState: (_) {},
            builder: (cntrl) {
              return Wrap(
                direction: Axis.horizontal,
                alignment: WrapAlignment.start,
                spacing: 0.0,
                runSpacing: 0.0,
                children: cntrl.list
                    .map(
                      (item) => AppointmentTime(
                        time: item.startTime ?? '',
                        isActive: item.availabilityStatus ==
                                AvailabilityStatus.available
                            ? true
                            : false,
                        isSelected: item.isSelected!,
                        index: c.list.indexOf(item),
                      ),
                    )
                    .toList()
                    .cast<Widget>(),
              );
            },
          ),
          //appointment button
          Obx(
            () => Visibility(
              visible: c.selectedTime.date != null ? true : false,
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
                child: ButtonBasic(
                    buttonText: UIText.newAppointmentBtn,
                    bgColor: UIColor.azureRadiance,
                    textColor: UIColor.white,
                    onTap: () => selectDialog()),
              ),
            ),
          ),
          const SizedBox(height: 28),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: TextBasic(
              text: UIText.newAppointmentInfo,
              fontSize: 15,
              color: UIColor.manatee,
            ),
          ),
        ],
      ),
    );
  }

  void selectDialog() {
    final ControllerNewAppointment c = Get.find();

    Get.dialog(AlertDialog(
        contentPadding: EdgeInsets.zero,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(14))),
        content: Container(
          height: Get.height / 5,
          width: Get.width * .8,
          decoration: BoxDecoration(
            color: UIColor.white,
            borderRadius: const BorderRadius.all(Radius.circular(14)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: TextBasic(
                  text:
                      '${ChronosService.getDateShort(c.selectedDay.toIso8601String())} \n ${c.selectedTime.startTime} - ${c.selectedTime.endTime}',
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  textAlign: TextAlign.center,
                ),
              ),
              const Spacer(),
              Divider(color: UIColor.tuna.withOpacity(.38), height: 8),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => Get.back(),
                      child: TextBasic(
                          text: UIText.textCancel,
                          color: UIColor.azureRadiance,
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          textAlign: TextAlign.center),
                    ),
                  ),
                  SizedBox(
                    height: (Get.height / 6)/3,
                    child: VerticalDivider(
                      color: UIColor.tuna.withOpacity(.38),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        Get.back();
                        await c.setAppointment();
                      },
                      child: TextBasic(
                          text: UIText.textOK,
                          color: UIColor.azureRadiance,
                          fontSize: 17,
                          textAlign: TextAlign.center),
                    ),
                  )
                ],
              )
            ],
          ),
        )));
  }
}

void successDialog() {
  Get.dialog(AlertDialog(
      contentPadding: EdgeInsets.zero,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(14))),
      content: Container(
        height: Get.height / 5,
        width: Get.width * .8,
        decoration: BoxDecoration(
          color: UIColor.white,
          borderRadius: const BorderRadius.all(Radius.circular(14)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(UIPath.roundedCheck, width: 54, height: 54),
            const SizedBox(height: 32),
            Flexible(
              child: TextBasic(
                text: UIText.newAppointmentSuccess,
                fontSize: 17,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      )));
}

class AppointmentTime extends StatelessWidget {
  final String time;
  final bool isActive;
  final bool isSelected;

  final int index;

  const AppointmentTime(
      {Key? key,
      required this.time,
      required this.isActive,
      required this.isSelected,
      required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ControllerNewAppointment c = Get.find();

    return InkWell(
      onTap: () => c.select(index),
      child: Container(
        width: (Get.width - 0) / 3,
        decoration: BoxDecoration(
          color: !isSelected ? UIColor.white : UIColor.azureRadiance,
          border: Border(
            right: BorderSide(width: 1, color: UIColor.tuna.withOpacity(.38)),
            bottom: BorderSide(width: 1, color: UIColor.tuna.withOpacity(.38)),
          ),
        ),
        height: 44,
        child: Center(
            child: TextBasic(
          text: time,
          fontSize: 18,
          color: isSelected
              ? UIColor.white
              : isActive
                  ? UIColor.black
                  : UIColor.tuna.withOpacity(.6),
        )),
      ),
    );
  }
}
