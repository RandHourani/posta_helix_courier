import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'file:///C:/Users/r.horani/AndroidStudioProjects/helix_courier_project/helix_courier_project/lib/src/constants/application_colors_value.dart';

import 'package:image_picker/image_picker.dart';
import 'package:photo_view/photo_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:posta_courier/models/get_captain_model.dart';
import 'package:posta_courier/src/blocs/home_blocs/approved_captain_bloc.dart';
import 'package:posta_courier/src/blocs/home_blocs/new_vehicle_bloc.dart';

import 'package:posta_courier/src/constants/fonts_size.dart';
import 'package:posta_courier/src/ui/home/side_menu_screens/profile_screen.dart';
import 'package:posta_courier/src/ui/signIn_and_createAccount_screens/interview_screen.dart';

class VehicleDocumentsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.white);
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.width / 6,
                    left: MediaQuery.of(context).size.width * 0.04,
                  ),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.arrow_back,
                        color: AppColors.TITLE_TEXT_COLOR,
                        size: (MediaQuery.of(context).size.width * 0.04) +
                            FontSize.HEADING_FONT -
                            3,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "   UPLOAD  VEHICLE  DOCUMENTS",
                          style: TextStyle(
                              color: AppColors.TITLE_TEXT_COLOR,
                              fontFamily: FontFamilies.POPPINS,
                              fontSize:
                                  (MediaQuery.of(context).size.width * 0.04) +
                                      FontSize.HEADING_FONT -
                                      7,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                    color: AppColors.DOCUMENTS_LABEL,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(
                      left: (MediaQuery.of(context).size.height * 0.02) + 20,
                      top: MediaQuery.of(context).size.width * 0.04,
                      bottom: MediaQuery.of(context).size.width * 0.04,
                    ),
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.width * 0.07,
                        bottom: MediaQuery.of(context).size.width * 0.07),
                    child: Text(
                      "Vehicle Insurance",
                      style: TextStyle(
                          fontFamily: FontFamilies.POPPINS,
                          fontSize:
                              (MediaQuery.of(context).size.height * 0.02) + 5,
                          fontWeight: FontWeight.w500),
                    )),
                Container(
                  padding: EdgeInsets.only(
                      left: (MediaQuery.of(context).size.height * 0.02) + 20,
                      right: 15,
                      bottom: MediaQuery.of(context).size.width * 0.07),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Vehicle Insurance Front Copy",
                            style: TextStyle(
                              fontFamily: FontFamilies.POPPINS,
                              fontSize:
                                  (MediaQuery.of(context).size.height * 0.02),
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              Container(
                                width: (MediaQuery.of(context).size.height *
                                        0.02) +
                                    15,
                                height: (MediaQuery.of(context).size.height *
                                        0.02) +
                                    15,
                                child: StreamBuilder(
                                    stream: newVehicleBloc.insuranceFront,
                                    builder: (context, snap) {
                                      if (snap.hasData) {
                                        FlutterStatusbarcolor.setStatusBarColor(
                                            Colors.white);
                                        return Container(
                                          width: 18,
                                          height: 18,
                                          child: CircleAvatar(
                                              child: GestureDetector(
                                                onTap: () async {
                                                  FlutterStatusbarcolor
                                                      .setStatusBarColor(
                                                          AppColors
                                                              .dialogStatusBar);
                                                  await showDialog(
                                                          barrierDismissible: true,
                                                          context: context,
                                                          builder: (_) {
                                                            return WillPopScope(
                                                                onWillPop: () {
                                                                  FlutterStatusbarcolor
                                                                      .setStatusBarColor(
                                                                          Colors
                                                                              .white);
                                                                  return Future
                                                                      .value(
                                                                          true);
                                                                },
                                                                child: Stack(
                                                                    children: [
                                                                      PhotoView(
                                                                        backgroundDecoration:
                                                                            BoxDecoration(color: Colors.black12.withOpacity(0.01)),

                                                                        imageProvider:
                                                                            FileImage(snap.data),
                                                                        minScale:
                                                                            0.2,
                                                                        // initialScale: 0.2,
                                                                        maxScale:
                                                                            0.6,
                                                                        customSize: Size(
                                                                            300,
                                                                            400),
                                                                      ),
                                                                      Align(
                                                                        alignment:
                                                                            Alignment.topRight,
                                                                        child:
                                                                            Container(
                                                                          margin:
                                                                              EdgeInsets.all(10),
                                                                          width:
                                                                              30,
                                                                          height:
                                                                              30,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            boxShadow: <BoxShadow>[
                                                                              BoxShadow(
                                                                                color: Colors.black26,
                                                                                blurRadius: 5,
                                                                                offset: Offset(2, 2),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          child: FloatingActionButton(
                                                                              heroTag: "dismiss5",
                                                                              elevation: 2.5,
                                                                              backgroundColor: Colors.white,
                                                                              child: Icon(
                                                                                Icons.close,
                                                                                color: Colors.black,
                                                                                size: 20,
                                                                              ),
                                                                              onPressed: () {
                                                                                Navigator.pop(context);
                                                                                FlutterStatusbarcolor.setStatusBarColor(Colors.white);
                                                                              }),
                                                                        ),
                                                                      )
                                                                    ]));
                                                          })
                                                      .then((value) =>
                                                          FlutterStatusbarcolor
                                                              .setStatusBarColor(
                                                                  Colors
                                                                      .white));
                                                },
                                              ),
                                              radius: 50.0,
                                              backgroundImage:
                                                  FileImage(snap.data)),
                                        );
                                      } else {
                                        return FloatingActionButton(
                                          heroTag: "btn5",
                                          elevation: 2.5,
                                          backgroundColor: Colors.white,
                                          child: Image.asset(
                                            "assets/images/camera.png",
                                            width: (MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.02),
                                            height: (MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.02),
                                          ),
                                          onPressed: () {
                                            FlutterStatusbarcolor
                                                .setStatusBarColor(
                                                    AppColors.dialogStatusBar);
                                            showDialog<void>(
                                                    context: context,
                                                    barrierDismissible: false,
                                                    // user must tap button!
                                                    builder:
                                                        (BuildContext context) {
                                                      return WillPopScope(
                                                          onWillPop: () {
                                                            FlutterStatusbarcolor
                                                                .setStatusBarColor(
                                                                    Colors
                                                                        .white);
                                                            return Future.value(
                                                                true);
                                                          },
                                                          child: AlertDialog(
                                                            contentPadding:
                                                                EdgeInsets.all(
                                                                    8),
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            15.0))),
                                                            content: Container(
                                                              height: 50,
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceAround,
                                                                children: <
                                                                    Widget>[
                                                                  cameraNew(
                                                                      'VEHICLE_INSURANCE_FRONT'),
                                                                  VerticalDivider(
                                                                    color: AppColors
                                                                        .labelColor,
                                                                  ),
                                                                  galleryNew(
                                                                      'VEHICLE_INSURANCE_FRONT'),
                                                                ],
                                                              ),
                                                            ),
                                                          ));
                                                    })
                                                .then((value) =>
                                                    FlutterStatusbarcolor
                                                        .setStatusBarColor(
                                                            Colors.white));
                                          },
                                        );
                                      }
                                    }),
                              ),
                              StreamBuilder(
                                stream: newVehicleBloc.insuranceFront,
                                builder: (context, snap) {
                                  if (snap.hasData) {
                                    return InkWell(
                                      onTap: () {
                                        FlutterStatusbarcolor.setStatusBarColor(
                                            AppColors.dialogStatusBar);
                                        showDialog<void>(
                                                context: context,
                                                barrierDismissible: false,
                                                // user must tap button!
                                                builder: (BuildContext context) {
                                                  return WillPopScope(
                                                      onWillPop: () {
                                                        FlutterStatusbarcolor
                                                            .setStatusBarColor(
                                                                Colors.white);
                                                        return Future.value(
                                                            true);
                                                      },
                                                      child: AlertDialog(
                                                        contentPadding:
                                                            EdgeInsets.all(8),
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius.all(
                                                                    Radius.circular(
                                                                        15.0))),
                                                        content: Container(
                                                          height: 50,
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceAround,
                                                            children: <Widget>[
                                                              cameraNew(
                                                                  'VEHICLE_INSURANCE_FRONT'),
                                                              VerticalDivider(
                                                                color: AppColors
                                                                    .labelColor,
                                                              ),
                                                              galleryNew(
                                                                  'VEHICLE_INSURANCE_FRONT'),
                                                            ],
                                                          ),
                                                        ),
                                                      ));
                                                })
                                            .then((value) =>
                                                FlutterStatusbarcolor
                                                    .setStatusBarColor(
                                                        Colors.white));
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 10),
                                        child: SvgPicture.asset(
                                            "assets/images/edit_pin.svg",
                                            width: (MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.02) +
                                                2,
                                            height: (MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.02) +
                                                2),
                                      ),
                                    );
                                  } else {
                                    return SizedBox(
                                      width:
                                          (MediaQuery.of(context).size.height *
                                                  0.02) +
                                              12,
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                    left: (MediaQuery.of(context).size.height * 0.02) + 20,
                    right: 15,
                  ),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Vehicle Insurance Back Copy",
                            style: TextStyle(
                              fontFamily: FontFamilies.POPPINS,
                              fontSize:
                                  (MediaQuery.of(context).size.height * 0.02),
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              Container(
                                width: (MediaQuery.of(context).size.height *
                                        0.02) +
                                    15,
                                height: (MediaQuery.of(context).size.height *
                                        0.02) +
                                    15,
                                child: StreamBuilder(
                                    stream: newVehicleBloc.insuranceBack,
                                    builder: (context, snap) {
                                      if (snap.hasData) {
                                        FlutterStatusbarcolor.setStatusBarColor(
                                            Colors.white);
                                        return Container(
                                          width: 18,
                                          height: 18,
                                          child: CircleAvatar(
                                              child: GestureDetector(
                                                onTap: () async {
                                                  FlutterStatusbarcolor
                                                      .setStatusBarColor(
                                                          AppColors
                                                              .dialogStatusBar);
                                                  await showDialog(
                                                          barrierDismissible: true,
                                                          context: context,
                                                          builder: (_) {
                                                            return WillPopScope(
                                                                onWillPop: () {
                                                                  FlutterStatusbarcolor
                                                                      .setStatusBarColor(
                                                                          Colors
                                                                              .white);
                                                                  return Future
                                                                      .value(
                                                                          true);
                                                                },
                                                                child: Stack(
                                                                    children: [
                                                                      PhotoView(
                                                                        backgroundDecoration:
                                                                            BoxDecoration(color: Colors.black12.withOpacity(0.01)),

                                                                        imageProvider:
                                                                            FileImage(snap.data),
                                                                        minScale:
                                                                            0.2,
                                                                        // initialScale: 0.2,
                                                                        maxScale:
                                                                            0.6,
                                                                        customSize: Size(
                                                                            300,
                                                                            400),
                                                                      ),
                                                                      Align(
                                                                        alignment:
                                                                            Alignment.topRight,
                                                                        child:
                                                                            Container(
                                                                          margin:
                                                                              EdgeInsets.all(10),
                                                                          width:
                                                                              30,
                                                                          height:
                                                                              30,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            boxShadow: <BoxShadow>[
                                                                              BoxShadow(
                                                                                color: Colors.black26,
                                                                                blurRadius: 5,
                                                                                offset: Offset(2, 2),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          child: FloatingActionButton(
                                                                              heroTag: "dismiss2",
                                                                              elevation: 2.5,
                                                                              backgroundColor: Colors.white,
                                                                              child: Icon(
                                                                                Icons.close,
                                                                                color: Colors.black,
                                                                                size: 20,
                                                                              ),
                                                                              onPressed: () {
                                                                                Navigator.pop(context);
                                                                                FlutterStatusbarcolor.setStatusBarColor(Colors.white);
                                                                              }),
                                                                        ),
                                                                      )
                                                                    ]));
                                                          })
                                                      .then((value) =>
                                                          FlutterStatusbarcolor
                                                              .setStatusBarColor(
                                                                  Colors
                                                                      .white));
                                                },
                                              ),
                                              radius: 50.0,
                                              backgroundImage:
                                                  FileImage(snap.data)),
                                        );
                                      } else {
                                        return FloatingActionButton(
                                          heroTag: "btn6",
                                          elevation: 2.5,
                                          backgroundColor: Colors.white,
                                          child: Image.asset(
                                            "assets/images/camera.png",
                                            width: (MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.02),
                                            height: (MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.02),
                                          ),
                                          onPressed: () {
                                            FlutterStatusbarcolor
                                                .setStatusBarColor(
                                                    AppColors.dialogStatusBar);
                                            showDialog<void>(
                                                    context: context,
                                                    barrierDismissible: false,
                                                    // user must tap button!
                                                    builder:
                                                        (BuildContext context) {
                                                      return WillPopScope(
                                                          onWillPop: () {
                                                            FlutterStatusbarcolor
                                                                .setStatusBarColor(
                                                                    Colors
                                                                        .white);
                                                            return Future.value(
                                                                true);
                                                          },
                                                          child: AlertDialog(
                                                            contentPadding:
                                                                EdgeInsets.all(
                                                                    8),
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            15.0))),
                                                            content:
                                                                SingleChildScrollView(
                                                              child: Container(
                                                                height: 50,
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceAround,
                                                                  children: <
                                                                      Widget>[
                                                                    cameraNew(
                                                                        'VEHICLE_INSURANCE_BACK'),
                                                                    VerticalDivider(
                                                                      color: AppColors
                                                                          .labelColor,
                                                                    ),
                                                                    galleryNew(
                                                                        'VEHICLE_INSURANCE_BACK'),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ));
                                                    })
                                                .then((value) =>
                                                    FlutterStatusbarcolor
                                                        .setStatusBarColor(
                                                            Colors.white));
                                          },
                                        );
                                      }
                                    }),
                              ),
                              StreamBuilder(
                                stream: newVehicleBloc.insuranceBack,
                                builder: (context, snap) {
                                  if (snap.hasData) {
                                    return InkWell(
                                      onTap: () {
                                        FlutterStatusbarcolor.setStatusBarColor(
                                            AppColors.dialogStatusBar);
                                        showDialog<void>(
                                                context: context,
                                                barrierDismissible: false,
                                                // user must tap button!
                                                builder: (BuildContext context) {
                                                  return WillPopScope(
                                                      onWillPop: () {
                                                        FlutterStatusbarcolor
                                                            .setStatusBarColor(
                                                                Colors.white);
                                                        return Future.value(
                                                            true);
                                                      },
                                                      child: AlertDialog(
                                                        contentPadding:
                                                            EdgeInsets.all(8),
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius.all(
                                                                    Radius.circular(
                                                                        15.0))),
                                                        content:
                                                            SingleChildScrollView(
                                                          child: Container(
                                                            height: 50,
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceAround,
                                                              children: <
                                                                  Widget>[
                                                                cameraNew(
                                                                    'VEHICLE_INSURANCE_BACK'),
                                                                VerticalDivider(
                                                                  color: AppColors
                                                                      .labelColor,
                                                                ),
                                                                galleryNew(
                                                                    'VEHICLE_INSURANCE_BACK'),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ));
                                                })
                                            .then((value) =>
                                                FlutterStatusbarcolor
                                                    .setStatusBarColor(
                                                        Colors.white));
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 10),
                                        child: SvgPicture.asset(
                                            "assets/images/edit_pin.svg",
                                            width: (MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.02) +
                                                2,
                                            height: (MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.02) +
                                                2),
                                      ),
                                    );
                                  } else {
                                    return SizedBox(
                                      width:
                                          (MediaQuery.of(context).size.height *
                                                  0.02) +
                                              12,
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                    color: AppColors.DOCUMENTS_LABEL,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(
                      left: (MediaQuery.of(context).size.height * 0.02) + 20,
                      top: MediaQuery.of(context).size.width * 0.04,
                      bottom: MediaQuery.of(context).size.width * 0.04,
                    ),
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.width * 0.07,
                        bottom: MediaQuery.of(context).size.width * 0.07),
                    child: Text(
                      "Vehicle License",
                      style: TextStyle(
                          fontFamily: FontFamilies.POPPINS,
                          fontSize:
                              (MediaQuery.of(context).size.height * 0.02) + 5,
                          fontWeight: FontWeight.w500),
                    )),
                Container(
                  padding: EdgeInsets.only(
                      left: (MediaQuery.of(context).size.height * 0.02) + 20,
                      right: 15,
                      bottom: MediaQuery.of(context).size.width * 0.07),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Vehicle License Front Copy",
                            style: TextStyle(
                              fontFamily: FontFamilies.POPPINS,
                              fontSize:
                                  (MediaQuery.of(context).size.height * 0.02),
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              Container(
                                width: (MediaQuery.of(context).size.height *
                                        0.02) +
                                    15,
                                height: (MediaQuery.of(context).size.height *
                                        0.02) +
                                    15,
                                child: StreamBuilder(
                                  stream: newVehicleBloc.vehicleLicenseFront,
                                  builder: (context, snap) {
                                    if (snap.hasData) {
                                      return Container(
                                        width: 18,
                                        height: 18,
                                        child: CircleAvatar(
                                            child: GestureDetector(
                                              onTap: () async {
                                                FlutterStatusbarcolor
                                                    .setStatusBarColor(AppColors
                                                        .dialogStatusBar);
                                                await showDialog(
                                                        barrierDismissible: true,
                                                        context: context,
                                                        builder: (_) {
                                                          return WillPopScope(
                                                              onWillPop: () {
                                                                FlutterStatusbarcolor
                                                                    .setStatusBarColor(
                                                                        Colors
                                                                            .white);
                                                                return Future
                                                                    .value(
                                                                        true);
                                                              },
                                                              child: Stack(
                                                                  children: [
                                                                    PhotoView(
                                                                      backgroundDecoration: BoxDecoration(
                                                                          color: Colors
                                                                              .black12
                                                                              .withOpacity(0.01)),

                                                                      imageProvider:
                                                                          FileImage(
                                                                              snap.data),
                                                                      minScale:
                                                                          0.2,
                                                                      // initialScale: 0.2,
                                                                      maxScale:
                                                                          0.6,
                                                                      customSize:
                                                                          Size(
                                                                              300,
                                                                              400),
                                                                    ),
                                                                    Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .topRight,
                                                                      child:
                                                                          Container(
                                                                        margin:
                                                                            EdgeInsets.all(10),
                                                                        width:
                                                                            30,
                                                                        height:
                                                                            30,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          boxShadow: <
                                                                              BoxShadow>[
                                                                            BoxShadow(
                                                                              color: Colors.black26,
                                                                              blurRadius: 5,
                                                                              offset: Offset(2, 2),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        child: FloatingActionButton(
                                                                            heroTag: "dismiss2",
                                                                            elevation: 2.5,
                                                                            backgroundColor: Colors.white,
                                                                            child: Icon(
                                                                              Icons.close,
                                                                              color: Colors.black,
                                                                              size: 20,
                                                                            ),
                                                                            onPressed: () {
                                                                              Navigator.pop(context);
                                                                              FlutterStatusbarcolor.setStatusBarColor(Colors.white);
                                                                            }),
                                                                      ),
                                                                    )
                                                                  ]));
                                                        })
                                                    .then((value) =>
                                                        FlutterStatusbarcolor
                                                            .setStatusBarColor(
                                                                Colors.white));
                                              },
                                            ),
                                            radius: 50.0,
                                            backgroundImage:
                                                FileImage(snap.data)),
                                      );
                                    } else {
                                      return FloatingActionButton(
                                        heroTag: "btn7",
                                        elevation: 2.5,
                                        backgroundColor: Colors.white,
                                        child: Image.asset(
                                          "assets/images/camera.png",
                                          width: (MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.02),
                                          height: (MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.02),
                                        ),
                                        onPressed: () {
                                          FlutterStatusbarcolor
                                              .setStatusBarColor(
                                                  AppColors.dialogStatusBar);
                                          showDialog<void>(
                                                  context: context,
                                                  barrierDismissible: false,
                                                  // user must tap button!
                                                  builder: (BuildContext context) {
                                                    return WillPopScope(
                                                        onWillPop: () {
                                                          FlutterStatusbarcolor
                                                              .setStatusBarColor(
                                                                  Colors.white);
                                                          return Future.value(
                                                              true);
                                                        },
                                                        child: AlertDialog(
                                                          contentPadding:
                                                              EdgeInsets.all(8),
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          15.0))),
                                                          content:
                                                              SingleChildScrollView(
                                                            child: Container(
                                                              height: 50,
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceAround,
                                                                children: <
                                                                    Widget>[
                                                                  cameraNew(
                                                                      'VEHICLE_License_FRONT'),
                                                                  VerticalDivider(
                                                                    color: AppColors
                                                                        .labelColor,
                                                                  ),
                                                                  galleryNew(
                                                                      'VEHICLE_License_FRONT'),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ));
                                                  })
                                              .then((value) =>
                                                  FlutterStatusbarcolor
                                                      .setStatusBarColor(
                                                          Colors.white));
                                        },
                                      );
                                    }
                                  },
                                ),
                              ),
                              StreamBuilder(
                                stream: newVehicleBloc.vehicleLicenseFront,
                                builder: (context, snap) {
                                  if (snap.hasData) {
                                    return InkWell(
                                      onTap: () {
                                        FlutterStatusbarcolor.setStatusBarColor(
                                            AppColors.dialogStatusBar);
                                        showDialog<void>(
                                                context: context,
                                                barrierDismissible: false,
                                                // user must tap button!
                                                builder: (BuildContext context) {
                                                  return WillPopScope(
                                                      onWillPop: () {
                                                        FlutterStatusbarcolor
                                                            .setStatusBarColor(
                                                                Colors.white);
                                                        return Future.value(
                                                            true);
                                                      },
                                                      child: AlertDialog(
                                                        contentPadding:
                                                            EdgeInsets.all(8),
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius.all(
                                                                    Radius.circular(
                                                                        15.0))),
                                                        content:
                                                            SingleChildScrollView(
                                                          child: Container(
                                                            height: 50,
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceAround,
                                                              children: <
                                                                  Widget>[
                                                                cameraNew(
                                                                    'VEHICLE_License_FRONT'),
                                                                VerticalDivider(
                                                                  color: AppColors
                                                                      .labelColor,
                                                                ),
                                                                galleryNew(
                                                                    'VEHICLE_License_FRONT'),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ));
                                                })
                                            .then((value) =>
                                                FlutterStatusbarcolor
                                                    .setStatusBarColor(
                                                        Colors.white));
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 10),
                                        child: SvgPicture.asset(
                                            "assets/images/edit_pin.svg",
                                            width: (MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.02) +
                                                2,
                                            height: (MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.02) +
                                                2),
                                      ),
                                    );
                                  } else {
                                    return SizedBox(
                                      width:
                                          (MediaQuery.of(context).size.height *
                                                  0.02) +
                                              12,
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                    left: (MediaQuery.of(context).size.height * 0.02) + 20,
                    right: 15,
                  ),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Vehicle License Back Copy",
                            style: TextStyle(
                              fontFamily: FontFamilies.POPPINS,
                              fontSize:
                                  (MediaQuery.of(context).size.height * 0.02),
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              Container(
                                width: (MediaQuery.of(context).size.height *
                                        0.02) +
                                    15,
                                height: (MediaQuery.of(context).size.height *
                                        0.02) +
                                    15,
                                child: StreamBuilder(
                                  stream: newVehicleBloc.vehicleLicenseBack,
                                  builder: (context, snap) {
                                    if (snap.hasData) {
                                      FlutterStatusbarcolor.setStatusBarColor(
                                          Colors.white);
                                      return Container(
                                        width: 18,
                                        height: 18,
                                        child: CircleAvatar(
                                            child: GestureDetector(
                                              onTap: () async {
                                                FlutterStatusbarcolor
                                                    .setStatusBarColor(AppColors
                                                        .dialogStatusBar);
                                                await showDialog(
                                                        barrierDismissible: true,
                                                        context: context,
                                                        builder: (_) {
                                                          return WillPopScope(
                                                              onWillPop: () {
                                                                FlutterStatusbarcolor
                                                                    .setStatusBarColor(
                                                                        Colors
                                                                            .white);
                                                                return Future
                                                                    .value(
                                                                        true);
                                                              },
                                                              child: Stack(
                                                                  children: [
                                                                    PhotoView(
                                                                      backgroundDecoration: BoxDecoration(
                                                                          color: Colors
                                                                              .black12
                                                                              .withOpacity(0.01)),

                                                                      imageProvider:
                                                                          FileImage(
                                                                              snap.data),
                                                                      minScale:
                                                                          0.2,
                                                                      // initialScale: 0.2,
                                                                      maxScale:
                                                                          0.6,
                                                                      customSize:
                                                                          Size(
                                                                              300,
                                                                              400),
                                                                    ),
                                                                    Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .topRight,
                                                                      child:
                                                                          Container(
                                                                        margin:
                                                                            EdgeInsets.all(10),
                                                                        width:
                                                                            30,
                                                                        height:
                                                                            30,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          boxShadow: <
                                                                              BoxShadow>[
                                                                            BoxShadow(
                                                                              color: Colors.black26,
                                                                              blurRadius: 5,
                                                                              offset: Offset(2, 2),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        child: FloatingActionButton(
                                                                            heroTag: "dismiss2",
                                                                            elevation: 2.5,
                                                                            backgroundColor: Colors.white,
                                                                            child: Icon(
                                                                              Icons.close,
                                                                              color: Colors.black,
                                                                              size: 20,
                                                                            ),
                                                                            onPressed: () {
                                                                              Navigator.pop(context);
                                                                              FlutterStatusbarcolor.setStatusBarColor(Colors.white);
                                                                            }),
                                                                      ),
                                                                    )
                                                                  ]));
                                                        })
                                                    .then((value) =>
                                                        FlutterStatusbarcolor
                                                            .setStatusBarColor(
                                                                Colors.white));
                                              },
                                            ),
                                            radius: 50.0,
                                            backgroundImage:
                                                FileImage(snap.data)),
                                      );
                                    } else {
                                      return FloatingActionButton(
                                        heroTag: "btn8",
                                        elevation: 2.5,
                                        backgroundColor: Colors.white,
                                        child: Image.asset(
                                          "assets/images/camera.png",
                                          width: (MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.02),
                                          height: (MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.02),
                                        ),
                                        onPressed: () {
                                          FlutterStatusbarcolor
                                              .setStatusBarColor(
                                                  AppColors.dialogStatusBar);
                                          showDialog<void>(
                                                  context: context,
                                                  barrierDismissible: false,
                                                  // user must tap button!
                                                  builder: (BuildContext context) {
                                                    return WillPopScope(
                                                        onWillPop: () {
                                                          FlutterStatusbarcolor
                                                              .setStatusBarColor(
                                                                  Colors.white);
                                                          return Future.value(
                                                              true);
                                                        },
                                                        child: AlertDialog(
                                                          contentPadding:
                                                              EdgeInsets.all(8),
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          15.0))),
                                                          content:
                                                              SingleChildScrollView(
                                                            child: Container(
                                                              height: 50,
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceAround,
                                                                children: <
                                                                    Widget>[
                                                                  cameraNew(
                                                                      'VEHICLE_License_BACK'),
                                                                  VerticalDivider(
                                                                    color: AppColors
                                                                        .labelColor,
                                                                  ),
                                                                  galleryNew(
                                                                      'VEHICLE_License_BACK'),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ));
                                                  })
                                              .then((value) =>
                                                  FlutterStatusbarcolor
                                                      .setStatusBarColor(
                                                          Colors.white));
                                        },
                                      );
                                    }
                                  },
                                ),
                              ),
                              StreamBuilder(
                                stream: newVehicleBloc.vehicleLicenseBack,
                                builder: (context, snap) {
                                  if (snap.hasData) {
                                    return InkWell(
                                      onTap: () {
                                        FlutterStatusbarcolor.setStatusBarColor(
                                            AppColors.dialogStatusBar);
                                        showDialog<void>(
                                                context: context,
                                                barrierDismissible: false,
                                                // user must tap button!
                                                builder: (BuildContext context) {
                                                  return WillPopScope(
                                                      onWillPop: () {
                                                        FlutterStatusbarcolor
                                                            .setStatusBarColor(
                                                                Colors.white);
                                                        return Future.value(
                                                            true);
                                                      },
                                                      child: AlertDialog(
                                                        contentPadding:
                                                            EdgeInsets.all(8),
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius.all(
                                                                    Radius.circular(
                                                                        15.0))),
                                                        content: Container(
                                                          height: 50,
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceAround,
                                                            children: <Widget>[
                                                              cameraNew(
                                                                  'VEHICLE_License_BACK'),
                                                              VerticalDivider(
                                                                color: AppColors
                                                                    .labelColor,
                                                              ),
                                                              galleryNew(
                                                                  'VEHICLE_License_BACK'),
                                                            ],
                                                          ),
                                                        ),
                                                      ));
                                                })
                                            .then((value) =>
                                                FlutterStatusbarcolor
                                                    .setStatusBarColor(
                                                        Colors.white));
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 10),
                                        child: SvgPicture.asset(
                                            "assets/images/edit_pin.svg",
                                            width: (MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.02) +
                                                2,
                                            height: (MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.02) +
                                                2),
                                      ),
                                    );
                                  } else {
                                    return SizedBox(
                                      width:
                                          (MediaQuery.of(context).size.height *
                                                  0.02) +
                                              12,
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
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
              bottom: MediaQuery.of(context).size.width * 0.18,
              top: MediaQuery.of(context).size.width * 0.3,
              left: MediaQuery.of(context).size.width * 0.05,
              right: MediaQuery.of(context).size.width * 0.05,
            ),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width / 7,
            child: ButtonTheme(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                buttonColor: Colors.white,
                child: StreamBuilder(
                  stream: newVehicleBloc.submitValid2,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return RaisedButton(
                        onPressed: () {

                          newVehicleBloc.addCar();
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return ProfileScreen();
                            }),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Save ",
                              style: TextStyle(
                                fontFamily: FontFamilies.POPPINS,
                                fontSize: (MediaQuery.of(context).size.width *
                                        0.008) +
                                    FontSize.BUTTON_FONT_L,
                                color: Colors.black,
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward,
                              color: Colors.black,
                              size:
                                  (MediaQuery.of(context).size.width * 0.008) +
                                      18,
                            ),
                          ],
                        ),
                      );
                    } else {
                      return RaisedButton(
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Save ",
                              style: TextStyle(
                                fontFamily: FontFamilies.POPPINS,
                                fontSize: (MediaQuery.of(context).size.width *
                                        0.008) +
                                    FontSize.BUTTON_FONT_L,
                                color: AppColors.LIGHT_GREY,
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward,
                              color: AppColors.LIGHT_GREY,
                              size:
                                  (MediaQuery.of(context).size.width * 0.008) +
                                      18,
                            ),
                          ],
                        ),
                      );
                    }
                  },
                )),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 5),
            child: Image.asset("assets/images/home_indicator.png"),
          ),
        ],
      )),
    );
  }

  Widget cameraNew(String img) => StreamBuilder<File>(
        builder: (context, snap) {
          return FlatButton(
            color: Colors.white,
            child: Column(
              children: [
                Image.asset(
                  "assets/images/camera.png",
                  width: 30,
                  height: 30,
                ),
                Text("Camera",
                    style: TextStyle(
                        fontSize: 10,
                        color: AppColors.LIGHT_GREY,
                        fontFamily: 'Poppins'))
              ],
            ),
            onPressed: () {
              newVehicleBloc.updateImage(ImageSource.camera, img);
              Navigator.of(context).pop();
              FlutterStatusbarcolor.setStatusBarColor(Colors.white);
            },
          );
        },
      );

  Widget galleryNew(String img) => StreamBuilder<File>(
        builder: (context, snap) {
          return FlatButton(
            highlightColor: Colors.white,
            color: Colors.white,
            child: Column(children: [
              Image.asset(
                "assets/images/gallery.png",
                width: 35,
                height: 30,
              ),
              Text("Gallery",
                  style: TextStyle(
                      fontSize: 10,
                      color: AppColors.LIGHT_GREY,
                      fontFamily: 'Poppins'))
            ]),
            onPressed: () {
              FlutterStatusbarcolor.setStatusBarColor(Colors.white);
              newVehicleBloc.updateImage(ImageSource.gallery, img);
              Navigator.of(context).pop();
            },
          );
        },
      );
}
