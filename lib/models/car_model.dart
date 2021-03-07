import 'package:posta_courier/db/providers/colors_provider.dart';

class CarDataModel {
  Data carData;

  CarDataModel({this.carData});

  factory CarDataModel.fromJson(Map<String, dynamic> json) {

    return CarDataModel(
      carData: Data.fromJson(json['data']),
    );
  }
}

class Data {
  List<ColorModelDetails> data;

  Data({this.data});

  factory Data.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<ColorModelDetails> car = list.map((i) => ColorModelDetails.fromJson(i)).toList();
    return Data(
      data: car,
    );
  }
}

class ColorModelDetails {
  int id;
  String name;

  ColorModelDetails({this.id, this.name});

  factory ColorModelDetails.fromJson(Map<String, dynamic> json)  {
    return ColorModelDetails(
      id: json['id'] as int,
      name: json['name'] as String,
    );
  }


  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,

  };
}
