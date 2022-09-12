import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:terapizone/ui/shared/uicolor.dart';
import 'package:terapizone/ui/views/view_notifications.dart';
import 'package:terapizone/ui/widgets/widget_text.dart';

class NotificationMark extends StatelessWidget {
  final int notificationCount;
  const NotificationMark({Key? key, required this.notificationCount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(() => const ViewNotifications()),
      behavior: HitTestBehavior.translucent,
      child: Stack(
        children: [
          Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Icon(Icons.notifications,
                    color: (notificationCount != 0)
                        ? UIColor.redOrange
                        : UIColor.azureRadiance,
                    size: 20),
              )),
          Visibility(
            visible: notificationCount != 0 ? true : false,
            child: Positioned(
              top: 12,
              right: 10,
              child: TextBasic(
                text: notificationCount.toString(),
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: UIColor.redOrange,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
