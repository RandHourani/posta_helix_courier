import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:posta_courier/models/order_model.dart';
import 'package:posta_courier/src/blocs/home_blocs/order_bloc.dart';
import 'package:posta_courier/src/constants/application_colors_value.dart';
import 'package:posta_courier/src/constants/fonts_size.dart';
import 'package:posta_courier/src/constants/card_colors.dart';
import 'package:posta_courier/src/ui/widgets/dialog_loading.dart';

class CaptainOrders extends StatelessWidget {
  OrderModel orders;

  CaptainOrders({this.orders});

  ScrollController _controller;

  @override
  Widget build(BuildContext context) {
    _controller = ScrollController();
    _controller.addListener(_scrollListener);

    return ListView(
      controller: _controller, //new line
      shrinkWrap: true,

      scrollDirection: Axis.horizontal,
      children: [
        orderList(orders),
      ],
    );
  }

  ListView orderList( OrderModel orders) {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: orders.data.data.length,
      itemBuilder: (BuildContext context, int index) {
        return orderContainer(context, orders.data.data[index], index);
      },
    );
  }

  ListView waitingList() {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: orders.data.data.length,
      itemBuilder: (BuildContext context, int index) {
        return waitingContainer(context, orders.data.data[index], index);
      },
    );
  }

  _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {}
    if (_controller.offset <= _controller.position.minScrollExtent &&
        !_controller.position.outOfRange) {}
  }

  Widget orderContainer(BuildContext context, OrderDetails orders, int index) {
    return InkWell(
      onTap: () {
        orderBloc.getRide(orders);
        orderBloc.setOrderIndex(index);
        orderBloc.setPolyLine();
      },
      child: Container(
          width: MediaQuery.of(context).size.width / 2.2,
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
                padding:
                    EdgeInsets.only(top: 10, bottom: 10, left: 5, right: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SvgPicture.asset("assets/images/order_card_icon.svg"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          orders.passenger.firstName +
                              " " +
                              orders.passenger.lastName,
                          style: TextStyle(
                              color: AppColors.TITLE_TEXT_COLOR,
                              fontFamily: FontFamilies.POPPINS,
                              fontSize: 12),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "#" + orders.orderId.toString(),
                          style: TextStyle(
                              color: AppColors.MAIN_COLOR,
                              fontFamily: FontFamilies.POPPINS,
                              fontSize: 12),
                        ),
                      ],
                    ),
                    Text(orders.status,
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
                right: 5.0,
                top: 5.0,
                child: SvgPicture.asset(
                  "assets/images/information.svg",
                  width: 15,
                  height: 15,
                ),
              ),
            ],
          )),
    );
  }

  Widget waitingContainer(
      BuildContext context, OrderDetails orders, int index) {
    return InkWell(
      onTap: () {},
      child: Container(
          width: MediaQuery.of(context).size.width / 2.2,
          margin: EdgeInsets.only(left: 10, right: 10),
          decoration: new BoxDecoration(
            color: Colors.white,
            borderRadius: new BorderRadius.all(
              Radius.circular(15.0),
            ),
            border: Border.all(color: CardColors.color1),
            image: DecorationImage(
              image: AssetImage("assets/images/waiting.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              Container(
                padding:
                    EdgeInsets.only(top: 10, bottom: 10, left: 5, right: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SvgPicture.asset("assets/images/order_card_icon.svg"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          orders.passenger.firstName +
                              " " +
                              orders.passenger.lastName,
                          style: TextStyle(
                              color: AppColors.TITLE_TEXT_COLOR,
                              fontFamily: FontFamilies.POPPINS,
                              fontSize: 12),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "#" + orders.orderId.toString(),
                          style: TextStyle(
                              color: AppColors.MAIN_COLOR,
                              fontFamily: FontFamilies.POPPINS,
                              fontSize: 12),
                        ),
                      ],
                    ),
                    Text(orders.status,
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
                right: 5.0,
                top: 5.0,
                child: SvgPicture.asset(
                  "assets/images/information.svg",
                  width: 15,
                  height: 15,
                ),
              ),
            ],
          )),
    );
  }



}
