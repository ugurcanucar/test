import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:terapizone/core/utils/mocks.dart';
import 'package:terapizone/ui/controllers/controllers_consultant/controller_calendar.dart';
import 'package:terapizone/ui/controllers/controllers_consultant/controller_calendar_settings.dart';
import 'package:terapizone/ui/shared/decoration.dart';
import 'package:terapizone/ui/shared/uicolor.dart';
import 'package:terapizone/ui/shared/uipath.dart';
import 'package:terapizone/ui/shared/uitext.dart';
import 'package:terapizone/ui/views/view_base.dart';
import 'package:terapizone/ui/views/views_consultant/view_routine_break.dart';
import 'package:terapizone/ui/views/views_consultant/view_working_routine.dart';
import 'package:terapizone/ui/widgets/widget_buttons.dart';
import 'package:terapizone/ui/widgets/widget_state.dart';
import 'package:terapizone/ui/widgets/widget_text.dart';

class ViewCalendarSettings extends StatelessWidget {
  const ViewCalendarSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final c = Get.put(ControllerCalendarSettings());

    return WillPopScope(
      onWillPop: () async {
        final ControllerCalendar c = Get.put(ControllerCalendar());
        c.init();
        return true;
      },
      child: ViewBase(
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
                      backgroundColor: UIColor.wildSand,
                      appBar: AppBar(
                        backgroundColor: UIColor.wildSand,
                        elevation: 0,
                        automaticallyImplyLeading: false,
                        centerTitle: true,
                        title: Row(
                          children: [
                            const Spacer(),
                            TextBasic(
                              text: UIText.cCalendarSettingsTitle,
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              textAlign: TextAlign.center,
                            ),
                            const Spacer(),
                            InkWell(
                              onTap: () => c.saveWorkscheduleSetting(),
                              child: TextBasic(
                                text: UIText.save,
                                color: UIColor.azureRadiance,
                                fontSize: 17,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                        leading: GetBackButton(
                            title: UIText.back, isCalendarSettings: true),
                        systemOverlayStyle: SystemUiOverlayStyle.dark,
                      ),
                      body: body()),
                )),
        ),
      ),
    );
  }

  Widget body() {
    final ControllerCalendarSettings c = Get.find();

    return Container(
      height: Get.height,
      width: Get.width,
      decoration: BoxDecoration(
        color: UIColor.athensGray,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //working routine title
            Padding(
              padding: const EdgeInsets.only(left: 16, bottom: 6, top: 20),
              child: TextBasic(
                text: UIText.cCalendarSettingsSubtitle1,
                color: UIColor.tuna.withOpacity(.6),
                fontSize: 13,
              ),
            ),
            //working routine container
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
              decoration: whiteDecoration(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (c.workScheduleDetail.workscheduleDayplan != null)
                    GetBuilder<ControllerCalendarSettings>(
                      init: ControllerCalendarSettings(),
                      builder: (ctrl) {
                        return getLine(
                          title: UIText.cCalendarSettingsTime,
                          rightWidget: Expanded(
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      //days
                                      TextBasic(
                                        text: Mocks.shortDayStringFromIds(ctrl
                                            .workScheduleDetail
                                            .workscheduleDayplan!
                                            .dayNumbers),
                                        fontSize: 15,
                                        color: UIColor.tuna.withOpacity(.6),
                                        textAlign: TextAlign.end,
                                      ),
                                      //time interval
                                      TextBasic(
                                        text:
                                            '${ctrl.workScheduleDetail.workscheduleDayplan!.startTime} - ${ctrl.workScheduleDetail.workscheduleDayplan!.endTime}',
                                        fontSize: 15,
                                        color: UIColor.tuna.withOpacity(.6),
                                        textAlign: TextAlign.end,
                                      ),
                                    ],
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
                          ),
                          isDivider: true,
                          onTap: () {
                            Get.to(() => ViewWorkingRoutine(
                                id: ctrl.workScheduleDetail.workscheduleId!));
                          },
                        );
                      },
                    ),
                  GestureDetector(
                    onTap: () {
                      if (c.workScheduleDetail.workscheduleDayplan != null) {
                        Get.to(() => ViewWorkingRoutine(
                            id: c.workScheduleDetail.workscheduleId!));
                      } else {
                        Get.to(() => const ViewWorkingRoutine(id: null));
                      }
                    },
                    child: SizedBox(
                      width: Get.width,
                      child: TextBasic(
                        text: UIText.cCalendarSettingsAdd,
                        fontSize: 17,
                        color: UIColor.azureRadiance,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //hint1 about working routine
            Padding(
              padding: const EdgeInsets.only(
                  left: 16, right: 16, top: 8, bottom: 28),
              child: TextBasic(
                text: UIText.cCalendarSettingsHint1,
                color: UIColor.tuna.withOpacity(.6),
                fontSize: 13,
              ),
            ),
            //routine break
            Padding(
              padding: const EdgeInsets.only(left: 16, bottom: 6),
              child: TextBasic(
                text: UIText.cCalendarSettingsSubtitle2,
                color: UIColor.tuna.withOpacity(.6),
                fontSize: 13,
              ),
            ),
            //routine break list
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
              decoration: whiteDecoration(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: c.routineBreakList.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return getLine(
                          title: '${c.routineBreakList[index].name}',
                          rightWidget: Expanded(
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      //days
                                      TextBasic(
                                        text: Mocks.shortDayStringFromIds(c
                                            .routineBreakList[index]
                                            .dayNumbers!),
                                        fontSize: 15,
                                        color: UIColor.tuna.withOpacity(.6),
                                        textAlign: TextAlign.end,
                                      ),
                                      //time interval
                                      TextBasic(
                                        text:
                                            '${c.routineBreakList[index].startTime} - ${c.routineBreakList[index].endTime}',
                                        fontSize: 15,
                                        color: UIColor.tuna.withOpacity(.6),
                                        textAlign: TextAlign.end,
                                      ),
                                    ],
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
                          ),
                          isDivider: true,
                          onTap: () => Get.to(() => ViewRoutineBreak(
                                id: c.routineBreakList[index].id,
                              )),
                        );
                      }),
                  GestureDetector(
                    onTap: () => Get.to(() => const ViewRoutineBreak(
                          id: null,
                        )),
                    child: SizedBox(
                      width: Get.width,
                      child: TextBasic(
                        text: UIText.cCalendarSettingsAdd,
                        fontSize: 17,
                        color: UIColor.azureRadiance,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //hint1 about lunch break
            Padding(
              padding: const EdgeInsets.only(
                  left: 16, right: 16, top: 8, bottom: 28),
              child: TextBasic(
                text: UIText.cCalendarSettingsHint2,
                color: UIColor.tuna.withOpacity(.6),
                fontSize: 13,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, bottom: 6),
              child: TextBasic(
                text: UIText.cCalendarSettingsSubtitle3,
                color: UIColor.tuna.withOpacity(.6),
                fontSize: 13,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
              margin: const EdgeInsets.only(bottom: 30),
              decoration: whiteDecoration(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //I work on public holidays switch
                  getLine(
                      title: UIText.cCalendarSettingsSwicthContent,
                      isLightTitle: true,
                      rightWidget: SizedBox(
                          width: 51,
                          height: 31,
                          child: CupertinoSwitch(
                              value: c.switchVal,
                              onChanged: (val) => c.setSwitchVal(val))),
                      isDivider: true,
                      onTap: () {}),
                  //How many appointments can be made in the same day?
                  getLine(
                    title: UIText.cCalendarSettingsCounter1,
                    isLightTitle: true,
                    rightWidget: Row(
                      children: [
                        GestureDetector(
                          onTap: () => c.decreaseCounter1(),
                          child: SvgPicture.asset(UIPath.decrease,
                              width: 32, height: 32),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: TextBasic(
                              text: c.counter1.toString(), fontSize: 17),
                        ),
                        GestureDetector(
                          onTap: () => c.increaseCounter1(),
                          child: SvgPicture.asset(UIPath.increase,
                              width: 32, height: 32),
                        ),
                      ],
                    ),
                    isDivider: true,
                    onTap: () {},
                  ),
                  //If the calendar is available, what time should you make an appointment at the earliest?
                  getLine(
                      title: UIText.cCalendarSettingsCounter2,
                      isLightTitle: true,
                      rightWidget: Row(
                        children: [
                          GestureDetector(
                            onTap: () => c.decreaseCounter2(),
                            child: SvgPicture.asset(UIPath.decrease,
                                width: 32, height: 32),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: TextBasic(
                                text: c.counter2.toString(), fontSize: 17),
                          ),
                          GestureDetector(
                            onTap: () => c.increaseCounter2(),
                            child: SvgPicture.asset(UIPath.increase,
                                width: 32, height: 32),
                          ),
                        ],
                      ),
                      onTap: () {}),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getLine({
    required String title,
    Widget? rightWidget,
    bool isDivider = false,
    bool isLightTitle = false,
    required Function() onTap,
  }) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Row(
            children: [
              Expanded(
                child: TextBasic(
                  text: title,
                  fontSize: isLightTitle ? 13 : 17,
                  color: isLightTitle
                      ? UIColor.tuna.withOpacity(.6)
                      : UIColor.black,
                ),
              ),
              const SizedBox(width: 8),
              if (rightWidget != null) rightWidget
            ],
          ),
        ),
        if (isDivider)
          Divider(color: UIColor.tuna.withOpacity(.38), height: 22),
      ],
    );
  }
}
