import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'file:///C:/Users/r.horani/AndroidStudioProjects/helix_courier_project/helix_courier_project/lib/src/constants/application_colors_value.dart';

import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:posta_courier/models/activation_code_model.dart';
import 'package:posta_courier/src/blocs/signIn_and_createAccount_blocs/vehicle_bloc.dart';
import 'package:posta_courier/src/blocs/signIn_and_createAccount_blocs/sign_up_bloc.dart';
import 'package:posta_courier/src/constants/fonts_size.dart';
import 'package:posta_courier/src/ui/signIn_and_createAccount_screens/welcome_screen.dart';
import 'package:posta_courier/src/ui/widgets/country_code.dart';
import 'package:posta_courier/src/ui/widgets/dialog.dart';
import 'package:posta_courier/src/ui/widgets/dialog_loading.dart';
import 'otp_screen.dart';
import 'package:country_codes/country_codes.dart';
import 'package:flag/flag.dart';

class SignUpScreen extends StatelessWidget {
  var phoneNumberNode = FocusNode();
  static final controller = TextEditingController();
  var globalPhoneType = PhoneNumberType.mobile;
  var globalPhoneFormat = PhoneNumberFormat.national;
  final initFuture = FlutterLibphonenumber().init();
  String currentCountryCode = "";
  CountryDetails countryDetails = CountryCodes.detailsForLocale();

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.white);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    phoneBloc.internetChecked();
    vehicleBloc.fetchAllCarBrand();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return WelcomeScreen();
                          }),
                        );
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
              Center(
                child: Container(
                  margin: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.width * 0.03,
                    top: MediaQuery.of(context).size.width * 0.03,
                  ),
                  child: SvgPicture.asset(
                    "assets/images/posta_logo.svg",
                    width: (MediaQuery.of(context).size.width * 0.6) - 22,
                    height: (MediaQuery.of(context).size.height * 0.17) - 22,
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.05,
                      right: MediaQuery.of(context).size.width * 0.05,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Join our Team!",
                          style: TextStyle(
                              color: AppColors.TITLE_TEXT_COLOR,
                              fontFamily: FontFamilies.POPPINS,
                              fontSize:
                                  (MediaQuery.of(context).size.width * 0.04) +
                                      FontSize.HEADING_FONT,
                              fontWeight: FontWeight.w700),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.width * 0.06,
                              bottom: MediaQuery.of(context).size.width * 0.08),
                          padding: EdgeInsets.only(
                              left: 8, right: 3, top: 3, bottom: 3),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.completedInfoBoxUnderLine,
                                spreadRadius: 2,
                                blurRadius: 2,
                                offset: Offset(
                                    1, 1.5), // changes position of shadow
                              ),
                            ],
                          ),
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            children: <Widget>[
                              CountryCode(),

                              Container(
                                height: 35,
                                child: VerticalDivider(
                                  color: Colors.black12,
                                  thickness: 1.2,
                                ),
                              ),
                              // phoneNumberTextField(),

                              Expanded(
                                  child: Align(
                                alignment: Alignment.center,
                                child: phoneNumberTextField(),
                              )),
                            ],
                          ),
                        ),
                        Text(
                          "By creating an account, you agree to our",
                          style: TextStyle(
                            color: AppColors.TITLE_TEXT_COLOR,
                            fontFamily: FontFamilies.POPPINS,
                            fontSize:
                                (MediaQuery.of(context).size.height * 0.02),
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            InkWell(
                              onTap: () {},
                              child: Text(
                                "Terms of Service",
                                style: TextStyle(
                                    color: AppColors.TITLE_TEXT_COLOR,
                                    fontFamily: FontFamilies.POPPINS,
                                    fontSize:
                                        (MediaQuery.of(context).size.height *
                                            0.02),
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                            Text(
                              " and ",
                              style: TextStyle(
                                color: AppColors.TITLE_TEXT_COLOR,
                                fontFamily: FontFamilies.POPPINS,
                                fontSize:
                                    (MediaQuery.of(context).size.height * 0.02),
                              ),
                            ),
                            InkWell(
                              onTap: () {},
                              child: Text(
                                "Privacy Policy",
                                style: TextStyle(
                                    color: AppColors.TITLE_TEXT_COLOR,
                                    fontFamily: FontFamilies.POPPINS,
                                    fontSize:
                                        (MediaQuery.of(context).size.height *
                                            0.02),
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ],
                        ),
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
                            top: MediaQuery.of(context).size.width * 0.08,
                          ),
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.width / 7,
                          child: ButtonTheme(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            buttonColor: Colors.white,
                            child: StreamBuilder(
                              stream: phoneBloc.phoneNumber,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  phoneBloc.internetChecked();

                                  return StreamBuilder(
                                    stream: phoneBloc.checkInternet,
                                    builder: (context, snap) {
                                      return StreamBuilder(
                                        stream: phoneBloc.activationCode,
                                        builder: (BuildContext context,
                                            AsyncSnapshot<ActivationCodeModel>
                                                snapshots) {
                                          return RaisedButton(
                                            onPressed: () {
                                              phoneBloc.internetChecked();
                                              if (snapshot.data == "") {
                                              } else {
                                                if (snap.data == true) {
                                                  phoneBloc.getActivationCode();
                                                  _showDialog(context);
                                                  // countryBloc.getCities(phoneBloc.getCountryCode().toString());
                                                } else {
                                                  _checkInternet(context);
                                                }
                                              }
                                            },
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.04),
                                                  child: Text(
                                                    "Continue",
                                                    style: TextStyle(
                                                      fontFamily:
                                                          FontFamilies.POPPINS,
                                                      fontSize: (MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.008) +
                                                          FontSize
                                                              .BUTTON_FONT_L,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      right:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.04),
                                                  child: Icon(
                                                    Icons.arrow_forward,
                                                    color: Colors.black,
                                                    size:
                                                        (MediaQuery.of(context)
                                                                    .size
                                                                    .width *
                                                                0.008) +
                                                            18,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  );
                                } else {
                                  return StreamBuilder(
                                    stream: phoneBloc.checkInternet,
                                    builder: (context, snap) {
                                      return RaisedButton(
                                        onPressed: () {},
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.04),
                                              child: Text(
                                                "Continue",
                                                style: TextStyle(
                                                  fontFamily:
                                                      FontFamilies.POPPINS,
                                                  fontSize:
                                                      (MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.008) +
                                                          FontSize
                                                              .BUTTON_FONT_L,
                                                  color: AppColors.LIGHT_GREY,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  right: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.04),
                                              child: Icon(
                                                Icons.arrow_forward,
                                                color: AppColors.LIGHT_GREY,
                                                size: (MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        0.008) +
                                                    18,
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
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
      ),
    );
  }

  Widget phoneNumberTextField() => StreamBuilder<String>(
        stream: phoneBloc.phoneNumber,
        builder: (context, snap) {
          // snap.hasData?print(snap.data.replaceAll(RegExp(r'[^\d]+'), '')):print("test");
          return Container(
            padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.height * 0.03),
            child: TextField(
              style: TextStyle(
                fontSize: (MediaQuery.of(context).size.height * 0.019) + 1,
                fontFamily: FontFamilies.POPPINS,
              ),
              focusNode: phoneNumberNode,
              cursorColor: AppColors.MAIN_COLOR,
              keyboardType: TextInputType.phone,
              decoration: new InputDecoration(
                contentPadding: EdgeInsets.only(bottom: 15),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                errorText: snap.error,
                labelText: phoneNumberNode.hasFocus || snap.hasData
                    ? " "
                    : 'Enter your phone number',
                labelStyle: TextStyle(
                    color: AppColors.TITLE_TEXT_COLOR, fontFamily: 'Poppins'),
              ),
              onChanged: (phoneBloc.changePhoneNumber),
            ),
          );
        },
      );

  Future<void> _checkInternet(context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        FlutterStatusbarcolor.setStatusBarColor(AppColors.dialogStatusBar);

        Future.delayed(Duration(seconds: 3), () {
          phoneBloc.internetChecked();
          FlutterStatusbarcolor.setStatusBarColor(Colors.white);

          Navigator.of(context).pop();
        });
        phoneBloc.internetChecked();

        return AlertDialog(
          contentPadding: EdgeInsets.all(10),
          insetPadding: EdgeInsets.all(0),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          content: Container(
              height: 200,
              width: 170,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset("assets/images/mark.png"),
                  SizedBox(
                    height: 30,
                  ),
                  Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Please check your internet connection and try again",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w200),
                      )),
                ],
              )),
        );
      },
    ).then((value) => FlutterStatusbarcolor.setStatusBarColor(Colors.white));
  }

  Future<void> _showDialog(context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        FlutterStatusbarcolor.setStatusBarColor(AppColors.dialogStatusBar);
        Future.delayed(Duration(seconds: 3), () {
          if (phoneBloc.userValidationII() == "success") {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return OtpScreen(
                  screen: "SIGN_UP",
                  phoneNumber: phoneBloc.getPhoneNumber(),
                );
              }),
            );
          } else {
            Navigator.pop(context);
            showDialog(
                barrierDismissible: false,
                context: context,
                builder: (BuildContext context) {
                  return ErrorDialogWidget(
                    text:
                        "The phone number has already been taken with another account",
                  );
                });
          }
        });
        return LoadingDialogWidget();
      },
    ).then((value) => FlutterStatusbarcolor.setStatusBarColor(Colors.white));
  }
}
