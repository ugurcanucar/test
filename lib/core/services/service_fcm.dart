import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:terapizone/core/utils/general_data.dart';
import 'package:terapizone/ui/controllers/controller_chat.dart';
import 'package:terapizone/ui/models/chat_detail_model.dart';
import 'package:terapizone/ui/views/view_chat.dart';

String? payloadFromFCM;
String? notificationTypeIdMsg = 'Message';

/// Create a [AndroidNotificationChannel] for heads up notifications
AndroidNotificationChannel? channel;

/// Initialize the [FlutterLocalNotificationsPlugin] package.
FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;

class FCMService with ChangeNotifier {
  //constants
  static BuildContext? context;
  static FirebaseMessaging? fire;

  static void notificataionSettings(BuildContext context) async {
    try {
      FCMService.context = context;
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp();
      // Set the background messaging handler early on, as a named top-level function
      if (Platform.isAndroid) {
        FirebaseMessaging.onBackgroundMessage(onBackground);
      } else {
        FirebaseMessaging.onBackgroundMessage(onBackgroundIOS);
      }
      FirebaseMessaging.onMessage.listen((message) {
        onMessage(message);
      });
      FirebaseMessaging.onMessageOpenedApp.listen((message) {
        onBackground(message);
      });

      if (!kIsWeb) {
        channel = const AndroidNotificationChannel(
          'high_importance_channel', // id
          'High Importance Notifications', // title
          description:
              'This channel is used for important notifications.', // description
          importance: Importance.high,
        );

        flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

        /// Create an Android Notification Channel.
        ///
        /// We use this channel in the `AndroidManifest.xml` file to override the
        /// default FCM channel to enable heads up notifications.
        await flutterLocalNotificationsPlugin!
            .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>()
            ?.createNotificationChannel(channel!);

        /// Update the iOS foreground notification presentation options to allow
        /// heads up notifications.
        await FirebaseMessaging.instance
            .setForegroundNotificationPresentationOptions(
          alert: true,
          badge: true,
          sound: true,
        );
        await flutterLocalNotificationsPlugin!
            .resolvePlatformSpecificImplementation<
                IOSFlutterLocalNotificationsPlugin>()
            ?.requestPermissions(
              alert: true,
              badge: true,
              sound: true,
            );
      }
      await FirebaseMessaging.instance.getToken().then((token) {
        log(token ?? '');
        GeneralData.setFCMToken(token);
      });
      var initAndroid =
          const AndroidInitializationSettings('mipmap/ic_notification');
      var initIOS = const IOSInitializationSettings();
      var initPlatform =
          InitializationSettings(android: initAndroid, iOS: initIOS);
      await flutterLocalNotificationsPlugin!
          .initialize(initPlatform, onSelectNotification: onSelectNotification);
    } catch (e) {
      log(e.toString());
    }
  }

  static Future<dynamic> onSelectNotification(String? payload) async {
    if (payloadFromFCM != null && payloadFromFCM!.isNotEmpty) {
      ChatDetailModel o = ChatDetailModel.fromJson(jsonDecode(payloadFromFCM!));
      if (o.notificationTypeId == notificationTypeIdMsg) {
        if (!isChatOpen) {
          Get.to(() => ViewChat(messageGroupId: o.messageGroupId));
        } else if (isChatOpen) {
          ControllerChat c = Get.find();

          if (c.chatList.isNotEmpty) {
            if (c.chatList[0].senderUserId == o.senderUserId) {
              if (Platform.isIOS) {
                c.messageGroupId = o.messageGroupId;
                c.getDetail();
              } else {
                c.getNotificationMsg(o);
              }
            } else {
              c.messageGroupId = o.messageGroupId;
              c.getDetail();
            }
          }
        }
      }
    }
  }

  static Future<void> onBackground(RemoteMessage message) async {
    Map<String, dynamic> msg = message.data;
    log(msg.toString());
    // ignore: unused_local_variable
    ChatDetailModel p = ChatDetailModel();
    if (Platform.isIOS) {
      p = ChatDetailModel.fromJson(msg);
    } else {
      p = ChatDetailModel.fromJson(msg);
    }
    payloadFromFCM = jsonEncode(p.toJson());
    onSelectNotification(payloadFromFCM);
  }

  static Future<void> onBackgroundIOS(RemoteMessage message) async {
    //dummy method
  }

  static Future<void> onMessage(RemoteMessage message) async {
    Map<String, dynamic> msg = message.data;

    ChatDetailModel p = ChatDetailModel();
    if (Platform.isIOS) {
      p = ChatDetailModel.fromJson(msg);
    } else {
      p = ChatDetailModel.fromJson(msg);
    }
    var androidSpecifics = const AndroidNotificationDetails(
        'jain channel id', 'jain channel name',
        channelDescription: 'jain channel description',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
        channelAction: AndroidNotificationChannelAction.createIfNotExists);
    var iosSpecifics = const IOSNotificationDetails();
    var platformSpecifics =
        NotificationDetails(android: androidSpecifics, iOS: iosSpecifics);
    if (!isChatOpen) {
      payloadFromFCM = jsonEncode(p.toJson());
      //Burada çift olduğu için local
      if (!Platform.isIOS) {
        await flutterLocalNotificationsPlugin!.show(
          1,
          p.nickname,
          p.text,
          platformSpecifics,
          payload: payloadFromFCM,
        );
      }
    } else {
      payloadFromFCM = jsonEncode(p.toJson());
      onSelectNotification(payloadFromFCM);
    }
    log(p.toString());
  }
}
