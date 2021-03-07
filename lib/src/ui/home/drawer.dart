import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:posta_courier/src/blocs/home_blocs/approved_captain_bloc.dart';
import 'package:posta_courier/src/blocs/signIn_and_createAccount_blocs/signIn_bloc.dart';
import 'package:posta_courier/src/blocs/signIn_and_createAccount_blocs/get_captain_data_bloc.dart';
import 'package:posta_courier/src/blocs/signIn_and_createAccount_blocs/sign_up_bloc.dart';
import 'package:posta_courier/src/blocs/home_blocs/report_problem_bloc.dart';
import 'package:posta_courier/src/constants/application_colors_value.dart';
import 'package:posta_courier/src/constants/fonts_size.dart';
import 'package:posta_courier/src/ui/home/side_menu_screens/profile_screen.dart';
import 'package:posta_courier/src/ui/home/side_menu_screens/report_problem_screen.dart';
import 'package:posta_courier/src/ui/home/side_menu_screens/wallet_screen.dart';
import 'package:posta_courier/src/ui/home/side_menu_screens/weekly_report_screen.dart';
import 'package:posta_courier/src/ui/home/side_menu_screens/notification_screen.dart';
import 'package:posta_courier/src/ui/signIn_and_createAccount_screens/welcome_screen.dart';
import 'package:posta_courier/src/constants/constants.dart';

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    approvedCaptainBloc.checkUserAuth();

    return new SizedBox(
      width: MediaQuery.of(context).size.width * 0.77,
      child: Drawer(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            ListTile(
              title: Container(
                margin: EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    StreamBuilder(
                        stream: approvedCaptainBloc.profileImg,
                        builder: (BuildContext context,
                            AsyncSnapshot<String> snapshot) {
                          if (snapshot.hasData) {
                            return Container(
                                // margin: EdgeInsets.only(top: 110),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                width: 50,
                                height: 50,
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(25.0),
                                    child: FadeInImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          Constants.MAIN_URL_FOR_DOCUMENTS +
                                              snapshot.data),
                                      placeholder: AssetImage(
                                          "assets/images/profile.png"),
                                    )));
                          } else {
                            return SvgPicture.asset("assets/images/user.svg");
                          }
                        }),
                    Container(
                      margin: EdgeInsets.only(left: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            getDateTime().toString(),
                            style: TextStyle(
                                fontFamily: FontFamilies.POPPINS,
                                color: AppColors.TITLE_TEXT_COLOR,
                                fontSize: 13),
                            textAlign: TextAlign.left,
                          ),
                          StreamBuilder(
                            stream: checkCaptainDataBloc.fullName,
                            builder: (BuildContext context,
                                AsyncSnapshot<String> snapshot) {
                              return Text(
                                snapshot.data,
                                style: TextStyle(
                                    fontFamily: FontFamilies.POPPINS,
                                    color: AppColors.TITLE_TEXT_COLOR,
                                    fontSize: 20),
                                textAlign: TextAlign.left,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              onTap: () => {},
            ),
            Divider(
              thickness: 0.5,
              color: AppColors.LIGHT_GREY,
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(top: 0, left: 20),
                child: ListView(children: <Widget>[
                  ListTile(
                    title: Text(
                      'My Account',
                      style: TextStyle(
                          fontSize: FontSize.TITLE_FONT + 2,
                          fontFamily: FontFamilies.POPPINS,
                          color: AppColors.TITLE_TEXT_COLOR),
                    ),
                    // onTap: () =>{
                    //
                    //   Navigator.push(
                    //     context,
                    //     MaterialPageRoute(builder: (context) {
                    //       return ProfileScreen();
                    //     }),
                    //   )
                    // },
                    onTap: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return (ProfileScreen());
                        }),
                      ),
                    },
                  ),
                  ListTile(
                    title: Text(
                      'Weekly Statement',
                      style: TextStyle(
                          fontSize: FontSize.TITLE_FONT + 2,
                          fontFamily: FontFamilies.POPPINS,
                          color: AppColors.TITLE_TEXT_COLOR),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return (WeeklyReportScreen());
                        }),
                      );
                    },
                  ),
                  ListTile(
                    title: Text(
                      'Wallet',
                      style: TextStyle(
                          fontSize: FontSize.TITLE_FONT + 2,
                          fontFamily: FontFamilies.POPPINS,
                          color: AppColors.TITLE_TEXT_COLOR),
                    ),
                    onTap: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return (WalletScreen());
                        }),
                      ),
                    },
                  ),
                  ListTile(
                    title: Text(
                      'Notifications',
                      style: TextStyle(
                          fontSize: FontSize.TITLE_FONT + 2,
                          fontFamily: FontFamilies.POPPINS,
                          color: AppColors.TITLE_TEXT_COLOR),
                    ),
                    onTap: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return (NotificationScreen());
                        }),
                      ),
                    },
                  ),
                  ListTile(
                    title: Text(
                      'Report a Problem',
                      style: TextStyle(
                          fontSize: FontSize.TITLE_FONT + 2,
                          fontFamily: FontFamilies.POPPINS,
                          color: AppColors.TITLE_TEXT_COLOR),
                    ),
                    onTap: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return (ReportProblem());
                        }),
                      ),
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  ListTile(
                    title: Text(
                      'Logout',
                      style: TextStyle(
                          fontSize: FontSize.TITLE_FONT + 2,
                          fontFamily: FontFamilies.POPPINS,
                          color: AppColors.MAIN_COLOR),
                    ),
                    onTap: () {
                      approvedCaptainBloc.logout();
                      signInBloc.resetCountry();
                      phoneBloc.resetCountry();
                      // signInBloc.resetUser();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return (WelcomeScreen());
                        }),
                      );
                    },
                  ),
                ]),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 15, bottom: 17),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  "version 4.0.0",
                  style: TextStyle(
                      fontSize: 10,
                      fontFamily: FontFamilies.POPPINS,
                      color: AppColors.LIGHT_GREY),
                ),
              ),
            ),
            Divider(
              thickness: 0.5,
              color: AppColors.LIGHT_GREY,
            ),
            Container(
              margin: EdgeInsets.only(top: 15, bottom: 17),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  "Copyright © 2020 Posta Helix . All rights reserved",
                  style: TextStyle(
                      fontSize: 10,
                      fontFamily: FontFamilies.POPPINS,
                      color: AppColors.LIGHT_GREY),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  getDateTime() {
    var now = new DateTime.now();

    if (now.hour >= 0 && now.hour <= 11) {
      return "Good Morning";
    } else if (now.hour >= 12 && now.hour <= 17) {
      return "Good Afternoon";
    } else {
      return "Good Evening";
    }
  }
}
