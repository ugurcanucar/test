import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:terapizone/core/services/service_chronos.dart';
import 'package:terapizone/ui/controllers/controllers_consultant/controller_new_note.dart';

import 'package:terapizone/ui/shared/uicolor.dart';
import 'package:terapizone/ui/shared/uipath.dart';

import 'package:terapizone/ui/shared/uitext.dart';
import 'package:terapizone/ui/views/view_base.dart';
import 'package:terapizone/ui/widgets/widget_buttons.dart';

import 'package:terapizone/ui/widgets/widget_state.dart';
import 'package:terapizone/ui/widgets/widget_text.dart';

class ViewNewNote extends StatelessWidget {
  const ViewNewNote({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final c = Get.put(ControllerNewNote());

    return ViewBase(
      statusbarBrightness: SystemUiOverlayStyle.dark,
      child: Container(
        height: Get.size.height,
        width: Get.size.width,
        alignment: Alignment.center,
        color: UIColor.wildSand.withOpacity(.92),
        child: Obx(
          () => c.busy
              ? const ActivityIndicator()
              : Scaffold(
                  key: c.scaffoldKey,
                  backgroundColor: UIColor.wildSand.withOpacity(.92),
                  appBar: getAppBarUser(),
                  body: body(0)),
        ),
      ),
    );
  }

  AppBar getAppBarUser() {
    return AppBar(
      elevation: 0,
      automaticallyImplyLeading: false,
      backgroundColor: UIColor.wildSand.withOpacity(.92),
      leadingWidth: 100,
      leading: GetBackButton(
        title: UIText.cClientProfileNotes,
      ),
      actions: <Widget>[
        Align(
          alignment: Alignment.centerRight,
          child: GestureDetector(
            onTap: () => {},
            behavior: HitTestBehavior.translucent,
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Row(
                children: [
                  SvgPicture.asset(
                    UIPath.clientProfileCircleThreeDot,
                    fit: BoxFit.scaleDown,
                  ),
                  const SizedBox(width: 12),
                  TextBasic(
                    text: UIText.save,
                    color: UIColor.azureRadiance,
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  )
                ],
              ),
            ),
          ),
        ),
      ],
      systemOverlayStyle: SystemUiOverlayStyle.dark,
    );
  }

  Widget body(index) {
    return Container(
      height: Get.height,
      width: Get.width,
      decoration: BoxDecoration(
        color: UIColor.white,
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: bodyDetails(
              index: index,
              noteDate: DateTime.now(),
              noteTitle: "Enter your title here",
              noteDetail: "Enter your text here"),
        ),
      ),
    );
  }

  Widget bodyDetails({
    required int index,
    required DateTime noteDate,
    required String noteTitle,
    required String noteDetail,
  }) {
    ControllerNewNote c = Get.find();
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 40),
        TextBasic(
            text: ChronosService.getDateDayMonth(((noteDate.toString())))),
        TextField(
          controller: c.noteTitleController,
          focusNode: c.focusNoteTitle,
          style: noteText(FontWeight.bold),
          decoration: InputDecoration.collapsed(
            hintText: noteTitle,
            hintStyle: noteText(FontWeight.bold),
          ),
          enabled: true,
        ),
        const SizedBox(height: 16),
        TextField(
          controller: c.noteTextController,
          focusNode: c.focusNoteText,
          style: noteText(FontWeight.w400),
          maxLines: 50,
          decoration: InputDecoration.collapsed(
            hintText: noteDetail,
            hintStyle: noteText(FontWeight.w400),
          ),
        ),
      ],
    );
  }

  TextStyle noteText(FontWeight fontWeight) {
    return TextStyle(
        fontWeight: fontWeight, color: UIColor.black, fontSize: 17);
  }
}
