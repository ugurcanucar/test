import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:terapizone/core/enums/enum.dart';
import 'package:terapizone/core/services/endpoint.dart';
import 'package:terapizone/core/services/service_api.dart';
import 'package:terapizone/core/utils/utilities.dart';
import 'package:terapizone/ui/controllers/controller_base.dart';
import 'package:terapizone/ui/controllers/controllers_user/controller_change_consultant/controller_change_consultant.dart';
import 'package:terapizone/ui/models/gender_model.dart';
import 'package:terapizone/ui/models/response_data_model.dart';

class ControllerChangeGender extends BaseController {
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

  final RxList<GenderModel> _genderList = <GenderModel>[].obs;

  List<GenderModel> get genderList => _genderList;
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;
  //get list of genders
  Future<void> getList() async {
    ResponseData<GenderModel> response = await ApiService.apiRequest(
        Get.context!, ApiMethod.get,
        endpoint: Endpoint.gendersGetAll);
    setBusy(false);

    if (response.success && response.data != null) {
      _genderList.value = response.data;
      if (_genderList.isNotEmpty) {
        _genderList.value =
            _genderList.where((item) => item.status == true).toList();
      }
      if (_genderList.isNotEmpty) {
        _genderList[0].check = true;
        setGenderModel(0);
      }
    } else {
      Utilities.showToast(response.message!);
    }
  }

  void checkGenderList(index) {
    for (int i = 0; i < _genderList.length; i++) {
      if (index == i) {
        _genderList[i].check = true;
      } else {
        _genderList[i].check = false;
      }
    }
    update();
  }

  setGenderModel(int i) {
    final ControllerChangeConsultant c = Get.find();
    c.setGenderModel(_genderList[i]);
  }
}
