import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:terapizone/ui/shared/uicolor.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:terapizone/ui/shared/uitext.dart';

class ActivityIndicator extends StatelessWidget {
  const ActivityIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.height,
      decoration: BoxDecoration(color: UIColor.mercury.withOpacity(0.2)),
      child: Center(
          child: SizedBox(
        width: 36,
        height: 36,
        child: LoadingIndicator(
          indicatorType: Indicator.ballRotateChase,
          colors: [UIColor.azureRadiance],
        ),
      )),
    );
  }
}

class ChatLoadingIndicator extends StatelessWidget {
  const ChatLoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox(
      width: 36,
      height: 36,
      child: LoadingIndicator(
        indicatorType: Indicator.ballBeat,
        colors: [UIColor.azureRadiance],
      ),
    ));
  }
}

class ActivityIndicatorListConsultant extends StatelessWidget {
  const ActivityIndicatorListConsultant({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.height,
      decoration: BoxDecoration(color: UIColor.mercury.withOpacity(0.2)),
      child: Column(
        children: [
          const Spacer(),
          Text(
            UIText.listConsultantLoading,
            style: TextStyle(
                decoration: TextDecoration.none,
                color: UIColor.azureRadiance,
                fontSize: 24,
                fontWeight: FontWeight.w400),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            width: 36,
            height: 36,
            child: LoadingIndicator(
              indicatorType: Indicator.ballBeat,
              colors: [UIColor.azureRadiance],
            ),
          ),
          const Spacer()
        ],
      ),
    );
  }
}
