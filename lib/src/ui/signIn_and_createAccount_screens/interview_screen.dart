import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/Picker.dart';
import 'file:///C:/Users/r.horani/AndroidStudioProjects/helix_courier_project/helix_courier_project/lib/src/constants/application_colors_value.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:flutter/services.dart';
import 'package:posta_courier/models/interview_model.dart';
import 'package:posta_courier/src/blocs/signIn_and_createAccount_blocs/interview_bloc.dart';
import 'package:posta_courier/src/constants/fonts_size.dart';
import 'package:posta_courier/src/ui/signIn_and_createAccount_screens/completed_info_screen.dart';
import 'package:posta_courier/src/ui/signIn_and_createAccount_screens/incompleted_info_screen.dart';
import 'package:posta_courier/src/ui/widgets/calender_widget.dart';
import 'package:posta_courier/src/ui/widgets/dialog.dart';
import 'package:posta_courier/src/blocs/signIn_and_createAccount_blocs/get_captain_data_bloc.dart';
import 'package:posta_courier/models/registered_captain_model.dart';
import 'package:posta_courier/src/ui/home/google_maps/home_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:posta_courier/src/ui/widgets/dialog_loading.dart';
class InterviewScreen extends StatelessWidget {
  double itemExtent = 60.0;
  FixedExtentScrollController scrollController;
  FixedExtentScrollController scrollController2;

  @override
  Widget build(BuildContext context) {
    interviewBloc.fetchAllAvailableTime();
    FlutterStatusbarcolor.setStatusBarColor(Colors.white);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.width / 6,
                    left: MediaQuery.of(context).size.width * 0.04,
                  ),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.arrow_back,
                        color: AppColors.TITLE_TEXT_COLOR,
                        size: (MediaQuery.of(context).size.width * 0.04) +
                            FontSize.HEADING_FONT -
                            3,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "   SCHEDULE INTERVIEW",
                          style: TextStyle(
                              color: AppColors.TITLE_TEXT_COLOR,
                              fontFamily: FontFamilies.POPPINS,
                              fontSize:
                                  (MediaQuery.of(context).size.width * 0.04) +
                                      FontSize.HEADING_FONT -
                                      7,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 2.2,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image:
                          AssetImage("assets/images/interview_background.png"),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Text(""),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.05,
                    right: MediaQuery.of(context).size.width * 0.05,
                  ),
                  child: Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.width * 0.1),
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.width * 0.05),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom:
                            BorderSide(width: 1.0, color: AppColors.LIGHT_BLUE),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Choose Date",
                          style: TextStyle(
                            fontFamily: FontFamilies.POPPINS,
                            fontSize:
                                (MediaQuery.of(context).size.height * 0.02),
                            color: AppColors.labelColor,
                          ),
                        ),
                        StreamBuilder(
                          stream: interviewBloc.interviewDate,
                          builder: (context, snap) {
                            interviewBloc.fetchAllAvailableTime();

                            if (snap.hasData) {
                              interviewBloc.fetchAllAvailableTime();
                              return InkWell(
                                onTap: () {
                                  showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (BuildContext context) {
                                        FlutterStatusbarcolor.setStatusBarColor(
                                            AppColors.dialogStatusBar);
                                        return CalendarWidget(
                                          screen: "INTERVIEW_DATE",
                                        );
                                      });
                                },
                                child: Text(
                                  snap.data,
                                  style: TextStyle(
                                    fontFamily: FontFamilies.POPPINS,
                                    fontSize:
                                        (MediaQuery.of(context).size.height *
                                            0.02),
                                    color: AppColors.MAIN_COLOR,
                                  ),
                                ),
                              );
                            } else {
                              return calendarDialog(context);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.05,
                    right: MediaQuery.of(context).size.width * 0.05,
                  ),
                  child: Container(
                    margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.width * 0.05,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Choose Time",
                          style: TextStyle(
                            fontFamily: FontFamilies.POPPINS,
                            fontSize:
                                (MediaQuery.of(context).size.height * 0.02),
                            color: AppColors.labelColor,
                          ),
                        ),
                        StreamBuilder(
                          stream: interviewBloc.selectedTime,
                          builder: (context, snap) {
                            print(snap.data);
                            if (snap.hasData) {
                              return InkWell(
                                onTap: () {
                                  showDialog(
                                      barrierDismissible: true,
                                      context: context,
                                      builder: (BuildContext context) {
                                        FlutterStatusbarcolor.setStatusBarColor(
                                            AppColors.dialogStatusBar);
                                        return showTimePicker(context);
                                      });
                                },
                                child: Text(
                                  snap.data.toString(),
                                  style: TextStyle(
                                    fontFamily: FontFamilies.POPPINS,
                                    fontSize:
                                        (MediaQuery.of(context).size.height *
                                            0.02),
                                    color: AppColors.MAIN_COLOR,
                                  ),
                                ),
                              );
                            } else {
                              return InkWell(
                                onTap: () {
                                  showDialog(
                                      barrierDismissible: true,
                                      context: context,
                                      builder: (BuildContext context) {
                                        FlutterStatusbarcolor.setStatusBarColor(
                                            AppColors.dialogStatusBar);
                                        return showTimePicker(context);
                                      });
                                },
                                child: SvgPicture.asset(
                                  "assets/images/clock.svg",
                                  width: 17,
                                  height: 17,
                                ),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.width * 0.1,
                    right: MediaQuery.of(context).size.width * 0.05,
                    left: MediaQuery.of(context).size.width * 0.05,
                  ),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width / 7,
                  child: ButtonTheme(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: StreamBuilder(
                        stream: interviewBloc.submitValid,
                        builder: (context, snapshot) {
                          if (snapshot.hasData)  {
                              return RaisedButton(
                                color: AppColors.MAIN_COLOR,

                                onPressed: () {
                                  interviewBloc.sendInterviewData();
                                  checkCaptainDataBloc.checkUserAuth();
                                  checkCaptainDataBloc.checkCaptainData();

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) {
                                      return StreamBuilder(
                                        stream: checkCaptainDataBloc.checkUser,
                                        builder: (BuildContext context,
                                            AsyncSnapshot<LogInModel> snapshot) {
                                        if (snapshot.hasData) {
                                          if (snapshot.data.data.approvedAt !=
                                              null) {
                                            return HomeScreen();
                                          } else if (snapshot
                                                  .data.data.car.car.isEmpty ||
                                              snapshot.data.data.idCardBack ==
                                                  null ||
                                              snapshot.data.data.idCardFront ==
                                                  null ||
                                              snapshot.data.data
                                                      .drivingCertificateFront ==
                                                  null ||
                                              snapshot.data.data
                                                      .drivingCertificateBack ==
                                                  null) {
                                            return InCompletedInfoScreen();
                                          } else {
                                            return CompletedInfoScreen();
                                          }
                                        } else {
                                          return CompletedInfoScreen();
                                        }
                                      },
                                    );
                                  }),
                                  );
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.05),
                                      child: Text(
                                        "Complete ",
                                        style: TextStyle(
                                          fontFamily: FontFamilies.POPPINS,
                                          fontSize: (MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.008) +
                                              FontSize.BUTTON_FONT_L,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          right: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.025),
                                      child: Icon(
                                        Icons.arrow_forward,
                                        color: Colors.white,
                                        size:
                                            (MediaQuery.of(context).size.width *
                                                    0.008) +
                                                18,
                                      ),
                                    )
                                  ],
                                ),
                              );
                            }
                           else {
                            return RaisedButton(
                              color: AppColors.LIGHT_GREY,

                              onPressed: () {

                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width *
                                          0.05,
                                    ),
                                    child: Text(
                                      "Complete ",
                                      style: TextStyle(
                                        fontFamily: FontFamilies.POPPINS,
                                        fontSize:
                                            (MediaQuery.of(context).size.width *
                                                    0.008) +
                                                FontSize.BUTTON_FONT_L,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        right:
                                            MediaQuery.of(context).size.width *
                                                0.025),
                                    child: Icon(
                                      Icons.arrow_forward,
                                      color: Colors.white,
                                      size: (MediaQuery.of(context).size.width *
                                              0.008) +
                                          18,
                                    ),
                                  )
                                ],
                              ),
                            );
                          }
                        },
                      )),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 5),
              child: Image.asset("assets/images/home_indicator.png"),
            ),
          ],
        ),
      ),
    );
  }
  Future<void> _showDialog(context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {

        Future.delayed(Duration(seconds: 2), () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return StreamBuilder(
                stream: checkCaptainDataBloc.checkUser,
                builder: (BuildContext context,
                    AsyncSnapshot<LogInModel> snapshot) {
                  if (snapshot.data.data.approvedAt != null) {
                    return HomeScreen();
                  } else if (snapshot.data.data.car.car.isEmpty ||
                      snapshot.data.data.idCardBack == null ||
                      snapshot.data.data.idCardFront == null ||
                      snapshot.data.data.drivingCertificateFront ==
                          null ||
                      snapshot.data.data.drivingCertificateBack ==
                          null
                  ) {
                    return InCompletedInfoScreen();
                  } else {
                    return CompletedInfoScreen();
                  }
                },
              );
            }),
          );
          Navigator.of(context).pop(true);

        });
        return LoadingDialogWidget();
      },
    );
  }

  InkWell calendarDialog(BuildContext context) {
    return InkWell(
      onTap: () {
        FlutterStatusbarcolor.setStatusBarColor(AppColors.dialogStatusBar);
        // personalDetailsBloc.setCalendarColor(true);
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return CalendarWidget(
                screen: "INTERVIEW_DATE",
              );
            });
      },
      child: SvgPicture.asset(
        "assets/images/calendar.svg",
        width: 17,
        height: 17,
      ),

      // StreamBuilder(
      //   stream: personalDetailsBloc.calendarColor,
      //   builder: (context, snap) {
      //     if (snap.hasData) {
      //       return Image.asset(
      //         "assets/images/calendar.png",
      //         color: snap.data ? AppColors.mainColor : AppColors.labelColor,
      //       );
      //     } else {
      //       return Image.asset(
      //         "assets/images/calendar.png",
      //       );
      //     }
      //   },
      // ),
    );
  }

  showTimePicker(BuildContext context) {
    scrollController = FixedExtentScrollController(initialItem: 0);
    scrollController2 = FixedExtentScrollController(initialItem: 0);

    var i = 0;
    return StreamBuilder(
      stream: interviewBloc.interviewHM,
      builder: (context, AsyncSnapshot<List<InterviewModel>> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.hasData &&
              snapshot.data != null &&
              snapshot.data != null &&
              snapshot.data.isNotEmpty) {
            interviewBloc.setInterviewMins(0);
            interviewBloc.setHour(snapshot.data[0].hour.toString());

            return Container(
                margin: EdgeInsets.only(right: 70, left: 70),
                child: AlertDialog(
                  contentPadding: EdgeInsets.all(8),
                  insetPadding: EdgeInsets.all(0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0))),
                  content: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                            height: 220,
                            width: 190,
                            child: ListView(
                              shrinkWrap: true,
                              // mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "  Set Your Appointment Time",
                                      style: TextStyle(
                                        fontFamily: FontFamilies.POPPINS,
                                        fontSize:
                                        (MediaQuery
                                            .of(context)
                                            .size
                                            .height *
                                            0.02),
                                        color: AppColors.labelColor,
                                      ),
                                    )),
                                Divider(
                                  color: AppColors.LIGHT_GREY,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 180,
                                      width: MediaQuery
                                          .of(context)
                                          .size
                                          .height *
                                          0.07,
                                      child: CupertinoPicker(
                                        scrollController: scrollController,
                                        itemExtent: itemExtent,
                                        children: <Widget>[
                                          for (i = 0;
                                          i < snapshot.data.length;
                                          i++)
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              children: <Widget>[
                                                Text(
                                                  snapshot.data[i].hour
                                                      .toString(),
                                                  style: TextStyle(
                                                    fontFamily:
                                                    FontFamilies.POPPINS,
                                                    fontSize:
                                                    (MediaQuery
                                                        .of(context)
                                                        .size
                                                        .height *
                                                        0.02),
                                                    color: AppColors.labelColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                        ],
                                        onSelectedItemChanged: (int index) {
                                          interviewBloc.setInterviewMins(index);
                                          interviewBloc.setHour(snapshot
                                              .data[index].hour
                                              .toString());
                                        },
                                        looping: false,
                                        backgroundColor: Colors.white,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 120,
                                      width: 20,
                                      child: Container(
                                        alignment: Alignment.center,
                                        color: Colors.white,
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            ":",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery
                                          .of(context)
                                          .size
                                          .height *
                                          0.07,
                                      height: 120,
                                      child: StreamBuilder(
                                        stream: interviewBloc.interviewMins,
                                        builder: (context,
                                            AsyncSnapshot<List<String>> snap) {
                                          // print(snap.data);

                                          if (snap.hasData) {
                                            interviewBloc
                                                .setMins(
                                                snap.data.first.toString());

                                            return CupertinoPicker(
                                              scrollController: scrollController2,
                                              itemExtent: itemExtent,
                                              children: <Widget>[
                                                for (var j = 0;
                                                j < snap.data.length;
                                                j++)
                                                  Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .center,
                                                      children: <Widget>[
                                                        Text(
                                                          snap.data[j]
                                                              .toString(),
                                                          style: TextStyle(
                                                            fontFamily:
                                                            FontFamilies
                                                                .POPPINS,
                                                            fontSize:
                                                            (MediaQuery
                                                                .of(
                                                                context)
                                                                .size
                                                                .height *
                                                                0.02),
                                                            color: AppColors
                                                                .labelColor,
                                                          ),
                                                        ),
                                                      ]),
                                              ],
                                              onSelectedItemChanged: (
                                                  int index) {
                                                interviewBloc.setMins(
                                                    snap.data[index]
                                                        .toString());
                                              },
                                              looping: false,
                                              backgroundColor: Colors.white,
                                            );
                                          } else {
                                            return Text(" ");
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )),
                      ]),
                  actions: <Widget>[
                    Container(
                      margin: EdgeInsets.only(bottom: 10, right: 10),
                      child: InkWell(
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                            fontFamily: FontFamilies.POPPINS,
                            fontSize: (MediaQuery
                                .of(context)
                                .size
                                .height * 0.02),
                            color: AppColors.labelColor,
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 10, right: 20, left: 10),
                      child: InkWell(
                        child: Text(
                          "Ok",
                          style: TextStyle(
                              fontFamily: FontFamilies.POPPINS,
                              fontSize:
                              (MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.02) + 5,
                              color: AppColors.MAIN_COLOR,
                              fontWeight: FontWeight.w700),
                        ),
                        onTap: () {
                          FlutterStatusbarcolor.setStatusBarColor(Colors.white);
                          interviewBloc.setSelectedTime();
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ],
                ));
          }
          else {
            // print(snapshot.data);
            return StreamBuilder(
              stream: interviewBloc.interviewDate,
              builder: (context, snap) {
                if (snap.hasData) {
                  return ErrorDialogWidget(
                      text:
                      "Ops, No Slot Available \nTry to choose another date");
                } else {
                  return ErrorDialogWidget(text: "Please choose date first ");
                }
              },
            );
          }
        }
        else {
          return SpinKitCircle(
            color: AppColors.MAIN_COLOR,
          );
        }
      },
    );
  }
}
