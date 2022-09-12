import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:terapizone/ui/controllers/controllers_user/controllers_video_therapy/controller_buy_video_therapy.dart';
import 'package:terapizone/ui/shared/uicolor.dart';
import 'package:terapizone/ui/shared/uipath.dart';
import 'package:terapizone/ui/shared/uitext.dart';
import 'package:terapizone/ui/views/views_user/views_video_therapy/view_payment_video_therapy.dart';
import 'package:terapizone/ui/widgets/widget_buttons.dart';
import 'package:terapizone/ui/widgets/widget_text.dart';

void viewBuyVideoTherapy() {
  // ignore: unused_local_variable
  final c = Get.put(ControllerBuyVideoTherapy());
  showModalBottomSheet(
      context: Get.context!,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
      backgroundColor: UIColor.wildSand.withOpacity(.92),
      isScrollControlled: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      builder: (context) {
        return _body();
      });
}

Widget _body() {
  final viewInsets = EdgeInsets.fromWindowPadding(
      WidgetsBinding.instance!.window.viewInsets,
      WidgetsBinding.instance!.window.devicePixelRatio);

  return AnimatedPadding(
    duration: const Duration(milliseconds: 200),
    curve: Curves.fastOutSlowIn,
    padding: EdgeInsets.only(bottom: viewInsets.bottom),
    child: Stack(
      children: [
        Container(
          width: double.infinity,
          color: UIColor.white,
          height: Get.height * .95,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    color: UIColor.wildSand.withOpacity(.92),
                    height: 10,
                    width: Get.width),
                _getAppBar(),
                //picture
                _getPicture(),
                //title
                _getVideTherapyTitle(),
                //info text
                _getSubtext(),
                //sessions options to buy
                _getOptionsToBuy(),

                const SizedBox(height: 18),
                //session info
                _getSessionInfoText(),
                const SizedBox(height: 98),
              ],
            ),
          ),
        ), //buy button
        Positioned(bottom: 32, left: 16, right: 16, child: _getBuyButton()),
      ],
    ),
  );
}

Widget _getAppBar() {
  return AppBar(
    backgroundColor: UIColor.wildSand.withOpacity(.92),
    elevation: 0,
    leadingWidth: 65,
    automaticallyImplyLeading: false,
    centerTitle: true,
    leading: Align(
      alignment: Alignment.center,
      child: GestureDetector(
        onTap: () => Get.back(),
        child: TextBasic(
          text: UIText.textCancel,
          color: UIColor.azureRadiance,
          fontSize: 17,
        ),
      ),
    ),
    title: TextBasic(
      text: UIText.terapizone,
      fontSize: 17,
      fontWeight: FontWeight.w600,
    ),
    systemOverlayStyle: SystemUiOverlayStyle.dark,
  );
}

Widget _getPicture() {
  return Padding(
    padding: const EdgeInsets.only(top: 30, bottom: 15, left: 90, right: 90),
    child: SvgPicture.asset(UIPath.videoBuy),
  );
}

Widget _getVideTherapyTitle() {
  return Padding(
    padding: const EdgeInsets.only(left: 16, top: 8, right: 16),
    child: TextBasic(
      text: UIText.buyVideoTherapyTitle,
      fontSize: 34,
      fontWeight: FontWeight.w700,
      textAlign: TextAlign.center,
    ),
  );
}

Widget _getSubtext() {
  return Padding(
    padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 40),
    child: TextBasic(
      text: UIText.terapizone,
      fontSize: 22,
      textAlign: TextAlign.center,
    ),
  );
}

Widget _getOptionsToBuy() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    child: GetBuilder<ControllerBuyVideoTherapy>(
      init: ControllerBuyVideoTherapy(),
      initState: (_) {},
      builder: (c) {
        return GridView.builder(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: (Get.width / 2),
              mainAxisExtent: 76,
              mainAxisSpacing: 16,
              crossAxisSpacing: 10,
              childAspectRatio: 1,
            ),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: c.packages.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext ctx, index) {
              return _getOption(
                  title:
                      '${c.packages[index].numberOfVideos!.toString()} seans',
                  price: '${c.packages[index].price} TL',
                  weekPrice: '${c.packages[index].weekPrice} TL / seans',
                  index: index);
            });
      },
    ),
  );
}

Widget _getOption(
    {required String title,
    required String price,
    required String weekPrice,
    required int index}) {
  final ControllerBuyVideoTherapy c = Get.find();

  return InkWell(
    onTap: () => c.setSelectedSession(index),
    child: Obx(() => Container(
          decoration: BoxDecoration(
            color: UIColor.athensGray,
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            border: c.selectedSession == index
                ? Border.all(color: UIColor.azureRadiance, width: 3)
                : Border.all(color: UIColor.athensGray, width: 3),
          ),
          padding: const EdgeInsets.all(5),
          child: Column(
            children: [
              FittedBox(
                fit: BoxFit.scaleDown,
                child: TextBasic(
                  text: weekPrice,
                  fontSize: 28,
                  textAlign: TextAlign.center,
                ),
              ),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: TextBasic(
                  text: price,
                  color: UIColor.manatee,
                  fontSize: 17,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        )),
  );
}

Widget _getSessionInfoText() {
  return TextBasic(
    text: UIText.buySubtext,
    color: UIColor.manatee,
    fontSize: 15,
    textAlign: TextAlign.center,
  );
}

Widget _getBuyButton() {
  ControllerBuyVideoTherapy c = Get.find();
  return ButtonBasic(
      buttonText: UIText.buyButton,
      bgColor: UIColor.azureRadiance,
      textColor: UIColor.white,
      onTap: () {
        Get.back();
        viewPaymentVideoTherapy(
          packageModel: c.packages[c.selectedSession],
        );
      });
}
