import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:terapizone/core/enums/enum.dart';
import 'package:terapizone/core/utils/utilities.dart';
import 'package:terapizone/ui/controllers/controllers_consultant/controller_working_routine.dart';
import 'package:terapizone/ui/shared/decoration.dart';
import 'package:terapizone/ui/shared/uicolor.dart';
import 'package:terapizone/ui/shared/uipath.dart';
import 'package:terapizone/ui/shared/uitext.dart';
import 'package:terapizone/ui/views/view_base.dart';
import 'package:terapizone/ui/widgets/widget_buttons.dart';
import 'package:terapizone/ui/widgets/widget_state.dart';
import 'package:terapizone/ui/widgets/widget_text.dart';

class ViewWorkingRoutine extends StatelessWidget {
  final String? id;

  const ViewWorkingRoutine({Key? key, required this.id}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final c = Get.put(ControllerWorkingRoutine(id));

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
                    backgroundColor: UIColor.wildSand,
                    key: c.scaffoldKey,
                    appBar: AppBar(
                      backgroundColor: UIColor.wildSand,
                      elevation: 0,
                      automaticallyImplyLeading: false,
                      centerTitle: false,
                      title: Row(
                        children: [
                          const Spacer(),
                          TextBasic(
                            text: UIText.cWorkingRoutineTitle,
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            textAlign: TextAlign.center,
                          ),
                          const Spacer(),
                          InkWell(
                            onTap: () => id == null
                                ? c.saveWorkschedule(ApiMethod.post) //post new
                                : c.saveWorkschedule(ApiMethod.put), //update
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
    final ControllerWorkingRoutine c = Get.find();
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
            //working hours container
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
              margin: const EdgeInsets.only(top: 20),
              decoration: whiteDecoration(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getLine(
                      title: UIText.cWorkingRoutineWorkingHours,
                      value: '${c.startTime} - ${c.endTime}',
                      onTap: () async {
                        Get.bottomSheet(
                          timeIntervalPicker(),
                          isScrollControlled: true,
                        );
                      },
                      isDivider: true),
                  getLine(
                      title: UIText.cWorkingRoutineRepeat,
                      value: c.selectedDays,
                      onTap: () {
                        Get.bottomSheet(
                          dayPicker(),
                          isScrollControlled: true,
                        );
                      },
                      isDivider: false),
                ],
              ),
            ),
            //hint1 about working routine
            Padding(
              padding: const EdgeInsets.only(
                  left: 16, right: 16, top: 8, bottom: 28),
              child: TextBasic(
                text: UIText.cWorkingRoutineHint,
                color: UIColor.tuna.withOpacity(.6),
                fontSize: 13,
              ),
            ),
            if (id != null)
              GestureDetector(
                onTap: () {
                  Utilities.showDefaultDialogConfirmCancel(
                      title: UIText.textSure,
                      content: UIText.textDeleteWarning,
                      onConfirm: () => c.deleteWorkSchedule(),
                      onCancel: () => Get.back());
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
                  width: Get.width,
                  decoration: whiteDecoration(),
                  alignment: Alignment.center,
                  child: TextBasic(
                    text: UIText.cWorkingRoutineDelete,
                    fontSize: 17,
                    color: UIColor.redOrange,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  timeIntervalPicker() {
    final ControllerWorkingRoutine c = Get.find();

    return Container(
      height: Get.height / 2,
      color: UIColor.white,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: CupertinoPicker(
              key: const Key("time Picker1"),
              scrollController: FixedExtentScrollController(),
              itemExtent: 50,
              onSelectedItemChanged: (int index) {
                c.setStartTime(index);
              },
              children: List<Widget>.generate(c.timeList.length, (int index) {
                return Center(
                  child: TextBasic(
                    text: '${c.timeList[index]}',
                    fontSize: 17,
                    color: UIColor.black,
                  ),
                );
              }),
            ),
          ),
          Expanded(
            child: CupertinoPicker(
              key: const Key("time Picker2"),
              scrollController: FixedExtentScrollController(),
              itemExtent: 50,
              onSelectedItemChanged: (int index) {
                c.setEndTime(index);
              },
              children: List<Widget>.generate(c.timeList.length, (int index) {
                return Center(
                  child: Text('${c.timeList[index]}'),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  dayPicker() {
    return Container(
      height: Get.height / 2,
      color: UIColor.white,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GetBuilder<ControllerWorkingRoutine>(
        init: ControllerWorkingRoutine(id),
        builder: (ctrl) {
          return ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: ctrl.dummyDayList.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => ctrl.checkDayList(index),
                behavior: HitTestBehavior.translucent,
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextBasic(
                          text: ctrl.dummyDayList[index].name ?? '',
                          color: ctrl.dummyDayList[index].check!
                              ? UIColor.azureRadiance
                              : UIColor.black,
                          fontSize: 17,
                        ),
                        if (ctrl.dummyDayList[index].check!)
                          SvgPicture.asset(UIPath.check),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Divider(color: UIColor.tuna.withOpacity(.38), height: 0),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget getLine({
    required String title,
    required String value,
    bool isDivider = false,
    required Function() onTap,
  }) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          behavior: HitTestBehavior.translucent,
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: TextBasic(
                  text: title,
                  fontSize: 17,
                  color: UIColor.black,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                flex: 2,
                child: TextBasic(
                  text: value,
                  fontSize: 15,
                  color: UIColor.tuna.withOpacity(.6),
                  textAlign: TextAlign.right,
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
        if (isDivider)
          Divider(color: UIColor.tuna.withOpacity(.38), height: 22),
      ],
    );
  }
}
