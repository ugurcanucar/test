import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:terapizone/ui/controllers/controllers_user/controller_change_consultant/controller_change_consultant.dart';
import 'package:terapizone/ui/shared/decoration.dart';
import 'package:terapizone/ui/shared/uicolor.dart';
import 'package:terapizone/ui/shared/uipath.dart';
import 'package:terapizone/ui/shared/uitext.dart';
import 'package:terapizone/ui/views/view_base.dart';
import 'package:terapizone/ui/views/views_user/views_change_consultant/view_change_disease.dart';
import 'package:terapizone/ui/views/views_user/views_change_consultant/view_change_for_who.dart';
import 'package:terapizone/ui/widgets/widget_buttons.dart';
import 'package:terapizone/ui/widgets/widget_state.dart';
import 'package:terapizone/ui/widgets/widget_text.dart';

class ViewChangeConsultant extends StatelessWidget {
  const ViewChangeConsultant({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final c = Get.put(ControllerChangeConsultant());

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
                  automaticallyImplyLeading: false,
                  centerTitle: true,
                  leadingWidth: 90,
                  leading: Align(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () => Get.back(),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: TextBasic(
                          text: UIText.changeConsultantCancel,
                          color: UIColor.azureRadiance,
                          fontSize: 17,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  title: TextBasic(
                    text: UIText.changeConsultantTitle,
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
    final ControllerChangeConsultant c = Get.find();

    return Stack(
      children: [
        Container(
          height: Get.height,
          width: Get.width,
          decoration: BoxDecoration(
            color: UIColor.mercury,
          ),
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
              child: !c.isAsked ? getSureContainer() : getReasonContainer()),
        ),
        Visibility(
          visible: c.isAsked,
          child: Positioned(
            bottom: 32,
            left: 16,
            right: 16,
            child: ButtonBasic(
                buttonText: UIText.changeConsultantBtn2,
                bgColor: UIColor.azureRadiance,
                textColor: UIColor.white,
                onTap: () => c.clientChangingTherapist()),
          ),
        ),
      ],
    );
  }

  Widget getSureContainer() {
    final ControllerChangeConsultant c = Get.find();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 30),
        SvgPicture.asset(UIPath.deleteAccount,
            width: 74, height: 70, fit: BoxFit.cover),
        const SizedBox(height: 30),
        TextBasic(
          text: UIText.changeConsultantText,
          color: UIColor.manatee,
          fontSize: 22,
          fontWeight: FontWeight.w700,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 30),
        TextBasic(
          text: UIText.changeConsultantSubtext,
          color: UIColor.manatee,
          fontSize: 17,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 30),
        //change consultant button
        ButtonBasic(
            buttonText: UIText.changeConsultantBtn,
            bgColor: UIColor.azureRadiance,
            textColor: UIColor.white,
            onTap: () => c.setIsAsked(true)),
      ],
    );
  }

  Widget getReasonContainer() {
    final ControllerChangeConsultant c = Get.find();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding:
              const EdgeInsets.only(top: 30, bottom: 20, left: 16, right: 16),
          child: TextBasic(
            text: UIText.changeConsultantWhy,
            fontSize: 22,
            fontWeight: FontWeight.w700,
            textAlign: TextAlign.center,
          ),
        ),
        Container(
            decoration: whiteDecoration(),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: GetBuilder<ControllerChangeConsultant>(
              init: ControllerChangeConsultant(),
              builder: (ctrl) {
                final data = ctrl.reasonList;
                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: data.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () => ctrl.checkReasonList(index),
                      child: Column(
                        children: [
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: TextBasic(
                                  text: data[index].reasonText!,
                                  color: data[index].check!
                                      ? UIColor.azureRadiance
                                      : UIColor.black,
                                  fontSize: 17,
                                ),
                              ),
                              if (data[index].check!)
                                SvgPicture.asset(UIPath.check),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Divider(
                              color: UIColor.tuna.withOpacity(.38), height: 0),
                        ],
                      ),
                    );
                  },
                );
              },
            )),
        Padding(
          padding:
              const EdgeInsets.only(top: 28, bottom: 8.0, left: 16, right: 16),
          child: Align(
            alignment: Alignment.centerLeft,
            child: TextBasic(
              text: UIText.changeConsultantNote,
              color: UIColor.tuna.withOpacity(.6),
              fontSize: 13,
            ),
          ),
        ),
        Container(
          decoration: whiteDecoration(),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            children: [
              getLine(
                title: UIText.changeConsultantComplaint,
                subtitle: UIText.changeConsultantComplaintSub,
                onTap: () => Get.to(() => ViewChangeForWho(
                    onTap: () => Get.to(() => ViewChangeDisease()))),
                //isDivider: true,
              ),
              /*  getLine(
                title: UIText.changeConsultantGender,
                onTap: () => Get.to(() => ViewChangeGender()),
              ), */
            ],
          ),
        ),
        const SizedBox(height: 20),
        //user agreement acceptance
        Obx(() => CheckboxListTile(
              value: c.checkboxValue,
              controlAffinity: ListTileControlAffinity.leading,
              onChanged: (value) => c.setCheckBox(value),
              contentPadding: EdgeInsets.zero,
              checkColor: UIColor.white,
              selectedTileColor: UIColor.azureRadiance,
              title: TextBasic(
                text: UIText.changeConsultantApproval,
                fontSize: 15,
              ),
            )),

        const SizedBox(height: 72),
      ],
    );
  }

  Widget getComplaintLine(
      {required String title, required int value, bool? isDivider = false}) {
    final ControllerChangeConsultant c = Get.find();

    return Column(
      children: [
        const SizedBox(height: 18),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: TextBasic(
                text: title,
                fontSize: 17,
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(
              width: 24,
              height: 24,
              child: Radio(
                  groupValue: c.groupValue,
                  value: value,
                  onChanged: (value) => c.setRadioButton(value)),
            )
          ],
        ),
        const SizedBox(height: 18),
        if (isDivider!)
          Divider(color: UIColor.tuna.withOpacity(.38), height: 1),
      ],
    );
  }

  Widget getLine(
      {required String title,
      String? subtitle,
      String? text,
      required Function() onTap,
      bool? isDivider = false,
      String? icon}) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          behavior: HitTestBehavior.translucent,
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextBasic(
                      text: title,
                      fontSize: 17,
                    ),
                    if (subtitle != null)
                      TextBasic(
                        text: subtitle,
                        color: UIColor.tuna.withOpacity(.6),
                        fontSize: 13,
                      ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (text != null)
                    TextBasic(
                      text: text,
                      color: UIColor.tuna.withOpacity(.6),
                      fontSize: 17,
                    ),
                  if (icon != null)
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: SvgPicture.asset(
                        icon,
                        width: 24,
                        height: 24,
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  const SizedBox(width: 8),
                  SvgPicture.asset(
                    UIPath.right,
                    width: 10,
                    height: 24,
                    fit: BoxFit.scaleDown,
                  ),
                ],
              )
            ],
          ),
        ),
        if (isDivider!)
          Divider(color: UIColor.tuna.withOpacity(.38), height: 16),
      ],
    );
  }

  Widget getTextField(
      {List<TextInputFormatter>? inputFormatters,
      Function(String?)? onFieldSubmitted,
      String? Function(String?)? validate,
      Function(String?)? onChanged,
      Function(String?)? onSaved}) {
    final ControllerChangeConsultant c = Get.find();

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextFormField(
        controller: c.controller,
        inputFormatters: inputFormatters,
        onFieldSubmitted: onFieldSubmitted,
        onChanged: onChanged,
        onSaved: onSaved,
        cursorColor: UIColor.azureRadiance,
        validator: validate,
        style: TextStyle(fontSize: 13, color: UIColor.black),
        maxLines: 3,
        decoration: InputDecoration(
          hintText: UIText.changeConsultantHint,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: UIColor.frenchGray)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: UIColor.azureRadiance)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: UIColor.redOrange)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: UIColor.redOrange)),
        ),
      ),
    );
  }
}
