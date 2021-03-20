
import 'package:flutter/material.dart';
import 'package:posta_courier/src/blocs/home_blocs/approved_captain_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:async';
class RefreshButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RotateImage();
  }
}
class RotateImage extends StatefulWidget {
  @override
  RotateImageState createState() => new RotateImageState();
}
class RotateImageState extends State
    with SingleTickerProviderStateMixin {

  AnimationController animationController;

  @override
  void initState() {
    super.initState();

    animationController = new AnimationController(
      value: this,
      duration: new Duration(seconds: 5),
    );

    animationController.repeat();
  }

  stopRotation(){

    animationController.stop();
  }

  startRotation(){

    animationController.repeat();
  }


  @override
  Widget build(BuildContext context) {
    stopRotation();
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
              color: Colors.white,
              alignment: Alignment.center,
              child:AnimatedBuilder(
                animation: animationController,
                child: Container(
                    height: 40.0,
                    width: 40.0,
                    child: Padding(
                        padding: EdgeInsets.only(right: 20.0),
                        child: InkWell(
                          onTap: () {

                            startRotation();
                            const oneSec = const Duration(seconds: 3);
                            new Timer.periodic(oneSec, (Timer t) {
                              stopRotation();
                            });
                          },
                          child: SvgPicture.asset(
                            "assets/images/refresh.svg",
                            width: 22,
                            height: 22,
                          ),
                        ))
                ),
                builder: (BuildContext context, Widget _widget) {
                  return Transform.rotate(
                    angle: animationController.value * 6.3,
                    child: _widget,
                  );
                },
              )),



        ]);
  }
}