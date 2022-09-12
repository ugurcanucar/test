import 'package:flutter/material.dart';
import 'package:terapizone/ui/controllers/controller_play_vimeo_video.dart';
import 'package:terapizone/ui/widgets/widget_buttons.dart';
import 'package:vimeo_player_flutter/vimeo_player_flutter.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:terapizone/ui/shared/uicolor.dart';
import 'package:terapizone/ui/views/view_base.dart';
import 'package:terapizone/ui/widgets/widget_state.dart';

class ViewPlayVimeoVideo extends StatelessWidget {
  const ViewPlayVimeoVideo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final c = Get.put(ControllerPlayVimeoVideo());

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
                      leadingWidth: 31, //padding+icon width
                      automaticallyImplyLeading: false,
                      leading: const GetBackButton(),
                      systemOverlayStyle: SystemUiOverlayStyle.dark,
                    ),
                    body: body()),
              )),
      ),
    );
  }

  Widget body() {
    final ControllerPlayVimeoVideo c = Get.find();

    return SizedBox(
      height: Get.height,
      width: Get.width,
      child: c.vimeoVideo != null && c.vimeoVideo!.videoId != null
          ? VimeoPlayer(videoId: c.vimeoVideo!.videoId!.toString())
          : Container(),
    );
  }
}
