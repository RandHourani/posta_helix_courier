import 'package:posta_courier/models/report_problem_model.dart';
import 'package:posta_courier/models/tikets_question_model.dart';
import 'package:posta_courier/src/reasources/repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReportProblemBloc {
  final _repository = Repository();
  final _problems = BehaviorSubject<QuestionModel>();
  final _questions = BehaviorSubject<TicketsQuestionModel>();
  final _selectedReason = BehaviorSubject<String>();
  final _reason = BehaviorSubject<List<String>>();
  final _validation = BehaviorSubject<Map<String, String>>();
  final _submitValidation = BehaviorSubject<bool>();
  Map answers = Map<String, String>();

  Observable<String> get selectedReason => _selectedReason.stream;
  Observable<bool> get validation => _submitValidation.stream;

  Observable<QuestionModel> get problem => _problems.stream;

  Observable<List<String>> get reasons => _reason.stream;

  Observable<TicketsQuestionModel> get questions => _questions.stream;

  reportProblem() async {
    QuestionModel questions = await _repository.reportProblem("6");
    _problems.add(questions);
    getReasons();
  }

  setQuestion() async {
    var questions = await _repository.postQuestions({
      "answers": answers,
      "last_question_id": _problems
          .value
          .data
          .list[_problems.value.data.list
              .indexWhere((element) => _selectedReason.value == element.title)]
          .id
          .toString(),
      "ticket_type_id": 6.toString()
    });
  }


  setAnswerList(String questionId,String answer) async {

    answers[questionId] =answer;

    _validation.add(answers);
    if(_validation.value.length==_questions.value.data.tickets.length)
    {
    _submitValidation.add( true);
    }
    else
    {_submitValidation.add( false);}

  }

  setAnswersValidation(bool value) {
     _submitValidation.add(value);
  }

  getQuestions() async {
    String parentId = _problems
        .value
        .data
        .list[_problems.value.data.list
            .indexWhere((element) => _selectedReason.value == element.title)]
        .id
        .toString();
    TicketsQuestionModel questions = await _repository.ticket("6", parentId);
    _questions.add(questions);
  }

  getReasons() {
    List<String> list = List();
    for (int i = 0; i < _problems.value.data.list.length; i++) {
      list.add(_problems.value.data.list[i].title);
    }
    _reason.add(list);
  }

  setSelectedReason(String value) {
    _selectedReason.add(value);
  }
}

final reportProblemBloc = ReportProblemBloc();
