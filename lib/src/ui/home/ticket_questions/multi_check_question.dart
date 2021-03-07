import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_question_answer_widget/flutter_question_answer_widget.dart';
import 'package:posta_courier/src/constants/application_colors_value.dart';
import 'package:flutter_question_answer_widget/flutter_question_answer_widget.dart';
import 'package:posta_courier/src/constants/application_colors_value.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:posta_courier/src/blocs/home_blocs/report_problem_bloc.dart';

class MultiCheckQuestion extends StatefulWidget {
  List<String> options;
  String question, details, questionId;
int index;
  MultiCheckQuestion(
      {this.options, this.details, this.question, this.questionId,this.index});

  @override
  _State createState() => new _State(
      options: options,
      question: question,
      details: details,
      index: index,
      questionId: questionId);
}

class _State extends State<MultiCheckQuestion> {
  List<String> options;
  String question, details, questionId;
int index;
  _State({this.options, this.details, this.question, this.questionId,this.index});

  String _value1 ;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 5,bottom: 5),

        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 7),
                  child:Text((index+1).toString()+"."),

                ),
                Text(question,style:  TextStyle(
                    color: AppColors.labelColor, fontFamily: 'Poppins'),),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: 17),
              child:   FlutterQuestionAnswerWidget.singleCheckSelection(
                  activeColor: AppColors.MAIN_COLOR,
                  answerMargin: EdgeInsets.only(left: 7),
                  answersFontFamily: 'Poppins',
                  answered: _value1,
                  answerList:options,
                  onChanged: (String value) async {
                    setState(()  {
                      _value1 = value;

                    });

                    reportProblemBloc.setAnswerList(
                        questionId, options[options.indexWhere((element) => _value1==element)].toString());

                    },

                  question: details,

                  questionTextStyle: TextStyle(fontSize: 12,color: AppColors.LIGHT_GREY, fontFamily: 'Poppins')
              ),
            ),

          ],
        )
    );

  }
}
