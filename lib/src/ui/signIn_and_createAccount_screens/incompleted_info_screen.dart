import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'file:///C:/Users/r.horani/AndroidStudioProjects/helix_courier_project/helix_courier_project/lib/src/constants/application_colors_value.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:posta_courier/src/blocs/signIn_and_createAccount_blocs/country_cities_bloc.dart';
import 'package:posta_courier/src/blocs/signIn_and_createAccount_blocs/get_captain_data_bloc.dart';
import 'package:posta_courier/src/ui/widgets/dialog.dart';
import 'package:posta_courier/src/utils/util.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'file:///C:/Users/r.horani/AndroidStudioProjects/helix_courier_project/helix_courier_project/lib/src/constants/application_colors_value.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:posta_courier/models/get_captain_model.dart';
import 'package:posta_courier/src/blocs/signIn_and_createAccount_blocs/get_captain_data_bloc.dart';
import 'package:posta_courier/src/blocs/signIn_and_createAccount_blocs/interview_bloc.dart';
import 'package:posta_courier/src/blocs/signIn_and_createAccount_blocs/personal_details_bloc.dart';
import 'package:posta_courier/src/blocs/signIn_and_createAccount_blocs/vehicle_bloc.dart';
import 'package:posta_courier/src/blocs/signIn_and_createAccount_blocs/documents_bloc.dart';
import 'package:posta_courier/src/ui/signIn_and_createAccount_screens/personal_details_screen.dart';
import 'package:posta_courier/src/ui/signIn_and_createAccount_screens/vehicle_details_screen.dart';
import 'package:posta_courier/src/ui/signIn_and_createAccount_screens/documents_screen.dart';
import 'package:posta_courier/src/utils/util.dart';

class InCompletedInfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.white);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    // personalDetailsBloc.fetchAllNationality();
    checkCaptainDataBloc.checkCaptainData();
    vehicleBloc.getCountries();
    // vehicleBloc.fetchAllCarBrand();
    // vehicleBloc.fetchAllCarColor();
    // vehicleBloc.getManufacturingYear();
    return new WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 40, left: 20, bottom: 20),
                      child: Image.asset("assets/images/incompleted.png"),
                    ),
                    Text(
                      "Oops, Your Data",
                      style: TextStyle(fontSize: 26, fontFamily: 'Poppins'),
                    ),
                    Text(
                      "is Incomplete",
                      style: TextStyle(fontSize: 26, fontFamily: 'Poppins'),
                    ),
                    Text(
                      "In order to review your application, \n please complete your details ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          color: AppColors.COMPLETED_INFO_TEXT),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            spreadRadius: 3,
                            blurRadius: 3,
                            offset: Offset(0, 1), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(15),
                                  topLeft: Radius.circular(15)),
                              color: AppColors.ERROR,
                            ),
                            height: 60,
                            width: MediaQuery.of(context).size.width,
                            child: Text(
                              "INFORMATION",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                  letterSpacing: 0.8),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(15),
                                  bottomLeft: Radius.circular(15)),
                              color: Colors.white,
                            ),
                            height: 230,
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              children: [
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        Column(
                                          children: [
                                            Container(
                                              child: Column(
                                                children: [
                                                  StreamBuilder(
                                                    stream: checkCaptainDataBloc
                                                        .personal,
                                                    builder:
                                                        (BuildContext context,
                                                            AsyncSnapshot<bool>
                                                                snapshot) {
                                                      if (snapshot.hasData) {
                                                        return Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  right: 10,
                                                                  left: 20,
                                                                  bottom: 4),
                                                          decoration: BoxDecoration(
                                                              color: snapshot
                                                                      .data
                                                                  ? AppColors
                                                                      .COMPLETED_INFO_BOX
                                                                  : AppColors
                                                                      .ERROR,
                                                              shape: BoxShape
                                                                  .circle),
                                                          width: 10,
                                                          height: 10,
                                                        );
                                                      } else {
                                                        return Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  right: 10,
                                                                  left: 20,
                                                                  bottom: 4),
                                                          decoration:
                                                              BoxDecoration(
                                                                  color:
                                                                      AppColors
                                                                          .ERROR,
                                                                  shape: BoxShape
                                                                      .circle),
                                                          width: 10,
                                                          height: 10,
                                                        );
                                                      }
                                                    },
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        right: 10,
                                                        left: 20,
                                                        bottom: 4),
                                                    height: 55,
                                                    child: DottedLine(
                                                      direction: Axis.vertical,
                                                      dashLength: 3,
                                                      lineThickness: 3,
                                                      dashRadius: 50,
                                                      dashColor:
                                                          Color(0xffEFEFEF),
                                                    ),
                                                  ),
                                                  StreamBuilder(
                                                    stream: checkCaptainDataBloc
                                                        .vehicle,
                                                    builder:
                                                        (BuildContext context,
                                                            AsyncSnapshot<bool>
                                                                snapshot) {
                                                      if (snapshot.hasData) {
                                                        return Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  right: 10,
                                                                  left: 20,
                                                                  bottom: 4),
                                                          decoration: BoxDecoration(
                                                              color: snapshot
                                                                      .data
                                                                  ? AppColors
                                                                      .COMPLETED_INFO_BOX
                                                                  : AppColors
                                                                      .ERROR,
                                                              shape: BoxShape
                                                                  .circle),
                                                          width: 10,
                                                          height: 10,
                                                        );
                                                      } else {
                                                        return Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  right: 10,
                                                                  left: 20,
                                                                  bottom: 4),
                                                          decoration:
                                                              BoxDecoration(
                                                                  color:
                                                                      AppColors
                                                                          .ERROR,
                                                                  shape: BoxShape
                                                                      .circle),
                                                          width: 10,
                                                          height: 10,
                                                        );
                                                      }
                                                    },
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        right: 10,
                                                        left: 20,
                                                        bottom: 4),
                                                    height: 55,
                                                    child: DottedLine(
                                                      direction: Axis.vertical,
                                                      dashLength: 3,
                                                      lineThickness: 3,
                                                      dashRadius: 50,
                                                      dashColor:
                                                          Color(0xffEFEFEF),
                                                    ),
                                                  ),
                                                  StreamBuilder(
                                                    stream: checkCaptainDataBloc
                                                        .documents,
                                                    builder:
                                                        (BuildContext context,
                                                            AsyncSnapshot<bool>
                                                                snapshot) {
                                                      if (snapshot.hasData) {
                                                        return Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  right: 10,
                                                                  left: 20,
                                                                  bottom: 4),
                                                          decoration: BoxDecoration(
                                                              color: snapshot
                                                                      .data
                                                                  ? AppColors
                                                                      .COMPLETED_INFO_BOX
                                                                  : AppColors
                                                                      .ERROR,
                                                              shape: BoxShape
                                                                  .circle),
                                                          width: 10,
                                                          height: 10,
                                                        );
                                                      } else {
                                                        return Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  right: 10,
                                                                  left: 20,
                                                                  bottom: 4),
                                                          decoration:
                                                              BoxDecoration(
                                                                  color:
                                                                      AppColors
                                                                          .ERROR,
                                                                  shape: BoxShape
                                                                      .circle),
                                                          width: 10,
                                                          height: 10,
                                                        );
                                                      }
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(
                                                  right: 20,
                                                  bottom: 7,
                                                  top: 30),
                                              decoration: BoxDecoration(
                                                border: Border(
                                                  bottom: BorderSide(
                                                      width: 1.0,
                                                      color: AppColors
                                                          .completedInfoBoxUnderLine),
                                                ),
                                                color: Colors.white,
                                              ),
                                              padding: EdgeInsets.only(left: 5),
                                              height: 50,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  1.4,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  StreamBuilder(
                                                    stream: checkCaptainDataBloc
                                                        .personal,
                                                    builder:
                                                        (BuildContext context,
                                                            AsyncSnapshot<bool>
                                                                snapshot) {
                                                      if (snapshot.hasData) {
                                                        if (snapshot.data) {
                                                          return Text(
                                                            "Completed",
                                                            style: TextStyle(
                                                                color: AppColors
                                                                    .labelColor,
                                                                fontFamily:
                                                                    'Poppins',
                                                                fontSize: 10),
                                                          );
                                                        } else {
                                                          return Text(
                                                            "Not Completed",
                                                            style: TextStyle(
                                                                color: AppColors
                                                                    .labelColor,
                                                                fontFamily:
                                                                    'Poppins',
                                                                fontSize: 10),
                                                          );
                                                        }
                                                      } else {
                                                        return Text(
                                                          "Not Completed",
                                                          style: TextStyle(
                                                              color: AppColors
                                                                  .labelColor,
                                                              fontFamily:
                                                                  'Poppins',
                                                              fontSize: 10),
                                                        );
                                                      }
                                                    },
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "Personal Details",
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'Poppins',
                                                            fontSize: 17),
                                                      ),
                                                      StreamBuilder(
                                                        stream:
                                                            checkCaptainDataBloc
                                                                .captainData,
                                                        builder: (BuildContext
                                                                context,
                                                            AsyncSnapshot<
                                                                    CaptainData>
                                                                snapshot) {
                                                          return InkWell(
                                                            onTap: () {
                                                              personalDetailsBloc
                                                                  .setCaptainData(
                                                                      snapshot
                                                                          .data);
                                                              personalDetailsBloc
                                                                  .changeFirstName(
                                                                      snapshot
                                                                          .data
                                                                          .data
                                                                          .firstName);
                                                              personalDetailsBloc
                                                                  .setBirthday(Utils
                                                                      .dateTimeFormat2(snapshot
                                                                          .data
                                                                          .data
                                                                          .birthday));
                                                              personalDetailsBloc
                                                                  .setLicenseIssueDate(
                                                                      Utils.dateTimeFormat2(snapshot
                                                                          .data
                                                                          .data
                                                                          .drivingCertificateSD));
                                                              personalDetailsBloc
                                                                  .setLicenseExpiredOn(
                                                                      Utils.dateTimeFormat2(snapshot
                                                                          .data
                                                                          .data
                                                                          .drivingCertificateED));

                                                              personalDetailsBloc
                                                                  .setNationality(
                                                                      snapshot
                                                                          .data
                                                                          .data
                                                                          .nationalityId);

                                                              snapshot.data.data
                                                                      .gender
                                                                  ? personalDetailsBloc
                                                                      .setGenderMale()
                                                                  : personalDetailsBloc
                                                                      .setGenderFemale();

                                                              Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) {
                                                                  return PersonalDetailsScreen(
                                                                    captainPersonalData:
                                                                        snapshot
                                                                            .data,
                                                                  );
                                                                }),
                                                              );
                                                            },
                                                            child: SvgPicture
                                                                .asset(
                                                              "assets/images/edit_pin.svg",
                                                              width: 15,
                                                              height: 15,
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  right: 20,
                                                  top: 15,
                                                  bottom: 10),
                                              decoration: BoxDecoration(
                                                border: Border(
                                                  bottom: BorderSide(
                                                      width: 1.0,
                                                      color: AppColors
                                                          .completedInfoBoxUnderLine),
                                                ),
                                                color: Colors.white,
                                              ),
                                              padding: EdgeInsets.only(left: 5),
                                              height: 50,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  1.4,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  StreamBuilder(
                                                    stream: checkCaptainDataBloc
                                                        .vehicle,
                                                    builder:
                                                        (BuildContext context,
                                                            AsyncSnapshot<bool>
                                                                snapshot) {
                                                      if (snapshot.hasData) {
                                                        if (snapshot.data) {
                                                          return Text(
                                                            "Completed",
                                                            style: TextStyle(
                                                                color: AppColors
                                                                    .labelColor,
                                                                fontFamily:
                                                                    'Poppins',
                                                                fontSize: 10),
                                                          );
                                                        } else {
                                                          return Text(
                                                            "Not Completed",
                                                            style: TextStyle(
                                                                color: AppColors
                                                                    .labelColor,
                                                                fontFamily:
                                                                    'Poppins',
                                                                fontSize: 10),
                                                          );
                                                        }
                                                      } else {
                                                        return Text(
                                                          "Not Completed",
                                                          style: TextStyle(
                                                              color: AppColors
                                                                  .labelColor,
                                                              fontFamily:
                                                                  'Poppins',
                                                              fontSize: 10),
                                                        );
                                                      }
                                                    },
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "Vehicle Information",
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'Poppins',
                                                            fontSize: 17),
                                                      ),
                                                      StreamBuilder(
                                                        stream:
                                                            checkCaptainDataBloc
                                                                .captainData,
                                                        builder: (BuildContext
                                                                context,
                                                            AsyncSnapshot<
                                                                    CaptainData>
                                                                snapshot) {
                                                          countryBloc
                                                              .getCountryName(
                                                                  snapshot
                                                                      .data
                                                                      .data
                                                                      .countryId);
                                                          return InkWell(
                                                            onTap: () {
                                                              if (snapshot
                                                                      .data
                                                                      .data
                                                                      .car !=
                                                                  null) {
                                                                vehicleBloc
                                                                    .setCarBrand(
                                                                  snapshot
                                                                      .data
                                                                      .data
                                                                      .car
                                                                      .carBrandName,
                                                                );

                                                                setVehicleData(
                                                                    snapshot
                                                                        .data);
                                                                vehicleBloc
                                                                    .findCarBrandModel(
                                                                        snapshot
                                                                            .data
                                                                            .data
                                                                            .car
                                                                            .brandModelId);

                                                                Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder:
                                                                          (context) {
                                                                    return VehicleDetailsScreen(
                                                                      captainPersonalData:
                                                                          snapshot
                                                                              .data,
                                                                    );
                                                                  }),
                                                                );
                                                              } else {
                                                                Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder:
                                                                          (context) {
                                                                    return VehicleDetailsScreen();
                                                                  }),
                                                                );
                                                              }
                                                            },
                                                            child: SvgPicture
                                                                .asset(
                                                              "assets/images/edit_pin.svg",
                                                              width: 15,
                                                              height: 15,
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  right: 20, top: 15),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                              ),
                                              padding: EdgeInsets.only(left: 5),
                                              height: 50,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  1.4,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  StreamBuilder(
                                                    stream: checkCaptainDataBloc
                                                        .documents,
                                                    builder:
                                                        (BuildContext context,
                                                            AsyncSnapshot<bool>
                                                                snapshot) {
                                                      if (snapshot.hasData) {
                                                        if (snapshot.data) {
                                                          return Text(
                                                            "Completed",
                                                            style: TextStyle(
                                                                color: AppColors
                                                                    .labelColor,
                                                                fontFamily:
                                                                    'Poppins',
                                                                fontSize: 10),
                                                          );
                                                        } else {
                                                          return Text(
                                                            "Not Completed",
                                                            style: TextStyle(
                                                                color: AppColors
                                                                    .labelColor,
                                                                fontFamily:
                                                                    'Poppins',
                                                                fontSize: 10),
                                                          );
                                                        }
                                                      } else {
                                                        return Text(
                                                          "Not Completed",
                                                          style: TextStyle(
                                                              color: AppColors
                                                                  .labelColor,
                                                              fontFamily:
                                                                  'Poppins',
                                                              fontSize: 10),
                                                        );
                                                      }
                                                    },
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "Documents",
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'Poppins',
                                                            fontSize: 17),
                                                      ),
                                                      StreamBuilder(
                                                        stream:
                                                            checkCaptainDataBloc
                                                                .captainData,
                                                        builder: (BuildContext
                                                                context,
                                                            AsyncSnapshot<
                                                                    CaptainData>
                                                                snapshot) {
                                                          return InkWell(
                                                            onTap: () {
                                                              if (snapshot
                                                                      .data
                                                                      .data
                                                                      .drivingCertificateF !=
                                                                  null) {
                                                                Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder:
                                                                          (context) {
                                                                    return DocumentsScreen(
                                                                      captainPersonalData:
                                                                          snapshot
                                                                              .data,
                                                                    );
                                                                  }),
                                                                );
                                                              } else {
                                                                Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder:
                                                                          (context) {
                                                                    return DocumentsScreen();
                                                                  }),
                                                                );
                                                              }
                                                            },
                                                            child: SvgPicture
                                                                .asset(
                                                              "assets/images/edit_pin.svg",
                                                              width: 15,
                                                              height: 15,
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
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
                    // Container(
                    //   margin: EdgeInsets.only(top: 40, bottom: 20),
                    //   width: MediaQuery.of(context).size.width,
                    //   height: MediaQuery.of(context).size.width / 7,
                    //   decoration: BoxDecoration(
                    //     boxShadow: <BoxShadow>[
                    //       BoxShadow(
                    //         color: Colors.black26,
                    //         blurRadius: 5,
                    //         offset: Offset(2, 2),
                    //       ),
                    //     ],
                    //   ),
                    //   child: ButtonTheme(
                    //     shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(5),
                    //     ),
                    //     buttonColor: AppColors.COMPLETED_INFO_TEXT,
                    //     child: RaisedButton(
                    //       onPressed: () {
                    //         showDialog(
                    //             barrierDismissible: false,
                    //             context: context,
                    //             builder: (BuildContext context) {
                    //               return ErrorDialogWidget(
                    //                 text: "",
                    //               );
                    //             });
                    //       },
                    //       child: Text(
                    //         "Appointment Details ",
                    //         style: TextStyle(
                    //           fontFamily: 'Poppins',
                    //           fontSize: 14,
                    //           color: Colors.white,
                    //         ),
                    //         textAlign: TextAlign.center,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
              // Padding(
              //   padding: EdgeInsets.only(bottom: 5),
              //   child: Image.asset("assets/images/home_indicator.png"),
              // ),
            ],
          )),
        ));
  }

  _showAppointmentDetailsDialog(context) {
    return AlertDialog(
        contentPadding: EdgeInsets.all(0),
        insetPadding: EdgeInsets.all(0),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0))),
        content: Container(
          height: 370,
          width: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Appointment Details",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: AppColors.COMPLETED_INFO_TEXT,
                            fontFamily: 'Poppins')),
                    Padding(
                      padding: EdgeInsets.only(right: 110, top: 5, bottom: 20),
                      child: Divider(
                        thickness: 2.0,
                        color: AppColors.COMPLETED_INFO_TEXT,
                      ),
                    ),
                    Row(
                      children: [
                        Image.asset("assets/images/calendar.png"),
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 20, right: 6),
                              child: Text(
                                "---",
                                style: TextStyle(
                                    color: AppColors.labelColor,
                                    fontFamily: 'Poppins'),
                              ),
                            ),
                            Text(
                              "",
                              style: TextStyle(
                                  color: AppColors.labelColor,
                                  fontFamily: 'Poppins'),
                            )
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Image.asset("assets/images/clock.png"),
                        Padding(
                            padding: EdgeInsets.only(left: 20, right: 6),
                            child: Text(
                              "---",
                              style: TextStyle(
                                  color: AppColors.labelColor,
                                  fontFamily: 'Poppins'),
                            ))
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                padding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
                color: AppColors.DOCUMENTS_LABEL,
                child: Text(
                  "Contact Us",
                  style: TextStyle(
                      color: AppColors.labelColor, fontFamily: 'Poppins'),
                ),
              ),
              Container(
                  margin: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  spreadRadius: 2,
                                  blurRadius: 2,
                                  offset: Offset(
                                      0, 0.5), // changes position of shadow
                                ),
                              ],
                            ),
                            height: MediaQuery.of(context).size.width / 8,
                            child: ButtonTheme(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                buttonColor: Colors.white,
                                child: RaisedButton(
                                  padding: EdgeInsets.only(right: 5, left: 5),
                                  onPressed: () {},
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Image.asset(
                                        "assets/images/phone.png",
                                        width: 13,
                                        height: 13,
                                      ),
                                      Text(
                                        " 06 6565 6005",
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 12,
                                          color: AppColors.MAIN_COLOR,
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.DOCUMENTS_LABEL,
                                  spreadRadius: 2,
                                  blurRadius: 2,
                                  offset: Offset(
                                      0, 0.5), // changes position of shadow
                                ),
                              ],
                            ),
                            height: MediaQuery.of(context).size.width / 8,
                            child: ButtonTheme(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                buttonColor: Colors.white,
                                child: RaisedButton(
                                  padding: EdgeInsets.only(right: 5, left: 5),
                                  onPressed: () {},
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Image.asset(
                                        "assets/images/phone.png",
                                        width: 13,
                                        height: 13,
                                      ),
                                      Text(
                                        " 06 6565 6004",
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 12,
                                          color: AppColors.MAIN_COLOR,
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                          ),
                        ],
                      ),
                      Container(
                        height: MediaQuery.of(context).size.width / 7,
                        margin: EdgeInsets.only(
                            top: 20, bottom: 10, right: 10, left: 10),
                        width: MediaQuery.of(context).size.width,
                        child: ButtonTheme(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          buttonColor: AppColors.COMPLETED_INFO_TEXT,
                          child: RaisedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              "Done ",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 14,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ))
            ],
          ),
        ));
  }

  String convertDateDisplay(String date) {
    final DateFormat displayFormater = DateFormat('MMM dd, yyyy');
    final DateFormat serverFormater = DateFormat('dd MMM. yy');
    final DateTime displayDate = displayFormater.parse(date);
    final String formatted = serverFormater.format(displayDate);
    return formatted.replaceAll(".", "'");
  }

  String convertDay(String date) {
    print(date);

    return DateFormat('EEE,').format(DateTime.parse(Utils.dateFormat3(date)));
  }

  setVehicleData(CaptainData captainPersonalData) {
    // vehicleBloc.fetchAllCarBrand();
    // vehicleBloc.setCarBrand(captainPersonalData.data.car.carBrandName);
    vehicleBloc
        .setManufacturingYear(captainPersonalData.data.car.yearManu.toString());
    vehicleBloc.getSuggestions(captainPersonalData.data.car.carBrandName);
    vehicleBloc.setRegistrationExpireDate(Utils.dateTimeFormat2(
        captainPersonalData.data.car.insuranceExpiredDate));
    vehicleBloc.setPlateNumber(captainPersonalData.data.car.number);
    vehicleBloc.setSelectedColorId(captainPersonalData.data.car.colorId);
    vehicleBloc.setSelectedCountries(
        countryBloc.getCityById(captainPersonalData.data.car.cityId));
    vehicleBloc.setSelectedModelId(captainPersonalData.data.car.brandModelId);
  }
}
