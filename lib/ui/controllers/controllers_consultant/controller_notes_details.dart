import 'dart:async';
import 'package:flutter/material.dart';
import 'package:terapizone/ui/controllers/controller_base.dart';

class ControllerNoteDetails extends BaseController {
  @override
  void onInit() async {
    super.onInit();
    init();
  }

  Future<void> init() async {
    setBusy(false);
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;
  //controllers
  final TextEditingController _noteTitleController = TextEditingController();
  TextEditingController get noteTitleController => _noteTitleController;

  final TextEditingController _noteTextController = TextEditingController();
  TextEditingController get noteTextController => _noteTextController;

  final focusNoteTitle = FocusNode();
  final focusNoteText = FocusNode();
  //states
  //states
}
