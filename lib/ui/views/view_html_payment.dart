import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:terapizone/ui/controllers/controllers_user/controller_html_payment.dart';
import 'package:terapizone/ui/shared/uicolor.dart';
import 'package:terapizone/ui/views/view_base.dart';
import 'package:terapizone/ui/widgets/widget_buttons.dart';
import 'package:terapizone/ui/widgets/widget_state.dart';
import 'package:webviewx/webviewx.dart';

class ViewHtmlPayment extends StatelessWidget {
  final String html;

  const ViewHtmlPayment({Key? key, required this.html}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final c = Get.put(ControllerHtmlPayment());
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
                    ),
                    body: body()),
              )),
      ),
    );
  }

  Widget body() {
    ControllerHtmlPayment c = Get.find();
    return SizedBox(
      height: Get.height,
      width: Get.width,
      child: SingleChildScrollView(
        child: WebViewX(
          initialContent: html,
          initialSourceType: SourceType.html,
          height: Get.height,
          width: Get.width,
          onWebViewCreated: (controller) => c.webviewController = controller,
          onPageFinished: (String result) {
            c.onPageFinished();
          },
        ),
      ),
    );
  }
}
