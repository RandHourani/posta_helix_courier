import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:posta_courier/models/interview_model.dart';
import '../../constants/constants.dart';

class InterviewDataProvider{
  Client client=Client();

  Future<InterviewDataModel> getInterviewTime(String date )
  async {

    var timeUrl=Constants.MAIN_URL+"available_interview_time/available_times?date=$date";
    var response = await client.get(timeUrl);
    print(response.body);
    return InterviewDataModel.fromJson(jsonDecode(response.body));
  }

  Future<void> interview(String body )
  async {
    final storage = new FlutterSecureStorage();
    String accessToken = await storage.read(key:"accessToken");
    String interviewUrl=Constants.MAIN_URL+"interview";
    var request = http.MultipartRequest('POST', Uri.parse(interviewUrl));
    request.headers.addAll({
      "Authorization":"Bearer "+accessToken   ,
      "Accept":"application/json",
    });
    request.files.add
      ( http.MultipartFile.fromString('datetime',body ));
    var res = await request.send();
    print(res.statusCode);
    print("interview");
    print(res.reasonPhrase);

  }



}
String convertDateDisplay(String date) {
  final DateFormat displayFormater = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
  final DateFormat serverFormater = DateFormat('yyyy-MM-dd');
  final DateTime displayDate = displayFormater.parse(date);
  final String formatted = serverFormater.format(displayDate);
  return formatted;
}