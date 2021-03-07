import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:posta_courier/models/booking_action_model.dart';
import 'package:posta_courier/models/ride_model.dart';
import 'package:posta_courier/src/blocs/home_blocs/approved_captain_bloc.dart';
import 'package:posta_courier/src/blocs/home_blocs/order_bloc.dart';
import 'package:posta_courier/src/blocs/home_blocs/payment_bloc.dart';
import 'package:posta_courier/src/constants/application_colors_value.dart';
import 'package:posta_courier/src/constants/fonts_size.dart';
import 'package:posta_courier/src/ui/widgets/numeric_keyboard_widget.dart';
import 'package:posta_courier/src/utils/util.dart';
import 'package:posta_courier/src/ui/widgets/dialog_loading.dart';



class Item {
  final String name;
  final Icon icon;

  const Item(this.name, this.icon);

  int get hashCode => icon.hashCode;

  bool operator ==(Object other) => other is Item && other.icon == icon;
}

class PaymentScreen extends StatelessWidget {
  String shipmentCase;

  PaymentScreen({this.shipmentCase});
  List<Item> payment = [
    const Item(
        'cash',
        Icon(
          Icons.monetization_on,
          size: 15,
        )),
    const Item('wallet', Icon(Icons.account_balance_wallet)),
  ];
  Item selectedItem;

  @override
  Widget build(BuildContext context) {
    selectedItem = payment[0];
    FlutterStatusbarcolor.setStatusBarColor(Colors.white);
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return Scaffold(
      body: SingleChildScrollView(
        child:  Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 60, right: 20, left: 30, bottom: 40),
              child: StreamBuilder(
                stream: orderBloc.ride,
                builder:
                    (BuildContext context, AsyncSnapshot<RideModel> snapshot) {
                  if (snapshot.hasData) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(snapshot.data.data
                            .bookings[orderBloc.getOrderIndex()].passengerName,
                          style: TextStyle(
                              color: AppColors.TITLE_TEXT_COLOR,
                              fontFamily: FontFamilies.POPPINS,
                              fontSize: (MediaQuery.of(context).size.width * 0.04) + 6,
                              fontWeight: FontWeight.w700),),
                        Text(Utils.dateTimeFormat1(snapshot.data.data
                            .bookings[orderBloc.getOrderIndex()].dateTime))
                      ],
                    );
                  } else {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          " ",
                          style: TextStyle(
                              color: AppColors.TITLE_TEXT_COLOR,
                              fontFamily: FontFamilies.POPPINS,
                              fontSize:
                              (MediaQuery.of(context).size.width * 0.04) +
                                  4,
                              fontWeight: FontWeight.w700),
                        ),
                        Text(
                          " ",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: AppColors.TITLE_TEXT_COLOR,
                            fontSize:
                            (MediaQuery.of(context).size.height * 0.017) +
                                2,
                          ),
                        )
                      ],
                    );
                  }
                },
              ),
            ),
            Container(
              height: 90,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(right: 10, left: 10),
              color: Color(0xffF8F8F8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  StreamBuilder(
                      stream: orderBloc.bookingPrice,
                      builder: (BuildContext context,
                          AsyncSnapshot<BookingAction> snapshot) {
                        if (snapshot.hasData) {
                          return Text(
                            snapshot.data.data.price.toString() +
                                snapshot.data.data.currencyCode.toString(),
                            style: TextStyle(
                              color: AppColors.TITLE_TEXT_COLOR,
                              fontFamily: FontFamilies.POPPINS,
                              fontSize: 24,
                            ),
                          );
                        } else {
                          return Text(
                            "",
                            style: TextStyle(
                              color: AppColors.TITLE_TEXT_COLOR,
                              fontFamily: FontFamilies.POPPINS,
                              fontSize: 24,
                            ),
                          );
                        }
                      }),
                  Padding(
                    padding: EdgeInsets.only(top: 2),
                  ),
                  Text(
                    "Order Cost",
                    style: TextStyle(
                      color: AppColors.TITLE_TEXT_COLOR,
                      fontFamily: FontFamilies.POPPINS,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      height: 90,
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.only(right: 10, left: 10),
                      color: Color(0xff2CB2A6),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          StreamBuilder(
                              stream: orderBloc.bookingPrice,
                              builder: (BuildContext context,
                                  AsyncSnapshot<BookingAction> snapshot) {
                                if (snapshot.hasData) {
                                  return Text(
                                    snapshot.data.data.cashOnDelivery.toString() +
                                        snapshot.data.data.currencyCode.toString(),
                                    style: TextStyle(
                                      color: AppColors.TITLE_TEXT_COLOR,
                                      fontFamily: FontFamilies.POPPINS,
                                      fontSize: 24,
                                    ),
                                  );
                                } else {
                                  return Text(
                                    "",
                                    style: TextStyle(
                                      color: AppColors.TITLE_TEXT_COLOR,
                                      fontFamily: FontFamilies.POPPINS,
                                      fontSize: 24,
                                    ),
                                  );
                                }
                              }),
                          Padding(
                            padding: EdgeInsets.only(top: 2),
                          ),
                          Text(
                            "As Delivery Fees",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: FontFamilies.POPPINS,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 90,
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.only(right: 10, left: 10),
                      color: Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SafeArea(
                            child: Align(
                              alignment: Alignment.topCenter,
                              child:    StreamBuilder(
                                  stream: orderBloc.bookingPrice,
                                  builder: (BuildContext context,
                                      AsyncSnapshot<BookingAction> snapshot) {
                                    if (snapshot.hasData) {
                                      return Text(
                                        snapshot.data.data.finalPrice.toString() +
                                            snapshot.data.data.currencyCode.toString(),
                                        style: TextStyle(
                                          color: AppColors.TITLE_TEXT_COLOR,
                                          fontFamily: FontFamilies.POPPINS,
                                          fontSize: 24,
                                        ),
                                      );
                                    } else {
                                      return Text(
                                        "",
                                        style: TextStyle(
                                          color: AppColors.TITLE_TEXT_COLOR,
                                          fontFamily: FontFamilies.POPPINS,
                                          fontSize: 24,
                                        ),
                                      );
                                    }
                                  }),
                            ),
                          ),
                          Text(
                            "Total Cost",
                            style: TextStyle(
                              color: AppColors.TITLE_TEXT_COLOR,
                              fontFamily: FontFamilies.POPPINS,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SvgPicture.asset("assets/images/payment_icon.svg"),
              ],
            ),
            Container(
              height: 100,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(top: 20, right: 20, left: 10),
              color: Color(0xffEFEFEF),
              child: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Cash Received",
                      style: TextStyle(
                        color: AppColors.PAYMENT_COLOR,
                        fontFamily: FontFamilies.POPPINS,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Container(
                      alignment: Alignment.centerRight,
                      margin: EdgeInsets.only(top: 5),
                      child: StreamBuilder(
                        stream: paymentBloc.payPrice,
                        builder: (BuildContext context,
                            AsyncSnapshot<String> snapshot) {
                          if (snapshot.hasData) {
                            return Text(
                              snapshot.data,
                              style: TextStyle(
                                color: AppColors.TITLE_TEXT_COLOR,
                                fontFamily: FontFamilies.POPPINS,
                                fontSize: 25,
                              ),
                            );
                          } else {
                            return Text(
                              " ",
                              style: TextStyle(
                                color: AppColors.TITLE_TEXT_COLOR,
                                fontFamily: FontFamilies.POPPINS,
                                fontSize: 25,
                              ),
                            );
                          }
                        },
                      )),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 10),
              width: MediaQuery.of(context).size.width,
              color: AppColors.KEYBOARD_BACKGROUND,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Divider(
                    thickness: 0.8,
                    color: Color(0xffC4C1C1),
                  ),
                  NumericKeyboardWidget(
                    screen: "PAYMENT",
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
                      top: MediaQuery.of(context).size.width * 0.05,
                      bottom: MediaQuery.of(context).size.width * 0.05,
                      left: MediaQuery.of(context).size.width * 0.06,
                      right: MediaQuery.of(context).size.width * 0.06,
                    ),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width / 7,
                    child: ButtonTheme(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      buttonColor: AppColors.MAIN_COLOR,
                      child: StreamBuilder(
                        stream: paymentBloc.payPrice,
                        builder: (context, snap) {
                          if (snap.hasData) {
                            return RaisedButton(
                              onPressed: () {


                                shipmentCase == "SHIPPER_PAY"
                                    ? paymentBloc.shipperPay()
                                    : paymentBloc.paid();

                                    _showDialog(context);

                                switch(shipmentCase)
                                {
                                  case  "CASE_1":{
                                    orderBloc.setOrderSheet("NULL");
                                  }break;

                                  case  "FORWARD_ROUND_TRIP":{
                                    orderBloc.getRide(orderBloc.getOrder());

                                  }break;


                                }
                              },
                              child: Text(
                                "Submit Receipt",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: FontFamilies.POPPINS,
                                  fontSize: (MediaQuery.of(context).size.width *
                                      0.008) +
                                      FontSize.BUTTON_FONT_L,
                                  color: Colors.white,
                                ),
                              ),
                            );
                          } else {
                            return RaisedButton(
                              onPressed: () {
                                // approvedCaptainBloc.checkUserAuth();
                                // orderBloc.setOrderSheet("NULL");
                              },
                              child: Text(
                                "Submit Receipt",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: FontFamilies.POPPINS,
                                  fontSize: (MediaQuery.of(context).size.width *
                                      0.008) +
                                      FontSize.BUTTON_FONT_L,
                                  color: Colors.white,
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                  Container(
                    color: AppColors.KEYBOARD_BACKGROUND,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 6),
                      child: Image.asset("assets/images/home_indicator.png"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      )


    );
  }
  Future<void> _showDialog(context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {

        Future.delayed(Duration(seconds: 3), () {

          Navigator.of(context).pop(true);

        });
        return LoadingDialogWidget();
      },
    );
  }

}
