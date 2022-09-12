import 'package:flutter/material.dart';
import 'package:terapizone/ui/shared/uicolor.dart';

BoxDecoration whiteDecoration() {
  return BoxDecoration(
    color: UIColor.white,
    border: Border(
      top: BorderSide(width: 1, color: UIColor.tuna.withOpacity(.33)),
      bottom: BorderSide(width: 1, color: UIColor.tuna.withOpacity(.33)),
    ),
  );
}

BoxDecoration wildSandDecoration() {
  return BoxDecoration(
    color: UIColor.wildSand,
    border: Border(
      top: BorderSide(width: 1, color: UIColor.tuna.withOpacity(.33)),
      bottom: BorderSide(width: 1, color: UIColor.tuna.withOpacity(.33)),
    ),
  );
}

BoxDecoration alabasterDecoration() {
  return BoxDecoration(
    color: UIColor.alabaster,
    border: Border(
      top: BorderSide(width: 1, color: UIColor.tuna.withOpacity(.33)),
      bottom: BorderSide(width: 1, color: UIColor.tuna.withOpacity(.33)),
    ),
  );
}
