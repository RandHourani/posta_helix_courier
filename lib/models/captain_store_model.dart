
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:posta_courier/src/blocs/signIn_and_createAccount_blocs/otp_signIn_bloc.dart';
import 'package:posta_courier/src/blocs/signIn_and_createAccount_blocs/personal_details_bloc.dart';
import 'package:posta_courier/src/blocs/signIn_and_createAccount_blocs/sign_up_bloc.dart';
import 'package:posta_courier/src/blocs/signIn_and_createAccount_blocs/vehicle_bloc.dart';
import 'package:posta_courier/src/utils/util.dart';
import 'package:country_codes/country_codes.dart';

class Captain {

  static Map<String, dynamic> car = {
    "color_id": vehicleBloc.getSelectedColor().toInt() + 1,
    "brand_model_id": vehicleBloc.getSelectedModelId(),
    "number": vehicleBloc.getPlateNumber().toString(),
    "state": vehicleBloc.getSelectedCity().toString(),
    "insurance_expired_date":
        Utils.dateFormat2(vehicleBloc.getRegistrationExpireDate().toString()),
    "car_manufacture_year": int.parse(vehicleBloc.getManufacturingYearSelected()),
    "city_id":  vehicleBloc.getSelectedCityId().toInt
  };

  Map<String, dynamic> data = {
    "captain": {
      "activation_code": otpBloc.getSignUpCode().toString(),
      "first_name": personalDetailsBloc.getFirstName().toString(),
      "last_name": personalDetailsBloc.getLastName().toString(),
      "birthday":
          Utils.dateFormat2(personalDetailsBloc.getBirthday().toString()),
      "driving_certificate_end_date": Utils.dateFormat2(
          personalDetailsBloc.getDriverExpiredDate().toString()),
      "driving_certificate_start_date": Utils.dateFormat2(
          personalDetailsBloc.getDriverIssueDate().toString()),
      "email": personalDetailsBloc.getEmail().toString(),
      "gender": personalDetailsBloc.getGender(),
      "nationality_id": personalDetailsBloc.getNationalityId(),
      "password": personalDetailsBloc.getPassword().toString(),
      "password_confirmation":
          personalDetailsBloc.getConfirmPassword().toString(),
      "username": phoneBloc
          .getPhoneNumber()
          .replaceAll(RegExp(r'[^\d]+'), '')
          .toString(),
    },
    "car": [],
    "country_code": phoneBloc.getCountryCode().toString(),
  };

  getData() {
    return data;
  }
}

getActivationCode() async {
  final storage = new FlutterSecureStorage();
  String code =  await storage.read(key: "code").then((value) {
    return value;
  });

}

final captain = Captain();

class CaptainModel {
  DataDetails data;
  String message = "";

  CaptainModel({this.data, this.message});

  factory CaptainModel.fromJson(Map<String, dynamic> json) {
    return CaptainModel(
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

  // CarData car;

  DataDetails({
    this.username,
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
    // this.car
  });

  factory DataDetails.fromJson(Map<String, dynamic> json) {
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
      drivingCertificateEndDate: json['driving_certificate_end_date'] as String,
      profileImage: json['profile_image'] as String,
      idCardFront: json['id_card_front'] as String,
      idCardBack: json['id_card_back'] as String,
      drivingCertificateFront: json['driving_certificate_front'] as String,
      drivingCertificateBack: json['driving_certificate_back'] as String,
      nationalityId: json['nationality_id'] as int,
      bankId: json['bank_id'] as int,
      countryId: json['country_id'] as int,
      // car: json['car'] != null ? CarData.fromJson(json['car']) : null,
    );
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

  CarData(
      {this.id,
      this.insuranceExpiredDate,
      this.brandModelId,
      this.carManufactureYear,
      this.cityId,
      this.colorId,
      this.insuranceDocumentBack,
      this.insuranceDocumentFront});

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
    );
  }
}
