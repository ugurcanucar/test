import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:terapizone/core/utils/utilities.dart';
import 'package:terapizone/ui/controllers/controller_base.dart';
import 'package:terapizone/ui/shared/uitext.dart';
import 'package:terapizone/ui/views/views_consultant/view_calendar.dart';
import 'package:terapizone/ui/views/views_consultant/view_meetings.dart';
import 'package:terapizone/ui/views/views_consultant/view_messages.dart';
import 'package:terapizone/ui/views/views_consultant/view_settings.dart';

class ControllerHome extends BaseController {
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
  final RxInt _selectedIndex = 0.obs;
  Rx<Widget> _selectedView = const ViewMessages().obs;
  final RxList<int> _listHomeNavigation = <int>[].obs;
  final _listViews = <Rx<Widget>>[
    Rx<Widget>(const ViewMessages()), //0
    Rx<Widget>(const ViewMeetings()), //1
    Rx<Widget>(const ViewCalendar()), //2
    Rx<Widget>(const ViewSettings()), //3
  ].obs;

  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;
  get selectedIndex => _selectedIndex.value;
  get selectedView => _selectedView.value;

  List<int> get listHomeNavigation => _listHomeNavigation;

  void setSelectedIndex(int i) {
    _selectedIndex.value = i;
  }

  void homePush(int i) {
    if (_selectedIndex.value != i) {
      _listHomeNavigation.add(i);
      _selectedIndex.value = i;
      _selectedView = _listViews[_selectedIndex.value];
      update();
    }
  }

  void homePop() {
    if (_listHomeNavigation.length != 1) {
      _listHomeNavigation.removeLast();
      _selectedIndex.value = _listHomeNavigation.last;
      _selectedView.value = _listViews[_listHomeNavigation.last].value;
    } else {
      Utilities.showDefaultDialogConfirmCancel(
          title: UIText.textExitAppTitle,
          content: UIText.textExitAppContent,
          onConfirm: () {
            SystemNavigator.pop();
          },
          onCancel: () {
            Get.back();
          });
    }
  }
}
