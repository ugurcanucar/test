import 'dart:async';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:terapizone/core/enums/enum.dart';
import 'package:terapizone/core/services/endpoint.dart';
import 'package:terapizone/core/services/service_api.dart';
import 'package:terapizone/core/utils/utilities.dart';
import 'package:terapizone/ui/controllers/controller_base.dart';
import 'package:terapizone/ui/models/post_workschedule_setting_model.dart';
import 'package:terapizone/ui/models/response_data_model.dart';
import 'package:terapizone/ui/models/routinebreak_list_model.dart';
import 'package:terapizone/ui/models/workschedule_model.dart';
import 'package:terapizone/ui/models/workschedule_setting_model.dart';
import 'package:terapizone/ui/shared/uitext.dart';

class ControllerCalendarSettings extends BaseController {
  @override
  void onInit() async {
    super.onInit();
    init();
  }

  Future<void> init() async {
    await getWorkschedule();
    await getAllRoutineBreak();
    await getWorkscheduleSetting();
  }

  //controllers

  //states
  final Rx<WorkscheduleModel> _workScheduleDetail = WorkscheduleModel().obs;

  final RxList<RoutineBreakListModel> _routineBreakList = <RoutineBreakListModel>[].obs;
  final Rx<WorkscheduleSettingModel> _workscheduleSettingModel = WorkscheduleSettingModel().obs;

  final RxBool _switchVal = false.obs;
  final RxInt _counter1 = 0.obs;
  final RxInt _counter2 = 0.obs;

  WorkscheduleModel get workScheduleDetail => _workScheduleDetail.value;
  List<RoutineBreakListModel> get routineBreakList => _routineBreakList;
  WorkscheduleSettingModel get workscheduleSettingModel => _workscheduleSettingModel.value;

  bool get switchVal => _switchVal.value;
  int get counter1 => _counter1.value;
  int get counter2 => _counter2.value;

  //get work schedule
  Future<void> getWorkschedule() async {
    _workScheduleDetail.value = WorkscheduleModel();
    ResponseData<WorkscheduleModel> response =
        await ApiService.apiRequest(Get.context!, ApiMethod.get, endpoint: Endpoint.workschedule);
    setBusy(false);

    if (response.success && response.data != null) {
      _workScheduleDetail.value = response.data;
    }
    update();
  }

  //get saved routine breaks from api
  Future<void> getAllRoutineBreak() async {
    ResponseData<List<RoutineBreakListModel>> response =
        await ApiService.apiRequest(Get.context!, ApiMethod.get, endpoint: Endpoint.allRoutineBreak);
    setBusy(false);

    if (response.success && response.data != null) {
      if (response.data.isNotEmpty) {
        _routineBreakList.value = response.data;
      }
    } else {
      inspect("hata burda");

      Utilities.showToast(response.message!);
    }
  }

  //get work schedule
  Future<void> getWorkscheduleSetting() async {
    ResponseData<WorkscheduleSettingModel> response =
        await ApiService.apiRequest(Get.context!, ApiMethod.get, endpoint: Endpoint.workscheduleSetting);
    setBusy(false);

    if (response.success && response.data != null) {
      _workscheduleSettingModel.value = response.data;
      setSwitchVal(_workscheduleSettingModel.value.isOfficialDayWorking!);
      _counter1.value = _workscheduleSettingModel.value.maxAppointmentCount!;
      _counter2.value = _workscheduleSettingModel.value.earliestAppointmentHour!;
    }
    update();
  }

  //save setting
  Future<void> saveWorkscheduleSetting() async {
    setBusy(true);

    PostWorkscheduleSettingModel postitem = PostWorkscheduleSettingModel(
        isOfficialDayWorking: _switchVal.value,
        maxAppointmentCount: _counter1.value,
        earliestAppointmentHour: _counter2.value);
    ResponseData<dynamic> response = await ApiService.apiRequest(Get.context!, ApiMethod.post,
        endpoint: Endpoint.workscheduleSettingSave, body: postitem.toJson());

    inspect(response);
    setBusy(false);

    if (response.success) {
      Utilities.showDefaultDialogConfirm(
          title: UIText.textSuccess, content: UIText.textSettingSaveSuccess, onConfirm: () => Get.back());
    } else {
      inspect("hata burda");

      Utilities.showToast(response.message ?? '');
    }
  }

  setSwitchVal(bool value) {
    _switchVal.value = value;
  }

  increaseCounter1() {
    _counter1.value++;
  }

  decreaseCounter1() {
    if (_counter1.value > 0) _counter1.value--;
  }

  increaseCounter2() {
    _counter2.value++;
  }

  decreaseCounter2() {
    if (_counter2.value > 0) _counter2.value--;
  }
}
