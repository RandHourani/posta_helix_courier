import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:posta_courier/models/weekly_report.dart';
import 'package:posta_courier/models/weekly_report_details_model.dart';
import 'package:posta_courier/src/constants/constants.dart';

class WeeklyReportProvider {
  Client client = Client();

  var weeklyReportUrl = Constants.MAIN_URL + "payment?page=1";
  var weeklyReportDetailsUrl = Constants.MAIN_URL + "payment/";

  Future<WeeklyReport> getWeeklyReport() async {
    final storage = new FlutterSecureStorage();
    String accessToken = await storage.read(key: "accessToken");
    var response = await client.get(weeklyReportUrl, headers: {
      "Authorization": "Bearer " + accessToken,
      "Accept": "application/json",
    });
    print(response.statusCode);
    print(response.body);

    return WeeklyReport.fromJson(jsonDecode(response.body));
  }

  Future<WeeklyReportDetailsModel> getWeeklyReportDetails(String id) async {
    final storage = new FlutterSecureStorage();
    String accessToken = await storage.read(key: "accessToken");
    var response = await client.get(weeklyReportDetailsUrl + id, headers: {
      "Authorization": "Bearer " + accessToken,
      "Accept": "application/json",
    });
    print(response.statusCode);
    print(response.body);

    return WeeklyReportDetailsModel.fromJson(jsonDecode(response.body));
  }
}
