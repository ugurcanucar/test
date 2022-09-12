import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:terapizone/ui/controllers/controller_base.dart';
import 'package:url_launcher/url_launcher.dart';

class ControllerSettings extends BaseController {
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

  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;
  String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  launchEmail() async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'destek@terapizone.com',
      query: encodeQueryParameters(
          <String, String>{'subject': 'Terapizone App Destek'}),
    );
    launch(emailLaunchUri.toString());
  }

  launchPhoneCall() async {
    String _phone = '905366607301';
    String _launched = 'tel:$_phone';

    launch(_launched);
  }

  launchWhatsapp() {
    launch(whatsappUrl());
  }

  String whatsappUrl() {
    String message = '';
    String phone = '905366607301';

    if (Platform.isAndroid) {
      return "https://wa.me/$phone/?text=${Uri.parse(message)}"; // new line
    } else {
      return "https://api.whatsapp.com/send?phone=$phone=${Uri.parse(message)}"; // new line
    }
  }
}
