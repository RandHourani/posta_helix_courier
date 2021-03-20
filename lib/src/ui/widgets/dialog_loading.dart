import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'file:///C:/Users/r.horani/AndroidStudioProjects/helix_courier_project/helix_courier_project/lib/src/constants/application_colors_value.dart';

class LoadingDialogWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: MediaQuery.of(context).size.width/3, right:  MediaQuery.of(context).size.width/3),
      child: AlertDialog(
        contentPadding: EdgeInsets.only(left: 5,right: 5,),
        insetPadding: EdgeInsets.all(0),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0))),
        content: Container(
          alignment: Alignment.center,
            height:  MediaQuery.of(context).size.width/3.2,
            width:  MediaQuery.of(context).size.width/3.1,
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                Align(
                  alignment: Alignment.center,

                  child:Padding(padding: EdgeInsets.only(bottom: 7),
                    child: Text("Please wait"),

                  )
                ),

                SpinKitCircle(
                  color: AppColors.MAIN_COLOR,
                  // duration: Duration(seconds: 7),
                ),
              ],
            )),
      ),
    );
  }
}
