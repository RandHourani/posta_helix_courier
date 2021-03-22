import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:posta_courier/models/get_captain_model.dart';
import 'package:posta_courier/models/nationality_model.dart';
import 'package:posta_courier/src/blocs/signIn_and_createAccount_blocs/personal_details_bloc.dart';
import 'package:posta_courier/src/blocs/signIn_and_createAccount_blocs/vehicle_bloc.dart';
import 'package:posta_courier/src/constants/application_colors_value.dart';
import 'package:posta_courier/src/constants/fonts_size.dart';
import 'package:posta_courier/src/ui/signIn_and_createAccount_screens/vehicle_details_screen.dart';
import 'package:posta_courier/src/ui/widgets/calender_widget.dart';
import 'package:posta_courier/src/ui/widgets/dialog.dart';
import 'package:posta_courier/src/utils/util.dart';
import 'package:posta_courier/validation/text_field_validation.dart';
import 'package:posta_courier/src/ui/widgets/dialog_loading.dart';
import 'package:posta_courier/db/providers/nationalities_provider.dart';
import 'package:posta_courier/src/ui/signIn_and_createAccount_screens/completed_info_screen.dart';
import 'package:posta_courier/src/ui/signIn_and_createAccount_screens/completed_info_screen.dart';
import 'package:posta_courier/src/ui/signIn_and_createAccount_screens/incompleted_info_screen.dart';

class PersonalDetailsScreen extends StatelessWidget {
  String screen;
  String firstName, lastName, email;
  CaptainData captainPersonalData;

  PersonalDetailsScreen(
      {this.screen,
      this.captainPersonalData,
      this.firstName,
      this.lastName,
      this.email});

  FocusNode firstNameNode = new FocusNode();
  FocusNode lastNameNode = new FocusNode();
  FocusNode emailNode = new FocusNode();
  FocusNode passNode = new FocusNode();
  FocusNode confirmPassNode = new FocusNode();

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.white);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    personalDetailsBloc.setInitDate(DateTime.now());
    personalDetailsBloc.fetchAllNationality();
    // vehicleBloc.fetchAllCarBrand();
    personalDetailsBloc.setCalendarColor(false);
    personalDetailsBloc.setCalendarColorIssue(false);
    personalDetailsBloc.setCalendarColorExpired(false);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.width / 6,
                    left: MediaQuery.of(context).size.width * 0.04,
                  ),
                  child: Row(
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.arrow_back,
                          color: AppColors.TITLE_TEXT_COLOR,
                          size: (MediaQuery.of(context).size.width * 0.04) +
                              FontSize.HEADING_FONT -
                              3,
                        ),
                      ),
                      Text(
                        "   PERSONAL  DETAILS",
                        style: TextStyle(
                            color: AppColors.TITLE_TEXT_COLOR,
                            fontFamily: FontFamilies.POPPINS,
                            fontSize:
                                (MediaQuery.of(context).size.width * 0.04) +
                                    FontSize.HEADING_FONT -
                                    7,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.05,
                    right: MediaQuery.of(context).size.width * 0.05,
                    bottom: MediaQuery.of(context).size.width * 0.05,
                  ),
                  child: Column(
                    children: <Widget>[
                      firstNameTextField(),
                      lastNameTextField(),
                      emailTextField(),
                      captainPersonalData != null
                          ? Container()
                          : passTextField(),
                      captainPersonalData != null
                          ? Container()
                          : confirmPassTextField(),
                      Container(
                        margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.04),
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).size.height * 0.017),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                                width: 1.0, color: AppColors.LIGHT_BLUE),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Birthday",
                              style: TextStyle(
                                fontFamily: FontFamilies.POPPINS,
                                fontSize:
                                    (MediaQuery.of(context).size.height * 0.02),
                                color: AppColors.labelColor,
                              ),
                            ),
                            StreamBuilder(
                              stream: personalDetailsBloc.birthday,
                              builder: (context, snap) {
                                if (snap.hasData) {
                                  return InkWell(
                                    onTap: () {
                                      passNode.unfocus();
                                      confirmPassNode.unfocus();
                                      firstNameNode.unfocus();
                                      lastNameNode.unfocus();
                                      emailNode.unfocus();
                                      showDialog(
                                              barrierDismissible: false,
                                              context: context,
                                              builder: (BuildContext context) {
                                                return CalendarWidget(
                                                  screen: "BIRTHDAY_DATE",
                                                );
                                              })
                                          .then((value) => FlutterStatusbarcolor
                                              .setStatusBarColor(Colors.white));
                                    },
                                    child: Text(
                                      Utils.dateFormat1(snap.data),
                                      style: TextStyle(
                                        color: AppColors.MAIN_COLOR,
                                        fontFamily: FontFamilies.POPPINS,
                                        fontSize: (MediaQuery.of(context)
                                                .size
                                                .height *
                                            0.02),
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
                      Container(
                        margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.037),
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).size.height * 0.007),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                                width: 1.0, color: AppColors.LIGHT_BLUE),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Gender",
                              style: TextStyle(
                                fontFamily: FontFamilies.POPPINS,
                                fontSize:
                                    (MediaQuery.of(context).size.height * 0.02),
                                color: AppColors.labelColor,
                              ),
                            ),
                            gender(context),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.046),
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).size.height * 0.02),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                                width: 1.0, color: AppColors.LIGHT_BLUE),
                          ),
                        ),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "Nationality",
                                style: TextStyle(
                                  fontFamily: FontFamilies.POPPINS,
                                  fontSize:
                                      (MediaQuery.of(context).size.height *
                                          0.02),
                                  color: AppColors.labelColor,
                                ),
                              ),
                              StreamBuilder(
                                stream: personalDetailsBloc.nationality,
                                builder: (context,
                                    AsyncSnapshot<NationalityModel> snap) {
                                  if (snap.hasData) {
                                    List<String> list = List();
                                    for (int i = 0;
                                        i < snap.data.personalData.data.length;
                                        i++) {
                                      list.add(snap
                                          .data.personalData.data[i].name
                                          .toString());
                                    }

                                    return PopupMenuButton<String>(
                                      padding: EdgeInsets.all(0),
                                      itemBuilder: (context) {
                                        return list.map((value) {
                                          return PopupMenuItem(
                                            value: value,
                                            child: Container(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  value,
                                                  style: TextStyle(
                                                    fontFamily:
                                                    FontFamilies.POPPINS,
                                                    fontSize:
                                                    (MediaQuery
                                                        .of(context)
                                                        .size
                                                        .height *
                                                        0.02),
                                                  ),
                                                )),
                                          );
                                        }).toList();
                                      },
                                      child: StreamBuilder(
                                        stream: personalDetailsBloc
                                            .selectedNationality,
                                        builder: (context, snap) {
                                          if (snap.hasData) {
                                            return Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                Text(
                                                  snap.data.toString(),
                                                  style: TextStyle(
                                                    fontFamily:
                                                    FontFamilies.POPPINS,
                                                    fontSize:
                                                    (MediaQuery
                                                        .of(context)
                                                        .size
                                                        .height *
                                                        0.02),
                                                  ),
                                                ),
                                                Container(
                                                  child: Icon(
                                                    Icons.keyboard_arrow_down,
                                                    size: 15,
                                                  ),
                                                  alignment: Alignment.center,
                                                  padding: EdgeInsets.only(
                                                      bottom: 3),
                                                ),
                                              ],
                                            );
                                          } else {
                                            return Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                Text(
                                                  list[0],
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
                                                Container(
                                                  child: Icon(
                                                    Icons.keyboard_arrow_down,
                                                    size:
                                                    (MediaQuery
                                                        .of(context)
                                                        .size
                                                        .height *
                                                        0.02),
                                                  ),
                                                  alignment: Alignment.center,
                                                  padding: EdgeInsets.only(
                                                      bottom: 3),
                                                ),
                                              ],
                                            );
                                          }
                                        },
                                      ),
                                      onSelected: (value) {
                                        personalDetailsBloc
                                            .setSelectedNationality(value);
                                      },
                                    );
                                  } else {
                                    return Text("");
                                  }
                                },
                              ),
                              // FutureBuilder<List<NationalityDetails>>(
                              //     future: NationalitiesDBProvider.db
                              //         .getAllNationalities(),
                              //     builder: (BuildContext context,
                              //         AsyncSnapshot<List<NationalityDetails>>
                              //             snapshot) {
                              //       personalDetailsBloc.fetchAllNationality();
                              //
                              //       if (snapshot.hasData) {
                              //         List<String> list = List();
                              //         for (int i = 0;
                              //             i < snapshot.data.length;
                              //             i++) {
                              //           list.add(
                              //               snapshot.data[i].name.toString());
                              //         }
                              //
                              //         return PopupMenuButton<String>(
                              //           padding: EdgeInsets.all(0),
                              //           itemBuilder: (context) {
                              //             return list.map((value) {
                              //               return PopupMenuItem(
                              //                 value: value,
                              //                 child: Container(
                              //                     alignment: Alignment.center,
                              //                     child: Text(
                              //                       value,
                              //                       style: TextStyle(
                              //                         fontFamily:
                              //                             FontFamilies.POPPINS,
                              //                         fontSize: (MediaQuery.of(
                              //                                     context)
                              //                                 .size
                              //                                 .height *
                              //                             0.02),
                              //                         color:
                              //                             AppColors.labelColor,
                              //                       ),
                              //                     )),
                              //               );
                              //             }).toList();
                              //           },
                              //           child: StreamBuilder(
                              //             stream: personalDetailsBloc
                              //                 .selectedNationality,
                              //             builder: (context, snap) {
                              //               if (snap.hasData) {
                              //                 return Row(
                              //                   mainAxisSize: MainAxisSize.min,
                              //                   children: <Widget>[
                              //                     Text(
                              //                       snap.data.toString(),
                              //                       style: TextStyle(
                              //                         fontFamily:
                              //                             FontFamilies.POPPINS,
                              //                         fontSize: (MediaQuery.of(
                              //                                     context)
                              //                                 .size
                              //                                 .height *
                              //                             0.02),
                              //                         color:
                              //                             AppColors.labelColor,
                              //                       ),
                              //                     ),
                              //                     Container(
                              //                       child: Icon(
                              //                         Icons.keyboard_arrow_down,
                              //                         size: 15,
                              //                       ),
                              //                       alignment: Alignment.center,
                              //                       padding: EdgeInsets.only(
                              //                           bottom: 3),
                              //                     ),
                              //                   ],
                              //                 );
                              //               } else {
                              //                 return Row(
                              //                   mainAxisSize: MainAxisSize.min,
                              //                   children: <Widget>[
                              //                     Text(
                              //                       captainPersonalData == null
                              //                           ? snapshot
                              //                           .data.first.name
                              //                           : snapshot
                              //                               .data[captainPersonalData.data.nationalityId-1].name,
                              //                       style: TextStyle(
                              //                         fontFamily:
                              //                             FontFamilies.POPPINS,
                              //                         fontSize: (MediaQuery.of(
                              //                                     context)
                              //                                 .size
                              //                                 .height *
                              //                             0.02),
                              //                         color:
                              //                             AppColors.labelColor,
                              //                       ),
                              //                     ),
                              //                     Container(
                              //                       child: Icon(
                              //                         Icons.keyboard_arrow_down,
                              //                         size: 15,
                              //                       ),
                              //                       alignment: Alignment.center,
                              //                       padding: EdgeInsets.only(
                              //                           bottom: 3),
                              //                     ),
                              //                   ],
                              //                 );
                              //               }
                              //             },
                              //           ),
                              //           onSelected: (value) {
                              //             personalDetailsBloc
                              //                 .setSelectedNationality(value);
                              //           },
                              //         );
                              //       } else {
                              //         return Text("");
                              //       }
                              //     })
                            ]),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.046),
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).size.height * 0.017),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                                width: 1.0, color: AppColors.LIGHT_BLUE),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Driver License Issue Date",
                              style: TextStyle(
                                fontFamily: FontFamilies.POPPINS,
                                fontSize:
                                    (MediaQuery.of(context).size.height * 0.02),
                                color: AppColors.labelColor,
                              ),
                            ),
                            StreamBuilder(
                              stream: personalDetailsBloc.licenseIssueDate,
                              builder: (context, snap) {
                                if (snap.hasData) {
                                  return InkWell(
                                    onTap: () {
                                      showDialog(
                                              barrierDismissible: false,
                                              context: context,
                                              builder: (BuildContext context) {
                                                return CalendarWidget(
                                                  screen:
                                                      "DRIVER_LICENSE_ISSUE_DATE",
                                                );
                                              })
                                          .then((value) => FlutterStatusbarcolor
                                              .setStatusBarColor(Colors.white));
                                    },
                                    child: Text(
                                      Utils.dateFormat1(snap.data),
                                      style: TextStyle(
                                        color: AppColors.MAIN_COLOR,
                                        fontFamily: FontFamilies.POPPINS,
                                        fontSize: (MediaQuery.of(context)
                                                .size
                                                .height *
                                            0.02),
                                      ),
                                    ),
                                  );
                                } else {
                                  return calendarDialogIssueDate(context);
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                      StreamBuilder(
                        stream: personalDetailsBloc.issueDateValidation,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Container(
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.width *
                                        0.01),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      "assets/images/error_icon.png",
                                      width: 10,
                                      height: 10,
                                    ),
                                    Container(
                                        width:
                                            MediaQuery.of(context).size.width -
                                                60,
                                        padding: EdgeInsets.only(left: 8),
                                        child: Text(
                                          "  " + snapshot.data,
                                          style: TextStyle(
                                              color: AppColors.ERROR,
                                              fontFamily: 'Poppins',
                                              fontSize: 10),
                                        )),
                                  ],
                                ));
                          } else {
                            return Container();
                          }
                        },
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.046),
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).size.height * 0.017),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Driver License Expiry Date",
                              style: TextStyle(
                                fontFamily: FontFamilies.POPPINS,
                                fontSize:
                                    (MediaQuery.of(context).size.height * 0.02),
                                color: AppColors.labelColor,
                              ),
                            ),
                            StreamBuilder(
                              stream: personalDetailsBloc.licenseExpiredDate,
                              builder: (context, snap) {
                                if (snap.hasData) {
                                  return InkWell(
                                    onTap: () {
                                      showDialog(
                                              barrierDismissible: false,
                                              context: context,
                                              builder: (BuildContext context) {
                                                return CalendarWidget(
                                                  screen:
                                                      "DRIVER_LICENSE_EXPIRED_DATE",
                                                );
                                              })
                                          .then((value) => FlutterStatusbarcolor
                                              .setStatusBarColor(Colors.white));
                                    },
                                    child: Text(
                                      Utils.dateFormat1(snap.data),
                                      style: TextStyle(
                                        color: AppColors.MAIN_COLOR,
                                        fontFamily: FontFamilies.POPPINS,
                                        fontSize: (MediaQuery.of(context)
                                                .size
                                                .height *
                                            0.02),
                                      ),
                                    ),
                                  );
                                } else {
                                  return calendarDialogExpiredDate(context);
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                      StreamBuilder(
                        stream: personalDetailsBloc.expiredDateValidation,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Container(
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.width *
                                        0.01),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      "assets/images/error_icon.png",
                                      width: 10,
                                      height: 10,
                                    ),
                                    Container(
                                        width:
                                            MediaQuery.of(context).size.width -
                                                60,
                                        padding: EdgeInsets.only(left: 8),
                                        child: Text(
                                          "  " + snapshot.data,
                                          style: TextStyle(
                                              color: AppColors.ERROR,
                                              fontFamily: 'Poppins',
                                              fontSize: 10),
                                        )),
                                  ],
                                ));
                          } else {
                            return Container();
                          }
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.completedInfoBoxUnderLine,
                        spreadRadius: 2,
                        blurRadius: 2,
                        offset: Offset(0.5, 1), // changes position of shadow
                      ),
                    ],
                  ),
                  margin: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.width * 0.08,
                    left: MediaQuery.of(context).size.width * 0.05,
                    right: MediaQuery.of(context).size.width * 0.05,
                  ),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width / 7,
                  child: ButtonTheme(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      buttonColor: Colors.white,
                      child: StreamBuilder(
                        stream: personalDetailsBloc.message,
                        builder: (BuildContext context,
                            AsyncSnapshot<String> snapshot) {
                          if (snapshot.hasData) {
                            return StreamBuilder(
                                stream: personalDetailsBloc.birthdayValidation,
                                builder: (context, snap) {
                                  if (snap.hasData) {
                                    return RaisedButton(
                                      onPressed: () {
                                        showDialog<void>(
                                            context: context,
                                            barrierDismissible: true,
                                            // user must tap button!
                                            builder: (BuildContext context) {
                                              Future.delayed(
                                                  Duration(seconds: 5), () {
                                                Navigator.of(context).pop();
                                              });
                                              return ErrorDialogWidget(
                                                text: snap.data,
                                              );
                                            })
                                            .then((value) =>
                                            FlutterStatusbarcolor
                                                .setStatusBarColor(
                                                Colors.white));

                                        TextFieldValidation()
                                            .checkEmailValidation(
                                            personalDetailsBloc
                                                .getEmail()
                                                .toString(),
                                            'PERSONAL_DETAILS');

                                        TextFieldValidation()
                                            .checkDriverLicenseIssueDateValidation(
                                            personalDetailsBloc
                                                .getDriverIssueDate());
                                        TextFieldValidation()
                                            .checkDriverLicenseExpiredDateValidation(
                                            personalDetailsBloc
                                                .getDriverExpiredDate());
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            "Continue ",
                                            style: TextStyle(
                                              fontFamily: FontFamilies.POPPINS,
                                              fontSize: (MediaQuery
                                                  .of(context)
                                                  .size
                                                  .width *
                                                  0.008) +
                                                  FontSize.BUTTON_FONT_L,
                                              color: Colors.black,
                                            ),
                                          ),
                                          Icon(
                                            Icons.arrow_forward,
                                            color: Colors.black,
                                            size: (MediaQuery
                                                .of(context)
                                                .size
                                                .width *
                                                0.008) +
                                                18,
                                          ),
                                        ],
                                      ),
                                    );
                                  } else {
                                    return RaisedButton(
                                      onPressed: () {
                                        // TextFieldValidation().checkPassValidation(
                                        //     personalDetailsBloc
                                        //         .getPassword()
                                        //         .toString(),
                                        //     'PERSONAL_DETAILS');
                                        TextFieldValidation()
                                            .checkEmailValidation(
                                            personalDetailsBloc
                                                .getEmail()
                                                .toString(),
                                            'PERSONAL_DETAILS');
                                        // TextFieldValidation().checkPasswordMatching(
                                        //     personalDetailsBloc
                                        //         .getPassword()
                                        //         .toString(),
                                        //     personalDetailsBloc
                                        //         .Password()
                                        //         .toString());
                                        TextFieldValidation()
                                            .checkDriverLicenseIssueDateValidation(
                                            personalDetailsBloc
                                                .getDriverIssueDate());
                                        TextFieldValidation()
                                            .checkDriverLicenseExpiredDateValidation(
                                            personalDetailsBloc
                                                .getDriverExpiredDate());

                                        if (personalDetailsBloc
                                            .checkEditPersonalDetailsValidation()) {
                                          personalDetailsBloc.editAccount();
                                          captainPersonalData == null
                                              ? Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                                  return VehicleDetailsScreen(
                                                    plateCode: vehicleBloc
                                                        .getPlateNumber(),
                                                  );
                                                }),
                                          )
                                              : Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                                  return CompletedInfoScreen();
                                                }),
                                          );
                                        } else {}
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            "Continue ",
                                            style: TextStyle(
                                              fontFamily: FontFamilies.POPPINS,
                                              fontSize: (MediaQuery
                                                  .of(context)
                                                  .size
                                                  .width *
                                                  0.008) +
                                                  FontSize.BUTTON_FONT_L,
                                              color: Colors.black,
                                            ),
                                          ),
                                          Icon(
                                            Icons.arrow_forward,
                                            color: Colors.black,
                                            size: (MediaQuery
                                                .of(context)
                                                .size
                                                .width *
                                                0.008) +
                                                18,
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                                });
                          } else {
                            return captainPersonalData == null
                                ? StreamBuilder(
                              stream: personalDetailsBloc.submitValid,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return StreamBuilder(
                                    stream: personalDetailsBloc
                                        .birthdayValidation,
                                    builder: (context, snap) {
                                      if (snap.hasData) {
                                        return RaisedButton(
                                          onPressed: () {
                                            showDialog<void>(
                                                context: context,
                                                barrierDismissible: true,
                                                // user must tap button!
                                                builder: (BuildContext
                                                context) {
                                                  Future.delayed(
                                                      Duration(
                                                          seconds: 5),
                                                          () {
                                                        Navigator.of(
                                                            context)
                                                            .pop();
                                                      });
                                                  return ErrorDialogWidget(
                                                    text: snap.data,
                                                  );
                                                })
                                                .then((value) =>
                                                FlutterStatusbarcolor
                                                    .setStatusBarColor(
                                                    Colors
                                                        .white));
                                            TextFieldValidation()
                                                .checkPassValidation(
                                                personalDetailsBloc
                                                    .getPassword()
                                                    .toString(),
                                                'PERSONAL_DETAILS');
                                            TextFieldValidation()
                                                .checkEmailValidation(
                                                personalDetailsBloc
                                                    .getEmail()
                                                    .toString(),
                                                'PERSONAL_DETAILS');
                                            TextFieldValidation()
                                                .checkPasswordMatching(
                                                personalDetailsBloc
                                                    .getPassword()
                                                    .toString(),
                                                personalDetailsBloc
                                                    .getConfirmPassword()
                                                    .toString());
                                            TextFieldValidation()
                                                .checkDriverLicenseIssueDateValidation(
                                                personalDetailsBloc
                                                    .getDriverIssueDate());
                                            TextFieldValidation()
                                                .checkDriverLicenseExpiredDateValidation(
                                                personalDetailsBloc
                                                    .getDriverExpiredDate());

                                            if (personalDetailsBloc
                                                .checkPersonalDetailsValidation()) {
                                              personalDetailsBloc
                                                  .createAccount();
                                              _showDialog(context);
                                            } else {}
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceBetween,
                                            children: <Widget>[
                                              Text(
                                                "Continue ",
                                                style: TextStyle(
                                                  fontFamily: FontFamilies
                                                      .POPPINS,
                                                  fontSize: (MediaQuery
                                                      .of(
                                                      context)
                                                      .size
                                                      .width *
                                                      0.008) +
                                                      FontSize
                                                          .BUTTON_FONT_L,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              Icon(
                                                Icons.arrow_forward,
                                                color: Colors.black,
                                                size: (MediaQuery
                                                    .of(
                                                    context)
                                                    .size
                                                    .width *
                                                    0.008) +
                                                    18,
                                              ),
                                            ],
                                          ),
                                        );
                                      } else {
                                        return RaisedButton(
                                          onPressed: () {
                                            TextFieldValidation()
                                                .checkPassValidation(
                                                personalDetailsBloc
                                                    .getPassword()
                                                    .toString(),
                                                'PERSONAL_DETAILS');
                                            TextFieldValidation()
                                                .checkEmailValidation(
                                                personalDetailsBloc
                                                    .getEmail()
                                                    .toString(),
                                                'PERSONAL_DETAILS');
                                            TextFieldValidation()
                                                .checkPasswordMatching(
                                                personalDetailsBloc
                                                    .getPassword()
                                                    .toString(),
                                                personalDetailsBloc
                                                    .getConfirmPassword()
                                                    .toString());
                                            TextFieldValidation()
                                                .checkDriverLicenseIssueDateValidation(
                                                personalDetailsBloc
                                                    .getDriverIssueDate());
                                            TextFieldValidation()
                                                .checkDriverLicenseExpiredDateValidation(
                                                personalDetailsBloc
                                                    .getDriverExpiredDate());
                                            if (personalDetailsBloc
                                                .checkPersonalDetailsValidation()) {
                                              personalDetailsBloc
                                                  .createAccount();

                                              _showDialog(context);
                                            } else {}
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceBetween,
                                            children: <Widget>[
                                              Text(
                                                "Continue ",
                                                style: TextStyle(
                                                  fontFamily: FontFamilies
                                                      .POPPINS,
                                                  fontSize: (MediaQuery
                                                      .of(
                                                      context)
                                                      .size
                                                      .width *
                                                      0.008) +
                                                      FontSize
                                                          .BUTTON_FONT_L,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              Icon(
                                                Icons.arrow_forward,
                                                color: Colors.black,
                                                size: (MediaQuery
                                                    .of(
                                                    context)
                                                    .size
                                                    .width *
                                                    0.008) +
                                                    18,
                                              ),
                                            ],
                                          ),
                                        );
                                      }
                                    },
                                  );
                                } else {
                                  return RaisedButton(
                                    onPressed: () {},
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          "Continue ",
                                          style: TextStyle(
                                            fontFamily:
                                            FontFamilies.POPPINS,
                                            fontSize:
                                            (MediaQuery
                                                .of(context)
                                                .size
                                                .width *
                                                0.008) +
                                                FontSize
                                                    .BUTTON_FONT_L,
                                            color: AppColors.LIGHT_GREY,
                                          ),
                                        ),
                                        Icon(
                                          Icons.arrow_forward,
                                          color: AppColors.LIGHT_GREY,
                                          size: (MediaQuery
                                              .of(context)
                                              .size
                                              .width *
                                              0.008) +
                                              18,
                                        ),
                                      ],
                                    ),
                                  );
                                }
                              },
                            )
                                : StreamBuilder(
                                stream:
                                personalDetailsBloc.birthdayValidation,
                                builder: (context, snap) {
                                  if (snap.hasData) {
                                    return RaisedButton(
                                      onPressed: () {
                                        showDialog<void>(
                                            context: context,
                                            barrierDismissible: true,
                                            // user must tap button!
                                            builder:
                                                (BuildContext context) {
                                              Future.delayed(
                                                  Duration(seconds: 5),
                                                      () {
                                                    Navigator.of(context)
                                                        .pop();
                                                  });
                                              return ErrorDialogWidget(
                                                text: snap.data,
                                              );
                                            })
                                            .then((value) =>
                                            FlutterStatusbarcolor
                                                .setStatusBarColor(
                                                Colors.white));

                                        TextFieldValidation()
                                            .checkEmailValidation(
                                            personalDetailsBloc
                                                .getEmail()
                                                .toString(),
                                            'PERSONAL_DETAILS');

                                        TextFieldValidation()
                                            .checkDriverLicenseIssueDateValidation(
                                            personalDetailsBloc
                                                .getDriverIssueDate());
                                        TextFieldValidation()
                                            .checkDriverLicenseExpiredDateValidation(
                                            personalDetailsBloc
                                                .getDriverExpiredDate());
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            "Continue ",
                                            style: TextStyle(
                                              fontFamily:
                                              FontFamilies.POPPINS,
                                              fontSize:
                                              (MediaQuery
                                                  .of(context)
                                                  .size
                                                  .width *
                                                  0.008) +
                                                  FontSize
                                                      .BUTTON_FONT_L,
                                              color: Colors.black,
                                            ),
                                          ),
                                          Icon(
                                            Icons.arrow_forward,
                                            color: Colors.black,
                                            size: (MediaQuery
                                                .of(context)
                                                .size
                                                .width *
                                                0.008) +
                                                18,
                                          ),
                                        ],
                                      ),
                                    );
                                  } else {
                                    return RaisedButton(
                                      onPressed: () {
                                        // TextFieldValidation().checkPassValidation(
                                        //     personalDetailsBloc
                                        //         .getPassword()
                                        //         .toString(),
                                        //     'PERSONAL_DETAILS');
                                        TextFieldValidation()
                                            .checkEmailValidation(
                                            personalDetailsBloc
                                                .getEmail()
                                                .toString(),
                                            'PERSONAL_DETAILS');
                                        // TextFieldValidation().checkPasswordMatching(
                                        //     personalDetailsBloc
                                        //         .getPassword()
                                        //         .toString(),
                                        //     personalDetailsBloc
                                        //         .getConfirmPassword()
                                        //         .toString());
                                        TextFieldValidation()
                                            .checkDriverLicenseIssueDateValidation(
                                            personalDetailsBloc
                                                .getDriverIssueDate());
                                        TextFieldValidation()
                                            .checkDriverLicenseExpiredDateValidation(
                                            personalDetailsBloc
                                                .getDriverExpiredDate());

                                        if (personalDetailsBloc
                                            .checkEditPersonalDetailsValidation()) {
                                          personalDetailsBloc.editAccount();
                                          captainPersonalData.data.car !=
                                              null &&
                                              captainPersonalData.data
                                                  .drivingCertificateF !=
                                                  null
                                              ? Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                                  return CompletedInfoScreen();
                                                }),
                                          )
                                              : Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                                  return InCompletedInfoScreen();
                                                }),
                                          );
                                        } else {}
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            "Continue ",
                                            style: TextStyle(
                                              fontFamily:
                                              FontFamilies.POPPINS,
                                              fontSize:
                                              (MediaQuery
                                                  .of(context)
                                                  .size
                                                  .width *
                                                  0.008) +
                                                  FontSize
                                                      .BUTTON_FONT_L,
                                              color: Colors.black,
                                            ),
                                          ),
                                          Icon(
                                            Icons.arrow_forward,
                                            color: Colors.black,
                                            size: (MediaQuery
                                                .of(context)
                                                .size
                                                .width *
                                                0.008) +
                                                18,
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                                });
                          }
                        },
                      )),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 5),
            child: Image.asset("assets/images/home_indicator.png"),
          ),
        ],
      )),
    );
  }

  InkWell calendarDialog(BuildContext context) {
    return InkWell(
      onTap: () {
        passNode.unfocus();
        confirmPassNode.unfocus();
        firstNameNode.unfocus();
        lastNameNode.unfocus();
        emailNode.unfocus();
        personalDetailsBloc.setCalendarColor(true);
        showDialog(
                barrierDismissible: false,
                context: context,
                builder: (BuildContext context) {
                  return CalendarWidget(
                    screen: "BIRTHDAY_DATE",
                  );
                })
            .then((value) =>
                FlutterStatusbarcolor.setStatusBarColor(Colors.white));
      },
      child: StreamBuilder(
        stream: personalDetailsBloc.calendarColor,
        builder: (context, snap) {
          if (snap.hasData) {
            return Container(
                margin: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height * 0.005),
                child: SvgPicture.asset(
                  "assets/images/calendar.svg",
                  width: MediaQuery.of(context).size.width * 0.05,
                  height: MediaQuery.of(context).size.width * 0.05,
                  color:
                      snap.data ? AppColors.MAIN_COLOR : AppColors.labelColor,
                ));
          } else {
            return Container(
                margin: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height * 0.005),
                child: SvgPicture.asset(
                  "assets/images/calendar.svg",
                  width: MediaQuery.of(context).size.width * 0.05,
                  height: MediaQuery.of(context).size.width * 0.05,
                ));
          }
        },
      ),
    );
  }

  InkWell calendarDialogIssueDate(BuildContext context) {
    return InkWell(
      onTap: () {
        passNode.unfocus();
        confirmPassNode.unfocus();
        firstNameNode.unfocus();
        lastNameNode.unfocus();
        emailNode.unfocus();
        personalDetailsBloc.setCalendarColorIssue(true);
        showDialog(
                barrierDismissible: false,
                context: context,
                builder: (BuildContext context) {
                  return CalendarWidget(
                    screen: "DRIVER_LICENSE_ISSUE_DATE",
                  );
                })
            .then((value) =>
                FlutterStatusbarcolor.setStatusBarColor(Colors.white));
      },
      child: StreamBuilder(
        stream: personalDetailsBloc.calendarColorIssueDate,
        builder: (context, snap) {
          if (snap.hasData) {
            return SvgPicture.asset(
              "assets/images/calendar.svg",
              width: MediaQuery.of(context).size.width * 0.05,
              height: MediaQuery.of(context).size.width * 0.05,
              color: snap.data ? AppColors.MAIN_COLOR : AppColors.labelColor,
            );
          } else {
            return SvgPicture.asset(
              "assets/images/calendar.svg",
              width: MediaQuery.of(context).size.width * 0.05,
              height: MediaQuery.of(context).size.width * 0.05,
            );
          }
        },
      ),
    );
  }

  InkWell calendarDialogExpiredDate(BuildContext context) {
    return InkWell(
      onTap: () {
        passNode.unfocus();
        confirmPassNode.unfocus();
        firstNameNode.unfocus();
        lastNameNode.unfocus();
        emailNode.unfocus();
        personalDetailsBloc.setCalendarColorExpired(true);
        showDialog(
                barrierDismissible: false,
                context: context,
                builder: (BuildContext context) {
                  return CalendarWidget(
                    screen: "DRIVER_LICENSE_EXPIRED_DATE",
                  );
                })
            .then((value) =>
                FlutterStatusbarcolor.setStatusBarColor(Colors.white));
      },
      child: StreamBuilder(
        stream: personalDetailsBloc.calendarColorExpiredDate,
        builder: (context, snap) {
          if (snap.hasData) {
            return SvgPicture.asset(
              "assets/images/calendar.svg",
              width: MediaQuery.of(context).size.width * 0.05,
              height: MediaQuery.of(context).size.width * 0.05,
              color: snap.data ? AppColors.MAIN_COLOR : AppColors.labelColor,
            );
          } else {
            return SvgPicture.asset(
              "assets/images/calendar.svg",
              width: MediaQuery.of(context).size.width * 0.05,
              height: MediaQuery.of(context).size.width * 0.05,
            );
          }
        },
      ),
    );
  }

  Widget firstNameTextField() => StreamBuilder<String>(
        stream: personalDetailsBloc.firstName,
        builder: (context, snap) {
          return Container(
            margin: EdgeInsets.only(top: 20),
            child: TextFormField(
              style: TextStyle(
                fontFamily: FontFamilies.POPPINS,
                fontSize: (MediaQuery
                    .of(context)
                    .size
                    .height * 0.02),
              ),
              initialValue: captainPersonalData != null
                  ? captainPersonalData.data.firstName
                  : firstName != null
                  ? firstName
                  : "",
              focusNode: firstNameNode,
              cursorColor: AppColors.MAIN_COLOR,
              keyboardType: TextInputType.text,
              decoration: new InputDecoration(
                contentPadding: EdgeInsets.all(0),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.LIGHT_BLUE),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.MAIN_COLOR),
                ),
                errorText: snap.error,
                labelText: 'First Name',
                labelStyle: TextStyle(
                    color: AppColors.labelColor, fontFamily: 'Poppins'),
              ),
              onChanged: (personalDetailsBloc.changeFirstName),
            ),
          );
        },
      );

  Widget lastNameTextField() => StreamBuilder<String>(
        stream: personalDetailsBloc.lastName,
        builder: (context, snap) {
          return Container(
            margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.018),
            child: TextFormField(
              style: TextStyle(
                fontFamily: FontFamilies.POPPINS,
                fontSize: (MediaQuery
                    .of(context)
                    .size
                    .height * 0.02),
              ),
              initialValue: captainPersonalData != null
                  ? captainPersonalData.data.lastName
                  : lastName != null
                  ? lastName
                  : "",
              focusNode: lastNameNode,
              cursorColor: AppColors.MAIN_COLOR,
              keyboardType: TextInputType.text,
              decoration: new InputDecoration(
                contentPadding: EdgeInsets.all(0),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.LIGHT_BLUE),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.MAIN_COLOR),
                ),
                labelText: 'Last Name',
                labelStyle: TextStyle(
                  color: AppColors.labelColor,
                  fontFamily: FontFamilies.POPPINS,
                ),
              ),
              onChanged: (personalDetailsBloc.changeLastName),
            ),
          );
        },
      );

  Widget emailTextField() => StreamBuilder<String>(
        stream: personalDetailsBloc.email,
        builder: (context, snap) {
          return Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.018),
              child: Column(
                children: [
                  TextFormField(
                    style: TextStyle(
                      fontFamily: FontFamilies.POPPINS,
                      fontSize: (MediaQuery
                          .of(context)
                          .size
                          .height * 0.02),
                    ),
                    initialValue: captainPersonalData != null
                        ? captainPersonalData.data.email
                        : email != null
                        ? email
                        : "",
                    focusNode: emailNode,
                    cursorColor: AppColors.MAIN_COLOR,
                    keyboardType: TextInputType.text,
                    decoration: new InputDecoration(
                      contentPadding: EdgeInsets.all(0),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.LIGHT_BLUE),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.MAIN_COLOR),
                      ),
                      errorText: snap.error,
                      labelText: 'Email Address',
                      labelStyle: TextStyle(
                          color: AppColors.labelColor, fontFamily: 'Poppins'),
                    ),
                    onChanged: (personalDetailsBloc.changeEmail),
                  ),
                  StreamBuilder(
                    stream: personalDetailsBloc.isEmailValid,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Container(
                            child: Row(
                          children: [
                            Image.asset(
                              "assets/images/error_icon.png",
                              width: 10,
                              height: 10,
                            ),
                            Text(
                              "  " + snapshot.data,
                              style: TextStyle(
                                  color: AppColors.ERROR,
                                  fontFamily: 'Poppins',
                                  fontSize: 10),
                            )
                          ],
                            ));
                      } else {
                        return Container();
                      }
                    },
                  ),
                ],
              ));
        },
  );

  Widget passTextField() {
    final _controller = TextEditingController();
    return StreamBuilder<String>(
      stream: personalDetailsBloc.password,
      builder: (context, snap) {
        return Column(
          children: [
            StreamBuilder(
              stream: personalDetailsBloc.isPasswordHide,
              builder: (context, snap) {
                return StreamBuilder(
                  stream: personalDetailsBloc.isEmailValid,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Container(
                        margin: EdgeInsets.only(top: 3),
                        child: TextField(
                          style: TextStyle(
                            fontFamily: FontFamilies.POPPINS,
                            fontSize:
                            (MediaQuery
                                .of(context)
                                .size
                                .height * 0.02),
                          ),
                          enabled: personalDetailsBloc.getMessage() == null
                              ? true
                              : false,
                          focusNode: passNode,
                          cursorColor: AppColors.MAIN_COLOR,
                          keyboardType: TextInputType.text,
                          decoration: new InputDecoration(
                              contentPadding: EdgeInsets.all(0),
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                BorderSide(color: AppColors.LIGHT_BLUE),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                BorderSide(color: AppColors.MAIN_COLOR),
                              ),
                              labelText: 'New Password',
                              labelStyle: TextStyle(
                                  color: AppColors.labelColor,
                                  fontFamily: 'Poppins'),
                              suffix: InkWell(
                                child: snap.hasData
                                    ? snap.data
                                    ? Image.asset(
                                  "assets/images/hidden_pass.png",
                                  width: 15,
                                  height: 15,
                                )
                                    : Image.asset(
                                  "assets/images/show_pass.png",
                                  width: 15,
                                  height: 15,
                                )
                                    : Image.asset(
                                  "assets/images/hidden_pass.png",
                                  width: 15,
                                  height: 15,
                                ),
                                onTap: () {
                                  snap.hasData
                                      ? personalDetailsBloc
                                      .setPasswordVisibility(!snap.data)
                                      : personalDetailsBloc
                                      .setPasswordVisibility(false);
                                },
                              )),
                          obscureText: snap.hasData ? snap.data : true,
                          onChanged: (personalDetailsBloc.changePassword),
                        ),
                      );
                    } else {
                      return StreamBuilder(
                        stream: personalDetailsBloc.message,
                        builder: (BuildContext context,
                            AsyncSnapshot<String> snapshot) {
                          print(snapshot.data);
                          if (snapshot.hasData && snapshot.data == "success") {
                            return Container(
                              width: 520,
                              height: 50,
                              margin: EdgeInsets.only(
                                  top: MediaQuery
                                      .of(context)
                                      .size
                                      .height *
                                      0.018),
                              child: Stack(
                                children: [
                                  Container(
                                    // margin: EdgeInsets.only(top: 5, bottom: 10),
                                      width: MediaQuery
                                          .of(context)
                                          .size
                                          .width,
                                      child: StreamBuilder(
                                        stream: personalDetailsBloc.password,
                                        builder: (BuildContext context,
                                            AsyncSnapshot<String> snapshot) {
                                          _controller.text = snapshot.data;
                                          return TextFormField(
                                            controller: _controller,
                                            style: TextStyle(
                                              fontFamily: FontFamilies.POPPINS,
                                              fontSize: (MediaQuery
                                                  .of(context)
                                                  .size
                                                  .height *
                                                  0.02),
                                            ),
                                            enabled: false,
                                            focusNode: passNode,
                                            cursorColor: AppColors.MAIN_COLOR,
                                            keyboardType: TextInputType.text,
                                            decoration: new InputDecoration(
                                              contentPadding: EdgeInsets.all(0),
                                              enabledBorder:
                                              UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color:
                                                    AppColors.LIGHT_BLUE),
                                              ),
                                              focusedBorder:
                                              UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color:
                                                    AppColors.MAIN_COLOR),
                                              ),

                                              labelText: 'New Password',
                                              labelStyle: TextStyle(
                                                  color: AppColors.labelColor,
                                                  fontFamily: 'Poppins'),
                                              // suffix: InkWell(
                                              //   child: snap.hasData
                                              //       ? snap.data
                                              //       ? Image.asset(
                                              //     "assets/images/hidden_pass.png",
                                              //     width: 15,
                                              //     height: 15,
                                              //   )
                                              //       : Image.asset(
                                              //     "assets/images/show_pass.png",
                                              //     width: 15,
                                              //     height: 15,
                                              //   )
                                              //       : Image.asset(
                                              //     "assets/images/hidden_pass.png",
                                              //     width: 15,
                                              //     height: 15,
                                              //   ),
                                              //   onTap: () {
                                              //     snap.hasData
                                              //         ? personalDetailsBloc
                                              //         .setPasswordVisibility(!snap.data)
                                              //         : personalDetailsBloc
                                              //         .setPasswordVisibility(false);
                                              //   },
                                              // )
                                            ),
                                            obscureText:
                                            snap.hasData ? snap.data : true,
                                          );
                                        },
                                      )),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: InkWell(
                                      child: snap.hasData
                                          ? snap.data
                                          ? Image.asset(
                                        "assets/images/hidden_pass.png",
                                        width: 15,
                                        height: 15,
                                      )
                                          : Image.asset(
                                        "assets/images/show_pass.png",
                                        width: 15,
                                        height: 15,
                                      )
                                          : Image.asset(
                                        "assets/images/hidden_pass.png",
                                        width: 15,
                                        height: 15,
                                      ),
                                      onTap: () {
                                        snap.hasData
                                            ? personalDetailsBloc
                                            .setPasswordVisibility(
                                            !snap.data)
                                            : personalDetailsBloc
                                            .setPasswordVisibility(false);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            );
                          } else {
                            return Container(
                              margin: EdgeInsets.only(
                                  top: MediaQuery
                                      .of(context)
                                      .size
                                      .height *
                                      0.018),
                              child: TextField(
                                style: TextStyle(
                                  fontFamily: FontFamilies.POPPINS,
                                  fontSize:
                                  (MediaQuery
                                      .of(context)
                                      .size
                                      .height *
                                      0.02),
                                ),
                                focusNode: passNode,
                                cursorColor: AppColors.MAIN_COLOR,
                                keyboardType: TextInputType.text,
                                decoration: new InputDecoration(
                                    contentPadding: EdgeInsets.all(0),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColors.LIGHT_BLUE),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColors.MAIN_COLOR),
                                    ),
                                    labelText: 'New Password',
                                    labelStyle: TextStyle(
                                        color: AppColors.labelColor,
                                        fontFamily: 'Poppins'),
                                    suffix: InkWell(
                                      child: snap.hasData
                                          ? snap.data
                                          ? Image.asset(
                                        "assets/images/hidden_pass.png",
                                        width: 15,
                                        height: 15,
                                      )
                                          : Image.asset(
                                        "assets/images/show_pass.png",
                                        width: 15,
                                        height: 15,
                                      )
                                          : Image.asset(
                                        "assets/images/hidden_pass.png",
                                        width: 15,
                                        height: 15,
                                      ),
                                      onTap: () {
                                        snap.hasData
                                            ? personalDetailsBloc
                                            .setPasswordVisibility(
                                            !snap.data)
                                            : personalDetailsBloc
                                            .setPasswordVisibility(false);
                                      },
                                    )),
                                obscureText: snap.hasData ? snap.data : true,
                                onChanged: (personalDetailsBloc.changePassword),
                              ),
                            );
                          }
                        },
                      );
                    }
                  },
                );
              },
            ),
            StreamBuilder(
              stream: personalDetailsBloc.isPassValid,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      padding: EdgeInsets.only(
                          top: MediaQuery
                              .of(context)
                              .size
                              .width * 0.01),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            "assets/images/error_icon.png",
                            width: 10,
                            height: 10,
                          ),
                          Container(
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width - 60,
                              padding: EdgeInsets.only(left: 8),
                              child: Text(
                                "  " + snapshot.data,
                                style: TextStyle(
                                    color: AppColors.ERROR,
                                    fontFamily: 'Poppins',
                                    fontSize: 10),
                              )),
                        ],
                      ));
                } else {
                  return Container();
                }
              },
            ),
          ],
        );
      },
    );
  }

  Widget confirmPassTextField() {
    final _controller = TextEditingController();
    return StreamBuilder<String>(
      stream: personalDetailsBloc.confirmPass,
      builder: (context, snap) {
        return Column(
          children: [
            StreamBuilder(
              stream: personalDetailsBloc.isConfirmPasswordHide,
              builder: (context, snap) {
                return StreamBuilder(
                  stream: personalDetailsBloc.isPassValid,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Container(
                        margin: EdgeInsets.only(top: 3),
                        child: TextField(
                          style: TextStyle(
                            fontFamily: FontFamilies.POPPINS,
                            fontSize:
                            (MediaQuery
                                .of(context)
                                .size
                                .height * 0.02),
                          ),
                          enabled: personalDetailsBloc.getMessage() == null
                              ? true
                              : false,
                          focusNode: confirmPassNode,
                          cursorColor: AppColors.MAIN_COLOR,
                          keyboardType: TextInputType.text,
                          decoration: new InputDecoration(
                              contentPadding: EdgeInsets.all(0),
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                BorderSide(color: AppColors.LIGHT_BLUE),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                BorderSide(color: AppColors.MAIN_COLOR),
                              ),
                              labelText: 'Confirm Password',
                              labelStyle: TextStyle(
                                  color: AppColors.labelColor,
                                  fontFamily: 'Poppins'),
                              suffix: InkWell(
                                child: snap.hasData
                                    ? snap.data
                                    ? Image.asset(
                                  "assets/images/hidden_pass.png",
                                  width: 15,
                                  height: 15,
                                )
                                    : Image.asset(
                                  "assets/images/show_pass.png",
                                  width: 15,
                                  height: 15,
                                )
                                    : Image.asset(
                                  "assets/images/hidden_pass.png",
                                  width: 15,
                                  height: 15,
                                ),
                                onTap: () {
                                  snap.hasData
                                      ? personalDetailsBloc
                                      .setConfirmPasswordVisibility(
                                      !snap.data)
                                      : personalDetailsBloc
                                      .setConfirmPasswordVisibility(false);
                                },
                              )),
                          obscureText: snap.hasData ? snap.data : true,
                          onChanged: (personalDetailsBloc.changeConfirmPass),
                        ),
                      );
                    } else {
                      return StreamBuilder(
                        stream: personalDetailsBloc.message,
                        builder: (BuildContext context,
                            AsyncSnapshot<String> snapshot) {
                          print(snapshot.data);
                          if (snapshot.hasData && snapshot.data == "success") {
                            return Container(
                              width: 520,
                              height: 50,
                              margin: EdgeInsets.only(
                                  top: MediaQuery
                                      .of(context)
                                      .size
                                      .height *
                                      0.018),
                              child: Stack(
                                children: [
                                  Container(
                                    // margin: EdgeInsets.only(top: 5, bottom: 10),
                                      width: MediaQuery
                                          .of(context)
                                          .size
                                          .width,
                                      child: StreamBuilder(
                                        stream: personalDetailsBloc.confirmPass,
                                        builder: (BuildContext context,
                                            AsyncSnapshot<String> snapshot) {
                                          _controller.text = snapshot.data;
                                          return TextFormField(
                                            controller: _controller,
                                            style: TextStyle(
                                              fontFamily: FontFamilies.POPPINS,
                                              fontSize: (MediaQuery
                                                  .of(context)
                                                  .size
                                                  .height *
                                                  0.02),
                                            ),
                                            enabled: false,
                                            focusNode: confirmPassNode,
                                            cursorColor: AppColors.MAIN_COLOR,
                                            keyboardType: TextInputType.text,
                                            decoration: new InputDecoration(
                                              contentPadding: EdgeInsets.all(0),
                                              enabledBorder:
                                              UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color:
                                                    AppColors.LIGHT_BLUE),
                                              ),
                                              focusedBorder:
                                              UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color:
                                                    AppColors.MAIN_COLOR),
                                              ),

                                              labelText: 'Confirm Password',
                                              labelStyle: TextStyle(
                                                  color: AppColors.labelColor,
                                                  fontFamily: 'Poppins'),
                                              // suffix: InkWell(
                                              //   child: snap.hasData
                                              //       ? snap.data
                                              //       ? Image.asset(
                                              //     "assets/images/hidden_pass.png",
                                              //     width: 15,
                                              //     height: 15,
                                              //   )
                                              //       : Image.asset(
                                              //     "assets/images/show_pass.png",
                                              //     width: 15,
                                              //     height: 15,
                                              //   )
                                              //       : Image.asset(
                                              //     "assets/images/hidden_pass.png",
                                              //     width: 15,
                                              //     height: 15,
                                              //   ),
                                              //   onTap: () {
                                              //     snap.hasData
                                              //         ? personalDetailsBloc
                                              //         .setPasswordVisibility(!snap.data)
                                              //         : personalDetailsBloc
                                              //         .setPasswordVisibility(false);
                                              //   },
                                              // )
                                            ),
                                            obscureText:
                                            snap.hasData ? snap.data : true,
                                          );
                                        },
                                      )),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: InkWell(
                                      child: snap.hasData
                                          ? snap.data
                                          ? Image.asset(
                                        "assets/images/hidden_pass.png",
                                        width: 15,
                                        height: 15,
                                      )
                                          : Image.asset(
                                        "assets/images/show_pass.png",
                                        width: 15,
                                        height: 15,
                                      )
                                          : Image.asset(
                                        "assets/images/hidden_pass.png",
                                        width: 15,
                                        height: 15,
                                      ),
                                      onTap: () {
                                        snap.hasData
                                            ? personalDetailsBloc
                                            .setConfirmPasswordVisibility(
                                            !snap.data)
                                            : personalDetailsBloc
                                            .setConfirmPasswordVisibility(
                                            false);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            );
                          } else {
                            return Container(
                              margin: EdgeInsets.only(
                                  top: MediaQuery
                                      .of(context)
                                      .size
                                      .height *
                                      0.018),
                              child: TextField(
                                style: TextStyle(
                                  fontFamily: FontFamilies.POPPINS,
                                  fontSize:
                                  (MediaQuery
                                      .of(context)
                                      .size
                                      .height *
                                      0.02),
                                ),
                                focusNode: confirmPassNode,
                                cursorColor: AppColors.MAIN_COLOR,
                                keyboardType: TextInputType.text,
                                decoration: new InputDecoration(
                                    contentPadding: EdgeInsets.all(0),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColors.LIGHT_BLUE),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColors.MAIN_COLOR),
                                    ),
                                    labelText: 'Confirm Password',
                                    labelStyle: TextStyle(
                                        color: AppColors.labelColor,
                                        fontFamily: 'Poppins'),
                                    suffix: InkWell(
                                      child: snap.hasData
                                          ? snap.data
                                          ? Image.asset(
                                        "assets/images/hidden_pass.png",
                                        width: 15,
                                        height: 15,
                                      )
                                          : Image.asset(
                                        "assets/images/show_pass.png",
                                        width: 15,
                                        height: 15,
                                      )
                                          : Image.asset(
                                        "assets/images/hidden_pass.png",
                                        width: 15,
                                        height: 15,
                                      ),
                                      onTap: () {
                                        snap.hasData
                                            ? personalDetailsBloc
                                            .setConfirmPasswordVisibility(
                                            !snap.data)
                                            : personalDetailsBloc
                                            .setConfirmPasswordVisibility(
                                            false);
                                      },
                                    )),
                                obscureText: snap.hasData ? snap.data : true,
                                onChanged:
                                (personalDetailsBloc.changeConfirmPass),
                              ),
                            );
                          }
                        },
                      );
                    }
                  },
                );
              },
            ),
            StreamBuilder(
              stream: personalDetailsBloc.isPassMatching,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      padding: EdgeInsets.only(
                          top: MediaQuery
                              .of(context)
                              .size
                              .width * 0.01),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            "assets/images/error_icon.png",
                            width: 10,
                            height: 10,
                          ),
                          Container(
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width - 60,
                              padding: EdgeInsets.only(left: 8),
                              child: Text(
                                "  " + snapshot.data,
                                style: TextStyle(
                                    color: AppColors.ERROR,
                                    fontFamily: 'Poppins',
                                    fontSize: 10),
                              )),
                        ],
                      ));
                } else {
                  return Container();
                }
              },
            ),
          ],
        );
      },
    );
  }

  Container gender(BuildContext context) {
    return Container(
      margin:
          EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.005),
      child: Row(
        children: <Widget>[
          StreamBuilder(
            stream: personalDetailsBloc.male,
            builder: (context, snapshot) {
              return Container(
                margin: EdgeInsets.only(bottom: 3),
                width: MediaQuery.of(context).size.width / 5.3,
                height: 30,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      side: snapshot.data == true
                          ? BorderSide(color: AppColors.MAIN_COLOR)
                          : BorderSide(color: AppColors.LIGHT_GREY),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          bottomLeft: Radius.circular(20.0))),
                  color:
                      snapshot.data == true ? Color(0xffef8132) : Colors.white,
                  onPressed: () {
                    personalDetailsBloc.setGenderMale();
                  },
                  child: Text(
                    "Male",
                    style: TextStyle(
                      fontFamily: FontFamilies.POPPINS,
                      fontSize: (MediaQuery.of(context).size.height * 0.02) - 2,
                      color: snapshot.data == true
                          ? Colors.white
                          : AppColors.labelColor,
                    ),
                  ),
                ),
              );
            },
          ),
          StreamBuilder(
            stream: personalDetailsBloc.female,
            builder: (context, snapshot) {
              return Container(
                width: MediaQuery.of(context).size.width / 5.4,
                height: 30,
                margin: EdgeInsets.only(bottom: 3),
                child: RaisedButton(
                  padding: EdgeInsets.all(0),
                  shape: RoundedRectangleBorder(
                    side: snapshot.data == true
                        ? BorderSide(color: AppColors.MAIN_COLOR)
                        : BorderSide(color: AppColors.LIGHT_GREY),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0)),
                  ),
                  color:
                      snapshot.data == true ? Color(0xffef8132) : Colors.white,
                  onPressed: () {
                    personalDetailsBloc.setGenderFemale();
                  },
                  child: Text(
                    "Female",
                    style: TextStyle(
                      color: snapshot.data == true
                          ? Colors.white
                          : AppColors.labelColor,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Future<void> _showDialog(context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        FlutterStatusbarcolor.setStatusBarColor(AppColors.dialogStatusBar);

        Future.delayed(Duration(seconds: 3), () {
          if (personalDetailsBloc.getMessage() == "success") {
            print(personalDetailsBloc.getMessage());
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return VehicleDetailsScreen();
              }),
            );
          } else if (personalDetailsBloc.getMessage() ==
              "The captain.email has already been taken.") {
            print(personalDetailsBloc.getMessage());

            Navigator.pop(context);
          } else {
            Navigator.pop(context);
            print(personalDetailsBloc.getMessage());

            //     Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) {
            //     return VehicleDetailsScreen();
            //   }),
            // );
          }
        });
        return LoadingDialogWidget();
      },
    ).then((value) => FlutterStatusbarcolor.setStatusBarColor(Colors.white));
  }
}
