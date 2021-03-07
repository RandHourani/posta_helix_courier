import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:posta_courier/src/constants/application_colors_value.dart';
import 'package:posta_courier/src/constants/fonts_size.dart';
import 'package:posta_courier/src/blocs/home_blocs/online_offline_bloc.dart';

class GoingOfflineErrorDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.only(left: 15, top: 15, right: 15, bottom: 5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      //this right here
      content: Container(
        height: 130.0,
        width: 260.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 15),
              child: Align(
                alignment: Alignment.center,
                child: SvgPicture.asset(
                  "assets/images/error.svg",
                  width: 50,
                  height: 50,
                ),
              ),
            ),
            Container(
              child: Text(
                "You need to finish current \norder before you go offline",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: AppColors.TITLE_TEXT_COLOR,
                  fontFamily: FontFamilies.POPPINS,
                  fontSize: (MediaQuery.of(context).size.height * 0.018) + 4,
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        InkWell(
          onTap: (){
            Navigator.pop(context);
            onlineOfflineBloc.setColor(true);

          },
            child: Padding(
          padding: EdgeInsets.only(right: 17),
          child: Text(
            "Ok",
            textAlign: TextAlign.left,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: AppColors.TITLE_TEXT_COLOR,
              fontFamily: FontFamilies.POPPINS,
              fontSize: (MediaQuery.of(context).size.height * 0.018) + 2,
            ),
          ),
        ))
      ],
    );
  }
}
