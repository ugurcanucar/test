import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:terapizone/core/utils/general_data.dart';
import 'package:terapizone/features/user_secure_storage.dart';

import '../config/api_constants.dart';
import 'refresh_token_response_model.dart';

class ApiService {
  final Dio _dio = Dio();
  int tryCount = 0;
  Future<Response?> get(String path) async {
    try {
      String token = GeneralData.getAccessToken();
      Response response = await _dio.get(
        '${ApiConstants.baseUrl}$path',
        options: Options(
          headers: {
            'authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode == 200) {
        return response;
      }
      return null;
    } on DioError catch (e) {
      if (e.response == null) {
        tryCount++;
      }
      if (tryCount < 5 && e.response != null && e.response!.statusCode == 401) {
        print("*************** Token Refreshing ***************");
        // refreshToken();
      }
      return null;
    }
  }

  Future<Response?> post(String path, dynamic data) async {
    try {
      String token = GeneralData.getAccessToken();
      _dio.options.headers[HttpHeaders.authorizationHeader] = "Bearer $token";
      final jsonBody = jsonEncode(data);

      Response response = await _dio.post(
        '${ApiConstants.baseUrl}$path',
        data: jsonBody,
      );
      if (response.statusCode == 200) {
        return response;
      }
      return null;
    } on DioError catch (e) {
      inspect(e);
      return null;
    }
  }

  Future<Response?> put(String path, dynamic data) async {
    try {
      String token = GeneralData.getAccessToken();
      _dio.options.headers[HttpHeaders.authorizationHeader] = "Bearer $token";
      final jsonBody = jsonEncode(data);

      Response response = await _dio.put(
        '${ApiConstants.baseUrl}$path',
        data: jsonBody,
      );
      if (response.statusCode == 200) {
        return response;
      }
      return null;
    } on DioError catch (e) {
      inspect(e);
      return null;
    }
  }

  Future<Response?> delete(String path) async {
    try {
      String token = GeneralData.getAccessToken();
      _dio.options.headers[HttpHeaders.authorizationHeader] = "Bearer $token";

      Response response = await _dio.delete(
        '${ApiConstants.baseUrl}$path',
      );
      if (response.statusCode == 200) {
        return response;
      }
      return null;
    } on DioError catch (e) {
      inspect(e);

      return null;
    }
  }
}
