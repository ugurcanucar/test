import 'package:get/get.dart';
import 'package:terapizone/core/utils/routes.dart';
import 'package:terapizone/ui/views/view_splash.dart';
import 'package:terapizone/ui/views/view_video_call.dart';

List<GetPage> getPages = [
  GetPage(
    name: Routes.splash,
    page: () => const ViewSplash(),
  ),
  // GetPage(
  //   name: Routes.dummy,
  //   page: () =>  ViewVideoCall(),
  // ),
];
