import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:flutter_svg/svg.dart';
import 'package:posta_courier/models/activation_code_model.dart';
import 'package:posta_courier/models/registered_captain_model.dart';
import 'package:posta_courier/src/blocs/home_blocs/approved_captain_bloc.dart';
import 'package:posta_courier/src/blocs/home_blocs/google_map_bloc.dart';
import 'package:posta_courier/src/blocs/signIn_and_createAccount_blocs/get_captain_data_bloc.dart';
import 'package:posta_courier/src/blocs/signIn_and_createAccount_blocs/signIn_bloc.dart';
import 'package:posta_courier/src/constants/application_colors_value.dart';
import 'package:posta_courier/src/constants/fonts_size.dart';
import 'package:posta_courier/src/ui/home/google_maps/home_screen.dart';
import 'package:posta_courier/src/ui/signIn_and_createAccount_screens/sign_up_screen.dart';
import 'package:posta_courier/src/ui/widgets/dialog_loading.dart';
import 'package:posta_courier/src/blocs/home_blocs/weekly_report_bloc.dart';
import 'package:country_codes/country_codes.dart';
import 'package:posta_courier/src/blocs/home_blocs/wallet_bloc.dart';
import 'package:posta_courier/src/blocs/signIn_and_createAccount_blocs/sign_up_bloc.dart';
import 'package:posta_courier/src/blocs/signIn_and_createAccount_blocs/rout_sceen.dart';
import 'package:posta_courier/src/ui/widgets/country_code_dialog.dart';
import 'package:posta_courier/src/ui/widgets/country_code.dart';

import 'package:flag/flag.dart';
import 'completed_info_screen.dart';
import 'forgot_pass_with_phone_screen.dart';
import 'incompleted_info_screen.dart';
import 'otp_screen.dart';

class SignInScreen extends StatelessWidget {
  var phoneNumberNode = FocusNode();
  var passwordNode = FocusNode();

  var globalPhoneType = PhoneNumberType.mobile;
  var globalPhoneFormat = PhoneNumberFormat.national;
  final initFuture = FlutterLibphonenumber().init();

  static final phoneController = TextEditingController();
  String currentCountryCode = "";
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(
    //     SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    _firebaseMessaging.getToken().then((token) {
      approvedCaptainBloc.setNotificationToken(token);});
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.width / 5,
                        left: MediaQuery.of(context).size.width * 0.05,
                      ),
                      child: Text(" "),
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
                          height:
                              (MediaQuery.of(context).size.height * 0.17) - 22,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.05,
                        right: MediaQuery.of(context).size.width * 0.05,
                        top: MediaQuery.of(context).size.width * 0.12,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Welcome back!",
                            style: TextStyle(
                                color: AppColors.TITLE_TEXT_COLOR,
                                fontFamily: FontFamilies.POPPINS,
                                fontSize:
                                    (MediaQuery.of(context).size.width * 0.04) +
                                        FontSize.HEADING_FONT,
                                fontWeight: FontWeight.w700),
                          ),

                          StreamBuilder<String>(
                            stream: signInBloc.phoneNumber,
                            builder: (context, snap) {
                              return Container(
                                  margin: EdgeInsets.only(top: 5),
                                  child: StreamBuilder(
                                      stream: signInBloc.loginValidation,
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return TextField(
                                            style: TextStyle(
                                              fontFamily: FontFamilies.POPPINS,
                                              fontSize: (MediaQuery.of(context).size.height * 0.02),
                                            ),
                                            focusNode: phoneNumberNode,
                                            cursorColor: AppColors.MAIN_COLOR,
                                            keyboardType: TextInputType.phone,
                                            decoration: new InputDecoration(
                                              contentPadding: EdgeInsets.all(0),
                                              enabledBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(color: AppColors.ERROR),
                                              ),
                                              focusedBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(color: AppColors.MAIN_COLOR),
                                              ),
                                              errorText: snap.error,
                                              labelText: 'Phone Number',
                                              labelStyle: TextStyle(
                                                color: AppColors.labelColor,
                                                fontFamily: FontFamilies.POPPINS,
                                              ),
                                               prefix: CountryCode(),
                                              suffix: snap.hasData
                                                  ? snap.data.isNotEmpty
                                                  ? Padding(
                                                  padding: EdgeInsets.only(
                                                      right: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                          0.025),
                                                  child: Container(
                                                      child: Image.asset(
                                                          "assets/images/check_green.png")))
                                                  : Text(" ")
                                                  : Text(" "),
                                            ),

                                            controller: phoneController,
                                            onChanged: (signInBloc.changePhoneNumber),
                                          );
                                        }
                                        else {
                                          return TextField(
                                            style: TextStyle(
                                              fontFamily: FontFamilies.POPPINS,
                                              fontSize: (MediaQuery.of(context).size.height * 0.02),
                                            ),
                                            focusNode: phoneNumberNode,
                                            cursorColor: AppColors.MAIN_COLOR,
                                            keyboardType: TextInputType.phone,
                                            decoration: new InputDecoration(
                                              contentPadding: EdgeInsets.all(0),
                                              enabledBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(color: AppColors.LIGHT_BLUE),
                                              ),
                                              focusedBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(color: AppColors.MAIN_COLOR),
                                              ),
                                              errorText: snap.error,
                                              labelText: 'Phone Number',
                                              labelStyle: TextStyle(
                                                color: AppColors.labelColor,
                                                fontFamily: FontFamilies.POPPINS,
                                              ),
                                              prefix: CountryCode(),
                                              suffix: snap.hasData
                                                  ? snap.data.isNotEmpty
                                                  ? Padding(
                                                  padding: EdgeInsets.only(
                                                      right: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                          0.025),
                                                  child: Container(
                                                      child: Image.asset(
                                                          "assets/images/check_green.png")))
                                                  : Text(" ")
                                                  : Text(" "),
                                            ),

                                            controller: phoneController,
                                            onChanged: (signInBloc.changePhoneNumber),
                                          );
                                        }
                                      }));
                            },
                          ),
                          passwordTextField(),
                          StreamBuilder(
                            stream: signInBloc.loginValidation,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding: EdgeInsets.only(
                                        top: MediaQuery.of(context).size.width *
                                            0.01),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(top: 3),
                                          child: Image.asset(
                                            "assets/images/error_icon.png",
                                            width: 13,
                                            height: 13,
                                          ),
                                        ),
                                        Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                60,
                                            padding: EdgeInsets.only(left: 3),
                                            child: Text(
                                              "  " + snapshot.data,
                                              style: TextStyle(
                                                  color: AppColors.ERROR,
                                                  fontFamily: 'Poppins',
                                                  fontSize: 13),
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
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.05,
                        right: MediaQuery.of(context).size.width * 0.05,
                        top: MediaQuery.of(context).size.width * 0.16,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              signInBloc.resetPhone();
                              phoneController.clear();
                              ForgotPassWithPhone.phoneController.clear();

                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) {
                                  return ForgotPassWithPhone();
                                }),
                              );
                            },
                            child: Text(
                              "Forgot Password ?",
                              style: TextStyle(
                                  color: AppColors.DARK_GREY,
                                  fontFamily: FontFamilies.POPPINS,
                                  fontSize:
                                      (MediaQuery.of(context).size.height *
                                          0.019)),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                top: MediaQuery.of(context).size.width * 0.03),
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.width / 7,
                            child: ButtonTheme(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: StreamBuilder(
                                  stream: signInBloc.submitValid,
                                  builder: (BuildContext context,
                                      AsyncSnapshot<bool> snapshot) {
                                    if (snapshot.hasData) {
                                      return StreamBuilder(
                                        stream: signInBloc.captainDetails,
                                        builder: (context,
                                            AsyncSnapshot<LogInModel>
                                                snapshot) {
                                          return StreamBuilder(
                                            stream: signInBloc.activationCode,
                                            builder: (context,
                                                AsyncSnapshot<
                                                        ActivationCodeModel>
                                                    snap) {
                                              return RaisedButton(
                                                color: AppColors.MAIN_COLOR,
                                                onPressed: () {
                                                  signInBloc.signIn();
                                                  // checkCaptainDataBloc.checkUserAuth();
                                                  _showDialog(context);


                                                },
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: <Widget>[
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.04),
                                                      child: Text(
                                                        "Login",
                                                        style: TextStyle(
                                                            fontFamily:
                                                                FontFamilies
                                                                    .POPPINS,
                                                            fontSize: (MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.008) +
                                                                13,
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          right: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.04),
                                                      child: Icon(
                                                        Icons.arrow_forward,
                                                        color: Colors.white,
                                                        size: (MediaQuery.of(
                                                                        context)
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
                                      return RaisedButton(
                                        color: AppColors.LIGHT_GREY,
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
                                                "Login",
                                                style: TextStyle(
                                                    fontFamily:
                                                        FontFamilies.POPPINS,
                                                    fontSize:
                                                        (MediaQuery.of(context)
                                                                    .size
                                                                    .width *
                                                                0.008) +
                                                            13,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w700),
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
                                                color: Colors.white,
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
                                    }
                                  },
                                )),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.width * 0.03),
                            child: InkWell(
                              onTap: () {
                                signInBloc.resetPhone();
                                phoneController.clear();
                                phoneBloc.resetPhone();

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) {
                                    return SignUpScreen();
                                  }),
                                );
                              },
                              child: Text(
                                "Or Create An Account",
                                style: TextStyle(
                                    color: AppColors.DARK_GREY,
                                    fontFamily: FontFamilies.POPPINS,
                                    fontSize:
                                        (MediaQuery.of(context).size.height *
                                            0.019)),
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
        ));
  }

  Widget phoneNumberTextField(String res) => StreamBuilder<String>(
        stream: signInBloc.phoneNumber,
        builder: (context, snap) {
          return Container(
              margin: EdgeInsets.only(top: 5),
              child: StreamBuilder(
                  stream: signInBloc.loginValidation,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return TextField(
                        style: TextStyle(
                          fontFamily: FontFamilies.POPPINS,
                          fontSize: (MediaQuery.of(context).size.height * 0.02),
                        ),
                        focusNode: phoneNumberNode,
                        cursorColor: AppColors.MAIN_COLOR,
                        keyboardType: TextInputType.phone,
                        decoration: new InputDecoration(
                          contentPadding: EdgeInsets.all(0),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: AppColors.ERROR),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: AppColors.MAIN_COLOR),
                          ),
                          errorText: snap.error,
                          labelText: 'Phone Number',
                          labelStyle: TextStyle(
                            color: AppColors.labelColor,
                            fontFamily: FontFamilies.POPPINS,
                          ),
                          prefix:  InkWell(
                            onTap: () {
                              showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (BuildContext context) {
                                    return CountryCodeDialog(screen: "SIGN_IN",);
                                  });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                BorderRadius.all(Radius.circular(15)),
                              ),
                              width: MediaQuery.of(context).size.width / 3.7,
                              child: Row(
                                children: [
                                  StreamBuilder(
                                      stream: signInBloc.countryFlag,
                                      builder: (BuildContext context,
                                          AsyncSnapshot<String> snapshot) {

                                          return Flag(
                                            snapshot.data,
                                            width: 45,
                                            height: 40,
                                          );

                                      }),
                                  StreamBuilder(
                                    stream: signInBloc.countryCode,
                                    builder: (BuildContext context,
                                        AsyncSnapshot<String> snapshot) {

                                        return Padding(
                                            padding: EdgeInsets.only(left: 5),
                                            child:Text(
                                              snapshot.data,style: TextStyle(
                                                fontFamily: FontFamilies.POPPINS,
                                                fontSize: (MediaQuery.of(context).size.height * 0.02)+1),
                                            )
                                        );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),

                          suffix: snap.hasData
                              ? snap.data.isNotEmpty
                                  ? Padding(
                                      padding: EdgeInsets.only(
                                          right: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.025),
                                      child: Container(
                                          child: Image.asset(
                                              "assets/images/check_green.png")))
                                  : Text(" ")
                              : Text(" "),
                        ),
                        // inputFormatters: [
                        //   LibPhonenumberTextFormatter(
                        //     phoneNumberType: globalPhoneType,
                        //     phoneNumberFormat: globalPhoneFormat,
                        //
                        //     onCountrySelected: (val) {},
                        //   ),
                        // ],
                        controller: phoneController,
                        onChanged: (signInBloc.changePhoneNumber),
                      );
                    }
                    else {
                      return TextField(
                        style: TextStyle(
                          fontFamily: FontFamilies.POPPINS,
                          fontSize: (MediaQuery.of(context).size.height * 0.02),
                        ),
                        focusNode: phoneNumberNode,
                        cursorColor: AppColors.MAIN_COLOR,
                        keyboardType: TextInputType.phone,
                        decoration: new InputDecoration(
                          contentPadding: EdgeInsets.all(0),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: AppColors.LIGHT_BLUE),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: AppColors.MAIN_COLOR),
                          ),
                          errorText: snap.error,
                          labelText: 'Phone Number',
                          labelStyle: TextStyle(
                            color: AppColors.labelColor,
                            fontFamily: FontFamilies.POPPINS,
                          ),
                          prefix:  InkWell(
                            onTap: () {
                              showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (BuildContext context) {
                                    return CountryCodeDialog(screen: "SIGN_IN",);
                                  });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                BorderRadius.all(Radius.circular(15)),
                              ),
                              width: MediaQuery.of(context).size.width / 3.7,
                              child: Row(
                                children: [
                                  StreamBuilder(
                                      stream: signInBloc.countryFlag,
                                      builder: (BuildContext context,
                                          AsyncSnapshot<String> snapshot) {
                                        if (snapshot.hasData) {
                                          return Flag(
                                            snapshot.data,
                                            width: 45,
                                            height: 40,
                                          );
                                        } else {
                                          return Flag(
                                            res,
                                            width: 45,
                                            height: 40,
                                          );
                                        }
                                      }),
                                  StreamBuilder(
                                    stream: signInBloc.countryCode,
                                    builder: (BuildContext context,
                                        AsyncSnapshot<String> snapshot) {
                                      if(snapshot.hasData)
                                      {
                                        return Padding(
                                            padding: EdgeInsets.only(left: 5),
                                            child:Text(
                                              snapshot.data,style: TextStyle(
                                                fontFamily: FontFamilies.POPPINS,
                                                fontSize: (MediaQuery.of(context).size.height * 0.02)+1),
                                            )
                                        );}
                                      else
                                      {return Padding(
                                          padding: EdgeInsets.only(left: 5),
                                          child:Text(
                                            currentCountryCode,style: TextStyle(
                                              fontFamily: FontFamilies.POPPINS,
                                              fontSize: (MediaQuery.of(context).size.height * 0.02)+1),
                                          )
                                      );}
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          suffix: snap.hasData
                              ? snap.data.isNotEmpty
                                  ? Padding(
                                      padding: EdgeInsets.only(
                                          right: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.025),
                                      child: Container(
                                          child: Image.asset(
                                              "assets/images/check_green.png")))
                                  : Text(" ")
                              : Text(" "),
                        ),
                        // inputFormatters: [
                        //   LibPhonenumberTextFormatter(
                        //     phoneNumberType: globalPhoneType,
                        //     phoneNumberFormat: globalPhoneFormat,
                        //     overrideSkipCountryCode:
                        //         CountryCodePickerWidget.res,
                        //     onCountrySelected: (val) {},
                        //   ),
                        // ],
                        controller: phoneController,
                        onChanged: (signInBloc.changePhoneNumber),
                      );
                    }
                  }));
        },
      );
  Widget passwordTextField() => StreamBuilder<String>(
        stream: signInBloc.password,
        builder: (context, snap) {
          return StreamBuilder(
            stream: signInBloc.isPasswordHide,
            builder: (context, snap) {
              return Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.018),
                child: StreamBuilder(
                    stream: signInBloc.loginValidation,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return TextField(
                          style: TextStyle(
                            fontFamily: FontFamilies.POPPINS,
                            fontSize:
                                (MediaQuery.of(context).size.height * 0.02),
                          ),
                          focusNode: passwordNode,
                          cursorColor: AppColors.MAIN_COLOR,
                          keyboardType: TextInputType.text,
                          decoration: new InputDecoration(
                            contentPadding: EdgeInsets.all(0),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: AppColors.ERROR),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: AppColors.MAIN_COLOR),
                            ),
                            errorText: snap.error,
                            labelText: 'Password',
                            labelStyle: TextStyle(
                              color: AppColors.labelColor,
                              fontFamily: FontFamilies.POPPINS,
                            ),
                            suffix: Padding(
                                padding: EdgeInsets.only(
                                    right: MediaQuery.of(context).size.width *
                                        0.025),
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
                                        ? signInBloc
                                            .setPasswordVisibility(!snap.data)
                                        : signInBloc
                                            .setPasswordVisibility(false);
                                  },
                                )),
                          ),
                          obscureText: snap.hasData ? snap.data : true,
                          onChanged: (signInBloc.changePassword),
                        );
                      } else {
                        return TextField(
                          style: TextStyle(
                            fontFamily: FontFamilies.POPPINS,
                            fontSize:
                                (MediaQuery.of(context).size.height * 0.02),
                          ),
                          focusNode: passwordNode,
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
                            errorText: snap.error,
                            labelText: 'Password',
                            labelStyle: TextStyle(
                              color: AppColors.labelColor,
                              fontFamily: FontFamilies.POPPINS,
                            ),
                            suffix: Padding(
                                padding: EdgeInsets.only(
                                    right: MediaQuery.of(context).size.width *
                                        0.025),
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
                                        ? signInBloc
                                            .setPasswordVisibility(!snap.data)
                                        : signInBloc
                                            .setPasswordVisibility(false);
                                  },
                                )),
                          ),
                          obscureText: snap.hasData ? snap.data : true,
                          onChanged: (signInBloc.changePassword),
                        );
                      }
                    }),
              );
            },
          );
        },
      );
  Future<void> _showDialog(context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        signInBloc.setLoginValidation();
        FlutterStatusbarcolor.setStatusBarColor(AppColors.dialogStatusBar);
        // checkCaptainDataBloc.checkUserAuth();
        // checkCaptainDataBloc.checkCaptainData();
        Future.delayed(Duration(seconds:3), () {
          if (signInBloc.logInValidation()) {
            FlutterStatusbarcolor.setStatusBarColor(Colors.white);
            Navigator.of(context).pop(true);
            checkCaptainDataBloc.checkUserStatus();
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return StreamBuilder(
                    stream: checkCaptainDataBloc.checkUser,
                    builder: (BuildContext context,
                        AsyncSnapshot<LogInModel> snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data.data.approvedAt != null) {
                          signInBloc.resetCountry();
                          googleMapBloc.getUserLocation();
                          // approvedCaptainBloc.checkUserAuth();
                          // walletBloc.walletAccount();
                          screensBloc.setScreen('/home');
                          return HomeScreen();
                        }
                    else if (snapshot.data.data.car.car.isEmpty||
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
                  }
                  else
                    {
                      return SignInScreen();
                    }}

                );
              }),
            );
          } else {
            FlutterStatusbarcolor.setStatusBarColor(Colors.white);
            Navigator.of(context).pop(true);
          }
        });
        return LoadingDialogWidget();
      },
    ).then((value) => FlutterStatusbarcolor.setStatusBarColor(Colors.white));
  }

}
