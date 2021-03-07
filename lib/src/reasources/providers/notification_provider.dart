import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:posta_courier/src/constants/constants.dart';

class NotificationProvider {
  Client client = Client();
  var notificationTokenUrl = Constants.MAIN_URL + "notification_token";

  Future<void> notification(String token) async {
    final storage = new FlutterSecureStorage();
    String accessToken = await storage.read(key: "accessToken");
    var response = await client.post(notificationTokenUrl, body: {
      "notification_token": token
    }, headers: {
      "Authorization": "Bearer " + accessToken,
      "Accept": "application/json"
    });
    print(response.body);
  }
}
