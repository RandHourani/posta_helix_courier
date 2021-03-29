import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:posta_courier/models/unsuccessful_order_model.dart';
import 'package:posta_courier/src/constants/constants.dart';
import 'package:http/http.dart' as http;

class UnsuccessfulOrderProvider {
  Client client = Client();

  var unsuccessfulReasonUrl =
      Constants.MAIN_URL + "unsuccessful_order_reasons?type=";

  Future<UnsuccessfulOrderModel> unsuccessfulReason(String type) async {
    final storage = new FlutterSecureStorage();
    String accessToken = await storage.read(key: "accessToken");
    var response = await client.get(unsuccessfulReasonUrl + type, headers: {
      "Authorization": "Bearer " + accessToken,
      "Accept": "application/json",
      "Content_Type": "application/json",
    });
    return UnsuccessfulOrderModel.fromJson(jsonDecode(response.body));
  }

  Future<void> setUnsuccessfulOrder(int reasonId, String action, int orderId,
      String photo, Uint8List sig, String ref) async {
    var unsuccessfulOrderUrl = Constants.MAIN_URL + "order/$orderId/action";
    final storage = new FlutterSecureStorage();
    String accessToken = await storage.read(key: "accessToken");
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ' + accessToken
    };
    var request =
        http.MultipartRequest('POST', Uri.parse(unsuccessfulOrderUrl));
    request.fields.addAll({
      'proofs[0][type]': 'PHOTO',
      'proofs[0][reference]': ref,
      "action": action,
      'data[action]': 0.toString(),
      'data[id]': reasonId.toString()
    });
    if (photo != null) {
      request.files.add(await http.MultipartFile.fromPath(
          'proofs[0][image]', photo,
          filename: 'photo.jpg'));
    } else {
      var multipartFile = http.MultipartFile.fromBytes(
        'proofs[0][image]',
        sig,
        filename: 'sign.jpg', // use the real name if available, or omit
        // contentType: MediaType('image', 'jpg'),
      );

      request.files.add(multipartFile);
    }
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      http.Response res = await http.Response.fromStream(response);
      print(res.body);
    } else {
      print(response.reasonPhrase);
    }
    // var response = await client.post(unsuccessfulOrderUrl, headers: {
    //   "Authorization": "Bearer " + accessToken,
    //   "Accept": "application/json",
    //   "Content_Type": "application/json",
    // }, body: {
    //   "action": action,
    //   "data": {"action": 0, "id": reasonId}
    // });
  }
}
