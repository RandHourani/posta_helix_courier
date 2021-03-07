import 'dart:convert';

import 'package:http/http.dart';
import 'package:posta_courier/models/registered_captain_model.dart';
import 'package:posta_courier/src/constants/constants.dart';
import 'package:posta_courier/src/blocs/signIn_and_createAccount_blocs/get_captain_data_bloc.dart';

class SignInProvider {
  Client client = Client();
  var signInUrl = Constants.MAIN_URL + "login";

  Future<LogInModel> request(Map<String, String> body) async {
    var response = await client.post(signInUrl, body: body,  headers: {
      "Accept": "application/json"
    });
    print(response.statusCode.toString());

    return LogInModel.fromJson(jsonDecode(response.body));
  }
}
