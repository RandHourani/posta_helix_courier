import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbar_manager/flutter_statusbar_manager.dart';
import 'package:flutter_svg/svg.dart';
import 'package:posta_courier/src/constants/application_colors_value.dart';
import 'package:posta_courier/src/constants/fonts_size.dart';
import 'package:posta_courier/models/wallet_model.dart';
import 'package:posta_courier/src/utils/util.dart';
class ViewReceipt extends StatelessWidget {
  TransactionData wallet;
  String currancy;
  ViewReceipt({this.wallet,this.currancy});
  @override
  Widget build(BuildContext context) {
    FlutterStatusbarManager.setHidden(true);

    return Scaffold(
        body: Container(
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(

                    children: <Widget>[
                  Container(
                    height: 150,
                    color: Color(0xfff7e7da),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          // flex: 1,
                          child: Container(
                            margin: EdgeInsets.only(top: 30,),
                            child: Column(
                              children: <Widget>[
                                Text(
                                  "Receipt",
                                  style: TextStyle(
                                    letterSpacing: 0.5,
                                      color: AppColors.TITLE_TEXT_COLOR,
                                      fontFamily: FontFamilies.POPPINS,
                                      fontSize:
                                      (MediaQuery.of(context).size.width * 0.04) +
                                          FontSize.HEADING_FONT,
                                      fontWeight: FontWeight.w700),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Text(
                                   Utils.dateFormat1(wallet.dateTime),
                                    style: TextStyle(
                                        color: Colors.black38,
                                        fontSize: 12,
                                        fontFamily: 'SF Pro Display'),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          // flex: 1,
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 30),
                            transform: Matrix4.translationValues(0, 40, 0),
                            alignment: Alignment.centerRight,
                            child: SvgPicture.asset("assets/images/box.svg",width: 100,height: 100,),
                          ),
                        ),
                      ],
                    ),
                  ),


                  Container(
                    margin: EdgeInsets.only(top: 20, left: 10),
                    padding: EdgeInsets.all(15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Padding(
                                  child: Text(
                                    "Total",
                                    style: TextStyle(
                                        color: AppColors.TITLE_TEXT_COLOR,
                                        fontFamily: FontFamilies.POPPINS,
                                        fontSize:
                                       20,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  padding: EdgeInsets.only(left: 0),
                                ),
                                Padding(
                                  child: Text(
                                    (int.parse(wallet.lastBalance)<0? (int.parse(wallet.lastBalance)/-1):int.parse(wallet.lastBalance)).toString()+" "+currancy,
                                    style: TextStyle(
                                        color: AppColors.TITLE_TEXT_COLOR,
                                        fontFamily: FontFamilies.POPPINS,
                                        fontSize:
                                       20,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  padding: EdgeInsets.only(left: 0, right: 20),
                                )
                              ],
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.only(left: 0, top: 7, right: 17),
                              child: Divider(
                                thickness: 1,
                                color: AppColors.LIGHT_BLUE,
                              ),
                            ),
                            wallet.transactionList.length>1?Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Padding(
                                      child: Text(
                                        wallet.transactionList[1].type,
                                        style: TextStyle(
                                          color: AppColors.LIGHT_GREY,
                                          fontFamily: FontFamilies.POPPINS,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),),
                                      padding: EdgeInsets.only(left: 0, top: 10),
                                    ),
                                    Padding(
                                      child: Text(
                                        wallet.transactionList[1].amount+" "+currancy,
                                        style: TextStyle(
                                          color: AppColors.LIGHT_GREY,
                                          fontFamily: FontFamilies.POPPINS,
                                          fontSize:16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      padding: EdgeInsets.only(
                                          left: 50, right: 20, top: 15),
                                    )
                                  ],
                                ),
                                Padding(
                                  padding:
                                  EdgeInsets.only(left: 0, top: 7, right: 17),
                                  child: Divider(
                                    thickness: 1,
                                    color: AppColors.LIGHT_BLUE,
                                  ),
                                ),
                              ],
                            ):Text(" "),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Padding(
                                  child: Text(
                                    wallet.transactionList[0].type,
                                    style: TextStyle(
                                      color: AppColors.LIGHT_GREY,
                                      fontFamily: FontFamilies.POPPINS,
                                      fontSize:16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  padding: EdgeInsets.only(left: 0, top: 10),
                                ),
                                Padding(
                                  child: Text(
                                    (double.parse( wallet.transactionList[0].amount)<0?(double.parse( wallet.transactionList[0].amount)/-1.0):double.parse( wallet.transactionList[0].amount)).toString()+" "+currancy,
                                    style: TextStyle(
                                      color: AppColors.LIGHT_GREY,
                                      fontFamily: FontFamilies.POPPINS,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  padding: EdgeInsets.only(
                                      left: 50, right: 20, top: 15),
                                )
                              ],
                            ),

                            SizedBox(
                              height: MediaQuery.of(context).size.height/17,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                child: Text(
                                  "Amount Charged",
                                  style: TextStyle(
                                      color: AppColors.TITLE_TEXT_COLOR,
                                      fontFamily: FontFamilies.POPPINS,
                                      fontSize:
                                      20,
                                      fontWeight: FontWeight.w700),
                                ),
                                padding: EdgeInsets.only(left: 0, top: 15),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Padding(
                                      child: Row(
                                        children: <Widget>[
                                          SvgPicture.asset(
                                            "assets/images/cash.svg",
                                            width: 15,
                                            height: 15,
                                            // semanticsLabel: 'A red up arrow'
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(left: 4),
                                            child: Text(
                                              "Cash",
                                              style: TextStyle(
                                                color: AppColors.LIGHT_GREY,
                                                fontFamily: FontFamilies.POPPINS,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      padding: EdgeInsets.only(left: 0),
                                    ),
                                    Padding(
                                      child: Text(int.parse(
                                       wallet.lastBalance)<0?(int.parse(
                                          wallet.lastBalance)/-1).toString():int.parse(
                                          wallet.lastBalance).toString()+" "+currancy,
                                        style: TextStyle(
                                          color: AppColors.LIGHT_GREY,
                                          fontFamily: FontFamilies.POPPINS,
                                          fontSize:16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      padding: EdgeInsets.only(
                                          left: 50, right: 20, top: 0),
                                    )
                                  ],
                                ),
                                padding: EdgeInsets.only(left: 0, top: 6),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ]),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(bottom: 5),
                      child: Text(
                          "Something not right? please call our support team",
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.LIGHT_GREY,
                          fontFamily: FontFamilies.POPPINS,)),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Text(
                        "+965485455877",
                          style: TextStyle(
                            fontSize: 12,

                            color: AppColors.MAIN_COLOR,
                              fontFamily: FontFamilies.POPPINS,

                           ),
                      ),
                    ),
                  ],
                ),
              ],
            )));
  }
}
