import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:posta_courier/models/booking_action_model.dart';
import 'package:posta_courier/models/order_model.dart';
import 'package:posta_courier/models/ride_model.dart';
import 'package:posta_courier/src/reasources/repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:posta_courier/src/constants/application_colors_value.dart';
import 'dart:async';

import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:ui' as ui;
import 'package:flutter/rendering.dart';

class OrderBloc {
  final _repository = Repository();
  final _getOrder = BehaviorSubject<OrderModel>();
  final _orderList = BehaviorSubject<List<OrderDetails>>();
  final _order = BehaviorSubject<OrderDetails>();
  final _getRide = BehaviorSubject<RideModel>();
  final _orderIndex = BehaviorSubject<int>();
  final _orderIndex2 = BehaviorSubject<int>();
  final _orderId = BehaviorSubject<int>();
  final _rideIndex = BehaviorSubject<int>();
  final _rideId = BehaviorSubject<int>();
  final _orderSheet = BehaviorSubject<String>();
  final _bookingAction = BehaviorSubject<BookingAction>();
  final _podScreen = BehaviorSubject<bool>();
  final _imgDialog = BehaviorSubject<bool>();
  final _timer = BehaviorSubject<int>();
  var _polyLines = Set<Polyline>();
  var _sourceMarker = BehaviorSubject<Marker>();
  var _destinationMarker = BehaviorSubject<Marker>();
  var _markersOnMap = BehaviorSubject<Set<Marker>>();
  Set<Marker> _markers = Set<Marker>();
  BitmapDescriptor sourceIcon;
  BitmapDescriptor destinationIcon;

  void setSourceAndDestinationIcons(BuildContext context) async {
    sourceIcon = BitmapDescriptor.fromBytes(
        await getCustomMarker('assets/images/my_location.png', 100));
    //
    // if(_getRide.value.data.bookings.first.status=="PICKED_UP"){
    //   destinationIcon = BitmapDescriptor.fromBytes(
    //       await getCustomMarker('assets/images/pin.png', 70));}
    // else
    // {
    //   destinationIcon = BitmapDescriptor.fromBytes(
    //       await getCustomMarker('assets/images/delivery_pin.png', 70));
    // }
  }

  getMarkers() {
    return _markersOnMap.value;
  }

  void showPinsOnMap() {
    var pinPosition = LatLng(
        _getRide.value.data.bookings.first.pickupLocationPoints.points[1],
        _getRide.value.data.bookings.first.pickupLocationPoints
            .points[0]); // test (_currentLocation)

    var destPosition = LatLng(
        _getRide.value.data.bookings.first.pullDownLocationPoints.points[1],
        _getRide.value.data.bookings.first.pullDownLocationPoints.points[0]);

    _sourceMarker.add(Marker(
        markerId: MarkerId('sourcePin'),
        position: pinPosition,
        icon: sourceIcon,
        anchor: Offset(0.5, 0.6)));

    _destinationMarker.add(Marker(
        markerId: MarkerId('destPin'),
        position: destPosition,
        icon: destinationIcon));

    _markers.add(_sourceMarker.value);
    _markers.add(_destinationMarker.value);
    _markersOnMap.add(_markers);

    setPolyLine();
  }

  Future<Uint8List> getCustomMarker(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
        .buffer
        .asUint8List();
  }

  Observable<String> get orderSheet => _orderSheet.stream;

  Observable<OrderModel> get order => _getOrder.stream;

  Observable<RideModel> get ride => _getRide.stream;

  Observable<BookingAction> get bookingPrice => _bookingAction.stream;

  Observable<List<OrderDetails>> get orderList => _orderList.stream;

  Observable<bool> get pod => _podScreen.stream;

  Observable<bool> get imagePod => _imgDialog.stream;

  Observable<int> get timer => _timer.stream;

  setTimer(int min) {
    _timer.add(min);
  }

  setPrice(BookingAction price) {
    _bookingAction.add(price);
  }

  setOrderSheet(String state) {
    _orderSheet.add(state);
  }

  setPOD(bool value) {
    _podScreen.add(value);
  }

  setImagePOD(bool value) {
    _imgDialog.add(value);
  }

  bookingAction() async {
    BookingAction response = await _repository
        .bookingAction(_getRide.value.data.bookings[_rideIndex.value].id);
    _bookingAction.add(response);
    getOrders("NOT_PAID");
    getRide(_order.value);
  }

  bookingAction2() async {
    getRide2(_orderList.value[_orderList.value
        .indexWhere((element) => _orderId.value == element.orderId)]);
  }

  getBookingAction() {
    return _bookingAction.value;
  }

  acceptOrderSuggestion(int id) {
    _repository.acceptSuggestion(id);
  }

  rejectOrderSuggestion(int id) {
    _repository.rejectSuggestion(id);
    getOrders("NOT_PAID");
  }

  getOrders(String filter) async {
    OrderModel orders = await _repository.getOrders(filter);
    _getOrder.add(orders);
    _orderList.add(_getOrder.value.data.data);
    if (_orderList.value.isEmpty) {
    } else {
      // setNewOrder();
    }
  }

  getOrderList() {
    return _orderList.value;
  }

  setNewOrder() {
    int index = _orderList.value
        .indexWhere((element) => _order.value.orderId == element.orderId);
    _order.add(_orderList.value[index]);
    getRide(_order.value);
  }

  getRide(OrderDetails order) async {
    RideModel ride = await _repository.getRide(order.ride.id);
    _getRide.add(ride);
    orderBloc.setOrderSheet(_getRide.value.data.bookings[0].status);
    _order.add(order);
    _orderId.add(_getRide.value.data.bookings[0].orderId);
    _orderIndex.add(0);
    _rideId.add(order.ride.id);
    _rideIndex.add(_getRide.value.data.bookings
        .indexWhere((element) => element.rideId == order.ride.id));
    setPolyLine();
  }

  getRide2(OrderDetails order) async {
    RideModel ride = await _repository.getRide(order.ride.id);
    _getRide.add(ride);
    orderBloc.setOrderSheet(_getRide.value.data.bookings[0].status);
    _order.add(order);
    _orderId.add(_getRide.value.data.bookings[0].orderId);
    _orderIndex.add(0);
    _rideId.add(order.ride.id);
    _rideIndex.add(_getRide.value.data.bookings
        .indexWhere((element) => element.rideId == order.ride.id));
    setPolyLine();
    bookingAction();
  }

  getRide3() async {
    if (_orderList.value
            .indexWhere((element) => _orderId.value == element.orderId) !=
        null) {
      RideModel ride = await _repository.getRide(_orderList
          .value[_orderList.value
              .indexWhere((element) => _orderId.value == element.orderId)]
          .ride
          .id);
      _getRide.add(ride);
      orderBloc.setOrderSheet(_getRide.value.data.bookings[0].status);
      _order.add(_orderList.value[_orderList.value
          .indexWhere((element) => _orderId.value == element.orderId)]);
      _orderId.add(_getRide.value.data.bookings[0].orderId);
      _orderIndex.add(0);
      _rideId.add(_orderList
          .value[_orderList.value
              .indexWhere((element) => _orderId.value == element.orderId)]
          .ride
          .id);
      _rideIndex.add(_getRide.value.data.bookings.indexWhere((element) =>
          element.rideId ==
          _orderList
              .value[_orderList.value
                  .indexWhere((element) => _orderId.value == element.orderId)]
              .ride
              .id));
      setPolyLine();
    } else {}
  }

  setOrderIndex(int index) {
    _orderIndex2.add(index);
  }

  getRoundBackward() async {
    // getOrders("NOT_PAID");
    // getRide(_orderList.value[_orderIndex2.value]);
    int index = _orderList.value
        .indexWhere((element) => _orderId.value == element.orderId);
    print(index);
    RideModel ride = await _repository.getRide(_orderList
        .value[
            _orderList.value.indexWhere((element) => element.orderId == index)]
        .ride
        .id);
    print(_orderList.value[_orderIndex2.value].ride.id);
    _getRide.add(ride);
    print(_getRide.value.data.id);
    _rideId.add(_orderList.value[_orderIndex2.value].ride.id);
    _rideIndex.add(_getRide.value.data.bookings.indexWhere((element) =>
        element.rideId == _orderList.value[_orderIndex2.value].ride.id));
    setOrderSheet(_getRide.value.data.bookings.first.status);
    _order.add(_orderList.value[_orderIndex2.value]);
  }

  setPolyLine() {
    PolylinePoints polylinePoints = PolylinePoints();
    if (_getRide.value.data.bookings.first.summary != null) {
      List<PointLatLng> result = polylinePoints.decodePolyline(_getRide
          .value
          .data
          .bookings
          .first
          .summary
          .estimatedRout
          .estimatedRoute
          .first
          .points
          .points);
      List<LatLng> polylineCoordinates = [];

      if (result.isNotEmpty) {
        result.forEach((PointLatLng point) {
          polylineCoordinates.add(LatLng(point.latitude, point.longitude));
        });
      }

      _polyLines.add(Polyline(
          width: 3,
          polylineId: PolylineId("poly"),
          color: AppColors.MAIN_COLOR,
          points: polylineCoordinates));
    } else {}
  }

  getPolyLine() {
    return _polyLines;
  }

  getOrder() {
    return _order.value;
  }

  getOrderIndex() {
    return _orderIndex.value;
  }

  getRideIndex() {
    return _rideIndex.value;
  }

  getRideId() {
    return _rideId.value;
  }

  setOrderId(int value) {
    _rideId.add(value);
  }

  getBookingId() {
    return _getRide.value.data.bookings[_rideIndex.value].id;
  }

  getOrderId() {
    return _orderId.value;
  }

  rideData(int index) {
    return _getRide.value.data.bookings[index].status;
  }
}

final orderBloc = OrderBloc();
