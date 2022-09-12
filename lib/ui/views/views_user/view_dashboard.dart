import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:terapizone/core/services/service_chronos.dart';
import 'package:terapizone/core/utils/utilities.dart';
import 'package:terapizone/ui/controllers/controllers_user/controller_dashboard.dart';
import 'package:terapizone/ui/controllers/message_signal_controller.dart';
import 'package:terapizone/ui/shared/decoration.dart';
import 'package:terapizone/ui/shared/uicolor.dart';
import 'package:terapizone/ui/shared/uipath.dart';
import 'package:terapizone/ui/shared/uitext.dart';
import 'package:terapizone/ui/views/view_base.dart';
import 'package:terapizone/ui/views/view_chat.dart';
import 'package:terapizone/ui/views/views_user/view_settings.dart';
import 'package:terapizone/ui/views/views_user/views_video_therapy/view_new_appointment.dart';
import 'package:terapizone/ui/views/views_user/views_video_therapy/view_video_therapy.dart';
import 'package:terapizone/ui/widgets/widget_notification_mark.dart';
import 'package:terapizone/ui/widgets/widget_state.dart';
import 'package:terapizone/ui/widgets/widget_text.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:terapizone/core/services/extensions.dart';

import '../view_video_call.dart';

class ViewDashboard extends StatelessWidget {
  const ViewDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final c = Get.put(ControllerDashboard());
    final SignalRMessageController signalRMessageController =
        Get.put(SignalRMessageController());
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
                    appBar: AppBar(
                      backgroundColor: UIColor.wildSand,
                      elevation: 0,
                      leadingWidth: 90, //padding+icon width + cancel title
                      automaticallyImplyLeading: false,
                      centerTitle: false,
                      title: TextBasic(
                        text: UIText.terapizone,
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                      actions: [
                        NotificationMark(
                            notificationCount: c.notificationCount),
                        const SizedBox(
                          width: 12,
                        ),
                        GestureDetector(
                          onTap: () => Get.to(() => const ViewSettings()),
                          behavior: HitTestBehavior.translucent,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                                padding: const EdgeInsets.only(right: 16),
                                child: SvgPicture.asset(UIPath.menu)),
                          ),
                        ),
                      ],
                      systemOverlayStyle: SystemUiOverlayStyle.light,
                    ),
                    body: body(context, signalRMessageController)),
              )),
      ),
    );
  }

  Widget body(context, SignalRMessageController signalRMessageController) {
    ControllerDashboard c = Get.find();

    return Container(
      width: double.infinity,
      color: UIColor.alabaster,
      height: Get.height * .95,
      child: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(color: UIColor.tuna.withOpacity(.38), height: 1),
          //my messages title
          getMessagesTitle(),
          //message container
          if (c.list.isNotEmpty) getMessageContainer(signalRMessageController),

          //my meetings title
          getMeetingsTitle(),
          //meetings container
          getMeetingsContainer(),
          //symptom tracker chart

          Visibility(visible: false, child: getChartContainer()),
        ],
      )),
    );
  }

  Widget getMessagesTitle() {
    return Padding(
      padding: const EdgeInsets.only(top: 30, left: 16, bottom: 8),
      child: TextBasic(
        text: UIText.dashboardMessages,
        fontSize: 20,
        fontWeight: FontWeight.w700,
        textAlign: TextAlign.left,
      ),
    );
  }

  Widget getMessageContainer(
      SignalRMessageController signalRMessageController) {
    return Container(
      //padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: alabasterDecoration(),
      child: GetBuilder<ControllerDashboard>(
        init: ControllerDashboard(),
        initState: (_) {},
        builder: (c) {
          final SignalRMessageController controller = Get.find();
          return ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: c.list.length,
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    controller.joinRoom(c.list[index].messageGroupId!);
                    Get.to(() => ViewChat(
                          messageGroupId: c.list[index].messageGroupId,
                        ));
                  },
                  behavior: HitTestBehavior.translucent,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                        child: Row(
                          children: [
                            //sender picture
                            Container(
                              width: 39,
                              height: 39,
                              decoration: BoxDecoration(
                                color: UIColor.alabaster,
                                border: Border.all(
                                    color:
                                        UIColor.chetwodeBlue.withOpacity(.15),
                                    width: 1),
                                shape: BoxShape.circle,
                                /*  image: const DecorationImage(
                              image: NetworkImage(
                                  'https://static.wixstatic.com/media/b88739_e711f50959d3412aa5c1f9490b4f85af~mv2.jpg/v1/fill/w_508,h_610,al_c,q_80,usm_0.66_1.00_0.01/b88739_e711f50959d3412aa5c1f9490b4f85af~mv2.webp'),
                              fit: BoxFit.fitWidth), */
                              ),
                              child: Center(
                                child: TextBasic(
                                  text: c.list[index].title!.length > 1
                                      ? c.list[index].title!.substring(0, 1)
                                      : '',
                                  color: UIColor.black,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w400,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  //sender name
                                  TextBasic(
                                    text: c.list[index].title!,
                                    fontSize: 17,
                                    textAlign: TextAlign.left,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  //sender message text
                                  TextBasic(
                                    text: c.list[index].text!,
                                    fontSize: 13,
                                    color: UIColor.tuna.withOpacity(.6),
                                    textAlign: TextAlign.left,
                                    maxLines: 2,
                                  ),
                                ],
                              ),
                            ),
                            Visibility(
                              visible: c.list[index].unreadMessageCount != 0
                                  ? true
                                  : false,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Container(
                                  width: 24,
                                  height: 24,
                                  decoration: BoxDecoration(
                                    color: UIColor.azureRadiance,
                                    shape: BoxShape.circle,
                                  ),
                                  alignment: Alignment.center,
                                  child: TextBasic(
                                    text: c.list[index].unreadMessageCount
                                        .toString(),
                                    fontSize: 17,
                                    color: UIColor.white,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
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
                      if (c.list.length - 1 > index)
                        Divider(
                            color: UIColor.tuna.withOpacity(.38), height: 20),
                    ],
                  ),
                );
              });
        },
      ),
    );
  }

  Widget getMeetingsTitle() {
    return Padding(
      padding: const EdgeInsets.only(top: 30, left: 16, bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            child: TextBasic(
              text: UIText.dashboardMeetings,
              fontSize: 20,
              fontWeight: FontWeight.w700,
              textAlign: TextAlign.left,
            ),
          ),
          GestureDetector(
            onTap: () => Get.to(() => const ViewVideoTherapy()),
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: TextBasic(
                text: UIText.dashboardSeeAll,
                color: UIColor.azureRadiance,
                fontSize: 17,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getMeetingsContainer() {
    ControllerDashboard c = Get.find();
    return Container(
      decoration: whiteDecoration(),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          //no upcoming meetings text
          if (c.activeAppointments.isEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: TextBasic(
                text: UIText.dashboardNoUpcomingsMeeting,
                color: UIColor.tuna.withOpacity(.6),
                fontSize: 13,
                textAlign: TextAlign.center,
              ),
            ),
          //create meeting button
          GestureDetector(
            onTap: () => Get.to(() => const ViewnNewAppointment()),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.add_circle_outline_rounded,
                  color: UIColor.azureRadiance,
                  size: 22,
                ),
                const SizedBox(width: 8),
                TextBasic(
                  text: UIText.dashboardNewMeeting,
                  color: UIColor.azureRadiance,
                  fontSize: 13,
                  textAlign: TextAlign.center,
                ),
              ],
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
                          await c.joinAppointment(
                              c.activeAppointments[index].id ?? '');
                          // Get.to(() => const ViewVideoCall2());
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

  Widget getChartContainer() {
    return Container(
      decoration: const BoxDecoration(),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      width: Get.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: TextBasic(
                    text: UIText.dashboardSymptomTracker,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    textAlign: TextAlign.left,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: TextBasic(
                    text: UIText.dashboardSeeAll,
                    color: UIColor.azureRadiance,
                    fontSize: 17,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          CarouselSlider(
            options: CarouselOptions(
                autoPlay: false, aspectRatio: 1.2, viewportFraction: 1),
            items: ['Deprasyon 1', 'Deprasyon 2']
                .map((item) => BarChartSymptomTracker(title: item))
                .toList(),
          ),
        ],
      ),
    );
  }
}

class BarChartSymptomTracker extends StatefulWidget {
  final String title;

  const BarChartSymptomTracker({Key? key, required this.title})
      : super(key: key);
  @override
  State<StatefulWidget> createState() => BarChartSymptomTrackerState();
}

class BarChartSymptomTrackerState extends State<BarChartSymptomTracker> {
  final Color barBackgroundColor = UIColor.azureRadiance.withOpacity(.8);
  final Duration animDuration = const Duration(milliseconds: 250);

  int touchedIndex = -1;

  bool isPlaying = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      elevation: 1,
      color: UIColor.white,
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                TextBasic(
                  text: widget.title,
                  color: UIColor.tuna.withOpacity(.6),
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
                const SizedBox(height: 32),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: BarChart(
                      mainBarData(),
                      swapAnimationDuration: animDuration,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }

  BarChartGroupData makeGroupData(
    int x,
    double y, {
    bool isTouched = false,
    Color barColor = const Color(0xFFAFD5FF),
    double width = 15,
    List<int> showTooltips = const [],
  }) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          y: isTouched ? y + 1 : y,
          colors: isTouched ? [Colors.yellow] : [barColor],
          width: width,
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            y: 20,
            colors: [barBackgroundColor],
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  List<BarChartGroupData> showingGroups() => List.generate(6, (i) {
        switch (i) {
          case 0:
            return makeGroupData(0, 56, isTouched: i == touchedIndex);
          case 1:
            return makeGroupData(1, 70, isTouched: i == touchedIndex);
          case 2:
            return makeGroupData(2, 65, isTouched: i == touchedIndex);
          case 3:
            return makeGroupData(3, 68, isTouched: i == touchedIndex);
          case 4:
            return makeGroupData(4, 62, isTouched: i == touchedIndex);
          case 5:
            return makeGroupData(5, 55, isTouched: i == touchedIndex);
          default:
            return throw Error();
        }
      });

  BarChartData mainBarData() {
    return BarChartData(
      alignment: BarChartAlignment.spaceBetween,
      gridData: FlGridData(show: true, horizontalInterval: 5),
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Colors.blueGrey,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              String weekDay;
              switch (group.x.toInt()) {
                case 0:
                  weekDay = '01/03';
                  break;
                case 1:
                  weekDay = '01/03';
                  break;
                case 2:
                  weekDay = '01/03';
                  break;
                case 3:
                  weekDay = '01/03';
                  break;
                case 4:
                  weekDay = '01/03';
                  break;
                case 5:
                  weekDay = '01/03';
                  break;
                case 6:
                  weekDay = '01/03';
                  break;
                default:
                  throw Error();
              }
              return BarTooltipItem(
                weekDay + '\n',
                const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: (rod.y - 1).toString(),
                    style: const TextStyle(
                      color: Colors.yellow,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              );
            }),
        touchCallback: (flTouchEvent, barTouchResponse) {
          setState(() {
            if (barTouchResponse != null &&
                barTouchResponse.spot != null &&
                barTouchResponse.spot is! PointerUpEvent &&
                barTouchResponse.spot is! PointerExitEvent) {
              touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
            } else {
              touchedIndex = -1;
            }
          });
        },
      ),
      minY: 45,
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value, doublee) => TextStyle(
              color: UIColor.tuna.withOpacity(.6),
              fontWeight: FontWeight.bold,
              fontSize: 14),
          margin: 8,
          getTitles: (double value) {
            switch (value.toInt()) {
              case 0:
                return '01/03';
              case 1:
                return '08/03';
              case 2:
                return '08/03';
              case 3:
                return '08/03';
              case 4:
                return '08/03';
              case 5:
                return '09/04';
              default:
                return '';
            }
          },
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value, doublee) => TextStyle(
            color: UIColor.tuna.withOpacity(.6),
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
          margin: 16,
          reservedSize: 40,
          getTitles: (value) {
            if (value == 50) {
              return 'Yok';
            } else if (value == 55) {
              return 'Hafif';
            } else if (value == 60) {
              return 'Orta';
            } else if (value == 70) {
              return 'Şiddetli';
            } else {
              return '';
            }
          },
        ),
        rightTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value, doublee) => TextStyle(
            color: UIColor.tuna.withOpacity(.6),
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
          margin: 16,
          reservedSize: 20,
          getTitles: (value) {
            if (value == 50) {
              return '50';
            } else if (value == 55) {
              return '55';
            } else if (value == 60) {
              return '60';
            } else if (value == 70) {
              return '70';
            } else {
              return '';
            }
          },
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(),
    );
  }
}
