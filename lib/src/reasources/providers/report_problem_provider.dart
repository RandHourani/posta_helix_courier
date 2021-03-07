import 'dart:convert';
import 'package:http/http.dart';
import 'package:posta_courier/models/report_problem_model.dart';
import 'package:posta_courier/models/tikets_question_model.dart';
import 'package:posta_courier/src/constants/constants.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class ReportProblemProvider {
  Client client = Client();

  Future<QuestionModel> getTicketQuestion(String typeId) async {
    final storage = new FlutterSecureStorage();
    String accessToken = await storage.read(key: "accessToken");
    var ticket = await client
        .get(Constants.MAIN_URL + "ticket_type/$typeId/questions", headers: {
      "Authorization": "Bearer " + accessToken,
      "Accept": "application/json",
    });
    print(ticket.statusCode);
    print(ticket.body);
    return QuestionModel.fromJson(jsonDecode(ticket.body));
  }

  Future<TicketsQuestionModel> getQuestion(
      String typeId, String parentId) async {
    final storage = new FlutterSecureStorage();
    String accessToken = await storage.read(key: "accessToken");
    var ticket = await client.get(
        Constants.MAIN_URL +
            "ticket_type/$typeId/questions?parent_id=$parentId",
        headers: {
          "Authorization": "Bearer " + accessToken,
          "Accept": "application/json",
        });
    print(ticket.statusCode);
    print(ticket.body);
    return TicketsQuestionModel.fromJson(jsonDecode(ticket.body));
  }

  postTicketQuestion(Map<String, dynamic> body) async {
    print(body);
    final storage = new FlutterSecureStorage();
    String accessToken = await storage.read(key: "accessToken");
    var ticket = await client.post(Constants.MAIN_URL + "ticket",
        headers: {
          "Authorization": "Bearer " + accessToken,
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
        body: json.encode(body));

    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
  }
}
