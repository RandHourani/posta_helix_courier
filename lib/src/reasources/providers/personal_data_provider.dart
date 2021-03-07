import 'dart:convert';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:http/http.dart'as http;
import 'package:posta_courier/models/bank_model.dart';
import 'package:posta_courier/models/nationality_model.dart';

import '../../constants/constants.dart';
class PersonalDataProvider
{
  Client client=Client();
  var nationalityUrl=Constants.MAIN_URL+"nationality";
  var bankUrl="http://development.postahelix.com/api/bank";


  Future<NationalityModel> nationality( )
  async {
    var response = await client.get(nationalityUrl);
    return NationalityModel.fromJson(jsonDecode(response.body));
  }

  setProfileImage(File img)
 async {

   final storage = new FlutterSecureStorage();
   String accessToken = await storage.read(key: "accessToken");
   String id = await storage.read(key: "id");
    var request = http.MultipartRequest('POST', Uri.parse('https://development.postahelix.com/api/captain/$id'));
 request.fields.addAll({
   '_method': 'PUT'
 });
 request.files.add(await http.MultipartFile.fromPath('captain[profile_image]', img.path));
 request.headers.addAll({
   "Authorization": "Bearer " + accessToken,
   "Accept": "application/json",
 });

   http.StreamedResponse response = await request.send();

 if (response.statusCode == 200) {
 print(await response.stream.bytesToString());
 }
   else {
 print(response.reasonPhrase);
 }}


}