import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:terapizone/ui/controllers/controllers_consultant/controller_messages.dart';
import 'package:terapizone/ui/shared/decoration.dart';
import 'package:terapizone/ui/shared/uicolor.dart';
import 'package:terapizone/ui/shared/uipath.dart';
import 'package:terapizone/ui/shared/uitext.dart';
import 'package:terapizone/ui/views/view_base.dart';
import 'package:terapizone/ui/views/views_consultant/view_archive.dart';
import 'package:terapizone/ui/views/view_chat.dart';
import 'package:terapizone/ui/widgets/widget_message_container.dart';
import 'package:terapizone/ui/widgets/widget_notification_mark.dart';
import 'package:terapizone/ui/widgets/widget_setting_line.dart';
import 'package:terapizone/ui/widgets/widget_state.dart';
import 'package:terapizone/ui/widgets/widget_text.dart';

import '../../controllers/message_signal_controller.dart';

class ViewMessages extends StatelessWidget {
  const ViewMessages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final c = Get.put(ControllerMessages());
    final SignalRMessageController signalRMessageController = Get.put(SignalRMessageController());

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
                        text: UIText.cMessagesTitle,
                        fontSize: 34,
                        fontWeight: FontWeight.w600,
                      ),
                      actions: [
                        NotificationMark(notificationCount: c.notificationCount),
                        const SizedBox(
                          width: 12,
                        ),
                      ],
                      systemOverlayStyle: SystemUiOverlayStyle.light,
                    ),
                    body: body(signalRMessageController)),
              )),
      ),
    );
  }

  Widget body(SignalRMessageController signalRMessageController) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // messages title
          //getMessagesTitle(),
          //searchbox
          /*  Padding(
              padding: const EdgeInsets.all(16),
              child: SearchTextField(
                hint: UIText.cMessagesHint,
              )),

          //archived messages
          getArchive(),
          const SizedBox(height: 30), */
          //messages list
          getMessageList(signalRMessageController)
        ],
      ),
    );
  }

  /*  Widget getMessagesTitle() {
    return Padding(
      padding: const EdgeInsets.only(top: 30, left: 16, bottom: 8),
      child: TextBasic(
        text: UIText.cMessagesTitle,
        fontWeight: FontWeight.w700,
        fontSize: 34,
      ),
    );
  } */

  Widget getArchive() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
      decoration: wildSandDecoration(),
      child: getSetting(
          icon: UIPath.archive,
          title: UIText.cMessagesArchive,
          onTap: () => Get.to(() => const ViewArchive()),
          isDivider: false),
    );
  }

  Widget getMessageList(signalRMessageController) {
    // ControllerMessages c = Get.find();
    return GetX<SignalRMessageController>(
      init: SignalRMessageController(),
      initState: (initController) {
        initController.controller!.getChatList();
      },
      builder: (controller) {
        var list = controller.allMessages.value;
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
          decoration: whiteDecoration(),
          child: list.isNotEmpty
              ? ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    return getMessageContainer(
                        url:
                            'https://static.wixstatic.com/media/b88739_e711f50959d3412aa5c1f9490b4f85af~mv2.jpg/v1/fill/w_508,h_610,al_c,q_80,usm_0.66_1.00_0.01/b88739_e711f50959d3412aa5c1f9490b4f85af~mv2.webp',
                        senderName: list[index].title!,
                        subtitle: list[index].text!,
                        onTap: () {
                          signalRMessageController.joinRoom(list[index].messageGroupId!);
                          Get.to(() => ViewChat(
                                messageGroupId: list[index].messageGroupId,
                              ));
                        },
                        isDivider: index < list.length - 1 ? true : false,
                        number: list[index].unreadMessageCount!);
                  })
              : Center(
                  child: Column(
                  children: [
                    SvgPicture.asset(UIPath.bottomChat),
                    const SizedBox(height: 8),
                    TextBasic(
                      text: UIText.cMessagesEmpty,
                      color: UIColor.tuna.withOpacity(.6),
                      fontSize: 13,
                    ),
                  ],
                )),
        );
      },
    );
  }
}
