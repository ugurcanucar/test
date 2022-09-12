import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:terapizone/ui/controllers/controllers_consultant/controller_archive.dart';
import 'package:terapizone/ui/shared/decoration.dart';
import 'package:terapizone/ui/shared/uicolor.dart';
import 'package:terapizone/ui/shared/uitext.dart';
import 'package:terapizone/ui/views/view_base.dart';
import 'package:terapizone/ui/views/view_chat.dart';
import 'package:terapizone/ui/widgets/widget_buttons.dart';
import 'package:terapizone/ui/widgets/widget_message_container.dart';
import 'package:terapizone/ui/widgets/widget_state.dart';
import 'package:terapizone/ui/widgets/widget_text.dart';

class ViewArchive extends StatelessWidget {
  const ViewArchive({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final c = Get.put(ControllerArchive());
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
            : SafeArea(
                child: Scaffold(
                    key: _scaffoldKey,
                    backgroundColor: UIColor.wildSand,
                    appBar: AppBar(
                      backgroundColor: UIColor.wildSand,
                      elevation: 0,
                      leadingWidth: 30,
                      automaticallyImplyLeading: false,
                      leading: const GetBackButton(),
                      centerTitle: true,
                      title: TextBasic(
                        text: UIText.cMessagesArchive,
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                      systemOverlayStyle: SystemUiOverlayStyle.light,
                    ),
                    body: body()),
              )),
      ),
    );
  }

  Widget body() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //messages list
          getMessageList(),
        ],
      ),
    );
  }

  Widget getMessageList() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
      decoration: whiteDecoration(),
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: 5,
          itemBuilder: (context, index) {
            return getMessageContainer(
                url:
                    'https://static.wixstatic.com/media/b88739_e711f50959d3412aa5c1f9490b4f85af~mv2.jpg/v1/fill/w_508,h_610,al_c,q_80,usm_0.66_1.00_0.01/b88739_e711f50959d3412aa5c1f9490b4f85af~mv2.webp',
                senderName: 'Ursula',
                subtitle:
                    'Hello, Here’s some feedback Here’s some feedback..Here’s some feedback ',
                onTap: () => Get.to(() => const ViewChat(messageGroupId: null,)),
                isDivider: index < 4 ? true : false,
                number: index == 1 ? 4 : 0);
          }),
    );
  }
}
