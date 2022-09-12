import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:terapizone/core/enums/enum.dart';
import 'package:terapizone/core/services/endpoint.dart';
import 'package:terapizone/core/services/service_api.dart';
import 'package:terapizone/core/utils/utilities.dart';
import 'package:terapizone/ui/controllers/controller_base.dart';
import 'package:terapizone/ui/controllers/controllers_user/controller_select_topic.dart';
import 'package:terapizone/ui/models/main_disease_model.dart';
import 'package:terapizone/ui/models/post_adduserfirstpreference_model.dart';
import 'package:terapizone/ui/models/response_data_model.dart';
import 'package:terapizone/ui/shared/uitext.dart';

import 'controller_select_for_who.dart';

class ControllerExternalHelp extends BaseController {
  @override
  void onInit() async {
    super.onInit();
    init();
  }

  Future<void> init() async {
    setBusy(false);
  }

  //states
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final List<String> _list = [
    UIText.externalHelpText1,
    UIText.externalHelpText2,
    UIText.externalHelpText3,
    UIText.externalHelpText4,
    UIText.externalHelpText5,
  ];
  final RxBool _checkboxValue = false.obs;

  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;
  List<String> get list => _list;

  bool get checkboxValue => _checkboxValue.value;
  setCheckBox(value) {
    _checkboxValue.value = value;
  }

//post selected diseases and gender
  Future<void> addUserFirstPreference(Function() onTap) async {
    if (!_checkboxValue.value) {
      Utilities.showToast(UIText.toastApproveExternalHelp);
      return;
    }
    //find selected for who
    final ControllerSelectForWho c = Get.find();
    MainDiseaseModel mainDiseaseModel =
        c.list.where((element) => element.check == true).first;

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
      genderId: 1,
    );
    setBusy(true);

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
