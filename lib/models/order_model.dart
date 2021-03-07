class OrderModel {
  OrderList data;

  OrderModel({this.data});

  factory OrderModel.formJson(Map<String, dynamic> json) {
    return OrderModel(data: OrderList.formJson(json['data']));
  }
}

class OrderList {
  List<OrderDetails> data;

  OrderList({this.data});

  factory OrderList.formJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<OrderDetails> data =
        list.map((i) => OrderDetails.fromJson(i)).toList();
    return OrderList(
      data: data,
    );
  }
}

class OrderDetails {
  int orderId;
  int passengerId;
  int serviceId;
  String status;
  String notes;
  bool roundTrip;
  int cashOnDeliveryPaid;
  String cashOnDeliveryOption;
  int cashOnDeliveryAmount;
  String deliverBackOption;
  // Coordinates deliverBackLocation;
  String deliverBackLocationDetails;
  String deliverBackLocationName;
  String payment;
  bool payUpFront;
  bool waiting;
  String until;
  Passenger passenger;
  Ride ride;

  OrderDetails({
    this.orderId,
    this.serviceId,
    this.passengerId,
    this.status,
    this.notes,
    this.roundTrip,
    this.cashOnDeliveryPaid,
    this.cashOnDeliveryOption,
    this.cashOnDeliveryAmount,
    this.payUpFront,
    this.payment,
    // this.deliverBackLocation,
    this.deliverBackLocationDetails,
    this.deliverBackLocationName,
    this.deliverBackOption,
    this.until,
    this.waiting,
    this.passenger,
    this.ride,
  });

  factory OrderDetails.fromJson(Map<String, dynamic> json) {
    return OrderDetails(
      orderId: json['id'] as int,
      passengerId: json['passenger_id'] as int,
      serviceId: json['service_id'] as int,
      status: json['status'] as String,
      notes: json['notes'] as String,
      roundTrip: json['round_trip'] as bool,
      cashOnDeliveryPaid: json['cash_on_delivery_paid'] as int,
      cashOnDeliveryOption: json['cash_on_delivery_option'] as String,
      cashOnDeliveryAmount: json['cash_on_delivery_amount'] as int,
      payUpFront: json['pay_upfront'] as bool,
      payment: json['payment_method'] as String,
      // deliverBackLocation: Coordinates.fromJson(json['deliver_back_location']),
      deliverBackLocationDetails:
          json['deliver_back_location_details'] as String,
      deliverBackLocationName: json['deliver_back_location_name'] as String,
      deliverBackOption: json['deliver_back_option'] as String,
      until: json['until'] as String,
      waiting: json['waiting'] as bool,
      passenger: Passenger.fromJson(json['passenger']),
      ride: json['ride'] != null ? Ride.fromJson(json['ride']) : null,
    );
  }
}

class Coordinates {
  List<double> points;

  Coordinates({this.points});

  factory Coordinates.fromJson(Map<String, dynamic> json) {
    return Coordinates(
        points: (json['coordinates'] as List).map((map) => (map)).toList());
  }
}

class Passenger {
  int id;
  String userName;
  String email;
  String firstName;
  String lastName;

  // int gender;
  String birthday;
  String profileImage;
  String idCardFront;
  String idCardBack;
  int wallet;
  int rejectCount;
  bool canSeeVIP;
  bool canSeeETA;
  bool canUseVIP;
  bool canUseMTN;

  Passenger({
    this.id,
    this.userName,
    this.email,
    this.firstName,
    this.lastName,
    this.birthday,
    this.profileImage,
    this.idCardFront,
    this.idCardBack,
    this.wallet,
    this.rejectCount,
    this.canSeeETA,
    this.canSeeVIP,
    this.canUseMTN,
    this.canUseVIP,
  });

  factory Passenger.fromJson(Map<String, dynamic> json) {
    return Passenger(
        id: json['id'] as int,
        userName: json['username'] as String,
        email: json['email'] as String,
        firstName: json['first_name'] as String,
        lastName: json['last_name'] as String,
        birthday: json['birthday'] as String,
        profileImage: json['profile_image'] as String,
        idCardBack: json['id_card_back'] as String,
        idCardFront: json['id_card_front'] as String,
        wallet: json['wallet'] as int,
        rejectCount: json['reject_count'] as int,
        canSeeVIP: json['can_see_vip'] as bool,
        canSeeETA: json['can_see_eta'] as bool,
        canUseMTN: json['can_use_mtn'] as bool,
        canUseVIP: json['can_use_vip'] as bool);
  }
}

class Ride {
  int id;
  int bookingCount;
  String pickUpLocationName;
  String passengerName;
  String startDateTime;

  Ride({
    this.id,
    this.bookingCount,
    this.passengerName,
    this.pickUpLocationName,
    this.startDateTime,
  });

  factory Ride.fromJson(Map<String, dynamic> json) {
    return Ride(
      id: json['id'] as int,
      bookingCount: json['booking_count'] as int,
      passengerName: json['passenger_name'] as String,
      pickUpLocationName: json['pick_up_location_name'] as String,
      startDateTime: json['start_datetime'] as String,
    );
  }
}
