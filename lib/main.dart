import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:terapizone/core/utils/general_data.dart';
import 'package:terapizone/core/utils/pages.dart';
import 'package:terapizone/core/utils/routes.dart';
import 'package:terapizone/ui/shared/uicolor.dart';
import 'package:terapizone/ui/shared/uifont.dart';
import 'package:terapizone/ui/shared/uitext.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wakelock/wakelock.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Hive.init((await getApplicationDocumentsDirectory()).path);
  GeneralData.hive = await Hive.openBox(UIText.terapizone);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: UIColor.transparent,
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.light,
  ));
  // To keep the screen on:
  Wakelock.enable(); // or Wakelock.toggle(on: true);
  initializeDateFormatting().then((_) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MVP Terapi',
      fallbackLocale: LocalizationService.fallbackLocale,
      translations: LocalizationService(),
      theme: ThemeData(fontFamily: UIFont.regular),
      initialRoute: Routes.splash,
      getPages: getPages,
      onInit: onFirstRun,
    );
  }

  void onFirstRun() {
    LocalizationService()
        .changeLocale(Get.deviceLocale!.toString()); //set language
    log('app has started');
  }
}
