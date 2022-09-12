import 'package:flutter/material.dart';
import 'package:terapizone/ui/shared/uicolor.dart';
import 'package:terapizone/ui/widgets/widget_text.dart';

Container getProfilPhoto(String url, String name) {
  return Container(
    width: 39,
    height: 39,
    decoration: BoxDecoration(
      color: UIColor.alabaster,
      border:
          Border.all(color: UIColor.chetwodeBlue.withOpacity(.15), width: 1),
      shape: BoxShape.circle,
      //image: DecorationImage(image: NetworkImage(url), fit: BoxFit.fitWidth),
    ),
    child: TextBasic(
      text: name.isNotEmpty ? name.substring(0, 1) : '',
      color: UIColor.black,
      fontSize: 24,
      fontWeight: FontWeight.w400,
      textAlign: TextAlign.center,
    ),
  );
}
