import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:terapizone/ui/controllers/controller_chat.dart';
import 'package:terapizone/ui/controllers/controllers_consultant/controller_calendar.dart';
import 'package:terapizone/ui/shared/uicolor.dart';
import 'package:terapizone/ui/shared/uifont.dart';
import 'package:terapizone/ui/shared/uipath.dart';
import 'package:terapizone/ui/views/view_chat.dart';
import 'package:terapizone/ui/widgets/widget_text.dart';

//Basic button
class ButtonBasic extends StatelessWidget {
  final String? buttonText;
  final Color? bgColor;
  final Color? textColor;
  final Function()? onTap;
  final int? flex;
  final double radius;
  final double? height;
  final double? padding;
  final Widget? prefixIcon;
  final double elevation;

  // ignore: use_key_in_widget_constructors
  const ButtonBasic(
      {this.buttonText,
      this.bgColor,
      this.textColor,
      this.onTap,
      this.flex,
      this.radius = 13,
      this.height,
      this.padding,
      this.prefixIcon,
      this.elevation = 0});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: elevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: height ?? 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.all(Radius.circular(radius)),
          ),
          padding: EdgeInsets.symmetric(horizontal: padding ?? 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (prefixIcon != null) prefixIcon!,
              Flexible(
                child: TextBasic(
                  text: buttonText ?? "",
                  color: textColor,
                  fontSize: 17,
                  fontFamily: UIFont.regular,
                  fontWeight: FontWeight.w600,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//button with border
class ButtonBorder extends StatelessWidget {
  final String? buttonText;
  final Color borderColor;
  final Color? textColor;
  final Function()? onTap;
  final int? flex;
  final double radius;
  final double? height;
  final double? padding;
  final Widget? prefixIcon;
  final double elevation;

  // ignore: use_key_in_widget_constructors
  const ButtonBorder(
      {this.buttonText,
      required this.borderColor,
      this.textColor,
      this.onTap,
      this.flex,
      this.radius = 14,
      this.height,
      this.padding,
      this.prefixIcon,
      this.elevation = 0});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height ?? 50,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: UIColor.transparent,
          border: Border.all(color: borderColor, width: 2.5),
          borderRadius: BorderRadius.all(
            Radius.circular(radius),
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: padding ?? 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (prefixIcon != null) prefixIcon!,
            Flexible(
              child: TextBasic(
                text: buttonText ?? "",
                color: textColor,
                fontSize: 17,
                fontFamily: UIFont.regular,
                fontWeight: FontWeight.w600,
                textAlign: TextAlign.center,
                maxLines: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//back button
class GetBackButton extends StatelessWidget {
  final String? title;
  final bool isChatView;
  final bool isCalendarSettings;

  const GetBackButton(
      {Key? key,
      this.title,
      this.isChatView = false,
      this.isCalendarSettings = false})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (isChatView) {
          isChatOpen = false;
          final ControllerChat c = Get.put(ControllerChat());
          c.disposeOnWillPop();
        } else if (isCalendarSettings) {
          final ControllerCalendar c = Get.put(ControllerCalendar());
          c.init();
        }
        Get.back();
      },
      behavior: HitTestBehavior.translucent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SvgPicture.asset(
            UIPath.back,
            color: UIColor.azureRadiance,
            width: 23,
            fit: BoxFit.scaleDown,
          ),
          if (title != null)
            Flexible(
              child: TextBasic(
                text: title!,
                color: UIColor.azureRadiance,
                fontSize: 17,
                textAlign: TextAlign.left,
              ),
            ),
        ],
      ),
    );
  }
}

class CircleButton extends StatelessWidget {
  final String icon;
  final double radius;
  final Color bgColor;
  final Color iconColor;
  final Color? borderColor;
  final void Function()? onTap;

  const CircleButton(
      {Key? key,
      required this.icon,
      this.radius = 36,
      this.bgColor = Colors.white,
      this.iconColor = Colors.black,
      this.borderColor,
      this.onTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: radius,
      height: radius,
      decoration: BoxDecoration(
          color: bgColor,
          shape: BoxShape.circle,
          border: borderColor != null
              ? Border.all(color: borderColor!, width: 2)
              : null),
      child: InkWell(
        onTap: onTap,
        child: SvgPicture.asset(icon,
            width: radius / 2,
            height: radius / 2,
            color: iconColor,
            fit: BoxFit.scaleDown),
      ),
    );
  }
}
