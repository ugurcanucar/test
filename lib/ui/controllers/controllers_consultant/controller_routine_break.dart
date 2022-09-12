import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:terapizone/core/enums/enum.dart';
import 'package:terapizone/core/services/endpoint.dart';
import 'package:terapizone/core/services/service_api.dart';
import 'package:terapizone/core/utils/mocks.dart';
import 'package:terapizone/core/utils/utilities.dart';
import 'package:terapizone/ui/controllers/controller_base.dart';
import 'package:terapizone/ui/controllers/controllers_consultant/controller_calendar_settings.dart';
import 'package:terapizone/ui/models/dummy_day_model.dart';
import 'package:terapizone/ui/models/post_routinebreak_model.dart';
import 'package:terapizone/ui/models/response_data_model.dart';
import 'package:terapizone/ui/models/routinebreak_list_model.dart';
import 'package:terapizone/ui/shared/uitext.dart';

class ControllerRoutineBreak extends BaseController {
  final String? id;

  ControllerRoutineBreak(this.id);

  @override
  void onInit() async {
    super.onInit();
    init();
  }

  //controllers
  final TextEditingController _nameController =
      TextEditingController(text: 'Yeni meşguliyet');
  TextEditingController get nameController => _nameController;
  //states
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final Rx<RoutineBreakListModel> _detail = RoutineBreakListModel().obs;
  final RxList _timeList = [].obs;
  final RxString _startTime = ''.obs;
  final RxString _endTime = ''.obs;
  final RxList<DummyDayModel> _dummyDayList = <DummyDayModel>[].obs;
  final RxString _selectedDays = ''.obs;

  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;
  RoutineBreakListModel get detail => _detail.value;
  List get timeList => _timeList;
  String get startTime => _startTime.value;
  String get endTime => _endTime.value;
  List<DummyDayModel> get dummyDayList => _dummyDayList;
  String get selectedDays => _selectedDays.value;

  Future<void> init() async {
    if (id != null) {
      await getDetail();
    } else {
      for (var element in Mocks().dayList) {
        _dummyDayList.add(DummyDayModel(
            id: Mocks().dayList.indexOf(element) + 1,
            check: Mocks().dayList.indexOf(element) > 4 ? true : false,
            name: element));
      }
      for (var element in _dummyDayList) {
        checkDayList(_dummyDayList.indexOf(element));
      }
    }

    //get available times from api
    await getTimeList();
  }

  //get routine break detail from api
  Future<void> getDetail() async {
    ResponseData<RoutineBreakListModel> response = await ApiService.apiRequest(
        Get.context!, ApiMethod.get,
        endpoint: Endpoint.routineBreakDetail(id: id!));
    setBusy(false);

    if (response.success && response.data != null) {
      _detail.value = response.data;
      _startTime.value = _detail.value.startTime!;
      _endTime.value = _detail.value.endTime!;
      _nameController.text = _detail.value.name!;
      //fill day list
      for (var element in Mocks().dayList) {
        _dummyDayList.add(DummyDayModel(
            id: Mocks().dayList.indexOf(element) + 1,
            check: false,
            name: element));
      }
      //check day list
      if (_detail.value.dayNumbers!.isNotEmpty) {
        _selectedDays.value = ''; //clear selected days text
        for (var element in _detail.value.dayNumbers!) {
          for (var day in _dummyDayList) {
            if (day.id == element) {
              day.check = true;
            }
          }
          if (_selectedDays.isNotEmpty) {
            _selectedDays.value += ' , ';
          }
          _selectedDays.value += Mocks().shortDayList[element - 1];
        }
      }
    } else {
      inspect("hata burda");

      Utilities.showToast(response.message!);
    }
  }

  //delete routine break detail from api
  Future<void> deleteRoutineBreak() async {
    Get.back();
    ResponseData<dynamic> response = await ApiService.apiRequest(
        Get.context!, ApiMethod.delete,
        endpoint: Endpoint.routineBreakDetail(id: id!));
    setBusy(false);

    if (response.success) {
      final ControllerCalendarSettings c = Get.find();
      await c.getAllRoutineBreak();
      Get.back();
      Utilities.showDefaultDialogConfirm(
          title: UIText.textSuccess,
          content: UIText.textDeleteSuccess,
          onConfirm: () => Get.back());
    } else {
      Get.back();
      inspect("hata burda");

      Utilities.showToast(response.message!);
    }
  }

  //post/put routine break
  Future<void> saveRoutineBreak(ApiMethod apiMethod) async {
    List<int> dayNumbers = [];
    if (_dummyDayList.isNotEmpty) {
      for (var element in _dummyDayList) {
        if (element.check!) {
          dayNumbers.add(element.id!);
        }
      }
    }
    setBusy(true);

    RoutineBreakDayplanModel postitem = RoutineBreakDayplanModel(
        name: _nameController.text,
        dayNumbers: dayNumbers,
        startTime: _startTime.value,
        endTime: _endTime.value);
    ResponseData<dynamic> response = await ApiService.apiRequest(
        Get.context!, apiMethod,
        endpoint: apiMethod == ApiMethod.post
            ? Endpoint.routineBreak
            : Endpoint.routineBreak + '/$id',
        body: postitem.toJson());
    setBusy(false);

    if (response.success) {
      final ControllerCalendarSettings c = Get.find();
      await c.getAllRoutineBreak();
      Get.back();
      Utilities.showDefaultDialogConfirm(
          title: UIText.textSuccess,
          content: UIText.textAddRoutineBreak,
          onConfirm: () => Get.back());
    } else {
      inspect("hata burda");

      Utilities.showToast(response.message!);
    }
  }

  //get available times from api
  Future<void> getTimeList() async {
    ResponseData<List<String>> response = await ApiService.apiRequest(
        Get.context!, ApiMethod.get,
        endpoint: Endpoint.workscheduleDayplanTimes);
    setBusy(false);

    if (response.success && response.data != null) {
      _timeList.value = response.data;
      if (_timeList.isNotEmpty && id == null) {
        _startTime.value = _timeList.first;
        _endTime.value = _timeList.last;
      }
    } else {
      inspect("hata burda");

      Utilities.showToast(response.message!);
    }
  }

  setStartTime(int index) {
    _startTime.value = _timeList[index];
  }

  setEndTime(int index) {
    _endTime.value = _timeList[index];
  }

  checkDayList(int index) {
    _dummyDayList[index].check = !_dummyDayList[index].check!;
    _selectedDays.value = ''; //clear selected days text
    for (var element in _dummyDayList) {
      if (element.check!) {
        if (_selectedDays.isNotEmpty) {
          _selectedDays.value += ' , ';
        }
        _selectedDays.value +=
            Mocks().shortDayList[_dummyDayList.indexOf(element)];
      }
    }
    update();
  }
}
