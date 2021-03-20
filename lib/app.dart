import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:posta_courier/src/constants/application_colors_value.dart';
import 'package:posta_courier/src/notifications/notification.dart';
import 'package:posta_courier/src/ui/home/google_maps/home_screen.dart';
import 'package:posta_courier/src/ui/home/side_menu_screens/add_new_car.dart';
import 'package:posta_courier/src/ui/home/google_maps/base_home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'src/blocs/home_blocs/approved_captain_bloc.dart';
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

class App extends StatelessWidget {
//   String screen;
// App({this.screen});
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  @override
  Widget build(BuildContext context) {
    CitiesDBProvider.deleteAll();
    BrandsDBProvider.deleteAll();
    ColorsDBProvider.deleteAll();
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
        '/home': (context) => BaseHomeScreen(),
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
    final dynamic data = message['data'];
  }

  if (message.containsKey('notification')) {
    final dynamic notification = message['notification'];
  }
  print("message");
}
