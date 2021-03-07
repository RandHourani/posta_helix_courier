class BookingAction {
  Data data;

  BookingAction({this.data});

  factory BookingAction.fromJson(Map<String, dynamic> json) {
    return BookingAction(
      data: Data.fromJson(json['data']),
    );
  }
}

class Data {
  int id;
  String status;
  String currencyCode;
  int price;
  int finalPrice;
  int fee;
  int cashOnDelivery;

  Data(
      {this.id,
      this.status,
      this.currencyCode,
      this.price,
      this.finalPrice,
      this.fee,
      this.cashOnDelivery});

  factory Data.fromJson(Map<String, dynamic> json) {
    if (json['status'] == "DONE") {
      return Data(
          id: json['id'] as int,
          status: json['status'] as String,
          currencyCode: json['currency_code'] as String,
          price: json['price'] as int,
          finalPrice: json['to_pay'] as int,
          fee: json['fee'] as int,
          cashOnDelivery: json['cash_on_delivery_amount']);
    } else {
      return Data(
        id: json['id'] as int,
        status: json['status'] as String,
        currencyCode: json['currency_code'] as String,
      );
    }
  }
}
