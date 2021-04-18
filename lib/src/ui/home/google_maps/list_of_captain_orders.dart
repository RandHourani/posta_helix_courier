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

  ListView orderList(OrderModel orders) {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: orders.data.data.length,
      itemBuilder: (BuildContext context, int index) {
        return orders.data.data[index].waiting
            ? waitingContainer(context, orders.data.data[index], index)
            : orderContainer(context, orders.data.data[index], index);
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
        // orderBloc.setPolyLine();
      },
      child: Container(
          width: MediaQuery.of(context).size.width / 2.2,
          margin: EdgeInsets.only(left: 10, right: 10, bottom: 20),
          decoration: new BoxDecoration(
            color: Colors.white,
            borderRadius: new BorderRadius.all(
              Radius.circular(15.0),
            ),
          ),
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.only(top: 10, left: 5, right: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SvgPicture.asset("assets/images/order_card_icon.svg"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 2, left: 7),
                          child: Text(
                            orders.passenger.firstName +
                                " " +
                                orders.passenger.lastName,
                            style: TextStyle(
                                color: AppColors.COMPLETED_INFO_TEXT,
                                fontFamily: FontFamilies.POPPINS,
                                fontSize: 10,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "#" + orders.orderId.toString(),
                          style: TextStyle(
                              color: AppColors.MAIN_COLOR,
                              fontFamily: FontFamilies.POPPINS,
                              fontSize: 10,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Text(orders.status,
                        style: TextStyle(
                          color: AppColors.COMPLETED_INFO_TEXT,
                          fontFamily: FontFamilies.POPPINS,
                          fontSize: 10,
                        )),
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
            /*        image: DecorationImage(
              image: AssetImage("assets/images/waiting_bac.png"),
              fit: BoxFit.fill,
            ),*/
          ),
          child: Stack(
            children: [
              Container(
                padding:
                EdgeInsets.only(top: 10, bottom: 22, left: 5, right: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SvgPicture.asset(
                      "assets/images/car.svg",
                      width: 30,
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 2, left: 7),
                          child: Text(
                            orders.passenger.firstName +
                                " " +
                                orders.passenger.lastName,
                            style: TextStyle(
                                color: AppColors.COMPLETED_INFO_TEXT,
                                fontFamily: FontFamilies.POPPINS,
                                fontSize: 10,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "#" + orders.orderId.toString(),
                          style: TextStyle(
                              color: AppColors.MAIN_COLOR,
                              fontFamily: FontFamilies.POPPINS,
                              fontSize: 10,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Text(orders.status,
                        style: TextStyle(
                          color: AppColors.COMPLETED_INFO_TEXT,
                          fontFamily: FontFamilies.POPPINS,
                          fontSize: 10,
                        )),
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
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 20,
                  padding: EdgeInsets.only(top: 2),
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  decoration: BoxDecoration(
                    color: CardColors.color1,
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                    ),
                  ),
                  child: Text(
                    "waiting",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: FontFamilies.POPPINS,
                        fontSize: 10),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
