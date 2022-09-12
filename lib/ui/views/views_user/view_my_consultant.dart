import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:terapizone/ui/controllers/controllers_user/controller_my_consultant.dart';
import 'package:terapizone/ui/shared/uicolor.dart';
import 'package:terapizone/ui/shared/uitext.dart';
import 'package:terapizone/ui/views/view_base.dart';
import 'package:terapizone/ui/views/views_user/views_change_consultant/view_change_consultant.dart';
import 'package:terapizone/ui/widgets/widget_buttons.dart';
import 'package:terapizone/ui/widgets/widget_consultant_short_info.dart';
import 'package:terapizone/ui/widgets/widget_star_rating.dart';
import 'package:terapizone/ui/widgets/widget_state.dart';
import 'package:terapizone/ui/widgets/widget_text.dart';

class ViewMyConsultant extends StatelessWidget {
  const ViewMyConsultant({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final c = Get.put(ControllerMyConsultant());

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
                  leadingWidth: 65, //padding+icon width + back title
                  automaticallyImplyLeading: false,
                  leading: GetBackButton(title: UIText.back),
                  centerTitle: true,
                  title: Row(
                    children: [
                      const Spacer(),
                      Flexible(
                        child: TextBasic(
                          text: UIText.myConsultantTitle,
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const Spacer(),
                      Flexible(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () =>
                                Get.to(() => const ViewChangeConsultant()),
                            child: TextBasic(
                              text: UIText.myConsultantChange,
                              color: UIColor.azureRadiance,
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  systemOverlayStyle: SystemUiOverlayStyle.dark,
                ),
                body: body())),
      ),
    );
  }

  Widget body() {
    ControllerMyConsultant c = Get.find();
    return Container(
      height: Get.height,
      width: Get.width,
      decoration: BoxDecoration(
        color: UIColor.white,
      ),
      child: c.myTherapist.firstName != null
          ? SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ConsultantShortInfo(
                      img: c.myTherapist.imageUrl!,
                      name:
                          '${c.myTherapist.firstName} ${c.myTherapist.lastName}',
                      specialty: c.myTherapist.title!,
                      year: '8+',
                      rating: 4.7,
                      imgSize: 200,
                      /* widgetButton: ButtonBasic(
                  buttonText: UIText.myConsultantBtn,
                  bgColor: UIColor.azureRadiance,
                  textColor: UIColor.white,
                  onTap: null,
                ), */
                      videoUrl: c.myTherapist.videoUrl!,
                    ),
                    const SizedBox(height: 20),
                    //about
                    getAbout(c.myTherapist.biography!),
                    const SizedBox(height: 20),
                    //comments
                    //getComment(), const SizedBox(height: 20),
                    //workng topics
                    //getWorkingTopics(), const SizedBox(height: 20),
                    //education
                    getEducation(c.myTherapist.education!),
                    const SizedBox(height: 20),
                    //therapy approaches
                    getTherapyApproaches(c.myTherapist.therapyApproaches!),
                  ],
                ),
              ),
            )
          : const SizedBox(),
    );
  }

  Widget getAbout(String aboutText) {
    return Column(
      children: [
        getW700S22Title(UIText.myConsultantAbout),
        const SizedBox(height: 8),
        TextBasic(
          text: aboutText,
          fontSize: 17,
        ),
      ],
    );
  }

  Widget getComment() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            getW700S22Title(UIText.myConsultantComments),
            Expanded(
              child: GestureDetector(
                onTap: () => log('see all'),
                child: TextBasic(
                  text: UIText.myConsultantSeeAll,
                  color: UIColor.azureRadiance,
                  fontSize: 17,
                  textAlign: TextAlign.right,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: UIColor.athensGray,
            borderRadius: const BorderRadius.all(Radius.circular(14)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //nickname and comment date
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TextBasic(
                    text: 'Ursula473',
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                  TextBasic(
                    text: '03/08/2021',
                    color: UIColor.tuna.withOpacity(.6),
                    fontSize: 13,
                  ),
                ],
              ),
              const SizedBox(height: 4),
              //comment rating
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  StarRating(rating: 3.5, color: UIColor.pizazz),
                ],
              ),
              const SizedBox(height: 4),
              //comment text
              const TextBasic(
                text:
                    'Görüşmelerde Psikodinamik Terapi ve Bilel Davranışçı Terapi tekniklerini kullanmaktadır.',
                fontSize: 15,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget getWorkingTopics() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getW700S22Title(UIText.meetConsultatWorkingTopics),
        const SizedBox(height: 8),
        Wrap(
          runSpacing: 8,
          children: List.generate(8, (index) => buildTag('Depresyon')),
        ),
      ],
    );
  }

  Widget getEducation(String education) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getW700S22Title(UIText.myConsultantEducation),
        const SizedBox(height: 8),
        TextBasic(
          text: education,
          fontSize: 17,
        ),
      ],
    );
  }

  Widget getTherapyApproaches(String therapyApproaches) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getW700S22Title(UIText.myConsultantApproaches),
        const SizedBox(height: 8),
        Wrap(
          runSpacing: 1,
          runAlignment: WrapAlignment.start,
          children: List.generate(1, (index) => buildTag(therapyApproaches)),
        ),
      ],
    );
  }

  Widget buildTag(String text) {
    return InkResponse(
      child: Container(
        decoration: BoxDecoration(
          color: UIColor.jumbo.withOpacity(.08),
          borderRadius: const BorderRadius.all(Radius.circular(99)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
        child: TextBasic(
          text: text,
          color: UIColor.azureRadiance,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget getW700S22Title(String title) {
    return Align(
      alignment: Alignment.topLeft,
      child: TextBasic(
        text: title,
        fontSize: 22,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
