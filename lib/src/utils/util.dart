import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:url_launcher/url_launcher.dart';

class Utils {
  static Future<bool> isInternetConnected() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) return true;
    } on SocketException catch (_) {
      return false;
    }
    return true;
  }

  static launchWhatsApp({@required String phone, message}) async {
    String url() {
      if (Platform.isIOS) {
        return "whatsapp://wa.me/$phone";
      } else {
        return "https://api.whatsapp.com/send?phone=$phone=${Uri.parse(message)}";
      }
    }

    if (await canLaunch(url())) {
      await launch(url());
    } else {
      throw 'Could not launch ${url()}';
    }
  }

  static mapLaunch(double lat, double lng) {
    MapsLauncher.launchCoordinates(lat, lng);
  }

  static phoneLaunch(String phoneNumber) {
    launch("tel://+" + phoneNumber);
  }

  static String timeFormat1(String time) {
    final DateFormat displayFormater = DateFormat('yyyy-MM-dd HH:mm:ss');
    final DateFormat serverFormater = DateFormat('HH:mm');
    final DateTime displayDate = displayFormater.parse(time);
    final String formatted = serverFormater.format(displayDate);
    return formatted;
  }

  static String dateFormat1(String time) {
    final DateFormat displayFormater = DateFormat('yyyy-MM-dd HH:mm:ss');
    final DateFormat serverFormater = DateFormat('MMM dd, yyyy');
    final DateTime displayDate = displayFormater.parse(time);
    final String formatted = serverFormater.format(displayDate);
    return formatted;
  }

  static String dateTimeFormat1(String time) {
    final DateFormat displayFormater = DateFormat('yyyy-MM-dd HH:mm:ss');
    final DateFormat serverFormater = DateFormat('MMM dd, yyyy , HH:mm');
    final DateTime displayDate = displayFormater.parse(time);
    final String formatted = serverFormater.format(displayDate);
    return formatted;
  }

  static String dateTimeFormat2(String date) {
    final DateFormat serverFormater = DateFormat('yyyy-MM-dd');
    final DateFormat displayFormater = DateFormat('yyyy-MM-dd HH:mm:ss');
    final DateTime displayDate = serverFormater.parse(date);
    final String formatted = displayFormater.format(displayDate);
    return formatted;
  }

  static String dateFormat2(String date) {
    final DateFormat displayFormater = DateFormat('yyyy-MM-dd HH:mm:ss');
    final DateFormat serverFormater = DateFormat('yyyy-MM-dd');
    final DateTime displayDate = displayFormater.parse(date);
    final String formatted = serverFormater.format(displayDate);
    return formatted;
  }

  static String dateFormat3(String date) {
    final DateFormat displayFormater = DateFormat('yyyy-MM-dd HH:mm:ss');
    final DateFormat serverFormater = DateFormat('yyyy-MM-dd');
    final DateTime displayDate = displayFormater.parse(date);
    final String formatted = serverFormater.format(displayDate);
    return formatted;
  }

  static String dateFormat5(String date) {
    final DateFormat displayFormater = DateFormat('MMM dd, yyyy');
    final DateFormat serverFormater = DateFormat('yyyy-MM-dd');
    final DateTime displayDate = displayFormater.parse(date);
    final String formatted = serverFormater.format(displayDate);
    return formatted;
  }

  static String dateFormat4(String date) {
    final DateFormat displayFormater = DateFormat('yyyy-MM-dd HH:mm:ss');
    final DateFormat serverFormater = DateFormat('yyyy/MM/dd');
    final DateTime displayDate = displayFormater.parse(date);
    final String formatted = serverFormater.format(displayDate);
    return formatted;
  }
  static String dateTimeFormat6(String time) {
    final DateFormat displayFormater = DateFormat('yyyy-MM-dd HH:mm:ss');
    final DateFormat serverFormater = DateFormat('yyyy-MM-dd , HH:mm');
    final DateTime displayDate = displayFormater.parse(time);
    final String formatted = serverFormater.format(displayDate);
    return formatted;
  }
}
