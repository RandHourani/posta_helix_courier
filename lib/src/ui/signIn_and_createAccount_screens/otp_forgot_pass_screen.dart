import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'file:///C:/Users/r.horani/AndroidStudioProjects/helix_courier_project/helix_courier_project/lib/src/constants/application_colors_value.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:flutter/services.dart';
import 'package:posta_courier/src/blocs/signIn_and_createAccount_blocs/forgot_pass_bloc.dart';
import 'package:posta_courier/src/constants/fonts_size.dart';
import 'package:posta_courier/src/ui/widgets/numeric_keyboard_widget.dart';

import 'new_pass_screen.dart';

class OtpForgotPassScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.white);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
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
                        Navigator.pop(context);
                        },
                        child: Text(
                          " BACK",
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
                            fontSize: (MediaQuery.of(context).size.width * 0.04) +
                                FontSize.HEADING_FONT,
                            fontWeight: FontWeight.w700),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Text("Enter the 6-digit code sent to you on",
                          style: TextStyle(
                            color: AppColors.TITLE_TEXT_COLOR,
                            fontFamily: FontFamilies.POPPINS,
                            fontSize: (MediaQuery.of(context).size.height * 0.02),
                          ),),
                      ),
                      Text(forgotPassBloc.getEmail().toString(),  style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.TITLE_TEXT_COLOR,
                        fontFamily: FontFamilies.POPPINS,
                        fontSize: (MediaQuery.of(context).size.height * 0.02),
                      ),),
                      Container(
                          margin: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width < 450
                                ? MediaQuery.of(context).size.width * 0.01
                                : MediaQuery.of(context).size.width * 0.07,
                            right:MediaQuery.of(context).size.width < 450
                                ? MediaQuery.of(context).size.width * 0.01
                                : MediaQuery.of(context).size.width * 0.07,
                            top: MediaQuery.of(context).size.height * 0.04,
                            bottom: MediaQuery.of(context).size.height * 0.003,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width <
                                    450
                                    ? MediaQuery.of(context).size.width /
                                    7.5
                                    : MediaQuery.of(context).size.width /
                                    8,
                                height: MediaQuery.of(context).size.width  <
                                    450
                                    ? MediaQuery.of(context).size.width  /
                                    9
                                    : MediaQuery.of(context).size.width  /
                                    9.9,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                                  border: Border.all(
                                    color:  AppColors.LIGHT_GREY,

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
                                child: Text(" "),
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width <
                                    450
                                    ? MediaQuery.of(context).size.width /
                                    7.5
                                    : MediaQuery.of(context).size.width /
                                    8,
                                height: MediaQuery.of(context).size.width  <
                                    450
                                    ? MediaQuery.of(context).size.width  /
                                    9
                                    : MediaQuery.of(context).size.width  /
                                    9.9,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                                  border: Border.all(
                                    color:  AppColors.LIGHT_GREY,

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
                                child: Text(" "),
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width <
                                    450
                                    ? MediaQuery.of(context).size.width /
                                    7.5
                                    : MediaQuery.of(context).size.width /
                                    8,
                                height: MediaQuery.of(context).size.width  <
                                    450
                                    ? MediaQuery.of(context).size.width  /
                                    9
                                    : MediaQuery.of(context).size.width  /
                                    9.9,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                                  border: Border.all(
                                    color:  AppColors.LIGHT_GREY,

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
                                child: Text(" "),
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width <
                                    450
                                    ? MediaQuery.of(context).size.width /
                                    7.5
                                    : MediaQuery.of(context).size.width /
                                    8,
                                height: MediaQuery.of(context).size.width  <
                                    450
                                    ? MediaQuery.of(context).size.width  /
                                    9
                                    : MediaQuery.of(context).size.width  /
                                    9.9,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                                  border: Border.all(
                                    color:  AppColors.LIGHT_GREY,

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
                                child: Text(" "),
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width <
                                    450
                                    ? MediaQuery.of(context).size.width /
                                    7.5
                                    : MediaQuery.of(context).size.width /
                                    8,
                                height: MediaQuery.of(context).size.width  <
                                    450
                                    ? MediaQuery.of(context).size.width  /
                                    9
                                    : MediaQuery.of(context).size.width  /
                                    9.9,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                                  border: Border.all(
                                    color:  AppColors.LIGHT_GREY,

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
                                child: Text(" "),
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width <
                                    450
                                    ? MediaQuery.of(context).size.width /
                                    7.5
                                    : MediaQuery.of(context).size.width /
                                    8,
                                height: MediaQuery.of(context).size.width  <
                                    450
                                    ? MediaQuery.of(context).size.width  /
                                    9
                                    : MediaQuery.of(context).size.width  /
                                    9.9,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                                  border: Border.all(
                                    color:  AppColors.LIGHT_GREY,

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
                                child: Text(" "),
                              ),
                            ],
                          )),
                      Container(
                        padding: EdgeInsets.only(bottom: 5),
                        margin: EdgeInsets.only(left: 12,top: 8),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                                color: Color(0xffef8132), width: 1.0),
                          ),
                        ),
                        child: InkWell(
                          child: Text(
                            "Resend Code",
                            style: TextStyle(
                              fontFamily: FontFamilies.POPPINS,
                              fontSize:
                              (MediaQuery.of(context).size.height * 0.02),
                              color: AppColors.MAIN_COLOR,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 30),
                  padding: EdgeInsets.only(top: 20, bottom: 5),
                  width: MediaQuery.of(context).size.width,
                  color: AppColors.KEYBOARD_BACKGROUND,
                  child: Column(
                    children: <Widget>[
                      NumericKeyboardWidget(),
                      Container(
                        margin: EdgeInsets.only(
                          top: 20,
                          bottom: 30,
                          left: 20,
                          right: 20,
                        ),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.width / 7,
                        child: ButtonTheme(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          buttonColor: Colors.white,
                          child: RaisedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) {
                                  return NewPassScreen();
                                }),
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "Continue ",
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_forward,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Image.asset("assets/images/home_indicator.png")
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
