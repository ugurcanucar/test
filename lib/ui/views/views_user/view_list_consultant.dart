import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:terapizone/ui/controllers/controllers_user/controller_list_consultant.dart';
import 'package:terapizone/ui/shared/uicolor.dart';
import 'package:terapizone/ui/shared/uitext.dart';
import 'package:terapizone/ui/views/view_base.dart';
import 'package:terapizone/ui/views/views_user/view_meet_consultant.dart';
import 'package:terapizone/ui/widgets/widget_buttons.dart';
import 'package:terapizone/ui/widgets/widget_consultant_short_info.dart';
import 'package:terapizone/ui/widgets/widget_state.dart';
import 'package:terapizone/ui/widgets/widget_text.dart';

class ViewListConsultant extends StatelessWidget {
  final bool isFromRegister;
  const ViewListConsultant({Key? key, required this.isFromRegister})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final c = Get.put(ControllerListConsultant());

    return ViewBase(
      statusbarBrightness: SystemUiOverlayStyle.light,
      child: Container(
        height: Get.size.height,
        width: Get.size.width,
        alignment: Alignment.center,
        color: UIColor.wildSand.withOpacity(.92),
        child: Obx(() => c.busy
            ? const ActivityIndicatorListConsultant()
            : Scaffold(
                key: c.scaffoldKey,
                backgroundColor: UIColor.wildSand.withOpacity(.92),
                appBar: AppBar(
                  backgroundColor: UIColor.wildSand.withOpacity(.92),
                  elevation: 0,
                  leadingWidth: 31, //padding+icon width
                  automaticallyImplyLeading: false,
                  leading: const GetBackButton(),
                  centerTitle: true,
                  title: TextBasic(
                    text: UIText.terapizone,
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    textAlign: TextAlign.center,
                  ),
                  systemOverlayStyle: SystemUiOverlayStyle.dark,
                ),
                body: body())),
      ),
    );
  }

  Widget body() {
    final ControllerListConsultant c = Get.find();

    return Container(
      height: Get.height,
      width: Get.width,
      decoration: BoxDecoration(
        color: UIColor.white,
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //title
              TextBasic(
                text: UIText.listConsultantTitle,
                fontSize: 28,
                fontWeight: FontWeight.w700,
                textAlign: TextAlign.center,
              ),
              //subtitle
              TextBasic(
                text: UIText.listConsultantSubTitle,
                color: UIColor.tuna.withOpacity(.6),
                fontSize: 20,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              //consultant list
              ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: c.list.length,
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: InkWell(
                        onTap: () => Get.to(
                          () => ViewMeetConsultant(
                            id: c.list[index].therapistId,
                            isFromRegister: isFromRegister,
                          ),
                        ),
                        child: getConsultant(
                          c.list[index].therapistId ?? '',
                          img: c.list[index].imageUrl ?? '-',
                          name: c.list[index].firstName! +
                              ' ' +
                              c.list[index].lastName!,
                          specialty: c.list[index].title ?? '-',
                          year: '8+',
                          rating: 4.7,
                          imgSize: 120,
                          aboutText: c.list[index].biography ?? '-',
                          videoUrl: c.list[index].videoUrl ?? '',
                        ),
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }

  Widget getConsultant(String therapistId,
      {required String img,
      required String name,
      required String specialty,
      required String year,
      required double rating,
      required double imgSize,
      required String aboutText,
      required String videoUrl}) {
    final ControllerListConsultant c = Get.find();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: UIColor.white,
        border: Border.all(color: UIColor.tuna.withOpacity(.33), width: 1),
      ),
      child: Column(
        children: [
          ConsultantShortInfo(
            img: img,
            name: name,
            specialty: specialty,
            year: year,
            rating: rating,
            imgSize: imgSize,
            videoUrl: videoUrl,
          ),
          const SizedBox(height: 10),

          //match button
          ButtonBasic(
            buttonText: UIText.listConsultantButton,
            bgColor: UIColor.azureRadiance,
            textColor: UIColor.white,
            onTap: () => c.addClientTherapistPreference(therapistId, name, img,
                isFromRegister: isFromRegister),
          ),
          const SizedBox(height: 10),

          getAbout(aboutText),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget getAbout(String text) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextBasic(
          text: UIText.listConsultantAbout,
          fontSize: 22,
          fontWeight: FontWeight.w700,
        ),
        const SizedBox(height: 8),
        TextBasic(
          text: text,
          fontSize: 17,
          maxLines: 4,
        ),
        const SizedBox(height: 8),
        Align(
          alignment: Alignment.center,
          child: TextBasic(
            text: UIText.listConsultantRead,
            color: UIColor.azureRadiance,
            fontSize: 17,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
