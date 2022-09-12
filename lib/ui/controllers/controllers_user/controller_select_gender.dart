import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:terapizone/core/enums/enum.dart';
import 'package:terapizone/core/services/endpoint.dart';
import 'package:terapizone/core/services/service_api.dart';
import 'package:terapizone/core/utils/utilities.dart';
import 'package:terapizone/ui/controllers/controller_base.dart';
import 'package:terapizone/ui/controllers/controllers_user/controller_select_topic.dart';
import 'package:terapizone/ui/models/gender_model.dart';
import 'package:terapizone/ui/models/main_disease_model.dart';
import 'package:terapizone/ui/models/post_adduserfirstpreference_model.dart';
import 'package:terapizone/ui/models/response_data_model.dart';

import 'controller_select_for_who.dart';

class ControllerSelectGender extends BaseController {
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
      if (_genderList.isNotEmpty) _genderList[0].check = true;
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

//post selected diseases and gender
  Future<void> addUserFirstPreference(Function() onTap) async {
    //find selected for who
    final ControllerSelectForWho c = Get.find();
    MainDiseaseModel mainDiseaseModel =
        c.list.where((element) => element.check == true).first;

    //find selected gender model
    GenderModel genderModel = _genderList.where((g) => g.check == true).first;
    //find selected diseases
    final ControllerSelectDisease cDisease = Get.find();
    cDisease.topicList;
    List diseaseList =
        cDisease.topicList.where((d) => d.check == true).toList();
    List<int> diseaseIds = [];
    if (mainDiseaseModel.id != null) {
      diseaseIds.add(mainDiseaseModel.id!);
    }
    if (diseaseList.isNotEmpty) {
      for (var element in diseaseList) {
        diseaseIds.add(element.id!);
      }
    }
    PostAddUserFirstPreferenceModel postitem = PostAddUserFirstPreferenceModel(
      diseaseIds: diseaseIds,
      genderId: genderModel.id!,
    );
    ResponseData<dynamic> response = await ApiService.apiRequest(
        Get.context!, ApiMethod.post,
        endpoint: Endpoint.adduserfirstpreference, body: postitem.toJson());
    setBusy(false);

    if (response.success) {
      onTap();
    } else {
      Utilities.showToast(response.message!);
    }
  }

}
