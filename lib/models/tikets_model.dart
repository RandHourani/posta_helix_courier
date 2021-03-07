class TicketsModel {
  TicketData data;

  TicketsModel({this.data});

  factory TicketsModel.fromJson(Map<String, dynamic> json) {
    return TicketsModel(data: TicketData.fromJson(json['data']));
  }
}

class TicketData {
  List<TicketDetails> tickets;

  TicketData({this.tickets});

  factory TicketData.fromJson(Map<String, dynamic> json) {
    var list = json['list'] as List;
    List<TicketDetails> details =
        list.map((i) => TicketDetails.fromJson(i)).toList();

    return TicketData(tickets: details);
  }
}

class TicketDetails {
  int id;
  int typeId;
  String title;
  String details;

  TicketDetails({this.id, this.title, this.details, this.typeId});

  factory TicketDetails.fromJson(Map<String, dynamic> json) {
    return TicketDetails(
        id: json['id'] as int,
        title: json['title'] as String,
        details: json['details'] as String,
        typeId: json['type_id'] as int);
  }
}
