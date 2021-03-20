import 'dart:convert';

import 'package:http/http.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:http/http.dart' as http;
import 'package:posta_courier/models/captain_store_model.dart';
import 'package:posta_courier/models/get_captain_model.dart';
import 'package:posta_courier/models/vehicle_model.dart';
import 'package:posta_courier/src/blocs/signIn_and_createAccount_blocs/get_captain_data_bloc.dart';
import 'package:posta_courier/src/constants/constants.dart';
import 'package:posta_courier/src/blocs/home_blocs/new_vehicle_bloc.dart';
import 'package:posta_courier/src/utils/util.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:posta_courier/src/blocs/signIn_and_createAccount_blocs/otp_signIn_bloc.dart';
import 'package:posta_courier/src/blocs/signIn_and_createAccount_blocs/personal_details_bloc.dart';
import 'package:posta_courier/src/blocs/signIn_and_createAccount_blocs/sign_up_bloc.dart';
import 'package:posta_courier/src/blocs/home_blocs/approved_captain_bloc.dart';
import 'package:posta_courier/src/utils/util.dart';

class CaptainProvider {
  Client client = Client();
  var captainRegistrationUrl = Constants.MAIN_URL + "captain?country_code=";
  var vehicleUrl = Constants.MAIN_URL + "captain/";
  var captainDetailsUrl = Constants.MAIN_URL + "captain/";
  var selectedCarUrl=Constants.MAIN_URL+"car/";

  Future<CaptainModel> request(Map<String, dynamic> body) async {
    var response = await client.post(captainRegistrationUrl,
        body: json.encode({  "captain": {
          "activation_code": otpBloc.getSignUpCode().toString(),
          "first_name": personalDetailsBloc.getFirstName().toString(),
          "last_name": personalDetailsBloc.getLastName().toString(),
          "birthday":
          Utils.dateFormat2(personalDetailsBloc.getBirthday().toString()),
          "driving_certificate_end_date": Utils.dateFormat2(
              personalDetailsBloc.getDriverExpiredDate().toString()),
          "driving_certificate_start_date": Utils.dateFormat2(
              personalDetailsBloc.getDriverIssueDate().toString()),
          "email": personalDetailsBloc.getEmail().toString(),
          "gender": personalDetailsBloc.getGender(),
            "nationality_id": personalDetailsBloc.getNationalityId(),
            "password": personalDetailsBloc.getPassword().toString(),
            "password_confirmation":
                personalDetailsBloc.getConfirmPassword().toString(),
            "username": phoneBloc
                .getPhoneNumber()
                .replaceAll(RegExp(r'[^\d]+'), '')
                .toString(),
          },
          "car": [],
          "country_code": phoneBloc.getCountryCode().toString()
        }),
        headers: {
          "content-type": "application/json",
          "Accept": "application/json"
        });
    print(response.statusCode.toString());
    print(response.body);
    return CaptainModel.fromJson(jsonDecode(response.body));
  }

  Future<CaptainModel> editPersonalData(Map<String, dynamic> body) async {
    final storage = new FlutterSecureStorage();
    String id = await storage.read(key: "id");
    String auth = await storage.read(key: "accessToken");
    var response = await client
        .put(vehicleUrl + id.toString(), body: json.encode(body), headers: {
      "Authorization": "Bearer " + auth,
      "content-type": "application/json",
      "Accept": "application/json"
    });
    print(response.statusCode.toString());
    print(response.body);
    checkCaptainDataBloc.checkCaptainData();

    return CaptainModel.fromJson(jsonDecode(response.body));
  }

  Future<CaptainModel> vehicleRequest(
      String id, auth, Map<String, dynamic> body) async {
    print(VehicleModel.carData);
    var response = await client
        .put(vehicleUrl + id.toString(), body: json.encode(body), headers: {
      "Authorization": "Bearer " + auth,
      "content-type": "application/json",
      "Accept": "application/json"
    });
    print(response.statusCode.toString());
    print(response.body);
    checkCaptainDataBloc.checkCaptainData();

    return CaptainModel.fromJson(jsonDecode(response.body));
  }

  newVehicleRequest(
    String id,
    auth,
    String insuranceFront,
    String insuranceBack,
    String vehicleFront,
    String vehicleBack,
  ) async {
    var headers = {'Authorization': 'Bearer ' + auth.toString()};
    var request = http.MultipartRequest(
        'POST', Uri.parse('http://development.postahelix.com/api/car'));
    request.fields.addAll({
      "color_id": newVehicleBloc.getSelectedColorId() != null
          ? (newVehicleBloc.getSelectedColorId()).toString()
          : "1",
      "brand_model_id": (newVehicleBloc.getSelectedModelId().toString()),
      "number": newVehicleBloc.getVehicleNumber().toString(),
      "insurance_expired_date": Utils.dateFormat2(
          newVehicleBloc.getRegistrationExpireDate().toString())
          .toString(),
      "car_manufacture_year":
      newVehicleBloc.getManufacturingYearSelected().toString(),
      "city_id": (newVehicleBloc.getSelectedCountries()).toString(),
      "brand_id": newVehicleBloc.getCarBrandId() != null
          ? (int.parse(newVehicleBloc.getCarBrandId()) + 1).toString()
          : 1,

    });
    request.files.add(await http.MultipartFile.fromPath(
        'insurance_document_front', insuranceFront));
    request.files.add(await http.MultipartFile.fromPath(
        'insurance_document_back', insuranceBack));
    request.files.add(
        await http.MultipartFile.fromPath('car_document_front', vehicleFront));
    request.files.add(
        await http.MultipartFile.fromPath('car_document_back', vehicleBack));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
      print("error");
    }
  }

  selectCar(String id,String auth)
  async {
    var response = await client.put(selectedCarUrl+id.toString()+"/set_default",headers:  {
      "Authorization": "Bearer " + auth,
      "content-type": "application/json",
      "Accept": "application/json"
    });
    approvedCaptainBloc.captainCars();

  }

  Future<void> uploadProfileImage(filename, String auth, String id) async {
    String uploadImage = Constants.MAIN_URL + "captain/" + id;

    var request = http.MultipartRequest('POST', Uri.parse(uploadImage));
    request.headers.addAll({
      "Authorization": "Bearer " + auth,
      "Accept": "application/json",
    });
    request.files.add(
        await http.MultipartFile.fromPath('captain[profile_image]', filename));
    request.files.add(http.MultipartFile.fromString('_method', 'PUT'));
    var res = await request.send();
    print(res.reasonPhrase);
  }

  Future<CaptainData> getCaptainData(String id) async {
    final storage = new FlutterSecureStorage();
    String accessToken = await storage.read(key: "accessToken");
    var response = await client.get(captainDetailsUrl + id.toString(),
        headers: {
          "Authorization": "Bearer " + accessToken,
          "Accept": "application/json"
        });

    print(response.statusCode.toString());
    return CaptainData.fromJson(jsonDecode(response.body));
  }
}
