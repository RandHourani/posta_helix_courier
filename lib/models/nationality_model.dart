class NationalityModel {
  Data personalData;

  NationalityModel({this.personalData});

  factory NationalityModel.fromJson(Map<String, dynamic> json) {
    return NationalityModel(
      personalData: Data.fromJson(json['data']),
    );
  }
}

class Data {
  List<NationalityDetails> data;

  Data({this.data});

  factory Data.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<NationalityDetails> data = list.map((i) => NationalityDetails.fromJson(i)).toList();
    return Data(
      data: data,
    );
  }
}

class NationalityDetails {
  int id;
  String name;

  NationalityDetails({this.id, this.name});

  factory NationalityDetails.fromJson(Map<String, dynamic> json) {
    return NationalityDetails(
      id: json['id'] as int,
      name: json['name'] as String,
    );
  }
  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,

  };
}
