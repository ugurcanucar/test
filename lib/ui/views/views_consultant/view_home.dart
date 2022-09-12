import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:terapizone/ui/controllers/controllers_consultant/controller_home.dart';
import 'package:terapizone/ui/controllers/controllers_consultant/controller_meetings.dart';
import 'package:terapizone/ui/shared/uicolor.dart';
import 'package:terapizone/ui/shared/uipath.dart';
import 'package:terapizone/ui/shared/uitext.dart';
import 'package:terapizone/ui/views/view_base.dart';
import 'package:terapizone/ui/widgets/widget_state.dart';

class ViewHome extends StatelessWidget {
  const ViewHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final c = Get.put(ControllerHome());

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
                bottomNavigationBar: BottomAppBar(
                  child: bottomAppBar(),
                ),
                body: body())),
      ),
    );
  }

  Widget body() {
    final ControllerHome c = Get.find();

    return Container(
      width: Get.width,
      height: Get.height,
      color: UIColor.wildSand,
      child: c.selectedView,
    );
  }

  Widget bottomAppBar() {
    final ControllerHome c = Get.find();

    return FitHomeBottomAppBar(
      selectedIndex: c.selectedIndex,
      onTapMessages: () => c.homePush(0),
      onTapMeetings: () {
        c.homePush(1);
        final cMeetings = Get.put(ControllerMeetings());
        cMeetings.getActiveAppointments();
      },
      onTapCalendar: () => c.homePush(2),
      onTapSettings: () => c.homePush(3),
    );
  }
}

class FitHomeBottomAppBar extends StatelessWidget {
  final int selectedIndex;

  final Function() onTapCalendar;
  final Function() onTapMeetings;
  final Function() onTapMessages;
  final Function() onTapSettings;

  // ignore: use_key_in_widget_constructors
  const FitHomeBottomAppBar({
    required this.selectedIndex,
    required this.onTapCalendar,
    required this.onTapMeetings,
    required this.onTapMessages,
    required this.onTapSettings,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 53,
      color: UIColor.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          selectedIndex == 0
              ? getButton(
                  path: UIPath.bottomChat,
                  text: UIText.bottomAppbarMessages,
                  onTap: () {},
                  isActive: true,
                )
              : getButton(
                  path: UIPath.bottomChat, text: UIText.bottomAppbarMessages, onTap: onTapMessages, isActive: false),
          selectedIndex == 1
              ? getButton(
                  path: UIPath.bottomVideo,
                  text: UIText.bottomAppbarMeetings,
                  onTap: () {},
                  isActive: true,
                )
              : getButton(
                  path: UIPath.bottomVideo, text: UIText.bottomAppbarMeetings, onTap: onTapMeetings, isActive: false),
          selectedIndex == 2
              ? getButton(
                  path: UIPath.bottomCalendar,
                  text: UIText.bottomAppbarCalendar,
                  onTap: () {},
                  isActive: true,
                )
              : getButton(
                  path: UIPath.bottomCalendar,
                  text: UIText.bottomAppbarCalendar,
                  onTap: onTapCalendar,
                  isActive: false),
          selectedIndex == 3
              ? getButton(
                  path: UIPath.bottomMenu,
                  text: UIText.bottomAppbarSettings,
                  onTap: () {},
                  isActive: true,
                )
              : getButton(
                  path: UIPath.bottomMenu, text: UIText.bottomAppbarSettings, onTap: onTapSettings, isActive: false),
        ],
      ),
    );
  }

  Widget getButton({
    required String path,
    required String text,
    required Function() onTap,
    required bool isActive,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.translucent,
        child: SizedBox(
          height: 60,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  path,
                  color: isActive ? UIColor.azureRadiance : UIColor.manatee,
                  width: 24,
                  height: 24,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 2),
                Text(
                  text,
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: isActive ? UIColor.azureRadiance : UIColor.manatee,
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
