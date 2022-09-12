import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:terapizone/core/enums/enum.dart';
import 'package:terapizone/core/services/endpoint.dart';
import 'package:terapizone/core/services/service_api.dart';
import 'package:terapizone/core/utils/utilities.dart';
import 'package:terapizone/ui/controllers/controller_base.dart';
import 'package:terapizone/ui/controllers/controllers_user/controller_change_consultant/controller_change_consultant.dart';
import 'package:terapizone/ui/models/main_disease_model.dart';
import 'package:terapizone/ui/models/response_data_model.dart';

class ControllerChangeForWho extends BaseController {
  @override
  void onInit() async {
    super.onInit();
    init();
  }

  Future<void> init() async {
    await getList();
  }

  //states
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final RxList<MainDiseaseModel> _list = <MainDiseaseModel>[].obs;

  List<MainDiseaseModel> get list => _list;
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  Future<void> getList() async {
    ResponseData<MainDiseaseModel> response = await ApiService.apiRequest(
        Get.context!, ApiMethod.get,
        endpoint: Endpoint.diseasesGetallmaindisease);
    setBusy(false);

    if (response.success && response.data != null) {
      _list.value = response.data;
      if (_list.isNotEmpty) {
        _list[0].check = true;
        setMainDiseaseModel(0);
      }
    } else {
      Utilities.showToast(response.message!);
    }
  }

  checkList(int index) {
    for (int i = 0; i < _list.length; i++) {
      if (index == i) {
        _list[i].check = true;
        setMainDiseaseModel(i);
      } else {
        _list[i].check = false;
      }
    }
    update();
  }

  setMainDiseaseModel(int i) {
    final ControllerChangeConsultant c = Get.find();
    c.setMainDiseaseModel(_list[i]);
  }
}
