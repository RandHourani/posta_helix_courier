import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:posta_courier/models/weekly_report_details_model.dart';
import 'package:posta_courier/src/blocs/home_blocs/weekly_report_bloc.dart';
import 'package:posta_courier/src/constants/application_colors_value.dart';
import 'package:posta_courier/src/constants/fonts_size.dart';

class WeeklyDetailsScreen extends StatelessWidget {
  WeeklyReportDetailsModel data;

  WeeklyDetailsScreen({this.data});

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(
    //     SystemUiOverlayStyle(statusBarColor: Colors.transparent));

    return      MaterialApp(
        theme: ThemeData(
            primaryColor: AppColors.MAIN_COLOR,
            cursorColor: AppColors.MAIN_COLOR),
        debugShowCheckedModeBanner: false,

        home: Scaffold(
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/background_ii.png"),
              fit: BoxFit.fill,
            ),
          ),
          child: SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              Container(
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.width / 6,
                  left: MediaQuery.of(context).size.width * 0.04,
                ),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: (MediaQuery.of(context).size.width * 0.04) +
                          FontSize.HEADING_FONT -
                          3,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "   BACK",
                        style: TextStyle(
                            color: Colors.white,
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
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width / 4,
                margin: EdgeInsets.only(
                  right: MediaQuery.of(context).size.width * 0.05,
                  left: MediaQuery.of(context).size.width * 0.05,
                  top: MediaQuery.of(context).size.height * 0.07,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 5,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Rides :",
                      style: TextStyle(
                        color: AppColors.LIGHT_GREY,
                        fontFamily: FontFamilies.POPPINS,
                        fontSize:
                            (MediaQuery.of(context).size.height * 0.02) + 3,
                      ),
                    ),
                    Text(
                      data.data.rides.toString(),
                      style: TextStyle(
                        color: AppColors.TITLE_TEXT_COLOR,
                        fontFamily: FontFamilies.POPPINS,
                        fontSize:
                            (MediaQuery.of(context).size.height * 0.02) + 5,
                      ),
                    ),
                    SizedBox(
                      height: 40,
                      child: VerticalDivider(
                        thickness: 0.6,
                        color: AppColors.LIGHT_GREY,
                      ),
                    ),
                    Text(
                      "Online Time :",
                      style: TextStyle(
                        color: AppColors.LIGHT_GREY,
                        fontFamily: FontFamilies.POPPINS,
                        fontSize:
                            (MediaQuery.of(context).size.height * 0.02) + 3,
                      ),
                    ),
                    Text(
                      data.data.hours.toString(),
                      style: TextStyle(
                        color: AppColors.TITLE_TEXT_COLOR,
                        fontFamily: FontFamilies.POPPINS,
                        fontSize:
                            (MediaQuery.of(context).size.height * 0.02) + 5,
                      ),
                    ),
                  ],
                ),
              ),
              buildListView(),
              // Container(
              //   margin: EdgeInsets.only(
              //       right: MediaQuery.of(context).size.width * 0.05,
              //       left: MediaQuery.of(context).size.width * 0.05,
              //       top: 15,
              //       bottom: 6),
              //   width: MediaQuery.of(context).size.width,
              //   height: MediaQuery.of(context).size.width / 7,
              //   child: ButtonTheme(
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(5),
              //     ),
              //     buttonColor: AppColors.MAIN_COLOR,
              //     child: RaisedButton(
              //       onPressed: () {
              //         //
              //         // Navigator.push(
              //         //   context,
              //         //   MaterialPageRoute(builder: (context) {
              //         //     return SignInScreen();
              //         //   }),
              //         // );
              //       },
              //       child: Text(
              //         "Report a Problem",
              //         style: TextStyle(
              //             fontFamily: FontFamilies.POPPINS,
              //             fontSize:
              //                 (MediaQuery.of(context).size.width * 0.008) + 13,
              //             color: Colors.white,
              //             fontWeight: FontWeight.w700),
              //       ),
              //     ),
              //   ),
              // ),
            ]),
          )),
    ));
  }

  buildListView() {
    return StreamBuilder(
      stream: weeklyReportBloc.weeklyReportDetails,
      builder: (BuildContext context,
          AsyncSnapshot<WeeklyReportDetailsModel> snapshot) {
        return Container(
            margin: EdgeInsets.only(
                right: MediaQuery.of(context).size.width * 0.05,
                left: MediaQuery.of(context).size.width * 0.05,
                top: 5,
                bottom: 6),
            child: ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemBuilder: (context, position) {
                return buildColumn(context, snapshot.data, position,
                    "card" + position.toString());
              },
              itemCount: snapshot.data.data.items.length,
            ));
      },
    );
  }

  Column buildColumn(BuildContext context, WeeklyReportDetailsModel model,
      int index, String name) {
    final GlobalKey<ExpansionTileCardState> name = new GlobalKey();

    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: index == 0 ? 0 : 6, bottom: 6),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              model.data.items[index].prefixOperator,
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(color: AppColors.LIGHT_BLUE, width: 1.0))),
          child: ExpansionTileCard(
            baseColor: Colors.white,
            key: name,
    trailing:Icon(Icons.arrow_drop_down,color: AppColors.MAIN_COLOR,),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  model.data.items[index].label,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
                Text(
                  model.data.items[index].total.toString() +
                      model.data.items[index].unit,
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              ],
            ),
            children: <Widget>[
              Divider(
                thickness: 1.0,
                height: 1.0,
              ),
              ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemBuilder: (context, position) {
                  return details(context, index, model, position);
                },
                itemCount: model.data.items[index].details.length,
              )
            ],
          ),
        ),
      ],
    );
  }

  details(context, int index, WeeklyReportDetailsModel model, int position) {
    return Container(
        margin: EdgeInsets.only(
            right: MediaQuery.of(context).size.width * 0.05,
            left: MediaQuery.of(context).size.width * 0.05,
            top: 6,
            bottom: 6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(model.data.items[index].details[position].label),
            Text(model.data.items[index].details[position].total.toString() +
                " " +
                model.data.items[index].details[position].unit),
          ],
        ));
  }
}
