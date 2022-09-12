import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:terapizone/core/enums/enum.dart';
import 'package:terapizone/core/services/endpoint.dart';
import 'package:terapizone/core/services/service_api.dart';
import 'package:terapizone/core/services/service_chronos.dart';
import 'package:terapizone/core/utils/utilities.dart';
import 'package:terapizone/ui/controllers/controller_base.dart';
import 'package:terapizone/ui/controllers/controllers_user/controller_dashboard.dart';
import 'package:terapizone/ui/models/availability_list_client_model.dart';
import 'package:terapizone/ui/models/post_appointment_model.dart';
import 'package:terapizone/ui/models/response_data_model.dart';
import 'package:terapizone/ui/views/views_user/views_video_therapy/view_new_appointment.dart';
import 'package:terapizone/core/services/extensions.dart';

class ControllerNewAppointment extends BaseController {
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
  final RxList<DayAvailabilityListForClientModel> _list =
      <DayAvailabilityListForClientModel>[].obs;

  final Rx<DayAvailabilityListForClientModel>? _selectedTime =
      DayAvailabilityListForClientModel().obs;
  final Rx<DateTime> _selectedDay = DateTime.now().obs;
  final Rx<DateTime> _focusedDay = DateTime.now().obs;

  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;
  List<DayAvailabilityListForClientModel> get list => _list;
  DayAvailabilityListForClientModel get selectedTime => _selectedTime!.value;

  DateTime get selectedDay => _selectedDay.value;
  DateTime get focusedDay => _focusedDay.value;

  // get list of times for client to make an appointment
  Future<void> getList() async {
    setBusy(true);
    ResponseData<List<DayAvailabilityListForClientModel>> response =
        await ApiService.apiRequest(Get.context!, ApiMethod.get,
            endpoint: Endpoint.dayAvailabilityListForClient(
                date: _selectedDay.value.toIso8601String()));
    setBusy(false);

    if (response.success && response.data != null) {
      _list.value = response.data;
      if (DateCompare(DateTime.now()).isPastDate(_selectedDay.value)) {
        for (var element in _list) {
          element.availabilityStatus = AvailabilityStatus.notAvailable;
        }
      } else if (DateCompare(DateTime.now()).isSameDate(_selectedDay.value)) {
        for (var element in _list) {
          String time1 =
              ChronosService.getTime(DateTime.now().toIso8601String());
          time1 = time1.split(':').first;
          String? time2 = element.startTime!.split(':').first;

          int t1 = int.parse(time1);
          int t2 = int.parse(time2);

          if (t2 <= t1) {
            element.availabilityStatus = AvailabilityStatus.notAvailable;
          }
        }
      }
    } else {
      Utilities.showToast(response.message!);
    }
  }

  //make an appointment
  Future<void> setAppointment() async {
    PostAppointmentModel postitem = PostAppointmentModel(
      date: _selectedTime!.value.date,
      startTime: _selectedTime!.value.startTime,
      endTime: _selectedTime!.value.endTime,
    );
    setBusy(true);
    ResponseData<dynamic> response = await ApiService.apiRequest(
        Get.context!, ApiMethod.post,
        endpoint: Endpoint.appointment, body: postitem.toJson());
    setBusy(false);

    if (response.success) {
      successDialog();
      await getList();
      ControllerDashboard controllerDashboard = Get.find();
      await controllerDashboard.getActiveAppointments();
    } else {
      Utilities.showToast(response.message!);
    }
  }

  setSelectedDay(DateTime selectedDay) async {
    _selectedDay.value = selectedDay;
    await getList();
  }

  setFocusedDay(DateTime focusedDay) {
    _focusedDay.value = focusedDay;
  }

  select(int i) {
    if (_list[i].availabilityStatus == AvailabilityStatus.available) {
      for (var element in _list) {
        if (_list.indexOf(element) == i) {
          element.isSelected = true;
        } else {
          element.isSelected = false;
        }
      }
      _selectedTime!.value = _list[i];
      update();
    }
  }
}
