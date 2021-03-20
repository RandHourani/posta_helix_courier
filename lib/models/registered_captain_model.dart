import 'package:posta_courier/models/ride_model.dart';

class LogInModel {
  DataDetails data;
  String message = "";

  LogInModel({this.data, this.message});

  factory LogInModel.fromJson(Map<String, dynamic> json) {
    return LogInModel(
      data: json['data'] == null ? null : DataDetails.fromJson(json['data']),
      message: json['message'] as String,
    );
  }
}

class DataDetails {
  int id;
  String username;
  String firstName;
  String lastName;
  String accessToken;
  String email;
  String birthday;
  String drivingCertificateStartDate;
  String drivingCertificateEndDate;
  String profileImage;
  String idCardFront;
  String idCardBack;
  String drivingCertificateFront;
  String drivingCertificateBack;
  int nationalityId;
  int bankId;
  int countryId;
  Car car;
  String approvedAt;
  ActiveSuggestion activeSuggestion;
  String rating;
  Interview interview;
  bool goingOffline;

  DataDetails({this.username,
    this.id,
    this.firstName,
    this.lastName,
    this.accessToken,
    this.email,
    this.birthday,
    this.drivingCertificateStartDate,
    this.drivingCertificateEndDate,
    this.profileImage,
    this.idCardFront,
    this.idCardBack,
    this.drivingCertificateFront,
    this.drivingCertificateBack,
    this.nationalityId,
    this.bankId,
    this.countryId,
    this.car, this.approvedAt,
    this.activeSuggestion,
    this.rating, this.interview, this.goingOffline});

  factory DataDetails.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    return DataDetails(
        id: json['id'] as int,
        username: json['username'] as String,
        firstName: json['first_name'] as String,
        lastName: json['last_name'] as String,
        accessToken: json['accessToken'] as String,
        email: json['email'] as String,
        birthday: json['birthday'] as String,
        drivingCertificateStartDate:
        json['driving_certificate_start_date'] as String,
        drivingCertificateEndDate:
        json['driving_certificate_end_date'] as String,
        profileImage: json['profile_image'] as String,
        idCardFront: json['id_card_front'] as String,
        idCardBack: json['id_card_back'] as String,
        drivingCertificateFront: json['driving_certificate_front'] as String,
        drivingCertificateBack: json['driving_certificate_back'] as String,
        nationalityId: json['nationality_id'] as int,
        bankId: json['bank_id'] as int,
        countryId: json['country_id'] as int,
        car: Car.fromJson(json['cars']),
        goingOffline: json['goingOffline'] as bool,
        interview: json['interview'] != null ? Interview.fromJson(
            json['interview']) : null,
        rating: json['avg_rating'] as String,
        approvedAt: json['approved_at'] != null
            ? json['approved_at'] as String
            : null,
        activeSuggestion: json['active_suggestion'] != null ? ActiveSuggestion
            .fromJson(json['active_suggestion']) : null);
  }
}

class Car {
  List<CarData> car;

  Car({this.car});

  factory Car.fromJson(json) {
    var list = json as List;
    List<CarData> data = list.map((i) => CarData.fromJson(i)).toList();
    return Car(car: data);
  }
}

class CarData {
  int id;
  String insuranceExpiredDate;
  int carManufactureYear;
  String insuranceDocumentFront;
  String insuranceDocumentBack;
  int colorId;
  int brandModelId;
  int cityId;
  String number ;
  CarData(
      {this.id,
      this.insuranceExpiredDate,
      this.brandModelId,
      this.carManufactureYear,
      this.cityId,
      this.colorId,
      this.insuranceDocumentBack,
      this.insuranceDocumentFront,this.number});

  factory CarData.fromJson(Map<String, dynamic> json) {
    return CarData(
      id: json['id'] as int,
      insuranceExpiredDate: json['insurance_expired_date'] as String,
      carManufactureYear: json['car_manufacture_year'] as int,
      insuranceDocumentFront: json['insurance_document_front'] as String,
      insuranceDocumentBack: json['insurance_document_back'] as String,
      cityId: json['city_id'] as int,
      colorId: json['color_id'] as int,
      brandModelId: json['brand_model_id'] as int,
      number: json['number']as String
    );
  }
  
}
class ActiveSuggestion{
  String until;
  Bookings booking;
  int duration;
  
  ActiveSuggestion({this.until,this.booking,this.duration});
  
  factory ActiveSuggestion.fromJson(Map<String,dynamic>json)
  {
    return ActiveSuggestion(
      until: json['until']as String,
      booking: Bookings.fromJson(json['booking']),
      duration: json['duration']as int,
    );
  }

}

class Interview{
  int id;
  String dateTime;
  Interview({this.id,this.dateTime});

  factory Interview.fromJson(Map<String ,dynamic>json)
  {return Interview(
    id:json['id']as int,
    dateTime: json['datetime']as String
  );}
}