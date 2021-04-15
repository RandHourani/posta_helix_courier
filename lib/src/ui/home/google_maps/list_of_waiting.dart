import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:posta_courier/src/constants/application_colors_value.dart';
import 'package:posta_courier/src/constants/fonts_size.dart';

class WaitingOrders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: [waitingContainer(context)],
    );
  }

  Widget waitingContainer(BuildContext context) {
    return Container(
        width: 170,
        margin: EdgeInsets.only(left: 10, right: 10),
        decoration: new BoxDecoration(
          color: Colors.white,
          borderRadius: new BorderRadius.all(
            Radius.circular(15.0),
          ),
        ),
        child: Stack(
          children: [
            Container(
              height: 120,
              width: 200,
              child: SvgPicture.asset(
                "assets/images/waiting.svg",
              ),
            ),
            Positioned(
                left: 0.0,
                top: 0.0,
                child: Stack(
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                          top: 10, bottom: 10, left: 5, right: 5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SvgPicture.asset("assets/images/order_card_icon.svg"),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Customer Name",
                                style: TextStyle(
                                    color: AppColors.TITLE_TEXT_COLOR,
                                    fontFamily: FontFamilies.POPPINS,
                                    fontSize: 12),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "#000",
                                style: TextStyle(
                                    color: AppColors.MAIN_COLOR,
                                    fontFamily: FontFamilies.POPPINS,
                                    fontSize: 12),
                              ),
                            ],
                          ),
                          Text("Going to receive packages",
                              style: TextStyle(
                                  color: AppColors.TITLE_TEXT_COLOR,
                                  fontFamily: FontFamilies.POPPINS,
                                  fontSize: 12)),
                        ],
                      ),
                    ),
                    Positioned(
                      width: 20,
                      height: 20,
                      right: 3.0,
                      top: 5.0,
                      child: SvgPicture.asset(
                        "assets/images/information.svg",
                        width: 20,
                        height: 20,
                      ),
                    ),
                  ],
                ))
          ],
        ));
  }
}
