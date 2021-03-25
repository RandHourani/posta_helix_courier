import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:posta_courier/src/blocs/home_blocs/online_offline_bloc.dart';
import 'package:posta_courier/src/constants/application_colors_value.dart';
import 'package:posta_courier/src/notifications/notification.dart';
import 'package:posta_courier/src/ui/home/google_maps/home_screen.dart';
import 'package:posta_courier/src/ui/home/side_menu_screens/add_new_car.dart';
import 'package:posta_courier/src/ui/home/google_maps/base_home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'src/blocs/home_blocs/approved_captain_bloc.dart';
import 'src/blocs/home_blocs/order_bloc.dart';
import 'src/blocs/signIn_and_createAccount_blocs/country_cities_bloc.dart';
import 'src/ui/signIn_and_createAccount_screens/welcome_screen.dart';
import 'src/ui/signIn_and_createAccount_screens/signIn_screen.dart';
import 'src/ui/signIn_and_createAccount_screens/personal_details_screen.dart';
import 'src/ui/signIn_and_createAccount_screens/vehicle_details_screen.dart';
import 'src/ui/home/ticket_questions/multi_check_question.dart';
import 'package:posta_courier/db/providers/cities_provider.dart';
import 'package:posta_courier/db/providers/vehicle_brands.dart';
import 'package:posta_courier/db/providers/colors_provider.dart';
import 'src/ui/widgets/refresh_button.dart';
import 'dart:io';
import 'package:posta_courier/src/blocs/signIn_and_createAccount_blocs/rout_sceen.dart';
import 'package:posta_courier/src/blocs/home_blocs/approved_captain_bloc.dart';
import 'package:posta_courier/src/blocs/home_blocs/google_map_bloc.dart';
import 'package:posta_courier/src/blocs/signIn_and_createAccount_blocs/get_captain_data_bloc.dart';
import 'package:posta_courier/models/notification_model.dart';
import 'package:posta_courier/src/ui/home/google_maps/home.dart';

class App extends StatelessWidget {
//   String screen;
// App({this.screen});
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  @override
  Widget build(BuildContext context) {
    CitiesDBProvider.deleteAll();
    BrandsDBProvider.deleteAll();
    ColorsDBProvider.deleteAll();
    onlineOfflineBloc.getCaptainStatus();
    countryBloc.getCountry();
    checkCaptainDataBloc.checkUserAuth();
    initialize(context);
    return MaterialApp(
      theme: ThemeData(
          primaryColor: AppColors.MAIN_COLOR,
          cursorColor: AppColors.MAIN_COLOR),
      debugShowCheckedModeBanner: false,
      initialRoute: screensBloc.getScreen(),
      routes: {
        '/': (context) => WelcomeScreen(),
        '/home': (context) => HomeScreen(),
        '/signIn': (context) => SignInScreen(),
      },
    );
  }

  Future initialize(context) async {
    if (Platform.isIOS) {
      _firebaseMessaging
          .requestNotificationPermissions(IosNotificationSettings());
    }

    String token = await _firebaseMessaging.getToken();
    print("FirebaseMessaging token: $token");

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        // approvedCaptainBloc.checkUserAuth();
        // print("onMessage: $message");
        orderBloc.setTimer(60);
        print(message['data']['code']);
        NotificationModel msg = setNotification(message);
        notificationCode(message['data']['code']);
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        print(new DateTime.fromMillisecondsSinceEpoch(
            message['data']['google.sent_time']));
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        print(new DateTime.fromMillisecondsSinceEpoch(
            message['data']['google.sent_time']));
        print("DateTime.now()");
        print(DateTime.now());
        orderBloc.setTimer(DateTime.now()
            .difference(new DateTime.fromMillisecondsSinceEpoch(
                message['data']['google.sent_time']))
            .inSeconds);
        notificationCode(message['data']['code']);
        // NotificationModel msg = setNotification(message);
      },
      onBackgroundMessage: backgroundMessageHandler,
    );
  }

  NotificationModel setNotification(Map<String, dynamic> body) {
    print(body);
    notificationCode(body['data']['code']);
    return NotificationModel.fromJson(body);
  }

  notificationCode(String code) {
    switch (code) {
      case 'CAPTAIN_CHECK':
        {
          checkCaptainDataBloc.checkUserAuth();
        }
        break;
      case 'BOOKING_SUGGESTION':
        {
          checkCaptainDataBloc.checkUserAuth();
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
}

Future<dynamic> backgroundMessageHandler(Map<String, dynamic> message) async {
  if (message.containsKey('data')) {
    final dynamic data = message['data'];
  }

  if (message.containsKey('notification')) {
    final dynamic notification = message['notification'];
  }
  print("message");
}
