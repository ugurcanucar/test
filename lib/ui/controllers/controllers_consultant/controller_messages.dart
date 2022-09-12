import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signalr_core/signalr_core.dart';
// import 'package:signalr_core/signalr_core.dart';
import 'package:terapizone/core/enums/enum.dart';
import 'package:terapizone/core/services/endpoint.dart';
import 'package:terapizone/core/services/service_api.dart';
import 'package:terapizone/core/utils/general_data.dart';
import 'package:terapizone/core/utils/utilities.dart';
import 'package:terapizone/ui/controllers/controller_base.dart';
import 'package:terapizone/ui/controllers/controller_login_register.dart';
import 'package:terapizone/ui/models/chat_list_model.dart';
import 'package:terapizone/ui/models/response_data_model.dart';

class ControllerMessages extends BaseController {
  @override
  void onInit() async {
    super.onInit();
    init();
  }

  Future<void> init() async {
    setNotificationCount();
    await getChatList();
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
    // while (repeat) {
    //   await 5.delay();
    //   await getChatList();
    // }
  }
  //controllers

  //states
  bool repeat = true;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final RxList<ChatListModel> _list = <ChatListModel>[].obs;
  final RxInt _notificationCount = 0.obs;

  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;
  List<ChatListModel> get list => _list;
  int get notificationCount => _notificationCount.value;

  //get chat list
  Future<void> getChatList() async {
    ResponseData<List<ChatListModel>> response = await ApiService.apiRequest(
        Get.context!, ApiMethod.get,
        endpoint: Endpoint.chatList);
    setBusy(false);
    if (response.success && response.data != null) {
      if (response.data.isNotEmpty) {
        _list.value = response.data;
      }
    } else {
      inspect("hata burda");

      Utilities.showToast(response.message!);
    }
  }
}
