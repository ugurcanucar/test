import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:terapizone/core/utils/content_keys.dart';
import 'package:terapizone/ui/controllers/controllers_user/controller_external_help.dart';
import 'package:terapizone/ui/shared/uicolor.dart';
import 'package:terapizone/ui/shared/uitext.dart';
import 'package:terapizone/ui/views/view_base.dart';
import 'package:terapizone/ui/views/view_html_content.dart';
import 'package:terapizone/ui/widgets/widget_buttons.dart';
import 'package:terapizone/ui/widgets/widget_state.dart';
import 'package:terapizone/ui/widgets/widget_text.dart';

class ViewExternalHelp extends StatelessWidget {
  final Function() onTap;
  final bool isFromRegister;

  ViewExternalHelp(
      {Key? key, required this.onTap, required this.isFromRegister})
      : super(key: key);
  final c = Get.put(ControllerExternalHelp());

  @override
  Widget build(BuildContext context) {
    return ViewBase(
      statusbarBrightness: SystemUiOverlayStyle.dark,
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
                  leadingWidth: 31, //padding+icon width
                  automaticallyImplyLeading: false,
                  leading: const GetBackButton(),
                  systemOverlayStyle: SystemUiOverlayStyle.dark,
                ),
                body: body())),
      ),
    );
  }

  Widget body() {
    return Stack(
      children: [
        Container(
          height: Get.height,
          width: Get.width,
          decoration: BoxDecoration(
            color: UIColor.wildSand.withOpacity(.92),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //title
                      TextBasic(
                        text: UIText.externalHelpTitle,
                        fontSize: 21,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                    color: UIColor.white,
                    padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
                    child: GetBuilder<ControllerExternalHelp>(
                      init: ControllerExternalHelp(),
                      builder: (ctrl) {
                        final data = ctrl.list;
                        return ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: data.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 16),
                                Row(
                                  children: [
                                    const Icon(Icons.lens, size: 8),
                                    const SizedBox(width: 6),
                                    Expanded(
                                      child: TextBasic(
                                        text: data[index],
                                        color: UIColor.black,
                                        fontSize: 17,
                                        textAlign: TextAlign.left,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                                if (index < data.length - 1)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 16.0),
                                    child: Divider(
                                        color: UIColor.tuna.withOpacity(.38),
                                        height: 0),
                                  ),
                              ],
                            );
                          },
                        );
                      },
                    )),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: RichTextBasic(textAlign: TextAlign.left, texts: [
                    TextSpan(
                      text: UIText.externalHelpWarning1,
                      style: TextStyle(
                        color: UIColor.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    TextSpan(
                      text: UIText.externalHelpWarning2,
                      style: TextStyle(
                        color: UIColor.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => Get.to(() => ViewHtmlContent(
                            contentKey: ContentKey.externalHelp)),
                    ),
                  ]),
                ),
                Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Obx(
                      () => CheckboxListTile(
                        value: c.checkboxValue,
                        controlAffinity: ListTileControlAffinity.leading,
                        onChanged: (value) => c.setCheckBox(value),
                        contentPadding: EdgeInsets.zero,
                        checkColor: UIColor.white,
                        selectedTileColor: UIColor.azureRadiance,
                        title: TextBasic(
                          text: UIText.externalHelpApproveText,
                          color: UIColor.black,
                          fontSize: 17,
                          textAlign: TextAlign.left,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    )),
                const SizedBox(height: 98),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 32,
          left: 16,
          right: 16,
          child: ButtonBasic(
            buttonText: UIText.externalHelpButton,
            bgColor: UIColor.azureRadiance,
            textColor: UIColor.white,
            onTap: () async => isFromRegister
                ? await c.addUserFirstPreference(onTap)
                : Get.back(),
          ),
        ),
      ],
    );
  }
}
