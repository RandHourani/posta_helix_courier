class CountryModel {
  Data data;

  CountryModel({this.data});

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(
      data: Data.fromJson(json),
    );
  }
}

class Data {
  List<Details> data;

  Data({this.data});

  factory Data.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<Details> details = list.map((i) => Details.fromJson(i)).toList();
    return Data(
      data: details,
    );
  }
}

class Details {
  int id;
  String nameEG;
  String nameAR;
  String countryCode;
  int currencyId;

  // Centroid centroid;
  Currency currency;

  Details({
    this.id,
    this.nameEG,
    this.nameAR,
    this.countryCode,
    this.currencyId,
    this.currency,
    // this.centroid
  });

  factory Details.fromJson(Map<String, dynamic> json) {
    return Details(
      id: json['id'] as int,
      nameEG: json['name_en'] as String,
      nameAR: json['name_ar'] as String,
      countryCode: json['country_code'] as String,
      currencyId: json['currency_id'] as int,
      currency: Currency.fromJson(json['currency']),
      // centroid: Centroid.formJson(json['centroid']),
    );
  }
}

// class Centroid {
//   List<dynamic> coordinates;
//
//   Centroid({this.coordinates});
//
//   factory Centroid.formJson(Map<String, dynamic> json) {
//     return Centroid(
//         coordinates:json['coordinates']as List);
//         // (json['coordinates'] as List).map((map) => (double.parse("$map"))).toList());
//   }
// }

class Currency {
  int id;
  String nameEG;
  String nameAR;
  String currencyCode;

  Currency({this.id, this.nameEG, this.nameAR, this.currencyCode});

  factory Currency.fromJson(Map<String, dynamic> json) {
    return Currency(
      id: json['id'] as int,
      nameEG: json['name_en'] as String,
      nameAR: json['name_ar'] as String,
      currencyCode: json['currency_code'] as String,
    );
  }
}
