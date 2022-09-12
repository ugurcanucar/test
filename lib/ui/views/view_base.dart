import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:terapizone/core/utils/utilities.dart';

class 
ViewBase extends StatelessWidget {
  final SystemUiOverlayStyle statusbarBrightness;
  final Widget child;

  const ViewBase(
      {Key? key,
      required this.statusbarBrightness,
      required this.child,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: statusbarBrightness,
      child: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (OverscrollIndicatorNotification overscroll) {
            overscroll.disallowGlow();
            return true;
          },
          child: GestureDetector(
            onTap: () => Utilities.hideKeyboard(),
            child: child ),
          )
    );
  }
}
