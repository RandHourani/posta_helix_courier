
import 'country_model.dart';

class RideModel {
  Ride data;

  RideModel({this.data});

  factory RideModel.fromJson(Map<String, dynamic> json) {
    return RideModel(
      data: Ride.fromJson(json['data']),
    );
  }
}

class Ride {
  int id;
  int captainId;
  int serviceId;
  int countryId;
  List<Bookings> bookings;

  Ride(
      {this.id, this.captainId, this.serviceId, this.countryId, this.bookings});

  factory Ride.fromJson(Map<String, dynamic> json) {
    var list = json['bookings'] as List;
    List<Bookings> bookings = list.map((i) => Bookings.fromJson(i)).toList();

    return Ride(
      id: json['id'] as int,
      countryId: json['country_id'] as int,
      serviceId: json['service_id'] as int,
      captainId: json['captain_id'] as int,
      bookings: bookings,
    );
  }
}

class Coordinates {
  List<dynamic> points;

  Coordinates({this.points});

  factory Coordinates.fromJson(Map<String, dynamic> json) {
    return Coordinates(
        points: json['coordinates'] != null
            ? (json['coordinates'] as List).map((map) => (map)).toList()
            : null);
  }
}

class Service {
  int id;
  String name;
  bool isPooling;
  int priority;
  int parentId;

  Service({this.id, this.name, this.priority, this.parentId, this.isPooling});

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      id: json['id'] as int,
      name: json['name'] as String,
      isPooling: json['is_pooling'] as bool,
      priority: json['priority'] as int,
      parentId: json['parent_id'] as int,
    );
  }
}

class Bookings {
  int id;
  int orderId;
  String dateTime;
  Coordinates pickupLocationPoints;
  Coordinates pullDownLocationPoints;
  String pickupLocationDetails;
  String pullDownLocationDetails;
  String pickupLocationName;
  String pullDownLocationName;

  //pick_up_voice_recording
  //pull_down_voice_recording
  int useWallet;
  String status;//important
  int passengerId;
  int rideId;
  int voucherId;
  Service service;
  bool isETA;
  int now;
  ContactInfo shipperContactInfo;
  ContactInfo consigneeContactInfo;
  int countryId;
  String passengerName;
  String passengerUsername;
  String passengerProfileImage;
  bool itemExist;
  String stateMessage;
  int price;
  String currencyCode;
  bool cancelable;
  bool toPostaFacilityOnCancellation;
  Order order;
  Summary summary;
  Details country;
  String cancellationStatus;


  Bookings(
      {this.id,
      this.orderId,
      this.countryId,
      this.service,
      this.dateTime,
      this.passengerId,
      this.pickupLocationDetails,
      this.pickupLocationName,
      this.pickupLocationPoints,
      this.pullDownLocationDetails,
      this.pullDownLocationName,
      this.pullDownLocationPoints,
      this.rideId,
      this.status,
      this.useWallet,
      this.voucherId,
      this.summary,
      this.order,
      this.country,
      this.currencyCode,
      this.now,
      this.cancelable,
      this.consigneeContactInfo,
      this.itemExist,
      this.passengerName,
      this.passengerProfileImage,
      this.passengerUsername,
      this.price,
      this.shipperContactInfo,
      this.stateMessage,
      this.cancellationStatus,this.isETA,
      this.toPostaFacilityOnCancellation});

  factory Bookings.fromJson(Map<String, dynamic> json) {
    return Bookings(
        id: json['id'] as int,
        orderId: json['order_id'] as int,
        countryId: json['country_id'] as int,
        service: Service.fromJson(json['service']),
        dateTime: json['datetime'] as String,
        passengerId: json['passenger_id'] as int,
        pickupLocationDetails: json['pick_up_location_details'] as String,
        pickupLocationName: json['pick_up_location_name'] as String,
        pickupLocationPoints: json['pick_up_location'] != null
            ? Coordinates.fromJson(json['pick_up_location'])
            : null,
        pullDownLocationDetails: json['pull_down_location_details'],
        pullDownLocationName: json['pull_down_location_name'] as String,
        pullDownLocationPoints: json['pull_down_location'] != null
            ? Coordinates.fromJson(json['pull_down_location'])
            : null,
        rideId: json['ride_id'] as int,
        status: json['status'] as String,
        useWallet: json['use_wallet'] as int,
        voucherId: json['voucher_id'] as int,
        summary:
            json['summary'] != null ? Summary.fromJson(json['summary']) : null,
        order: Order.fromJson(json['order']),
        country:
            json['country'] != null ? Details.fromJson(json['country']) : null,
        currencyCode: json['currency_code'] as String,
        now: json['now'] as int,
        cancelable: json['cancelable'] as bool,
        consigneeContactInfo: json['consignee_contact_info'] != null
            ? ContactInfo.fromJson(json['consignee_contact_info'])
            : null,
        itemExist: json['item_exist'] as bool,
        passengerName: json['passenger_name'] as String,
        passengerProfileImage: json['passenger_profile_image'] as String,
        passengerUsername: json['passenger_username'] as String,
        price: json['estimated_price'] as int,
        shipperContactInfo: json['shipper_contact_info'] != null
            ? ContactInfo.fromJson(json['shipper_contact_info'])
            : null,
        stateMessage: json['state_message'] as String,
        cancellationStatus: json['cancellation_status'] as String,
      isETA: json['is_eta']as bool,
    toPostaFacilityOnCancellation: json['to_posta_facility_on_cancellation']as bool);
  }
}

class Order {
  int id;
  int passengerId;
  int parentId;
  int serviceId;
  String status;
  String note;
  String payment;
  bool payUpFront;
  int paidUpFront;
  bool roundTrip;//important
  int cashOnDeliveryPaid;
  String cashOnDeliveryOption;
  int cashOnDeliveryAmount;
  String deliverBackOption;

  Coordinates deliverBackLocation;
  String deliverBackLocationDetails;
  String deliverBackLocationName;

  Order(
      {this.id,
      this.passengerId,
      this.parentId,
      this.serviceId,
      this.status,
      this.note,
      this.payment,
      this.paidUpFront,
      this.payUpFront,
      this.roundTrip,
      this.cashOnDeliveryAmount,
      this.cashOnDeliveryOption,
      this.cashOnDeliveryPaid,
      this.deliverBackLocation,
      this.deliverBackLocationDetails,
      this.deliverBackLocationName,
      this.deliverBackOption});

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'] as int,
      passengerId: json['passenger_id'] as int,
      parentId: json['parent_id'] as int,
      serviceId: json['service_id'] as int,
      status: json['status'] as String,
      note: json['note'] as String,
      payment: json['payment_method'] as String,
      paidUpFront: json['paid_upfront'] as int,
      roundTrip: json['round_trip'] as bool,
      cashOnDeliveryAmount: json['cash_on_delivery_amount'] as int,
      cashOnDeliveryOption: json['cash_on_delivery_option'] as String,
      cashOnDeliveryPaid: json['cash_on_delivery_paid'] as int,
      deliverBackLocationDetails:
          json['deliver_back_location_details'] as String,
      deliverBackLocationName: json['deliver_back_location_name'] as String,
      deliverBackOption: json['deliver_back_option'] as String,
      payUpFront: json['pay_upfront'] as bool,
      deliverBackLocation: json['deliver_back_location']!=null?Coordinates.fromJson(json['deliver_back_location']):null

    );
  }
}

class Summary {
  int id;
  int bookingId;

EstimatedRout estimatedRout;
  double captainRating;
  double captainRatingCause;
  double passengerRating;
  double passengerRatingCause;
  double estimatedTime;
  double estimatedDistance;
  double s_pf;
  double us_pf;
  int estimatedPrice;


  Summary(
      {this.id,
      this.bookingId,
      this.estimatedRout,
      this.captainRating,
      this.captainRatingCause,
      this.estimatedDistance,
      this.estimatedTime,
      this.passengerRating,
      this.passengerRatingCause,this.estimatedPrice,
      this.s_pf,this.us_pf});

  factory Summary.fromJson(Map<String, dynamic> json) {
    // var list = json['estimated_route'] as List;
    // List<EstimatedRout> estimatedRouts = list.map((i) => EstimatedRout.fromJson(i)).toList();
    return Summary(
        id: json['id'] as int,
        bookingId: json['booking_id'] as int,
        estimatedRout: json['estimated_route'] != null
            ? EstimatedRout.fromJson(json['estimated_route'])
            : null,
        captainRating: json['captain_rating'] as double,
        captainRatingCause: json['captain_rating_cause'] as double,
        passengerRating: json['passenger_rating'] as double,
        passengerRatingCause: json['passenger_rating_cause'] as double,
        estimatedTime: (json['estimated_time'] +0.0) as double,
        estimatedDistance: json['estimated_distance'] as double,
    estimatedPrice: json['estimated_price']as int,
    s_pf: json['s_pf']as double,
    us_pf: json['us_pf']as double);
  }
}



class EstimatedRout {
  List<Routs> estimatedRoute;

  EstimatedRout({this.estimatedRoute});

  factory EstimatedRout.fromJson(Map<String, dynamic> json) {
    var list = json['routes'] as List;
    List<Routs> routs = list.map((i) => Routs.fromJson(i)).toList();
    return EstimatedRout(estimatedRoute: json!=null?routs:null);
  }
}

class Routs {
  List<Legs> routs;
  PolylinePoint points;
  Routs({this.routs,this.points});

  factory Routs.fromJson(Map<String, dynamic> json) {
    var list = json['legs'] as List;
    List<Legs> routs = list.map((i) => Legs.fromJson(i)).toList();
    return Routs(routs: routs,
    points: PolylinePoint.fromJson(json['overview_polyline']));
  }
}

class PolylinePoint{
  String points;
  PolylinePoint({this.points});
  factory PolylinePoint.fromJson(Map<String,dynamic>json)
  {return PolylinePoint(
    points: json['points']as String
  );}
  
}

// class RoutsData {
//   List<RoutsDetails> routsData;
//
//   RoutsData({this.routsData});
//
//   factory RoutsData.fromJson(Map<String, dynamic> json) {
//     var list = json['routs'] as List;
//     List<RoutsDetails> legs =
//         list.map((i) => RoutsDetails.fromJson(i)).toList();
//     return RoutsData(routsData: legs);
//   }
// }

class RoutsDetails {
  Legs legs;

  RoutsDetails({this.legs});

  factory RoutsDetails.fromJson(Map<String, dynamic> json) {
    return RoutsDetails(
     legs: Legs.fromJson(json['legs'])
    );
  }
}

// class Data {
//   String text;
//   int value;
//
//   Data({this.value, this.text});
//
//   factory Data.fromJson(Map<String, dynamic> json) {
//     return Data(
//       text: json['text'] as String,
//       value: json['value'] as int,
//     );
//   }
// }

class ContactInfo {
  int id;
  String name;
  String phoneNumber;

  ContactInfo({this.id, this.name, this.phoneNumber});

  factory ContactInfo.fromJson(Map<String, dynamic> json) {
    return ContactInfo(
        id: json['id'] as int,
        name: json['name'] as String,
        phoneNumber: json['phone_number'] as String);
  }}

  class Legs{
  List<Steps> steps;
  Legs({this.steps});
  factory Legs.fromJson(Map<String,dynamic>json)
  { var list = json['steps'] as List;
  List<Steps> steps = list.map((i) => Steps.fromJson(i)).toList();
    return Legs(
      steps: steps
    );
  }
  }
  class Steps{
  Points startSteps;
 Points endSteps;
  Steps({this.startSteps,this.endSteps});
  factory Steps.fromJson(Map<String,dynamic>json)
  {
    // var list = json['start_location'] as List;
    //    List<Points> startList = list.map((i) => Points.fromJson(i)).toList();
    //    var list2 = json['end_location'] as List;
    //    List<Points> endList = list2.map((i) => Points.fromJson(i)).toList();
    return Steps(
      startSteps: Points.fromJson(json['start_location']),
          endSteps: Points.fromJson(json['end_location']),
    );
  }
  }
  class Points{
    double lat;
    double lng;
    Points({this.lat,this.lng});

    factory Points.fromJson(Map<String,dynamic>json)
    {
      return Points(
        lat: json['lat']as double,
        lng: json['lng']as double
      );
    }
  }

