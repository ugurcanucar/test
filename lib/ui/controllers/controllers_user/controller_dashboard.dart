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
import 'package:terapizone/ui/models/active_appointments_model.dart';
import 'package:terapizone/ui/models/appointment_join_model.dart';
import 'package:terapizone/ui/models/chat_list_model.dart';
import 'package:terapizone/ui/models/response_data_model.dart';
import 'package:terapizone/ui/shared/uitext.dart';
import 'package:terapizone/ui/views/view_video_call.dart';

class ControllerDashboard extends BaseController {
  @override
  void onInit() async {
    super.onInit();
    init();
  }

  Future<void> init() async {
    setNotificationCount();
    await getChatList();
    await getActiveAppointments();
    setRepeat();
  }

  void setNotificationCount({int? value}) {
    if (value != null) {
      _notificationCount.value = value;
      TerapizoneUser.user!.unreadMessageCount = 0;
    } else if (TerapizoneUser.user != null) {
      _notificationCount.value = TerapizoneUser.user!.unreadMessageCount!;
    }
  }

  void setRepeat() async {
    while (repeat) {
      await 5.delay();
      await getChatList();
    }
  }

  //controllers

  //states
  bool repeat = true;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final RxList<ChatListModel> _list = <ChatListModel>[].obs;

  final RxList<ActiveAppointmentsModel> _activeAppointments = <ActiveAppointmentsModel>[].obs;
  final RxInt _notificationCount = 0.obs;
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;
  List<ChatListModel> get list => _list;

  List<ActiveAppointmentsModel> get activeAppointments => _activeAppointments;
  int get notificationCount => _notificationCount.value;

  //get chat list
  Future<void> getChatList() async {
    ResponseData<List<ChatListModel>> response =
        await ApiService.apiRequest(Get.context!, ApiMethod.get, endpoint: Endpoint.chatList);
    setBusy(false);
    if (response.success && response.data != null) {
      if (response.data.isNotEmpty) {
        _list.value = response.data;
      }
    } else {
      inspect("hata burda");
      // Utilities.showToast(response.message!);
    }
  }

  Future<void> getActiveAppointments() async {
    ResponseData<List<ActiveAppointmentsModel>> response =
        await ApiService.apiRequest(Get.context!, ApiMethod.get, endpoint: Endpoint.activeAppointments);
    setBusy(false);

    if (response.success && response.data != null) {
      if (response.data.isNotEmpty) {
        _activeAppointments.value = response.data;
      }
      update();
    } else {
      Utilities.showToast(response.message!);
    }
  }

  //cancel appointment
  Future<void> cancelAppointment(ActiveAppointmentsModel appointment) async {
    ResponseData<dynamic> response = await ApiService.apiRequest(Get.context!, ApiMethod.put,
        endpoint: Endpoint.appointmentCancel(id: appointment.id!), body: {"cancellationReason": ""});
    setBusy(false);

    if (response.success) {
      Utilities.showDefaultDialogConfirm(
        title: UIText.textSuccess,
        content: UIText.textCancelAppointmentSuccess,
        onConfirm: () => Get.back(),
      );
      await getActiveAppointments();
    } else {
      Utilities.showToast(response.message!);
    }
  }

  //join appointment
  Future<void> joinAppointment(String id) async {
    setBusy(true);
    ResponseData<AppointmentJoinModel> response =
        await ApiService.apiRequest(Get.context!, ApiMethod.get, endpoint: Endpoint.appointmentJoin(id: id));
    setBusy(false);

    if (response.success && response.data != null) {
      AppointmentJoinModel join = response.data;
      // uid = join.uid!;
      // channel = join.channel!;
      // token = join.token!;
      Get.to(() => ViewVideoCall(
            session: join,
            appointmendId: id,
          ));
    } else {
      Utilities.showToast(response.message!);
    }
  }
}
