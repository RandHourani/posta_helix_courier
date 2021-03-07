import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ErrorDialogWidget extends StatelessWidget {
  final String text;

  ErrorDialogWidget({this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(30),
      child:  AlertDialog(
        contentPadding: EdgeInsets.all(10),
        insetPadding: EdgeInsets.all(0),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0))),
        content: Container(
            height: 200,
            width: 170,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset("assets/images/mark.png"),
                SizedBox(
                  height: 30,
                ),
                Align(
                    alignment: Alignment.center,
                    child: Text(
                      text,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w200),
                    )),
              ],
            )),
      ),
    );
  
  }
}
