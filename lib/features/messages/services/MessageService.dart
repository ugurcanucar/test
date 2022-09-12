// ignore_for_file: file_names

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:terapizone/features/api_service.dart';
import 'package:terapizone/features/messages/model/chat_list_model.dart';
import 'package:terapizone/features/messages/services/IMessageService.dart';

import '../model/chat_details_response_model.dart';

class MessageService extends IMessageService {
  final ApiService repository = ApiService();

  @override
  Future<ChatListResponseModel?> getChatList() async {
    final Response? response = await repository.get(getChatListPath);
    if (response?.statusCode == 200) {
      return ChatListResponseModel.fromJson(response!.data);
    }
    return null;
  }

  @override
  Future<List<ChatDetailsModel>?> getChatDetails(String messageGroupId) async {
    final Response? response =
        await repository.get("$getChatDetailsPath/$messageGroupId");
    if (response?.statusCode == 200) {
      ChatDetailsResponseModel responseModel =
          ChatDetailsResponseModel.fromJson(response!.data!);
      return responseModel.data;
    }
    return null;
  }

  // @override
  // Future<TherapistModel?> getTherapistList() async {
  //   final Response? response = await repository.get(getAllTherapistPath);
  //   if (response?.statusCode == 200) {
  //     return TherapistModel.fromJson(response!.data);
  //   }
  //   return null;
  // }

}
