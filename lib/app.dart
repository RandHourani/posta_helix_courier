import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:posta_courier/src/constants/application_colors_value.dart';
import 'package:posta_courier/src/notifications/notification.dart';
import 'package:posta_courier/src/ui/home/side_menu_screens/add_new_car.dart';
import 'package:posta_courier/src/ui/home/side_menu_screens/vehicle_documents_screen.dart';
import 'src/blocs/home_blocs/approved_captain_bloc.dart';
import 'src/blocs/signIn_and_createAccount_blocs/country_cities_bloc.dart';
import 'src/ui/signIn_and_createAccount_screens/welcome_screen.dart';
import 'src/ui/home/ticket_questions/multi_check_question.dart';
import 'src/ui/widgets/refresh_button.dart';
import 'dart:io';

class App extends StatelessWidget {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  @override
  Widget build(BuildContext context) {
    countryBloc.getCountry();
    initialise(context);

    return MaterialApp(
        theme: ThemeData(
            primaryColor: AppColors.MAIN_COLOR,
            cursorColor: AppColors.MAIN_COLOR),
        debugShowCheckedModeBanner: false,
        home: WelcomeScreen());
  }
  Future initialise(context) async {
    if (Platform.isIOS) {
      _firebaseMessaging.requestNotificationPermissions(IosNotificationSettings());
    }

    String token = await _firebaseMessaging.getToken();
    print("FirebaseMessaging token: $token");

    _firebaseMessaging.configure(
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