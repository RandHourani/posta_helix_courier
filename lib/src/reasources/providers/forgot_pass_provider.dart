import 'dart:convert';

import 'package:http/http.dart';
import 'package:posta_courier/models/activation_code_model.dart';
import 'package:posta_courier/src/constants/constants.dart';

class ForgotPassProvider {
  Client client = Client();
  var forgotPass = Constants.MAIN_URL + "forget_password";

  Future<ActivationCodeModel> forgotPassRequest(Map<String, String> body) async {
    var response = await client.put(forgotPass, body: body,  headers: {
      "Accept": "application/json"
    });
    print(response.statusCode.toString());
    return ActivationCodeModel.fromJson(jsonDecode(response.body));
  }

}