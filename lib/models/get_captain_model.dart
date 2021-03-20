class CaptainData {
  CaptainDetails data;
  CaptainData({this.data});

 factory CaptainData.fromJson(Map<String,dynamic>json)
 {
   return CaptainData(
     data: CaptainDetails.fromJson(json['data'])
   );
 }

}
class CaptainDetails{
  int id;
  String username;
  String email;
  String firstName;
  String lastName;
  bool gender;
  String birthday;
  String drivingCertificateSD;
  String drivingCertificateED;
  String drivingCertificateF;
  String drivingCertificateB;
  String idCardF;
  String idCardB;
  int nationalityId;
  int countryId;
  int totalRating;
  CaptainCar car;
  Nationality nationality;

  CaptainDetails(
      {this.id,
      this.nationalityId,
      this.birthday,
      this.email,
      this.lastName,
      this.firstName,
      this.countryId,
      this.username,
      this.drivingCertificateB,
      this.drivingCertificateED,
      this.drivingCertificateF,
      this.drivingCertificateSD,
      this.gender,
      this.idCardB,
      this.idCardF,
      this.totalRating,
      this.car,
      this.nationality});

  factory CaptainDetails.fromJson(Map<String, dynamic> json) {
    return CaptainDetails(
        id: json['id'] as int,
        username: json['username'] as String,
        email: json['email'] as String,
        firstName: json['first_name'] as String,
        lastName: json['last_name'] as String,
        gender: json['gender'] as bool,
        birthday: json['birthday'] as String,
        drivingCertificateSD: json['driving_certificate_start_date'] as String,
        drivingCertificateED: json['driving_certificate_end_date'] as String,
        idCardF: json['id_card_front'] as String,
        idCardB: json['id_card_back'] as String,
        drivingCertificateF: json['driving_certificate_front'] as String,
        drivingCertificateB: json['driving_certificate_back'] as String,
        nationalityId: json['nationality_id'] as int,
        totalRating: json['total_ratings'] as int,
        countryId: json['country_id'] as int,
        car: json['car'] != null ? CaptainCar.fromJson(json['car']) : null,
        nationality: Nationality.fromJson(json['nationality'])

    );
  }

}

class Nationality {
  int id;

  String name;

  Nationality({this.id, this.name});

  factory Nationality.fromJson(Map<String, dynamic>json)
  {
    return Nationality(
        id: json['id'] as int,
        name: json['name'] as String
    );
  }
}

class CaptainCar {
  int id;
  String insuranceExpiredDate;
  int yearManu;
  String number;
  String insuranceDocumentFront;
  String insuranceDocumentBack;
  String carDocumentBack;
  String carDocumentFront;
  int colorId;
  int brandModelId;
  int cityId;
  int captainId;
  int carBrandId;
  String carBrandName;

  CaptainCar(
      {this.id,
      this.insuranceExpiredDate,
      this.brandModelId,
      this.yearManu,
      this.cityId,
      this.colorId,
      this.insuranceDocumentBack,
      this.insuranceDocumentFront,
      this.number,
      this.captainId,
      this.carBrandId,
      this.carBrandName,
      this.carDocumentBack,
      this.carDocumentFront});

  factory CaptainCar.fromJson(Map<String, dynamic> json) {
    return CaptainCar(
        id: json['id'] as int,
        insuranceExpiredDate: json['insurance_expired_date'] as String,
        yearManu: json['car_manufacture_year'] as int,
        insuranceDocumentFront: json['insurance_document_front'] as String,
        insuranceDocumentBack: json['insurance_document_back'] as String,
        cityId: json['city_id'] as int,
        colorId: json['color_id'] as int,
        brandModelId: json['brand_model_id'] as int,
        number: json['number'] as String,
        carBrandId: json['car_brand_id']as int,
       captainId: json['captain_id']as int,
      carBrandName: json['car_brand_name']as String,
       carDocumentFront: json['car_document_front']as String,
      carDocumentBack: json['car_document_back']as String,
      


    );
  }
}
