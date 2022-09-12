import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:terapizone/ui/shared/uicolor.dart';
import 'package:terapizone/ui/shared/uipath.dart';
import 'package:terapizone/ui/widgets/widget_text.dart';

Widget getSetting(
    {required String icon,
    required String title,
    required Function() onTap,
    bool? isDivider = false}) {
  return GestureDetector(
    onTap: onTap,
    behavior: HitTestBehavior.translucent,
    child: Row(
      children: [
        SvgPicture.asset(
          icon,
          width: 29,
          height: 29,
        ),
        const SizedBox(width: 15),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextBasic(
                    text: title,
                    fontSize: 17,
                  ),
                  SvgPicture.asset(
                    UIPath.right,
                    width: 10,
                    height: 24,
                    fit: BoxFit.scaleDown,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              if (isDivider!)
                Divider(color: UIColor.tuna.withOpacity(.38), height: 1),
            ],
          ),
        ),
      ],
    ),
  );
}
