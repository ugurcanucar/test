import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:terapizone/ui/controllers/controller_base.dart';

class ControllerNotes extends BaseController {
  @override
  void onInit() async {
    super.onInit();
    init();
  }

  Future<void> init() async {
    setBusy(false);
    _list.add(
        NoteCard(DateTime.now(), "Lorem", "asdasdasdasdasdasdasdasdas", 0));
    _list.add(NoteCard(DateTime.now(), "asd", "asdasdasdasdasdasdasdasdas", 1));
    _list.add(NoteCard(DateTime.now(), "dfg", "asdasdasdasdasdasdasdasdas", 2));
    _list.add(
        NoteCard(DateTime.now(), "hjkhl", "asdasdasdasdasdasdasdasdas", 3));
    _list.add(
        NoteCard(DateTime.now(), "hjkhl", "asdasdasdasdasdasdasdasdas", 4));
    _list.add(
        NoteCard(DateTime.now(), "hjkhl", "asdasdasdasdasdasdasdasdas", 5));
    _list.add(
        NoteCard(DateTime.now(), "hjkhl", "asdasdasdasdasdasdasdasdas", 6));
    _list.add(
        NoteCard(DateTime.now(), "hjkhl", "asdasdasdasdasdasdasdasdas", 7));
    _list.add(NoteCard(
        DateTime.now(),
        "hjkhl",
        "asdasdasdasdasdasdasdasdasdfgggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg",
        8));
    _list.add(
        NoteCard(DateTime.now(), "hjkhl", "asdasdasdasdasdasdasdasdas", 9));
    _list.add(
        NoteCard(DateTime.now(), "hjkhl", "asdasdasdasdasdasdasdasdas", 10));
    _list.add(
        NoteCard(DateTime.now(), "hjkhl", "asdasdasdasdasdasdasdasdas", 11));

    update();
    setBusy(false);
  }

  //controllers

  //states
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  final RxList<NoteCard> _list = <NoteCard>[].obs;

  List<NoteCard> get list => _list;
  // setUpdate(
  //   DateTime? noteDate,
  //   String? noteTitle,
  //   String? noteDetail,
  //   int? value,
  // ) {
  //   _list.add(NoteCard(noteDate, noteDetail, noteTitle, value));
  // }
}

class NoteCard {
  @required
  DateTime? noteDate;
  @required
  String? noteTitle;
  @required
  String? noteDetail;
  int? value;

  NoteCard(
    this.noteDate,
    this.noteTitle,
    this.noteDetail,
    this.value,
  );
}
