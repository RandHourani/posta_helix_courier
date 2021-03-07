import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:posta_courier/src/constants/application_colors_value.dart';
import 'package:posta_courier/src/constants/fonts_size.dart';

class FindingOrdersSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  SizedBox.expand(
        child: DraggableScrollableSheet(
          maxChildSize:0.25,
          minChildSize: 0.07,
          initialChildSize: 0.25,
          builder: (BuildContext context, ScrollController scrollController) {
            return Container(
              margin: EdgeInsets.only(right: 27,left: 27),
              decoration: new BoxDecoration(
                color: Colors.white,
                borderRadius: new BorderRadius.only(
                  topLeft: const Radius.circular(15.0),
                  topRight: const Radius.circular(15.0),
                ),

              ),
              child:container(context),
            );
          },
        ),

    );
  }

  container(context)
  {
    return Column(

      children: [

        Padding(
          padding: EdgeInsets.only(top: 30),
          child: Text("Finding Orders",style: TextStyle(
            fontWeight: FontWeight.w700,
            color: AppColors.TITLE_TEXT_COLOR,
            fontFamily: FontFamilies.POPPINS,
            fontSize:
            (MediaQuery.of(context).size.height * 0.018) + 7,
          ),),
        ),     Padding(
          padding: EdgeInsets.only(top: 15),
          child: Text("Opportunity Nearby",style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.MAIN_COLOR,
            fontFamily: FontFamilies.POPPINS,
            fontSize:
            (MediaQuery.of(context).size.height * 0.018) + 7,
          ),),
        ),     Padding(
          padding: EdgeInsets.only(top: 3,bottom: 5),
          child: Text("More request than usual",style: TextStyle(
            fontWeight: FontWeight.w500,
            color: AppColors.LIGHT_GREY,
            fontFamily: FontFamilies.POPPINS,
            fontSize:
            (MediaQuery.of(context).size.height * 0.018) + 3,
          ),),
        ),


      ],
    );
  }
}