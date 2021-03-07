
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:posta_courier/models/unsuccessful_order_model.dart';
import 'package:posta_courier/src/blocs/home_blocs/unsuccessful_order_bloc.dart';
import 'package:posta_courier/src/constants/application_colors_value.dart';
import 'package:posta_courier/src/constants/fonts_size.dart';


class UnsuccessfulScreen extends StatelessWidget {
  final String type;
  final orderId;

  UnsuccessfulScreen({this.type,this.orderId});

  @override
  Widget build(BuildContext context) {
    unsuccessfulOrderBloc.unsuccessfulReasons(type);
    return AlertDialog(
      contentPadding: EdgeInsets.only(left: 17,top: 0,right: 17,bottom: 5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      //this right here
      content: Container(
        height: 235.0,
        width: 250.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only( bottom: 10),
              child: Text(
                "Please Select Reason Why \n Canceling The Order!",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: AppColors.TITLE_TEXT_COLOR,
                  fontFamily: FontFamilies.POPPINS,
                  fontSize: (MediaQuery.of(context).size.height * 0.018) + 3,
                ),
              ),
            ),
            Divider(
              thickness: 0.7,
              color: AppColors.LIGHT_GREY,
            ),
            Container(
                margin: EdgeInsets.only(left: 17, right: 17, top: 5, bottom: 10),
                height: 50,

                child: StreamBuilder(
                  stream: unsuccessfulOrderBloc.reasons,
                  builder: (context,
                      AsyncSnapshot<UnsuccessfulOrderModel> snap) {
                    if (snap.hasData) {
                      return StreamBuilder(
                        stream: unsuccessfulOrderBloc.selectedReasons,
                        builder: (context, snapshot) {
                          return DropdownButtonHideUnderline(
                            child: new DropdownButton<String>(
                              isExpanded: true,
                              value: snapshot.data,
                              items: snap.data.data.data
                                  .map((Reason value) {
                                return new DropdownMenuItem<
                                    String>(
                                  value: value.reason,
                                  child:
                                  new Text(value.reason),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                               unsuccessfulOrderBloc.setSelectedReason(newValue);
                              },
                            ),
                          );
                        },
                      );
                    } else {
                      return Text("");
                    }
                  },
                ),),
            Padding(
              padding: EdgeInsets.only(top: 0),
              child:  Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 50,
                    width: 100,
                    margin: EdgeInsets.only(right: 10),
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      elevation: 3,
                      color: Colors.white,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                            fontFamily: FontFamilies.POPPINS,
                            fontSize:
                            (MediaQuery.of(context).size.width * 0.008) + 8,
                            color: Colors.black,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  Container(
                    height: 50,
                    width: 120,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      elevation: 3,
                      color: AppColors.MAIN_COLOR,
                      onPressed: () {
                        Navigator.of(context).pop();
                        unsuccessfulOrderBloc.setUnsuccessfulOrder(orderId);
                      },
                      child:
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.02),
                        child: Text(
                          "Submit",
                          style: TextStyle(
                              fontFamily: FontFamilies.POPPINS,
                              fontSize:
                              (MediaQuery.of(context).size.width * 0.008) +
                                  8,
                              color: Colors.white,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
