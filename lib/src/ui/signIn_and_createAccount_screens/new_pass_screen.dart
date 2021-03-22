import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'file:///C:/Users/r.horani/AndroidStudioProjects/helix_courier_project/helix_courier_project/lib/src/constants/application_colors_value.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:posta_courier/src/blocs/signIn_and_createAccount_blocs/forgot_pass_bloc.dart';
import 'package:posta_courier/src/constants/fonts_size.dart';
import 'package:posta_courier/src/ui/signIn_and_createAccount_screens/signIn_screen.dart';
import 'package:posta_courier/src/ui/widgets/dialog_loading.dart';
import 'package:posta_courier/validation/text_field_validation.dart';

class NewPassScreen extends StatelessWidget {
  var passNode = FocusNode();
  var confirmPassNode = FocusNode();

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
              Center(
                child: Container(
                  margin: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.width * 0.01,
                    top: MediaQuery.of(context).size.width * 0.01,
                  ),
                  child: SvgPicture.asset(
                    "assets/images/posta_logo.svg",
                    width: (MediaQuery.of(context).size.width * 0.6) - 22,
                    height: (MediaQuery.of(context).size.height * 0.17) - 22,
                  ),
                ),
              ),
              Container(
                  margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.05,
                    right: MediaQuery.of(context).size.width * 0.05,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          " Set Your New Password ",
                          style: TextStyle(
                              color: AppColors.TITLE_TEXT_COLOR,
                              fontFamily: FontFamilies.POPPINS,
                              fontSize:
                                  (MediaQuery.of(context).size.width * 0.04) +
                                      FontSize.HEADING_FONT,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      passTextField(),
                      confirmPassTextField(),
                    ],
                  )),
              Container(
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.width * 0.03,
                  left: MediaQuery.of(context).size.width * 0.05,
                  right: MediaQuery.of(context).size.width * 0.05,
                ),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width / 7,
                child: ButtonTheme(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: StreamBuilder(
                      stream: forgotPassBloc.submitValid,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return RaisedButton(                    color: AppColors.MAIN_COLOR,

                            onPressed: () {
                              TextFieldValidation().checkPassValidation(
                                  forgotPassBloc.getPass().toString(),
                                  'RESET_NEW_PASS');
                              TextFieldValidation().checkNewPasswordMatching(
                                  forgotPassBloc.getPass().toString(),
                                  forgotPassBloc.getConfirmPass().toString());
                              if (forgotPassBloc.checkValidation()) {
                                print(true);
                                forgotPassBloc.resetPass();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) {
                                    return SignInScreen();
                                  }),
                                );

                              } else {
                                print(false);
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width *
                                          0.04),
                                  child: Text(
                                    "Complete",
                                    style: TextStyle(
                                        fontFamily: FontFamilies.POPPINS,
                                        fontSize:
                                            (MediaQuery.of(context).size.width *
                                                    0.008) +
                                                13,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      right: MediaQuery.of(context).size.width *
                                          0.04),
                                  child: Icon(
                                    Icons.arrow_forward,
                                    color: Colors.white,
                                    size: (MediaQuery.of(context).size.width *
                                            0.008) +
                                        18,
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else {
                          return RaisedButton(                    color: AppColors.LIGHT_GREY,

                            onPressed: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width *
                                          0.04),
                                  child: Text(
                                    "Complete",
                                    style: TextStyle(
                                        fontFamily: FontFamilies.POPPINS,
                                        fontSize:
                                            (MediaQuery.of(context).size.width *
                                                    0.008) +
                                                13,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      right: MediaQuery.of(context).size.width *
                                          0.04),
                                  child: Icon(
                                    Icons.arrow_forward,
                                    color: Colors.white,
                                    size: (MediaQuery.of(context).size.width *
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
                padding: EdgeInsets.only(bottom: 5),
                child: Image.asset("assets/images/home_indicator.png"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget passTextField() => StreamBuilder<String>(
        stream: forgotPassBloc.password,
        builder: (context, snap) {
          // snap.hasData?print(snap.data.replaceAll(RegExp(r'[^\d]+'), '')):print("test");
          return Column(
            children: [
              StreamBuilder(
                stream: forgotPassBloc.isPasswordHide,
                builder: (context, snap) {
                  return Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.width * 0.06),
                    child: TextField(
                      style: TextStyle(
                        fontFamily: FontFamilies.POPPINS,
                        fontSize: (MediaQuery.of(context).size.height * 0.02),
                      ),
                      focusNode: passNode,
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
                          labelText: 'New Password',
                          labelStyle: TextStyle(
                            color: AppColors.labelColor,
                            fontFamily: FontFamilies.POPPINS,
                          ),
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
                                  ? forgotPassBloc
                                      .setPasswordVisibility(!snap.data)
                                  : forgotPassBloc.setPasswordVisibility(false);
                            },
                          )),
                      obscureText: snap.hasData ? snap.data : true,
                      onChanged: (forgotPassBloc.changePassword),
                    ),
                  );
                },
              ),
              StreamBuilder(
                stream: forgotPassBloc.isPassValid,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.width * 0.01),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              "assets/images/error_icon.png",
                              width: 10,
                              height: 10,
                            ),
                            Container(
                                width: MediaQuery.of(context).size.width - 60,
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

  Widget confirmPassTextField() => StreamBuilder<String>(
        stream: forgotPassBloc.confirmPass,
        builder: (context, snap) {
          // snap.hasData?print(snap.data.replaceAll(RegExp(r'[^\d]+'), '')):print("test");
          return Column(
            children: [
              StreamBuilder(
                stream: forgotPassBloc.isConfirmPasswordHide,
                builder: (context, snap) {
                  return Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.018),
                    child: TextField(
                      style: TextStyle(
                        fontFamily: FontFamilies.POPPINS,
                        fontSize: (MediaQuery.of(context).size.height * 0.02),
                      ),
                      focusNode: confirmPassNode,
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
                          labelText: 'Confirm Password',
                          labelStyle: TextStyle(
                            color: AppColors.labelColor,
                            fontFamily: FontFamilies.POPPINS,
                          ),
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
                                  ? forgotPassBloc
                                      .setConfirmPasswordVisibility(!snap.data)
                                  : forgotPassBloc
                                      .setConfirmPasswordVisibility(false);
                            },
                          )),
                      obscureText: snap.hasData ? snap.data : true,
                      onChanged: (forgotPassBloc.changeConfirmPass),
                    ),
                  );
                },
              ),
              StreamBuilder(
                stream: forgotPassBloc.isPassMatching,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.width * 0.01),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              "assets/images/error_icon.png",
                              width: 10,
                              height: 10,
                            ),
                            Container(
                                width: MediaQuery.of(context).size.width - 60,
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

  Future<void> _showDialog(context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        FlutterStatusbarcolor.setStatusBarColor(AppColors.dialogStatusBar);

        Future.delayed(Duration(seconds: 3), () {
          if (forgotPassBloc.resetPassValidation()) {
            FlutterStatusbarcolor.setStatusBarColor(Colors.white);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return SignInScreen();
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
