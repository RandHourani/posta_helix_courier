import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:posta_courier/src/constants/application_colors_value.dart';
import 'package:posta_courier/src/constants/fonts_size.dart';
import 'package:posta_courier/src/blocs/home_blocs/report_problem_bloc.dart';
import 'package:posta_courier/src/ui/home/ticket_questions/textfield_question.dart';
import 'package:posta_courier/src/ui/home/ticket_questions/single_check_question.dart';
import 'package:posta_courier/src/ui/home/ticket_questions/multi_check_question.dart';
import 'package:posta_courier/src/ui/home/google_maps/home_screen.dart';
import 'package:posta_courier/models/report_problem_model.dart';
import 'package:posta_courier/models/tikets_question_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:posta_courier/src/ui/widgets/dialog.dart';
import 'package:posta_courier/src/ui/widgets/dialog_loading.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ReportProblem extends StatelessWidget {
  List<String> list = List();

  @override
  Widget build(BuildContext context) {
    reportProblemBloc.reportProblem();
    // SystemChrome.setSystemUIOverlayStyle(
    //     SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background_profile.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.width / 6,
                        left: MediaQuery.of(context).size.width * 0.04,
                      ),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: (MediaQuery.of(context).size.width * 0.04) +
                                FontSize.HEADING_FONT -
                                3,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              "   BACK",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: FontFamilies.POPPINS,
                                  fontSize: (MediaQuery.of(context).size.width *
                                          0.04) +
                                      FontSize.HEADING_FONT -
                                      7,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.width / 2.7,
                    left: MediaQuery.of(context).size.width * 0.06,
                    right: MediaQuery.of(context).size.width * 0.06,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Report a problem",
                        style: TextStyle(
                            fontFamily: FontFamilies.POPPINS,
                            fontSize:
                                (MediaQuery.of(context).size.height * 0.02) + 5,
                            fontWeight: FontWeight.w500),
                      ),
                      Container(
                          padding: EdgeInsets.only(bottom: 5),
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.width * 0.05,
                          ),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                  color: AppColors.MAIN_COLOR, width: 2.0),
                            ),
                          ),
                          child: StreamBuilder(
                            stream: reportProblemBloc.reasons,
                            builder:
                                (context, AsyncSnapshot<List<String>> snap) {
                              if (snap.hasData) {
                                return StreamBuilder(
                                    stream: reportProblemBloc.selectedReason,
                                    builder: (context, snapshot) {
                                      return DropdownButtonHideUnderline(
                                        child: new DropdownButton<String>(
                                          hint: Text("Select Reason",
                                              style: TextStyle(
                                                  color: AppColors.labelColor,
                                                  fontFamily: 'Poppins')),
                                          isExpanded: true,
                                          value: snapshot.data,
                                          items: snap.data.map((String value) {
                                            return new DropdownMenuItem<String>(
                                              value: value,
                                              child: new Text(
                                                value,
                                                style: TextStyle(
                                                  fontFamily:
                                                      FontFamilies.POPPINS,
                                                  fontSize:
                                                      (MediaQuery.of(context)
                                                              .size
                                                              .height *
                                                          0.02),
                                                  color: AppColors.labelColor,
                                                ),
                                              ),
                                            );
                                          }).toList(),
                                          onChanged: (newValue) {
                                            reportProblemBloc
                                                .setSelectedReason(newValue);
                                            reportProblemBloc.getQuestions();

                                            // _showDialog(context);
                                          },
                                        ),
                                      );
                                    });
                              } else {
                                return Text("");
                              }
                            },
                          )),
                      StreamBuilder(
                        stream: reportProblemBloc.selectedReason,
                        builder: (BuildContext context,
                            AsyncSnapshot<String> snapshot) {
                          if (snapshot.hasData) {
                            return StreamBuilder(
                              stream: reportProblemBloc.questions,
                              builder: (BuildContext context,
                                  AsyncSnapshot<TicketsQuestionModel>
                                      snapshot) {
                                if (snapshot.hasData) {
                                  return ListView.builder(
                                    itemBuilder: (context, index) {
                                      return questionType(
                                          index,
                                          snapshot
                                              .data.data.tickets[index].type,
                                          snapshot.data.data.tickets[index]);
                                    },
                                    itemCount:
                                        snapshot.data.data.tickets.length,
                                    shrinkWrap: true,
                                  );
                                } else {
                                  return SpinKitCircle(
                                    color: AppColors.MAIN_COLOR,
                                  );
                                }
                              },
                            );
                          } else {
                            return Container();
                          }
                        },
                      ),
                      StreamBuilder(
                        stream: reportProblemBloc.selectedReason,
                        builder: (BuildContext context,
                            AsyncSnapshot<String> snapshot) {
                          if (snapshot.hasData) {
                            return StreamBuilder(
                                stream: reportProblemBloc.validation,
                                builder: (BuildContext context,
                                    AsyncSnapshot<bool> snapshot) {
                                  if (snapshot.hasData) {
                                    if (snapshot.data) {
                                      return Container(
                                        margin: EdgeInsets.only(
                                          top: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.1,
                                          bottom: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.1,
                                          right: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.02,
                                          left: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.02,
                                        ),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height:
                                            MediaQuery.of(context).size.width /
                                                8.7,
                                        child: ButtonTheme(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          buttonColor: AppColors.MAIN_COLOR,
                                          child: RaisedButton(
                                            onPressed: () async {
                                              reportProblemBloc.setQuestion();

                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) {
                                                      reportProblemBloc.setAnswersValidation(false);
                                                  reportProblemBloc
                                                      .setSelectedReason(null);
                                                  return HomeScreen();
                                                }),
                                              );
                                            },
                                            child: Text(
                                              "Submit",
                                              style: TextStyle(
                                                  fontFamily:
                                                      FontFamilies.POPPINS,
                                                  fontSize:
                                                      (MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.008) +
                                                          10,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ),
                                        ),
                                      );
                                    } else {
                                      return Container(
                                        margin: EdgeInsets.only(
                                          top: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.1,
                                          right: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.02,
                                          left: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.02,
                                        ),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height:
                                            MediaQuery.of(context).size.width /
                                                8.7,
                                        child: ButtonTheme(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          buttonColor: AppColors.GREY_BUTTON,
                                          child: RaisedButton(
                                            onPressed: () async {},
                                            child: Text(
                                              "Submit",
                                              style: TextStyle(
                                                  fontFamily:
                                                      FontFamilies.POPPINS,
                                                  fontSize:
                                                      (MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.008) +
                                                          10,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                  } else {
                                    return Container(
                                      margin: EdgeInsets.only(
                                        top: MediaQuery.of(context).size.width *
                                            0.1,
                                        right:
                                            MediaQuery.of(context).size.width *
                                                0.02,
                                        left:
                                            MediaQuery.of(context).size.width *
                                                0.02,
                                      ),
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.width /
                                              8.7,
                                      child: ButtonTheme(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        buttonColor: AppColors.GREY_BUTTON,
                                        child: RaisedButton(
                                          onPressed: () async {},
                                          child: Text(
                                            "Submit",
                                            style: TextStyle(
                                                fontFamily:
                                                    FontFamilies.POPPINS,
                                                fontSize:
                                                    (MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.008) +
                                                        10,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                });
                          } else {
                            return Container(
                              margin: EdgeInsets.only(
                                top: MediaQuery.of(context).size.width * 0.1,
                                right: MediaQuery.of(context).size.width * 0.02,
                                left: MediaQuery.of(context).size.width * 0.02,
                              ),
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.width / 8.7,
                              child: ButtonTheme(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                buttonColor: AppColors.GREY_BUTTON,
                                child: RaisedButton(
                                  onPressed: () async {},
                                  child: Text(
                                    "Submit",
                                    style: TextStyle(
                                        fontFamily: FontFamilies.POPPINS,
                                        fontSize:
                                            (MediaQuery.of(context).size.width *
                                                    0.008) +
                                                10,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                )
              ]),
        ),
      ),
    );
  }

  questionType(int index, String type, TicketDetails question) {
    switch (type) {
      case "TEXT":
        {
          return TextFieldQuestion(
            index: index,
            hint: question.details,
            label: question.title,
            questionId: "question_" + question.id.toString(),
          );
        }
        break;
      case "CHECK":
        {
          return SingleCheckQuestion(
            index: index,
            options: ["Yes", "No"],
            question: question.title,
            details: question.details,
            questionId: "question_" + question.id.toString(),
          );
        }
        break;
      case "SELECT":
        {
          return MultiCheckQuestion(
            index: index,
            options: jsonDecode(question.extra).cast<String>(),
            question: question.title,
            details: question.details,
            questionId: "question_" + question.id.toString(),
          );
        }
        break;
    }
  }
}
