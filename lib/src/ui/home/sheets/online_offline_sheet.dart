import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:posta_courier/models/ride_model.dart';
import 'package:posta_courier/src/blocs/home_blocs/approved_captain_bloc.dart';
import 'package:posta_courier/src/blocs/home_blocs/online_offline_bloc.dart';
import 'package:posta_courier/src/blocs/home_blocs/google_map_bloc.dart';
import 'package:posta_courier/src/constants/application_colors_value.dart';
import 'package:posta_courier/src/constants/fonts_size.dart';
import 'package:posta_courier/src/blocs/home_blocs/order_bloc.dart';
import 'package:posta_courier/src/ui/widgets/unsuccessful_dialog_screen.dart';
import 'package:posta_courier/src/utils/util.dart';
class OnlineOfflineSheet extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // orderBloc.getOrders("NOT_PAID");
    return SizedBox.expand(
        child: DraggableScrollableSheet(
          maxChildSize:0.27,
          minChildSize: 0.13,
          initialChildSize: 0.13,
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
              child:Theme(
              //Inherit the current Theme and override only the accentColor property
              data: Theme.of(context).copyWith(
            accentColor: Colors.white
            ),
              child: ListView.builder(
                controller: scrollController,
                itemCount:1,
                itemBuilder: (BuildContext context, int index) {
                  return container(context);
                },
              ),),
            );
          },
        ),
      )
   ;
  }

  container(context)
  {
    return Column(

      children: [


        Padding(
          padding: EdgeInsets.only(top: 30),
          child: Text("You'er Offline",style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.ERROR,
            fontFamily: FontFamilies.POPPINS,
            fontSize:
            (MediaQuery.of(context).size.height * 0.018) + 7,
          ),),
        ),
        Container(
          margin: EdgeInsets.only(top: 30, bottom: 25,right: 17,left: 17),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width / 7.2,
          decoration: BoxDecoration(
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black26,
                blurRadius: 5,
                offset: Offset(2, 2),
              ),
            ],
          ),
          child: ButtonTheme(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            buttonColor: AppColors.COMPLETED_INFO_TEXT,
            child: RaisedButton(
              onPressed: () {
                onlineOfflineBloc.setStatus(true);
                googleMapBloc.setZoomMap(17.0);
                approvedCaptainBloc.checkCaptainStatus();
                orderBloc.setOrderSheet("null");
              },
              child: Text(
                "Go Online ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: FontFamilies.POPPINS,
                  fontSize:
                  (MediaQuery.of(context).size.height * 0.018) + 5.5,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),

      ],
    );
  }
}