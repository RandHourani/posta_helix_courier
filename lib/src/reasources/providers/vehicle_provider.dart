import 'dart:convert';


import 'package:http/http.dart';
import 'package:posta_courier/models/captain_cars_model.dart';
import 'package:posta_courier/src/constants/constants.dart';

class VehicleProvider{
  Client client=Client();

  var captainCars=Constants.MAIN_URL+"car";
  var selectedCarUrl=Constants.MAIN_URL+"car/";


addNewCar(Map<String,String> header ,Map<String,dynamic> body)
  async {

    var response = await client.post(captainCars,body:json.encode( body),headers: header);
    print(response.body);
  }
  Future<CaptainCarsData> captainCarList(Map<String,String> header )
  async {
    var response = await client.get(captainCars,headers: header);
    return CaptainCarsData.fromJson(jsonDecode(response.body));
  }

  selectCar(String id,Map<String,String> header )
  async {
    var response = await client.put(selectedCarUrl+id.toString()+"/set_default",headers: header);

  }

}