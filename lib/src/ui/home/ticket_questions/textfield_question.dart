import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:posta_courier/src/constants/application_colors_value.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:posta_courier/src/blocs/home_blocs/report_problem_bloc.dart';

class TextFieldQuestion extends StatefulWidget {
  String hint, label, questionId;
  TextEditingController controller;
  int index;

  TextFieldQuestion(
      {this.hint, this.label, this.controller, this.questionId, this.index});

  @override
  State<StatefulWidget> createState() {
    return QuestionState(
        hint: hint, label: label, questionId: questionId, index: index);
  }
}

class QuestionState extends State<TextFieldQuestion> {
  String hint, label, questionId;
  int index;

  QuestionState({this.hint, this.label, this.questionId, this.index});

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 5, bottom: 5),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(right: 7),
            child: Text((index + 1).toString() + "."),
          ),
          Container(
              margin: EdgeInsets.only(top: 5, bottom: 10),
              width: 338,
              // height: 30,
              child: TextField(
                decoration: new InputDecoration(
                  contentPadding: EdgeInsets.all(0),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.LIGHT_BLUE),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.MAIN_COLOR),
                  ),
                  hintText: hint,
                  labelText: label,
                  labelStyle: TextStyle(
                      color: AppColors.labelColor, fontFamily: 'Poppins'),
                ),
                controller: controller,
                onChanged: (value) {
                  setState(() async {


                    reportProblemBloc.setAnswerList(
                        questionId, controller.text);
                    // controller.text=value;
                  });
                  print(controller.text);
                },
              ))
        ],
      ),
    );
  }
}
