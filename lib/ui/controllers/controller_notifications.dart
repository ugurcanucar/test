import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:terapizone/core/enums/enum.dart';
import 'package:terapizone/core/services/endpoint.dart';
import 'package:terapizone/core/services/service_api.dart';
import 'package:terapizone/core/utils/utilities.dart';
import 'package:terapizone/ui/controllers/controller_base.dart';
import 'package:terapizone/ui/controllers/controller_login_register.dart';
import 'package:terapizone/ui/controllers/controllers_consultant/controller_messages.dart';
import 'package:terapizone/ui/controllers/controllers_user/controller_dashboard.dart';
import 'package:terapizone/ui/models/notification_model.dart';
import 'package:terapizone/ui/models/response_data_model.dart';

class ControllerNotifications extends BaseController {
  @override
  void onInit() async {
    super.onInit();
    init();
  }

  Future<void> init() async {
    await getNotifications();
  }

  //states
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final RxList<NotificationModel> _notifications = <NotificationModel>[].obs;

  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;
  List<NotificationModel> get notifications => _notifications;

  //get notifications
  Future<void> getNotifications() async {
    setBusy(true);
    ResponseData<List<NotificationModel>> response =
        await ApiService.apiRequest(Get.context!, ApiMethod.get,
            endpoint: Endpoint.notifications);
    setBusy(false);
    if (response.success && response.data != null) {
      if (response.data.isNotEmpty) _notifications.value = response.data;
      update();
      //if client
      if (TerapizoneUser.user != null &&
          TerapizoneUser.user!.user!.accountTypeId == 1) {
        ControllerDashboard cDashboard = Get.find();
        cDashboard.setNotificationCount(value: 0);
      }
      //if therapist
      else {
        ControllerMessages cMessages = Get.find();
        cMessages.setNotificationCount(value: 0);
      }
    } else {
      inspect("hata burda");

      Utilities.showToast(response.message!);
    }
  }
}
