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
import 'package:terapizone/ui/models/therapist_list_model.dart';
import 'package:terapizone/ui/views/views_user/view_dashboard.dart';
import 'package:terapizone/ui/views/views_user/view_match_consultant.dart';

class ControllerListConsultant extends BaseController {
  @override
  void onInit() async {
    super.onInit();
    init();
  }

  Future<void> init() async {
    await 3.delay();
    await getList();
    setBusy(false);
  }

  //states
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final RxList<TherapistListModel> _list = <TherapistListModel>[].obs;

  List<TherapistListModel> get list => _list;
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  //get list of consultants (therapists)
  Future<void> getList() async {
    ResponseData<List<TherapistListModel>> response =
        await ApiService.apiRequest(Get.context!, ApiMethod.get,
            endpoint: Endpoint.getlisttherapistclientmatch);
    setBusy(false);
    if (response.success && response.data != null) {
      if (response.data.isNotEmpty) {
        _list.value = response.data;
      }
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
