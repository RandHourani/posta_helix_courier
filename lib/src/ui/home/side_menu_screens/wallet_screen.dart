import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:posta_courier/models/wallet_model.dart';
import 'package:posta_courier/src/blocs/home_blocs/wallet_bloc.dart';
import 'package:posta_courier/src/constants/application_colors_value.dart';
import 'package:posta_courier/src/constants/card_colors.dart';
import 'package:posta_courier/src/constants/fonts_size.dart';
import 'package:posta_courier/src/ui/home/side_menu_screens/view_receipt_screen.dart';
import 'package:posta_courier/src/ui/widgets/dialog_loading.dart';
import 'package:posta_courier/src/utils/util.dart';

class WalletScreen extends StatelessWidget {
  List<String> list = List();

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(
    //     SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    list = ["Jordan-jo"];
    walletBloc.walletAccount();
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background_ii.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.width / 6,
                  left: MediaQuery.of(context).size.width * 0.04,
                ),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: (MediaQuery.of(context).size.width * 0.04) +
                          FontSize.HEADING_FONT -
                          3,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "   WALLET",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: FontFamilies.POPPINS,
                            fontSize:
                                (MediaQuery.of(context).size.width * 0.04) +
                                    FontSize.HEADING_FONT -
                                    7,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.width / 6,
                    right: MediaQuery.of(context).size.width * 0.04,
                  ),
                  child: StreamBuilder(
                    stream: walletBloc.country,
                    builder:
                        (BuildContext context, AsyncSnapshot<String> snapshot) {
                      if (snapshot.hasData) {
                        return Text(
                          snapshot.data,
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: FontFamilies.POPPINS,
                              fontSize:
                                  (MediaQuery.of(context).size.width * 0.04) +
                                      FontSize.HEADING_FONT -
                                      7,
                              fontWeight: FontWeight.bold),
                        );
                      } else {
                        return Text("");
                      }
                    },
                  ))
            ],
          ),
          StreamBuilder(
              stream: walletBloc.account,
              builder: (BuildContext context,
                  AsyncSnapshot<CaptainWallet> snapshot) {
                if (snapshot.hasData) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width / 3.1,
                    margin: EdgeInsets.only(
                        right: MediaQuery.of(context).size.width * 0.05,
                        left: MediaQuery.of(context).size.width * 0.05,
                        top: MediaQuery.of(context).size.height * 0.05,
                        bottom: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 5,
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: 'Your ',
                            style: TextStyle(
                              color: AppColors.TITLE_TEXT_COLOR,
                              fontFamily: FontFamilies.POPPINS,
                              fontSize:
                                  (MediaQuery.of(context).size.height * 0.02) +
                                      3,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                  text: 'Current Balance',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.TITLE_TEXT_COLOR,
                                    fontFamily: FontFamilies.POPPINS,
                                    fontSize:
                                        (MediaQuery.of(context).size.height *
                                                0.02) +
                                            3,
                                  )),
                            ],
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            text: '',
                            style: TextStyle(
                              fontFamily: FontFamilies.POPPINS,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: snapshot.data.data.first.balance,
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.MAIN_COLOR,
                                  fontFamily: FontFamilies.POPPINS,
                                  fontSize: (MediaQuery.of(context)
                                      .size
                                      .height *
                                      0.02) +
                                      23,
                                ),
                              ),
                              TextSpan(
                                  text: snapshot.data.data.first.country
                                      .currency.currencyCode,
                                  style: TextStyle(
                                    color: AppColors.TITLE_TEXT_COLOR,
                                    fontFamily: FontFamilies.POPPINS,
                                    fontSize: (MediaQuery.of(context)
                                        .size
                                        .height *
                                        0.02) +
                                        7,
                                  )),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                } else {
                  return Container();
                }
              }),
          Expanded(
            child: StreamBuilder(
              stream: walletBloc.walletData,
              builder:
                  (BuildContext context, AsyncSnapshot<WalletModel> snapshot) {
                if (snapshot.hasData) {
                  return buildListView(snapshot.data);
                } else {
                  return LoadingDialogWidget();
                }
              },
            ),
          ),
        ]),
      ),
    );
  }

  walletCard(int position, BuildContext context, WalletModel data) {
    var cardColor;
    if (position < 14) {
      cardColor = CardColors.colorArr[position];
    } else {
      cardColor = CardColors.colorArr[position % 15];
    }

    return data.wallet.data[position].transactionList.length > 1
        ? Container(
            margin: position == 0
                ? EdgeInsets.only(
                    right: MediaQuery.of(context).size.width * 0.04,
                    left: MediaQuery.of(context).size.width * 0.04,
                    bottom: MediaQuery.of(context).size.width * 0.04)
                : EdgeInsets.only(
                    right: MediaQuery.of(context).size.width * 0.04,
                    left: MediaQuery.of(context).size.width * 0.04,
                    bottom: MediaQuery.of(context).size.width * 0.04,
                    top: 5),
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.width * 0.04,
                top: 5,
                right: MediaQuery.of(context).size.width * 0.03,
                left: MediaQuery.of(context).size.width * 0.03),
            // height: 100,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(1.0, 1.0), //(x,y)
                  blurRadius: 3.0,
                ),
              ],
              color: Colors.white,
            ),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.03),
                            child: Text(
                              "Last Balance:  ",
                              style: TextStyle(
                                  fontFamily: FontFamilies.POPPINS,
                                  fontSize:
                                      (MediaQuery.of(context).size.height *
                                          0.015)),
                            ),
                          ),
                          Text(
                            data.wallet.data[position].lastBalance.toString(),
                            style: TextStyle(
                                fontFamily: FontFamilies.POPPINS,
                                fontSize: (MediaQuery.of(context).size.height *
                                        0.015) +
                                    5,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            " JOD",
                            style: TextStyle(
                                fontFamily: FontFamilies.POPPINS,
                                fontSize: (MediaQuery.of(context).size.height *
                                        0.015) +
                                    5,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        right: (MediaQuery.of(context).size.height * 0.015),
                        top: (MediaQuery.of(context).size.height * 0.008),
                        bottom: (MediaQuery.of(context).size.height * 0.008),
                      ),
                      width: 75,
                      height: 27,
                      child: RaisedButton(
                        padding: EdgeInsets.all(0),
                        color: AppColors.GREY_BUTTON,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return ViewReceipt(
                                wallet: data.wallet.data[position],
                                currancy: walletBloc.currancy().toString(),
                              );
                            }),
                          );
                        },
                        child: Text(
                          " View Receipt",
                          style: TextStyle(
                            color: AppColors.TEXT_BUTTON,
                            fontFamily: FontFamilies.POPPINS,
                            fontSize:
                                MediaQuery.of(context).size.height * 0.013,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(
                  color: AppColors.LIGHT_GREY,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.03,
                              right: MediaQuery.of(context).size.width * 0.01),
                          padding: EdgeInsets.all(7),
                          decoration: BoxDecoration(
                              color: cardColor, shape: BoxShape.circle),
                          child: Text(
                            (position + 1).toString(),
                            style: TextStyle(
                                fontFamily: FontFamilies.POPPINS,
                                fontSize: (MediaQuery.of(context).size.height *
                                    0.015),
                                color: Colors.white),
                          ),
                        ),
                        Text(
                          "Transactions",
                          style: TextStyle(
                              fontFamily: FontFamilies.POPPINS,
                              fontSize:
                                  (MediaQuery.of(context).size.height * 0.015)),
                        ),
                      ],
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              Utils.dateTimeFormat6(
                              data.wallet.data[position].dateTime.toString()),
                              style: TextStyle(
                                  fontFamily: FontFamilies.POPPINS,
                                  fontSize:
                                      (MediaQuery.of(context).size.height *
                                          0.015)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 7),
                  child: Row(
                    children: <Widget>[
                      Container(
                          width: 30,
                          height: 30,
                          margin: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.03,
                              right: MediaQuery.of(context).size.width * 0.01),
                          padding: EdgeInsets.all(6.7),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: CardColors.cashCostColor,
                          ),
                          child: SizedBox(
                            width: 3,
                            height: 3,
                            child: SvgPicture.asset(
                              "assets/images/cash_icon.svg",
                            ),
                          )),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                data.wallet.data[position].transactionList[1]
                                    .type,
                                style: TextStyle(
                                    fontFamily: FontFamilies.POPPINS,
                                    fontSize:
                                        (MediaQuery.of(context).size.height *
                                                0.015) +
                                            5),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                data.wallet.data[position].transactionList[1]
                                    .details,
                                style: TextStyle(
                                    fontFamily: FontFamilies.POPPINS,
                                    fontSize:
                                        (MediaQuery.of(context).size.height *
                                            0.013)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(right: 7),
                          child: Text(
                            "+" +
                                data.wallet.data[position].transactionList[1]
                                    .amount,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: CardColors.cashIconColor,
                                fontFamily: FontFamilies.POPPINS,
                                fontSize: (MediaQuery.of(context).size.height *
                                        0.015) +
                                    3),
                          )),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Row(
                    children: <Widget>[
                      Container(
                          width: 30,
                          height: 30,
                          margin: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.03,
                              right: MediaQuery.of(context).size.width * 0.01),
                          padding: EdgeInsets.all(6.7),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: CardColors.orderCostColor,
                          ),
                          child: SizedBox(
                            // width: 5,
                            // height: 5,
                            child: SvgPicture.asset(
                              "assets/images/order_icon.svg",
                              width: 5,
                              height: 5,
                            ),
                          )),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                data.wallet.data[position].transactionList[0]
                                    .type,
                                style: TextStyle(
                                    fontFamily: FontFamilies.POPPINS,
                                    fontSize:
                                        (MediaQuery.of(context).size.height *
                                                0.015) +
                                            3),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                data.wallet.data[position].transactionList[0]
                                    .details,
                                style: TextStyle(
                                    fontFamily: FontFamilies.POPPINS,
                                    fontSize:
                                        (MediaQuery.of(context).size.height *
                                            0.013)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(right: 7),
                          child: Text(
                            data.wallet.data[position].transactionList[0]
                                .amount,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.ERROR,
                                fontFamily: FontFamilies.POPPINS,
                                fontSize: (MediaQuery.of(context).size.height *
                                        0.015) +
                                    3),
                          )),
                    ],
                  ),
                ),
              ],
            ),
          )
        : Container(
            margin: position == 0
                ? EdgeInsets.only(
                    right: MediaQuery.of(context).size.width * 0.04,
                    left: MediaQuery.of(context).size.width * 0.04,
                    bottom: MediaQuery.of(context).size.width * 0.04)
                : EdgeInsets.only(
                    right: MediaQuery.of(context).size.width * 0.04,
                    left: MediaQuery.of(context).size.width * 0.04,
                    bottom: MediaQuery.of(context).size.width * 0.04,
                    top: 5),
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.width * 0.04,
                top: 5,
                right: MediaQuery.of(context).size.width * 0.03,
                left: MediaQuery.of(context).size.width * 0.03),
            // height: 100,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(1.0, 1.0), //(x,y)
                  blurRadius: 3.0,
                ),
              ],
              color: Colors.white,
            ),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.03),
                            child: Text(
                              "Last Balance:  ",
                              style: TextStyle(
                                  fontFamily: FontFamilies.POPPINS,
                                  fontSize:
                                      (MediaQuery.of(context).size.height *
                                          0.015)),
                            ),
                          ),
                          Text(
                            data.wallet.data[position].lastBalance.toString(),
                            style: TextStyle(
                                fontFamily: FontFamilies.POPPINS,
                                fontSize: (MediaQuery.of(context).size.height *
                                        0.015) +
                                    5,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            " JOD",
                            style: TextStyle(
                                fontFamily: FontFamilies.POPPINS,
                                fontSize: (MediaQuery.of(context).size.height *
                                        0.015) +
                                    5,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        right: (MediaQuery.of(context).size.height * 0.015),
                        top: (MediaQuery.of(context).size.height * 0.008),
                        bottom: (MediaQuery.of(context).size.height * 0.008),
                      ),
                      width: 75,
                      height: 27,
                      child: RaisedButton(
                        padding: EdgeInsets.all(0),
                        color: AppColors.GREY_BUTTON,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return ViewReceipt(
                                wallet: data.wallet.data[position],
                                currancy: walletBloc.currancy().toString(),
                              );
                            }),
                          );
                        },
                        child: Text(
                          " View Receipt",
                          style: TextStyle(
                            color: AppColors.TEXT_BUTTON,
                            fontFamily: FontFamilies.POPPINS,
                            fontSize:
                                MediaQuery.of(context).size.height * 0.013,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(
                  color: AppColors.LIGHT_GREY,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.03,
                              right: MediaQuery.of(context).size.width * 0.01),
                          padding: EdgeInsets.all(7),
                          decoration: BoxDecoration(
                              color: cardColor, shape: BoxShape.circle),
                          child: Text(
                            (position + 1).toString(),
                            style: TextStyle(
                                fontFamily: FontFamilies.POPPINS,
                                fontSize: (MediaQuery.of(context).size.height *
                                    0.015),
                                color: Colors.white),
                          ),
                        ),
                        Text(
                          "Transactions",
                          style: TextStyle(
                              fontFamily: FontFamilies.POPPINS,
                              fontSize:
                                  (MediaQuery.of(context).size.height * 0.015)),
                        ),
                      ],
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              data.wallet.data[position].dateTime.toString(),
                              style: TextStyle(
                                  fontFamily: FontFamilies.POPPINS,
                                  fontSize:
                                      (MediaQuery.of(context).size.height *
                                          0.015)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Row(
                    children: <Widget>[
                      Container(
                          width: 30,
                          height: 30,
                          margin: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.03,
                              right: MediaQuery.of(context).size.width * 0.01),
                          padding: EdgeInsets.all(6.7),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: CardColors.orderCostColor,
                          ),
                          child: SizedBox(
                            // width: 5,
                            // height: 5,
                            child: SvgPicture.asset(
                              "assets/images/order_icon.svg",
                              width: 5,
                              height: 5,
                            ),
                          )),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                data.wallet.data[position].transactionList[0]
                                    .type,
                                style: TextStyle(
                                    fontFamily: FontFamilies.POPPINS,
                                    fontSize:
                                        (MediaQuery.of(context).size.height *
                                                0.015) +
                                            3),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                data.wallet.data[position].transactionList[0]
                                    .details,
                                style: TextStyle(
                                    fontFamily: FontFamilies.POPPINS,
                                    fontSize:
                                        (MediaQuery.of(context).size.height *
                                            0.013)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(right: 7),
                          child: Text(
                            data.wallet.data[position].transactionList[0]
                                .amount,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.ERROR,
                                fontFamily: FontFamilies.POPPINS,
                                fontSize: (MediaQuery.of(context).size.height *
                                        0.015) +
                                    3),
                          )),
                    ],
                  ),
                ),
              ],
            ),
          );
  }

  ListView buildListView(WalletModel data) {
    return ListView.builder(
      itemBuilder: (context, position) {
        return Column(
          children: <Widget>[
            walletCard(position, context, data),
          ],
        );
      },
      itemCount: data.wallet.data.length,
    );
  }
}
