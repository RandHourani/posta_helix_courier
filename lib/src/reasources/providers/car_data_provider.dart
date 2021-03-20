import 'dart:convert';
import 'package:http/http.dart';
import 'package:posta_courier/models/car_model.dart';

import '../../constants/constants.dart';

class CarDataProvide {
  Client client = Client();
  var carBrandUrl = Constants.MAIN_URL + "car_brand";
  var carBrandListUrl = Constants.MAIN_URL + "car_brand?search=";
  var carColorUrl = Constants.MAIN_URL + "color";

  Future<CarDataModel> carBrand() async {
    var response = await client.get(carBrandUrl);
    return CarDataModel.fromJson(jsonDecode(response.body));
  }

  Future<CarDataModel> carBrandList(String query) async {
    var response = await client
        .get(carBrandListUrl + query, headers: {"Accept": "application/json"});
    if (response.statusCode == 200) {
      return CarDataModel.fromJson(jsonDecode(response.body));
    } else {}
  }

  Future<CarDataModel> carColorRequest() async {
    var response = await client.get(carColorUrl);
    return CarDataModel.fromJson(jsonDecode(response.body));
  }

  Future<CarDataModel> carBrandModel(String id) async {
    var carBrandModelsUrl = Constants.MAIN_URL + "car_brand/$id/models";
    var response = await client.get(carBrandModelsUrl);
    return CarDataModel.fromJson(jsonDecode(response.body));
  }
}
