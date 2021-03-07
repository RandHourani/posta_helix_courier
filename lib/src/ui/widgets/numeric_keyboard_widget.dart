import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:posta_courier/src/blocs/home_blocs/payment_bloc.dart';
import 'package:posta_courier/src/blocs/signIn_and_createAccount_blocs/otp_signIn_bloc.dart';
import 'package:posta_courier/src/constants/fonts_size.dart';
import 'package:posta_courier/src/utils/display_size_screen.dart';


class NumericKeyboardWidget extends StatelessWidget {
  String screen;
  NumericKeyboardWidget({this.screen});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 20,
        right: 20,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width / 3.7,
                  child: ButtonTheme(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    buttonColor: Colors.white,
                    child: RaisedButton(
                      onPressed: () {
                        screen=="PAYMENT"?paymentBloc.add("1")
                       : otpBloc.add("1");
                      },
                      child: Container(
                          padding: EdgeInsets.only(
                              top: DisplayScreen.displayWidth(context) * 0.005,
                              bottom:
                                  DisplayScreen.displayWidth(context) * 0.005,
                              right: DisplayScreen.displayWidth(context) * 0.01,
                              left: DisplayScreen.displayWidth(context) * 0.01),
                          child: Column(
                            children: <Widget>[
                              Text(
                                "1",
                                style: TextStyle(
                                    fontFamily: FontFamilies.POPPINS,
                                    fontSize:
                                        (MediaQuery.of(context).size.height *
                                            0.023)),
                              ),
                              Text(
                                "000",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: FontFamilies.POPPINS,
                                    fontSize:
                                        (MediaQuery.of(context).size.height *
                                            0.015),
                                    letterSpacing: 2.0),
                              ),
                            ],
                          )),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 3.7,
                  child: ButtonTheme(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    buttonColor: Colors.white,
                    child: RaisedButton(
                      onPressed: () {
                        screen=="PAYMENT"?paymentBloc.add("2")
                            : otpBloc.add("2");
                      },
                      child: Container(
                          padding: EdgeInsets.only(
                              top: DisplayScreen.displayWidth(context) * 0.005,
                              bottom:
                                  DisplayScreen.displayWidth(context) * 0.005,
                              right: DisplayScreen.displayWidth(context) * 0.01,
                              left: DisplayScreen.displayWidth(context) * 0.01),
                          child: Column(
                            children: <Widget>[
                              Text(
                                "2",
                                style: TextStyle(
                                    fontFamily: FontFamilies.POPPINS,
                                    fontSize:
                                        (MediaQuery.of(context).size.height *
                                            0.023)),
                              ),
                              Text(
                                "ABC",
                                style: TextStyle(
                                    fontFamily: FontFamilies.POPPINS,
                                    fontSize:
                                        (MediaQuery.of(context).size.height *
                                            0.015),
                                    letterSpacing: 2.0),
                              ),
                            ],
                          )),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 3.7,
                  child: ButtonTheme(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    buttonColor: Colors.white,
                    child: RaisedButton(
                      onPressed: () {
                        screen=="PAYMENT"?paymentBloc.add("3")
                            : otpBloc.add("3");
                      },
                      child: Container(
                          padding: EdgeInsets.only(
                              top: DisplayScreen.displayWidth(context) * 0.005,
                              bottom:
                                  DisplayScreen.displayWidth(context) * 0.005,
                              right: DisplayScreen.displayWidth(context) * 0.01,
                              left: DisplayScreen.displayWidth(context) * 0.01),
                          child: Column(
                            children: <Widget>[
                              Text(
                                "3",
                                style: TextStyle(
                                    fontFamily: FontFamilies.POPPINS,
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.023),
                              ),
                              Text(
                                "DEF",
                                style: TextStyle(
                                    fontFamily: FontFamilies.POPPINS,
                                    fontSize:
                                        (MediaQuery.of(context).size.height *
                                            0.015),
                                    letterSpacing: 2.0),
                              ),
                            ],
                          )),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width / 3.7,
                  child: ButtonTheme(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    buttonColor: Colors.white,
                    child: RaisedButton(
                      onPressed: () {
                        screen=="PAYMENT"?paymentBloc.add("4")
                            : otpBloc.add("4");
                      },
                      child: Container(
                          padding: EdgeInsets.only(
                              top: DisplayScreen.displayWidth(context) * 0.005,
                              bottom:
                                  DisplayScreen.displayWidth(context) * 0.005,
                              right: DisplayScreen.displayWidth(context) * 0.01,
                              left: DisplayScreen.displayWidth(context) * 0.01),
                          child: Column(
                            children: <Widget>[
                              Text(
                                "4",
                                style: TextStyle(
                                    fontFamily: FontFamilies.POPPINS,
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.023),
                              ),
                              Text(
                                "GHI",
                                style: TextStyle(
                                    fontFamily: FontFamilies.POPPINS,
                                    fontSize:
                                        (MediaQuery.of(context).size.height *
                                            0.015),
                                    letterSpacing: 2.0),
                              ),
                            ],
                          )),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 3.7,
                  child: ButtonTheme(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    buttonColor: Colors.white,
                    child: RaisedButton(
                      onPressed: () {
                        screen=="PAYMENT"?paymentBloc.add("5")
                            : otpBloc.add("5");
                      },
                      child: Container(
                          padding: EdgeInsets.only(
                              top: DisplayScreen.displayWidth(context) * 0.005,
                              bottom:
                                  DisplayScreen.displayWidth(context) * 0.005,
                              right: DisplayScreen.displayWidth(context) * 0.01,
                              left: DisplayScreen.displayWidth(context) * 0.01),
                          child: Column(
                            children: <Widget>[
                              Text(
                                "5",
                                style: TextStyle(
                                    fontFamily: FontFamilies.POPPINS,
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.023),
                              ),
                              Text(
                                "JKL",
                                style: TextStyle(
                                    fontFamily: FontFamilies.POPPINS,
                                    fontSize:
                                        (MediaQuery.of(context).size.height *
                                            0.015),
                                    letterSpacing: 2.0),
                              ),
                            ],
                          )),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 3.7,
                  child: ButtonTheme(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    buttonColor: Colors.white,
                    child: RaisedButton(
                      onPressed: () {
                        screen=="PAYMENT"?paymentBloc.add("6")
                            : otpBloc.add("6");
                      },
                      child: Container(
                          padding: EdgeInsets.only(
                              top: DisplayScreen.displayWidth(context) * 0.005,
                              bottom:
                                  DisplayScreen.displayWidth(context) * 0.005,
                              right: DisplayScreen.displayWidth(context) * 0.01,
                              left: DisplayScreen.displayWidth(context) * 0.01),
                          child: Column(
                            children: <Widget>[
                              Text(
                                "6",
                                style: TextStyle(
                                    fontFamily: FontFamilies.POPPINS,
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.023),
                              ),
                              Text(
                                "DEF",
                                style: TextStyle(
                                    fontFamily: FontFamilies.POPPINS,
                                    fontSize:
                                        (MediaQuery.of(context).size.height *
                                            0.015),
                                    letterSpacing: 2.0),
                              ),
                            ],
                          )),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width / 3.7,
                  child: ButtonTheme(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    buttonColor: Colors.white,
                    child: RaisedButton(
                      onPressed: () {
                        screen=="PAYMENT"?paymentBloc.add("7")
                            : otpBloc.add("7");                      },
                      child: Container(
                          padding: EdgeInsets.only(
                              top: DisplayScreen.displayWidth(context) * 0.005,
                              bottom:
                                  DisplayScreen.displayWidth(context) * 0.005,
                              right: DisplayScreen.displayWidth(context) * 0.01,
                              left: DisplayScreen.displayWidth(context) * 0.01),
                          child: Column(
                            children: <Widget>[
                              Text(
                                "7",
                                style: TextStyle(
                                    fontFamily: FontFamilies.POPPINS,
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.023),
                              ),
                              Text(
                                "PQRS",
                                style: TextStyle(
                                    fontFamily: FontFamilies.POPPINS,
                                    fontSize:
                                        (MediaQuery.of(context).size.height *
                                            0.015),
                                    letterSpacing: 2.0),
                              ),
                            ],
                          )),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 3.7,
                  child: ButtonTheme(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    buttonColor: Colors.white,
                    child: RaisedButton(
                      onPressed: () {
                        screen=="PAYMENT"?paymentBloc.add("8")
                            : otpBloc.add("8");                      },
                      child: Container(
                          padding: EdgeInsets.only(
                              top: DisplayScreen.displayWidth(context) * 0.005,
                              bottom:
                                  DisplayScreen.displayWidth(context) * 0.005,
                              right: DisplayScreen.displayWidth(context) * 0.01,
                              left: DisplayScreen.displayWidth(context) * 0.01),
                          child: Column(
                            children: <Widget>[
                              Text(
                                "8",
                                style: TextStyle(
                                    fontFamily: FontFamilies.POPPINS,
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.023),
                              ),
                              Text(
                                "TUV",
                                style: TextStyle(
                                    fontFamily: FontFamilies.POPPINS,
                                    fontSize:
                                        (MediaQuery.of(context).size.height *
                                            0.015),
                                    letterSpacing: 2.0),
                              ),
                            ],
                          )),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 3.7,
                  child: ButtonTheme(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    buttonColor: Colors.white,
                    child: RaisedButton(
                      onPressed: () {
                        screen=="PAYMENT"?paymentBloc.add("9")
                            : otpBloc.add("9");                      },
                      child: Container(
                          padding: EdgeInsets.only(
                              top: DisplayScreen.displayWidth(context) * 0.005,
                              bottom:
                                  DisplayScreen.displayWidth(context) * 0.005,
                              right: DisplayScreen.displayWidth(context) * 0.01,
                              left: DisplayScreen.displayWidth(context) * 0.01),
                          child: Column(
                            children: <Widget>[
                              Text(
                                "9",
                                style: TextStyle(
                                    fontFamily: FontFamilies.POPPINS,
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.023),
                              ),
                              Text(
                                "XWYZ",
                                style: TextStyle(
                                    fontFamily: FontFamilies.POPPINS,
                                    fontSize:
                                        (MediaQuery.of(context).size.height *
                                            0.015),
                                    letterSpacing: 2.0),
                              ),
                            ],
                          )),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 5, bottom: 10),
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10),
                  child: Text(" "),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 3.7,
                  child: ButtonTheme(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    buttonColor: Colors.white,
                    child: RaisedButton(
                      onPressed: () {
                        screen=="PAYMENT"?paymentBloc.add("0")
                            : otpBloc.add("0");                      },
                      child: Container(
                          padding: EdgeInsets.only(
                              top: DisplayScreen.displayWidth(context) * 0.005,
                              bottom:
                                  DisplayScreen.displayWidth(context) * 0.005,
                              right: DisplayScreen.displayWidth(context) * 0.01,
                              left: DisplayScreen.displayWidth(context) * 0.01),
                          child: Column(
                            children: <Widget>[
                              Text(
                                "0",
                                style: TextStyle(
                                    fontFamily: FontFamilies.POPPINS,
                                    fontSize:
                                        (MediaQuery.of(context).size.height *
                                            0.023)),
                              ),
                              Text(
                                "000",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: FontFamilies.POPPINS,
                                    fontSize:
                                        (MediaQuery.of(context).size.height *
                                            0.015),
                                    letterSpacing: 2.0),
                              ),
                            ],
                          )),
                    ),
                  ),
                ),
                InkWell(
                    onTap: () {
                      screen=="PAYMENT"?paymentBloc.remove()
                          : otpBloc.remove();                    },
                    child: SvgPicture.asset(
                      "assets/images/backspace.svg",
                      width: 25,
                      height: 25,
                    )
                    // Image.asset("assets/images/backspace.png")
                    ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
