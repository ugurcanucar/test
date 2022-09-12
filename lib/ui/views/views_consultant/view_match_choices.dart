import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:terapizone/ui/controllers/controllers_consultant/controller_match_choices.dart';
import 'package:terapizone/ui/shared/decoration.dart';
import 'package:terapizone/ui/shared/uicolor.dart';
import 'package:terapizone/ui/shared/uipath.dart';
import 'package:terapizone/ui/shared/uitext.dart';
import 'package:terapizone/ui/views/view_base.dart';
import 'package:terapizone/ui/widgets/widget_buttons.dart';
import 'package:terapizone/ui/widgets/widget_state.dart';
import 'package:terapizone/ui/widgets/widget_text.dart';

class ViewMatchChoices extends StatelessWidget {
  const ViewMatchChoices({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final c = Get.put(ControllerMatchChoices());
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
                  backgroundColor: UIColor.wildSand,
                  elevation: 0,
                  automaticallyImplyLeading: false,
                  centerTitle: true,
                  title: Row(
                    children: [
                      const Spacer(),
                      TextBasic(
                        text: UIText.cMatchTitle,
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        textAlign: TextAlign.center,
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () => Get.back(),
                        child: TextBasic(
                          text: UIText.save,
                          color: UIColor.azureRadiance,
                          fontSize: 17,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  leading: GetBackButton(title: UIText.back),
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
        color: UIColor.athensGray,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //new client switch
            getNewClientSwitch(),
            //topic list
            getListChoices(),
            //bottom note
            Padding(
              padding: const EdgeInsets.only(
                  left: 16, right: 16, top: 8, bottom: 24),
              child: TextBasic(
                text: UIText.cMatchNote,
                color: UIColor.tuna.withOpacity(.6),
                fontSize: 13,
                textAlign: TextAlign.start,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getNewClientSwitch() {
    final ControllerMatchChoices c = Get.find();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: whiteDecoration(),
          margin: const EdgeInsets.only(top: 30),
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(UIPath.settingsMatch),
              const SizedBox(width: 18),
              Expanded(
                child: TextBasic(
                  text: UIText.cMatchNewClient,
                  fontSize: 17,
                ),
              ),
              CupertinoSwitch(
                value: c.newClientValue,
                onChanged: (bool value) => c.setNewClientValue(value),
              ),
            ],
          ),
        ),
        Padding(
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
          child: TextBasic(
            text: UIText.cMatchNewClientHint,
            color: UIColor.tuna.withOpacity(.6),
            fontSize: 13,
            textAlign: TextAlign.start,
          ),
        ),
      ],
    );
  }

  Widget getListChoices() {
    return GetBuilder<ControllerMatchChoices>(
      init: ControllerMatchChoices(),
      initState: (_) {},
      builder: (clist) {
        return ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: clist.topicList.length,
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            itemBuilder: (context, index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 16, right: 16, top: 16),
                    child: TextBasic(
                      text: clist.topicList[index].parentName ?? '',
                      color: UIColor.black,
                      fontSize: 19,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    color: UIColor.white,
                    padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: clist
                          .topicList[index].userChosenDiseaseListDtos!.length,
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemBuilder: (context, i) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 16),
                            /*   Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextBasic(
                                text: clist.topicList[index].title,
                                color: clist.topicList[index].check
                                    ? UIColor.azureRadiance
                                    : UIColor.black,
                                fontSize: 17,
                              ),
                              if (clist.topicList[index].check)
                                SvgPicture.asset(UIPath.check),
                            ],
                          ), */
                            TextBasic(
                              text: clist
                                      .topicList[index]
                                      .userChosenDiseaseListDtos![i]
                                      .diseaseName ??
                                  '',
                              color: UIColor.black,
                              fontSize: 17,
                            ),
                            const SizedBox(height: 16),
                            Divider(
                                color: UIColor.tuna.withOpacity(.38),
                                height: 0),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              );
            });
      },
    );
  }
}
