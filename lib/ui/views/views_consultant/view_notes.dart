import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:terapizone/core/services/service_chronos.dart';

import 'package:terapizone/ui/controllers/controllers_consultant/controller_notes.dart';

import 'package:terapizone/ui/shared/uicolor.dart';
import 'package:terapizone/ui/shared/uipath.dart';

import 'package:terapizone/ui/shared/uitext.dart';
import 'package:terapizone/ui/views/view_base.dart';
import 'package:terapizone/ui/views/views_consultant/view_note_new.dart';
import 'package:terapizone/ui/views/views_consultant/view_notes_details.dart';
import 'package:terapizone/ui/widgets/widget_buttons.dart';

import 'package:terapizone/ui/widgets/widget_state.dart';
import 'package:terapizone/ui/widgets/widget_text.dart';

class ViewNotes extends StatelessWidget {
  const ViewNotes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final c = Get.put(ControllerNotes());

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
                  appBar: getAppBar(),
                  body: body()),
        ),
      ),
    );
  }

  AppBar getAppBar() {
    return AppBar(
      elevation: 0,
      automaticallyImplyLeading: false,
      backgroundColor: UIColor.wildSand,
      leadingWidth: 30,
      leading: const GetBackButton(),
      centerTitle: true,
      title: Column(
        children: [
          TextBasic(
            text: UIText.cClientProfileNotes,
            fontWeight: FontWeight.w400,
            fontSize: 15,
          ),
          const TextBasic(
            text: 'Daniel Clarke',
            fontWeight: FontWeight.w400,
            fontSize: 11,
          ),
        ],
      ),
      actions: <Widget>[
        Align(
          alignment: Alignment.centerRight,
          child: GestureDetector(
            onTap: () => Get.to(const ViewNewNote()),
            behavior: HitTestBehavior.translucent,
            child: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: SvgPicture.asset(
                  UIPath.clientProfileAddNote,
                  fit: BoxFit.scaleDown,
                )),
          ),
        ),
      ],
      systemOverlayStyle: SystemUiOverlayStyle.dark,
    );
  }

  Widget body() {
    ControllerNotes c = Get.find();
    return Container(
        height: Get.height,
        width: Get.width,
        decoration: BoxDecoration(
          color: UIColor.athensGray,
        ),
        child: GridView.builder(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: (Get.width / 2),
              mainAxisSpacing: 16,
              childAspectRatio: 1,
            ),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: c.list.length,
            itemBuilder: (BuildContext ctx, index) {
              return GestureDetector(
                onTap: () => Get.to(const ViewNoteDetails()),
                child: getSquareCard(
                    index: index,
                    noteDate: c.list[index].noteDate,
                    noteTitle: c.list[index].noteTitle,
                    noteDetail: c.list[index].noteDetail),
              );
            }));
  }

  Widget getSquareCard({
    required int? index,
    required DateTime? noteDate,
    required String? noteTitle,
    required String? noteDetail,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Container(
        width: Get.width / 2 - 48,
        height: Get.width / 2 - 48,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8), color: UIColor.white),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextBasic(
                  text:
                      ChronosService.getDateDayMonth(((noteDate.toString())))),
              TextBasic(
                text: noteTitle.toString(),
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(height: 24),
              TextBasic(
                text: noteDetail.toString(),
                maxLines: 4,
                fontSize: 21,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
