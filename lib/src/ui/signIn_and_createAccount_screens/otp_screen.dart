import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:posta_courier/models/registered_captain_model.dart';
import 'package:posta_courier/src/blocs/signIn_and_createAccount_blocs/get_captain_data_bloc.dart';
import 'package:posta_courier/src/constants/fonts_size.dart';

import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:flutter/services.dart';
import 'package:posta_courier/src/blocs/signIn_and_createAccount_blocs/otp_signIn_bloc.dart';
import 'package:posta_courier/src/blocs/signIn_and_createAccount_blocs/sign_up_bloc.dart';
import 'package:posta_courier/src/constants/application_colors_value.dart';
import 'package:posta_courier/src/ui/signIn_and_createAccount_screens/personal_details_screen.dart';
import 'package:posta_courier/src/ui/widgets/dialog_loading.dart';
import 'package:posta_courier/src/ui/widgets/numeric_keyboard_widget.dart';
import 'package:posta_courier/src/utils/display_size_screen.dart';
import 'completed_info_screen.dart';
import 'incompleted_info_screen.dart';
import 'new_pass_screen.dart';

class OtpScreen extends StatelessWidget {
  final screen;
  final phoneNumber;

  OtpScreen({this.screen, this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.white);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    print(MediaQuery.of(context).size.width);
    otpBloc.resetCode();
    phoneBloc.internetChecked();

    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.width / 6,
                        left: MediaQuery.of(context).size.width * 0.05,
                      ),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.arrow_back,
                            color: AppColors.TITLE_TEXT_COLOR,
                            size: (MediaQuery.of(context).size.width * 0.04) +
                                FontSize.HEADING_FONT -
                                5,
                          ),
                          InkWell(
                            onTap: () {
                              FlutterStatusbarcolor.setStatusBarColor(
                                  Colors.white);
                              Navigator.pop(context);
                            },
                            child: Text(
                              " BACK",
                              style: TextStyle(
                                  color: AppColors.TITLE_TEXT_COLOR,
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
                    Container(
                      margin: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.05,
                          right: MediaQuery.of(context).size.width * 0.05,
                          top: MediaQuery.of(context).size.height * 0.04),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Enter Your OTP Code",
                            style: TextStyle(
                                color: AppColors.TITLE_TEXT_COLOR,
                                fontFamily: FontFamilies.POPPINS,
                                fontSize:
                                    (MediaQuery.of(context).size.width * 0.04) +
                                        FontSize.HEADING_FONT,
                                fontWeight: FontWeight.w700),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 5),
                            child: Text(
                              "Enter the 6-digit code sent to you on",
                              style: TextStyle(
                                color: AppColors.TITLE_TEXT_COLOR,
                                fontFamily: FontFamilies.POPPINS,
                                fontSize:
                                    (MediaQuery.of(context).size.height * 0.02),
                              ),
                            ),
                          ),
                          Text(
                            "+" + phoneNumber.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.TITLE_TEXT_COLOR,
                              fontFamily: FontFamilies.POPPINS,
                              fontSize:
                                  (MediaQuery.of(context).size.height * 0.02),
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(
                                left: DisplayScreen.displayWidth(context) < 450
                                    ? DisplayScreen.displayWidth(context) * 0.01
                                    : DisplayScreen.displayWidth(context) *
                                        0.07,
                                right: DisplayScreen.displayWidth(context) < 450
                                    ? DisplayScreen.displayWidth(context) * 0.01
                                    : DisplayScreen.displayWidth(context) *
                                        0.07,
                                top: MediaQuery.of(context).size.height * 0.04,
                                bottom:
                                    MediaQuery.of(context).size.height * 0.003,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  StreamBuilder(
                                    stream: otpBloc.codeValidation,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return Container(
                                          alignment: Alignment.center,
                                          width: DisplayScreen.displayWidth(
                                                      context) <
                                                  450
                                              ? DisplayScreen.displayWidth(
                                                      context) /
                                                  7.5
                                              : DisplayScreen.displayWidth(
                                                      context) /
                                                  8,
                                          height: DisplayScreen.displayWidth(
                                                      context) <
                                                  450
                                              ? DisplayScreen.displayWidth(
                                                      context) /
                                                  9
                                              : DisplayScreen.displayWidth(
                                                      context) /
                                                  9.9,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(12)),
                                            border: Border.all(
                                              color: snapshot.data
                                                  ? AppColors.LIGHT_GREY
                                                  : AppColors.ERROR,
                                              width: snapshot.data ? 0.7 : 1.5,
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: AppColors
                                                    .completedInfoBoxUnderLine,
                                                spreadRadius: 2,
                                                blurRadius: 2,
                                                offset: Offset(1, 1.5),
                                              ),
                                            ],
                                          ),
                                          child: StreamBuilder(
                                              stream: otpBloc.firstDigit,
                                              builder: (context, snapshot) {
                                                otpBloc.firstAdd();
                                                if (snapshot.hasData) {
                                                  return Text(
                                                    snapshot.data == null
                                                        ? " "
                                                        : snapshot.data,
                                                    style: new TextStyle(
                                                      fontFamily:
                                                          FontFamilies.POPPINS,
                                                      fontSize: (MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              0.02) +
                                                          4,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color:
                                                          AppColors.LIGHT_GREY,
                                                    ),
                                                  );
                                                } else {
                                                  return Text(" ");
                                                }
                                              }),
                                        );
                                      } else {
                                        return Container(
                                          alignment: Alignment.center,
                                          width: DisplayScreen.displayWidth(
                                                      context) <
                                                  450
                                              ? DisplayScreen.displayWidth(
                                                      context) /
                                                  7.5
                                              : DisplayScreen.displayWidth(
                                                      context) /
                                                  8,
                                          height: DisplayScreen.displayWidth(
                                                      context) <
                                                  450
                                              ? DisplayScreen.displayWidth(
                                                      context) /
                                                  9
                                              : DisplayScreen.displayWidth(
                                                      context) /
                                                  9.9,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(12)),
                                            border: Border.all(
                                              color: AppColors.LIGHT_GREY,
                                              width: 0.7,
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: AppColors
                                                    .completedInfoBoxUnderLine,
                                                spreadRadius: 2,
                                                blurRadius: 2,
                                                offset: Offset(1, 1.5),
                                              ),
                                            ],
                                          ),
                                          child: StreamBuilder(
                                              stream: otpBloc.firstDigit,
                                              builder: (context, snapshot) {
                                                otpBloc.firstAdd();
                                                if (snapshot.hasData) {
                                                  return Text(
                                                    snapshot.data == null
                                                        ? " "
                                                        : snapshot.data,
                                                    style: new TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: AppColors
                                                            .LIGHT_GREY,
                                                        fontFamily: 'Poppins'),
                                                  );
                                                } else {
                                                  return Text("");
                                                }
                                              }),
                                        );
                                      }
                                    },
                                  ),
                                  StreamBuilder(
                                      stream: otpBloc.codeValidation,
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return Container(
                                            width: DisplayScreen.displayWidth(
                                                        context) <
                                                    450
                                                ? DisplayScreen.displayWidth(
                                                        context) /
                                                    7.5
                                                : DisplayScreen.displayWidth(
                                                        context) /
                                                    8,
                                            height: DisplayScreen.displayWidth(
                                                        context) <
                                                    450
                                                ? DisplayScreen.displayWidth(
                                                        context) /
                                                    9
                                                : DisplayScreen.displayWidth(
                                                        context) /
                                                    9.9,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(12)),
                                              border: Border.all(
                                                color: snapshot.data
                                                    ? AppColors.LIGHT_GREY
                                                    : AppColors.ERROR,
                                                width:
                                                    snapshot.data ? 0.7 : 1.5,
                                              ),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: AppColors
                                                      .completedInfoBoxUnderLine,
                                                  spreadRadius: 2,
                                                  blurRadius: 2,
                                                  offset: Offset(1, 1.5),
                                                ),
                                              ],
                                            ),
                                            child: StreamBuilder(
                                                stream: otpBloc.secondDigit,
                                                builder: (context, snapshot) {
                                                  otpBloc.secondAdd();
                                                  if (snapshot.hasData) {
                                                    return Text(
                                                      snapshot.data == null
                                                          ? " "
                                                          : snapshot.data,
                                                      style: new TextStyle(
                                                        fontFamily: FontFamilies
                                                            .POPPINS,
                                                        fontSize: (MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.02) +
                                                            4,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: AppColors
                                                            .LIGHT_GREY,
                                                      ),
                                                    );
                                                  } else {
                                                    return Text("");
                                                  }
                                                }),
                                          );
                                        } else {
                                          return Container(
                                            width: DisplayScreen.displayWidth(
                                                        context) <
                                                    450
                                                ? DisplayScreen.displayWidth(
                                                        context) /
                                                    7.5
                                                : DisplayScreen.displayWidth(
                                                        context) /
                                                    8,
                                            height: DisplayScreen.displayWidth(
                                                        context) <
                                                    450
                                                ? DisplayScreen.displayWidth(
                                                        context) /
                                                    9
                                                : DisplayScreen.displayWidth(
                                                        context) /
                                                    9.9,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(12)),
                                              border: Border.all(
                                                color: AppColors.LIGHT_GREY,
                                                width: 0.7,
                                              ),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: AppColors
                                                      .completedInfoBoxUnderLine,
                                                  spreadRadius: 2,
                                                  blurRadius: 2,
                                                  offset: Offset(1, 1.5),
                                                ),
                                              ],
                                            ),
                                            child: StreamBuilder(
                                                stream: otpBloc.secondDigit,
                                                builder: (context, snapshot) {
                                                  otpBloc.secondAdd();
                                                  if (snapshot.hasData) {
                                                    return Text(
                                                      snapshot.data == null
                                                          ? " "
                                                          : snapshot.data,
                                                      style: new TextStyle(
                                                        fontFamily: FontFamilies
                                                            .POPPINS,
                                                        fontSize: (MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.02) +
                                                            4,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: AppColors
                                                            .LIGHT_GREY,
                                                      ),
                                                    );
                                                  } else {
                                                    return Text("");
                                                  }
                                                }),
                                          );
                                        }
                                      }),
                                  StreamBuilder(
                                      stream: otpBloc.codeValidation,
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return Container(
                                            width: DisplayScreen.displayWidth(
                                                        context) <
                                                    450
                                                ? DisplayScreen.displayWidth(
                                                        context) /
                                                    7.5
                                                : DisplayScreen.displayWidth(
                                                        context) /
                                                    8,
                                            height: DisplayScreen.displayWidth(
                                                        context) <
                                                    450
                                                ? DisplayScreen.displayWidth(
                                                        context) /
                                                    9
                                                : DisplayScreen.displayWidth(
                                                        context) /
                                                    9.9,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(12)),
                                              border: Border.all(
                                                color: snapshot.data
                                                    ? AppColors.LIGHT_GREY
                                                    : AppColors.ERROR,
                                                width:
                                                    snapshot.data ? 0.7 : 1.5,
                                              ),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: AppColors
                                                      .completedInfoBoxUnderLine,
                                                  spreadRadius: 2,
                                                  blurRadius: 2,
                                                  offset: Offset(1, 1.5),
                                                ),
                                              ],
                                            ),
                                            child: StreamBuilder(
                                                stream: otpBloc.thirdDigit,
                                                builder: (context, snapshot) {
                                                  otpBloc.thirdAdd();
                                                  if (snapshot.hasData) {
                                                    return Text(
                                                      snapshot.data == null
                                                          ? " "
                                                          : snapshot.data,
                                                      style: new TextStyle(
                                                        fontFamily: FontFamilies
                                                            .POPPINS,
                                                        fontSize: (MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.02) +
                                                            4,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: AppColors
                                                            .LIGHT_GREY,
                                                      ),
                                                    );
                                                  } else {
                                                    return Text("");
                                                  }
                                                }),
                                          );
                                        } else {
                                          return Container(
                                            width: DisplayScreen.displayWidth(
                                                        context) <
                                                    450
                                                ? DisplayScreen.displayWidth(
                                                        context) /
                                                    7.5
                                                : DisplayScreen.displayWidth(
                                                        context) /
                                                    8,
                                            height: DisplayScreen.displayWidth(
                                                        context) <
                                                    450
                                                ? DisplayScreen.displayWidth(
                                                        context) /
                                                    9
                                                : DisplayScreen.displayWidth(
                                                        context) /
                                                    9.9,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(12)),
                                              border: Border.all(
                                                color: AppColors.LIGHT_GREY,
                                                width: 0.7,
                                              ),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: AppColors
                                                      .completedInfoBoxUnderLine,
                                                  spreadRadius: 2,
                                                  blurRadius: 2,
                                                  offset: Offset(1, 1.5),
                                                ),
                                              ],
                                            ),
                                            child: StreamBuilder(
                                                stream: otpBloc.thirdDigit,
                                                builder: (context, snapshot) {
                                                  otpBloc.thirdAdd();
                                                  if (snapshot.hasData) {
                                                    return Text(
                                                      snapshot.data == null
                                                          ? " "
                                                          : snapshot.data,
                                                      style: new TextStyle(
                                                        fontFamily: FontFamilies
                                                            .POPPINS,
                                                        fontSize: (MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.02) +
                                                            4,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: AppColors
                                                            .LIGHT_GREY,
                                                      ),
                                                    );
                                                  } else {
                                                    return Text("");
                                                  }
                                                }),
                                          );
                                        }
                                      }),
                                  StreamBuilder(
                                      stream: otpBloc.codeValidation,
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return Container(
                                            width: DisplayScreen.displayWidth(
                                                        context) <
                                                    450
                                                ? DisplayScreen.displayWidth(
                                                        context) /
                                                    7.5
                                                : DisplayScreen.displayWidth(
                                                        context) /
                                                    8,
                                            height: DisplayScreen.displayWidth(
                                                        context) <
                                                    450
                                                ? DisplayScreen.displayWidth(
                                                        context) /
                                                    9
                                                : DisplayScreen.displayWidth(
                                                        context) /
                                                    9.9,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(12)),
                                              border: Border.all(
                                                color: snapshot.data
                                                    ? AppColors.LIGHT_GREY
                                                    : AppColors.ERROR,
                                                width:
                                                    snapshot.data ? 0.7 : 1.5,
                                              ),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: AppColors
                                                      .completedInfoBoxUnderLine,
                                                  spreadRadius: 2,
                                                  blurRadius: 2,
                                                  offset: Offset(1, 1.5),
                                                ),
                                              ],
                                            ),
                                            child: StreamBuilder(
                                                stream: otpBloc.forthDigit,
                                                builder: (context, snapshot) {
                                                  otpBloc.fourthAdd();
                                                  if (snapshot.hasData) {
                                                    return Text(
                                                      snapshot.data == null
                                                          ? " "
                                                          : snapshot.data,
                                                      style: new TextStyle(
                                                        fontFamily: FontFamilies
                                                            .POPPINS,
                                                        fontSize: (MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.02) +
                                                            4,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: AppColors
                                                            .LIGHT_GREY,
                                                      ),
                                                    );
                                                  } else {
                                                    return Text("");
                                                  }
                                                }),
                                          );
                                        } else {
                                          return Container(
                                            width: DisplayScreen.displayWidth(
                                                        context) <
                                                    450
                                                ? DisplayScreen.displayWidth(
                                                        context) /
                                                    7.5
                                                : DisplayScreen.displayWidth(
                                                        context) /
                                                    8,
                                            height: DisplayScreen.displayWidth(
                                                        context) <
                                                    450
                                                ? DisplayScreen.displayWidth(
                                                        context) /
                                                    9
                                                : DisplayScreen.displayWidth(
                                                        context) /
                                                    9.9,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(12)),
                                              border: Border.all(
                                                color: AppColors.LIGHT_GREY,
                                                width: 0.7,
                                              ),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: AppColors
                                                      .completedInfoBoxUnderLine,
                                                  spreadRadius: 2,
                                                  blurRadius: 2,
                                                  offset: Offset(1, 1.5),
                                                ),
                                              ],
                                            ),
                                            child: StreamBuilder(
                                                stream: otpBloc.forthDigit,
                                                builder: (context, snapshot) {
                                                  otpBloc.fourthAdd();
                                                  if (snapshot.hasData) {
                                                    return Text(
                                                      snapshot.data == null
                                                          ? " "
                                                          : snapshot.data,
                                                      style: new TextStyle(
                                                        fontFamily: FontFamilies
                                                            .POPPINS,
                                                        fontSize: (MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.02) +
                                                            4,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: AppColors
                                                            .LIGHT_GREY,
                                                      ),
                                                    );
                                                  } else {
                                                    return Text("");
                                                  }
                                                }),
                                          );
                                        }
                                      }),
                                  StreamBuilder(
                                      stream: otpBloc.codeValidation,
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return Container(
                                            width: DisplayScreen.displayWidth(
                                                        context) <
                                                    450
                                                ? DisplayScreen.displayWidth(
                                                        context) /
                                                    7.5
                                                : DisplayScreen.displayWidth(
                                                        context) /
                                                    8,
                                            height: DisplayScreen.displayWidth(
                                                        context) <
                                                    450
                                                ? DisplayScreen.displayWidth(
                                                        context) /
                                                    9
                                                : DisplayScreen.displayWidth(
                                                        context) /
                                                    9.9,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(12)),
                                              border: Border.all(
                                                color: snapshot.data
                                                    ? AppColors.LIGHT_GREY
                                                    : AppColors.ERROR,
                                                width:
                                                    snapshot.data ? 0.7 : 1.5,
                                              ),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: AppColors
                                                      .completedInfoBoxUnderLine,
                                                  spreadRadius: 2,
                                                  blurRadius: 2,
                                                  offset: Offset(1, 1.5),
                                                ),
                                              ],
                                            ),
                                            child: StreamBuilder(
                                                stream: otpBloc.fifthDigit,
                                                builder: (context, snapshot) {
                                                  otpBloc.fifthAdd();
                                                  if (snapshot.hasData) {
                                                    return Text(
                                                      snapshot.data == null
                                                          ? " "
                                                          : snapshot.data,
                                                      style: new TextStyle(
                                                        fontFamily: FontFamilies
                                                            .POPPINS,
                                                        fontSize: (MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.02) +
                                                            4,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: AppColors
                                                            .LIGHT_GREY,
                                                      ),
                                                    );
                                                  } else {
                                                    return Text("");
                                                  }
                                                }),
                                          );
                                        } else {
                                          return Container(
                                            width: DisplayScreen.displayWidth(
                                                        context) <
                                                    450
                                                ? DisplayScreen.displayWidth(
                                                        context) /
                                                    7.5
                                                : DisplayScreen.displayWidth(
                                                        context) /
                                                    8,
                                            height: DisplayScreen.displayWidth(
                                                        context) <
                                                    450
                                                ? DisplayScreen.displayWidth(
                                                        context) /
                                                    9
                                                : DisplayScreen.displayWidth(
                                                        context) /
                                                    9.9,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(12)),
                                              border: Border.all(
                                                color: AppColors.LIGHT_GREY,
                                                width: 0.7,
                                              ),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: AppColors
                                                      .completedInfoBoxUnderLine,
                                                  spreadRadius: 2,
                                                  blurRadius: 2,
                                                  offset: Offset(1, 1.5),
                                                ),
                                              ],
                                            ),
                                            child: StreamBuilder(
                                                stream: otpBloc.fifthDigit,
                                                builder: (context, snapshot) {
                                                  otpBloc.fifthAdd();
                                                  if (snapshot.hasData) {
                                                    return Text(
                                                      snapshot.data == null
                                                          ? " "
                                                          : snapshot.data,
                                                      style: new TextStyle(
                                                        fontFamily: FontFamilies
                                                            .POPPINS,
                                                        fontSize: (MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.02) +
                                                            4,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: AppColors
                                                            .LIGHT_GREY,
                                                      ),
                                                    );
                                                  } else {
                                                    return Text("");
                                                  }
                                                }),
                                          );
                                        }
                                      }),
                                  StreamBuilder(
                                      stream: otpBloc.codeValidation,
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return Container(
                                            width: DisplayScreen.displayWidth(
                                                        context) <
                                                    450
                                                ? DisplayScreen.displayWidth(
                                                        context) /
                                                    7.5
                                                : DisplayScreen.displayWidth(
                                                        context) /
                                                    8,
                                            height: DisplayScreen.displayWidth(
                                                        context) <
                                                    450
                                                ? DisplayScreen.displayWidth(
                                                        context) /
                                                    9
                                                : DisplayScreen.displayWidth(
                                                        context) /
                                                    9.9,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(12)),
                                              border: Border.all(
                                                color: snapshot.data
                                                    ? AppColors.LIGHT_GREY
                                                    : AppColors.ERROR,
                                                width:
                                                    snapshot.data ? 0.7 : 1.5,
                                              ),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: AppColors
                                                      .completedInfoBoxUnderLine,
                                                  spreadRadius: 2,
                                                  blurRadius: 2,
                                                  offset: Offset(1, 1.5),
                                                ),
                                              ],
                                            ),
                                            child: StreamBuilder(
                                                stream: otpBloc.sixthDigit,
                                                builder: (context, snapshot) {
                                                  otpBloc.sixthAdd();
                                                  if (snapshot.hasData) {
                                                    return Text(
                                                      snapshot.data == null
                                                          ? " "
                                                          : snapshot.data,
                                                      style: new TextStyle(
                                                        fontFamily: FontFamilies
                                                            .POPPINS,
                                                        fontSize: (MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.02) +
                                                            4,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: AppColors
                                                            .LIGHT_GREY,
                                                      ),
                                                    );
                                                  } else {
                                                    return Text("");
                                                  }
                                                }),
                                          );
                                        } else {
                                          return Container(
                                            width: DisplayScreen.displayWidth(
                                                        context) <
                                                    450
                                                ? DisplayScreen.displayWidth(
                                                        context) /
                                                    7.5
                                                : DisplayScreen.displayWidth(
                                                        context) /
                                                    8,
                                            height: DisplayScreen.displayWidth(
                                                        context) <
                                                    450
                                                ? DisplayScreen.displayWidth(
                                                        context) /
                                                    9
                                                : DisplayScreen.displayWidth(
                                                        context) /
                                                    9.9,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(12)),
                                              border: Border.all(
                                                color: AppColors.LIGHT_GREY,
                                                width: 0.7,
                                              ),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: AppColors
                                                      .completedInfoBoxUnderLine,
                                                  spreadRadius: 2,
                                                  blurRadius: 2,
                                                  offset: Offset(1, 1.5),
                                                ),
                                              ],
                                            ),
                                            child: StreamBuilder(
                                                stream: otpBloc.sixthDigit,
                                                builder: (context, snapshot) {
                                                  otpBloc.sixthAdd();
                                                  if (snapshot.hasData) {
                                                    return Text(
                                                      snapshot.data == null
                                                          ? " "
                                                          : snapshot.data,
                                                      style: new TextStyle(
                                                        fontFamily: FontFamilies
                                                            .POPPINS,
                                                        fontSize: (MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.02) +
                                                            4,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: AppColors
                                                            .LIGHT_GREY,
                                                      ),
                                                    );
                                                  } else {
                                                    return Text("");
                                                  }
                                                }),
                                          );
                                        }
                                      }),
                                ],
                              )),
                          Container(
                            margin: EdgeInsets.only(
                              left: DisplayScreen.displayWidth(context) < 450
                                  ? DisplayScreen.displayWidth(context) * 0.01
                                  : DisplayScreen.displayWidth(context) * 0.07,
                              right: DisplayScreen.displayWidth(context) < 450
                                  ? DisplayScreen.displayWidth(context) * 0.01
                                  : DisplayScreen.displayWidth(context) * 0.07,
                            ),
                            child: StreamBuilder(
                              stream: otpBloc.codeValidation,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return !snapshot.data
                                      ? Row(
                                          children: [
                                            Image.asset(
                                              "assets/images/error_icon.png",
                                              width: 13,
                                              height: 13,
                                            ),
                                            Text(
                                              " Invalid OTP code",
                                              style: TextStyle(
                                                  color: AppColors.ERROR,
                                                  fontFamily:
                                                      FontFamilies.POPPINS,
                                                  fontSize:
                                                      (MediaQuery.of(context)
                                                              .size
                                                              .height *
                                                          0.02)),
                                            )
                                          ],
                                        )
                                      : Text("");
                                } else {
                                  return Text("");
                                }
                              },
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                left: 4,
                                top: MediaQuery.of(context).size.height * 0.01,
                                bottom:
                                    MediaQuery.of(context).size.height * 0.045),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                    color: AppColors.MAIN_COLOR, width: 1.0),
                              ),
                            ),
                            child: InkWell(
                              child: Text(
                                "Resend Code",
                                style: TextStyle(
                                  fontFamily: FontFamilies.POPPINS,
                                  fontSize:
                                      (MediaQuery.of(context).size.height *
                                          0.02),
                                  color: AppColors.MAIN_COLOR,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 50),
                    width: MediaQuery.of(context).size.width,
                    color: AppColors.KEYBOARD_BACKGROUND,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        NumericKeyboardWidget(),
                        Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.completedInfoBoxUnderLine,
                                spreadRadius: 2,
                                blurRadius: 2,
                                offset: Offset(
                                    0.5, 1), // changes position of shadow
                              ),
                            ],
                          ),
                          margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.width * 0.07,
                            bottom: MediaQuery.of(context).size.width * 0.012,
                            left: MediaQuery.of(context).size.width * 0.06,
                            right: MediaQuery.of(context).size.width * 0.06,
                          ),
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.width / 7,
                          child: ButtonTheme(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            buttonColor: Colors.white,
                            child: StreamBuilder(
                              stream: otpBloc.sixthDigit,
                              builder: (context, snap) {
                                if (snap.hasData) {
                                  return RaisedButton(
                                    onPressed: () {
                                      otpBloc.getVerify(phoneNumber);

                                      FlutterStatusbarcolor.setStatusBarColor(
                                          AppColors.dialogStatusBar);
                                      _showMyDialog(context);
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: MediaQuery
                                                  .of(context)
                                                  .size
                                                  .width *
                                                  0.04),
                                          child: Text(
                                            "Continue",
                                            style: TextStyle(
                                              fontFamily: FontFamilies.POPPINS,
                                              fontSize: (MediaQuery
                                                  .of(context)
                                                  .size
                                                  .width *
                                                  0.008) +
                                                  FontSize.BUTTON_FONT_L,
                                              color: AppColors.TITLE_TEXT_COLOR,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              right: MediaQuery
                                                  .of(context)
                                                  .size
                                                  .width *
                                                  0.04),
                                          child: Icon(
                                            Icons.arrow_forward,
                                            color: AppColors.TITLE_TEXT_COLOR,
                                            size: (MediaQuery
                                                .of(context)
                                                .size
                                                .width *
                                                0.008) +
                                                18,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                } else {
                                  return RaisedButton(
                                    onPressed: () {},
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: MediaQuery
                                                  .of(context)
                                                  .size
                                                  .width *
                                                  0.04),
                                          child: Text(
                                            "Continue",
                                            style: TextStyle(
                                              fontFamily: FontFamilies.POPPINS,
                                              fontSize: (MediaQuery
                                                  .of(context)
                                                  .size
                                                  .width *
                                                  0.008) +
                                                  FontSize.BUTTON_FONT_L,
                                              color: AppColors.LIGHT_GREY,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              right: MediaQuery
                                                  .of(context)
                                                  .size
                                                  .width *
                                                  0.04),
                                          child: Icon(
                                            Icons.arrow_forward,
                                            color: AppColors.LIGHT_GREY,
                                            size: (MediaQuery
                                                .of(context)
                                                .size
                                                .width *
                                                0.008) +
                                                18,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: AppColors.KEYBOARD_BACKGROUND,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 6),
                      child: Image.asset("assets/images/home_indicator.png"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }

  Future<void> _showMyDialog(context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        Future.delayed(Duration(seconds: 5), () {
          if (otpBloc.checkCodeValidation()) {
            checkCaptainDataBloc.checkUserAuth();

            FlutterStatusbarcolor.setStatusBarColor(Colors.white);
            switch (screen) {
              case "SIGN_UP":
                {
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return PersonalDetailsScreen();
                    }),
                  );
                }
                break;

              case "FORGOT_PASS":
                {
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return NewPassScreen();
                    }),
                  );
                }
                break;
              default:
                {}
            }
          } else {
            FlutterStatusbarcolor.setStatusBarColor(Colors.white);
            Navigator.of(context).pop(true);
            otpBloc.setValidation(false);
          }
        });
        return LoadingDialogWidget();
      },
    );
  }
}
