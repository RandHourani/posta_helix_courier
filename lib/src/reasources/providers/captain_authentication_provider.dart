import 'dart:convert';
import 'package:http/http.dart';
import 'package:posta_courier/models/captain_cars_model.dart';
import 'package:posta_courier/models/online_offline_model.dart';
import 'package:posta_courier/models/registered_captain_model.dart';
import 'package:posta_courier/src/constants/constants.dart';
import 'package:posta_courier/src/utils/util.dart';
import 'package:posta_courier/src/blocs/signIn_and_createAccount_blocs/rout_sceen.dart';
import 'package:posta_courier/src/blocs/signIn_and_createAccount_blocs/signIn_bloc.dart';

class CaptainAuthProvider {
  Client client = Client();

  var checkAuthUrl = Constants.MAIN_URL + "check_auth?version_code=48";
  var checkOnlineOfflineUrl = Constants.MAIN_URL + "check?going_offline=";
  var getCaptainUrl = Constants.MAIN_URL + "captain/";
  var captainCars = Constants.MAIN_URL + "car";

  Future<LogInModel> checkAuth(Map<String, String> header) async {
    var response = await client.get(checkAuthUrl, headers: header);
    if (response.statusCode != 200) {
      Utils.setScreen('/signIn');
      screensBloc.setScreen('/signIn');
      signInBloc.setLoginValidation();
      print("invalid");
    } else {
      return LogInModel.fromJson(jsonDecode(response.body));
    }
  }

  Future<CaptainCarsData> captainCarList(Map<String, String> header) async {
    var response = await client.get(captainCars, headers: header);
    return CaptainCarsData.fromJson(jsonDecode(response.body));
  }

  Future<OnlineOfflineModel> checkCaptainStatus(
      Map<String, String> headers) async {
    var response = await client.put(checkOnlineOfflineUrl, headers: headers);
    print(response.body);
    return OnlineOfflineModel.fromJson(jsonDecode(response.body));
  }

  Future<OnlineOfflineModel> getCaptain(Map<String, String> headers) async {
    var response = await client.put(checkOnlineOfflineUrl, headers: headers);
    print(response.body);
    return OnlineOfflineModel.fromJson(jsonDecode(response.body));
  }
}
