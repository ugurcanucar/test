import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:terapizone/core/enums/enum.dart';
import 'package:terapizone/core/utils/utilities.dart';
import 'package:terapizone/ui/controllers/controllers_consultant/controller_calendar.dart';
import 'package:terapizone/ui/models/availability_list_therapist_model.dart';
import 'package:terapizone/ui/shared/decoration.dart';
import 'package:terapizone/ui/shared/uicolor.dart';
import 'package:terapizone/ui/shared/uipath.dart';
import 'package:terapizone/ui/shared/uitext.dart';
import 'package:terapizone/ui/views/view_base.dart';
import 'package:terapizone/ui/widgets/widget_calendar.dart';
import 'package:terapizone/ui/widgets/widget_state.dart';
import 'package:terapizone/ui/widgets/widget_text.dart';

class ViewCalendar extends StatelessWidget {
  const ViewCalendar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final c = Get.put(ControllerCalendar());
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
                body: body())),
      ),
    );
  }

  Widget body() {
    final ControllerCalendar c = Get.find();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
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
          color: UIColor.tuna.withOpacity(
            .33,
          ),
          height: 16,
        ),
        //all day switch
        Container(
            decoration: whiteDecoration(),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            margin: const EdgeInsets.only(top: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 28.0),
                  child: TextBasic(
                    text: UIText.cCalenderMeetingHoursAllDay,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: UIColor.black,
                  ),
                ),
                SizedBox(
                  width: 51,
                  height: 31,
                  child: Obx(() => CupertinoSwitch(
                        value: c.allDaySwitch,
                        onChanged: (bool value) {
                          c.setAppointmentAllDay(value);
                        },
                      )),
                ),
              ],
            )),
        Expanded(
          child: GetBuilder<ControllerCalendar>(
            init: ControllerCalendar(),
            builder: (c) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: c.list.length,
                itemBuilder: (
                  context,
                  index,
                ) {
                  return _meetingTimes(
                      index: index,
                      availabilityStatus: c.list[index].availabilityStatus!,
                      timeText: c.list[index].startTime ?? '',
                      appointment: c.list[index].availabilityStatus! ==
                              AvailabilityStatus.appointment
                          ? c.list[index].appointment!
                          : null,
                      isDivider: index >= c.list.length - 1 ? false : true);
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _meetingTimes({
    required int index,
    required AvailabilityStatus availabilityStatus,
    required String timeText,
    bool isDivider = true,
    AppointmentModel? appointment,
  }) {
    final ControllerCalendar c = Get.find();
    return Container(
      width: Get.size.width,
      decoration: BoxDecoration(color: UIColor.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (index == 0) const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                appointment != null
                    ? SvgPicture.asset(
                      UIPath.check,
                      width: 20,
                      color: UIColor.tuna.withOpacity(0.6),
                    )
                    : const SizedBox(
                        width: 20,
                      ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: TextBasic(
                    text: timeText,
                    fontSize: 17,
                    fontWeight:
                        availabilityStatus == AvailabilityStatus.available
                            ? FontWeight.bold
                            : FontWeight.w400,
                    color: availabilityStatus == AvailabilityStatus.available
                        ? UIColor.black
                        : UIColor.tuna.withOpacity(.6),
                  ),
                ),
                if (appointment != null)
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: TextBasic(
                      text: appointment.clientNickName ?? '',
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: UIColor.black,
                    ),
                  ),
                const Spacer(),
                appointment != null
                    ? GestureDetector(
                        onTap: () => Utilities.showDefaultDialogConfirmCancel(
                            title: UIText.textSure,
                            content: UIText.textCancelAppointmentWarning,
                            onConfirm: () async {
                              Get.back();
                              await c.cancelAppointment(appointment);
                            },
                            onCancel: () => Get.back()),
                        child: SizedBox(
                          width: 51,
                          height: 31,
                          child: TextBasic(
                            text: UIText.cCalenderCancel,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: UIColor.redOrange,
                          ),
                        ),
                      )
                    : SizedBox(
                        width: 51,
                        height: 31,
                        child: CupertinoSwitch(
                          value:
                              availabilityStatus == AvailabilityStatus.available
                                  ? true
                                  : false,
                          onChanged: (bool value) {
                            c.setAppointment(index);
                          },
                        ),
                      )
              ],
            ),
          ),
          (isDivider)
              ? Divider(
                  color: UIColor.tuna.withOpacity(
                    .33,
                  ),
                  height: 16,
                )
              : const SizedBox(height: 9),
        ],
      ),
    );
  }
}
