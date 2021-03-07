class InterviewDataModel {
  List<String> interviewTime = List();

  InterviewDataModel({this.interviewTime});

  factory InterviewDataModel.fromJson(Map<String, dynamic> json) {
    return InterviewDataModel(
        interviewTime: (json['data'] as List).map((map) => ("$map")).toList());
  }
}

class InterviewModel {
  String hour;
  List<String> mins;

  InterviewModel({this.hour, this.mins});

  factory InterviewModel.fromJson(Map<String, dynamic> map) {
    return InterviewModel(
        hour: map["hour"],
        mins: (map["mins"] as List).map((map) => ("$map")).toList());
  }
}
