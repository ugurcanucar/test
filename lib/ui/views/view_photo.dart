import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:terapizone/ui/controllers/controller_photo.dart';
import 'package:terapizone/ui/shared/uicolor.dart';
import 'package:terapizone/ui/views/view_base.dart';
import 'package:terapizone/ui/widgets/widget_buttons.dart';
import 'package:terapizone/ui/widgets/widget_state.dart';

class ViewPhoto extends StatelessWidget {
  final String file;
  final c = Get.put(ControllerPhoto());

  ViewPhoto({Key? key, required this.file}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewBase(
      statusbarBrightness: SystemUiOverlayStyle.dark,
      child: Container(
        height: Get.size.height,
        width: Get.size.width,
        alignment: Alignment.center,
        color: UIColor.athensGray,
        child: Obx(() => c.busy
            ? const ActivityIndicator()
            : SafeArea(
                child: Scaffold(
                    key: c.scaffoldKey,
                    backgroundColor: UIColor.athensGray,
                    appBar: AppBar(
                      backgroundColor: UIColor.athensGray,
                      elevation: 0,
                      leadingWidth: 40,
                      leading: const Padding(
                        padding: EdgeInsets.only(left: 16),
                        child:  GetBackButton(),
                      ),
                      systemOverlayStyle: SystemUiOverlayStyle.dark,
                    ),
                    body: body()),
              )),
      ),
    );
  }

  Widget body() {
    return Container(
      height: Get.height,
      width: Get.width,
      decoration: BoxDecoration(color: UIColor.athensGray),
      child: InteractiveViewer(
        panEnabled: false, // Set it to false
        boundaryMargin: const EdgeInsets.all(100),
        minScale: 0.5,
        maxScale: 4,
        child: Image.network(
         file,
        ),
      ),
    );
  }
}
