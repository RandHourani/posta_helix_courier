import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:posta_courier/src/ui/widgets/dialog_loading.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_view/photo_view.dart';
import 'package:posta_courier/models/ride_model.dart';
import 'package:posta_courier/src/blocs/home_blocs/order_bloc.dart';
import 'package:posta_courier/src/blocs/home_blocs/pod_bloc.dart';
import 'package:posta_courier/src/constants/application_colors_value.dart';
import 'package:posta_courier/src/constants/fonts_size.dart';
import 'package:posta_courier/src/ui/home/payment/payment_with_cod_screen.dart';
import 'package:posta_courier/src/ui/home/payment/payment_without_cod_screen.dart';
import 'package:signature/signature.dart';
import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:path/path.dart' as path;

class PodScreen extends StatelessWidget {
  String screen;
  String shipmentCase;

  PodScreen({this.screen, this.shipmentCase});

  final SignatureController _controller = SignatureController(
    penStrokeWidth: 0.8,
    penColor: Colors.black,
    exportBackgroundColor: Colors.black12,
  );
  FocusNode referenceNode = new FocusNode();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);

    return _podDialog(context);
  }

  _podDialog(context) {
    return AlertDialog(
      contentPadding: EdgeInsets.all(15),
      content: Container(
          color: Colors.white,
          margin: EdgeInsets.only(
            top: 10,
          ),
          height: 720,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: SvgPicture.asset(
                    "assets/images/pod.svg",
                    width: 50,
                    height: 50,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 15, bottom: 10),
                  child: Text(
                    "Please set your signature of shipper or upload photo",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: AppColors.TITLE_TEXT_COLOR,
                      fontFamily: FontFamilies.POPPINS,
                      fontSize: (MediaQuery.of(context).size.height * 0.018) + 4,
                    ),
                  ),
                ),
                Divider(
                  thickness: 1,
                  color: AppColors.LIGHT_GREY,
                ),
                referenceTextField(),

                Divider(
                  thickness: 1,
                  color: AppColors.LIGHT_GREY,
                ),
                Container(
                  margin: EdgeInsets.only(top: 10, bottom: 10, left: 7),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Take Photo",
                        style: TextStyle(
                          fontFamily: FontFamilies.POPPINS,
                          fontSize: (MediaQuery.of(context).size.height * 0.02),
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Container(
                            width:
                            (MediaQuery.of(context).size.height * 0.02) + 15,
                            height:
                            (MediaQuery.of(context).size.height * 0.02) + 15,
                            child: StreamBuilder(
                              stream: podBloc.image,
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
                                                AppColors.dialogStatusBar);
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
                                                        return Future.value(
                                                            true);
                                                      },
                                                      child: Stack(children: [
                                                        PhotoView(
                                                          backgroundDecoration:
                                                          BoxDecoration(
                                                            color: Colors
                                                                .black12
                                                                .withOpacity(
                                                                0.01),
                                                          ),
                                                          imageProvider:
                                                          FileImage(
                                                            snap.data,
                                                          ),
                                                          minScale: 0.2,
                                                          // initialScale: 0.2,
                                                          maxScale: 0.6,
                                                          customSize:
                                                          Size(300, 400),
                                                        ),
                                                        Align(
                                                          alignment: Alignment
                                                              .topRight,
                                                          child: Container(
                                                            margin: EdgeInsets
                                                                .all(10),
                                                            width: 30,
                                                            height: 30,
                                                            decoration:
                                                            BoxDecoration(
                                                              boxShadow: <
                                                                  BoxShadow>[
                                                                BoxShadow(
                                                                  color: Colors
                                                                      .black26,
                                                                  blurRadius:
                                                                  5,
                                                                  offset:
                                                                  Offset(
                                                                      2,
                                                                      2),
                                                                ),
                                                              ],
                                                            ),
                                                            child:
                                                            FloatingActionButton(
                                                                heroTag:
                                                                "dismiss",
                                                                elevation:
                                                                2.5,
                                                                backgroundColor:
                                                                Colors
                                                                    .white,
                                                                child:
                                                                Icon(
                                                                  Icons
                                                                      .close,
                                                                  color: Colors
                                                                      .black,
                                                                  size:
                                                                  20,
                                                                ),
                                                                onPressed:
                                                                    () {
                                                                  Navigator.pop(
                                                                      context);
                                                                  FlutterStatusbarcolor.setStatusBarColor(
                                                                      Colors.white);
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
                                        backgroundImage: FileImage(snap.data)),
                                  );
                                } else {
                                  return FloatingActionButton(
                                    heroTag: "btn1",
                                    elevation: 2.5,
                                    backgroundColor: Colors.white,
                                    child: Image.asset(
                                      "assets/images/camera.png",
                                      width: (MediaQuery.of(context).size.height *
                                          0.02),
                                      height:
                                      (MediaQuery.of(context).size.height *
                                          0.02),
                                    ),
                                    onPressed: () {
                                      FlutterStatusbarcolor.setStatusBarColor(
                                          AppColors.dialogStatusBar);
                                      showDialog<void>(
                                        context: context,
                                        barrierDismissible: false,
                                        // user must tap button!
                                        builder: (BuildContext context) {
                                          return image(context);
                                        },
                                      );
                                    },
                                  );
                                }
                              },
                            ),
                          ),
                          StreamBuilder(
                            stream: podBloc.image,
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
                                                return Future.value(true);
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
                                                      cameraNew(),
                                                      VerticalDivider(
                                                        color: AppColors
                                                            .labelColor,
                                                      ),
                                                      galleryNew(),
                                                    ],
                                                  ),
                                                ),
                                              ));
                                        })
                                        .then((value) => FlutterStatusbarcolor
                                        .setStatusBarColor(Colors.white));
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 10),
                                    child: SvgPicture.asset(
                                        "assets/images/edit_pin.svg",
                                        width:
                                        (MediaQuery.of(context).size.height *
                                            0.02) +
                                            2,
                                        height:
                                        (MediaQuery.of(context).size.height *
                                            0.02) +
                                            2),
                                  ),
                                );
                              } else {
                                return SizedBox(
                                  width: (MediaQuery.of(context).size.height *
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
                ),
                Divider(
                  thickness: 1,
                  color: AppColors.LIGHT_GREY,
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 15, top: 10),
                  child: Text(
                    "Set Signature",
                    style: TextStyle(
                      fontFamily: FontFamilies.POPPINS,
                      fontSize: (MediaQuery.of(context).size.height * 0.02),
                    ),
                  ),
                ),
                Column(
                  children: [
                    Signature(
                      controller: _controller,
                      height: 200,
                      width: 300,
                      backgroundColor: AppColors.SIGNATURE_COLOR,
                    ),
                    Container(
                      width: 300,
                      decoration: BoxDecoration(
                          color: AppColors.SIGNATURE_COLOR,
                          border: Border(
                              top: BorderSide(
                                  color: AppColors.LIGHT_GREY, width: 1.0))),
                      child: RaisedButton(
                        onPressed: () {
                          _controller.clear();
                        },
                        child: Text(
                          "Clear",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: AppColors.LIGHT_GREY,
                            fontFamily: FontFamilies.POPPINS,
                            fontSize:
                            (MediaQuery.of(context).size.height * 0.018) + 2,
                          ),
                        ),
                        color: AppColors.SIGNATURE_COLOR,
                        elevation: 0,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 0),
                      child: Row(
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
                                Navigator.pop(context);
                              },
                              child: Text(
                                "Cancel",
                                style: TextStyle(
                                    fontFamily: FontFamilies.POPPINS,
                                    fontSize: (MediaQuery.of(context).size.width *
                                        0.008) +
                                        11,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                          StreamBuilder(
                            stream: podBloc.submitValid,
                            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                              if(snapshot.hasData)
                              {return  Container(
                                height: 50,
                                width: 160,
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  elevation: 3,
                                  color: AppColors.MAIN_COLOR,
                                  onPressed: () {
                                    // getSign();
                                    orderBloc.bookingAction();
                                    Navigator.of(context).pop(true);
                                    _showDialog(context);

                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left:
                                        MediaQuery.of(context).size.width * 0.02),
                                    child: Text(
                                      "Submit",
                                      style: TextStyle(
                                          fontFamily: FontFamilies.POPPINS,
                                          fontSize:
                                          (MediaQuery.of(context).size.width *
                                              0.008) +
                                              11,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                ),
                              );}
                              else
                              {
                                return  Container(
                                  height: 50,
                                  width: 160,
                                  child: RaisedButton(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    elevation: 3,
                                    color: AppColors.LIGHT_GREY,
                                    onPressed: () {

                                    },
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left:
                                          MediaQuery.of(context).size.width * 0.02),
                                      child: Text(
                                        "Submit",
                                        style: TextStyle(
                                            fontFamily: FontFamilies.POPPINS,
                                            fontSize:
                                            (MediaQuery.of(context).size.width *
                                                0.008) +
                                                11,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                  ),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          )),
    );
  }

  Widget referenceTextField() => StreamBuilder<String>(
    stream: podBloc.reference,
    builder: (context, snap) {
      return Container(
        margin: EdgeInsets.only(top: 20),
        child: TextFormField(
          style: TextStyle(
            fontFamily: FontFamilies.POPPINS,
            fontSize: (MediaQuery.of(context).size.height * 0.02),
          ),
          focusNode: referenceNode,
          cursorColor: AppColors.MAIN_COLOR,
          keyboardType: TextInputType.text,
          decoration: new InputDecoration(
            contentPadding: EdgeInsets.all(0),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.LIGHT_BLUE),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.MAIN_COLOR),
            ),
            errorText: snap.error,
            labelText: 'Enter Reference',
            labelStyle: TextStyle(
                color: AppColors.labelColor, fontFamily: 'Poppins'),
          ),
          onChanged: (podBloc.changeReference),
        ),
      );
    },
  );

  image(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      content: Container(
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            cameraNew(),
            VerticalDivider(
              color: AppColors.labelColor,
            ),
            galleryNew(),
          ],
        ),
      ),
    );
  }

  Widget cameraNew() => StreamBuilder<File>(
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
              podBloc.updateImage(ImageSource.camera);
              Navigator.of(context).pop();
              FlutterStatusbarcolor.setStatusBarColor(Colors.white);
            },
          );
        },
      );

  Widget galleryNew() => StreamBuilder<File>(
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
              podBloc.updateImage(ImageSource.gallery);
              Navigator.of(context).pop();
            },
          );
        },
      );

  Container sign(Uint8List data) {
    return Container(
        margin: EdgeInsets.all(40),
        color: Colors.grey[300],
        child: Image.memory(data));
  }

  //  getSign() async {
  //
  //   await _controller.toPngBytes().then((value) async {
  //
  // final dir = await getTemporaryDirectory();
  // await dir.create(recursive: true);
  // final tempFile = File(path.join(dir.path, "sign.png"));
  // await tempFile.writeAsBytes(value);
  //
  // podBloc.setSign(tempFile);
  // print(tempFile.path);
  //   });
  // }

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
