import 'city_model.dart';

class CaptainCarsData{

  List<CaptainCarsModel>cars;
  CaptainCarsData({this.cars});
  factory CaptainCarsData.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<CaptainCarsModel> details = list.map((i) => CaptainCarsModel.fromJson(i)).toList();
    return CaptainCarsData(
      cars: details,
    );
  }

  }
class CaptainCarsModel {
  int carId;
  int brandId;
  String captain;
  String brand;
  String model;
  int modelId;
  String color;
  int colorId;
  String insuranceExpiredDate;
  int carManufacturingYear;
  String carNumber;
  int captainId;
  bool isSelected;
  String drivingCertificateFront;
  String drivingCertificateBack;
  String insuranceDocumentFront;
  String insuranceDocumentBack;
  City city;
  bool approved;

  CaptainCarsModel(
      {this.carId,
      this.brandId,
      this.captain,
      this.brand,
      this.model,
      this.carNumber,
      this.captainId,
      this.carManufacturingYear,
      this.city,
      this.color,
      this.colorId,
      this.drivingCertificateBack,
      this.drivingCertificateFront,
      this.insuranceDocumentBack,
      this.insuranceDocumentFront,
      this.insuranceExpiredDate,
      this.isSelected,
      this.modelId,
      this.approved});


  factory CaptainCarsModel.fromJson(Map<String, dynamic> json) {
    return CaptainCarsModel(
      carId: json['id']as int,
      brandId: json['car_brand_id']as int,
      captain: json['captain']as String,
      brand: json['brand']as String,
      model: json['model']as String,
      color: json['color']as String,
      insuranceExpiredDate: json['insurance_expired_date']as String,
      carManufacturingYear: json['car_manufacture_year']as int,
      carNumber: json['number']as String,
      insuranceDocumentBack: json['insurance_document_back']as String,
      insuranceDocumentFront: json['insurance_document_front']as String,
      drivingCertificateFront: json['car_document_front']as String,
      drivingCertificateBack: json['car_document_back']as String,
      captainId: json['captain_id']as int,
      colorId: json['color_id']as int,
      modelId: json['brand_model_id']as int,
      approved: json['approved']as bool,
      isSelected: json['is_selected']as bool,
      city: City.fromJson(json['city'])


    );
  }

}
