class QuestionModel{
  QuestionList data;
  QuestionModel({this.data});
  factory QuestionModel.fromJson(Map<String,dynamic>json)
  {
    return QuestionModel(
      data: QuestionList.fromJson(json['data'])
    );
  }
}


class QuestionList{
List<QuestionDetails>list;
QuestionList({this.list});
factory QuestionList.fromJson(Map<String,dynamic>json)
{
  var list = json['list'] as List;
  List<QuestionDetails> details =
  list.map((i) => QuestionDetails.fromJson(i)).toList();
  return QuestionList(
      list: details
  );
}

}
class QuestionDetails{
  int id;
  String title;
  String details;
  int typeId;
  int questionId;
  int isLeaf;

  QuestionDetails({this.id,this.details,this.typeId,this.title,this.isLeaf,this.questionId});

  factory QuestionDetails.fromJson(Map<String,dynamic>json)
  {
    return QuestionDetails(
      id: json['id']as int,
      title: json['title']as String ,
      details: json['details']as String,
      typeId: json['type_id']as int,
      questionId: json['question_id']as int,
      isLeaf: json['is_leaf']as int
    );
  }


}