import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:terapizone/core/enums/enum.dart';
import 'package:terapizone/core/services/endpoint.dart';
import 'package:terapizone/core/services/service_api.dart';
import 'package:terapizone/core/utils/utilities.dart';
import 'package:terapizone/ui/controllers/controller_base.dart';
import 'package:terapizone/ui/models/post_addclienttherapistpreference_model.dart';
import 'package:terapizone/ui/models/response_data_model.dart';
import 'package:terapizone/ui/models/threapist_detail_model.dart';
import 'package:terapizone/ui/views/views_user/view_dashboard.dart';
import 'package:terapizone/ui/views/views_user/view_match_consultant.dart';

class ControllerMeetConsultant extends BaseController {
  final String? id;

  ControllerMeetConsultant(this.id);
  @override
  void onInit() async {
    super.onInit();
    init();
  }

  Future<void> init() async {
    if (id != null) {
      getDetail(id!);
    }
  }

  //states
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final Rx<TherapistDetailModel> _detail = TherapistDetailModel().obs;

  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;
  TherapistDetailModel get detail => _detail.value;

  //get list of consultants (therapists)
  Future<void> getDetail(String id) async {
    ResponseData<TherapistDetailModel> response = await ApiService.apiRequest(
        Get.context!, ApiMethod.get,
        endpoint: Endpoint.getTherapistById(id: id));
    setBusy(false);
    if (response.success && response.data != null) {
      _detail.value = response.data;
    } else {
      Utilities.showToast(response.message!);
    }
  }

  //post selected therapist to match
  Future<void> addClientTherapistPreference(
      String therapistId, String therapistName, String imgUrl,
      {required bool isFromRegister}) async {
    setBusy(true);
    PostAddClientTherapistPreferenceModel postitem =
        PostAddClientTherapistPreferenceModel(therapistId: therapistId);
    ResponseData<dynamic> response = await ApiService.apiRequest(
        Get.context!, ApiMethod.post,
        endpoint: Endpoint.addclienttherapistpreference,
        body: postitem.toJson());

    setBusy(false);

    if (response.success) {
      if (isFromRegister) {
        Get.to(() => ViewMatchConsultant(
              therapistName: therapistName,
              imgUrl: imgUrl,
            ));
      } else {
        Get.offAll(() => const ViewDashboard());
      }
    } else {
      Utilities.showToast(response.message!);
    }
  }
}
