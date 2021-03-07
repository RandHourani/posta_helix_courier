import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:posta_courier/db/providers/colors_provider.dart';
import 'package:posta_courier/db/providers/cities_provider.dart';
import 'package:posta_courier/models/car_model.dart';
import 'package:posta_courier/models/city_model.dart';
import 'package:posta_courier/src/constants/application_colors_value.dart';
import 'package:posta_courier/src/constants/fonts_size.dart';
import 'package:posta_courier/src/ui/home/side_menu_screens/vehicle_documents_screen.dart';
import 'package:posta_courier/src/ui/widgets/calender_widget.dart';
import 'package:posta_courier/src/utils/util.dart';
import 'package:posta_courier/validation/text_field_validation.dart';
import 'profile_screen.dart';
import 'package:posta_courier/src/blocs/home_blocs/new_vehicle_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddNewCar extends StatelessWidget {
  FocusNode firstNameNode = new FocusNode();
  FocusNode lastNameNode = new FocusNode();
  FocusNode emailNode = new FocusNode();
  FocusNode passNode = new FocusNode();
  FocusNode confirmPassNode = new FocusNode();
  FocusNode brandNode = new FocusNode();
  FocusNode plateCodeNode = new FocusNode();
  FocusNode plateNumberNode = new FocusNode();
  TextEditingController _typeAheadController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.white);
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    // newVehicleBloc.getCountries();
    newVehicleBloc.fetchAllCarBrand();
    // newVehicleBloc.fetchAllCarColor();
    newVehicleBloc.getManufacturingYear();
    newVehicleBloc.setCalendarColor(false);

    return Scaffold(
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
                            size: (MediaQuery.of(context).size.width * 0.04) +
                                FontSize.HEADING_FONT -
                                3,
                          ),
                          InkWell(
                            onTap: () {
                              SystemChrome.setSystemUIOverlayStyle(
                                  SystemUiOverlayStyle(
                                      statusBarColor: Colors.transparent));
                              Navigator.pop(context);
                            },
                            child: Text(
                              "   ADD  VEHICLE",
                              style: TextStyle(
                                  color: AppColors.TITLE_TEXT_COLOR,
                                  fontFamily: FontFamilies.POPPINS,
                                  fontSize: (MediaQuery.of(context).size.width *
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
                                top:
                                    MediaQuery.of(context).size.height * 0.043),
                            padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).size.height * 0.017),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                    width: 1.0, color: AppColors.LIGHT_BLUE),
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
                                      fontSize:
                                          (MediaQuery.of(context).size.height *
                                              0.02),
                                      color: AppColors.labelColor,
                                    ),
                                  ),
                                  Container(
                                    height: 20,
                                    child: StreamBuilder(
                                      stream: newVehicleBloc.carModels,
                                      builder: (context,
                                          AsyncSnapshot<CarDataModel> snap) {
                                        if (snap.hasData) {
                                          List<String> list = List();
                                          for (int i = 0;
                                              i < snap.data.carData.data.length;
                                              i++) {
                                            list.add(snap
                                                .data.carData.data[i].name
                                                .toString());
                                          }
                                          newVehicleBloc
                                              .setSelectedModel(list[0]);
                                          return PopupMenuButton<String>(
                                            padding: EdgeInsets.all(0),
                                            itemBuilder: (context) {
                                              return list.map((value) {
                                                return PopupMenuItem(
                                                  value: value,
                                                  child: Text(
                                                    value,
                                                    style: TextStyle(
                                                      fontFamily:
                                                          FontFamilies.POPPINS,
                                                      fontSize: (MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .height *
                                                          0.02),
                                                      color:
                                                          AppColors.labelColor,
                                                    ),
                                                  ),
                                                );
                                              }).toList();
                                            },
                                            child: StreamBuilder(
                                              stream:
                                                  newVehicleBloc.selectedModel,
                                              builder: (context, snap) {
                                                return Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: <Widget>[
                                                    Text(
                                                      snap.data.toString(),
                                                      style: TextStyle(
                                                        fontFamily: FontFamilies
                                                            .POPPINS,
                                                        fontSize:
                                                            (MediaQuery.of(
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
                                                      padding: EdgeInsets.only(
                                                          bottom: 3),
                                                    ),
                                                  ],
                                                );
                                              },
                                            ),
                                            onSelected: (value) {
                                              newVehicleBloc
                                                  .setSelectedModel(value);
                                            },
                                          );
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
                                top: MediaQuery.of(context).size.height * 0.04),
                            padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).size.height * 0.017),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                    width: 1.0, color: AppColors.LIGHT_BLUE),
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
                                      fontSize:
                                          (MediaQuery.of(context).size.height *
                                              0.02),
                                      color: AppColors.labelColor,
                                    ),
                                  ),
                                  FutureBuilder<List<ColorModelDetails>>(
                                      future:
                                          ColorsDBProvider.db.getAllColors(),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<List<ColorModelDetails>>
                                              snapshot) {
                                        List<String> list = List();

                                        if (snapshot.hasData) {
                                          for (int i = 0;
                                              i < snapshot.data.length;
                                              i++) {
                                            list.add(snapshot.data[i].name);
                                          }

                                          return PopupMenuButton<String>(
                                            padding: EdgeInsets.all(0),
                                            itemBuilder: (context) {
                                              return list.map((value) {
                                                return PopupMenuItem(
                                                  value: value,
                                                  child: Text(
                                                    value,
                                                    style: TextStyle(
                                                      fontFamily:
                                                          FontFamilies.POPPINS,
                                                      fontSize: (MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .height *
                                                          0.02),
                                                      color:
                                                          AppColors.labelColor,
                                                    ),
                                                  ),
                                                );
                                              }).toList();
                                            },
                                            child: StreamBuilder(
                                              stream:
                                                  newVehicleBloc.selectedColor,
                                              builder: (context, snapshot) {
                                                if(snapshot.hasData){
                                                  print(snapshot.data.length);
                                                return Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: <Widget>[
                                                    Text(
                                                      snapshot.data.toString(),
                                                      style: TextStyle(
                                                        fontFamily: FontFamilies
                                                            .POPPINS,
                                                        fontSize:
                                                            (MediaQuery.of(
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
                                                        size: 15,
                                                      ),
                                                      alignment:
                                                          Alignment.center,
                                                      padding: EdgeInsets.only(
                                                          bottom: 3),
                                                    ),
                                                  ],
                                                );}
                                                else
                                                  {
                                                    return Row(
                                                      mainAxisSize:
                                                      MainAxisSize.min,
                                                      children: <Widget>[
                                                        Text(
                                                         list[0],
                                                          style: TextStyle(
                                                            fontFamily: FontFamilies
                                                                .POPPINS,
                                                            fontSize:
                                                            (MediaQuery.of(
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
                                                            size: 15,
                                                          ),
                                                          alignment:
                                                          Alignment.center,
                                                          padding: EdgeInsets.only(
                                                              bottom: 3),
                                                        ),
                                                      ],
                                                    );
                                                  }
                                              },
                                            ),
                                            onSelected: (value) {
                                              newVehicleBloc
                                                  .setSelectedColor(value);
                                            },
                                          );
                                        } else {
                                          return Text("");
                                        }
                                      })
                                ]),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.04),
                            padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).size.height * 0.017),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                    width: 1.0, color: AppColors.LIGHT_BLUE),
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
                                      fontSize:
                                          (MediaQuery.of(context).size.height *
                                              0.02),
                                      color: AppColors.labelColor,
                                    ),
                                  ),
                                  StreamBuilder(
                                    stream: newVehicleBloc.manuYearList,
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
                                                child: Text(
                                                  value,
                                                  style: TextStyle(
                                                    fontFamily:
                                                        FontFamilies.POPPINS,
                                                    fontSize:
                                                        (MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.02),
                                                    color: AppColors.labelColor,
                                                  ),
                                                ),
                                              );
                                            }).toList();
                                          },
                                          child: StreamBuilder(
                                            stream:
                                                newVehicleBloc.selectedManuYear,
                                            builder: (context, snap) {
                                              if (snap.hasData) {
                                                return Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: <Widget>[
                                                    Text(
                                                      snap.data.toString(),
                                                      style: TextStyle(
                                                        fontFamily: FontFamilies
                                                            .POPPINS,
                                                        fontSize:
                                                            (MediaQuery.of(
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
                                                      padding: EdgeInsets.only(
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
                                                        fontFamily: FontFamilies
                                                            .POPPINS,
                                                        fontSize:
                                                            (MediaQuery.of(
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
                                                      padding: EdgeInsets.only(
                                                          bottom: 3),
                                                    ),
                                                  ],
                                                );
                                              }
                                            },
                                          ),
                                          onSelected: (value) {
                                            newVehicleBloc
                                                .setManufacturingYear(value);
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
                                top:
                                    MediaQuery.of(context).size.height * 0.043),
                            padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).size.height * 0.017),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                    width: 1.0, color: AppColors.LIGHT_BLUE),
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
                                      fontSize:
                                          (MediaQuery.of(context).size.height *
                                              0.02),
                                      color: AppColors.labelColor,
                                    ),
                                  ),

                                  FutureBuilder<List<City>>(
                                      future:
                                      CitiesDBProvider.db.getAllCities(),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<List<City>>
                                          snapshot) {
                                        print(snapshot.data);
                                        if (snapshot.hasData) {
                                          List<String> list = List();
                                          for (int i = 0;
                                          i < snapshot.data.length;
                                          i++) {
                                            list.add(snapshot.data[i].nameEN
                                                .toString());
                                          }
                                          // newVehicleBloc
                                          //     .setSelectedCountries(list[0]);
                                          return PopupMenuButton<String>(
                                            padding: EdgeInsets.all(0),
                                            itemBuilder: (context) {
                                              return list.map((value) {
                                                return PopupMenuItem(
                                                  value: value,
                                                  child: Text(
                                                    value,
                                                    style: TextStyle(
                                                      fontFamily:
                                                      FontFamilies.POPPINS,
                                                      fontSize: (MediaQuery.of(
                                                          context)
                                                          .size
                                                          .height *
                                                          0.02),
                                                      color:
                                                      AppColors.labelColor,
                                                    ),
                                                  ),
                                                );
                                              }).toList();
                                            },
                                            child: StreamBuilder(
                                              stream:
                                              newVehicleBloc.selectedCountries,
                                              builder: (context, snap) {
                                                if(snap.hasData){
                                                return Row(
                                                  mainAxisSize:
                                                  MainAxisSize.min,
                                                  children: <Widget>[
                                                    Text(
                                                      snap.data.toString(),
                                                      style: TextStyle(
                                                        fontFamily: FontFamilies
                                                            .POPPINS,
                                                        fontSize:
                                                        (MediaQuery.of(
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
                                                        size: 15,
                                                      ),
                                                      alignment:
                                                      Alignment.center,
                                                      padding: EdgeInsets.only(
                                                          bottom: 3),
                                                    ),
                                                  ],
                                                );}
                                                else
                                                {
                                                  return Row(
                                                    mainAxisSize:
                                                    MainAxisSize.min,
                                                    children: <Widget>[
                                                      Text(
                                                        list[0],
                                                        style: TextStyle(
                                                          fontFamily: FontFamilies
                                                              .POPPINS,
                                                          fontSize:
                                                          (MediaQuery.of(
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
                                                          size: 15,
                                                        ),
                                                        alignment:
                                                        Alignment.center,
                                                        padding: EdgeInsets.only(
                                                            bottom: 3),
                                                      ),
                                                    ],
                                                  );
                                                }
                                              },
                                            ),
                                            onSelected: (value) {
                                              newVehicleBloc
                                                  .setSelectedCountries(value);
                                            },
                                          );
                                        } else {
                                          return Text("");
                                        }
                                      })
                                ]),
                          ),
                          plateNumberTextField(),
                          Container(
                            margin: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.04),
                            padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).size.height * 0.017),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "Registration Expiry Date",
                                  style: TextStyle(
                                    fontFamily: FontFamilies.POPPINS,
                                    fontSize:
                                        (MediaQuery.of(context).size.height *
                                            0.02),
                                    color: AppColors.labelColor,
                                  ),
                                ),
                                StreamBuilder(
                                  stream:
                                      newVehicleBloc.registrationExpiredDate,
                                  builder: (context, snap) {
                                    if (snap.hasData) {
                                      return InkWell(
                                        onTap: () {
                                          showDialog(
                                              barrierDismissible: false,
                                              context: context,
                                              builder: (BuildContext context) {
                                                return CalendarWidget(
                                                  screen:
                                                      "REGISTRATION_EXPIRY_DATE_NEW_CAR",
                                                );
                                              });
                                        },
                                        child: Text(
                                          Utils.dateFormat1(snap.data),
                                          style: TextStyle(
                                            fontFamily: FontFamilies.POPPINS,
                                            fontSize: (MediaQuery.of(context)
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
                            stream:
                                newVehicleBloc.registrationExpireDateValidation,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding: EdgeInsets.only(
                                        top: MediaQuery.of(context).size.width *
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
                                            padding: EdgeInsets.only(left: 8),
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
                  bottom: MediaQuery.of(context).size.width * 0.18,
                  top: MediaQuery.of(context).size.width * 0.1,
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
                      stream: newVehicleBloc.submitValid,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return RaisedButton(
                            onPressed: () {
                              TextFieldValidation()
                                  .checkRegistrationExpiredDateValidation(
                                      newVehicleBloc
                                          .getRegistrationExpireDate());

                              if (newVehicleBloc
                                  .checkRegistrationExpireDateValidation()) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) {
                                    return VehicleDocumentsScreen();
                                  }),
                                );
                              } else {}
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) {
                                  return VehicleDocumentsScreen();
                                }),
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 5),
                  child: Image.asset("assets/images/home_indicator.png"),
                ),
              ),
            ],
          )),
        ));
  }

  carBrandTextField(context) {
    if (_typeAheadController.text == null) {
      newVehicleBloc.getSuggestions("a");
    }

    return TypeAheadFormField(
      textFieldConfiguration: TextFieldConfiguration(
        style: TextStyle(
          fontFamily: FontFamilies.POPPINS,
          fontSize: (MediaQuery.of(context).size.height * 0.02),
          color: Colors.black,
        ),
        controller: _typeAheadController,
        decoration: InputDecoration(
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
        return newVehicleBloc.getSuggestions(pattern);
      },
      onSuggestionSelected: (suggestion) {
        print(suggestion.toString());
        _typeAheadController.text = suggestion;

        newVehicleBloc.setCarBrand(suggestion.toString());
        newVehicleBloc.fetchAllCarModels();
        newVehicleBloc.getSuggestions("a");
      },
      onSaved: (suggestion) {
        newVehicleBloc.getSuggestions(null);
      },
    );
  }

  Widget plateCodeTextField() => StreamBuilder<String>(
        stream: newVehicleBloc.plateCode,
        builder: (context, snap) {
          return Container(
            margin: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.018,
            ),
            child: TextField(
              style: TextStyle(
                fontFamily: FontFamilies.POPPINS,
                fontSize: (MediaQuery.of(context).size.height * 0.02),
              ),
              focusNode: plateCodeNode,
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
                labelText: 'Plate Code',
                labelStyle: TextStyle(
                    color: AppColors.labelColor, fontFamily: 'Poppins'),
              ),
              onChanged: (newVehicleBloc.changePlateCode),
            ),
          );
        },
      );

  Widget plateNumberTextField() => StreamBuilder<String>(
        stream: newVehicleBloc.plateNumber,
        builder: (context, snap) {
          return Container(
            margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.018),
            child: TextField(
              style: TextStyle(
                fontFamily: FontFamilies.POPPINS,
                fontSize: (MediaQuery.of(context).size.height * 0.02),
              ),
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
              onChanged: (newVehicleBloc.changePlateNumber),
            ),
          );
        },
      );

  InkWell calendarDialog(BuildContext context) {
    return InkWell(
      onTap: () {
        newVehicleBloc.setCalendarColor(true);
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return CalendarWidget(
                screen: "REGISTRATION_EXPIRY_DATE_NEW_CAR",
              );
            });
      },
      child: StreamBuilder(
        stream: newVehicleBloc.calendarColor,
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
