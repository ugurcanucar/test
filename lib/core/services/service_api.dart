import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as g;
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:retry/retry.dart';
import 'package:terapizone/core/enums/enum.dart';
import 'package:terapizone/core/utils/general_data.dart';
import 'package:terapizone/core/utils/utilities.dart';
import 'package:terapizone/ui/models/response_data_model.dart';
import 'package:terapizone/ui/shared/uitext.dart';
import 'package:terapizone/ui/views/view_splash.dart';

class ApiService {
  static IOClient client = IOClient(HttpClient());

  //static String baseUrl = 'http://cloudapi.thinkwork.dijitalsahne.com/api/';
  //static String fileUrl = 'http://cloudapi.thinkwork.dijitalsahne.com/';
  //static String baseUrl = 'http://testapi.thinkwork.thinkcut.com/api/';
  //static String fileUrl = 'http://testapi.thinkwork.thinkcut.com/';

  static Future<ResponseData<T>> apiRequest<T>(
    BuildContext context,
    ApiMethod apiMethod, {
    required String endpoint,
    var body,
    List<http.MultipartFile>? files,
    bool isActiveToken = true,
  }) async {
    bool isTimeOut = false;
    Duration timeoutDuration = const Duration(minutes: 1);
    FutureOr<Response> Function()? timeoutFunction;
    timeoutFunction = () {
      isTimeOut = true;
      throw ('timeout');
    };
    Uri uri = Uri.parse(endpoint);
    Map<String, String> apiHeader = {'Content-Type': 'application/json'};
    if (GeneralData.getAccessToken().isNotEmpty && isActiveToken) {
      apiHeader.addAll({'Authorization': 'Bearer ' + GeneralData.getAccessToken()});
    }

    try {
      if (await Utilities.isOnline()) {
        switch (apiMethod) {
          case ApiMethod.get:
            log("Get isteği yapıldı !!! $uri ");
            return _responseConverter<T>(
                context,
                await retry(
                    () => client.get(uri, headers: apiHeader).timeout(timeoutDuration, onTimeout: timeoutFunction),
                    retryIf: (Exception p0) {
                  log(p0.toString());
                  return false;
                }, onRetry: (Exception p0) {
                  log("retrye girdi!");
                }),
                isTimeOut);
          case ApiMethod.post:
            return _responseConverter<T>(
                context,
                await client
                    .post(uri, headers: apiHeader, body: jsonEncode(body))
                    .timeout(timeoutDuration, onTimeout: timeoutFunction),
                isTimeOut);
          case ApiMethod.put:
            return _responseConverter<T>(
                context,
                await client
                    .put(uri, headers: apiHeader, body: jsonEncode(body))
                    .timeout(timeoutDuration, onTimeout: timeoutFunction),
                isTimeOut);
          case ApiMethod.delete:
            return _responseConverter<T>(
                context,
                await client.delete(uri, headers: apiHeader).timeout(timeoutDuration, onTimeout: timeoutFunction),
                isTimeOut);
          default:
            return ResponseData(success: false);
        }
      } else {
        return ResponseData(success: false, message: UIText.networkError);
      }
    } on ClientException catch (e) {
      return ResponseData(success: false, message: e.toString());
    } catch (e) {
      return ResponseData(success: false, message: UIText.genericError);
    }
  }

  // static Future<ResponseData<T>> multipartRequest<T>(
  //     BuildContext context,
  //     ApiMethod apiMethod,
  //     String endpoint,
  //     var body,
  //     List<http.MultipartFile> files,
  //     bool isActiveToken) async {
  //   String type = '';
  //   switch (apiMethod) {
  //     case ApiMethod.get:
  //       type = 'GET';
  //       break;
  //     case ApiMethod.post:
  //       type = 'POST';
  //       break;
  //     case ApiMethod.put:
  //       type = 'PUT';
  //       break;
  //     case ApiMethod.delete:
  //       type = 'DELETE';
  //       break;
  //     default:
  //       break;
  //   }

  //   var request = http.MultipartRequest(type, Uri.parse(endpoint));
  //   request.headers.addAll({'Content-Type': 'multipart/form-data'});
  //   if (GeneralData.getAccessToken().isNotEmpty && isActiveToken) {
  //     request.headers
  //         .addAll({'Authorization': 'Bearer ' + GeneralData.getAccessToken()});
  //   }
  //   if (body != null) request.fields.addAll(body);
  //   request.files.addAll(files);
  //   return _responseConverter(
  //       context, await http.Response.fromStream(await request.send()), false);
  // }

  static ResponseData<T> _responseConverter<T>(BuildContext context, Response response, bool isTimeOut) {
    ResponseData<T> o = ResponseData(success: false);
    inspect(o);
    if (isTimeOut) {
      o.success = false;
      o.message = UIText.connectionTimeOut;
    } else {
      if (response.statusCode >= 200 && response.statusCode <= 300) {
        o = ResponseData<T>.fromJson(jsonDecode(response.body));
        if (!o.success && o.data == null && o.message != null) {
          return o;
        }
      } else {
        if (response.statusCode == 401) {
          GeneralData.setPassword('');
          g.Get.reset;
          g.Get.offAll(() => const ViewSplash());
        }
        log("PATLADI!");
        o.success = false;
        o.message = response.reasonPhrase;
      }
    }
    return o;
  }
}
