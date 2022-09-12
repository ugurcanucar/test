import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:terapizone/core/enums/enum.dart';
import 'package:terapizone/core/services/endpoint.dart';
import 'package:terapizone/core/services/extensions.dart';
import 'package:terapizone/core/services/service_api.dart';
import 'package:terapizone/core/services/service_chronos.dart';
import 'package:terapizone/core/utils/utilities.dart';
import 'package:terapizone/ui/controllers/controller_base.dart';
import 'package:terapizone/ui/models/appointment_join_model.dart';
import 'package:terapizone/ui/models/availability_list_therapist_model.dart';
import 'package:terapizone/ui/models/post_change_time_status.dart';
import 'package:terapizone/ui/models/response_data_model.dart';
import 'package:terapizone/ui/shared/uitext.dart';
import 'package:terapizone/ui/views/view_video_call.dart';

class ControllerCalendar extends BaseController {
  @override
  void onInit() async {
    super.onInit();
    init();
  }

  Future<void> init() async {
    await getList();

    setBusy(false);
  }

  //controllers

  //states
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final RxList<DayAvailabilityListForTherapistModel> _list = <DayAvailabilityListForTherapistModel>[].obs;
  final Rx<DateTime> _selectedDay = DateTime.now().obs;
  final Rx<DateTime> _focusedDay = DateTime.now().obs;
  final RxBool _allDaySwitch = true.obs;

  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;
  List<DayAvailabilityListForTherapistModel> get list => _list;

  DateTime get selectedDay => _selectedDay.value;
  DateTime get focusedDay => _focusedDay.value;
  bool get allDaySwitch => _allDaySwitch.value;

  Future<void> getList() async {
    ResponseData<DayAvailabilityListForTherapistModel> response = await ApiService.apiRequest(
        Get.context!, ApiMethod.get,
        endpoint: Endpoint.dayAvailabilityListForTherapist(date: _selectedDay.value.toIso8601String()));
    setBusy(false);

    if (response.success && response.data != null) {
      _list.value = response.data;
      update();
    } else {
      inspect("hata burda");

      Utilities.showToast(response.message!);
    }
  }

  //on-off switch
  Future<void> setAppointment(int i) async {
    if (DateCompare(DateTime.now()).isPastDate(_selectedDay.value)) {
      return Utilities.showToast(UIText.textNotAllowedPastDates);
    } else if (DateCompare(DateTime.now()).isSameDate(_selectedDay.value)) {
      String time1 = ChronosService.getTime(DateTime.now().toIso8601String());
      time1 = time1.split(':').first;
      String? time2 = list[i].startTime!.split(':').first;

      int t1 = int.parse(time1);
      int t2 = int.parse(time2);

      if (t2 <= t1) {
        inspect("hata burda");

        return Utilities.showToast(UIText.textNotAllowedPastDates);
      }
    }
    PostChangeTimeStatusModel postitem = PostChangeTimeStatusModel(
      status: list[i].availabilityStatus == AvailabilityStatus.available ? false : true,
      date: _selectedDay.value.toIso8601String(),
      startTime: list[i].startTime,
      endTime: list[i].endTime,
    );
    setBusy(true);

    ResponseData<dynamic> response = await ApiService.apiRequest(Get.context!, ApiMethod.post,
        endpoint: Endpoint.changeTimeStatus, body: [postitem.toJson()]);
    setBusy(false);

    if (response.success) {
      AvailabilityStatus availabilityStatus = list[i].availabilityStatus!;
      list[i].availabilityStatus = availabilityStatus == AvailabilityStatus.available
          ? AvailabilityStatus.notAvailable
          : AvailabilityStatus.available;
      update();
    } else {
      inspect("hata burda");

      Utilities.showToast(response.message!);
    }
  }

// set all day button
  Future<void> setAppointmentAllDay(bool switchValue) async {
    //cant set switch values if selected date is past
    if (DateCompare(DateTime.now()).isPastDate(_selectedDay.value)) {
      inspect("hata burda");

      return Utilities.showToast(UIText.textNotAllowedPastDates);
    } else {
      List<PostChangeTimeStatusModel> postList = [];
      for (var element in list) {
        //cant set switch if there is an appointment
        if (element.availabilityStatus != AvailabilityStatus.appointment) {
          //eğer seçili gün bugünse , geçmiş bir saate dair işlem yapılamaz
          if (DateCompare(DateTime.now()).isSameDate(_selectedDay.value)) {
            String currentTime = ChronosService.getTime(DateTime.now().toIso8601String());
            currentTime = currentTime.split(':').first;
            String? time2 = element.startTime!.split(':').first;

            int t1 = int.parse(currentTime);
            int t2 = int.parse(time2);

            if (t1 <= t2) {
              postList.add(PostChangeTimeStatusModel(
                status: switchValue,
                date: _selectedDay.value.toIso8601String(),
                startTime: element.startTime,
                endTime: element.endTime,
              ));
            }
          } else {
            postList.add(PostChangeTimeStatusModel(
              status: switchValue,
              date: _selectedDay.value.toIso8601String(),
              startTime: element.startTime,
              endTime: element.endTime,
            ));
          }
        }
      }
      if (postList.isNotEmpty) {
        setBusy(true);

        ResponseData<dynamic> response = await ApiService.apiRequest(Get.context!, ApiMethod.post,
            endpoint: Endpoint.changeTimeStatus, body: postList.map((p) => p.toJson()).toList());
        setBusy(false);

        if (response.success) {
          _allDaySwitch.value = switchValue;
          await getList();
        } else {
          inspect("hata burda");

          Utilities.showToast(response.message!);
        }
      }
    }
  }

  //cancel appointment
  Future<void> cancelAppointment(AppointmentModel appointment) async {
    ResponseData<dynamic> response = await ApiService.apiRequest(Get.context!, ApiMethod.put,
        endpoint: Endpoint.appointmentCancel(id: appointment.id!), body: {"cancellationReason": ""});
    setBusy(false);

    if (response.success) {
      Utilities.showDefaultDialogConfirm(
        title: UIText.textSuccess,
        content: UIText.textCancelAppointmentSuccess,
        onConfirm: () => Get.back(),
      );
      await getList();
    } else {
      Utilities.showToast(response.message!);
    }
  }

//join appointment
  Future<void> joinAppointment(String id) async {
    setBusy(true);
    ResponseData<AppointmentJoinModel> response =
        await ApiService.apiRequest(Get.context!, ApiMethod.get, endpoint: Endpoint.appointmentJoin(id: id));
    setBusy(false);

    if (response.success && response.data != null) {
      AppointmentJoinModel join = response.data;
      // uid = join.uid!;
      // channel = join.channel!;
      // token = join.token!;
      Get.to(() => ViewVideoCall(
            session: join,
            appointmendId: id,
          ));
    } else {
      inspect("hata burda");

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
}
