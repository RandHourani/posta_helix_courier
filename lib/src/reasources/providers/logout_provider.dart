import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:posta_courier/src/constants/constants.dart';

class LogOutProvider {
  var client = Client();
  var logoutUrl = Constants.MAIN_URL + "logout";

  Future<void> logOut() async {
    final storage = new FlutterSecureStorage();
    String accessToken = await storage.read(key: "accessToken");
    var response =
    client.put(logoutUrl, headers: {
      "Authorization": "Bearer " + accessToken,
      "Accept": "application/json",
    });
  }
}

