class CityModel {
  List<City> data;

  CityModel({this.data});

  factory CityModel.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<City> details = list.map((i) => City.fromJson(i)).toList();
    return CityModel(
      data: details,
    );
  }
}

class City {
  int countryId;
  int id;
  String nameAR;
  String nameEN;

  City({this.countryId, this.nameAR, this.nameEN,this.id});

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      countryId: json['country_id'] as int,
     id: json['id'] as int,
      nameAR: json['name_ar'] as String,
      nameEN: json['name_en'] as String,
    );
  }

  Map<String, dynamic> toMap() => {
    "id": id,
    "name_en": nameEN,


  };
}
