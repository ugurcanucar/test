import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:terapizone/core/services/service_chronos.dart';
import 'package:terapizone/ui/controllers/controllers_user/controller_past_appointments.dart';
import 'package:terapizone/ui/shared/decoration.dart';
import 'package:terapizone/ui/shared/uicolor.dart';
import 'package:terapizone/ui/shared/uipath.dart';
import 'package:terapizone/ui/shared/uitext.dart';
import 'package:terapizone/ui/views/view_base.dart';
import 'package:terapizone/ui/widgets/widget_buttons.dart';
import 'package:terapizone/ui/widgets/widget_state.dart';
import 'package:terapizone/ui/widgets/widget_text.dart';

class ViewPastAppointments extends StatelessWidget {
  const ViewPastAppointments({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final c = Get.put(ControllerPastAppointments());

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
                    text: UIText.pastAppointmentsTitle,
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
          //past appointments list
          getPastAppointmentsList(),
        ]),
      ),
    );
  }

  Widget getPastAppointmentsList() {
    final ControllerPastAppointments c = Get.find();

    return Container(
      decoration: whiteDecoration(),
      width: Get.width,
      margin: const EdgeInsets.only(top: 30),
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Column(
        children: [
          //no past appointment warning
          if (c.pastAppointments.isEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 19, bottom: 19),
              child: TextBasic(
                text: UIText.pastAppointmentsNote,
                color: UIColor.tuna.withOpacity(.6),
                fontSize: 13,
              ),
            ),
          //past list
          if (c.pastAppointments.isNotEmpty)
            Divider(color: UIColor.tuna.withOpacity(.38), height: 16),

          Padding(
            padding: const EdgeInsets.only(bottom: 8, top: 8),
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: c.pastAppointments.length,
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemBuilder: (context, index) {
                  return getLine(
                      prefixIcon: UIPath.check,
                      title:
                          '${ChronosService.getDateLong(c.pastAppointments[index].date!.toIso8601String())} , ${c.pastAppointments[index].startTime}',
                      //'26.08.2021, Çarşamba, 11:00',
                      subtitle:
                          '${c.pastAppointments[index].firstName} ${c.pastAppointments[index].lastName}',
                      iconColor: UIColor.azureRadiance,
                      isDivider: index != 2 ? true : false,
                      onTap: () {},
                      suffixIcon: UIPath.pen);
                }),
          ),
        ],
      ),
    );
  }

  Widget getLine({
    String? prefixIcon,
    required String title,
    String? subtitle,
    Color? iconColor,
    required Function() onTap,
    bool? isDivider = false,
    String? suffixIcon,
  }) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          behavior: HitTestBehavior.translucent,
          child: Row(
            children: [
              if (prefixIcon != null)
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: SvgPicture.asset(
                    prefixIcon,
                    color: iconColor ?? UIColor.tuna.withOpacity(.6),
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
              if (suffixIcon != null)
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: SvgPicture.asset(
                    suffixIcon,
                    color: iconColor ?? UIColor.tuna.withOpacity(.6),
                    width: 24,
                    height: 24,
                    fit: BoxFit.scaleDown,
                  ),
                ),
            ],
          ),
        ),
        if (isDivider!)
          Divider(color: UIColor.tuna.withOpacity(.38), height: 16),
      ],
    );
  }
}
