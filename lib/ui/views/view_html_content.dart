import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:terapizone/ui/controllers/controller_html_content.dart';
import 'package:terapizone/ui/shared/uicolor.dart';
import 'package:terapizone/ui/views/view_base.dart';
import 'package:terapizone/ui/widgets/widget_buttons.dart';
import 'package:terapizone/ui/widgets/widget_state.dart';
import 'package:terapizone/ui/widgets/widget_text.dart';

class ViewHtmlContent extends StatelessWidget {
  final String contentKey;

  const ViewHtmlContent({Key? key, required this.contentKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final c = Get.put(ControllerHtmlContent(contentkey: contentKey));

    return ViewBase(
      statusbarBrightness: SystemUiOverlayStyle.dark,
      child: Container(
        height: Get.size.height,
        width: Get.size.width,
        alignment: Alignment.center,
        color: UIColor.white,
        child: Obx(() => c.busy
            ? const ActivityIndicator()
            : SafeArea(
                child: Scaffold(
                    key: c.scaffoldKey,
                    backgroundColor: UIColor.white,
                    appBar: AppBar(
                      backgroundColor: UIColor.white,
                      elevation: 0,
                      leadingWidth: 40,
                      leading: const Padding(
                        padding: EdgeInsets.only(left: 16),
                        child: GetBackButton(),
                      ),
                      systemOverlayStyle: SystemUiOverlayStyle.dark,
                      centerTitle: true,
                      title: TextBasic(
                        text: c.content.contentTitle!,
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        textAlign: TextAlign.left,
                        color: UIColor.azureRadiance,
                      ),
                    ),
                    body: body()),
              )),
      ),
    );
  }

  Widget body() {
    ControllerHtmlContent c = Get.find();
    return SizedBox(
      height: Get.height,
      width: Get.width,
      child: c.content.contentText != null
          ? SingleChildScrollView(
              child: Html(
                data: c.content.contentText,
                onLinkTap: (url, _, __, ___) {},
              ),
            )
          : null,
    );
  }
}
