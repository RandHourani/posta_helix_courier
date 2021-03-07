import 'dart:convert';

import 'package:http/http.dart';
import 'package:http/http.dart'as http;
import 'package:posta_courier/models/activation_code_model.dart';
import 'package:posta_courier/src/constants/constants.dart';
import 'package:posta_courier/src/blocs/signIn_and_createAccount_blocs/forgot_pass_bloc.dart';
class ActivationCodeProvider {
  Client client = Client();
  var activationCodeUrl = Constants.MAIN_URL + "request/activation_code";
  var verifyCodeUrl = Constants.MAIN_URL + "request/verify";
  var captainRegistrationUrl = Constants.MAIN_URL + "captain";

  Future<ActivationCodeModel> requestForgotPass(String phone) async {
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse(activationCodeUrl));
    request.body = '''{\r\n"phone_number": "$phone",\r\n"provider": "captains",\r\n"forget_password": true\r\n}''';
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      forgotPassBloc.setMessage("success");

    }
    else {
      print(response.reasonPhrase);
      forgotPassBloc.setMessage("No account connected with this phone number");

    }

  }
  Future<ActivationCodeModel> request(String phone) async {
    var response = await client.post(activationCodeUrl, body: {
      "phone_number":phone,
      "provider": "captains",

    });
    return ActivationCodeModel.fromJson(jsonDecode(response.body));
  }

  Future<ActivationCodeModel> verify(Map<String, String> body) async {
    var response = await client.post(verifyCodeUrl, body: body);

    return ActivationCodeModel.fromJson(jsonDecode(response.body));
  }


  Future<ActivationCodeModel> checkUserName(Map<String, dynamic> body) async {
    var response = await client.post(captainRegistrationUrl, body:  json.encode(body),
        headers: {
      "content-type": "application/json",
      "Accept": "application/json"
    });

    return ActivationCodeModel.fromJson(jsonDecode(response.body));
  }
}
