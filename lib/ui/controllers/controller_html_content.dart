import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:terapizone/core/enums/enum.dart';
import 'package:terapizone/core/services/endpoint.dart';
import 'package:terapizone/core/services/service_api.dart';
import 'package:terapizone/core/utils/utilities.dart';
import 'package:terapizone/ui/controllers/controller_base.dart';
import 'package:terapizone/ui/models/content_model.dart';
import 'package:terapizone/ui/models/response_data_model.dart';

class ControllerHtmlContent extends BaseController {
  final String contentkey;

  ControllerHtmlContent({required this.contentkey});
  @override
  void onInit() async {
    super.onInit();
    init();
  }

  Future<void> init() async {
    await getContent();
  }

  //states
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final Rx<ContentModel> _content = ContentModel().obs;

  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;
  ContentModel get content => _content.value;

  Future<void> getContent() async {
    ResponseData<ContentModel> response = await ApiService.apiRequest(
        Get.context!, ApiMethod.get,
        endpoint: Endpoint.getbycontentkey(contentkey: contentkey));
    setBusy(false);

    if (response.success && response.data != null) {
      _content.value = response.data;
    } else {
      Utilities.showToast(response.message!);
    }
  }
}
