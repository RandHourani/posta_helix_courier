import 'package:posta_courier/src/reasources/repository.dart';
import 'package:rxdart/rxdart.dart';

import 'order_bloc.dart';

class PaymentBloc {
  final _repository = Repository();

  final _price = BehaviorSubject<String>();

  Observable<String> get payPrice => _price.stream;

  String price = "";

  add(String value) {
    price = price + value;
    _price.add(price);
  }

  remove() {
    price = price.substring(0, price.length - 1);
    _price.add(price);
  }

  paid() async {
    await _repository.setBookingPay(
        orderBloc.getBookingId(), int.parse(_price.value));
    orderBloc.getOrders("NOT_PAID");
  }

  shipperPay() async {
    await _repository.setShipperPay(
        orderBloc.getOrderId(), int.parse(_price.value), "UPFRONT");
    orderBloc.getOrders("NOT_PAID");
  }

  void dispose() {
    _price.close();
  }

  resetPrice() {
    _price.add(null);
    print(_price.value);
    price = " ";
  }
}

final paymentBloc = PaymentBloc();
