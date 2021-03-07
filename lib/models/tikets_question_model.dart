class TicketsQuestionModel {
  TicketData data;

  TicketsQuestionModel({this.data});

  factory TicketsQuestionModel.fromJson(Map<String, dynamic> json) {
    return TicketsQuestionModel(data: TicketData.fromJson(json['data']));
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
  int parentId;
  int required;
  String type;
  String title;
  String details;
  String extra;

  TicketDetails(
      {this.id,
      this.title,
      this.details,
      this.type,
      this.parentId,
      this.extra,
      this.required});

  factory TicketDetails.fromJson(Map<String, dynamic> json) {
    return TicketDetails(
      id: json['id'] as int,
      title: json['title'] as String,
      details: json['details'] as String,
      type: json['type'] as String,
      parentId: json['question_id'] as int,
      required: json['required'] as int,
      extra: json['extra'] as String,
    );
  }
}
