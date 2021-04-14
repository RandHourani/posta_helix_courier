import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:posta_courier/src/utils/util.dart';
import 'package:http/http.dart' as http;

import 'package:http/http.dart';
import 'package:posta_courier/models/booking_action_model.dart';
import 'package:posta_courier/models/order_model.dart';
import 'package:posta_courier/models/ride_model.dart';
import 'package:posta_courier/src/constants/constants.dart';
import 'package:posta_courier/src/blocs/home_blocs/order_bloc.dart';

class OrderProvider {
  Client client = Client();

  var bookingUrl = Constants.MAIN_URL + "booking";

  Future<void> confirmSuggestion(int bookingId) async {
    final storage = new FlutterSecureStorage();
    String accessToken = await storage.read(key: "accessToken");
    var response =
        client.put(bookingUrl + "/$bookingId/confirm_suggestion", headers: {
      "Authorization": "Bearer " + accessToken,
      "Accept": "application/json",
    });
  }

  Future<void> refuseSuggestion(int bookingId) async {
    final storage = new FlutterSecureStorage();
    String accessToken = await storage.read(key: "accessToken");
    var response = await client
        .put(bookingUrl + "/$bookingId/refuse_suggestion", headers: {
      "Authorization": "Bearer " + accessToken,
      "Accept": "application/json",
    });
  }

  Future<void> acceptSuggestion(int bookingId) async {
    final storage = new FlutterSecureStorage();
    String accessToken = await storage.read(key: "accessToken");
    var acceptUrl =
        Constants.MAIN_URL + "booking/$bookingId/accept_captain_suggestion";
    var response = await client.post(acceptUrl, headers: {
      "Authorization": "Bearer " + accessToken,
      "Accept": "application/json",
      "Content_Type": "application/json",
    });
    if (response.statusCode == 200) {
      orderBloc.getOrders("NOT_PAID");
    } else {}
    print(response.body);
  }

  Future<void> rejectSuggestion(int bookingId) async {
    final storage = new FlutterSecureStorage();
    String accessToken = await storage.read(key: "accessToken");
    var acceptUrl =
        Constants.MAIN_URL + "booking/$bookingId/reject_captain_suggestion";
    var response = await client.post(acceptUrl, headers: {
      "Authorization": "Bearer " + accessToken,
      "Accept": "application/json",
      "Content_Type": "application/json",
    });
    print(response.body);
  }

  Future<OrderModel> getOrders(String filter) async {
    final storage = new FlutterSecureStorage();
    String accessToken = await storage.read(key: "accessToken");

    var queryParameters = {
      'filter': filter,
      'perPage': 20.toString(),
      "sortBy": "id",
    };

    var uri =
        Uri.http('development.postahelix.com', '/api/order', queryParameters);

    var response = await client.get(uri, headers: {
      "Authorization": "Bearer " + accessToken,
      "Accept": "application/json",
      "Content_Type": "application/json",
    });
    if (response.statusCode == 401) {
      Utils.setScreen('/signIn');
    } else {}
    return OrderModel.formJson(jsonDecode(response.body));
  }

  Future<RideModel> getRide(int id) async {
    final storage = new FlutterSecureStorage();
    String accessToken = await storage.read(key: "accessToken");

    var queryParameters = {
      'perPage': 10.toString(),
    };
    var uri = Uri.http('development.postahelix.com', '/api/ride/$id/bookings',
        queryParameters);

    var response = await client.get(uri, headers: {
      "Authorization": "Bearer " + accessToken,
      "Accept": "application/json",
    });
    print(response.statusCode);
    print(response.body);
    return RideModel.fromJson(jsonDecode(response.body));
  }

  Future<BookingAction> bookingAction(int bookingId) async {
    final storage = new FlutterSecureStorage();
    String accessToken = await storage.read(key: "accessToken");

    var acceptUrl = Constants.MAIN_URL + "booking/$bookingId/action";
    var response = await client.put(acceptUrl, headers: {
      "Authorization": "Bearer " + accessToken,
      "Accept": "application/json",
      "Content_Type": "application/json",
    });
    print(response.statusCode);
    print(response.body);
    return BookingAction.fromJson(jsonDecode(response.body));
  }

  Future<BookingAction> POD(
      int bookingId, String photo, Uint8List sig, String ref) async {
    print("sig");
    print(sig);
    final storage = new FlutterSecureStorage();
    String accessToken = await storage.read(key: "accessToken");
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ' + accessToken
    };
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'http://development.postahelix.com/api/booking/$bookingId/action'));
    request.fields.addAll({
      'proofs[0][type]': 'PHOTO',
      '_method': 'PUT',
      'proofs[0][reference]': ref
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
      orderBloc.getOrders("NOT_PAID");

      return BookingAction.fromJson(jsonDecode(res.body));
    } else {
      print(response.reasonPhrase);
    }

  }

  Future<void> setBookingPay(int bookingId, int price) async {
    final storage = new FlutterSecureStorage();
    String accessToken = await storage.read(key: "accessToken");
    var payUrl = Constants.MAIN_URL + "booking/$bookingId/pay";
    var response = await client.put(payUrl, headers: {
      "Authorization": "Bearer " + accessToken,
      "Accept": "application/json",
      "Content_Type": "application/json",
    }, body: {
      "passenger_paid_amount": price.toString()
    });
  }

  Future<void> setShipperPay(int orderId, int price, String type) async {
    final storage = new FlutterSecureStorage();
    String accessToken = await storage.read(key: "accessToken");
    var payUrl = Constants.MAIN_URL + "order/$orderId/pay";
    var response = await client.post(payUrl, headers: {
      "Authorization": "Bearer " + accessToken,
      "Accept": "application/json",
      "Content_Type": "application/json",
    }, body: {
      "amount": price.toString(),
      "type": type
    });
    // orderBloc.getRide(orderBloc.getOrder());
  }
}
