import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:terapizone/ui/controllers/controllers_user/controller_select_gender.dart';
import 'package:terapizone/ui/shared/uicolor.dart';
import 'package:terapizone/ui/shared/uipath.dart';
import 'package:terapizone/ui/shared/uitext.dart';
import 'package:terapizone/ui/views/view_base.dart';
import 'package:terapizone/ui/widgets/widget_buttons.dart';
import 'package:terapizone/ui/widgets/widget_state.dart';
import 'package:terapizone/ui/widgets/widget_text.dart';

class ViewSelectGender extends StatelessWidget {
  final Function() onTap;

  final c = Get.put(ControllerSelectGender());

  ViewSelectGender({Key? key, required this.onTap}) : super(key: key);

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
    return Container(
      height: Get.height,
      width: Get.width,
      decoration: BoxDecoration(
        color: UIColor.wildSand.withOpacity(.92),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),
                //title
                TextBasic(
                  text: UIText.selectGenderTitle,
                  fontSize: 28,
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Container(
                color: UIColor.white,
                padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
                child: GetBuilder<ControllerSelectGender>(
                  init: ControllerSelectGender(),
                  builder: (ctrl) {
                    final data = ctrl.genderList;
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () => ctrl.checkGenderList(index),
                          child: Column(
                            children: [
                              const SizedBox(height: 16),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextBasic(
                                    text: data[index].name!,
                                    color: data[index].check!
                                        ? UIColor.azureRadiance
                                        : UIColor.black,
                                    fontSize: 17,
                                  ),
                                  if (data[index].check!)
                                    SvgPicture.asset(UIPath.check),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Divider(
                                  color: UIColor.tuna.withOpacity(.38),
                                  height: 0),
                            ],
                          ),
                        );
                      },
                    );
                  },
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ButtonBasic(
              buttonText: UIText.selectTopicButton,
              bgColor: UIColor.azureRadiance,
              textColor: UIColor.white,
              onTap: () async => await c.addUserFirstPreference(
                  onTap), // if post user First Preferences is successfull then open next view in onTap functon
            ),
          ),
        ],
      ),
    );
  }
}
