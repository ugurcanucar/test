import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:terapizone/core/enums/enum.dart';
import 'package:terapizone/core/services/endpoint.dart';
import 'package:terapizone/core/services/service_api.dart';
import 'package:terapizone/core/utils/utilities.dart';
import 'package:terapizone/ui/controllers/controller_base.dart';
import 'package:terapizone/ui/models/is_new_client_accepting_model.dart';
import 'package:terapizone/ui/models/response_data_model.dart';
import 'package:terapizone/ui/models/therapist_get_diseases_model.dart';
import 'package:terapizone/ui/models/update_is_new_client_accepting_model.dart';

class ControllerMatchChoices extends BaseController {
  @override
  void onInit() async {
    super.onInit();
    init();
  }

  Future<void> init() async {
    await getList();
    await getIsNewClientAccepting();
  }

  //states
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final RxList<TherapistGetDiseasesModel> _topicList =
      <TherapistGetDiseasesModel>[].obs;
  final RxBool _newClientValue = false.obs;

  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;
  List<TherapistGetDiseasesModel> get topicList => _topicList;
  bool get newClientValue => _newClientValue.value;

  //get list of disease
  Future<void> getList() async {
    ResponseData<List<TherapistGetDiseasesModel>> response =
        await ApiService.apiRequest(Get.context!, ApiMethod.get,
            endpoint: Endpoint.getDiseases);
    if (response.success && response.data != null) {
      _topicList.value = response.data;
    } else {
      inspect("hata burda");

      Utilities.showToast(response.message!);
    }
  }

  Future<void> getIsNewClientAccepting() async {
    ResponseData<IsNewClientAcceptingModel> response =
        await ApiService.apiRequest(Get.context!, ApiMethod.get,
            endpoint: Endpoint.getIsNewNlientAccepting);
    setBusy(false);

    if (response.success && response.data != null) {
      IsNewClientAcceptingModel m = response.data;
      _newClientValue.value = m.isNewClientAccepting ?? false;
    } else {
      inspect("hata burda");

      Utilities.showToast(response.message!);
    }
  }

  Future<bool> updateIsNewClientAccepting(bool value) async {
    UpdateIsNewClientAcceptingModel postBody =
        UpdateIsNewClientAcceptingModel(isNewClientAccepting: value);
    ResponseData<dynamic> response = await ApiService.apiRequest(
        Get.context!, ApiMethod.put,
        endpoint: Endpoint.updateNewClientAccepting, body: postBody.toJson());
    setBusy(false);

    if (response.success) {
      return true;
    } else {
      return false;
    }
  }

  /*  checkTopicList(int index) {
    bool value = _topicList[index].check;
    _topicList[index].check = !value;
    update();
  } */

  setNewClientValue(bool value) async {
    bool result = await updateIsNewClientAccepting(value);
    if (result) {
      _newClientValue.value = value;
    }
  }
}
