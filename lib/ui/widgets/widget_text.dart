import 'package:flutter/material.dart';
import 'package:terapizone/ui/shared/uicolor.dart';
import 'package:terapizone/ui/shared/uifont.dart';

class TextBasic extends StatelessWidget {
  final String text;
  final Color? color;
  final String? fontFamily;
  final double? fontSize;
  final double? lineHeight;
  final bool? underline;
  final TextAlign? textAlign;
  final int? maxLines;
  final FontWeight? fontWeight;

  // ignore: use_key_in_widget_constructors
  const TextBasic(
      {required this.text,
      this.color,
      this.fontFamily,
      this.fontSize,
      this.lineHeight,
      this.underline = false,
      this.textAlign,
      this.maxLines,
      this.fontWeight});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      textAlign: textAlign,
      maxLines: maxLines ?? 999,
      textScaleFactor: 1.0,
      style: TextStyle(
        color: color ?? UIColor.black,
        fontFamily: fontFamily ?? UIFont.regular,
        fontSize: fontSize,
        decoration: underline! ? TextDecoration.underline : null,
        fontWeight: fontWeight ?? FontWeight.w400,
        height: lineHeight ?? 1.2,
      ),
    );
  }
}

class RichTextBasic extends StatelessWidget {
  final List<TextSpan> texts;
  final TextAlign? textAlign;

  // ignore: use_key_in_widget_constructors
  const RichTextBasic({required this.texts, this.textAlign});
  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: textAlign ?? TextAlign.center,
      text: TextSpan(
        children: texts,
      ),
    );
  }
}
