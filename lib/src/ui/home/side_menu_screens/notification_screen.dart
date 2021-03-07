import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:posta_courier/src/blocs/home_blocs/weekly_report_bloc.dart';
import 'package:posta_courier/src/constants/application_colors_value.dart';
import 'package:posta_courier/src/ui/home/side_menu_screens/weekly_details.dart';
import 'package:posta_courier/src/constants/fonts_size.dart';
import 'package:posta_courier/src/utils/util.dart';
import 'package:posta_courier/models/weekly_report.dart';

class NotificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

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
                        "   NOTIFICATIONS",
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

        ]),

      ),
    );
  }

}
