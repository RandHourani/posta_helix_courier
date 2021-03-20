import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:posta_courier/src/blocs/home_blocs/weekly_report_bloc.dart';
import 'package:posta_courier/src/constants/application_colors_value.dart';
import 'package:posta_courier/src/ui/home/side_menu_screens/weekly_details.dart';
import 'package:posta_courier/src/constants/fonts_size.dart';
import 'package:posta_courier/src/utils/util.dart';
import 'package:posta_courier/models/weekly_report.dart';
import 'package:posta_courier/src/ui/widgets/dialog_loading.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class WeeklyReportScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    weeklyReportBloc.getWeeklyReport();

    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background_ii.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
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
                        "   WEEKLY  REPORT",
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
            ],
          ), Expanded(
                 flex: 1,
                 child: buildListView(),
               )



        ]),
      ),
    );
  }

   walletCard(
      BuildContext context, WeeklyReportDetails weeklyReportDetails) {

    return InkWell(
      onTap: (){
        weeklyReportBloc.getWeeklyReportDetails(weeklyReportDetails.paymentId.toString());
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return WeeklyDetailsScreen(data:weeklyReportBloc.getDetails() ,);
          }),
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 120,
        margin: EdgeInsets.only(
            right: MediaQuery.of(context).size.width * 0.05,
            left: MediaQuery.of(context).size.width * 0.05,
            top: MediaQuery.of(context).size.width * 0.05,
            bottom: 5),
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(7),
              width: MediaQuery.of(context).size.width,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10), topLeft: Radius.circular(10)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("From",
                      style: TextStyle(
                          fontFamily: FontFamilies.POPPINS,
                          color: AppColors.labelColor)),
                  Text(
                      Utils.dateFormat4(weeklyReportDetails.startDate).toString(),
                      style: TextStyle(
                          fontFamily: FontFamilies.POPPINS,
                          color: AppColors.TITLE_TEXT_COLOR,
                          fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: 40,
                    child: VerticalDivider(
                      color: AppColors.LIGHT_GREY,
                    ),
                  ),
                  Text("To",
                      style: TextStyle(
                          fontFamily: FontFamilies.POPPINS,
                          color: AppColors.labelColor)),
                  Text(Utils.dateFormat4(weeklyReportDetails.endDate).toString(),
                      style: TextStyle(
                          fontFamily: FontFamilies.POPPINS,
                          color: AppColors.TITLE_TEXT_COLOR,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(right: 10, left: 7),
              width: MediaQuery.of(context).size.width,
              height: 60,
              decoration: BoxDecoration(
                color: Color(0xffF3F3F3),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("Cash",
                      style: TextStyle(
                          fontFamily: FontFamilies.POPPINS,
                          color: AppColors.labelColor)),
                  Row(
                    children: [
                      Text(
                        weeklyReportDetails.closing.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: AppColors.MAIN_COLOR,
                          fontFamily: FontFamilies.POPPINS,
                          fontSize:
                          (MediaQuery.of(context).size.height * 0.02) + 12,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Text(" JOD",
                            style: TextStyle(
                              fontFamily: FontFamilies.POPPINS,
                              color: AppColors.MAIN_COLOR,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 7,
                  ),
                  Text(weeklyReportDetails.status,
                      style: TextStyle(
                          fontFamily: FontFamilies.POPPINS,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  buildListView() {
    return StreamBuilder(
      stream: weeklyReportBloc.weeklyReport,
      builder: (BuildContext context, AsyncSnapshot<WeeklyReport> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemBuilder: (context, position) {
              return Column(
                children: <Widget>[
                  walletCard(context, snapshot.data.report.report[position]),
                ],
              );
            },
            itemCount: snapshot.data.report.report.length,
          );
        } else {
          return SpinKitCircle(
            color: AppColors.MAIN_COLOR,
          );
        }
      },
    );
  }
}
