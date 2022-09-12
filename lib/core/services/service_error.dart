import 'package:get/get.dart';

class ErrorService extends GetxService {
  @override
  Future<ErrorService> onInit() async {
    super.onInit();
    return this;
  }

  Future<dynamic> handleError(Exception exception) async {
    return null;
  }

  Future<dynamic> handleErrorMessage(String exception) async {
    return null;
  }
}
