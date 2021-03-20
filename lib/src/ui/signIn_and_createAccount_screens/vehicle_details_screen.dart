import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:posta_courier/models/car_model.dart';
import 'package:posta_courier/models/city_model.dart';
import 'package:posta_courier/models/get_captain_model.dart';
import 'package:posta_courier/src/blocs/signIn_and_createAccount_blocs/vehicle_bloc.dart';
import 'package:posta_courier/src/blocs/signIn_and_createAccount_blocs/sign_up_bloc.dart';
import 'package:posta_courier/src/constants/fonts_size.dart';
import 'package:posta_courier/src/ui/widgets/brand_auto_complete_tx.dart';
import 'package:posta_courier/src/ui/widgets/calender_widget.dart';
import 'package:posta_courier/src/ui/signIn_and_createAccount_screens/completed_info_screen.dart';
import 'package:posta_courier/src/utils/util.dart';
import 'package:posta_courier/validation/text_field_validation.dart';
import 'documents_screen.dart';
import 'file:///C:/Users/r.horani/AndroidStudioProjects/helix_courier_project/helix_courier_project/lib/src/constants/application_colors_value.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:posta_courier/src/blocs/signIn_and_createAccount_blocs/country_cities_bloc.dart';
import 'package:posta_courier/src/blocs/signIn_and_createAccount_blocs/signIn_bloc.dart';
import 'package:posta_courier/db/providers/cities_provider.dart';
import 'package:posta_courier/db/providers/colors_provider.dart';

class VehicleDetailsScreen extends StatelessWidget {
  CaptainData captainPersonalData;

  VehicleDetailsScreen({this.captainPersonalData});

  FocusNode plateNumberNode = new FocusNode();
  FocusNode brandsNode = new FocusNode();
  TextEditingController _typeAheadController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.white);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    vehicleBloc.fetchAllCarColor();
    vehicleBloc.getManufacturingYear();
    vehicleBloc.setCalendarColor(false);
    vehicleBloc.getCountries();
    // Utils.setScreen("/vehicle_screen");

    return GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Scaffold(
            backgroundColor: Colors.white,
            body: Container(
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
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
                                size:
                                    (MediaQuery.of(context).size.width * 0.04) +
                                        FontSize.HEADING_FONT -
                                        3,
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  "   VEHICLE  DETAILS",
                                  style: TextStyle(
                                      color: AppColors.TITLE_TEXT_COLOR,
                                      fontFamily: FontFamilies.POPPINS,
                                      fontSize:
                                          (MediaQuery.of(context).size.width *
                                                  0.04) +
                                              FontSize.HEADING_FONT -
                                              7,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.05,
                              right: MediaQuery.of(context).size.width * 0.05,
                              bottom: MediaQuery.of(context).size.width * 0.05,
                              top: MediaQuery.of(context).size.width * 0.05,
                            ),
                            child: Column(children: <Widget>[
                              carBrandTextField(context),
                              Container(
                                margin: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.height *
                                        0.043),
                                padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context).size.height *
                                        0.017),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                        width: 1.0,
                                        color: AppColors.LIGHT_BLUE),
                                  ),
                                ),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        "Vehicle Model ",
                                        style: TextStyle(
                                          fontFamily: FontFamilies.POPPINS,
                                          fontSize: (MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.02),
                                          color: AppColors.labelColor,
                                        ),
                                      ),
                                      Container(
                                        height: 20,
                                        child: StreamBuilder(
                                          stream: vehicleBloc.carModels,
                                          builder: (context,
                                              AsyncSnapshot<CarDataModel>
                                                  snap) {
                                            if (snap.hasData) {
                                              List<String> list = List();
                                              for (int i = 0;
                                                  i <
                                                      snap.data.carData.data
                                                          .length;
                                                  i++) {
                                                list.add(snap
                                                    .data.carData.data[i].name
                                                    .toString());
                                              }

                                              return InkWell(
                                                  onTap: () {
                                                    FocusScope.of(context)
                                                        .unfocus();
                                                    plateNumberNode.unfocus();
                                                  },
                                                  child:
                                                      PopupMenuButton<String>(
                                                    padding: EdgeInsets.all(0),
                                                    itemBuilder: (context) {
                                                      return list.map((value) {
                                                        return PopupMenuItem(
                                                          value: value,
                                                          child: Container(
                                                            height: 22,
                                                            alignment: Alignment
                                                                .bottomCenter,
                                                            child: Text(
                                                              value,
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    FontFamilies
                                                                        .POPPINS,
                                                                fontSize: (MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height *
                                                                    0.02),
                                                                color: AppColors
                                                                    .labelColor,
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      }).toList();
                                                    },
                                                    child: StreamBuilder(
                                                      stream: vehicleBloc
                                                          .selectedModel,
                                                      builder: (context, snap) {
                                                        if (snap.hasData) {
                                                          return Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: <Widget>[
                                                              Text(
                                                                snap.data
                                                                    .toString(),
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      FontFamilies
                                                                          .POPPINS,
                                                                  fontSize: (MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .height *
                                                                      0.02),
                                                                  color: AppColors
                                                                      .labelColor,
                                                                ),
                                                              ),
                                                              Container(
                                                                child: Icon(
                                                                  Icons
                                                                      .keyboard_arrow_down,
                                                                  size: (MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .height *
                                                                      0.02),
                                                                ),
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        bottom:
                                                                            3),
                                                              ),
                                                            ],
                                                          );
                                                        } else {
                                                          return Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: <Widget>[
                                                              Text(
                                                                list[0] == null
                                                                    ? " "
                                                                    : list[0],
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      FontFamilies
                                                                          .POPPINS,
                                                                  fontSize: (MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .height *
                                                                      0.02),
                                                                  color: AppColors
                                                                      .labelColor,
                                                                ),
                                                              ),
                                                              Container(
                                                                child: Icon(
                                                                  Icons
                                                                      .keyboard_arrow_down,
                                                                  size: (MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .height *
                                                                      0.02),
                                                                ),
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        bottom:
                                                                            3),
                                                              ),
                                                            ],
                                                          );
                                                        }
                                                      },
                                                    ),
                                                    onSelected: (value) {
                                                      // plateNumberNode.unfocus();
                                                      FocusScope.of(context)
                                                          .requestFocus(null);
                                                      vehicleBloc
                                                          .setSelectedModel(
                                                              value);
                                                    },
                                                  ));
                                            } else {
                                              return Text("");
                                            }
                                          },
                                        ),
                                      ),
                                    ]),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.height *
                                        0.04),
                                padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context).size.height *
                                        0.017),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                        width: 1.0,
                                        color: AppColors.LIGHT_BLUE),
                                  ),
                                ),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        "Vehicle Color ",
                                        style: TextStyle(
                                          fontFamily: FontFamilies.POPPINS,
                                          fontSize: (MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.02),
                                          color: AppColors.labelColor,
                                        ),
                                      ),
                                      StreamBuilder(
                                        stream: vehicleBloc.carColor,
                                        builder: (context,
                                            AsyncSnapshot<CarDataModel>
                                                snapshot) {
                                          if (snapshot.hasData) {
                                            List<String> list = List();
                                            for (int i = 0;
                                                i <
                                                    snapshot.data.carData.data
                                                        .length;
                                                i++) {
                                              list.add(snapshot
                                                  .data.carData.data[i].name
                                                  .toString());
                                            }

                                            return PopupMenuButton<String>(
                                              padding: EdgeInsets.all(0),
                                              itemBuilder: (context) {
                                                return list.map((value) {
                                                  return PopupMenuItem(
                                                    value: value,
                                                    child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        child: Text(
                                                          value,
                                                          style: TextStyle(
                                                            fontFamily:
                                                                FontFamilies
                                                                    .POPPINS,
                                                            fontSize: (MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.02),
                                                            color: AppColors
                                                                .labelColor,
                                                          ),
                                                        )),
                                                  );
                                                }).toList();
                                              },
                                              child: StreamBuilder(
                                                stream:
                                                    vehicleBloc.selectedColor,
                                                builder: (context, snap) {
                                                  if (snap.hasData) {
                                                    return Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: <Widget>[
                                                        Text(
                                                          snap.data.toString(),
                                                          style: TextStyle(
                                                            fontFamily:
                                                                FontFamilies
                                                                    .POPPINS,
                                                            fontSize: (MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.02),
                                                            color: AppColors
                                                                .labelColor,
                                                          ),
                                                        ),
                                                        Container(
                                                          child: Icon(
                                                            Icons
                                                                .keyboard_arrow_down,
                                                            size: (MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.02),
                                                          ),
                                                          alignment:
                                                              Alignment.center,
                                                          padding:
                                                              EdgeInsets.only(
                                                                  bottom: 3),
                                                        ),
                                                      ],
                                                    );
                                                  } else {
                                                    return Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: <Widget>[
                                                        Text(
                                                          list[0],
                                                          style: TextStyle(
                                                            fontFamily:
                                                                FontFamilies
                                                                    .POPPINS,
                                                            fontSize: (MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.02),
                                                            color: AppColors
                                                                .labelColor,
                                                          ),
                                                        ),
                                                        Container(
                                                          child: Icon(
                                                            Icons
                                                                .keyboard_arrow_down,
                                                            size: (MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.02),
                                                          ),
                                                          alignment:
                                                              Alignment.center,
                                                          padding:
                                                              EdgeInsets.only(
                                                                  bottom: 3),
                                                        ),
                                                      ],
                                                    );
                                                  }
                                                },
                                              ),
                                              onSelected: (value) {
                                                plateNumberNode.unfocus();
                                                vehicleBloc
                                                    .setSelectedColor(value);
                                              },
                                            );
                                          } else {
                                            return Text("");
                                          }
                                        },
                                      )
                                    ]),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.height *
                                        0.04),
                                padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context).size.height *
                                        0.017),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                        width: 1.0,
                                        color: AppColors.LIGHT_BLUE),
                                  ),
                                ),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        "Vehicle Manufacture Year ",
                                        style: TextStyle(
                                          fontFamily: FontFamilies.POPPINS,
                                          fontSize: (MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.02),
                                          color: AppColors.labelColor,
                                        ),
                                      ),
                                      StreamBuilder(
                                        stream: vehicleBloc.manuYearList,
                                        builder: (context,
                                            AsyncSnapshot<List<String>> snap) {
                                          if (snap.hasData) {
                                            List<String> list = List();
                                            for (int i = 0;
                                                i < snap.data.length;
                                                i++) {
                                              list.add(snap.data[i].toString());
                                            }

                                            return PopupMenuButton<String>(
                                              padding: EdgeInsets.all(0),
                                              itemBuilder: (context) {
                                                return list.map((value) {
                                                  return PopupMenuItem(
                                                    value: value,
                                                    child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        child: Text(
                                                          value,
                                                          style: TextStyle(
                                                            fontFamily:
                                                                FontFamilies
                                                                    .POPPINS,
                                                            fontSize: (MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.02),
                                                            color: AppColors
                                                                .labelColor,
                                                          ),
                                                        )),
                                                  );
                                                }).toList();
                                              },
                                              child: StreamBuilder(
                                                stream: vehicleBloc
                                                    .selectedManuYear,
                                                builder: (context, snap) {
                                                  if (snap.hasData) {
                                                    return Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: <Widget>[
                                                        Text(
                                                          snap.data.toString(),
                                                          style: TextStyle(
                                                            fontFamily:
                                                                FontFamilies
                                                                    .POPPINS,
                                                            fontSize: (MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.02),
                                                            color: AppColors
                                                                .labelColor,
                                                          ),
                                                        ),
                                                        Container(
                                                          child: Icon(
                                                            Icons
                                                                .keyboard_arrow_down,
                                                            size: (MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.02),
                                                          ),
                                                          alignment:
                                                              Alignment.center,
                                                          padding:
                                                              EdgeInsets.only(
                                                                  bottom: 3),
                                                        ),
                                                      ],
                                                    );
                                                  } else {
                                                    return Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: <Widget>[
                                                        Text(
                                                          "YYYY",
                                                          style: TextStyle(
                                                            fontFamily:
                                                                FontFamilies
                                                                    .POPPINS,
                                                            fontSize: (MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.02),
                                                            color: AppColors
                                                                .labelColor,
                                                          ),
                                                        ),
                                                        Container(
                                                          child: Icon(
                                                            Icons
                                                                .keyboard_arrow_down,
                                                            size: (MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.02),
                                                          ),
                                                          alignment:
                                                              Alignment.center,
                                                          padding:
                                                              EdgeInsets.only(
                                                                  bottom: 3),
                                                        ),
                                                      ],
                                                    );
                                                  }
                                                },
                                              ),
                                              onSelected: (value) {
                                                plateNumberNode.unfocus();
                                                vehicleBloc
                                                    .setManufacturingYear(
                                                        value);
                                              },
                                            );
                                          } else {
                                            return Text("");
                                          }
                                        },
                                      ),
                                    ]),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.height *
                                        0.043),
                                padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context).size.height *
                                        0.017),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                        width: 1.0,
                                        color: AppColors.LIGHT_BLUE),
                                  ),
                                ),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        "Vehicle State ",
                                        style: TextStyle(
                                          fontFamily: FontFamilies.POPPINS,
                                          fontSize: (MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.02),
                                          color: AppColors.labelColor,
                                        ),
                                      ),
                                      StreamBuilder(
                                        stream: vehicleBloc.countries,
                                        builder: (context,
                                            AsyncSnapshot<CityModel> snapshot) {
                                          if (snapshot.hasData) {
                                            List<String> list = List();
                                            for (int i = 0;
                                                i < snapshot.data.data.length;
                                                i++) {
                                              list.add(snapshot
                                                  .data.data[i].nameEN
                                                  .toString());
                                            }

                                            return PopupMenuButton<String>(
                                              padding: EdgeInsets.all(0),
                                              itemBuilder: (context) {
                                                return list.map((value) {
                                                  return PopupMenuItem(
                                                    value: value,
                                                    child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        child: Text(
                                                          value,
                                                          style: TextStyle(
                                                            fontFamily:
                                                                FontFamilies
                                                                    .POPPINS,
                                                            fontSize: (MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.02),
                                                            color: AppColors
                                                                .labelColor,
                                                          ),
                                                        )),
                                                  );
                                                }).toList();
                                              },
                                              child: StreamBuilder(
                                                stream: vehicleBloc
                                                    .selectedCountries,
                                                builder: (context, snap) {
                                                  if (snap.hasData) {
                                                    return Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: <Widget>[
                                                        Text(
                                                          snap.data.toString(),
                                                          style: TextStyle(
                                                            fontFamily:
                                                                FontFamilies
                                                                    .POPPINS,
                                                            fontSize: (MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.02),
                                                            color: AppColors
                                                                .labelColor,
                                                          ),
                                                        ),
                                                        Container(
                                                          child: Icon(
                                                            Icons
                                                                .keyboard_arrow_down,
                                                            size: (MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.02),
                                                          ),
                                                          alignment:
                                                              Alignment.center,
                                                          padding:
                                                              EdgeInsets.only(
                                                                  bottom: 3),
                                                        ),
                                                      ],
                                                    );
                                                  } else {
                                                    return Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: <Widget>[
                                                        Text(
                                                          captainPersonalData !=
                                                                  null
                                                              ? vehicleBloc
                                                                  .setSelectedCountries(snapshot
                                                                      .data
                                                                      .data[snapshot
                                                                          .data
                                                                          .data
                                                                          .indexWhere((element) =>
                                                                              element.id ==
                                                                              captainPersonalData.data.countryId)]
                                                                      .nameEN)
                                                                  .toString()
                                                              : list[0],
                                                          style: TextStyle(
                                                            fontFamily:
                                                                FontFamilies
                                                                    .POPPINS,
                                                            fontSize: (MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.02),
                                                            color: AppColors
                                                                .labelColor,
                                                          ),
                                                        ),
                                                        Container(
                                                          child: Icon(
                                                            Icons
                                                                .keyboard_arrow_down,
                                                            size: (MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.02),
                                                          ),
                                                          alignment:
                                                              Alignment.center,
                                                          padding:
                                                              EdgeInsets.only(
                                                                  bottom: 3),
                                                        ),
                                                      ],
                                                    );
                                                  }
                                                },
                                              ),
                                              onSelected: (value) {
                                                plateNumberNode.unfocus();
                                                vehicleBloc
                                                    .setSelectedCountries(
                                                        value);
                                              },
                                            );
                                          } else {
                                            return Text("");
                                          }
                                        },
                                      )
                                      // FutureBuilder<List<City>>(
                                      //     future: CitiesDBProvider.db
                                      //         .getAllCities(),
                                      //     builder: (BuildContext context,
                                      //         AsyncSnapshot<List<City>>
                                      //             snapshot) {
                                      //       if (snapshot.hasData) {
                                      //         List<String> list = List();
                                      //         for (int i = 0;
                                      //             i < snapshot.data.length;
                                      //             i++) {
                                      //           list.add(snapshot.data[i].nameEN
                                      //               .toString());
                                      //         }
                                      //
                                      //         return PopupMenuButton<String>(
                                      //           padding: EdgeInsets.all(0),
                                      //           itemBuilder: (context) {
                                      //             return list.map((value) {
                                      //               return PopupMenuItem(
                                      //                 value: value,
                                      //                 child: Text(
                                      //                   value,
                                      //                   style: TextStyle(
                                      //                     fontFamily:
                                      //                         FontFamilies
                                      //                             .POPPINS,
                                      //                     fontSize:
                                      //                         (MediaQuery.of(
                                      //                                     context)
                                      //                                 .size
                                      //                                 .height *
                                      //                             0.02),
                                      //                     color: AppColors
                                      //                         .labelColor,
                                      //                   ),
                                      //                 ),
                                      //               );
                                      //             }).toList();
                                      //           },
                                      //           child: StreamBuilder(
                                      //             stream: vehicleBloc
                                      //                 .selectedCountries,
                                      //             builder: (context, snap) {
                                      //               if (snap.hasData) {
                                      //                 return Row(
                                      //                   mainAxisSize:
                                      //                       MainAxisSize.min,
                                      //                   children: <Widget>[
                                      //                     Text(
                                      //                       snap.data
                                      //                           .toString(),
                                      //                       style: TextStyle(
                                      //                         fontFamily:
                                      //                             FontFamilies
                                      //                                 .POPPINS,
                                      //                         fontSize: (MediaQuery.of(
                                      //                                     context)
                                      //                                 .size
                                      //                                 .height *
                                      //                             0.02),
                                      //                         color: AppColors
                                      //                             .labelColor,
                                      //                       ),
                                      //                     ),
                                      //                     Container(
                                      //                       child: Icon(
                                      //                         Icons
                                      //                             .keyboard_arrow_down,
                                      //                         size: 15,
                                      //                       ),
                                      //                       alignment: Alignment
                                      //                           .center,
                                      //                       padding:
                                      //                           EdgeInsets.only(
                                      //                               bottom: 3),
                                      //                     ),
                                      //                   ],
                                      //                 );
                                      //               } else {
                                      //                 return Row(
                                      //                   mainAxisSize:
                                      //                       MainAxisSize.min,
                                      //                   children: <Widget>[
                                      //                     Text(
                                      //                       list[0],
                                      //                       style: TextStyle(
                                      //                         fontFamily:
                                      //                             FontFamilies
                                      //                                 .POPPINS,
                                      //                         fontSize: (MediaQuery.of(
                                      //                                     context)
                                      //                                 .size
                                      //                                 .height *
                                      //                             0.02),
                                      //                         color: AppColors
                                      //                             .labelColor,
                                      //                       ),
                                      //                     ),
                                      //                     Container(
                                      //                       child: Icon(
                                      //                         Icons
                                      //                             .keyboard_arrow_down,
                                      //                         size: 15,
                                      //                       ),
                                      //                       alignment: Alignment
                                      //                           .center,
                                      //                       padding:
                                      //                           EdgeInsets.only(
                                      //                               bottom: 3),
                                      //                     ),
                                      //                   ],
                                      //                 );
                                      //               }
                                      //             },
                                      //           ),
                                      //           onSelected: (value) {
                                      //             vehicleBloc
                                      //                 .setSelectedCountries(
                                      //                     value);
                                      //           },
                                      //         );
                                      //       } else {
                                      //         return Text("");
                                      //       }
                                      //     }),
                                    ]),
                              ),
                              plateNumberTextField(),
                              Container(
                                margin: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.height *
                                        0.04),
                                padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context).size.height *
                                        0.017),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      "Registration Expiry Date",
                                      style: TextStyle(
                                        fontFamily: FontFamilies.POPPINS,
                                        fontSize: (MediaQuery.of(context)
                                                .size
                                                .height *
                                            0.02),
                                        color: AppColors.labelColor,
                                      ),
                                    ),
                                    StreamBuilder(
                                      stream:
                                          vehicleBloc.registrationExpiredDate,
                                      builder: (context, snap) {
                                        if (snap.hasData) {
                                          return InkWell(
                                            onTap: () {
                                              showDialog(
                                                  barrierDismissible: false,
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return CalendarWidget(
                                                      screen:
                                                          "REGISTRATION_EXPIRY_DATE",
                                                    );
                                                  });
                                            },
                                            child: Text(
                                              Utils.dateFormat1(snap.data),
                                              style: TextStyle(
                                                fontFamily:
                                                    FontFamilies.POPPINS,
                                                fontSize:
                                                    (MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                        0.02),
                                                color: AppColors.MAIN_COLOR,
                                              ),
                                            ),
                                          );
                                        } else {
                                          return calendarDialog(context);
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              StreamBuilder(
                                stream: vehicleBloc
                                    .registrationExpireDateValidation,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        padding: EdgeInsets.only(
                                            top: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.01),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Image.asset(
                                              "assets/images/error_icon.png",
                                              width: 10,
                                              height: 10,
                                            ),
                                            Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    60,
                                                padding:
                                                    EdgeInsets.only(left: 8),
                                                child: Text(
                                                  "  " + snapshot.data,
                                                  style: TextStyle(
                                                      color: AppColors.ERROR,
                                                      fontFamily: 'Poppins',
                                                      fontSize: 10),
                                                )),
                                          ],
                                        ));
                                  } else {
                                    return Container();
                                  }
                                },
                              ),
                            ])),
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
                      top: MediaQuery.of(context).size.width * 0.1,
                      bottom: MediaQuery.of(context).size.width * 0.2,
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
                          stream: vehicleBloc.submitValid,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return RaisedButton(
                                onPressed: () {
                                  TextFieldValidation()
                                      .checkRegistrationExpiredDateValidation(
                                          vehicleBloc
                                              .getRegistrationExpireDate());

                                  if (vehicleBloc
                                      .checkRegistrationExpireDateValidation()) {
                                    vehicleBloc.createVehicle();
                                    captainPersonalData == null
                                        ? Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                              return DocumentsScreen();
                                            }),
                                          )
                                        : Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                              return CompletedInfoScreen();
                                            }),
                                          );
                                  }
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      "Continue ",
                                      style: TextStyle(
                                        fontFamily: FontFamilies.POPPINS,
                                        fontSize:
                                            (MediaQuery.of(context).size.width *
                                                    0.008) +
                                                FontSize.BUTTON_FONT_L,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Icon(
                                      Icons.arrow_forward,
                                      color: Colors.black,
                                      size: (MediaQuery.of(context).size.width *
                                              0.008) +
                                          18,
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
                                    Text(
                                      "Continue ",
                                      style: TextStyle(
                                        fontFamily: FontFamilies.POPPINS,
                                        fontSize:
                                            (MediaQuery.of(context).size.width *
                                                    0.008) +
                                                FontSize.BUTTON_FONT_L,
                                        color: AppColors.LIGHT_GREY,
                                      ),
                                    ),
                                    Icon(
                                      Icons.arrow_forward,
                                      color: AppColors.LIGHT_GREY,
                                      size: (MediaQuery.of(context).size.width *
                                              0.008) +
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
            )));
  }

  carBrandTextField(context) {
    return captainPersonalData != null
        ? Brands(
            init: captainPersonalData != null
                ? captainPersonalData.data.car.carBrandName
                : "",
          )
        : TypeAheadFormField(
            textFieldConfiguration: TextFieldConfiguration(
              focusNode: brandsNode,
              style: TextStyle(
                fontFamily: FontFamilies.POPPINS,
                fontSize: (MediaQuery.of(context).size.height * 0.02),
                color: Colors.black,
              ),
              controller: _typeAheadController,
              decoration: InputDecoration(
                // hintText: captainPersonalData!=null?captainPersonalData.data.car.carBrandName:" ",
                contentPadding: EdgeInsets.all(0),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.LIGHT_BLUE),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.MAIN_COLOR),
                ),
                labelText: 'Vehicle Make',
                labelStyle: TextStyle(
                  color: AppColors.labelColor,
                  fontFamily: FontFamilies.POPPINS,
                  fontSize: (MediaQuery.of(context).size.height * 0.02),
                ),
              ),
            ),
            itemBuilder: (BuildContext context, suggestion) {
              return ListTile(
                title: Text(
                  suggestion,
                  style: TextStyle(
                    fontFamily: FontFamilies.POPPINS,
                    fontSize: (MediaQuery.of(context).size.height * 0.02),
                    color: AppColors.labelColor,
                  ),
                ),
              );
            },
            suggestionsCallback: (String pattern) {
              return vehicleBloc.getSuggestions(pattern);
            },
            onSuggestionSelected: (suggestion) {
              // captainPersonalData != null
              //     ? _typeAheadController.text =
              //         captainPersonalData.data.car.carBrandName
              //     :
              _typeAheadController.text = suggestion;
              vehicleBloc.setCarBrand(suggestion.toString());
              // vehicleBloc.getSuggestions("a");
            },
            onSaved: (suggestion) {
              // vehicleBloc.getSuggestions(null);
            },
          );
  }

  Widget plateNumberTextField() => StreamBuilder<String>(
        stream: vehicleBloc.plateNumber,
        builder: (context, snap) {
          return Container(
            margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.018),
            child: TextFormField(
              style: TextStyle(
                fontFamily: FontFamilies.POPPINS,
                fontSize: (MediaQuery.of(context).size.height * 0.02),
              ),
              initialValue: captainPersonalData != null
                  ? captainPersonalData.data.car.number
                  : "",
              focusNode: plateNumberNode,
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
                labelText: 'Plate Number',
                labelStyle: TextStyle(
                    color: AppColors.labelColor, fontFamily: 'Poppins'),
              ),
              onChanged: (vehicleBloc.changePlateNumber),
            ),
          );
        },
      );

  InkWell calendarDialog(BuildContext context) {
    return InkWell(
      onTap: () {
        vehicleBloc.setCalendarColor(true);
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return CalendarWidget(
                screen: "REGISTRATION_EXPIRY_DATE",
              );
            });
      },
      child: StreamBuilder(
        stream: vehicleBloc.calendarColor,
        builder: (context, snap) {
          if (snap.hasData) {
            return SvgPicture.asset(
              "assets/images/calendar.svg",
              width: 17,
              height: 17,
              color: snap.data ? AppColors.MAIN_COLOR : AppColors.labelColor,
            );
          } else {
            return SvgPicture.asset(
              "assets/images/calendar.svg",
              width: 17,
              height: 17,
            );
          }
        },
      ),
    );
  }

  Iterable distinct(Iterable i) {
    var set = new Set();
    return i.where((e) {
      var isNew = !set.contains(e);
      set.add(e);
      return isNew;
    });
  }
}
