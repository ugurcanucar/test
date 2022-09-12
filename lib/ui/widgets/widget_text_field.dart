import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:terapizone/ui/shared/uicolor.dart';
import 'package:terapizone/ui/shared/uipath.dart';

//text field without any border
class LoginTextField extends StatelessWidget {
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final FocusNode? requestFocus;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final bool obscureText;
  final int? maxLength;
  final int? maxLines;
  final bool? enabled;
  final double? radius;
  final String? hint;
  final Widget? suffixIcon;
  final List<TextInputFormatter>? inputFormatters;

  // ignore: use_key_in_widget_constructors
  const LoginTextField(
      {this.focusNode,
      this.keyboardType,
      this.textInputAction,
      this.requestFocus,
      this.validator,
      this.controller,
      required this.obscureText,
      this.maxLength,
      this.maxLines,
      this.enabled,
      this.radius,
      this.hint,
      this.suffixIcon,
      this.inputFormatters});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      cursorColor: UIColor.azureRadiance,
      focusNode: focusNode,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      onFieldSubmitted: (v) {
        if (requestFocus != null) {
          FocusScope.of(context).requestFocus(requestFocus);
        }
      },
      controller: controller,
      obscureText: obscureText,
      maxLines: maxLines ?? 1,
      validator: validator,
      inputFormatters: inputFormatters,
      style: TextStyle(
        color: UIColor.tuna,
        fontSize: 16.0,
        //fontFamily: UIFont.medium,
      ),
      decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
            color: UIColor.tuna.withOpacity(.33),
            fontSize: 16.0,
            // fontFamily: UIFont.medium,
          ),
          errorStyle: TextStyle(color: UIColor.redOrange),
          fillColor: UIColor.white,
          filled: true,
          suffixIcon: suffixIcon,
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none),
    );
  }
}

class SearchTextField extends StatelessWidget {
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final FocusNode? requestFocus;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final int? maxLength;
  final int? maxLines;
  final bool? enabled;
  final double? radius;
  final String? hint;
  final Widget? suffixIcon;

  // ignore: use_key_in_widget_constructors
  const SearchTextField(
      {this.focusNode,
      this.keyboardType,
      this.textInputAction,
      this.requestFocus,
      this.validator,
      this.controller,
      this.maxLength,
      this.maxLines,
      this.enabled,
      this.radius,
      this.hint,
      this.suffixIcon});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      cursorColor: UIColor.azureRadiance,
      focusNode: focusNode,
      textInputAction: textInputAction,
      onFieldSubmitted: (v) {
        if (requestFocus != null) {
          FocusScope.of(context).requestFocus(requestFocus);
        }
      },
      controller: controller,
      maxLines: maxLines ?? 1,
      validator: validator,
      style: TextStyle(
        color: UIColor.tuna,
        fontSize: 16.0,
      ),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.zero,
        isDense: true,
        prefixIcon: Padding(
          padding: const EdgeInsets.all(6.0),
          child: SvgPicture.asset(
            UIPath.search,
            color: UIColor.black,
          ),
        ),
        prefixIconConstraints:
            const BoxConstraints(minWidth: 36, minHeight: 36),
        hintText: hint,
        hintStyle: TextStyle(
          color: UIColor.manatee,
          fontSize: 17,
        ),
        errorStyle: TextStyle(color: UIColor.redOrange),
        fillColor: UIColor.jumbo.withOpacity(.12),
        filled: true,
        border: _getBorder(),
        focusedBorder: _enabledBorder(),
        enabledBorder: _getBorder(),
        errorBorder: _getBorder(),
        focusedErrorBorder: _getBorder(),
        disabledBorder: _getBorder(),
      ),
    );
  }

  OutlineInputBorder _getBorder() {
    return OutlineInputBorder(
        borderSide: BorderSide.none, borderRadius: BorderRadius.circular(10));
  }

  OutlineInputBorder _enabledBorder() {
    return OutlineInputBorder(borderRadius: BorderRadius.circular(10));
  }
}
