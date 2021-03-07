import 'dart:convert';

import 'package:http/http.dart';
import 'package:posta_courier/models/city_model.dart';
import 'package:posta_courier/models/country_model.dart';

import '../../constants/constants.dart';

class CountriesProvider {
  Client client = Client();

  var countryUrl = Constants.MAIN_URL + "country";
  var cityUrl = Constants.MAIN_URL + "cities?country_code=";

  Future<CountryModel> country() async {
    var response = await client.get(countryUrl);
    print(response.body);

    return CountryModel.fromJson(jsonDecode(response.body));
  }

  Future<CityModel> city(String countryCode) async {

    var response = await client.get(cityUrl+countryCode);
    print(response.body);

    return CityModel.fromJson(jsonDecode(response.body));
  }
}
