import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

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

    var uri = Uri.http('development.postahelix.com', '/api/order', queryParameters);

    var response = await client.get(uri, headers: {
      "Authorization": "Bearer " + accessToken,
      "Accept": "application/json",
      "Content_Type": "application/json",
    });
    return OrderModel.formJson(jsonDecode(response.body));
  }

  Future<RideModel> getRide(int id) async {
    final storage = new FlutterSecureStorage();
    String accessToken = await storage.read(key: "accessToken");

    var queryParameters = {
      'perPage': 10.toString(),
    };
    var uri = Uri.http(
        'development.postahelix.com', '/api/ride/$id/bookings', queryParameters);

    var response = await client.get(uri, headers: {
      "Authorization": "Bearer " + accessToken,
      "Accept": "application/json",
    });
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
  Future<BookingAction> POD(int bookingId,String photo,File sig,String ref) async {
    final storage = new FlutterSecureStorage();
    String accessToken = await storage.read(key: "accessToken");

    var acceptUrl = Constants.MAIN_URL + "booking/$bookingId/action";
    var request = http.MultipartRequest('POST', Uri.parse(acceptUrl));
    request.headers.addAll({
      "Authorization": "Bearer " + accessToken,
      "Accept": "application/json",
    });
    request.files.add(
         await http.MultipartFile.fromPath('proofs[0][image][name]',sig.path,filename: "sign.png"));
    request.files.add(  http.MultipartFile.fromString('proofs[0][type]',"PHOTO" ));
    request.files.add(
         http.MultipartFile.fromString('proofs[0][reference]', ref));
    request.files.add( http.MultipartFile.fromString(
        '_method', "PUT"));
    var res = await request.send();
    final respStr = await res.stream.bytesToString();

     print(res.statusCode);
     print(respStr);
    return BookingAction.fromJson(jsonDecode(respStr));






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
    print(response.statusCode);
    print(response.body);
  }

  Future<void> setShipperPay(int orderId, int price,String type) async {
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
    orderBloc.getRide(orderBloc.getOrder());
    print(response.statusCode);
    print(response.body);
  }



}
