import 'package:country_codes/country_codes.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:posta_courier/src/notifications/notification.dart';
import 'app.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:posta_courier/src/blocs/signIn_and_createAccount_blocs/rout_sceen.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  await CountryCodes.init();
  screensBloc.getStringValuesSF();

  runApp(App());
}
