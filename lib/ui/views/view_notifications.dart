import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:terapizone/core/utils/mocks.dart';
import 'package:terapizone/ui/controllers/controller_notifications.dart';
import 'package:terapizone/ui/shared/decoration.dart';
import 'package:terapizone/ui/shared/uicolor.dart';
import 'package:terapizone/ui/shared/uitext.dart';
import 'package:terapizone/ui/views/view_base.dart';
import 'package:terapizone/ui/widgets/widget_buttons.dart';
import 'package:terapizone/ui/widgets/widget_state.dart';
import 'package:terapizone/ui/widgets/widget_text.dart';

class ViewNotifications extends StatelessWidget {
  const ViewNotifications({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final c = Get.put(ControllerNotifications());
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
                appBar: AppBar(
                  backgroundColor: UIColor.wildSand.withOpacity(.92),
                  elevation: 0,
                  automaticallyImplyLeading: false,
                  centerTitle: true,
                  title: TextBasic(
                    text: UIText.notificationsTitle,
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    textAlign: TextAlign.center,
                  ),
                  leading: GetBackButton(title: UIText.back),
                  systemOverlayStyle: SystemUiOverlayStyle.dark,
                ),
                body: body())),
      ),
    );
  }

  Widget body() {
    final ControllerNotifications c = Get.find();

    return Container(
      height: Get.height,
      width: Get.width,
      decoration: BoxDecoration(
        color: UIColor.athensGray,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        width: Get.width,
        decoration: whiteDecoration(),
        alignment: Alignment.center,
        child: RefreshIndicator(
          onRefresh: () async {
            await c.getNotifications();
          },
          child: c.notifications.isNotEmpty
              ? ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: c.notifications.length,
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return getLine(
                      text: c.notifications[index].message!,
                      date: c.notifications[index].createDate!,
                      isRead: c.notifications[index].isRead!,
                    );
                  })
              : TextBasic(
                  text: UIText.notificationsNotFound,
                  fontSize: 17,
                  textAlign: TextAlign.center,
                ),
        ),
      ),
    );
  }

  Widget getLine({
    required String text,
    required bool isRead,
    required String date,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (!isRead)
              Padding(
                padding: const EdgeInsets.only(right: 6.0),
                child: Icon(
                  Icons.circle_rounded,
                  color: UIColor.redOrange,
                  size: 12,
                ),
              ),
            Expanded(
              child: TextBasic(
                text: text,
                fontSize: 17,
                color: UIColor.black,
                textAlign: TextAlign.left,
              ),
            ),
          ],
        ),
        if (date.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 6.0),
            child: TextBasic(
              text: Mocks.timeAgo(date),
              color: UIColor.tuna.withOpacity(.6),
              fontSize: 13,
            ),
          ),
        Divider(color: UIColor.tuna.withOpacity(.38), height: 16),
      ],
    );
  }
}
