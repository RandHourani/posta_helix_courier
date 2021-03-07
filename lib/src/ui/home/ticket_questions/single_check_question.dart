import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_question_answer_widget/flutter_question_answer_widget.dart';
import 'package:posta_courier/src/constants/application_colors_value.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:posta_courier/src/blocs/home_blocs/report_problem_bloc.dart';

class SingleCheckQuestion extends StatefulWidget {
  List<String> options;
  String question, details, questionId;
  int index;

  SingleCheckQuestion(
      {this.options, this.details, this.question, this.questionId, this.index});

  @override
  _State createState() => new _State(
      options: options,
      question: question,
      details: details,
      questionId: questionId,
      index: index);
}

//State is information of the application that can change over time or when some actions are taken.
class _State extends State<SingleCheckQuestion> {
  List<String> options;
  String question, details, questionId;
  int index;

  _State(
      {this.options, this.question, this.details, this.questionId, this.index});

  String _value1;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 5, bottom: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 7),
                  child: Text((index + 1).toString() + "."),
                ),
                Text(
                  question,
                  style: TextStyle(
                      color: AppColors.labelColor, fontFamily: 'Poppins'),
                ),
              ],
            ),
            Padding(
                padding: EdgeInsets.only(left: 17),
                child: FlutterQuestionAnswerWidget.singleCheckSelection(
                    activeColor: AppColors.MAIN_COLOR,
                    answered: _value1,
                    answersFontFamily: 'Poppins',
                    answerList: options,
                    answerMargin: EdgeInsets.only(left: 7),
                    onChanged: (String value) async {
                      setState(() {
                        _value1 = value;
                      });

                      reportProblemBloc.setAnswerList(
                          questionId, (_value1 == "Yes" ? 0 : 1).toString());
                    },
                    question: details,
                    questionTextStyle: TextStyle(
                        fontSize: 12,
                        color: AppColors.LIGHT_GREY,
                        fontFamily: 'Poppins')))
          ],
        ));
  }
}
