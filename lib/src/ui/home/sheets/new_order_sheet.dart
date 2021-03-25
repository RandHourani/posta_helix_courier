import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:posta_courier/models/registered_captain_model.dart';
import 'package:posta_courier/models/ride_model.dart';
import 'package:posta_courier/src/blocs/home_blocs/approved_captain_bloc.dart';
import 'package:posta_courier/src/constants/application_colors_value.dart';
import 'package:posta_courier/src/constants/fonts_size.dart';
import 'package:posta_courier/src/blocs/home_blocs/order_bloc.dart';
import 'package:posta_courier/src/ui/widgets/timer.dart';
import 'package:posta_courier/src/ui/widgets/unsuccessful_dialog_screen.dart';
import 'package:posta_courier/src/utils/util.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:intl/intl.dart';
import 'package:posta_courier/src/blocs/signIn_and_createAccount_blocs/get_captain_data_bloc.dart';

import 'finding_order_sheet.dart';

class NewOrderSuggestionSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: checkCaptainDataBloc.suggestion,
        builder:
            (BuildContext context, AsyncSnapshot<ActiveSuggestion> snapshot) {
          return StreamBuilder(
            stream: orderBloc.timer,
            builder: (BuildContext context, AsyncSnapshot<int> snap) {
              if (snap.hasData) {
                Future.delayed(Duration(seconds: 60), () {
                  orderBloc.setOrderSheet("NULL");
                  checkCaptainDataBloc.resetSuggestion();
                });
                if (snapshot.hasData) {
                  return SizedBox.expand(
                    child: DraggableScrollableSheet(
                      maxChildSize: MediaQuery.of(context).size.height < 600
                          ? 0.67
                          : 0.78,
                      minChildSize: 0.07,
                      initialChildSize: MediaQuery.of(context).size.height < 600
                          ? 0.67
                          : 0.78,
                      builder: (BuildContext context,
                          ScrollController scrollController) {
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
                            child: container(context, snapshot.data));
                      },
                    ),
                  );
                } else {
                  return Container();
                }
              } else {
                Future.delayed(Duration(seconds: snap.data), () {
                  orderBloc.setOrderSheet("NULL");
                  checkCaptainDataBloc.resetSuggestion();
                });
                if (snapshot.hasData) {
                  return SizedBox.expand(
                    child: DraggableScrollableSheet(
                      maxChildSize: MediaQuery.of(context).size.height < 600
                          ? 0.67
                          : 0.78,
                      minChildSize: 0.07,
                      initialChildSize: MediaQuery.of(context).size.height < 600
                          ? 0.67
                          : 0.78,
                      builder: (BuildContext context,
                          ScrollController scrollController) {
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
                            child: container(context, snapshot.data));
                      },
                    ),
                  );
                } else {
                  return Container();
                }
              }
            },
          );
        });
  }

  container(context, ActiveSuggestion snapshot) {
    return Column(
      children: [
        Container(height: 20, child: TimerWidgetOrder()),
        Padding(
            padding: EdgeInsets.only(top: 20),
            child: Text(
              "You Have a New Order",
              style: TextStyle(
                  color: AppColors.TITLE_TEXT_COLOR,
                  fontFamily: FontFamilies.POPPINS,
                  fontSize: (MediaQuery.of(context).size.width * 0.04) + 6,
                  fontWeight: FontWeight.w700),
            )),
        Padding(
          padding: EdgeInsets.only(top: 10, bottom: 12),
          child: Text(
            snapshot.booking.service.name,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: AppColors.MAIN_COLOR,
              fontFamily: FontFamilies.POPPINS,
              fontSize: (MediaQuery
                  .of(context)
                  .size
                  .height * 0.018) + 2,
            ),
          ),
        ),
        Dash(
            direction: Axis.horizontal,
            length: MediaQuery.of(context).size.width - 66,
            dashLength: 7,
            dashColor: AppColors.LIGHT_GREY),
        Container(
          padding: EdgeInsets.only(bottom: 4),
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.only(top: 5, bottom: 5),
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
                margin: EdgeInsets.only(top: 5, bottom: 5),
                width: MediaQuery.of(context).size.width / 1.45,
                padding: EdgeInsets.only(left: 3, top: 8, bottom: 8),
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
                      width: MediaQuery.of(context).size.width / 1.45,
                      child: Text(
                        snapshot
                            .booking.pickupLocationName,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: AppColors.TITLE_TEXT_COLOR,
                          fontFamily: FontFamilies.POPPINS,
                          fontSize:
                          (MediaQuery
                              .of(context)
                              .size
                              .height * 0.018) + 2,
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.45,
                      child: Text(
                        snapshot.booking
                            .pickupLocationDetails,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: AppColors.dialogStatusBar,
                          fontFamily: FontFamilies.POPPINS,
                          fontSize:
                              (MediaQuery.of(context).size.height * 0.015),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        Dash(
            direction: Axis.horizontal,
            length: MediaQuery.of(context).size.width - 66,
            dashLength: 7,
            dashColor: AppColors.LIGHT_GREY),
        Container(
          padding: EdgeInsets.only(bottom: 4),
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.only(top: 5, bottom: 5),
                width: MediaQuery.of(context).size.width / 8.6,
                child: Align(
                  alignment: Alignment.center,
                  child: SvgPicture.asset(
                    "assets/images/delivery_pin.svg",
                    width: 25,
                    height: 25,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 5, bottom: 5),
                width: MediaQuery.of(context).size.width / 1.45,
                padding: EdgeInsets.only(left: 3, top: 8, bottom: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Delivery Location",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: AppColors.LIGHT_GREY,
                        fontFamily: FontFamilies.POPPINS,
                        fontSize: (MediaQuery.of(context).size.height * 0.017),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.45,
                      child: Text(
                        snapshot
                            .booking.pullDownLocationName,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: AppColors.TITLE_TEXT_COLOR,
                          fontFamily: FontFamilies.POPPINS,
                          fontSize:
                          (MediaQuery
                              .of(context)
                              .size
                              .height * 0.018) + 2,
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.45,
                      child: Text(
                        snapshot.booking
                            .pullDownLocationDetails,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: AppColors.dialogStatusBar,
                          fontFamily: FontFamilies.POPPINS,
                          fontSize:
                              (MediaQuery.of(context).size.height * 0.015),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        Dash(
            direction: Axis.horizontal,
            length: MediaQuery.of(context).size.width - 66,
            dashLength: 7,
            dashColor: AppColors.LIGHT_GREY),
        Container(
          height: 80,
          padding: EdgeInsets.only(bottom: 4),
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.only(top: 5, bottom: 5),
                height: 80,
                width: MediaQuery.of(context).size.width / 9,
              ),
              Container(
                  height: 80,
                  margin: EdgeInsets.only(top: 5, bottom: 5),
                  width: MediaQuery.of(context).size.width / 1.45,
                  padding:
                      EdgeInsets.only(left: 3, top: 8, bottom: 8, right: 20),
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
                          Text(
                            Utils.timeFormat1(snapshot
                                .booking.dateTime)
                                .toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: AppColors.COMPLETED_INFO_BOX,
                              fontFamily: FontFamilies.POPPINS,
                              fontSize:
                                  (MediaQuery.of(context).size.height * 0.018) +
                                      2,
                            ),
                          ),
                        ],
                      ),
                      SvgPicture.asset(
                        "assets/images/car.svg",
                        width: 25,
                        height: 25,
                      )
                    ],
                  ))
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 50,
              width: 110,
              margin: EdgeInsets.only(right: 10),
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                elevation: 3,
                color: Colors.white,
                onPressed: () {
                  orderBloc.rejectOrderSuggestion(
                      snapshot.booking.id);
                  orderBloc.setOrderSheet("NULL");
                  checkCaptainDataBloc.resetSuggestion();
                },
                child: Text(
                  "Reject",
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
              width: 150,
              child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  elevation: 3,
                  color: AppColors.MAIN_COLOR,
                  onPressed: () {
                    orderBloc.acceptOrderSuggestion(
                        snapshot.booking.id);
                    orderBloc.setOrderSheet("NULL");
                    checkCaptainDataBloc.resetSuggestion();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.04),
                        child: Text(
                          "Accept",
                          style: TextStyle(
                              fontFamily: FontFamilies.POPPINS,
                              fontSize:
                                  (MediaQuery.of(context).size.width * 0.008) +
                                      11,
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
                          size:
                              (MediaQuery.of(context).size.width * 0.008) + 18,
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

  calculateTime(String value) {
    final DateFormat displayFormater = DateFormat('yyyy-MM-dd HH:mm:ss');
    final DateFormat serverFormater = DateFormat('yyyy-MM-dd');
    final DateTime displayDate = displayFormater.parse(value);
    final date2 = DateTime.now();
    final day = date2.difference(displayDate).inDays;
    print(day);
    final hours = date2.difference(displayDate).inHours;
    final mints = date2.difference(displayDate).inMinutes;
    final seconds = date2.difference(displayDate).inSeconds;
    final millSeconds = date2.difference(displayDate).inMilliseconds;
    print(hours);
    var timeAgo;
    if (day >= 1) {
      timeAgo = new DateTime.now().subtract(new Duration(days: day));
    }
    if (hours >= 1 && hours < 24) {
      timeAgo = new DateTime.now().subtract(new Duration(hours: hours));
    }
    if (mints >= 1 && mints < 60) {
      timeAgo = new DateTime.now().subtract(new Duration(minutes: mints));
    }

    if (seconds >= 1 && seconds < 60) {
      timeAgo = new DateTime.now().subtract(new Duration(seconds: seconds));
    }

    if (millSeconds >= 1 && millSeconds < 60) {
      timeAgo =
          new DateTime.now().subtract(new Duration(milliseconds: millSeconds));
    }

    return timeAgo.toString();
  }
}
