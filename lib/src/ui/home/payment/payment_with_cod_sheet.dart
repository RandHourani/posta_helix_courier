import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:posta_courier/src/blocs/home_blocs/order_bloc.dart';
import 'package:posta_courier/src/ui/home/payment/payment_with_cod_screen.dart';
import 'package:posta_courier/models/booking_action_model.dart';

class PaymentWithCODSheet extends StatelessWidget {
  String shipmentCase;
  PaymentWithCODSheet({this.shipmentCase});
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
        return StreamBuilder(
          stream: orderBloc.bookingPrice,
          builder: (BuildContext context,
              AsyncSnapshot<BookingAction> snapshot) {
            if (snapshot.hasData) {
              return PaymentScreen(shipmentCase: shipmentCase,);
            }
            else {
              orderBloc.bookingAction();
              return PaymentScreen(shipmentCase: shipmentCase,);
            }
          },
        );
      },
    ),
  );


  }

}
