import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:posta_courier/models/captain_cars_model.dart';
import 'package:posta_courier/src/blocs/home_blocs/wallet_bloc.dart';
import 'package:posta_courier/src/constants/application_colors_value.dart';
import 'package:posta_courier/src/constants/fonts_size.dart';

class CourierVehicleDetailsScreen extends StatelessWidget {
  CaptainCarsModel data;
  CourierVehicleDetailsScreen({this.data});
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(
    //     SystemUiOverlayStyle(statusBarColor: Colors.transparent));

    // walletBloc.walletAccount();
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background_ii.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Container(
            margin: EdgeInsets.only(
              top: MediaQuery.of(context).size.width / 6,
              left: MediaQuery.of(context).size.width * 0.04,
            ),
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: (MediaQuery.of(context).size.width * 0.04) +
                      FontSize.HEADING_FONT -
                      3,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "   BACK",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: FontFamilies.POPPINS,
                        fontSize: (MediaQuery.of(context).size.width * 0.04) +
                            FontSize.HEADING_FONT -
                            7,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width / 3.1,
            margin: EdgeInsets.only(
                right: MediaQuery.of(context).size.width * 0.05,
                left: MediaQuery.of(context).size.width * 0.05,
                top: MediaQuery.of(context).size.height * 0.07,
                ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 5,
                  offset: Offset(2, 2),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Vehicle Make",
                  style: TextStyle(
                    color: AppColors.TITLE_TEXT_COLOR,
                    fontFamily: FontFamilies.POPPINS,
                    fontSize: (MediaQuery.of(context).size.height * 0.02) + 3,
                  ),
                ),
                Text(
                  data.brand.toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: AppColors.MAIN_COLOR,
                    fontFamily: FontFamilies.POPPINS,
                    fontSize: (MediaQuery.of(context).size.height * 0.02) + 16,
                  ),
                ),
              ],
            ),
          ),

      Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(
                right: MediaQuery.of(context).size.width * 0.05,
                left: MediaQuery.of(context).size.width * 0.07,
                top: 8
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        height:20,
                        margin: EdgeInsets.only(top: 13,bottom: 5),

                        child: Text(
                          "Vehicle Model",
                          style: TextStyle(
                            color: AppColors.TITLE_TEXT_COLOR,
                            fontFamily: FontFamilies.POPPINS,
                            fontSize:
                            (MediaQuery.of(context).size.height * 0.02),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        // padding: EdgeInsets.only(left: 0, top:0),
                      ),
                      Container(
                        height:20,
                        margin: EdgeInsets.only(top: 13,bottom: 5,right: 20,),
                        child: Text(
                          data.model.toString(),
                          style: TextStyle(
                            color: AppColors.LIGHT_GREY,
                            fontFamily: FontFamilies.POPPINS,
                            fontSize:
                            (MediaQuery.of(context).size.height * 0.02),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        // padding: EdgeInsets.only(left: 50, right: 20, top: 8),
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 0, top: 0, right: 17),
                    child: Divider(
                      thickness: 1,
                      color: AppColors.LIGHT_BLUE,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        height:20,
                        margin: EdgeInsets.only(top: 13,bottom: 5),

                        child: Text(
                          "Vehicle Color",
                          style: TextStyle(
                            color: AppColors.TITLE_TEXT_COLOR,
                            fontFamily: FontFamilies.POPPINS,
                            fontSize:
                            (MediaQuery.of(context).size.height * 0.02),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        // padding: EdgeInsets.only(left: 0, top:0),
                      ),
                      Container(
                        height:20,
                        margin: EdgeInsets.only(top: 13,bottom: 5,right: 20,),
                        child: Text(
                          data.color.toString(),
                          style: TextStyle(
                            color: AppColors.LIGHT_GREY,
                            fontFamily: FontFamilies.POPPINS,
                            fontSize:
                            (MediaQuery.of(context).size.height * 0.02),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        // padding: EdgeInsets.only(left: 50, right: 20, top: 8),
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 0, top: 0, right: 17),
                    child: Divider(
                      thickness: 1,
                      color: AppColors.LIGHT_BLUE,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        height:20,
                        margin: EdgeInsets.only(top: 13,bottom: 5),

                        child: Text(
                          "Vehicle State",
                          style: TextStyle(
                            color: AppColors.TITLE_TEXT_COLOR,
                            fontFamily: FontFamilies.POPPINS,
                            fontSize:
                            (MediaQuery.of(context).size.height * 0.02),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        // padding: EdgeInsets.only(left: 0, top:0),
                      ),
                      Container(
                        height:20,
                        margin: EdgeInsets.only(top: 13,bottom: 5,right: 20,),
                        child: Text(
                          data.city.nameEN.toString(),
                          style: TextStyle(
                            color: AppColors.LIGHT_GREY,
                            fontFamily: FontFamilies.POPPINS,
                            fontSize:
                            (MediaQuery.of(context).size.height * 0.02),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        // padding: EdgeInsets.only(left: 50, right: 20, top: 8),
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 0, top: 0, right: 17),
                    child: Divider(
                      thickness: 1,
                      color: AppColors.LIGHT_BLUE,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        height:20,
                        margin: EdgeInsets.only(top: 13,bottom: 5),

                        child: Text(
                          "Vehicle Manufacture Year",
                          style: TextStyle(
                            color: AppColors.TITLE_TEXT_COLOR,
                            fontFamily: FontFamilies.POPPINS,
                            fontSize:
                            (MediaQuery.of(context).size.height * 0.02),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        // padding: EdgeInsets.only(left: 0, top:0),
                      ),
                      Container(
                        height:20,
                        margin: EdgeInsets.only(top: 13,bottom: 5,right: 20,),
                        child: Text(
                          data.carManufacturingYear.toString(),
                          style: TextStyle(
                            color: AppColors.LIGHT_GREY,
                            fontFamily: FontFamilies.POPPINS,
                            fontSize:
                            (MediaQuery.of(context).size.height * 0.02),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        // padding: EdgeInsets.only(left: 50, right: 20, top: 8),
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 0, top: 0, right: 17),
                    child: Divider(
                      thickness: 1,
                      color: AppColors.LIGHT_BLUE,
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        height:20,
                        margin: EdgeInsets.only(top: 13,bottom: 5),

                        child: Text(
                          "Plate Number",
                          style: TextStyle(
                            color: AppColors.TITLE_TEXT_COLOR,
                            fontFamily: FontFamilies.POPPINS,
                            fontSize:
                            (MediaQuery.of(context).size.height * 0.02),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        // padding: EdgeInsets.only(left: 0, top:0),
                      ),
                      Container(
                        height:20,
                        margin: EdgeInsets.only(top: 13,bottom: 5,right: 20,),
                        child: Text(
                          data.carNumber.toString(),
                          style: TextStyle(
                            color: AppColors.LIGHT_GREY,
                            fontFamily: FontFamilies.POPPINS,
                            fontSize:
                            (MediaQuery.of(context).size.height * 0.02),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        // padding: EdgeInsets.only(left: 50, right: 20, top: 8),
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 0, top: 0, right: 17),
                    child: Divider(
                      thickness: 1,
                      color: AppColors.LIGHT_BLUE,
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        height:20,
                        margin: EdgeInsets.only(top: 13,bottom: 5),

                        child: Text(
                          "Registration Expiry Date ",
                          style: TextStyle(
                            color: AppColors.TITLE_TEXT_COLOR,
                            fontFamily: FontFamilies.POPPINS,
                            fontSize:
                            (MediaQuery.of(context).size.height * 0.02),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        // padding: EdgeInsets.only(left: 0, top:0),
                      ),
                      Container(
                        height:20,
                        margin: EdgeInsets.only(top: 13,bottom: 5,right: 20,),
                        child: Text(
                          data.insuranceExpiredDate.toString(),
                          style: TextStyle(
                            color: AppColors.LIGHT_GREY,
                            fontFamily: FontFamilies.POPPINS,
                            fontSize:
                            (MediaQuery.of(context).size.height * 0.02),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        // padding: EdgeInsets.only(left: 50, right: 20, top: 8),
                      )
                    ],
                  ),

                ],
              ),
            ) ,


        ]),
      ),
    );
  }
}
