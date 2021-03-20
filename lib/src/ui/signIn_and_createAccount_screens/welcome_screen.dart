import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:country_codes/country_codes.dart';
import 'package:posta_courier/src/blocs/signIn_and_createAccount_blocs/country_cities_bloc.dart';
import 'package:posta_courier/src/blocs/signIn_and_createAccount_blocs/sign_up_bloc.dart';
import 'package:posta_courier/src/blocs/signIn_and_createAccount_blocs/vehicle_bloc.dart';
import 'package:posta_courier/src/constants/application_colors_value.dart';
import 'package:posta_courier/src/constants/fonts_size.dart';
import 'package:posta_courier/src/ui/signIn_and_createAccount_screens/signIn_screen.dart';
import 'package:posta_courier/src/ui/signIn_and_createAccount_screens/sign_up_screen.dart';
import 'package:posta_courier/src/utils/util.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // FlutterStatusbarcolor.setStatusBarColor(Colors.white);
    // SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    phoneBloc.internetChecked();
    // countryBloc.getCountry();
    vehicleBloc.fetchAllCarColor();
    vehicleBloc.fetchAllCarBrand();
    Utils.setScreen('/');

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              Center(
                child: Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.07),
                  child: SvgPicture.asset(
                    "assets/images/posta_logo.svg",
                    width: MediaQuery.of(context).size.width * 0.6,
                    height: MediaQuery.of(context).size.height * 0.17,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.1,
                ),
                child: Text(
                  "Welcome",
                  style: TextStyle(
                      color: AppColors.TITLE_TEXT_COLOR,
                      fontFamily: FontFamilies.POPPINS,
                      fontSize: (MediaQuery.of(context).size.width * 0.04) +
                          FontSize.TITLE_FONT,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ]),
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.05,
                right: MediaQuery.of(context).size.width * 0.05,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width / 7,
                    child: ButtonTheme(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      buttonColor: AppColors.MAIN_COLOR,
                      child: RaisedButton(
                        onPressed: () {
                          // countryBloc.getCities(signInBloc.getCountryCode().toString());

                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return SignInScreen();
                            }),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(
                                  left:
                                      MediaQuery.of(context).size.width * 0.04),
                              child: Text(
                                "Login",
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
                                  right:
                                      MediaQuery.of(context).size.width * 0.04),
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
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.width * 0.05),
                    child: InkWell(
                        onTap: () {
                          phoneBloc.resetPhone();
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return SignUpScreen();
                            }),
                          );
                        },
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Align(
                            alignment: Alignment.centerLeft,
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
                        )),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 6),
              child: Image.asset("assets/images/home_indicator.png"),
            ),
          ],
        ),
      ),
    );
  }
}
