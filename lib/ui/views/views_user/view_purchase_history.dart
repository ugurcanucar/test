import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:terapizone/ui/controllers/controllers_user/controller_purchase_history.dart';
import 'package:terapizone/ui/shared/decoration.dart';
import 'package:terapizone/ui/shared/uicolor.dart';
import 'package:terapizone/ui/shared/uipath.dart';
import 'package:terapizone/ui/shared/uitext.dart';
import 'package:terapizone/ui/widgets/widget_buttons.dart';
import 'package:terapizone/ui/widgets/widget_text.dart';

void viewPurchaseHistory() {
  // ignore: unused_local_variable
  final c = Get.put(ControllerPurchaseHistory());
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
    child: Container(
      width: double.infinity,
      color: UIColor.mercury,
      height: Get.height * .95,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                color: UIColor.wildSand.withOpacity(.92),
                height: 10,
                width: Get.width),
            AppBar(
              backgroundColor: UIColor.wildSand.withOpacity(.92),
              elevation: 0,
              leadingWidth: 23,
              automaticallyImplyLeading: false,
              centerTitle: true,
              leading: const GetBackButton(),
              title: TextBasic(
                text: UIText.purchaseHistoryTitle,
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ), systemOverlayStyle: SystemUiOverlayStyle.dark,
            ),
            Divider(color: UIColor.tuna.withOpacity(.38), height: 1),
            const SizedBox(height: 30),
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                width: Get.width,
                decoration: whiteDecoration(),
                alignment: Alignment.center,
                child: Column(
                  children: [
                    ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: 3,
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return _getLine(
                            date: '26.08.2021',
                            cardNumber: '4579',
                            isDivider: index == 2 ? false : true,
                            price: '856 TL',
                          );
                        })
                  ],
                )),
            const SizedBox(height: 30),
          ],
        ),
      ),
    ),
  );
}

Widget _getLine({
  required String date,
  required String cardNumber,
  required String price,
  bool? isDivider = false,
}) {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextBasic(
                text: date,
                fontSize: 17,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.credit_card,
                    size: 16,
                    color: UIColor.tuna.withOpacity(.6),
                  ),
                  const SizedBox(width: 4),
                  TextBasic(
                    text: cardNumber,
                    color: UIColor.tuna.withOpacity(.6),
                    fontSize: 13,
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              TextBasic(
                text: price,
                color: UIColor.tuna.withOpacity(.6),
                fontSize: 17,
              ),
              const SizedBox(width: 8),
              SvgPicture.asset(
                UIPath.download,
                width: 24,
                height: 24,
                fit: BoxFit.scaleDown,
              )
            ],
          ),
        ],
      ),
      if (isDivider!) Divider(color: UIColor.tuna.withOpacity(.38), height: 22),
    ],
  );
}
