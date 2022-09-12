import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:terapizone/ui/controllers/controllers_consultant/controller_client_profile.dart';
import 'package:terapizone/ui/shared/decoration.dart';
import 'package:terapizone/ui/shared/uicolor.dart';
import 'package:terapizone/ui/shared/uipath.dart';
import 'package:terapizone/ui/shared/uitext.dart';
import 'package:terapizone/ui/views/view_base.dart';
import 'package:terapizone/ui/widgets/widget_buttons.dart';
import 'package:terapizone/ui/widgets/widget_setting_line.dart';
import 'package:terapizone/ui/widgets/widget_state.dart';
import 'package:terapizone/ui/widgets/widget_text.dart';

class ViewClientProfile extends StatelessWidget {
  final String id;
  final String name;

  const ViewClientProfile({Key? key, required this.id, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    log(id);
    final c = Get.put(ControllerClientProfile(id));

    return ViewBase(
      statusbarBrightness: SystemUiOverlayStyle.light,
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
                  centerTitle: true,
                  title: Row(
                    children: [
                      const Spacer(),
                      InkWell(
                        onTap: () {},
                        child: TextBasic(
                          text: UIText.save,
                          color: UIColor.azureRadiance,
                          fontSize: 17,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  leadingWidth: 120, //padding+icon width + back title
                  automaticallyImplyLeading: false,

                  leading: GetBackButton(title: UIText.cClientProfileLeading),
                  systemOverlayStyle: SystemUiOverlayStyle.dark,
                ),
                body: body(c, context))),
      ),
    );
  }

  String formatDate({required String date, String mask = "dd MMMM yyyy"}) {
    return DateFormat(mask, "tr-TR").format(
      DateTime.parse(date.split("+")[0]),
    );
  }

  Widget body(ControllerClientProfile controller, BuildContext context) {
    return Container(
      height: Get.height,
      width: Get.width,
      decoration: BoxDecoration(
        color: UIColor.athensGray,
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //client picture and name

              getProfileImgAndName(),

              //test scores

              getTestScores(),

              const SizedBox(height: 20),

              dayFrequency(controller),

              //about
              //getAbout(),
              //reasons
              //getReasons(),
              const SizedBox(height: 20),

              Align(
                alignment: Alignment.topLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //reason title
                    Padding(
                      padding: const EdgeInsets.only(top: 8, left: 16, bottom: 8),
                      child: TextBasic(
                        text: "Paket Bitiş Tarihi",
                        color: UIColor.tuna.withOpacity(.6),
                        fontSize: 13,
                      ),
                    ),
                    //test results

                    Container(
                      padding: const EdgeInsets.only(top: 11, left: 16, right: 16, bottom: 11),
                      decoration: whiteDecoration(),
                      child: Row(
                        children: [
                          TextBasic(
                              text: "Kullanıcının paket bitiş tarihi",
                              fontSize: 13,
                              color: UIColor.tuna.withOpacity(.6)),
                          const Spacer(),
                          InkWell(
                            onTap: () async {
                              final date =
                                  DateTime.parse(controller.clientAppointmentRequestModel.value.defaultPackageEndDate!);
                              DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: date,
                                firstDate: date.subtract(const Duration(days: 30)),
                                //DateTime.now() - not to allow to choose before today.
                                lastDate: date.add(
                                  const Duration(days: 30),
                                ),
                                builder: (context, child) {
                                  return Theme(
                                    data: Theme.of(context).copyWith(
                                      colorScheme: ColorScheme.light(
                                        primary: UIColor.tuna,
                                        onPrimary: Colors.white,
                                        onSurface: UIColor.tuna,
                                      ),
                                      textButtonTheme: TextButtonThemeData(
                                        style: TextButton.styleFrom(
                                          primary: UIColor.tuna,
                                        ),
                                      ),
                                    ),
                                    child: child!,
                                  );
                                },
                              );

                              if (pickedDate != null) {
                                await showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        content: Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                SizedBox(
                                                  height: Get.height * .03,
                                                ),
                                                TextBasic(
                                                  text:
                                                      "Kullanıcının paket bitiş tarihini değiştirmek istediğinize emin misiniz ?",
                                                  color: UIColor.tuna.withOpacity(.6),
                                                )
                                              ],
                                            ),
                                            Positioned(
                                              right: 0,
                                              top: 0,
                                              child: GestureDetector(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },
                                                child: const Icon(
                                                  Icons.close,
                                                  size: 15,
                                                  color: Colors.black54,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            child: Text(
                                              "Vazgeç",
                                              style: TextStyle(color: UIColor.tuna),
                                            ),
                                            onPressed: () => Navigator.of(context).pop(),
                                          ),
                                          TextButton(
                                              child: const Text(
                                                "Kaydet",
                                              ),
                                              onPressed: () async {
                                                controller.clientAppointmentRequestModel.value.packageEndDate =
                                                    pickedDate.toIso8601String();
                                                await controller.updateAppointmentSetting();
                                                Navigator.pop(context);
                                              }),
                                        ],
                                      );
                                    });
                              }
                            },
                            child: TextBasic(
                              text: "Değiştir",
                              color: UIColor.azureRadiance,
                              fontSize: 17,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              //appointments
              /*  getAppointment(
                apIcon: UIPath.clientProfileNotes,
                apText: UIText.cClientProfileNotes,
                onTap: () {
                  Get.to(() => const ViewNotes());
                },
              ),
              getAppointment(
                  apIcon: UIPath.settingsCalendar,
                  apText: UIText.cClientProfileSessions,
                  onTap: () {}),
              getAppointment(
                  apIcon: UIPath.clientProfileTargets,
                  apText: UIText.cClientProfileTargets,
                  onTap: () {}), */
            ],
          ),
        ),
      ),
    );
  }

  Align dayFrequency(ControllerClientProfile controller) {
    return Align(
      alignment: Alignment.topLeft,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //reason title
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 16, bottom: 8),
            child: TextBasic(
              text: "Randevu Gün Aralığı",
              color: UIColor.tuna.withOpacity(.6),
              fontSize: 13,
            ),
          ),
          //test results

          GetX<ControllerClientProfile>(
            init: ControllerClientProfile(id),
            initState: (_) {},
            builder: (buildController) {
              return Container(
                padding: const EdgeInsets.only(top: 11, left: 16, right: 16, bottom: 11),
                decoration: whiteDecoration(),
                child: Row(
                  children: [
                    TextBasic(
                        text: "Kullanıcının randevu gün aralığı", fontSize: 13, color: UIColor.tuna.withOpacity(.6)),
                    const Spacer(),
                    buildController.isLoading.value
                        ? const CircularProgressIndicator()
                        : Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  buildController.decreaseFrequency();
                                },
                                child: SvgPicture.asset(UIPath.decrease, width: 32, height: 32),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: TextBasic(
                                    text: buildController.clientAppointmentRequestModel.value.dayFrequency.toString(),
                                    fontSize: 17),
                              ),
                              GestureDetector(
                                onTap: () {
                                  log("tıkladı $id");
                                  buildController.increaseFrequency();
                                },
                                child: SvgPicture.asset(UIPath.increase, width: 32, height: 32),
                              ),
                            ],
                          ),
                  ],
                ),
              );
            },
          )
        ],
      ),
    );
  }

  Widget getProfileImgAndName() {
    return Align(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //picture
          /* Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: UIColor.chetwodeBlue.withOpacity(.15),
              border: Border.all(
                  color: UIColor.chetwodeBlue.withOpacity(.15), width: 1),
              shape: BoxShape.circle,
              image: const DecorationImage(
                  image: NetworkImage(
                      'https://static.wixstatic.com/media/b88739_e711f50959d3412aa5c1f9490b4f85af~mv2.jpg/v1/fill/w_508,h_610,al_c,q_80,usm_0.66_1.00_0.01/b88739_e711f50959d3412aa5c1f9490b4f85af~mv2.webp'),
                  fit: BoxFit.fitWidth), 
            ),
          ),
          const SizedBox(height: 4), */
          //client name
          TextBasic(
            text: name,
            fontSize: 28,
          ),
        ],
      ),
    );
  }

  Widget getTestScores() {
    ControllerClientProfile c = Get.find();
    //TODO

    return Align(
      alignment: Alignment.topLeft,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //reason title
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 16, bottom: 8),
            child: TextBasic(
              text: UIText.cClientProfileTestScores,
              color: UIColor.tuna.withOpacity(.6),
              fontSize: 13,
            ),
          ),
          //test results

          Container(
            padding: const EdgeInsets.only(top: 11, left: 16, right: 16, bottom: 11),
            decoration: whiteDecoration(),
            child: c.list.isNotEmpty
                ? ListView.builder(
                    shrinkWrap: true,
                    itemCount: c.list.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //test name
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: TextBasic(
                              text: c.list[index].testName!.toUpperCase(),
                              color: UIColor.tuna.withOpacity(.6),
                              fontSize: 13,
                            ),
                          ),
                          //test results
                          ListView.builder(
                              shrinkWrap: true,
                              itemCount: c.list[index].questionCategories?.length,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, ind) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(left: 8.0),
                                              child: Icon(Icons.circle, size: 8, color: UIColor.tuna),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                              child: TextBasic(
                                                text: c.list[index].questionCategories?[ind].categoryName ?? "",
                                                color: UIColor.tuna,
                                                fontSize: 13,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                        //name
                                        //score
                                        TextBasic(
                                          text: c.list[index].questionCategories?[ind].scoreText ?? "",
                                          color: UIColor.tuna,
                                          fontSize: 15,
                                        ),
                                      ],
                                    ),
                                    c.list[index].questionCategories?[ind].scoreDescription == null
                                        ? SizedBox()
                                        : Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                            child: TextBasic(
                                              text:
                                                  "Açıklama: ${c.list[index].questionCategories?[ind].scoreDescription} ",
                                              color: UIColor.tuna,
                                              fontSize: 13,
                                            ),
                                          ),
                                  ],
                                );
                              }),
                          Divider(color: UIColor.tuna.withOpacity(.38), height: 22),
                        ],
                      );
                    },
                  )
                : Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: Icon(Icons.find_in_page_sharp, size: 24),
                      ),
                      Expanded(
                        child: TextBasic(
                          text: UIText.cClientProfileTestScoresNotFound,
                          color: UIColor.tuna,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
          )
        ],
      ),
    );
  }

  Widget getAbout() {
    return Align(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //about
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 16, bottom: 8),
            child: TextBasic(
              text: UIText.cClientProfileAbout,
              color: UIColor.tuna.withOpacity(.6),
              fontSize: 13,
            ),
          ),
          //about container
          Container(
            padding: const EdgeInsets.only(top: 11, left: 16, right: 16, bottom: 11),
            decoration: whiteDecoration(),
            child: Column(
              children: [
                getLine(title: UIText.cClientProfileAge, value: '23', isDivider: true),
                getLine(title: UIText.cClientProfileSex, value: 'Erkek', isDivider: true),
                getLine(title: UIText.cClientProfileStartDate, value: '13/02/2021', isDivider: false),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget getReasons() {
    return Align(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //reason title
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 16, bottom: 8),
            child: TextBasic(
              text: UIText.cClientProfileReason,
              color: UIColor.tuna.withOpacity(.6),
              fontSize: 13,
            ),
          ),
          //reasons container
          Container(
            padding: const EdgeInsets.only(top: 11, left: 16, right: 16, bottom: 11),
            decoration: whiteDecoration(),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: 3,
              itemBuilder: (context, index) {
                return getLine(title: 'Depresyon / Mutsuzluk', isDivider: index == 2 ? false : true);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget getAppointment({required String apIcon, required String apText, required dynamic Function() onTap}) {
    return Container(
      padding: const EdgeInsets.only(top: 7, left: 16, right: 16, bottom: 7),
      decoration: whiteDecoration(),
      child: getSetting(
        icon: apIcon,
        title: apText,
        onTap: onTap,
      ),
    );
  }

  Widget getLine({required String title, String? value, bool? isDivider = false}) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextBasic(
              text: title,
              fontSize: 17,
            ),
            if (value != null)
              TextBasic(
                text: value,
                color: UIColor.tuna.withOpacity(.6),
                fontSize: 17,
              ),
          ],
        ),
        if (isDivider!) Divider(color: UIColor.tuna.withOpacity(.38), height: 22),
      ],
    );
  }
}
