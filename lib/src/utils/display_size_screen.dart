import 'package:flutter/cupertino.dart';

class DisplayScreen {
  static double displayWidth(BuildContext context) {
    return displaySize(context).width;
  }

  static Size displaySize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  static double displayHeight(BuildContext context) {
    return displaySize(context).height;
  }
}
