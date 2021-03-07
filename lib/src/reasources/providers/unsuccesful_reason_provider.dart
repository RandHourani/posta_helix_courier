import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:posta_courier/models/unsuccessful_order_model.dart';
import 'package:posta_courier/src/constants/constants.dart';

class UnsuccessfulOrderProvider {
  Client client = Client();

  var unsuccessfulReasonUrl =
      Constants.MAIN_URL + "unsuccessful_order_reasons?type=";

  Future<UnsuccessfulOrderModel> unsuccessfulReason(String type) async {
    final storage = new FlutterSecureStorage();
    String accessToken = await storage.read(key: "accessToken");
    var response = await client.get(unsuccessfulReasonUrl + type, headers: {
      "Authorization": "Bearer " + accessToken,
      "Accept": "application/json",
      "Content_Type": "application/json",
    });
    return UnsuccessfulOrderModel.fromJson(jsonDecode(response.body));
  }

  Future<void> setUnsuccessfulOrder(
      int reasonId, String action, int orderId) async {
    var unsuccessfulOrderUrl = Constants.MAIN_URL + "order/$orderId/action";
    final storage = new FlutterSecureStorage();
    String accessToken = await storage.read(key: "accessToken");

    var response = await client.post(unsuccessfulOrderUrl, headers: {
      "Authorization": "Bearer " + accessToken,
      "Accept": "application/json",
      "Content_Type": "application/json",
    }, body: {
      "action": action,
      "data": {"action": 0, "id": reasonId}
    });

  }
}
