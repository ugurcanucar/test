import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:terapizone/core/enums/enum.dart';
import 'package:terapizone/core/services/endpoint.dart';
import 'package:terapizone/core/services/service_api.dart';
import 'package:terapizone/core/utils/utilities.dart';
import 'package:terapizone/ui/controllers/controller_base.dart';
import 'package:terapizone/ui/models/client_changing_therapist_model.dart';
import 'package:terapizone/ui/models/gender_model.dart';
import 'package:terapizone/ui/models/get_changing_reason_model.dart';
import 'package:terapizone/ui/models/main_disease_model.dart';
import 'package:terapizone/ui/models/response_data_model.dart';
import 'package:terapizone/ui/views/views_user/view_list_consultant.dart';

class ControllerChangeConsultant extends BaseController {
  @override
  void onInit() async {
    super.onInit();
    init();
  }

  Future<void> init() async {
    await getReasons();
  }

  //controllers
  final TextEditingController _controller = TextEditingController();
  TextEditingController get controller => _controller;

  //states
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final RxList<ReasonChangingDtoModel> _reasonList =
      <ReasonChangingDtoModel>[].obs;
  ReasonChangingDtoModel _selectedReason = ReasonChangingDtoModel();
  MainDiseaseModel _mainDiseaseModel = MainDiseaseModel();
  // ignore: unused_field
  GenderModel _genderModel = GenderModel();
  List<int> _diseaseIds = [];
  final RxBool _isAsked = false.obs;
  final RxInt _groupValue = 0.obs; //selected reason
  final RxBool _checkboxValue = false.obs;

  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;
  List<ReasonChangingDtoModel> get reasonList => _reasonList;
  MainDiseaseModel get mainDiseaseModel => _mainDiseaseModel;

  bool get isAsked => _isAsked.value;
  int get groupValue => _groupValue.value;
  bool get checkboxValue => _checkboxValue.value;

  Future<void> getReasons() async {
    setBusy(true);
    ResponseData<GetChangingReasonModel> response = await ApiService.apiRequest(
        Get.context!, ApiMethod.get,
        endpoint: Endpoint.getChangingreason);
    setBusy(false);

    if (response.success && response.data != null) {
      GetChangingReasonModel m = response.data;
      if (m.reasonChangingDtos != null && m.reasonChangingDtos!.isNotEmpty) {
        _reasonList.value = m.reasonChangingDtos!;
      }
      if (_reasonList.isNotEmpty) {
        _reasonList[0].check = true;
        _selectedReason = _reasonList[0];
      }
    } else {
      Utilities.showToast(response.message ?? '');
    }
    update();
  }

  void checkReasonList(index) {
    for (int i = 0; i < _reasonList.length; i++) {
      if (index == i) {
        _reasonList[i].check = true;
        _selectedReason = _reasonList[i];
      } else {
        _reasonList[i].check = false;
      }
    }
    update();
  }

  setIsAsked(bool value) {
    _isAsked.value = value;
  }

  setRadioButton(ind) {
    _groupValue.value = ind;
  }

  setCheckBox(value) {
    _checkboxValue.value = value;
    update();
  }

  setMainDiseaseModel(MainDiseaseModel m) {
    _mainDiseaseModel = m;
  }

  setGenderModel(GenderModel m) {
    _genderModel = m;
  }

  setDiseaseIds(List<int> d) {
    _diseaseIds = d;
  }

  Future<void> clientChangingTherapist() async {
    if (_mainDiseaseModel.id == null) {
      return Utilities.showToast('Lütfen şikayetinizi tekrar seçiniz.');
    } else if (_diseaseIds.isEmpty) {
      return Utilities.showToast('Lütfen şikayet seçimini yapınız.');
    } /* else if (_genderModel.id == null) {
      return Utilities.showToast('Lütfen terapist cinsiyet seçimini yapınız.');
    } */
    else {
      ClientChangingTherapistModel postitem = ClientChangingTherapistModel(
          diseaseIds: _diseaseIds,
          genderId: 1, // _genderModel.id!,
          reasonId: (_selectedReason.id == null) ? null : _selectedReason.id,
          shareData: _checkboxValue.value,
          otherText: "string");
      setBusy(true);

      ResponseData<dynamic> response = await ApiService.apiRequest(
          Get.context!, ApiMethod.post,
          endpoint: Endpoint.clientChangingTherapist, body: postitem.toJson());
      setBusy(false);

      if (response.success) {
        Get.offAll(() => const ViewListConsultant(isFromRegister: false));
      } else {
        Utilities.showToast(response.message!);
      }
    }
  }
}
