import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:terapizone/core/enums/enum.dart';
import 'package:terapizone/core/services/endpoint.dart';
import 'package:terapizone/core/services/service_api.dart';
import 'package:terapizone/core/utils/utilities.dart';
import 'package:terapizone/ui/controllers/controller_base.dart';
import 'package:terapizone/ui/models/packages_model.dart';
import 'package:terapizone/ui/models/response_data_model.dart';

class ControllerBuyVideoTherapy extends BaseController {
  @override
  void onInit() async {
    super.onInit();
    init();
  }

  Future<void> init() async {
    await getPackageList();
  }

  //states
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final RxInt _selectedSession = 0.obs;
  final RxList<PackagesModel> _packages = <PackagesModel>[].obs;

  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;
  int get selectedSession => _selectedSession.value;
  List<PackagesModel> get packages => _packages;

  //get packages
  Future<void> getPackageList() async {
    setBusy(true);
    ResponseData<List<PackagesModel>> response = await ApiService.apiRequest(
        Get.context!, ApiMethod.get,
        endpoint: Endpoint.packages);
    setBusy(false);
    if (response.success && response.data != null) {
      if (response.data.isNotEmpty) _packages.value = response.data;
      update();
    } else {
      Utilities.showToast(response.message!);
    }
  }

  setSelectedSession(int index) {
    _selectedSession.value = index;
  }
}
