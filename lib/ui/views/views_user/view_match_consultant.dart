import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:terapizone/ui/controllers/controllers_user/controller_match_consultant.dart';
import 'package:terapizone/ui/shared/uicolor.dart';
import 'package:terapizone/ui/shared/uitext.dart';
import 'package:terapizone/ui/views/view_base.dart';
import 'package:terapizone/ui/views/views_user/view_payment.dart';
import 'package:terapizone/ui/widgets/widget_buttons.dart';
import 'package:terapizone/ui/widgets/widget_state.dart';
import 'package:terapizone/ui/widgets/widget_text.dart';

class ViewMatchConsultant extends StatelessWidget {
  final String therapistName;
  final String imgUrl;

  const ViewMatchConsultant(
      {Key? key, required this.therapistName, required this.imgUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final c = Get.put(ControllerMatchConsultant());

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
                      leadingWidth: 65, //padding+icon width + back title
                      automaticallyImplyLeading: false,
                      leading: GetBackButton(title: UIText.back),
                      systemOverlayStyle: SystemUiOverlayStyle.dark,
                    ),
                    body: body()),
              )),
      ),
    );
  }

  Widget body() {
    final ControllerMatchConsultant c = Get.find();

    return Container(
      height: Get.height,
      width: Get.width,
      decoration: BoxDecoration(
        color: UIColor.white,
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 132,
                height: 132,
                decoration: BoxDecoration(
                  color: UIColor.chetwodeBlue.withOpacity(.15),
                  border: Border.all(
                      color: UIColor.chetwodeBlue.withOpacity(.15), width: 1),
                  shape: BoxShape.circle,
                  image: imgUrl.isNotEmpty
                      ? DecorationImage(
                          image: NetworkImage(imgUrl), fit: BoxFit.fitWidth)
                      : null,
                ),
              ),
              const SizedBox(height: 4),
              //match text
              TextBasic(
                // ignore: prefer_adjacent_string_concatenation
                text: therapistName + ' ' + UIText.matchConsultantMatch,
                fontSize: 28,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 2),
              //info texts
              getInfoTexts(),
              const SizedBox(height: 20),
              //payment plans
              getPaymentPlans(),
              const SizedBox(height: 20),
              //start therapy button
              ButtonBasic(
                buttonText: UIText.matchConsultantButton,
                bgColor: UIColor.azureRadiance,
                textColor: UIColor.white,
                onTap: () => Get.to(() => ViewPayment(
                      packageModel: c.packages[c.groupValue],
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getInfoTexts() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextBasic(
          text: UIText.matchConsultantText1,
          fontSize: 22,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 32),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 24,
              height: 24,
              child: Checkbox(
                onChanged: (bool? value) {},
                value: true,
                fillColor: MaterialStateProperty.all(UIColor.white),
                checkColor: (UIColor.black),
              ),
            ),
            Flexible(
              child: TextBasic(
                text: UIText.matchConsultantText2,
                fontSize: 17,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Checkbox(
              onChanged: (bool? value) {},
              value: true,
              fillColor: MaterialStateProperty.all(UIColor.white),
              checkColor: (UIColor.black),
            ),
            Flexible(
              child: TextBasic(
                text: UIText.matchConsultantText3,
                fontSize: 17,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget getPaymentPlans() {
    final ControllerMatchConsultant c = Get.find();

    return Column(
      children: [
        Divider(color: UIColor.tuna.withOpacity(.38), height: 32),
        GetBuilder<ControllerMatchConsultant>(
          init: ControllerMatchConsultant(),
          initState: (_) {},
          builder: (ctrl) {
            return ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: ctrl.packages.length,
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextBasic(
                                  text: ctrl.packages[index].name!,
                                  fontSize: 21,
                                  fontWeight: FontWeight.w600,
                                  textAlign: TextAlign.start,
                                ),
                                const SizedBox(height: 4),
                                TextBasic(
                                  text: ctrl.packages[index].text!,
                                  fontSize: 13,
                                  color: UIColor.tuna.withOpacity(.6),
                                  textAlign: TextAlign.start,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            flex: 4,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: TextBasic(
                                    // ignore: prefer_adjacent_string_concatenation
                                    text:
                                        '${ctrl.packages[index].weekPrice!} TL / seans',
                                    color: UIColor.tuna.withOpacity(.6),
                                    fontSize: 20,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                TextBasic(
                                  text: '${ctrl.packages[index].price!} TL',
                                  color: UIColor.tuna.withOpacity(.6),
                                  fontSize: 13,
                                  textAlign: TextAlign.end,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          Obx(() => SizedBox(
                                width: 24,
                                height: 24,
                                child: Radio(
                                    groupValue: c.groupValue,
                                    value: index,
                                    onChanged: (value) =>
                                        c.setRadioButton(value)),
                              )),
                        ],
                      ),
                      Divider(color: UIColor.tuna.withOpacity(.38), height: 32),
                    ],
                  );
                });
          },
        ),
      ],
    );
  }
}
