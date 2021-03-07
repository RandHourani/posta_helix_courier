class WeeklyReportDetailsModel {
  Data data;

  WeeklyReportDetailsModel({this.data});

  factory WeeklyReportDetailsModel.fromJson(Map<String, dynamic> json) {
    return WeeklyReportDetailsModel(data: Data.fromJson(json['data']));
  }
}

class Data {
  String status;
  int hours;
  int rides;
  List<Items> items;

  Data({this.status, this.hours, this.items, this.rides});

  factory Data.fromJson(Map<String, dynamic> json) {
    var list = json['items'] as List;
    List<Items> items = list.map((i) => Items.fromJson(i)).toList();
    return Data(
        status: json['status'] as String,
        hours: json['hours'] as int,
        rides: json['rides'] as int,
        items: items);
  }
}

class Items {
  String label;
  int total;
  String unit;
  List<ItemDetails> details;
  String prefixOperator;

  Items({this.label, this.unit, this.total, this.details,this.prefixOperator});

  factory Items.fromJson(Map<String, dynamic> json) {
    var list = json['details'] as List;
    List<ItemDetails> details =
        list.map((i) => ItemDetails.fromJson(i)).toList();
    return Items(
        label: json['label'] as String,
        total: json['total'] as int,
        unit: json['unit'] as String,
        prefixOperator: json.containsValue(json['prefix_operator'])
            ? json['prefix_operator'] as String
            : " ",
        details: details);
  }
}

class ItemDetails {
  String label;
  int total;
  String unit;

  ItemDetails({this.label,this.total, this.unit});

  factory ItemDetails.fromJson(Map<String, dynamic> json) {
    return ItemDetails(
      label: json['label'] as String,
      total: json['total'] as int,
      unit: json['unit'] as String,

    );
  }
}
