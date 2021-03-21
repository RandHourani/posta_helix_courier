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
import 'package:posta_courier/src/blocs/signIn_and_createAccount_blocs/documents_bloc.dart';
import 'package:posta_courier/src/constants/constants.dart';
import 'package:posta_courier/src/constants/fonts_size.dart';
import 'package:posta_courier/src/ui/signIn_and_createAccount_screens/interview_screen.dart';
import 'package:posta_courier/src/ui/signIn_and_createAccount_screens/completed_info_screen.dart';
import 'package:posta_courier/src/ui/signIn_and_createAccount_screens/incompleted_info_screen.dart';

class DocumentsScreen extends StatelessWidget {
  CaptainData captainPersonalData;

  DocumentsScreen({this.captainPersonalData});

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.white);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

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
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.arrow_back,
                          color: AppColors.TITLE_TEXT_COLOR,
                          size: (MediaQuery.of(context).size.width * 0.04) +
                              FontSize.HEADING_FONT -
                              3,
                        ),
                      ),
                      Text(
                        "   UPLOAD  DOCUMENTS",
                        style: TextStyle(
                            color: AppColors.TITLE_TEXT_COLOR,
                            fontFamily: FontFamilies.POPPINS,
                            fontSize:
                                (MediaQuery.of(context).size.width * 0.04) +
                                    FontSize.HEADING_FONT -
                                    7,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Container(
                    color: AppColors.DOCUMENTS_LABEL,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(
                      left: (MediaQuery.of(context).size.height * 0.02) + 20,
                      right: MediaQuery.of(context).size.width * 0.04,
                      top: MediaQuery.of(context).size.width * 0.04,
                      bottom: MediaQuery.of(context).size.width * 0.04,
                    ),
                    margin: EdgeInsets.only(
                        top: 40,
                        bottom: MediaQuery.of(context).size.width * 0.07),
                    child: Text(
                      "Personal ID",
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
                            "ID Front Copy",
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
                                  stream: documentsBloc.idFront,
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
                                                          FlutterStatusbarcolor
                                                              .setStatusBarColor(
                                                                  AppColors
                                                                      .dialogStatusBar);
                                                          return WillPopScope(
                                                              onWillPop: () {
                                                                // FlutterStatusbarcolor
                                                                //     .setStatusBarColor(
                                                                //         Colors
                                                                //             .white);
                                                                return Future
                                                                    .value(
                                                                        true);
                                                              },
                                                              child: Stack(
                                                                  children: [
                                                                    PhotoView(
                                                                      backgroundDecoration:
                                                                          BoxDecoration(
                                                                        color: Colors
                                                                            .black12
                                                                            .withOpacity(0.01),
                                                                      ),
                                                                      imageProvider:
                                                                          FileImage(
                                                                        snap.data,
                                                                      ),
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
                                                                            heroTag: "dismiss",
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
                                      if (captainPersonalData != null) {
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
                                                            FlutterStatusbarcolor
                                                                .setStatusBarColor(
                                                                    AppColors
                                                                        .dialogStatusBar);
                                                            return WillPopScope(
                                                                onWillPop: () {
                                                                  // FlutterStatusbarcolor
                                                                  //     .setStatusBarColor(
                                                                  //         Colors
                                                                  //             .white);
                                                                  return Future
                                                                      .value(
                                                                          true);
                                                                },
                                                                child: Stack(
                                                                    children: [
                                                                      PhotoView(
                                                                        backgroundDecoration:
                                                                            BoxDecoration(
                                                                          color: Colors
                                                                              .black12
                                                                              .withOpacity(0.01),
                                                                        ),
                                                                        imageProvider:
                                                                            NetworkImage(Constants.MAIN_URL_FOR_DOCUMENTS +
                                                                                captainPersonalData.data.idCardF),
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
                                                                              heroTag: "dismiss",
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
                                              backgroundImage: NetworkImage(
                                                  Constants
                                                          .MAIN_URL_FOR_DOCUMENTS +
                                                      captainPersonalData
                                                          .data.idCardF)),
                                        );
                                      } else {
                                        return FloatingActionButton(
                                          heroTag: "btn1",
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
                                                    builder:
                                                        (BuildContext context) {
                                                      return WillPopScope(
                                                          onWillPop: () {
                                                            // FlutterStatusbarcolor
                                                            //     .setStatusBarColor(
                                                            //         Colors.white);
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
                                                                      'ID_FRONT'),
                                                                  VerticalDivider(
                                                                    color: AppColors
                                                                        .labelColor,
                                                                  ),
                                                                  galleryNew(
                                                                      'ID_FRONT'),
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
                                    }
                                  },
                                ),
                              ),
                              StreamBuilder(
                                stream: documentsBloc.idFront,
                                builder: (context, snap) {
                                  if (snap.hasData) {
                                    FlutterStatusbarcolor.setStatusBarColor(
                                        Colors.white);
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
                                                                  'ID_FRONT'),
                                                              VerticalDivider(
                                                                color: AppColors
                                                                    .labelColor,
                                                              ),
                                                              galleryNew(
                                                                  'ID_FRONT'),
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
                                    return captainPersonalData != null
                                        ? InkWell(
                                            onTap: () {
                                              FlutterStatusbarcolor
                                                  .setStatusBarColor(AppColors
                                                      .dialogStatusBar);
                                              showDialog<void>(
                                                      context: context,
                                                      barrierDismissible: false,
                                                      // user must tap button!
                                                      builder: (BuildContext
                                                          context) {
                                                        return WillPopScope(
                                                            onWillPop: () {
                                                              FlutterStatusbarcolor
                                                                  .setStatusBarColor(
                                                                      Colors
                                                                          .white);
                                                              return Future
                                                                  .value(true);
                                                            },
                                                            child: AlertDialog(
                                                              contentPadding:
                                                                  EdgeInsets
                                                                      .all(8),
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              15.0))),
                                                              content:
                                                                  Container(
                                                                height: 50,
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceAround,
                                                                  children: <
                                                                      Widget>[
                                                                    cameraNew(
                                                                        'ID_FRONT'),
                                                                    VerticalDivider(
                                                                      color: AppColors
                                                                          .labelColor,
                                                                    ),
                                                                    galleryNew(
                                                                        'ID_FRONT'),
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
                                              padding:
                                                  EdgeInsets.only(left: 10),
                                              child: SvgPicture.asset(
                                                  "assets/images/edit_pin.svg",
                                                  width: (MediaQuery.of(context)
                                                              .size
                                                              .height *
                                                          0.02) +
                                                      2,
                                                  height:
                                                      (MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.02) +
                                                          2),
                                            ),
                                          )
                                        : SizedBox(
                                            width: (MediaQuery.of(context)
                                                        .size
                                                        .height *
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
                            "ID Back Copy",
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
                                  stream: documentsBloc.idBack,
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
                                      if (captainPersonalData != null) {
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
                                                            FlutterStatusbarcolor
                                                                .setStatusBarColor(
                                                                    AppColors
                                                                        .dialogStatusBar);
                                                            return WillPopScope(
                                                                onWillPop: () {
                                                                  // FlutterStatusbarcolor
                                                                  //     .setStatusBarColor(
                                                                  //         Colors
                                                                  //             .white);
                                                                  return Future
                                                                      .value(
                                                                          true);
                                                                },
                                                                child: Stack(
                                                                    children: [
                                                                      PhotoView(
                                                                        backgroundDecoration:
                                                                            BoxDecoration(
                                                                          color: Colors
                                                                              .black12
                                                                              .withOpacity(0.01),
                                                                        ),
                                                                        imageProvider:
                                                                            NetworkImage(Constants.MAIN_URL_FOR_DOCUMENTS +
                                                                                captainPersonalData.data.idCardF),
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
                                                                              heroTag: "dismiss",
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
                                              backgroundImage: NetworkImage(
                                                  Constants
                                                          .MAIN_URL_FOR_DOCUMENTS +
                                                      captainPersonalData
                                                          .data.idCardB)),
                                        );
                                      } else {
                                        return FloatingActionButton(
                                          heroTag: "btn2",
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
                                                                      'ID_BACK'),
                                                                  VerticalDivider(
                                                                    color: AppColors
                                                                        .labelColor,
                                                                  ),
                                                                  galleryNew(
                                                                      'ID_BACK'),
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
                                    }
                                  },
                                ),
                              ),
                              StreamBuilder(
                                stream: documentsBloc.idBack,
                                builder: (context, snap) {
                                  if (snap.hasData) {
                                    FlutterStatusbarcolor.setStatusBarColor(
                                        Colors.white);
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
                                                                  'ID_BACK'),
                                                              VerticalDivider(
                                                                color: AppColors
                                                                    .labelColor,
                                                              ),
                                                              galleryNew(
                                                                  'ID_BACK'),
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
                                    return captainPersonalData != null
                                        ? InkWell(
                                            onTap: () {
                                              FlutterStatusbarcolor
                                                  .setStatusBarColor(AppColors
                                                      .dialogStatusBar);
                                              showDialog<void>(
                                                      context: context,
                                                      barrierDismissible: false,
                                                      // user must tap button!
                                                      builder: (BuildContext
                                                          context) {
                                                        return WillPopScope(
                                                            onWillPop: () {
                                                              FlutterStatusbarcolor
                                                                  .setStatusBarColor(
                                                                      Colors
                                                                          .white);
                                                              return Future
                                                                  .value(true);
                                                            },
                                                            child: AlertDialog(
                                                              contentPadding:
                                                                  EdgeInsets
                                                                      .all(8),
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              15.0))),
                                                              content:
                                                                  Container(
                                                                height: 50,
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceAround,
                                                                  children: <
                                                                      Widget>[
                                                                    cameraNew(
                                                                        'ID_BACK'),
                                                                    VerticalDivider(
                                                                      color: AppColors
                                                                          .labelColor,
                                                                    ),
                                                                    galleryNew(
                                                                        'ID_BACK'),
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
                                              padding:
                                                  EdgeInsets.only(left: 10),
                                              child: SvgPicture.asset(
                                                  "assets/images/edit_pin.svg",
                                                  width: (MediaQuery.of(context)
                                                              .size
                                                              .height *
                                                          0.02) +
                                                      2,
                                                  height:
                                                      (MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.02) +
                                                          2),
                                            ),
                                          )
                                        : SizedBox(
                                            width: (MediaQuery.of(context)
                                                        .size
                                                        .height *
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
                      "Driver License",
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
                            "Driver License Front Copy",
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
                                  stream: documentsBloc.driverLicenseFront,
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
                                                await showDialog(
                                                        barrierDismissible: true,
                                                        context: context,
                                                        builder: (_) {
                                                          FlutterStatusbarcolor
                                                              .setStatusBarColor(
                                                                  AppColors
                                                                      .dialogStatusBar);

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
                                      if (captainPersonalData != null) {
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
                                                            FlutterStatusbarcolor
                                                                .setStatusBarColor(
                                                                    AppColors
                                                                        .dialogStatusBar);
                                                            return WillPopScope(
                                                                onWillPop: () {
                                                                  // FlutterStatusbarcolor
                                                                  //     .setStatusBarColor(
                                                                  //         Colors
                                                                  //             .white);
                                                                  return Future
                                                                      .value(
                                                                          true);
                                                                },
                                                                child: Stack(
                                                                    children: [
                                                                      PhotoView(
                                                                        backgroundDecoration:
                                                                            BoxDecoration(
                                                                          color: Colors
                                                                              .black12
                                                                              .withOpacity(0.01),
                                                                        ),
                                                                        imageProvider:
                                                                            NetworkImage(Constants.MAIN_URL_FOR_DOCUMENTS +
                                                                                captainPersonalData.data.idCardF),
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
                                                                              heroTag: "dismiss",
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
                                              backgroundImage: NetworkImage(
                                                  Constants
                                                          .MAIN_URL_FOR_DOCUMENTS +
                                                      captainPersonalData.data
                                                          .drivingCertificateF)),
                                        );
                                      } else {
                                        return FloatingActionButton(
                                          heroTag: "btn3",
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
                                                                        'DRIVER_LICENSE_FRONT'),
                                                                    VerticalDivider(
                                                                      color: AppColors
                                                                          .labelColor,
                                                                    ),
                                                                    galleryNew(
                                                                        'DRIVER_LICENSE_FRONT'),
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
                                    }
                                  },
                                ),
                              ),
                              StreamBuilder(
                                stream: documentsBloc.driverLicenseFront,
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
                                                                  'DRIVER_LICENSE_FRONT'),
                                                              VerticalDivider(
                                                                color: AppColors
                                                                    .labelColor,
                                                              ),
                                                              galleryNew(
                                                                  'DRIVER_LICENSE_FRONT'),
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
                                    return captainPersonalData != null
                                        ? InkWell(
                                            onTap: () {
                                              FlutterStatusbarcolor
                                                  .setStatusBarColor(AppColors
                                                      .dialogStatusBar);
                                              showDialog<void>(
                                                      context: context,
                                                      barrierDismissible: false,
                                                      // user must tap button!
                                                      builder: (BuildContext
                                                          context) {
                                                        return WillPopScope(
                                                            onWillPop: () {
                                                              FlutterStatusbarcolor
                                                                  .setStatusBarColor(
                                                                      Colors
                                                                          .white);
                                                              return Future
                                                                  .value(true);
                                                            },
                                                            child: AlertDialog(
                                                              contentPadding:
                                                                  EdgeInsets
                                                                      .all(8),
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              15.0))),
                                                              content:
                                                                  Container(
                                                                height: 50,
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceAround,
                                                                  children: <
                                                                      Widget>[
                                                                    cameraNew(
                                                                        'DRIVER_LICENSE_FRONT'),
                                                                    VerticalDivider(
                                                                      color: AppColors
                                                                          .labelColor,
                                                                    ),
                                                                    galleryNew(
                                                                        'DRIVER_LICENSE_FRONT'),
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
                                              padding:
                                                  EdgeInsets.only(left: 10),
                                              child: SvgPicture.asset(
                                                  "assets/images/edit_pin.svg",
                                                  width: (MediaQuery.of(context)
                                                              .size
                                                              .height *
                                                          0.02) +
                                                      2,
                                                  height:
                                                      (MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.02) +
                                                          2),
                                            ),
                                          )
                                        : SizedBox(
                                            width: (MediaQuery.of(context)
                                                        .size
                                                        .height *
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
                            "Driver License Back Copy",
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
                                  stream: documentsBloc.driverLicenseBack,
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
                                      if (captainPersonalData != null) {
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
                                                            FlutterStatusbarcolor
                                                                .setStatusBarColor(
                                                                    AppColors
                                                                        .dialogStatusBar);
                                                            return WillPopScope(
                                                                onWillPop: () {
                                                                  // FlutterStatusbarcolor
                                                                  //     .setStatusBarColor(
                                                                  //         Colors
                                                                  //             .white);
                                                                  return Future
                                                                      .value(
                                                                          true);
                                                                },
                                                                child: Stack(
                                                                    children: [
                                                                      PhotoView(
                                                                        backgroundDecoration:
                                                                            BoxDecoration(
                                                                          color: Colors
                                                                              .black12
                                                                              .withOpacity(0.01),
                                                                        ),
                                                                        imageProvider:
                                                                            NetworkImage(Constants.MAIN_URL_FOR_DOCUMENTS +
                                                                                captainPersonalData.data.idCardF),
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
                                                                              heroTag: "dismiss",
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
                                              backgroundImage: NetworkImage(
                                                  Constants
                                                          .MAIN_URL_FOR_DOCUMENTS +
                                                      captainPersonalData.data
                                                          .drivingCertificateB)),
                                        );
                                      } else {
                                        return FloatingActionButton(
                                          heroTag: "btn4",
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
                                                                        'DRIVER_LICENSE_BACK'),
                                                                    VerticalDivider(
                                                                      color: AppColors
                                                                          .labelColor,
                                                                    ),
                                                                    galleryNew(
                                                                        'DRIVER_LICENSE_BACK'),
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
                                    }
                                  },
                                ),
                              ),
                              StreamBuilder(
                                stream: documentsBloc.driverLicenseBack,
                                builder: (context, snap) {
                                  if (snap.hasData) {
                                    return InkWell(
                                      onTap: () {
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
                                                                  'DRIVER_LICENSE_BACK'),
                                                              VerticalDivider(
                                                                color: AppColors
                                                                    .labelColor,
                                                              ),
                                                              galleryNew(
                                                                  'DRIVER_LICENSE_BACK'),
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
                                    return captainPersonalData != null
                                        ? InkWell(
                                            onTap: () {
                                              FlutterStatusbarcolor
                                                  .setStatusBarColor(AppColors
                                                      .dialogStatusBar);
                                              showDialog<void>(
                                                      context: context,
                                                      barrierDismissible: false,
                                                      // user must tap button!
                                                      builder: (BuildContext
                                                          context) {
                                                        return WillPopScope(
                                                            onWillPop: () {
                                                              FlutterStatusbarcolor
                                                                  .setStatusBarColor(
                                                                      Colors
                                                                          .white);
                                                              return Future
                                                                  .value(true);
                                                            },
                                                            child: AlertDialog(
                                                              contentPadding:
                                                                  EdgeInsets
                                                                      .all(8),
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              15.0))),
                                                              content:
                                                                  Container(
                                                                height: 50,
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceAround,
                                                                  children: <
                                                                      Widget>[
                                                                    cameraNew(
                                                                        'DRIVER_LICENSE_BACK'),
                                                                    VerticalDivider(
                                                                      color: AppColors
                                                                          .labelColor,
                                                                    ),
                                                                    galleryNew(
                                                                        'DRIVER_LICENSE_BACK'),
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
                                              padding:
                                                  EdgeInsets.only(left: 10),
                                              child: SvgPicture.asset(
                                                  "assets/images/edit_pin.svg",
                                                  width: (MediaQuery.of(context)
                                                              .size
                                                              .height *
                                                          0.02) +
                                                      2,
                                                  height:
                                                      (MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.02) +
                                                          2),
                                            ),
                                          )
                                        : SizedBox(
                                            width: (MediaQuery.of(context)
                                                        .size
                                                        .height *
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
                                  stream: documentsBloc.insuranceFront,
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
                                                                Colors.white));
                                              },
                                            ),
                                            radius: 50.0,
                                            backgroundImage:
                                                FileImage(snap.data)),
                                      );
                                    } else {
                                      if (captainPersonalData != null) {
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
                                                            FlutterStatusbarcolor
                                                                .setStatusBarColor(
                                                                    AppColors
                                                                        .dialogStatusBar);
                                                            return WillPopScope(
                                                                onWillPop: () {
                                                                  // FlutterStatusbarcolor
                                                                  //     .setStatusBarColor(
                                                                  //         Colors
                                                                  //             .white);
                                                                  return Future
                                                                      .value(
                                                                          true);
                                                                },
                                                                child: Stack(
                                                                    children: [
                                                                      PhotoView(
                                                                        backgroundDecoration:
                                                                            BoxDecoration(
                                                                          color: Colors
                                                                              .black12
                                                                              .withOpacity(0.01),
                                                                        ),
                                                                        imageProvider:
                                                                            NetworkImage(Constants.MAIN_URL_FOR_DOCUMENTS +
                                                                                captainPersonalData.data.idCardF),
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
                                                                              heroTag: "dismiss",
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
                                              backgroundImage: NetworkImage(Constants
                                                      .MAIN_URL_FOR_DOCUMENTS +
                                                  captainPersonalData.data.car
                                                      .insuranceDocumentFront)),
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
                                    }
                                  },
                                ),
                              ),
                              StreamBuilder(
                                stream: documentsBloc.insuranceFront,
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
                                    return captainPersonalData != null
                                        ? InkWell(
                                            onTap: () {
                                              FlutterStatusbarcolor
                                                  .setStatusBarColor(AppColors
                                                      .dialogStatusBar);
                                              showDialog<void>(
                                                      context: context,
                                                      barrierDismissible: false,
                                                      // user must tap button!
                                                      builder: (BuildContext
                                                          context) {
                                                        return WillPopScope(
                                                            onWillPop: () {
                                                              FlutterStatusbarcolor
                                                                  .setStatusBarColor(
                                                                      Colors
                                                                          .white);
                                                              return Future
                                                                  .value(true);
                                                            },
                                                            child: AlertDialog(
                                                              contentPadding:
                                                                  EdgeInsets
                                                                      .all(8),
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              15.0))),
                                                              content:
                                                                  Container(
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
                                            child: Padding(
                                              padding:
                                                  EdgeInsets.only(left: 10),
                                              child: SvgPicture.asset(
                                                  "assets/images/edit_pin.svg",
                                                  width: (MediaQuery.of(context)
                                                              .size
                                                              .height *
                                                          0.02) +
                                                      2,
                                                  height:
                                                      (MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.02) +
                                                          2),
                                            ),
                                          )
                                        : SizedBox(
                                            width: (MediaQuery.of(context)
                                                        .size
                                                        .height *
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
                                  stream: documentsBloc.insuranceBack,
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
                                      if (captainPersonalData != null) {
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
                                                            FlutterStatusbarcolor
                                                                .setStatusBarColor(
                                                                    AppColors
                                                                        .dialogStatusBar);
                                                            return WillPopScope(
                                                                onWillPop: () {
                                                                  // FlutterStatusbarcolor
                                                                  //     .setStatusBarColor(
                                                                  //         Colors
                                                                  //             .white);
                                                                  return Future
                                                                      .value(
                                                                          true);
                                                                },
                                                                child: Stack(
                                                                    children: [
                                                                      PhotoView(
                                                                        backgroundDecoration:
                                                                            BoxDecoration(
                                                                          color: Colors
                                                                              .black12
                                                                              .withOpacity(0.01),
                                                                        ),
                                                                        imageProvider:
                                                                            NetworkImage(Constants.MAIN_URL_FOR_DOCUMENTS +
                                                                                captainPersonalData.data.idCardF),
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
                                                                              heroTag: "dismiss",
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
                                              backgroundImage: NetworkImage(Constants
                                                      .MAIN_URL_FOR_DOCUMENTS +
                                                  captainPersonalData.data.car
                                                      .insuranceDocumentBack)),
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
                                    }
                                  },
                                ),
                              ),
                              StreamBuilder(
                                stream: documentsBloc.insuranceBack,
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
                                    return captainPersonalData != null
                                        ? InkWell(
                                            onTap: () {
                                              FlutterStatusbarcolor
                                                  .setStatusBarColor(AppColors
                                                      .dialogStatusBar);
                                              showDialog<void>(
                                                      context: context,
                                                      barrierDismissible: false,
                                                      // user must tap button!
                                                      builder: (BuildContext
                                                          context) {
                                                        return WillPopScope(
                                                            onWillPop: () {
                                                              FlutterStatusbarcolor
                                                                  .setStatusBarColor(
                                                                      Colors
                                                                          .white);
                                                              return Future
                                                                  .value(true);
                                                            },
                                                            child: AlertDialog(
                                                              contentPadding:
                                                                  EdgeInsets
                                                                      .all(8),
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              15.0))),
                                                              content:
                                                                  Container(
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
                                                            ));
                                                      })
                                                  .then((value) =>
                                                      FlutterStatusbarcolor
                                                          .setStatusBarColor(
                                                              Colors.white));
                                            },
                                            child: Padding(
                                              padding:
                                                  EdgeInsets.only(left: 10),
                                              child: SvgPicture.asset(
                                                  "assets/images/edit_pin.svg",
                                                  width: (MediaQuery.of(context)
                                                              .size
                                                              .height *
                                                          0.02) +
                                                      2,
                                                  height:
                                                      (MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.02) +
                                                          2),
                                            ),
                                          )
                                        : SizedBox(
                                            width: (MediaQuery.of(context)
                                                        .size
                                                        .height *
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
                                  stream: documentsBloc.vehicleLicenseFront,
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
                                                                            heroTag: "dismiss7",
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
                                      if (captainPersonalData != null) {
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
                                                            FlutterStatusbarcolor
                                                                .setStatusBarColor(
                                                                    AppColors
                                                                        .dialogStatusBar);
                                                            return WillPopScope(
                                                                onWillPop: () {
                                                                  // FlutterStatusbarcolor
                                                                  //     .setStatusBarColor(
                                                                  //         Colors
                                                                  //             .white);
                                                                  return Future
                                                                      .value(
                                                                          true);
                                                                },
                                                                child: Stack(
                                                                    children: [
                                                                      PhotoView(
                                                                        backgroundDecoration:
                                                                            BoxDecoration(
                                                                          color: Colors
                                                                              .black12
                                                                              .withOpacity(0.01),
                                                                        ),
                                                                        imageProvider:
                                                                            NetworkImage(Constants.MAIN_URL_FOR_DOCUMENTS +
                                                                                captainPersonalData.data.car.carDocumentFront),
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
                                                                              heroTag: "dismiss",
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
                                              backgroundImage: NetworkImage(
                                                  Constants
                                                          .MAIN_URL_FOR_DOCUMENTS +
                                                      captainPersonalData
                                                          .data
                                                          .car
                                                          .carDocumentFront)),
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
                                                          ));
                                                    })
                                                .then((value) =>
                                                    FlutterStatusbarcolor
                                                        .setStatusBarColor(
                                                            Colors.white));
                                          },
                                        );
                                      }
                                    }
                                  },
                                ),
                              ),
                              StreamBuilder(
                                stream: documentsBloc.vehicleLicenseFront,
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
                                    return captainPersonalData != null
                                        ? InkWell(
                                            onTap: () {
                                              FlutterStatusbarcolor
                                                  .setStatusBarColor(AppColors
                                                      .dialogStatusBar);
                                              showDialog<void>(
                                                      context: context,
                                                      barrierDismissible: false,
                                                      // user must tap button!
                                                      builder: (BuildContext
                                                          context) {
                                                        return WillPopScope(
                                                            onWillPop: () {
                                                              FlutterStatusbarcolor
                                                                  .setStatusBarColor(
                                                                      Colors
                                                                          .white);
                                                              return Future
                                                                  .value(true);
                                                            },
                                                            child: AlertDialog(
                                                              contentPadding:
                                                                  EdgeInsets
                                                                      .all(8),
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              15.0))),
                                                              content:
                                                                  Container(
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
                                                            ));
                                                      })
                                                  .then((value) =>
                                                      FlutterStatusbarcolor
                                                          .setStatusBarColor(
                                                              Colors.white));
                                            },
                                            child: Padding(
                                              padding:
                                                  EdgeInsets.only(left: 10),
                                              child: SvgPicture.asset(
                                                  "assets/images/edit_pin.svg",
                                                  width: (MediaQuery.of(context)
                                                              .size
                                                              .height *
                                                          0.02) +
                                                      2,
                                                  height:
                                                      (MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.02) +
                                                          2),
                                            ),
                                          )
                                        : SizedBox(
                                            width: (MediaQuery.of(context)
                                                        .size
                                                        .height *
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
                                  stream: documentsBloc.vehicleLicenseBack,
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
                                                                            heroTag: "dismiss8",
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
                                      if (captainPersonalData != null) {
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
                                                            FlutterStatusbarcolor
                                                                .setStatusBarColor(
                                                                    AppColors
                                                                        .dialogStatusBar);
                                                            return WillPopScope(
                                                                onWillPop: () {
                                                                  // FlutterStatusbarcolor
                                                                  //     .setStatusBarColor(
                                                                  //         Colors
                                                                  //             .white);
                                                                  return Future
                                                                      .value(
                                                                          true);
                                                                },
                                                                child: Stack(
                                                                    children: [
                                                                      PhotoView(
                                                                        backgroundDecoration:
                                                                            BoxDecoration(
                                                                          color: Colors
                                                                              .black12
                                                                              .withOpacity(0.01),
                                                                        ),
                                                                        imageProvider:
                                                                            NetworkImage(Constants.MAIN_URL_FOR_DOCUMENTS +
                                                                                captainPersonalData.data.car.carDocumentBack),
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
                                                                              heroTag: "dismiss7",
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
                                              backgroundImage: NetworkImage(
                                                  Constants
                                                          .MAIN_URL_FOR_DOCUMENTS +
                                                      captainPersonalData
                                                          .data
                                                          .car
                                                          .carDocumentBack)),
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
                                        );
                                      }
                                    }
                                  },
                                ),
                              ),
                              StreamBuilder(
                                stream: documentsBloc.vehicleLicenseBack,
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
                                    return captainPersonalData != null
                                        ? InkWell(
                                            onTap: () {
                                              FlutterStatusbarcolor
                                                  .setStatusBarColor(AppColors
                                                      .dialogStatusBar);
                                              showDialog<void>(
                                                      context: context,
                                                      barrierDismissible: false,
                                                      // user must tap button!
                                                      builder: (BuildContext
                                                          context) {
                                                        return WillPopScope(
                                                            onWillPop: () {
                                                              FlutterStatusbarcolor
                                                                  .setStatusBarColor(
                                                                      Colors
                                                                          .white);
                                                              return Future
                                                                  .value(true);
                                                            },
                                                            child: AlertDialog(
                                                              contentPadding:
                                                                  EdgeInsets
                                                                      .all(8),
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              15.0))),
                                                              content:
                                                                  Container(
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
                                                            ));
                                                      })
                                                  .then((value) =>
                                                      FlutterStatusbarcolor
                                                          .setStatusBarColor(
                                                              Colors.white));
                                            },
                                            child: Padding(
                                              padding:
                                                  EdgeInsets.only(left: 10),
                                              child: SvgPicture.asset(
                                                  "assets/images/edit_pin.svg",
                                                  width: (MediaQuery.of(context)
                                                              .size
                                                              .height *
                                                          0.02) +
                                                      2,
                                                  height:
                                                      (MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.02) +
                                                          2),
                                            ),
                                          )
                                        : SizedBox(
                                            width: (MediaQuery.of(context)
                                                        .size
                                                        .height *
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
                    top: MediaQuery.of(context).size.width * 0.08,
                    bottom: MediaQuery.of(context).size.width * 0.08,
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
                      child: captainPersonalData == null
                          ? StreamBuilder(
                              stream: documentsBloc.submitValid,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return RaisedButton(
                                    onPressed: () {
                                      documentsBloc.uploadDocumentImages();
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) {
                                          return InterviewScreen();
                                        }),
                                      );
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(left: 20),
                                          child: Text(
                                            "Continue",
                                            style: TextStyle(
                                              fontFamily: FontFamilies.POPPINS,
                                              fontSize: (MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.008) +
                                                  FontSize.BUTTON_FONT_L,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(right: 10),
                                          child: Icon(
                                            Icons.arrow_forward,
                                            color: Colors.black,
                                            size: (MediaQuery
                                                .of(context)
                                                .size
                                                .width *
                                                0.008) +
                                                18,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                } else {
                                  return RaisedButton(
                                    onPressed: () {},
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(left: 20),
                                          child: Text(
                                            "Continue",
                                            style: TextStyle(
                                              fontFamily: FontFamilies.POPPINS,
                                              fontSize: (MediaQuery
                                                  .of(context)
                                                  .size
                                                  .width *
                                                  0.008) +
                                                  FontSize.BUTTON_FONT_L,
                                              color: AppColors.LIGHT_GREY,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(right: 10),
                                          child: Icon(
                                            Icons.arrow_forward,
                                            color: AppColors.LIGHT_GREY,
                                            size: (MediaQuery
                                                .of(context)
                                                .size
                                                .width *
                                                0.008) +
                                                18,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                              },
                      )
                          : RaisedButton(
                        onPressed: () {
                          documentsBloc.uploadDocumentImages();
                          if (captainPersonalData.data.car != null) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) {
                                return CompletedInfoScreen();
                              }),
                            );
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) {
                                return InCompletedInfoScreen();
                              }),
                            );
                          }
                        },
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: Text(
                                "Continue",
                                style: TextStyle(
                                  fontFamily: FontFamilies.POPPINS,
                                  fontSize:
                                  (MediaQuery
                                      .of(context)
                                      .size
                                      .width *
                                      0.008) +
                                      FontSize.BUTTON_FONT_L,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 10),
                              child: Icon(
                                Icons.arrow_forward,
                                color: Colors.black,
                                size: (MediaQuery
                                    .of(context)
                                    .size
                                    .width *
                                    0.008) +
                                    18,
                              ),
                            ),
                          ],
                        ),
                      )),
                ),
              ],
            ),
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
              documentsBloc.updateImage(ImageSource.camera, img);
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
              documentsBloc.updateImage(ImageSource.gallery, img);
              Navigator.of(context).pop();
            },
          );
        },
      );
}
