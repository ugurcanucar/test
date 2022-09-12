import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:terapizone/ui/shared/uicolor.dart';
import 'package:terapizone/ui/shared/uipath.dart';
import 'package:terapizone/ui/widgets/widget_profil_photo.dart';
import 'package:terapizone/ui/widgets/widget_text.dart';

Widget getMessageContainer(
    {required String url,
    required String senderName,
    required String subtitle,
    required Function() onTap,
    required int number,
    bool isDivider = false}) {
  return GestureDetector(
    onTap: onTap,
    behavior: HitTestBehavior.translucent,
    child: Row(
      children: [
        getProfilPhoto(url, senderName),
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
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextBasic(
                          text: senderName,
                          color: UIColor.black,
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          maxLines: 1,
                        ),
                        TextBasic(
                          text: subtitle,
                          color: UIColor.tuna.withOpacity(.6),
                          fontSize: 13,
                          maxLines: 2,
                        ),
                      ],
                    ),
                  ),
                  if (number > 0)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          color: UIColor.azureRadiance,
                          shape: BoxShape.circle,
                        ),
                        alignment: Alignment.center,
                        child: TextBasic(
                          text: number.toString(),
                          fontSize: 17,
                          color: UIColor.white,
                          textAlign: TextAlign.center,
                        ),
                      ),
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
              if (isDivider) Divider(color: UIColor.tuna.withOpacity(.38), height: 1),
            ],
          ),
        ),
      ],
    ),
  );
}
