import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:http/http.dart';
import 'package:posta_courier/models/tikets_model.dart';
import 'package:posta_courier/src/constants/constants.dart';

class TicketProvider{
  Client client=Client();

  var ticketUrl=Constants.MAIN_URL+"ticket_type/";

  Future<TicketsModel> getTicket(String typeId )
  async {  final storage = new FlutterSecureStorage();
  String accessToken = await storage.read(key: "accessToken");
    var response = await client.get(ticketUrl+typeId+"/questions",headers: {
      "Authorization": "Bearer " + accessToken,
      "Accept": "application/json",
      "Content_Type": "application/json",
    });
    return TicketsModel.fromJson(jsonDecode(response.body));
  }


}