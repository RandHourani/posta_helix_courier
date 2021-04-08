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
import 'package:posta_courier/src/utils/util.dart';

import '../pod_dialog.dart';

class PickedUpItemSheet extends StatelessWidget {
  String shipmentCase;

  PickedUpItemSheet({this.shipmentCase});

  @override
  Widget build(BuildContext context) {
    unsuccessfulOrderBloc.unsuccessfulReasons("UNSUCCESSFUL_PICKUP");

    return SizedBox.expand(
      child: DraggableScrollableSheet(
        maxChildSize: MediaQuery.of(context).size.height < 650 ? 0.55 : 0.5,
        minChildSize: MediaQuery.of(context).size.height < 650 ? 0.25 : 0.21,
        initialChildSize:
            MediaQuery.of(context).size.height < 650 ? 0.25 : 0.21,
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
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 2, top: 8),
          width: MediaQuery.of(context).size.width,
          // height: MediaQuery.of(context).size.height <= 650
          //     ? MediaQuery.of(context).size.height / 4.3
          //     : MediaQuery.of(context).size.height / 4.7,
          child: StreamBuilder(
            stream: orderBloc.ride,
            builder: (BuildContext context, AsyncSnapshot<RideModel> snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Text(
                          snapshot.data.data.bookings[orderBloc.getOrderIndex()]
                              .passengerName,
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
                          top: 15, bottom: 7, left: 40, right: 40),
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
                                        Utils.launchWhatsApp(
                                            phone: snapshot
                                                .data
                                                .data
                                                .bookings[
                                                    orderBloc.getOrderIndex()]
                                                .shipperContactInfo
                                                .phoneNumber);
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
                                        Utils.phoneLaunch(snapshot
                                            .data
                                            .data
                                            .bookings[orderBloc.getOrderIndex()]
                                            .shipperContactInfo
                                            .phoneNumber);
                                      },
                                      child: Container(
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
                                        Utils.mapLaunch(
                                            snapshot
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
            dashLength: 7,
            dashColor: AppColors.LIGHT_GREY),
        Container(
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: [
              Container(
                height: 90,
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
                margin: EdgeInsets.only(bottom: 15),
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
                                    .bookings[orderBloc.getOrderIndex()]
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
                                    .bookings[orderBloc.getOrderIndex()]
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
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 50,
              width: 120,
              margin: EdgeInsets.only(right: 10),
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                elevation: 3,
                color: Colors.white,
                onPressed: () {
                  showDialog<void>(
                      context: context,
                      barrierDismissible: false,
                      // user must tap button!
                      builder: (BuildContext context) {
                        return UnsuccessfulScreen(
                          type: "UNSUCCESSFUL_PICKUP",
                          orderId: orderBloc.getOrderId(),
                        );
                      });
                },
                child: Text(
                  "Cancel",
                  style: TextStyle(
                      fontFamily: FontFamilies.POPPINS,
                      fontSize:
                          (MediaQuery.of(context).size.width * 0.008) + 11,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
            Container(
              height: 50,
              width: 160,
              child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  elevation: 3,
                  color: AppColors.MAIN_COLOR,
                  onPressed: () {
                    if (shipmentCase == "ROUND_TRIP") {
                      orderBloc.setOrderSheet("GO_TO_NEW_LOCATION");
                    }
                    showDialog(
                        context: context,
                        builder: (_) => PodScreen(
                              screen: shipmentCase,
                            ));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.02),
                        child: Text(
                          "Picked Up Item",
                          style: TextStyle(
                              fontFamily: FontFamilies.POPPINS,
                              fontSize:
                                  (MediaQuery.of(context).size.width * 0.008) +
                                      11,
                              color: Colors.white,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  )),
            ),
          ],
        )
      ],
    );
  }
}
