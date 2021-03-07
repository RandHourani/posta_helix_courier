class BankModel {
  Data bank;

  BankModel({this.bank});

  factory BankModel.fromJson(Map<String, dynamic> json) {
    return BankModel(
      bank: Data.fromJson(json['data']),
    );
  }
}

class Data {
  List<BankDetails> data;

  Data({this.data});

  factory Data.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<BankDetails> data = list.map((i) => BankDetails.fromJson(i)).toList();
    return Data(
      data: data,
    );
  }
}

class BankDetails {
  int id;
  String name;

  BankDetails({this.id, this.name});

  factory BankDetails.fromJson(Map<String, dynamic> json) {
    return BankDetails(
      id: json['id'] as int,
      name: json['name'] as String,
    );
  }
}
