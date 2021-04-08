import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:posta_courier/models/ride_model.dart';
import 'package:posta_courier/src/blocs/home_blocs/unsuccessful_order_bloc.dart';
import 'package:posta_courier/src/constants/application_colors_value.dart';
import 'package:posta_courier/src/constants/fonts_size.dart';
import 'package:posta_courier/src/blocs/home_blocs/order_bloc.dart';
import 'package:posta_courier/src/ui/widgets/unsuccessful_dialog_screen.dart';
import 'package:posta_courier/src/ui/home/sheets/ready_to_pick_up_item_sheet.dart';
import 'package:posta_courier/src/utils/util.dart';
class GoToPickUpItemSheet extends StatelessWidget {
String shipmentCase;
GoToPickUpItemSheet({this.shipmentCase});
  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: DraggableScrollableSheet(
        maxChildSize: MediaQuery.of(context).size.height < 650 ? 0.65 : 0.5,
        minChildSize: MediaQuery.of(context).size.height < 650 ? 0.23 : 0.21,
        initialChildSize:
            MediaQuery.of(context).size.height < 650 ? 0.65 : 0.5,
        builder: (BuildContext context, ScrollController scrollController) {
          return Container(
            margin: EdgeInsets.only(right: 27, left: 27),
            width: MediaQuery.of(context).size.width,
            decoration: new BoxDecoration(
              color: Colors.white,
              borderRadius: new BorderRadius.only(
                topLeft: const Radius.circular(15.0),
                topRight: const Radius.circular(15.0),
              ),
            ),
            child: ListView.builder(
              controller: scrollController,
              itemCount: 1,
              itemBuilder: (BuildContext context, int index) {
                return container(context);
              },
            ),
          );
        },
      ),
    );
  }

  container(context) {
    print(MediaQuery.of(context).size.height / 5);
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 8, top: 8),
          width: MediaQuery.of(context).size.width,
          // height: MediaQuery.of(context).size.height <= 650
          //     ? MediaQuery.of(context).size.height / 4.8
          //     : MediaQuery.of(context).size.height / 5.7,
          child: StreamBuilder(
            stream: orderBloc.ride,
            builder: (BuildContext context, AsyncSnapshot<RideModel> snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    Padding(
                        padding: EdgeInsets.only(top: 22),
                        child: Text(
                          snapshot.data.data.bookings[0].passengerName,
                          style: TextStyle(
                              color: AppColors.TITLE_TEXT_COLOR,
                              fontFamily: FontFamilies.POPPINS,
                              fontSize:
                                  (MediaQuery.of(context).size.width * 0.04) +
                                      FontSize.HEADING_FONT,
                              fontWeight: FontWeight.w700),
                        )),
                    Padding(
                      padding: EdgeInsets.only(
                          top: 5, bottom: 7, left: 40, right: 40),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              StreamBuilder(
                                stream: orderBloc.ride,
                                builder: (BuildContext context,
                                    AsyncSnapshot<RideModel> snapshot) {
                                  if (snapshot.hasData) {
                                    return InkWell(
                                      onTap: () {
                                        Utils.launchWhatsApp(phone: snapshot.data.data.bookings[
                                        orderBloc.getOrderIndex()].shipperContactInfo.phoneNumber);

                                      },
                                      child: Container(
                                        margin:
                                        EdgeInsets.only(top: 6, bottom: 0),
                                        width: 48,
                                        height: 48,
                                        child: Container(
                                            child: Image.asset(
                                              "assets/images/whatsapp.png",
                                              width: 40,
                                              height: 40,
                                              // color: AppColors.MAIN_COLOR,
                                            )),
                                      ),
                                    );
                                  } else {
                                    return Container(
                                      margin:
                                      EdgeInsets.only(top: 6, bottom: 0),
                                      width: 48,
                                      height: 48,
                                      child: Container(
                                          child: Image.asset(
                                            "assets/images/whatsapp.png",
                                            width: 40,
                                            height: 40,
                                            // color: AppColors.MAIN_COLOR,
                                          )),
                                    );
                                  }
                                },
                              ),
                              Text(
                                "WhatsApp",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.TITLE_TEXT_COLOR,
                                  fontFamily: FontFamilies.POPPINS,
                                  fontSize:
                                      (MediaQuery.of(context).size.height *
                                          0.013),
                                ),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              StreamBuilder(
                                stream: orderBloc.ride,
                                builder: (BuildContext context,
                                    AsyncSnapshot<RideModel> snapshot) {
                                  if (snapshot.hasData) {
                                    return InkWell(
                                      onTap: () {
                                        Utils.phoneLaunch(snapshot.data.data.bookings[
                                        orderBloc.getOrderIndex()].shipperContactInfo.phoneNumber);

                                      },
                                      child: Container(
                                        margin:
                                        EdgeInsets.only(top: 6, bottom: 0),
                                        width: 50,
                                        height: 50,
                                        child: Container(
                                            child: Image.asset(
                                              "assets/images/call_ii.png",
                                              width: 40,
                                              height: 40,
                                              // color: AppColors.MAIN_COLOR,
                                            )),
                                      ),
                                    );
                                  } else {
                                    return Container(
                                      margin:
                                      EdgeInsets.only(top: 6, bottom: 0),
                                      width: 48,
                                      height: 48,
                                      child: Container(
                                          child: Image.asset(
                                            "assets/images/call_ii.png",
                                            width: 40,
                                            height: 40,
                                            // color: AppColors.MAIN_COLOR,
                                          )),
                                    );
                                  }
                                },
                              ),
                              Text(
                                "Call",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.TITLE_TEXT_COLOR,
                                  fontFamily: FontFamilies.POPPINS,
                                  fontSize:
                                      (MediaQuery.of(context).size.height *
                                          0.013),
                                ),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              StreamBuilder(
                                stream: orderBloc.ride,
                                builder: (BuildContext context,
                                    AsyncSnapshot<RideModel> snapshot) {
                                  if (snapshot.hasData) {
                                    return InkWell(
                                      onTap: () {
                                        Utils.mapLaunch( snapshot
                                            .data
                                            .data
                                            .bookings[
                                        orderBloc.getOrderIndex()]
                                            .pickupLocationPoints
                                            .points[1],
                                            snapshot
                                                .data
                                                .data
                                                .bookings[
                                            orderBloc.getOrderIndex()]
                                                .pickupLocationPoints
                                                .points[0]);

                                      },
                                      child: Container(
                                        margin:
                                            EdgeInsets.only(top: 6, bottom: 0),
                                        width: 48,
                                        height: 48,
                                        child: Container(
                                            child: Image.asset(
                                          "assets/images/direction.png",
                                          width: 40,
                                          height: 40,
                                          // color: AppColors.MAIN_COLOR,
                                        )),
                                      ),
                                    );
                                  } else {
                                    return Container(
                                      margin:
                                          EdgeInsets.only(top: 6, bottom: 0),
                                      width: 48,
                                      height: 48,
                                      child: Container(
                                          child: Image.asset(
                                        "assets/images/direction.png",
                                        width: 40,
                                        height: 40,
                                        // color: AppColors.MAIN_COLOR,
                                      )),
                                    );
                                  }
                                },
                              ),
                              Text(
                                "Direction",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.TITLE_TEXT_COLOR,
                                  fontFamily: FontFamilies.POPPINS,
                                  fontSize:
                                      (MediaQuery.of(context).size.height *
                                          0.013),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              } else {
                return Container();
              }
            },
          ),
        ),
        Dash(
            direction: Axis.horizontal,
            length: MediaQuery.of(context).size.width - 66,
            dashLength: 4,
            dashColor: AppColors.LIGHT_GREY),
        Container(
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: [
              Container(
                height: 70,
                width: MediaQuery.of(context).size.width / 8.6,
                child: Align(
                  alignment: Alignment.center,
                  child: SvgPicture.asset(
                    "assets/images/pick_up_pin.svg",
                    width: 25,
                    height: 25,
                  ),
                ),
              ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Pickup Location",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: AppColors.LIGHT_GREY,
                        fontFamily: FontFamilies.POPPINS,
                        fontSize: (MediaQuery.of(context).size.height * 0.017),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.4,
                      child: StreamBuilder(
                          stream: orderBloc.ride,
                          builder: (BuildContext context,
                              AsyncSnapshot<RideModel> snapshot) {
                            if (snapshot.hasData) {
                              return Text(
                                snapshot
                                    .data
                                    .data
                                    .bookings[0]
                                    .pickupLocationName,
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.TITLE_TEXT_COLOR,
                                  fontFamily: FontFamilies.POPPINS,
                                  fontSize:
                                      (MediaQuery.of(context).size.height *
                                              0.018) +
                                          2,
                                ),
                              );
                            } else {
                              return Container();
                            }
                          }),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.4,
                      child: StreamBuilder(
                          stream: orderBloc.ride,
                          builder: (BuildContext context,
                              AsyncSnapshot<RideModel> snapshot) {
                            if (snapshot.hasData) {
                              return Text(
                                snapshot
                                    .data
                                    .data
                                    .bookings.first
                                    .pickupLocationDetails,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.dialogStatusBar,
                                  fontFamily: FontFamilies.POPPINS,
                                  fontSize:
                                      (MediaQuery.of(context).size.height *
                                          0.015),
                                ),
                              );
                            } else {
                              return Container();
                            }
                          }),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Dash(
            direction: Axis.horizontal,
            length: MediaQuery.of(context).size.width - 66,
            dashLength: 4,
            dashColor: AppColors.LIGHT_GREY),
        Container(
          height: 80,
          padding: EdgeInsets.only(bottom: 4),
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.only(top: 5, bottom: 5),
                height: 75,
                width: MediaQuery.of(context).size.width / 8.6,
              ),
              Container(
                  height: 75,
                  margin: EdgeInsets.only(top: 5, bottom: 5, right: 10),
                  width: MediaQuery.of(context).size.width / 1.5,
                  padding: EdgeInsets.only(
                    left: 3,
                    top: 8,
                    bottom: 8,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Pickup Time",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: AppColors.TEXT_DARK,
                              fontFamily: FontFamilies.POPPINS,
                              fontSize:
                                  (MediaQuery.of(context).size.height * 0.018) +
                                      2,
                            ),
                          ),
                          StreamBuilder(
                              stream: orderBloc.ride,
                              builder: (BuildContext context,
                                  AsyncSnapshot<RideModel> snapshot) {
                                if (snapshot.hasData) {
                                  return Text(
                                    Utils.timeFormat1(snapshot
                                        .data
                                        .data
                                        .bookings[0]
                                        .dateTime),
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.COMPLETED_INFO_BOX,
                                      fontFamily: FontFamilies.POPPINS,
                                      fontSize:
                                          (MediaQuery.of(context).size.height *
                                                  0.018) +
                                              2,
                                    ),
                                  );
                                } else {
                                  return Text(" ");
                                }
                              }),
                        ],
                      ),
                      SvgPicture.asset(
                        "assets/images/car.svg",
                        width: 25,
                        height: 25,
                      ),
                    ],
                  ))
            ],
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width / 7,
          margin: EdgeInsets.only(left: 15, right: 15),
          child: ButtonTheme(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            buttonColor: AppColors.MAIN_COLOR,
            child: RaisedButton(
              elevation: 0,
              onPressed: () {
                orderBloc.bookingAction();



                switch(shipmentCase)
                {
                  case "CASE_1":{ return ReadyToPickUpItemSheet(shipmentCase:shipmentCase);
                  }break;

                  case "CASE_1":{           return ReadyToPickUpItemSheet(shipmentCase: "SHIPPER_PAY");

                  }break;
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.04),
                    child: Text(
                      "Go To Pickup Item",
                      style: TextStyle(
                          fontFamily: FontFamilies.POPPINS,
                          fontSize:
                              (MediaQuery.of(context).size.width * 0.008) + 10,
                          color: Colors.white,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        right: MediaQuery.of(context).size.width * 0.04),
                    child: Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                      size: (MediaQuery.of(context).size.width * 0.008) + 18,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
