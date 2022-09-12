import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:terapizone/core/services/endpoint.dart';
import 'package:terapizone/ui/controllers/controller_base.dart';
import 'package:terapizone/ui/models/vimeo_from_url_model.dart';
import 'package:http/http.dart' as http;

String vimeoUrl = '';

class ControllerPlayVimeoVideo extends BaseController {
  @override
  void onInit() async {
    super.onInit();
    init();
  }

  Future<void> init() async {
    getVimeoIDbyUrl();
  }

  //states
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final Rx<VimeoFromUrlModel>? _vimeoVideo = VimeoFromUrlModel().obs;
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;
  VimeoFromUrlModel? get vimeoVideo =>
      _vimeoVideo != null ? _vimeoVideo!.value : null;

  Future<void> getVimeoIDbyUrl() async {
    final response =
        await http.get(Uri.parse(Endpoint.getVimeoIDbyUrl(url: vimeoUrl)));
    setBusy(false);
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.

      _vimeoVideo!.value =
          VimeoFromUrlModel.fromJson(json.decode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}
