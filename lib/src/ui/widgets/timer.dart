import 'package:flutter/material.dart';
import 'package:posta_courier/src/blocs/home_blocs/order_bloc.dart';
import 'package:posta_courier/src/blocs/signIn_and_createAccount_blocs/get_captain_data_bloc.dart';
import 'package:posta_courier/src/constants/application_colors_value.dart';

class TimerWidgetOrder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          // Define the default brightness and colors.
          accentColor: AppColors.MAIN_COLOR,
          // Define the default font family.

          // Define the default TextTheme. Use this to specify the default
          // text styling for headlines, titles, bodies of text, and more.
        ),
        home: HorizontalProgressIndicator());
  }
}

class HorizontalProgressIndicator extends StatefulWidget {
  @override
  HorizontalProgressIndicatorState createState() =>
      new HorizontalProgressIndicatorState();
}

class HorizontalProgressIndicatorState
    extends State<HorizontalProgressIndicator>
    with SingleTickerProviderStateMixin {
  AnimationController controller;

  Animation animation;

  double beginAnim = 1.0;

  double endAnim = 0.0;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 60), vsync: this);
    animation = Tween(begin: beginAnim, end: endAnim).animate(controller)
      ..addListener(() {
        setState(() {});
      });
    if (animation.isCompleted) {
      orderBloc.setOrderSheet("NULL");
      checkCaptainDataBloc.resetSuggestion();
    } else {}
  }

  @override
  void dispose() {
    controller.stop();
    super.dispose();
  }

  startProgress() {
    controller.forward();
  }

  stopProgress() {
    controller.stop();
  }

  resetProgress() {
    controller.reset();
  }

  @override
  Widget build(BuildContext context) {
    startProgress();
    return Center(
        child: Column(children: [
      Container(
          padding: EdgeInsets.only(left: 90.0, right: 90.0, top: 15),
          child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: LinearProgressIndicator(
                value: animation.value,
                backgroundColor: AppColors.LIGHT_GREY,
              ))),
    ]));
  }
}
