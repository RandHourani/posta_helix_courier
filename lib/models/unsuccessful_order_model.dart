class UnsuccessfulOrderModel{
  Data data;
  UnsuccessfulOrderModel({this.data});

  factory UnsuccessfulOrderModel.fromJson(Map<String, dynamic> json) {
    return UnsuccessfulOrderModel(data:Data.fromJson(json["data"]));

  }

}
class Data{
  List<Reason> data;
  Data({this.data});
  factory Data.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;

    List<Reason> reasons =  list.map((i) => Reason.fromJson(i)).toList();
    return Data(data:reasons,);

  }
}

class Reason{
  int id;
  String type;
  String reason;

  Reason({this.id,this.reason,this.type});

  factory Reason.fromJson(Map<String, dynamic> json) {
    return Reason(
      id: json['id'] as int,
      type: json['type'] as String,
      reason: json['text'] as String,

    );
  }

}