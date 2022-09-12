import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:terapizone/core/enums/enum.dart';
import 'package:terapizone/core/services/endpoint.dart';
import 'package:terapizone/core/services/service_api.dart';
import 'package:terapizone/core/utils/utilities.dart';
import 'package:terapizone/ui/controllers/controller_base.dart';
import 'package:terapizone/ui/controllers/controllers_user/controller_change_consultant/contoller_change_for_who.dart';
import 'package:terapizone/ui/controllers/controllers_user/controller_change_consultant/controller_change_consultant.dart';
import 'package:terapizone/ui/models/disease_model.dart';
import 'package:terapizone/ui/models/main_disease_model.dart';
import 'package:terapizone/ui/models/response_data_model.dart';

class ControllerChangeDisease extends BaseController {
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

  final RxList<DiseaseModel> _topicList = <DiseaseModel>[].obs;
  MainDiseaseModel mainDiseaseModel = MainDiseaseModel();
  List<DiseaseModel> get topicList => _topicList;
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  Future<void> getList() async {
    ResponseData<DiseaseModel> response = await ApiService.apiRequest(
        Get.context!, ApiMethod.get,
        endpoint: Endpoint.diseasesGetAll);
    setBusy(false);

    if (response.success && response.data != null) {
      _topicList.value = response.data;

      //filter the disease list accordding to selected for who info(from previous page)
      ControllerChangeForWho c;
      try {
        c = Get.find();
      } catch (e) {
        c = Get.put(ControllerChangeForWho());
      }

      mainDiseaseModel = c.list.where((element) => element.check == true).first;
      if (mainDiseaseModel.id != null) {
        Iterable<DiseaseModel> iterable =
            _topicList.where((item) => item.parentId == mainDiseaseModel.id);
        if (iterable.isNotEmpty) {
          _topicList.value = iterable.toList();
        }
      }
      if (_topicList.isNotEmpty) {
        _topicList.value =
            _topicList.where((item) => item.status == true).toList();
      }
      if (_topicList.isNotEmpty) {
        checkTopicList(0);
      }
    } else {
      Utilities.showToast(response.message!);
    }
  }

  checkTopicList(int index) {
    bool value = _topicList[index].check!;
    _topicList[index].check = !value;
    setTopicList();
    update();
  }

  setTopicList() {
    List diseaseList = _topicList.where((d) => d.check == true).toList();
    List<int> diseaseIds = [];
    if (mainDiseaseModel.id != null) {
      diseaseIds.add(mainDiseaseModel.id!);
    }
    if (diseaseList.isNotEmpty) {
      for (var element in diseaseList) {
        diseaseIds.add(element.id!);
      }
    }
    final ControllerChangeConsultant c = Get.find();
    c.setDiseaseIds(diseaseIds);
  }

  bool checkListIsNotEmpty() {
    if (_topicList.isNotEmpty) {
      List<DiseaseModel> l =
          _topicList.where((item) => item.check == true).toList();
      if (l.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }
}

class ModelTopic {
  ModelTopic({
    required this.title,
    required this.check,
  });

  String title;
  bool check;
}
