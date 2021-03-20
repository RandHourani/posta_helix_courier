import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:photo_view/photo_view.dart';
import 'package:posta_courier/models/captain_cars_model.dart';
import 'package:posta_courier/models/registered_captain_model.dart';
import 'package:posta_courier/src/blocs/home_blocs/approved_captain_bloc.dart';
import 'package:posta_courier/src/blocs/home_blocs/wallet_bloc.dart';
import 'package:posta_courier/src/blocs/home_blocs/new_vehicle_bloc.dart';
import 'package:posta_courier/src/blocs/signIn_and_createAccount_blocs/documents_bloc.dart';
import 'package:posta_courier/src/constants/application_colors_value.dart';
import 'package:posta_courier/src/constants/constants.dart';
import 'package:posta_courier/src/constants/fonts_size.dart';
import 'package:posta_courier/src/ui/home/side_menu_screens/vehicale_details.dart';
import 'package:posta_courier/src/ui/widgets/dialog.dart';
import 'package:posta_courier/src/ui/home/google_maps/home_screen.dart';
import 'add_new_car.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // approvedCaptainBloc.checkUserAuth();
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //      statusBarColor: Colors.transparent));
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    //  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

    approvedCaptainBloc.captainCars();

    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
            height: MediaQuery
                .of(context)
                .size
                .height,
            width: MediaQuery
                .of(context)
                .size
                .width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/background_profile.png"),
                fit: BoxFit.fill,
              ),
            ),
            child:

            SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start, children: [

                Container(
                  margin: EdgeInsets.only(
                    top: MediaQuery
                        .of(context)
                        .size
                        .width / 6,
                    left: MediaQuery
                        .of(context)
                        .size
                        .width * 0.04,
                  ),
                  child: Row(
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return HomeScreen();
                            }),
                          );
                        },
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: (MediaQuery
                              .of(context)
                              .size
                              .width * 0.04) +
                              FontSize.HEADING_FONT -
                              3,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "   MY  ACCOUNT",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: FontFamilies.POPPINS,
                              fontSize:
                              (MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.04) +
                                  FontSize.HEADING_FONT -
                                  7,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ),
                StreamBuilder(
                  stream: approvedCaptainBloc.profileImage,
                  builder: (BuildContext context,
                      AsyncSnapshot<File> snapshot) {
                    if (snapshot.hasData) {
                      return InkWell(
                          onTap: () {
                            showChangeImg(context, snapshot.data);
                          },
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              margin: EdgeInsets.only(top: 45),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: FileImage(
                                      snapshot.data),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              width: 250,
                              height: 150,
                            ),
                          ));
                    }
                    else {
                      return StreamBuilder(
                        stream: approvedCaptainBloc.profileImg,
                        builder:
                            (BuildContext context,
                            AsyncSnapshot<String> snapshot) {
                          if (snapshot.hasData) {
                            return InkWell(
                                onTap: () {
                                  showChangeImg2(context, snapshot.data);

                                  // showMaterialModalBottomSheet(
                                  //   expand: false,
                                  //   context: context,
                                  //   backgroundColor: Colors.transparent,
                                  //   builder: (context) {
                                  //     return ListView(
                                  //       shrinkWrap: true,
                                  //       children: [
                                  //         InkWell(
                                  //           onTap: () async {
                                  //             Navigator.pop(context);
                                  //
                                  //             await showDialog(
                                  //                 barrierDismissible: true,
                                  //                 context: context,
                                  //                 builder: (_) {
                                  //                   return AlertDialog(
                                  //                       contentPadding: EdgeInsets
                                  //                           .all(0),
                                  //                       content: FadeInImage(
                                  //                         fit: BoxFit.cover,
                                  //
                                  //                         image: NetworkImage(
                                  //                             Constants
                                  //                                 .MAIN_URL_FOR_DOCUMENTS +
                                  //                                 snapshot
                                  //                                     .data),
                                  //                         placeholder: AssetImage(
                                  //                             "assets/images/profile_img.png"),
                                  //                       )
                                  //                   );
                                  //                 });
                                  //           },
                                  //           child: Container(
                                  //             color: Colors.white,
                                  //             height: 60,
                                  //             width: MediaQuery
                                  //                 .of(context)
                                  //                 .size
                                  //                 .width,
                                  //             child: Row(
                                  //               mainAxisAlignment: MainAxisAlignment
                                  //                   .start,
                                  //               children: [
                                  //
                                  //                 Padding(
                                  //                   padding: EdgeInsets.only(
                                  //                       right: 10, left: 10),
                                  //                   child: SvgPicture.asset(
                                  //                     "assets/images/view_img.svg",
                                  //                     width: 30,
                                  //                     height: 30,
                                  //                     color: Colors.black,),
                                  //                 ),
                                  //
                                  //                 Container(child: Text(
                                  //                   "View Profile Picture",
                                  //                   style: TextStyle(
                                  //                       fontFamily: FontFamilies
                                  //                           .POPPINS,
                                  //                       fontSize: 16
                                  //
                                  //                   ),),
                                  //                 )
                                  //               ],),
                                  //           ),),
                                  //         Container(
                                  //           color: Colors.white,
                                  //           width: MediaQuery
                                  //               .of(context)
                                  //               .size
                                  //               .width,
                                  //           child: Divider(
                                  //               thickness: 1,
                                  //               color: AppColors.LIGHT_BLUE
                                  //           ),
                                  //
                                  //         ),
                                  //         InkWell(
                                  //             onTap: () async {
                                  //               Navigator.pop(context);
                                  //               showDialog<void>(
                                  //                   context: context,
                                  //                   barrierDismissible: false,
                                  //                   // user must tap button!
                                  //                   builder:
                                  //                       (BuildContext context) {
                                  //                     return WillPopScope(
                                  //                         onWillPop: () {
                                  //                           return Future.value(
                                  //                               true);
                                  //                         },
                                  //                         child: AlertDialog(
                                  //                           contentPadding:
                                  //                           EdgeInsets.all(
                                  //                               8),
                                  //                           shape: RoundedRectangleBorder(
                                  //                               borderRadius: BorderRadius
                                  //                                   .all(Radius
                                  //                                   .circular(
                                  //                                   15.0))),
                                  //                           content: Container(
                                  //                             height: 50,
                                  //                             child: Row(
                                  //                               mainAxisAlignment:
                                  //                               MainAxisAlignment
                                  //                                   .spaceAround,
                                  //                               children: <
                                  //                                   Widget>[
                                  //                                 cameraNew(
                                  //                                     'PROFILE_IMAGE'),
                                  //                                 VerticalDivider(
                                  //                                   color: AppColors
                                  //                                       .labelColor,
                                  //                                 ),
                                  //                                 galleryNew(
                                  //                                     'VEHICLE_License_FRONT'),
                                  //                               ],
                                  //                             ),
                                  //                           ),
                                  //                         ));
                                  //                   });
                                  //             },
                                  //             child:
                                  //             Container(
                                  //                 color: Colors.white,
                                  //                 height: 60,
                                  //                 width: MediaQuery
                                  //                     .of(context)
                                  //                     .size
                                  //                     .width,
                                  //                 child:
                                  //                 Row(
                                  //                   mainAxisAlignment: MainAxisAlignment
                                  //                       .start,
                                  //
                                  //                   children: [
                                  //
                                  //                     Padding(
                                  //                       padding: EdgeInsets
                                  //                           .only(right: 10,
                                  //                           left: 10),
                                  //                       child: Image.asset(
                                  //                         "assets/images/gallery.png",
                                  //                         width: 35,
                                  //                         height: 30,
                                  //                         color: Colors.black,
                                  //                       ),
                                  //                     ),
                                  //
                                  //
                                  //                     Container(child: Text(
                                  //                       "Select Profile Picture",
                                  //                       style: TextStyle(
                                  //                           fontFamily: FontFamilies
                                  //                               .POPPINS,
                                  //                           fontSize: 16
                                  //
                                  //                       ),),
                                  //                     )
                                  //                   ],)))
                                  //       ],
                                  //     );
                                  //   },
                                  // );
                                },
                                child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Container(
                                      margin: EdgeInsets.only(top: 45),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      width: 150,
                                      height: 150,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                            80.0),
                                        child: FadeInImage(
                                          fit: BoxFit.cover,
                                          width: 150,
                                          height: 150,
                                          image: NetworkImage(
                                              Constants
                                                  .MAIN_URL_FOR_DOCUMENTS +
                                                  snapshot
                                                      .data),
                                          placeholder: AssetImage(
                                            "assets/images/profile_img.png",
                                          ),
                                        ),


                                      ),

                                    )
                                ));
                          } else {
                            return InkWell(
                              onTap: () {
                                showMaterialModalBottomSheet(
                                  expand: false,
                                  context: context,
                                  backgroundColor: Colors.transparent,
                                  builder: (context) {
                                    return ListView(
                                      shrinkWrap: true,
                                      children: [

                                        InkWell(
                                            onTap: () async {
                                              Navigator.pop(context);
                                              showDialog<void>(
                                                  context: context,
                                                  barrierDismissible: false,
                                                  // user must tap button!
                                                  builder:
                                                      (BuildContext context) {
                                                    return WillPopScope(
                                                        onWillPop: () {
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
                                                                    'PROFILE_IMAGE'),
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
                                                  });
                                            },
                                            child:
                                            Container(
                                                color: Colors.white,
                                                height: 60,
                                                width: MediaQuery
                                                    .of(context)
                                                    .size
                                                    .width,
                                                child:
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment
                                                      .start,
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          right: 10, left: 10),
                                                      child: Image.asset(
                                                        "assets/images/gallery.png",
                                                        width: 35,
                                                        height: 30,
                                                        color: Colors.black,
                                                      ),
                                                    ),


                                                    Container(child: Text(
                                                      "Select Profile Picture",
                                                      style: TextStyle(
                                                          fontFamily: FontFamilies
                                                              .POPPINS,
                                                          fontSize: 16

                                                      ),),
                                                    )
                                                  ],)))
                                      ],
                                    );
                                  },
                                );
                              },
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  margin: EdgeInsets.only(top: 60),
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image:
                                      AssetImage(
                                          "assets/images/profile_img.png"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  width: 250,
                                  height: 120,

                                ),
                              ),
                            );
                          }
                        },
                      );
                    }
                  },


                ),


                StreamBuilder(
                  stream: approvedCaptainBloc.fullName,
                  builder: (BuildContext context,
                      AsyncSnapshot<String> snapshot) {
                    return Text(
                      snapshot.data,
                      style: TextStyle(
                        fontFamily: FontFamilies.POPPINS,
                        fontSize:
                        MediaQuery
                            .of(context)
                            .size
                            .height *
                            0.03,
                        fontWeight: FontWeight.w500,
                      ),
                    );
                  },
                ),
                Align(
                    alignment: Alignment.center,
                    child: StreamBuilder(
                      stream: approvedCaptainBloc.checkUser,
                      builder: (BuildContext context,
                          AsyncSnapshot<LogInModel> snapshot) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            double.parse(snapshot.data.data.rating) >= 1.0000
                                ? SvgPicture.asset(
                                "assets/images/full_star.svg",
                                width: (MediaQuery
                                    .of(context)
                                    .size
                                    .height *
                                    0.02) +
                                    2,
                                height: (MediaQuery
                                    .of(context)
                                    .size
                                    .height *
                                    0.02) +
                                    2)
                                : SvgPicture.asset(
                                "assets/images/empty_star.svg",
                                width: (MediaQuery
                                    .of(context)
                                    .size
                                    .height *
                                    0.02) +
                                    2,
                                height: (MediaQuery
                                    .of(context)
                                    .size
                                    .height *
                                    0.02) +
                                    2),
                            double.parse(snapshot.data.data.rating) >= 2.0000
                                ? SvgPicture.asset(
                                "assets/images/full_star.svg",
                                width: (MediaQuery
                                    .of(context)
                                    .size
                                    .height *
                                    0.02) +
                                    2,
                                height: (MediaQuery
                                    .of(context)
                                    .size
                                    .height *
                                    0.02) +
                                    2)
                                : SvgPicture.asset(
                                "assets/images/empty_star.svg",
                                width: (MediaQuery
                                    .of(context)
                                    .size
                                    .height *
                                    0.02) +
                                    2,
                                height: (MediaQuery
                                    .of(context)
                                    .size
                                    .height *
                                    0.02) +
                                    2),
                            double.parse(snapshot.data.data.rating) >= 3.0000
                                ? SvgPicture.asset(
                                "assets/images/full_star.svg",
                                width: (MediaQuery
                                    .of(context)
                                    .size
                                    .height *
                                    0.02) +
                                    2,
                                height: (MediaQuery
                                    .of(context)
                                    .size
                                    .height *
                                    0.02) +
                                    2)
                                : SvgPicture.asset(
                                "assets/images/empty_star.svg",
                                width: (MediaQuery
                                    .of(context)
                                    .size
                                    .height *
                                    0.02) +
                                    2,
                                height: (MediaQuery
                                    .of(context)
                                    .size
                                    .height *
                                    0.02) +
                                    2),
                            double.parse(snapshot.data.data.rating) >= 4.0000
                                ? SvgPicture.asset(
                                "assets/images/full_star.svg",
                                width: (MediaQuery
                                    .of(context)
                                    .size
                                    .height *
                                    0.02) +
                                    2,
                                height: (MediaQuery
                                    .of(context)
                                    .size
                                    .height *
                                    0.02) +
                                    2)
                                : SvgPicture.asset(
                                "assets/images/empty_star.svg",
                                width: (MediaQuery
                                    .of(context)
                                    .size
                                    .height *
                                    0.02) +
                                    2,
                                height: (MediaQuery
                                    .of(context)
                                    .size
                                    .height *
                                    0.02) +
                                    2),
                            double.parse(snapshot.data.data.rating) >= 5.0000
                                ? SvgPicture.asset(
                                "assets/images/full_star.svg",
                                width: (MediaQuery
                                    .of(context)
                                    .size
                                    .height *
                                    0.02) +
                                    2,
                                height: (MediaQuery
                                    .of(context)
                                    .size
                                    .height *
                                    0.02) +
                                    2)
                                : SvgPicture.asset(
                                "assets/images/empty_star.svg",
                                width: (MediaQuery
                                    .of(context)
                                    .size
                                    .height *
                                    0.02) +
                                    2,
                                height: (MediaQuery
                                    .of(context)
                                    .size
                                    .height *
                                    0.02) +
                                    2),
                          ],
                        );
                      },
                    )),
                Container(
                  margin: EdgeInsets.all(
                    MediaQuery
                        .of(context)
                        .size
                        .width * 0.05,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Phone",
                            style: TextStyle(
                              fontFamily: FontFamilies.POPPINS,
                              fontSize:
                              (MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.022),
                            ),
                          ),
                          StreamBuilder(
                              stream: approvedCaptainBloc.phone,
                              builder: (BuildContext context,
                                  AsyncSnapshot<String> snapshot) {
                                return Text(
                                  "+" + snapshot.data,
                                  style: TextStyle(
                                    fontFamily: FontFamilies.POPPINS,
                                    fontSize: (MediaQuery
                                        .of(context)
                                        .size
                                        .height *
                                        0.022),
                                  ),
                                );
                              }),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: MediaQuery
                              .of(context)
                              .size
                              .width * 0.05,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Email",
                              style: TextStyle(
                                fontFamily: FontFamilies.POPPINS,
                                fontSize:
                                (MediaQuery
                                    .of(context)
                                    .size
                                    .height * 0.022),
                              ),
                            ),
                            StreamBuilder(
                                stream: approvedCaptainBloc.email,
                                builder: (BuildContext context,
                                    AsyncSnapshot<String> snapshot) {
                                  if (snapshot.hasData) {
                                    return Text(
                                      snapshot.data,
                                      style: TextStyle(
                                        fontFamily: FontFamilies.POPPINS,
                                        fontSize:
                                        (MediaQuery
                                            .of(context)
                                            .size
                                            .height *
                                            0.022),
                                      ),
                                    );
                                  }
                                  else {
                                    return Text(" ");
                                  }
                                }),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                    color: AppColors.DOCUMENTS_LABEL,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    padding: EdgeInsets.only(
                      left: (MediaQuery
                          .of(context)
                          .size
                          .height * 0.02) + 20,
                      right: (MediaQuery
                          .of(context)
                          .size
                          .height * 0.02) + 20,
                      top: MediaQuery
                          .of(context)
                          .size
                          .width * 0.035,
                      bottom: MediaQuery
                          .of(context)
                          .size
                          .width * 0.035,
                    ),
                    margin: EdgeInsets.only(
                        top: MediaQuery
                            .of(context)
                            .size
                            .width * 0.05,
                        bottom: MediaQuery
                            .of(context)
                            .size
                            .width * 0.02),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "My Vehicle",
                          style: TextStyle(
                              fontFamily: FontFamilies.POPPINS,
                              fontSize:
                              (MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.02) + 5,
                              fontWeight: FontWeight.w500),
                        ),
                        StreamBuilder(
                            stream: approvedCaptainBloc.carList,
                            builder: (BuildContext context,
                                AsyncSnapshot<CaptainCarsData> snapshot) {
                              return Container(
                                width: 80,
                                height: 27,
                                child: RaisedButton(
                                  padding: EdgeInsets.all(0),
                                  color: AppColors.MAIN_COLOR,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                  ),
                                  onPressed: () {
                                    if (snapshot.data.cars.length >= 3) {
                                      showDialog(
                                          barrierDismissible: false,
                                          context: context,
                                          builder: (BuildContext context) {
                                            return ErrorDialogWidget(
                                              text: "You can not add any new car ",
                                            );
                                          });
                                    } else {
                                      newVehicleBloc.resetData();
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) {
                                          return AddNewCar();
                                        }),
                                      );
                                    }
                                  },
                                  child: Text(
                                    " Add Vehicle",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: FontFamilies.POPPINS,
                                      fontSize: MediaQuery
                                          .of(context)
                                          .size
                                          .height *
                                          0.014,
                                    ),
                                  ),
                                ),
                              );
                            })
                      ],
                    )),
                StreamBuilder(
                  stream: approvedCaptainBloc.carList,
                  builder: (BuildContext context,
                      AsyncSnapshot<CaptainCarsData> snapshot) {
                    if (snapshot.hasData) {
                      return _carsListView(context, snapshot.data);
                    }
                    else {
                      return Container(child: SpinKitCircle(
                        color: AppColors.MAIN_COLOR,
                      ),);
                    }
                  },
                ),
              ]),
            )));
  }

  _carsListView(context, CaptainCarsData data) {
    return carList(data);
  }

  ListView carList(CaptainCarsData data) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: data.cars.length,
        itemBuilder: (context, index) {
          return _carData(
              context,
              data.cars[index].carNumber,
              data.cars[index].brand,
              data.cars[index].model,
              data.cars[index].isSelected,
              data.cars[index]);
        });
  }

  _carData(context, String carNumber, String brand, String model,
      bool isSelected, CaptainCarsModel data) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: 70,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  InkWell(

                    onTap: () {
                      data.approved
                          ? newVehicleBloc.setSelectedCar(data.carId)
                          : showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (BuildContext context) {
                            return ErrorDialogWidget(
                              text: "Wait to approved from admin",
                            );
                          });
                    },
                    splashColor: Colors.white,
                    child: Container(
                      margin: EdgeInsets.only(
                          right:
                          (MediaQuery
                              .of(context)
                              .size
                              .height * 0.02) + 10,
                          left:
                          (MediaQuery
                              .of(context)
                              .size
                              .height * 0.02) + 10),
                      decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.MAIN_COLOR
                              : AppColors.LIGHT_GREY,
                          shape: BoxShape.circle),
                      width: 10,
                      height: 10,
                    ),
                  ),
                  Text(
                    "Car Number ",
                    style: TextStyle(
                      color: AppColors.LIGHT_GREY,
                      fontFamily: FontFamilies.POPPINS,
                      fontSize: (MediaQuery
                          .of(context)
                          .size
                          .height * 0.018),
                    ),
                  ),
                  Text(
                    carNumber,
                    style: TextStyle(
                      color: AppColors.LIGHT_GREY,
                      fontFamily: FontFamilies.POPPINS,
                      fontSize: (MediaQuery
                          .of(context)
                          .size
                          .height * 0.018),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: 65,
                  ),
                  Text(
                    brand,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.TITLE_TEXT_COLOR,
                      fontFamily: FontFamilies.POPPINS,
                      fontSize:
                      (MediaQuery
                          .of(context)
                          .size
                          .height * 0.018) + 5,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(
              right: (MediaQuery
                  .of(context)
                  .size
                  .height * 0.02) + 20,
              bottom: 30),
          width: 70,
          height: 27,
          child: RaisedButton(
            padding: EdgeInsets.all(0),
            color: AppColors.GREY_BUTTON,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return CourierVehicleDetailsScreen(
                    data: data,
                  );
                }),
              );
            },
            child: Text(
              " View Details",
              style: TextStyle(
                color: AppColors.TEXT_BUTTON,
                fontFamily: FontFamilies.POPPINS,
                fontSize: MediaQuery
                    .of(context)
                    .size
                    .height * 0.013,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget cameraNew(String img) =>
      StreamBuilder<File>(
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
              approvedCaptainBloc.updateImage(ImageSource.camera, img);

              Navigator.of(context).pop();
            },
          );
        },
      );

  Widget galleryNew(String img) =>
      StreamBuilder<File>(
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
              approvedCaptainBloc.updateImage(ImageSource.gallery, img);
              Navigator.of(context).pop();
            },
          );
        },
      );


  showChangeImg(context, File img) {
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return WillPopScope(
              onWillPop: () {
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
                    height: 137,
                    child: Column(
                      children: <
                          Widget>[
                        InkWell(
                          onTap: () async {
                            Navigator.pop(context);

                            await showDialog(
                                barrierDismissible: true,
                                context: context,
                                builder: (_) {
                                  return AlertDialog(
                                      contentPadding: EdgeInsets
                                          .all(0),
                                      content: FadeInImage(
                                        fit: BoxFit.cover,
                                        image: FileImage(
                                            img),
                                        placeholder: AssetImage(
                                            "assets/images/profile_img.png"),
                                      )
                                  );
                                });
                          },
                          child: Container(
                            color: Colors.white,
                            height: 60,
                            width: MediaQuery
                                .of(context)
                                .size
                                .width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment
                                  .start,
                              children: [

                                Padding(
                                  padding: EdgeInsets.only(
                                      right: 10, left: 10),
                                  child: SvgPicture.asset(
                                    "assets/images/view_img.svg",
                                    width: 30,
                                    height: 30,
                                    color: AppColors.MAIN_COLOR,),
                                ),

                                Container(child: Text(
                                  "View Profile Picture",
                                  style: TextStyle(
                                      fontFamily: FontFamilies
                                          .POPPINS,
                                      fontSize: 16,
                                      color: AppColors.LIGHT_GREY

                                  ),),
                                )
                              ],),
                          ),),
                        Container(
                          color: Colors.white,
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                          child: Divider(
                              thickness: 1,
                              color: AppColors.LIGHT_BLUE
                          ),

                        ),
                        InkWell(
                            onTap: () async {
                              Navigator.pop(context);
                              showDialog<void>(
                                  context: context,
                                  barrierDismissible: false,
                                  // user must tap button!
                                  builder:
                                      (BuildContext context) {
                                    return WillPopScope(
                                        onWillPop: () {
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
                                                    'PROFILE_IMAGE'),
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
                                  });
                            },
                            child:
                            Container(
                                color: Colors.white,
                                height: 60,
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width,
                                child:
                                Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .start,

                                  children: [

                                    Padding(
                                      padding: EdgeInsets.only(
                                          right: 10, left: 10),
                                      child: SvgPicture.asset(
                                        "assets/images/new_gallery.svg",
                                        width: 27,
                                        height: 27,
                                        color: AppColors.MAIN_COLOR,
                                      ),
                                    ),


                                    Container(child: Text(
                                      "Select Profile Picture",
                                      style: TextStyle(
                                          fontFamily: FontFamilies
                                              .POPPINS,
                                          fontSize: 16,
                                          color: AppColors.LIGHT_GREY


                                      ),),
                                    )
                                  ],)))
                      ],
                    ),
                  )
              ));
        });
  }

  Future<void> showChangeImg2(context, String img) {
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return WillPopScope(
              onWillPop: () {
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
                    height: 137,
                    child: Column(
                      // mainAxisAlignment:
                      // MainAxisAlignment
                      //     .spaceAround,
                      children: <
                          Widget>[
                        InkWell(
                          onTap: () async {
                            Navigator.pop(context);

                            await showDialog(
                                barrierDismissible: true,
                                context: context,
                                builder: (_) {
                                  return AlertDialog(
                                      contentPadding: EdgeInsets
                                          .all(0),
                                      content: FadeInImage(
                                        fit: BoxFit.cover,

                                        image: NetworkImage(
                                            Constants
                                                .MAIN_URL_FOR_DOCUMENTS +

                                                img),
                                        placeholder: AssetImage(
                                            "assets/images/profile_img.png"),
                                      )
                                  );
                                });
                          },
                          child: Container(
                            color: Colors.white,
                            height: 60,
                            width: MediaQuery
                                .of(context)
                                .size
                                .width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment
                                  .start,
                              children: [

                                Padding(
                                  padding: EdgeInsets.only(
                                      right: 10, left: 10),
                                  child: SvgPicture.asset(
                                    "assets/images/view_img.svg",
                                    width: 30,
                                    height: 30,
                                    color: AppColors.MAIN_COLOR,),
                                ),

                                Container(child: Text(
                                  "View Profile Picture",
                                  style: TextStyle(
                                      fontFamily: FontFamilies
                                          .POPPINS,
                                      fontSize: 16,
                                      color: AppColors.LIGHT_GREY

                                  ),),
                                )
                              ],),
                          ),),
                        Container(
                          color: Colors.white,
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                          child: Divider(
                              thickness: 1,
                              color: AppColors.LIGHT_BLUE
                          ),

                        ),
                        InkWell(
                            onTap: () async {
                              Navigator.pop(context);
                              showDialog<void>(
                                  context: context,
                                  barrierDismissible: false,
                                  // user must tap button!
                                  builder:
                                      (BuildContext context) {
                                    return WillPopScope(
                                        onWillPop: () {
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
                                                    'PROFILE_IMAGE'),
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
                                  });
                            },
                            child:
                            Container(
                                color: Colors.white,
                                height: 60,
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width,
                                child:
                                Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .start,

                                  children: [

                                    Padding(
                                      padding: EdgeInsets.only(
                                          right: 10, left: 10),
                                      child: SvgPicture.asset(
                                        "assets/images/new_gallery.svg",
                                        width: 27,
                                        height: 27,
                                        color: AppColors.MAIN_COLOR,
                                      ),
                                    ),


                                    Container(child: Text(
                                      "Select Profile Picture",
                                      style: TextStyle(
                                          fontFamily: FontFamilies
                                              .POPPINS,
                                          fontSize: 16,
                                          color: AppColors.LIGHT_GREY


                                      ),),
                                    )
                                  ],)))
                      ],
                    ),
                  )
              ));
        });
  }

}
