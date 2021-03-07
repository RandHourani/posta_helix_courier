import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:posta_courier/src/blocs/home_blocs/unsuccessful_order_bloc.dart';
import 'package:posta_courier/src/ui/home/payment/payment_without_cod_screen.dart';


class PaymentWithoutCODSheet extends StatelessWidget {
  String shipmentCase;

  PaymentWithoutCODSheet({this.shipmentCase});
  static const LatLng _center = const LatLng(31.949722, 35.932778);

@override
  Widget build(BuildContext context) {

  return SizedBox.expand(
    child: DraggableScrollableSheet(
      maxChildSize:1 ,
      minChildSize:1,
      initialChildSize:
      1,
      builder: (BuildContext context, ScrollController scrollController) {
        return PaymentWithoutCODScreen(shipmentCase: shipmentCase,);
      },
    ),
  );

  }

}
