import 'package:flutter/cupertino.dart';
import 'package:posta_courier/src/blocs/home_blocs/order_bloc.dart';
import 'package:posta_courier/src/ui/home/google_maps/home_screen.dart';

import '../pod_dialog.dart';


class MainScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream:  orderBloc.pod, builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if(snapshot.hasData)
          {if(snapshot.data)
          {
            return PodScreen();}
          else
          {return HomeScreen();}}
        else
          {return HomeScreen();}
    },

    );
  }
}