// ignore_for_file: file_names

import 'package:terapizone/features/messages/model/chat_list_model.dart';

import '../model/chat_details_response_model.dart';

abstract class IMessageService {
  final String getChatListPath = IMessageServicePath.chatList.rawValue;
  final String getChatDetailsPath = IMessageServicePath.chatDetails.rawValue;

  Future<ChatListResponseModel?> getChatList();
  Future<List<ChatDetailsModel?>?> getChatDetails(String messageGroupId);
}

enum IMessageServicePath { baseUrl, chatList, chatDetails }

extension IMessageServiceExtension on IMessageServicePath {
  String get rawValue {
    switch (this) {
      case IMessageServicePath.baseUrl:
        return '/Message';
      case IMessageServicePath.chatList:
        return IMessageServicePath.baseUrl.rawValue + "/ChatList";
      case IMessageServicePath.chatDetails:
        return IMessageServicePath.baseUrl.rawValue + "/ChatDetails";
    }
  }
}
