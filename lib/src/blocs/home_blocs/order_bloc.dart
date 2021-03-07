import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:posta_courier/models/booking_action_model.dart';
import 'package:posta_courier/models/order_model.dart';
import 'package:posta_courier/models/ride_model.dart';
import 'package:posta_courier/src/reasources/repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:posta_courier/src/constants/application_colors_value.dart';

class OrderBloc {
  final _repository = Repository();
  final _getOrder = BehaviorSubject<OrderModel>();
  final _orderList = BehaviorSubject<List<OrderDetails>>();
  final _order = BehaviorSubject<OrderDetails>();
  final _getRide = BehaviorSubject<RideModel>();
  final _orderIndex = BehaviorSubject<int>();
  final _orderId = BehaviorSubject<int>();
  final _rideIndex = BehaviorSubject<int>();
  final _rideId = BehaviorSubject<int>();
  final _orderSheet = BehaviorSubject<String>();
  final _bookingAction = BehaviorSubject<BookingAction>();
  final _podScreen = BehaviorSubject<bool>();
  final _imgDialog = BehaviorSubject<bool>();
  var _polyLines = Set<Polyline>();

  Observable<String> get orderSheet => _orderSheet.stream;

  Observable<OrderModel> get order => _getOrder.stream;

  Observable<RideModel> get ride => _getRide.stream;

  Observable<BookingAction> get bookingPrice => _bookingAction.stream;

  Observable<List<OrderDetails>> get orderList => _orderList.stream;

  Observable<bool> get pod => _podScreen.stream;

  Observable<bool> get imagePod => _imgDialog.stream;

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
    // if(_bookingAction.value.data==null)
    //   {setOrderSheet("NULL");
    //  }
    // else
    //   { setNewOrder();}

  }


  acceptOrderSuggestion(int id) {
    _repository.acceptSuggestion(id);
    getOrders("NOT_PAID");
  }

  rejectOrderSuggestion(int id) {
    _repository.rejectSuggestion(id);
    getOrders("NOT_PAID");
  }

  getOrders(String filter) async {
    OrderModel orders = await _repository.getOrders(filter);
    _getOrder.add(orders);
    _orderList.add(_getOrder.value.data.data);
    if(_orderList.value.isEmpty){}
    else
      {
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

  setPolyLine() {
    PolylinePoints polylinePoints = PolylinePoints();

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
