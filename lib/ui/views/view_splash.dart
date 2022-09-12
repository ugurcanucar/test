import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:terapizone/ui/controllers/controller_login_register.dart';
import 'package:terapizone/ui/controllers/controller_splash.dart';
import 'package:terapizone/ui/shared/uicolor.dart';
import 'package:terapizone/ui/shared/uitext.dart';
import 'package:terapizone/ui/views/view_base.dart';
import 'package:terapizone/ui/views/view_login_register.dart';
import 'package:terapizone/ui/views/view_video_call.dart';
import 'package:terapizone/ui/widgets/widget_buttons.dart';
import 'package:terapizone/ui/widgets/widget_state.dart';
import 'package:terapizone/ui/widgets/widget_text.dart';

class ViewSplash extends StatelessWidget {
  const ViewSplash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final c = Get.put(ControllerSplash());

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
                    body: body(context)),
              )),
      ),
    );
  }

  Widget body(context) {
    final ControllerSplash c = Get.find();

    return Container(
      height: Get.height,
      width: Get.width,
      decoration: BoxDecoration(color: UIColor.white),
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          children: [
            //motto 1

            // ElevatedButton(
            //     onPressed: () {
            //       Navigator.push(
            //         context,
            //         MaterialPageRoute(builder: (context) => ViewVideoCall()),
            //       );
            //     },
            //     child: Text("Delete")),
            TextBasic(
              text: UIText.welcomeMotto1,
              color: UIColor.azureRadiance,
              fontSize: 28,
            ),
            //motto 2
            TextBasic(
              text: UIText.welcomeMotto2,
              color: UIColor.azureRadiance,
              fontSize: 34,
              fontWeight: FontWeight.w700,
            ),
            //motto 3
            const SizedBox(height: 20),
            TextBasic(
              text: UIText.welcomeMotto3,
              fontSize: 15,
            ),
            const SizedBox(height: 20),
            //images
            CarouselSlider(
              options: CarouselOptions(
                  autoPlay: true,
                  onPageChanged: (index, reason) {
                    c.setCurrenIndex(index);
                  }),
              items: c.imgList
                  .map((item) => Center(
                      child: Image.asset(item, fit: BoxFit.cover, width: 230)))
                  .toList(),
            ),
            //dots
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _buildPageIndicator(),
            ),
            const SizedBox(height: 20),
            //register button
            ButtonBasic(
              buttonText: UIText.welcomeBtn,
              bgColor: UIColor.azureRadiance,
              textColor: UIColor.white,
              onTap: () {
                final cLogin = Get.put(ControllerLoginRegister());
                cLogin.setTabIndex(1);
                Get.to(() => const ViewLoginRegister());
              },
            ),
            const SizedBox(height: 20),
            //login button
            InkWell(
              onTap: () {
                final cLogin = Get.put(ControllerLoginRegister());
                cLogin.setTabIndex(0);
                Get.to(() => const ViewLoginRegister());
              },
              child: RichTextBasic(texts: [
                TextSpan(
                  text: UIText.welcomeLogin1,
                  style: TextStyle(
                    color: UIColor.black,
                    fontSize: 17,
                  ),
                ),
                TextSpan(
                  text: UIText.welcomeLogin2,
                  style: TextStyle(
                    color: UIColor.azureRadiance,
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ]),
            ),
            const SizedBox(height: 20),
            //warning text
            TextBasic(
              text: UIText.welcomeWarning,
              color: UIColor.tuna.withOpacity(.6),
              fontSize: 13,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildPageIndicator() {
    final ControllerSplash c = Get.find();

    List<Widget> list = [];
    for (int i = 0; i < c.imgList.length; i++) {
      list.add(i == c.currentIndex ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return SizedBox(
      height: 10,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        margin: const EdgeInsets.symmetric(horizontal: 4.0),
        height: isActive ? 10 : 8.0,
        width: isActive ? 12 : 8.0,
        decoration: BoxDecoration(
          boxShadow: [
            isActive
                ? BoxShadow(
                    color: UIColor.indigo.withOpacity(0.72),
                    blurRadius: 4.0,
                    spreadRadius: 1.0,
                    offset: const Offset(
                      0.0,
                      0.0,
                    ),
                  )
                : const BoxShadow(
                    color: Colors.transparent,
                  )
          ],
          shape: BoxShape.circle,
          color: isActive ? UIColor.indigo : UIColor.tuna.withOpacity(.18),
        ),
      ),
    );
  }
}
