import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:posta_courier/models/order_model.dart';
import 'package:posta_courier/models/registered_captain_model.dart';
import 'package:posta_courier/models/ride_model.dart';
import 'package:posta_courier/src/blocs/home_blocs/approved_captain_bloc.dart';
import 'package:posta_courier/src/blocs/home_blocs/google_map_bloc.dart';
import 'package:posta_courier/src/blocs/home_blocs/online_offline_bloc.dart';
import 'package:posta_courier/src/blocs/home_blocs/order_bloc.dart';
import 'package:posta_courier/src/blocs/signIn_and_createAccount_blocs/get_captain_data_bloc.dart';
import 'package:posta_courier/src/blocs/signIn_and_createAccount_blocs/rout_sceen.dart';
import 'package:posta_courier/src/shipment_cases/case_1.dart';
import 'package:posta_courier/src/shipment_cases/round_trip_case_1.dart';
import 'package:posta_courier/src/ui/home/google_maps/list_of_captain_orders.dart';
import 'package:posta_courier/src/ui/signIn_and_createAccount_screens/signIn_screen.dart';
import 'package:posta_courier/src/ui/widgets/error_going_offline_dialog_screen.dart';
import 'package:posta_courier/src/ui/home/payment/payment_with_cod_sheet.dart';
import 'package:posta_courier/src/ui/home/payment/payment_without_cod_sheet.dart';
import 'package:posta_courier/src/ui/home/sheets/delivered_item_sheet_ii.dart';
import 'package:posta_courier/src/ui/home/sheets/finding_order_sheet.dart';
import 'package:posta_courier/src/ui/home/sheets/go_to_new_location_sheet.dart';
import 'package:posta_courier/src/ui/home/sheets/go_to_pick_up_item_sheet.dart';
import 'package:posta_courier/src/ui/home/sheets/new_order_sheet.dart';
import 'package:posta_courier/src/ui/home/sheets/online_offline_sheet.dart';
import 'package:posta_courier/src/ui/home/google_maps/offline_map.dart';
import 'package:posta_courier/src/ui/home/google_maps/online_map.dart';
import 'package:posta_courier/src/ui/home/sheets/picked_up_item_sheet.dart';
import 'package:posta_courier/src/ui/home/sheets/ready_to_pick_up_item_sheet.dart';
import 'package:posta_courier/src/utils/util.dart';
import '../drawer.dart';
import 'package:flutter/services.dart';
import 'dart:io';

class LifecycleEventHandler extends WidgetsBindingObserver {
  final AsyncCallback resumeCallBack;
  final AsyncCallback suspendingCallBack;

  LifecycleEventHandler({
    this.resumeCallBack,
    this.suspendingCallBack,
  });

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.resumed:
        {
          checkCaptainDataBloc.checkUserAuth();
          checkCaptainDataBloc.checkUserAuth();
          // approvedCaptainBloc.checkUserAuth();
          //   orderBloc.getOrders("NOT_PAID");
        }
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
        print("paused");
        break;

      case AppLifecycleState.detached:
        break;
    }
  }
}

class HomeScreen extends StatelessWidget {
  static const LatLng _center = const LatLng(31.949722, 35.932778);
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  @override
  Widget build(BuildContext context) {
    // googleMapBloc.getUserLocation();
    _firebaseMessaging.getToken().then((token) {
      approvedCaptainBloc.setNotificationToken(token);
    });
    FlutterStatusbarcolor.setStatusBarColor(Colors.white);
    orderBloc.getOrders("NOT_PAID");
    googleMapBloc.getUserLocation();

    WidgetsBinding.instance.addObserver(
        LifecycleEventHandler(resumeCallBack: () async => "resume"));

    GoogleMapController _controller;
    return StreamBuilder(
      stream: screensBloc.screen,
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        return checkAuth(context, snapshot.data);
      },
    );
  }

  checkAuth(context, String status) {
    switch (status) {
      case '/home':
        {
          return home();
        }
        break;

      case '/signIn':
        {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return SignInScreen();
          }));
          // return SignInScreen();
        }
        break;
      default:
        {
          return home();
        }
    }
  }

  WillPopScope home() {
    Utils.setScreen('/home');

    return new WillPopScope(
        onWillPop: () {
          //   // this is the block you need
          Utils.setScreen('/home');
          //
          exit(0);
        },
        child: Scaffold(
          key: _scaffoldKey,
          drawer: NavDrawer(),
          appBar: AppBar(
            centerTitle: true,
            // this is all you need
            leading: InkWell(
              splashColor: Colors.white,
              child: Container(
                margin: EdgeInsets.only(left: 10),
                child: SvgPicture.asset(
                  "assets/images/menu.svg",
                  width: 22,
                  height: 22,
                ),
              ),
              onTap: () => _scaffoldKey.currentState.openDrawer(),
            ),
            leadingWidth: 35.0,
            backgroundColor: Colors.white,
            elevation: 0,
            title: Container(
              child: SvgPicture.asset(
                "assets/images/home_page_logo.svg",
                width: 32,
                height: 32,
              ),
            ),
            actions: <Widget>[
              Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: InkWell(
                    splashColor: Colors.white,
                    onTap: () {
                      checkCaptainDataBloc.checkUserAuth();
                      approvedCaptainBloc.checkUserAuth();
                      orderBloc.getOrders("NOT_PAID");
                    },
                    child: SvgPicture.asset(
                      "assets/images/refresh.svg",
                      width: 22,
                      height: 22,
                    ),
                  )),
            ],
          ),
          body: StreamBuilder(
            stream: orderBloc.order,
            builder: (BuildContext context, AsyncSnapshot<OrderModel> snap) {
              if (snap.hasData) {
                if (snap.data.data.data.isEmpty) {
                  return StreamBuilder(
                    stream: onlineOfflineBloc.captainStatus,
                    builder:
                        (BuildContext context, AsyncSnapshot<bool> snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data) {
                          return Stack(
                            children: [
                              StreamBuilder(
                                  stream: onlineOfflineBloc.captainStatus,
                                  builder: (BuildContext context,
                                      AsyncSnapshot<bool> snapshot) {
                                    if (snapshot.hasData) {
                                      if (snapshot.data) {
                                        return OnlineMap(
                                          locationPoints: _center,
                                        );
                                      } else {
                                        return OfflineMap(
                                          locationPoints: _center,
                                        );
                                      }
                                    } else {
                                      return OfflineMap(
                                        locationPoints: _center,
                                      );
                                    }
                                  }),
                              SafeArea(
                                child: Align(
                                  alignment: Alignment.topCenter,
                                  child: Container(
                                    height: 100,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              "assets/images/rectangle.png"),
                                          fit: BoxFit.fill),
                                    ),
                                  ),
                                ),
                              ),
                              Stack(children: [
                                StreamBuilder(
                                  stream: onlineOfflineBloc.captainStatus,
                                  builder: (BuildContext context,
                                      AsyncSnapshot<bool> snapshot) {
                                    if (snapshot.hasData) {
                                      if (snapshot.data) {
                                        return StreamBuilder(
                                          stream:
                                              onlineOfflineBloc.captainStatus,
                                          builder: (BuildContext context,
                                              AsyncSnapshot<bool> snapshot) {
                                            if (snapshot.hasData) {
                                              return StreamBuilder(
                                                stream: orderBloc.order,
                                                builder: (BuildContext context,
                                                    AsyncSnapshot<OrderModel>
                                                        snapshot) {
                                                  if (snapshot.hasData) {
                                                    if (snapshot.data.data.data
                                                        .isEmpty) {
                                                      return SafeArea(
                                                        child: Align(
                                                            alignment: Alignment
                                                                .bottomRight,
                                                            child: InkWell(
                                                                onTap: () {
                                                                  onlineOfflineBloc
                                                                      .setStatus(
                                                                          false);
                                                                  approvedCaptainBloc
                                                                      .checkCaptainStatus();
                                                                },
                                                                child:
                                                                    Container(
                                                                  margin: EdgeInsets
                                                                      .only(
                                                                          bottom:
                                                                              170,
                                                                          right:
                                                                              30),
                                                                  child:
                                                                      SvgPicture
                                                                          .asset(
                                                                    "assets/images/stop.svg",
                                                                    width: 60,
                                                                    height: 60,
                                                                  ),
                                                                ))),
                                                      );
                                                    } else {
                                                      return SafeArea(
                                                        child: Align(
                                                            alignment: Alignment
                                                                .bottomRight,
                                                            child: InkWell(
                                                                onTap: () {
                                                                  onlineOfflineBloc
                                                                      .setColor(
                                                                          false);
                                                                  return showDialog<
                                                                          void>(
                                                                      context:
                                                                          context,
                                                                      barrierDismissible:
                                                                          false,
                                                                      // user must tap button!
                                                                      builder:
                                                                          (BuildContext
                                                                              context) {
                                                                        return GoingOfflineErrorDialog();
                                                                      });
                                                                },
                                                                child:
                                                                    Container(
                                                                        margin: EdgeInsets.only(
                                                                            bottom:
                                                                                170,
                                                                            right:
                                                                                30),
                                                                        child:
                                                                            StreamBuilder(
                                                                          stream:
                                                                              onlineOfflineBloc.stopColor,
                                                                          builder:
                                                                              (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                                                                            if (snapshot.hasData) {
                                                                              if (snapshot.data) {
                                                                                return SvgPicture.asset(
                                                                                  "assets/images/stop.svg",
                                                                                  width: 60,
                                                                                  height: 60,
                                                                                );
                                                                              } else {
                                                                                return SvgPicture.asset(
                                                                                  "assets/images/error_stoping.svg",
                                                                                  width: 60,
                                                                                  height: 60,
                                                                                );
                                                                              }
                                                                            } else {
                                                                              return SvgPicture.asset(
                                                                                "assets/images/stop.svg",
                                                                                width: 60,
                                                                                height: 60,
                                                                              );
                                                                            }
                                                                          },
                                                                        )))),
                                                      );
                                                    }
                                                  } else {
                                                    return SafeArea(
                                                      child: Align(
                                                          alignment: Alignment
                                                              .bottomRight,
                                                          child: InkWell(
                                                              onTap: () {
                                                                onlineOfflineBloc
                                                                    .setStatus(
                                                                        false);
                                                                onlineOfflineBloc
                                                                    .setStatus(
                                                                        false);
                                                                approvedCaptainBloc
                                                                    .checkCaptainStatus();
                                                              },
                                                              child: Container(
                                                                margin: EdgeInsets
                                                                    .only(
                                                                        bottom:
                                                                            170,
                                                                        right:
                                                                            30),
                                                                child:
                                                                    SvgPicture
                                                                        .asset(
                                                                  "assets/images/stop.svg",
                                                                  width: 60,
                                                                  height: 60,
                                                                ),
                                                              ))),
                                                    );
                                                  }
                                                },
                                              );
                                            } else {
                                              return SafeArea(
                                                child: Align(
                                                    alignment:
                                                        Alignment.bottomRight,
                                                    child: InkWell(
                                                        onTap: () {
                                                          onlineOfflineBloc
                                                              .setStatus(false);
                                                          onlineOfflineBloc
                                                              .setStatus(false);
                                                          approvedCaptainBloc
                                                              .checkCaptainStatus();
                                                        },
                                                        child: Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  bottom: 170,
                                                                  right: 30),
                                                          child:
                                                              SvgPicture.asset(
                                                            "assets/images/stop.svg",
                                                            width: 60,
                                                            height: 60,
                                                          ),
                                                        ))),
                                              );
                                            }
                                          },
                                        );
                                      } else {
                                        return Container();
                                      }
                                    } else {
                                      return Container();
                                    }
                                  },
                                ),
                                StreamBuilder(
                                    stream: onlineOfflineBloc.captainStatus,
                                    builder: (BuildContext context,
                                        AsyncSnapshot<bool> snapshot) {
                                      if (snapshot.hasData) {
                                        if (snapshot.data) {
                                          if (snapshot.data) {
                                            return SafeArea(
                                              child: Align(
                                                  alignment:
                                                      Alignment.bottomCenter,
                                                  child: StreamBuilder(
                                                    stream: checkCaptainDataBloc
                                                        .suggestion,
                                                    builder: (BuildContext
                                                            context,
                                                        AsyncSnapshot<
                                                                ActiveSuggestion>
                                                            snapshot) {
                                                      if (snapshot.hasData) {
                                                        return NewOrderSuggestionSheet();
                                                      } else {
                                                        return StreamBuilder(
                                                          stream: orderBloc
                                                              .orderSheet,
                                                          builder: (BuildContext
                                                                  context,
                                                              AsyncSnapshot<
                                                                      String>
                                                                  snapshot) {
                                                            return StreamBuilder(
                                                              stream: orderBloc
                                                                  .ride,
                                                              builder: (BuildContext
                                                                      context,
                                                                  AsyncSnapshot<
                                                                          RideModel>
                                                                      snapshot) {
                                                                if (snapshot
                                                                    .hasData) {
                                                                  if (snapshot
                                                                      .data
                                                                      .data
                                                                      .bookings
                                                                      .isEmpty) {
                                                                    return FindingOrdersSheet();
                                                                  } else {
                                                                    if (snapshot
                                                                            .data
                                                                            .data
                                                                            .bookings[
                                                                                0]
                                                                            .order
                                                                            .payUpFront &&
                                                                        !snapshot
                                                                            .data
                                                                            .data
                                                                            .bookings[0]
                                                                            .order
                                                                            .roundTrip) {
                                                                      return StreamBuilder(
                                                                        stream:
                                                                            orderBloc.orderSheet,
                                                                        builder: (BuildContext
                                                                                context,
                                                                            AsyncSnapshot<String>
                                                                                snap) {
                                                                          return StandardCase.selectSheetShipperPay(
                                                                              snap.data,
                                                                              context,
                                                                              snapshot.data.data.bookings[0].order.paidUpFront);
                                                                        },
                                                                      );
                                                                    } else if (snapshot
                                                                            .data
                                                                            .data
                                                                            .bookings[
                                                                                0]
                                                                            .order
                                                                            .payUpFront &&
                                                                        snapshot
                                                                            .data
                                                                            .data
                                                                            .bookings[0]
                                                                            .order
                                                                            .roundTrip) {
                                                                      return StreamBuilder(
                                                                        stream:
                                                                            orderBloc.orderSheet,
                                                                        builder: (BuildContext
                                                                                context,
                                                                            AsyncSnapshot<String>
                                                                                snapshots) {
                                                                          return RoundTripCase.selectSheetRoundTripShipperPay(
                                                                              snapshots.data,
                                                                              context,
                                                                              snapshot.data.data.bookings[0].order.status,
                                                                              snapshot.data.data.bookings[0].order.paidUpFront);
                                                                        },
                                                                      );
                                                                    } else if (!snapshot
                                                                            .data
                                                                            .data
                                                                            .bookings[
                                                                                0]
                                                                            .order
                                                                            .payUpFront &&
                                                                        snapshot
                                                                            .data
                                                                            .data
                                                                            .bookings[0]
                                                                            .order
                                                                            .roundTrip) {
                                                                      return StreamBuilder(
                                                                        stream:
                                                                            orderBloc.orderSheet,
                                                                        builder: (BuildContext
                                                                                context,
                                                                            AsyncSnapshot<String>
                                                                                snapshots) {
                                                                          return RoundTripCase.selectSheetRoundTrip(
                                                                              snapshots.data,
                                                                              context,
                                                                              snapshot.data.data.bookings[0].order.status);
                                                                        },
                                                                      );
                                                                    } else if (snapshot
                                                                            .data
                                                                            .data
                                                                            .bookings[0]
                                                                            .order
                                                                            .cashOnDeliveryOption ==
                                                                        "RETURN") {
                                                                      return StreamBuilder(
                                                                        stream:
                                                                            orderBloc.orderSheet,
                                                                        builder: (BuildContext
                                                                                context,
                                                                            AsyncSnapshot<String>
                                                                                snapshots) {
                                                                          return RoundTripCase.selectSheetRoundTrip(
                                                                              snapshots.data,
                                                                              context,
                                                                              snapshot.data.data.bookings[0].order.status);
                                                                        },
                                                                      );
                                                                    } else {
                                                                      return StreamBuilder(
                                                                        stream:
                                                                            orderBloc.orderSheet,
                                                                        builder: (BuildContext
                                                                                context,
                                                                            AsyncSnapshot<String>
                                                                                snapshot) {
                                                                          return StandardCase.sheet(
                                                                              snapshot.data,
                                                                              context,
                                                                              "NORMAL");
                                                                        },
                                                                      );
                                                                    }
                                                                  }
                                                                } else {
                                                                  return StreamBuilder(
                                                                    stream: orderBloc
                                                                        .orderSheet,
                                                                    builder: (BuildContext
                                                                            context,
                                                                        AsyncSnapshot<String>
                                                                            snapshot) {
                                                                      return StandardCase.sheet(
                                                                          snapshot
                                                                              .data,
                                                                          context,
                                                                          "NORMAL");
                                                                    },
                                                                  );
                                                                }
                                                              },
                                                            );
                                                          },
                                                        );
                                                      }
                                                    },
                                                  )),
                                            );
                                          } else {
                                            return SafeArea(
                                              child: Align(
                                                  alignment:
                                                      Alignment.bottomCenter,
                                                  child: OnlineOfflineSheet()),
                                            );
                                          }
                                        } else {
                                          return SafeArea(
                                            child: Align(
                                                alignment:
                                                    Alignment.bottomCenter,
                                                child: OnlineOfflineSheet()),
                                          );
                                        }
                                      } else {
                                        return SafeArea(
                                          child: Align(
                                              alignment: Alignment.bottomCenter,
                                              child: OnlineOfflineSheet()),
                                        );
                                      }
                                    }),
                              ])
                            ],
                          );
                        } else {
                          return Stack(
                            children: [
                              OfflineMap(
                                locationPoints: _center,
                              ),
                              SafeArea(
                                child: Align(
                                  alignment: Alignment.topCenter,
                                  child: Container(
                                    height: 100,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              "assets/images/rectangle.png"),
                                          fit: BoxFit.fill),
                                    ),
                                  ),
                                ),
                              ),
                              SafeArea(
                                child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: OnlineOfflineSheet()),
                              )
                            ],
                          );
                        }
                      } else {
                        return Stack(
                          children: [
                            OfflineMap(
                              locationPoints: _center,
                            ),
                            SafeArea(
                              child: Align(
                                alignment: Alignment.topCenter,
                                child: Container(
                                  height: 100,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "assets/images/rectangle.png"),
                                        fit: BoxFit.fill),
                                  ),
                                ),
                              ),
                            ),
                            SafeArea(
                              child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: OnlineOfflineSheet()),
                            )
                          ],
                        );
                      }
                    },
                  );
                } else {
                  onlineOfflineBloc.setStatus(true);
                  return StreamBuilder(
                    stream: onlineOfflineBloc.captainStatus,
                    builder:
                        (BuildContext context, AsyncSnapshot<bool> snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data) {
                          return Stack(
                            children: [
                              StreamBuilder(
                                  stream: onlineOfflineBloc.captainStatus,
                                  builder: (BuildContext context,
                                      AsyncSnapshot<bool> snapshot) {
                                    if (snapshot.hasData) {
                                      if (snapshot.data) {
                                        return OnlineMap(
                                          locationPoints: _center,
                                        );
                                      } else {
                                        return OfflineMap(
                                          locationPoints: _center,
                                        );
                                      }
                                    } else {
                                      return OfflineMap(
                                        locationPoints: _center,
                                      );
                                    }
                                  }),
                              SafeArea(
                                child: Align(
                                  alignment: Alignment.topCenter,
                                  child: Container(
                                    height: 100,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              "assets/images/rectangle.png"),
                                          fit: BoxFit.fill),
                                    ),
                                  ),
                                ),
                              ),
                              SafeArea(
                                child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Container(
                                      margin: EdgeInsets.only(top: 50),
                                      height: 120,
                                      width: MediaQuery.of(context).size.width,
                                      child: CaptainOrders(
                                        orders: snap.data,
                                      ),
                                    )),
                              ),
                              Stack(children: [
                                StreamBuilder(
                                  stream: onlineOfflineBloc.captainStatus,
                                  builder: (BuildContext context,
                                      AsyncSnapshot<bool> snapshot) {
                                    if (snapshot.hasData) {
                                      if (snapshot.data) {
                                        return StreamBuilder(
                                          stream:
                                              onlineOfflineBloc.captainStatus,
                                          builder: (BuildContext context,
                                              AsyncSnapshot<bool> snapshot) {
                                            if (snapshot.hasData) {
                                              return StreamBuilder(
                                                stream: orderBloc.order,
                                                builder: (BuildContext context,
                                                    AsyncSnapshot<OrderModel>
                                                        snapshot) {
                                                  if (snapshot.hasData) {
                                                    if (snapshot.data.data.data
                                                        .isEmpty) {
                                                      return SafeArea(
                                                        child: Align(
                                                            alignment: Alignment
                                                                .bottomRight,
                                                            child: InkWell(
                                                                onTap: () {
                                                                  onlineOfflineBloc
                                                                      .setStatus(
                                                                          false);
                                                                  approvedCaptainBloc
                                                                      .checkCaptainStatus();
                                                                },
                                                                child:
                                                                    Container(
                                                                  margin: EdgeInsets
                                                                      .only(
                                                                          bottom:
                                                                              170,
                                                                          right:
                                                                              30),
                                                                  child:
                                                                      SvgPicture
                                                                          .asset(
                                                                    "assets/images/stop.svg",
                                                                    width: 60,
                                                                    height: 60,
                                                                  ),
                                                                ))),
                                                      );
                                                    } else {
                                                      return SafeArea(
                                                        child: Align(
                                                            alignment: Alignment
                                                                .bottomRight,
                                                            child: InkWell(
                                                                onTap: () {
                                                                  onlineOfflineBloc
                                                                      .setColor(
                                                                          false);
                                                                  return showDialog<
                                                                          void>(
                                                                      context:
                                                                          context,
                                                                      barrierDismissible:
                                                                          false,
                                                                      // user must tap button!
                                                                      builder:
                                                                          (BuildContext
                                                                              context) {
                                                                        return GoingOfflineErrorDialog();
                                                                      });
                                                                },
                                                                child:
                                                                    Container(
                                                                        margin: EdgeInsets.only(
                                                                            bottom:
                                                                                170,
                                                                            right:
                                                                                30),
                                                                        child:
                                                                            StreamBuilder(
                                                                          stream:
                                                                              onlineOfflineBloc.stopColor,
                                                                          builder:
                                                                              (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                                                                            if (snapshot.hasData) {
                                                                              if (snapshot.data) {
                                                                                return SvgPicture.asset(
                                                                                  "assets/images/stop.svg",
                                                                                  width: 60,
                                                                                  height: 60,
                                                                                );
                                                                              } else {
                                                                                return SvgPicture.asset(
                                                                                  "assets/images/error_stoping.svg",
                                                                                  width: 60,
                                                                                  height: 60,
                                                                                );
                                                                              }
                                                                            } else {
                                                                              return SvgPicture.asset(
                                                                                "assets/images/stop.svg",
                                                                                width: 60,
                                                                                height: 60,
                                                                              );
                                                                            }
                                                                          },
                                                                        )))),
                                                      );
                                                    }
                                                  } else {
                                                    return SafeArea(
                                                      child: Align(
                                                          alignment: Alignment
                                                              .bottomRight,
                                                          child: InkWell(
                                                              onTap: () {
                                                                onlineOfflineBloc
                                                                    .setStatus(
                                                                        false);
                                                                approvedCaptainBloc
                                                                    .checkCaptainStatus();
                                                              },
                                                              child: Container(
                                                                margin: EdgeInsets
                                                                    .only(
                                                                        bottom:
                                                                            170,
                                                                        right:
                                                                            30),
                                                                child:
                                                                    SvgPicture
                                                                        .asset(
                                                                  "assets/images/stop.svg",
                                                                  width: 60,
                                                                  height: 60,
                                                                ),
                                                              ))),
                                                    );
                                                  }
                                                },
                                              );
                                            } else {
                                              return SafeArea(
                                                child: Align(
                                                    alignment:
                                                        Alignment.bottomRight,
                                                    child: InkWell(
                                                        onTap: () {
                                                          onlineOfflineBloc
                                                              .setStatus(false);
                                                          approvedCaptainBloc
                                                              .checkCaptainStatus();
                                                        },
                                                        child: Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  bottom: 170,
                                                                  right: 30),
                                                          child:
                                                              SvgPicture.asset(
                                                            "assets/images/stop.svg",
                                                            width: 60,
                                                            height: 60,
                                                          ),
                                                        ))),
                                              );
                                            }
                                          },
                                        );
                                      } else {
                                        return Container();
                                      }
                                    } else {
                                      return Container();
                                    }
                                  },
                                ),
                                StreamBuilder(
                                    stream: onlineOfflineBloc.captainStatus,
                                    builder: (BuildContext context,
                                        AsyncSnapshot<bool> snapshot) {
                                      if (snapshot.hasData) {
                                        if (snapshot.data) {
                                          if (snapshot.data) {
                                            return SafeArea(
                                              child: Align(
                                                  alignment:
                                                      Alignment.bottomCenter,
                                                  child: StreamBuilder(
                                                    stream: checkCaptainDataBloc
                                                        .suggestion,
                                                    builder: (BuildContext
                                                            context,
                                                        AsyncSnapshot<
                                                                ActiveSuggestion>
                                                            snapshot) {
                                                      if (snapshot.hasData) {
                                                        return NewOrderSuggestionSheet();
                                                      } else {
                                                        return StreamBuilder(
                                                          stream: orderBloc
                                                              .orderSheet,
                                                          builder: (BuildContext
                                                                  context,
                                                              AsyncSnapshot<
                                                                      String>
                                                                  snapshot) {
                                                            return StreamBuilder(
                                                              stream: orderBloc
                                                                  .ride,
                                                              builder: (BuildContext
                                                                      context,
                                                                  AsyncSnapshot<
                                                                          RideModel>
                                                                      snapshot) {
                                                                if (snapshot
                                                                    .hasData) {
                                                                  if (snapshot
                                                                      .data
                                                                      .data
                                                                      .bookings
                                                                      .isEmpty) {
                                                                    return FindingOrdersSheet();
                                                                  } else {
                                                                    if (snapshot
                                                                            .data
                                                                            .data
                                                                            .bookings[
                                                                                0]
                                                                            .order
                                                                            .payUpFront &&
                                                                        !snapshot
                                                                            .data
                                                                            .data
                                                                            .bookings[0]
                                                                            .order
                                                                            .roundTrip) {
                                                                      return StreamBuilder(
                                                                        stream:
                                                                            orderBloc.orderSheet,
                                                                        builder: (BuildContext
                                                                                context,
                                                                            AsyncSnapshot<String>
                                                                                snap) {
                                                                          return StandardCase.selectSheetShipperPay(
                                                                              snap.data,
                                                                              context,
                                                                              snapshot.data.data.bookings[0].order.paidUpFront);
                                                                        },
                                                                      );
                                                                    } else if (snapshot
                                                                            .data
                                                                            .data
                                                                            .bookings[
                                                                                0]
                                                                            .order
                                                                            .payUpFront &&
                                                                        snapshot
                                                                            .data
                                                                            .data
                                                                            .bookings[0]
                                                                            .order
                                                                            .roundTrip) {
                                                                      return StreamBuilder(
                                                                        stream:
                                                                            orderBloc.orderSheet,
                                                                        builder: (BuildContext
                                                                                context,
                                                                            AsyncSnapshot<String>
                                                                                snapshots) {
                                                                          return RoundTripCase.selectSheetRoundTripShipperPay(
                                                                              snapshots.data,
                                                                              context,
                                                                              snapshot.data.data.bookings[0].order.status,
                                                                              snapshot.data.data.bookings[0].order.paidUpFront);
                                                                        },
                                                                      );
                                                                    } else if (!snapshot
                                                                            .data
                                                                            .data
                                                                            .bookings[
                                                                                0]
                                                                            .order
                                                                            .payUpFront &&
                                                                        snapshot
                                                                            .data
                                                                            .data
                                                                            .bookings[0]
                                                                            .order
                                                                            .roundTrip) {
                                                                      return StreamBuilder(
                                                                        stream:
                                                                            orderBloc.orderSheet,
                                                                        builder: (BuildContext
                                                                                context,
                                                                            AsyncSnapshot<String>
                                                                                snapshots) {
                                                                          return RoundTripCase.selectSheetRoundTrip(
                                                                              snapshots.data,
                                                                              context,
                                                                              snapshot.data.data.bookings[0].order.status);
                                                                        },
                                                                      );
                                                                    } else if (snapshot
                                                                            .data
                                                                            .data
                                                                            .bookings[0]
                                                                            .order
                                                                            .cashOnDeliveryOption ==
                                                                        "RETURN") {
                                                                      return StreamBuilder(
                                                                        stream:
                                                                            orderBloc.orderSheet,
                                                                        builder: (BuildContext
                                                                                context,
                                                                            AsyncSnapshot<String>
                                                                                snapshots) {
                                                                          return RoundTripCase.selectSheetRoundTrip(
                                                                              snapshots.data,
                                                                              context,
                                                                              snapshot.data.data.bookings[0].order.status);
                                                                        },
                                                                      );
                                                                    } else {
                                                                      return StreamBuilder(
                                                                        stream:
                                                                            orderBloc.orderSheet,
                                                                        builder: (BuildContext
                                                                                context,
                                                                            AsyncSnapshot<String>
                                                                                snapshot) {
                                                                          return StandardCase.sheet(
                                                                              snapshot.data,
                                                                              context,
                                                                              "NORMAL");
                                                                        },
                                                                      );
                                                                    }
                                                                  }
                                                                } else {
                                                                  return StreamBuilder(
                                                                    stream: orderBloc
                                                                        .orderSheet,
                                                                    builder: (BuildContext
                                                                            context,
                                                                        AsyncSnapshot<String>
                                                                            snapshot) {
                                                                      return StandardCase.sheet(
                                                                          snapshot
                                                                              .data,
                                                                          context,
                                                                          "NORMAL");
                                                                    },
                                                                  );
                                                                }
                                                              },
                                                            );
                                                          },
                                                        );
                                                      }
                                                    },
                                                  )),
                                            );
                                          } else {
                                            return SafeArea(
                                              child: Align(
                                                  alignment:
                                                      Alignment.bottomCenter,
                                                  child: OnlineOfflineSheet()),
                                            );
                                          }
                                        } else {
                                          return SafeArea(
                                            child: Align(
                                                alignment:
                                                    Alignment.bottomCenter,
                                                child: OnlineOfflineSheet()),
                                          );
                                        }
                                      } else {
                                        return SafeArea(
                                          child: Align(
                                              alignment: Alignment.bottomCenter,
                                              child: OnlineOfflineSheet()),
                                        );
                                      }
                                    }),
                              ])
                            ],
                          );
                        } else {
                          return Stack(
                            children: [
                              OnlineMap(
                                locationPoints: _center,
                              ),
                              SafeArea(
                                child: Align(
                                  alignment: Alignment.topCenter,
                                  child: Container(
                                    height: 100,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              "assets/images/rectangle.png"),
                                          fit: BoxFit.fill),
                                    ),
                                  ),
                                ),
                              ),
                              SafeArea(
                                child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Container(
                                      margin: EdgeInsets.only(top: 50),
                                      height: 120,
                                      width: MediaQuery.of(context).size.width,
                                      child: CaptainOrders(
                                        orders: snap.data,
                                      ),
                                    )),
                              ),
                              Stack(children: [
                                snap.data.data.data.isEmpty
                                    ? SafeArea(
                                        child: Align(
                                            alignment: Alignment.bottomRight,
                                            child: InkWell(
                                                onTap: () {
                                                  onlineOfflineBloc
                                                      .setStatus(false);
                                                  approvedCaptainBloc
                                                      .checkCaptainStatus();
                                                },
                                                child: Container(
                                                  margin: EdgeInsets.only(
                                                      bottom: 170, right: 30),
                                                  child: SvgPicture.asset(
                                                    "assets/images/stop.svg",
                                                    width: 60,
                                                    height: 60,
                                                  ),
                                                ))),
                                      )
                                    : SafeArea(
                                        child: Align(
                                            alignment: Alignment.bottomRight,
                                            child: InkWell(
                                                onTap: () {
                                                  onlineOfflineBloc
                                                      .setColor(false);
                                                  return showDialog<void>(
                                                      context: context,
                                                      barrierDismissible: false,
                                                      // user must tap button!
                                                      builder: (BuildContext
                                                          context) {
                                                        return GoingOfflineErrorDialog();
                                                      });
                                                },
                                                child: Container(
                                                    margin: EdgeInsets.only(
                                                        bottom: 170, right: 30),
                                                    child: StreamBuilder(
                                                      stream: onlineOfflineBloc
                                                          .stopColor,
                                                      builder: (BuildContext
                                                              context,
                                                          AsyncSnapshot<dynamic>
                                                              snapshot) {
                                                        if (snapshot.hasData) {
                                                          if (snapshot.data) {
                                                            return SvgPicture
                                                                .asset(
                                                              "assets/images/stop.svg",
                                                              width: 60,
                                                              height: 60,
                                                            );
                                                          } else {
                                                            return SvgPicture
                                                                .asset(
                                                              "assets/images/error_stoping.svg",
                                                              width: 60,
                                                              height: 60,
                                                            );
                                                          }
                                                        } else {
                                                          return SvgPicture
                                                              .asset(
                                                            "assets/images/stop.svg",
                                                            width: 60,
                                                            height: 60,
                                                          );
                                                        }
                                                      },
                                                    )))),
                                      ),
                                SafeArea(
                                  child: Align(
                                      alignment: Alignment.bottomCenter,
                                      child: StreamBuilder(
                                        stream: orderBloc.orderSheet,
                                        builder: (BuildContext context,
                                            AsyncSnapshot<String> snapshot) {
                                          return StreamBuilder(
                                            stream: orderBloc.ride,
                                            builder: (BuildContext context,
                                                AsyncSnapshot<RideModel>
                                                    snapshot) {
                                              if (snapshot.hasData) {
                                                if (snapshot.data.data.bookings
                                                    .isEmpty) {
                                                  return FindingOrdersSheet();
                                                } else {
                                                  if (snapshot
                                                          .data
                                                          .data
                                                          .bookings[0]
                                                          .order
                                                          .payUpFront &&
                                                      !snapshot
                                                          .data
                                                          .data
                                                          .bookings[0]
                                                          .order
                                                          .roundTrip) {
                                                    return StreamBuilder(
                                                      stream:
                                                          orderBloc.orderSheet,
                                                      builder: (BuildContext
                                                              context,
                                                          AsyncSnapshot<String>
                                                              snap) {
                                                        return StandardCase
                                                            .selectSheetShipperPay(
                                                                snap.data,
                                                                context,
                                                                snapshot
                                                                    .data
                                                                    .data
                                                                    .bookings[0]
                                                                    .order
                                                                    .paidUpFront);
                                                      },
                                                    );
                                                  } else if (snapshot
                                                          .data
                                                          .data
                                                          .bookings[0]
                                                          .order
                                                          .payUpFront &&
                                                      snapshot
                                                          .data
                                                          .data
                                                          .bookings[0]
                                                          .order
                                                          .roundTrip) {
                                                    return StreamBuilder(
                                                      stream:
                                                          orderBloc.orderSheet,
                                                      builder: (BuildContext
                                                              context,
                                                          AsyncSnapshot<String>
                                                              snapshots) {
                                                        return RoundTripCase
                                                            .selectSheetRoundTripShipperPay(
                                                                snapshots.data,
                                                                context,
                                                                snapshot
                                                                    .data
                                                                    .data
                                                                    .bookings[0]
                                                                    .order
                                                                    .status,
                                                                snapshot
                                                                    .data
                                                                    .data
                                                                    .bookings[0]
                                                                    .order
                                                                    .paidUpFront);
                                                      },
                                                    );
                                                  } else if (!snapshot
                                                          .data
                                                          .data
                                                          .bookings[0]
                                                          .order
                                                          .payUpFront &&
                                                      snapshot
                                                          .data
                                                          .data
                                                          .bookings[0]
                                                          .order
                                                          .roundTrip) {
                                                    return StreamBuilder(
                                                      stream:
                                                          orderBloc.orderSheet,
                                                      builder: (BuildContext
                                                              context,
                                                          AsyncSnapshot<String>
                                                              snapshots) {
                                                        return RoundTripCase
                                                            .selectSheetRoundTrip(
                                                                snapshots.data,
                                                                context,
                                                                snapshot
                                                                    .data
                                                                    .data
                                                                    .bookings[0]
                                                                    .order
                                                                    .status);
                                                      },
                                                    );
                                                  } else {
                                                    return StreamBuilder(
                                                      stream:
                                                          orderBloc.orderSheet,
                                                      builder: (BuildContext
                                                              context,
                                                          AsyncSnapshot<String>
                                                              snapshot) {
                                                        return StandardCase
                                                            .sheet(
                                                                snapshot.data,
                                                                context,
                                                                "NORMAL");
                                                      },
                                                    );
                                                  }
                                                }
                                              } else {
                                                return StreamBuilder(
                                                  stream: orderBloc.orderSheet,
                                                  builder:
                                                      (BuildContext context,
                                                          AsyncSnapshot<String>
                                                              snapshot) {
                                                    return StandardCase.sheet(
                                                        snapshot.data,
                                                        context,
                                                        "NORMAL");
                                                  },
                                                );
                                              }
                                            },
                                          );
                                        },
                                      )),
                                )
                              ])
                            ],
                          );
                        }
                      } else {
                        return Stack(
                          children: [
                            OnlineMap(
                              locationPoints: _center,
                            ),
                            SafeArea(
                              child: Align(
                                alignment: Alignment.topCenter,
                                child: Container(
                                  height: 100,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "assets/images/rectangle.png"),
                                        fit: BoxFit.fill),
                                  ),
                                ),
                              ),
                            ),
                            SafeArea(
                              child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Container(
                                    margin: EdgeInsets.only(top: 50),
                                    height: 120,
                                    width: MediaQuery.of(context).size.width,
                                    child: CaptainOrders(
                                      orders: snap.data,
                                    ),
                                  )),
                            ),
                            Stack(children: [
                              snap.data.data.data.isEmpty
                                  ? SafeArea(
                                      child: Align(
                                          alignment: Alignment.bottomRight,
                                          child: InkWell(
                                              onTap: () {
                                                onlineOfflineBloc
                                                    .setStatus(false);
                                                approvedCaptainBloc
                                                    .checkCaptainStatus();
                                              },
                                              child: Container(
                                                margin: EdgeInsets.only(
                                                    bottom: 170, right: 30),
                                                child: SvgPicture.asset(
                                                  "assets/images/stop.svg",
                                                  width: 60,
                                                  height: 60,
                                                ),
                                              ))),
                                    )
                                  : SafeArea(
                                      child: Align(
                                          alignment: Alignment.bottomRight,
                                          child: InkWell(
                                              onTap: () {
                                                onlineOfflineBloc
                                                    .setColor(false);
                                                return showDialog<void>(
                                                    context: context,
                                                    barrierDismissible: false,
                                                    // user must tap button!
                                                    builder:
                                                        (BuildContext context) {
                                                      return GoingOfflineErrorDialog();
                                                    });
                                              },
                                              child: Container(
                                                  margin: EdgeInsets.only(
                                                      bottom: 170, right: 30),
                                                  child: StreamBuilder(
                                                    stream: onlineOfflineBloc
                                                        .stopColor,
                                                    builder: (BuildContext
                                                            context,
                                                        AsyncSnapshot<dynamic>
                                                            snapshot) {
                                                      if (snapshot.hasData) {
                                                        if (snapshot.data) {
                                                          return SvgPicture
                                                              .asset(
                                                            "assets/images/stop.svg",
                                                            width: 60,
                                                            height: 60,
                                                          );
                                                        } else {
                                                          return SvgPicture
                                                              .asset(
                                                            "assets/images/error_stoping.svg",
                                                            width: 60,
                                                            height: 60,
                                                          );
                                                        }
                                                      } else {
                                                        return SvgPicture.asset(
                                                          "assets/images/stop.svg",
                                                          width: 60,
                                                          height: 60,
                                                        );
                                                      }
                                                    },
                                                  )))),
                                    ),
                              SafeArea(
                                child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: StreamBuilder(
                                      stream: orderBloc.orderSheet,
                                      builder: (BuildContext context,
                                          AsyncSnapshot<String> snapshot) {
                                        return StreamBuilder(
                                          stream: orderBloc.ride,
                                          builder: (BuildContext context,
                                              AsyncSnapshot<RideModel>
                                                  snapshot) {
                                            if (snapshot.hasData) {
                                              if (snapshot
                                                  .data.data.bookings.isEmpty) {
                                                return FindingOrdersSheet();
                                              } else {
                                                if (snapshot
                                                        .data
                                                        .data
                                                        .bookings[0]
                                                        .order
                                                        .payUpFront &&
                                                    !snapshot
                                                        .data
                                                        .data
                                                        .bookings[0]
                                                        .order
                                                        .roundTrip) {
                                                  return StreamBuilder(
                                                    stream:
                                                        orderBloc.orderSheet,
                                                    builder: (BuildContext
                                                            context,
                                                        AsyncSnapshot<String>
                                                            snap) {
                                                      return StandardCase
                                                          .selectSheetShipperPay(
                                                              snap.data,
                                                              context,
                                                              snapshot
                                                                  .data
                                                                  .data
                                                                  .bookings[0]
                                                                  .order
                                                                  .paidUpFront);
                                                    },
                                                  );
                                                } else if (snapshot
                                                        .data
                                                        .data
                                                        .bookings[0]
                                                        .order
                                                        .payUpFront &&
                                                    snapshot
                                                        .data
                                                        .data
                                                        .bookings[0]
                                                        .order
                                                        .roundTrip) {
                                                  return StreamBuilder(
                                                    stream:
                                                        orderBloc.orderSheet,
                                                    builder: (BuildContext
                                                            context,
                                                        AsyncSnapshot<String>
                                                            snapshots) {
                                                      return RoundTripCase
                                                          .selectSheetRoundTripShipperPay(
                                                              snapshots.data,
                                                              context,
                                                              snapshot
                                                                  .data
                                                                  .data
                                                                  .bookings[0]
                                                                  .order
                                                                  .status,
                                                              snapshot
                                                                  .data
                                                                  .data
                                                                  .bookings[0]
                                                                  .order
                                                                  .paidUpFront);
                                                    },
                                                  );
                                                } else if (!snapshot
                                                        .data
                                                        .data
                                                        .bookings[0]
                                                        .order
                                                        .payUpFront &&
                                                    snapshot
                                                        .data
                                                        .data
                                                        .bookings[0]
                                                        .order
                                                        .roundTrip) {
                                                  return StreamBuilder(
                                                    stream:
                                                        orderBloc.orderSheet,
                                                    builder: (BuildContext
                                                            context,
                                                        AsyncSnapshot<String>
                                                            snapshots) {
                                                      return RoundTripCase
                                                          .selectSheetRoundTrip(
                                                              snapshots.data,
                                                              context,
                                                              snapshot
                                                                  .data
                                                                  .data
                                                                  .bookings[0]
                                                                  .order
                                                                  .status);
                                                    },
                                                  );
                                                } else {
                                                  return StreamBuilder(
                                                    stream:
                                                        orderBloc.orderSheet,
                                                    builder: (BuildContext
                                                            context,
                                                        AsyncSnapshot<String>
                                                            snapshot) {
                                                      return StandardCase.sheet(
                                                          snapshot.data,
                                                          context,
                                                          "NORMAL");
                                                    },
                                                  );
                                                }
                                              }
                                            } else {
                                              return StreamBuilder(
                                                stream: orderBloc.orderSheet,
                                                builder: (BuildContext context,
                                                    AsyncSnapshot<String>
                                                        snapshot) {
                                                  return StandardCase.sheet(
                                                      snapshot.data,
                                                      context,
                                                      "NORMAL");
                                                },
                                              );
                                            }
                                          },
                                        );
                                      },
                                    )),
                              )
                            ])
                          ],
                        );
                      }
                    },
                  );
                }
              } else {
                return StreamBuilder(
                  stream: onlineOfflineBloc.captainStatus,
                  builder:
                      (BuildContext context, AsyncSnapshot<bool> snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data) {
                        return Stack(
                          children: [
                            StreamBuilder(
                                stream: onlineOfflineBloc.captainStatus,
                                builder: (BuildContext context,
                                    AsyncSnapshot<bool> snapshot) {
                                  if (snapshot.hasData) {
                                    if (snapshot.data) {
                                      return OnlineMap(
                                        locationPoints: _center,
                                      );
                                    } else {
                                      return OfflineMap(
                                        locationPoints: _center,
                                      );
                                    }
                                  } else {
                                    return OfflineMap(
                                      locationPoints: _center,
                                    );
                                  }
                                }),
                            SafeArea(
                              child: Align(
                                alignment: Alignment.topCenter,
                                child: Container(
                                  height: 100,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "assets/images/rectangle.png"),
                                        fit: BoxFit.fill),
                                  ),
                                ),
                              ),
                            ),
                            Stack(children: [
                              StreamBuilder(
                                stream: onlineOfflineBloc.captainStatus,
                                builder: (BuildContext context,
                                    AsyncSnapshot<bool> snapshot) {
                                  if (snapshot.hasData) {
                                    if (snapshot.data) {
                                      return StreamBuilder(
                                        stream: onlineOfflineBloc.captainStatus,
                                        builder: (BuildContext context,
                                            AsyncSnapshot<bool> snapshot) {
                                          if (snapshot.hasData) {
                                            return StreamBuilder(
                                              stream: orderBloc.order,
                                              builder: (BuildContext context,
                                                  AsyncSnapshot<OrderModel>
                                                      snapshot) {
                                                if (snapshot.hasData) {
                                                  if (snapshot
                                                      .data.data.data.isEmpty) {
                                                    return SafeArea(
                                                      child: Align(
                                                          alignment: Alignment
                                                              .bottomRight,
                                                          child: InkWell(
                                                              onTap: () {
                                                                onlineOfflineBloc
                                                                    .setStatus(
                                                                        false);
                                                                approvedCaptainBloc
                                                                    .checkCaptainStatus();
                                                              },
                                                              child: Container(
                                                                margin: EdgeInsets
                                                                    .only(
                                                                        bottom:
                                                                            170,
                                                                        right:
                                                                            30),
                                                                child:
                                                                    SvgPicture
                                                                        .asset(
                                                                  "assets/images/stop.svg",
                                                                  width: 60,
                                                                  height: 60,
                                                                ),
                                                              ))),
                                                    );
                                                  } else {
                                                    return SafeArea(
                                                      child: Align(
                                                          alignment: Alignment
                                                              .bottomRight,
                                                          child: InkWell(
                                                              onTap: () {
                                                                onlineOfflineBloc
                                                                    .setColor(
                                                                        false);
                                                                return showDialog<
                                                                        void>(
                                                                    context:
                                                                        context,
                                                                    barrierDismissible:
                                                                        false,
                                                                    // user must tap button!
                                                                    builder:
                                                                        (BuildContext
                                                                            context) {
                                                                      return GoingOfflineErrorDialog();
                                                                    });
                                                              },
                                                              child: Container(
                                                                  margin: EdgeInsets
                                                                      .only(
                                                                          bottom:
                                                                              170,
                                                                          right:
                                                                              30),
                                                                  child:
                                                                      StreamBuilder(
                                                                    stream: onlineOfflineBloc
                                                                        .stopColor,
                                                                    builder: (BuildContext
                                                                            context,
                                                                        AsyncSnapshot<dynamic>
                                                                            snapshot) {
                                                                      if (snapshot
                                                                          .hasData) {
                                                                        if (snapshot
                                                                            .data) {
                                                                          return SvgPicture
                                                                              .asset(
                                                                            "assets/images/stop.svg",
                                                                            width:
                                                                                60,
                                                                            height:
                                                                                60,
                                                                          );
                                                                        } else {
                                                                          return SvgPicture
                                                                              .asset(
                                                                            "assets/images/error_stoping.svg",
                                                                            width:
                                                                                60,
                                                                            height:
                                                                                60,
                                                                          );
                                                                        }
                                                                      } else {
                                                                        return SvgPicture
                                                                            .asset(
                                                                          "assets/images/stop.svg",
                                                                          width:
                                                                              60,
                                                                          height:
                                                                              60,
                                                                        );
                                                                      }
                                                                    },
                                                                  )))),
                                                    );
                                                  }
                                                } else {
                                                  return SafeArea(
                                                    child: Align(
                                                        alignment: Alignment
                                                            .bottomRight,
                                                        child: InkWell(
                                                            onTap: () {
                                                              onlineOfflineBloc
                                                                  .setStatus(
                                                                      false);
                                                              approvedCaptainBloc
                                                                  .checkCaptainStatus();
                                                            },
                                                            child: Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      bottom:
                                                                          170,
                                                                      right:
                                                                          30),
                                                              child: SvgPicture
                                                                  .asset(
                                                                "assets/images/stop.svg",
                                                                width: 60,
                                                                height: 60,
                                                              ),
                                                            ))),
                                                  );
                                                }
                                              },
                                            );
                                          } else {
                                            return SafeArea(
                                              child: Align(
                                                  alignment:
                                                      Alignment.bottomRight,
                                                  child: InkWell(
                                                      onTap: () {
                                                        onlineOfflineBloc
                                                            .setStatus(false);
                                                        approvedCaptainBloc
                                                            .checkCaptainStatus();
                                                      },
                                                      child: Container(
                                                        margin: EdgeInsets.only(
                                                            bottom: 170,
                                                            right: 30),
                                                        child: SvgPicture.asset(
                                                          "assets/images/stop.svg",
                                                          width: 60,
                                                          height: 60,
                                                        ),
                                                      ))),
                                            );
                                          }
                                        },
                                      );
                                    } else {
                                      return Container();
                                    }
                                  } else {
                                    return Container();
                                  }
                                },
                              ),
                              StreamBuilder(
                                  stream: onlineOfflineBloc.captainStatus,
                                  builder: (BuildContext context,
                                      AsyncSnapshot<bool> snapshot) {
                                    if (snapshot.hasData) {
                                      if (snapshot.data) {
                                        if (snapshot.data) {
                                          return SafeArea(
                                            child: Align(
                                                alignment:
                                                    Alignment.bottomCenter,
                                                child: StreamBuilder(
                                                  stream: orderBloc.orderSheet,
                                                  builder:
                                                      (BuildContext context,
                                                          AsyncSnapshot<String>
                                                              snapshot) {
                                                    return StreamBuilder(
                                                      stream: orderBloc.ride,
                                                      builder:
                                                          (BuildContext context,
                                                              AsyncSnapshot<
                                                                      RideModel>
                                                                  snapshot) {
                                                        if (snapshot.hasData) {
                                                          if (snapshot
                                                              .data
                                                              .data
                                                              .bookings
                                                              .isEmpty) {
                                                            return FindingOrdersSheet();
                                                          } else {
                                                            if (snapshot
                                                                    .data
                                                                    .data
                                                                    .bookings[0]
                                                                    .order
                                                                    .payUpFront &&
                                                                !snapshot
                                                                    .data
                                                                    .data
                                                                    .bookings[0]
                                                                    .order
                                                                    .roundTrip) {
                                                              return StreamBuilder(
                                                                stream: orderBloc
                                                                    .orderSheet,
                                                                builder: (BuildContext
                                                                        context,
                                                                    AsyncSnapshot<
                                                                            String>
                                                                        snap) {
                                                                  return StandardCase.selectSheetShipperPay(
                                                                      snap.data,
                                                                      context,
                                                                      snapshot
                                                                          .data
                                                                          .data
                                                                          .bookings[
                                                                              0]
                                                                          .order
                                                                          .paidUpFront);
                                                                },
                                                              );
                                                            } else if (snapshot
                                                                    .data
                                                                    .data
                                                                    .bookings[0]
                                                                    .order
                                                                    .payUpFront &&
                                                                snapshot
                                                                    .data
                                                                    .data
                                                                    .bookings[0]
                                                                    .order
                                                                    .roundTrip) {
                                                              return StreamBuilder(
                                                                stream: orderBloc
                                                                    .orderSheet,
                                                                builder: (BuildContext
                                                                        context,
                                                                    AsyncSnapshot<
                                                                            String>
                                                                        snapshots) {
                                                                  return RoundTripCase.selectSheetRoundTripShipperPay(
                                                                      snapshots
                                                                          .data,
                                                                      context,
                                                                      snapshot
                                                                          .data
                                                                          .data
                                                                          .bookings[
                                                                              0]
                                                                          .order
                                                                          .status,
                                                                      snapshot
                                                                          .data
                                                                          .data
                                                                          .bookings[
                                                                              0]
                                                                          .order
                                                                          .paidUpFront);
                                                                },
                                                              );
                                                            } else if (!snapshot
                                                                    .data
                                                                    .data
                                                                    .bookings[0]
                                                                    .order
                                                                    .payUpFront &&
                                                                snapshot
                                                                    .data
                                                                    .data
                                                                    .bookings[0]
                                                                    .order
                                                                    .roundTrip) {
                                                              return StreamBuilder(
                                                                stream: orderBloc
                                                                    .orderSheet,
                                                                builder: (BuildContext
                                                                        context,
                                                                    AsyncSnapshot<
                                                                            String>
                                                                        snapshots) {
                                                                  return RoundTripCase.selectSheetRoundTrip(
                                                                      snapshots
                                                                          .data,
                                                                      context,
                                                                      snapshot
                                                                          .data
                                                                          .data
                                                                          .bookings[
                                                                              0]
                                                                          .order
                                                                          .status);
                                                                },
                                                              );
                                                            } else if (snapshot
                                                                    .data
                                                                    .data
                                                                    .bookings[0]
                                                                    .order
                                                                    .cashOnDeliveryOption ==
                                                                "RETURN") {
                                                              return StreamBuilder(
                                                                stream: orderBloc
                                                                    .orderSheet,
                                                                builder: (BuildContext
                                                                        context,
                                                                    AsyncSnapshot<
                                                                            String>
                                                                        snapshots) {
                                                                  return RoundTripCase.selectSheetRoundTrip(
                                                                      snapshots
                                                                          .data,
                                                                      context,
                                                                      snapshot
                                                                          .data
                                                                          .data
                                                                          .bookings[
                                                                              0]
                                                                          .order
                                                                          .status);
                                                                },
                                                              );
                                                            } else {
                                                              return StreamBuilder(
                                                                stream: orderBloc
                                                                    .orderSheet,
                                                                builder: (BuildContext
                                                                        context,
                                                                    AsyncSnapshot<
                                                                            String>
                                                                        snapshot) {
                                                                  return StandardCase.sheet(
                                                                      snapshot
                                                                          .data,
                                                                      context,
                                                                      "NORMAL");
                                                                },
                                                              );
                                                            }
                                                          }
                                                        } else {
                                                          return StreamBuilder(
                                                            stream: orderBloc
                                                                .orderSheet,
                                                            builder: (BuildContext
                                                                    context,
                                                                AsyncSnapshot<
                                                                        String>
                                                                    snapshot) {
                                                              return StandardCase
                                                                  .sheet(
                                                                      snapshot
                                                                          .data,
                                                                      context,
                                                                      "NORMAL");
                                                            },
                                                          );
                                                        }
                                                      },
                                                    );
                                                  },
                                                )),
                                          );
                                        } else {
                                          return SafeArea(
                                            child: Align(
                                                alignment:
                                                    Alignment.bottomCenter,
                                                child: OnlineOfflineSheet()),
                                          );
                                        }
                                      } else {
                                        return SafeArea(
                                          child: Align(
                                              alignment: Alignment.bottomCenter,
                                              child: OnlineOfflineSheet()),
                                        );
                                      }
                                    } else {
                                      return SafeArea(
                                        child: Align(
                                            alignment: Alignment.bottomCenter,
                                            child: OnlineOfflineSheet()),
                                      );
                                    }
                                  }),
                            ])
                          ],
                        );
                      } else {
                        return Stack(
                          children: [
                            OnlineMap(
                              locationPoints: _center,
                            ),
                            SafeArea(
                              child: Align(
                                alignment: Alignment.topCenter,
                                child: Container(
                                  height: 100,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "assets/images/rectangle.png"),
                                        fit: BoxFit.fill),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }
                    } else {
                      return Stack(
                        children: [
                          OnlineMap(
                            locationPoints: _center,
                          ),
                          SafeArea(
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: Container(
                                height: 100,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "assets/images/rectangle.png"),
                                      fit: BoxFit.fill),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                  },
                );
              }
            },
          ),
        ));
  }
}
