import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:posta_courier/models/notification_model.dart';
import 'package:posta_courier/src/blocs/home_blocs/approved_captain_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PushNotificationService {
  final FirebaseMessaging _fcm;

  PushNotificationService(this._fcm);

  Future initialise(context) async {
    if (Platform.isIOS) {
      _fcm.requestNotificationPermissions(IosNotificationSettings());
    }

    String token = await _fcm.getToken();
    print("FirebaseMessaging token: $token");

    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        // NotificationModel msg = setNotification(message);
        // notificationCode(msg.data.code);

      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        // NotificationModel msg = setNotification(message);
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        // NotificationModel msg = setNotification(message);
      },
      onBackgroundMessage: backgroundMessageHandler,
    );
  }
}

Future<dynamic> backgroundMessageHandler(Map<String, dynamic> message) async {
  if (message.containsKey('data')) {
    // Handle data message
    final dynamic data = message['data'];
  }

  if (message.containsKey('notification')) {
    // Handle notification message
    final dynamic notification = message['notification'];
  }
  print("message");
}

NotificationModel setNotification(Map<String, dynamic> body) {
  return NotificationModel.fromJson(body);
}

notificationCode(String code) {
  switch (code) {
    case 'CAPTAIN_CHECK':
      {
        approvedCaptainBloc.checkUserAuth();
      }
      break;
    case 'BOOKING_SUGGESTION':
      {
        approvedCaptainBloc.checkUserAuth();
      }
      break;
    case 'GPS':
      {}
      break;
    case 'PAYMENT':
      {}
      break;

    case 'new_ride':
      {}
      break;
    case 'CAPTAIN_CHANGED':
      {}
      break;
    case 'CANCELLED':
      {}
      break;
  }
}
