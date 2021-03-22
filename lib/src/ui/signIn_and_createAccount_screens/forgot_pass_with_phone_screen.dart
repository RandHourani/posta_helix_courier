import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:posta_courier/src/blocs/signIn_and_createAccount_blocs/forgot_pass_bloc.dart';
import 'package:posta_courier/src/blocs/signIn_and_createAccount_blocs/signIn_bloc.dart';
import 'package:posta_courier/src/constants/application_colors_value.dart';
import 'package:posta_courier/src/constants/fonts_size.dart';
import 'package:posta_courier/src/ui/signIn_and_createAccount_screens/otp_screen.dart';
import 'package:posta_courier/src/blocs/signIn_and_createAccount_blocs/otp_signIn_bloc.dart';
import 'package:posta_courier/src/ui/widgets/country_code.dart';
import 'package:country_codes/country_codes.dart';
import 'package:posta_courier/src/ui/widgets/dialog_loading.dart';
import 'package:posta_courier/src/ui/widgets/dialog.dart';

import 'package:flag/flag.dart';
class ForgotPassWithPhone extends StatelessWidget {
  var phoneNode = FocusNode();
  var globalPhoneType = PhoneNumberType.mobile;
  var globalPhoneFormat = PhoneNumberFormat.national;
  final initFuture = FlutterLibphonenumber().init();

  static var phoneController = TextEditingController();
  String currentCountryCode = "";
  @override
  Widget build(BuildContext context) {

    FlutterStatusbarcolor.setStatusBarColor(Colors.white);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
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
                        top: MediaQuery.of(context).size.width * 0.1),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Don’t worry, it happens to the best of us",
                          style: TextStyle(
                              color: AppColors.DARK_GREY,
                              fontFamily: FontFamilies.POPPINS,
                              fontSize:
                                  (MediaQuery.of(context).size.height * 0.019)),
                        ),
                        Text(
                          "To Reset Your Password,\n Enter Your Phone Number",
                          style: TextStyle(
                              color: AppColors.TITLE_TEXT_COLOR,
                              fontFamily: FontFamilies.POPPINS,
                              fontSize:
                                  (MediaQuery.of(context).size.width * 0.04) +
                                      FontSize.HEADING_FONT,
                              fontWeight: FontWeight.w700),
                        ),
                        phoneNumberTextField(),
                      ],
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
                      stream: forgotPassBloc.phone,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return RaisedButton(
                            onPressed: () {
                              forgotPassBloc.getActivationCode();
                        _showDialog(context);
                            signInBloc.setCountryCode("962","JO");
                        signInBloc.setLoginValidation();
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "Continue ",
                                  style: TextStyle(
                                    fontFamily: FontFamilies.POPPINS,
                                    fontSize:
                                        (MediaQuery.of(context).size.width *
                                                0.008) +
                                            FontSize.BUTTON_FONT_L,
                                    color: Colors.black,
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_forward,
                                  color: Colors.black,
                                  size: (MediaQuery.of(context).size.width *
                                          0.008) +
                                      18,
                                ),
                              ],
                            ),
                          );
                        } else {
                          return RaisedButton(
                            onPressed: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "Continue ",
                                  style: TextStyle(
                                    fontFamily: FontFamilies.POPPINS,
                                    fontSize:
                                        (MediaQuery.of(context).size.width *
                                                0.008) +
                                            FontSize.BUTTON_FONT_L,
                                    color: AppColors.LIGHT_GREY,
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_forward,
                                  color: AppColors.LIGHT_GREY,
                                  size: (MediaQuery.of(context).size.width *
                                          0.008) +
                                      18,
                                ),
                              ],
                            ),
                          );
                        }
                      },
                    )),
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

  Widget phoneNumberTextField() =>
      StreamBuilder<String>(
        stream: forgotPassBloc.phone,
        builder: (context, snap) {
          return Container(
              margin: EdgeInsets.only(top: 5),
              child: TextField(
                style: TextStyle(
                  fontFamily: FontFamilies.POPPINS,
                  fontSize: (MediaQuery.of(context).size.height * 0.02),
                ),
                focusNode: phoneNode,
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
                onChanged: (forgotPassBloc.changePhone),
              ));
        },
      );
  Future<void> _showDialog(context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        FlutterStatusbarcolor.setStatusBarColor(AppColors.dialogStatusBar);
        Future.delayed(Duration(seconds: 3), () {
          if (forgotPassBloc.getMessage() == "success") {
            otpBloc.resetCode();
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return OtpScreen(
                  screen: 'FORGOT_PASS',
                  phoneNumber: forgotPassBloc.getPhoneNumber(),
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
                    forgotPassBloc.getMessage(),
                  );
                });
          }
        });
        return LoadingDialogWidget();
      },
    ).then((value) => FlutterStatusbarcolor.setStatusBarColor(Colors.white));
  }

}
