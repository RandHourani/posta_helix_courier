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
import 'package:posta_courier/src/shipment_cases/case_1.dart';
import 'package:posta_courier/src/shipment_cases/round_trip_case_1.dart';
import 'package:posta_courier/src/ui/home/google_maps/home_screen.dart';
import 'package:posta_courier/src/ui/home/google_maps/list_of_captain_orders.dart';
import 'package:posta_courier/src/ui/signIn_and_createAccount_screens/signIn_screen.dart';
import 'package:posta_courier/src/ui/widgets/dialog_loading.dart';
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
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'file:///C:/Users/r.horani/AndroidStudioProjects/helix_courier_project/helix_courier_project/lib/src/constants/application_colors_value.dart';

class BaseHomeScreen extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<BaseHomeScreen> {
  // @override
  // void initState() {
  //   super.initState();
  //   _showDialog(context);
  // }

  static const LatLng _center = const LatLng(31.949722, 35.932778);
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  @override
  Widget build(BuildContext context) {
    // _showDialog(context);
    checkCaptainDataBloc.checkUserAuth();

    // Utils.setScreen('/home');
    // _firebaseMessaging.getToken().then((token) {
    //   approvedCaptainBloc.setNotificationToken(token);
    // });
    FlutterStatusbarcolor.setStatusBarColor(Colors.white);
    checkCaptainDataBloc.checkUserAuth();
    _showDialog(context);
    GoogleMapController _controller;
    return Scaffold(
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
        body: Stack(
          children: [
            OfflineMap(
              locationPoints: _center,
            ),
            Align(
              alignment: Alignment.center,
              child: LoadingDialogWidget(),
            ),
            SafeArea(
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/rectangle.png"),
                        fit: BoxFit.fill),
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  _showDialog(context) async {
    Future.delayed(Duration(seconds: 3), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {
          googleMapBloc.getUserLocation();
          approvedCaptainBloc.checkUserAuth();
          // walletBloc.walletAccount();
          return HomeScreen();
        }),
      );
      // if (checkCaptainDataBloc.getData() == "success") {
      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(builder: (context) {
      //       googleMapBloc.getUserLocation();
      //       approvedCaptainBloc.checkUserAuth();
      //       // walletBloc.walletAccount();
      //       return HomeScreen();
      //     }),
      //   );
      // } else {
      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(builder: (context) {
      //       return SignInScreen();
      //     }),
      //   );
      // }
    });
    // showDialog(
    //   context: context,
    //   barrierDismissible: false, // user must tap button!
    //   builder: (BuildContext context) {
    //
    //     return LoadingDialogWidget();
    //   },
    // );
  }
}
