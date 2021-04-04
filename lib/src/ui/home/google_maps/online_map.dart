import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:posta_courier/src/blocs/home_blocs/google_map_bloc.dart';
import 'package:posta_courier/src/blocs/home_blocs/order_bloc.dart';
import 'package:posta_courier/src/constants/application_colors_value.dart';
import 'package:posta_courier/src/ui/widgets/dialog_loading.dart';
import 'package:flutter/services.dart' show rootBundle;

class OnlineMap extends StatelessWidget {
  LatLng locationPoints;

  OnlineMap({this.locationPoints});

  GoogleMapController _controller;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: googleMapBloc.currentLocation,
      builder: (context, snap) {
        if (snap.data == null) {
          return Center(
              child: GoogleMap(
            // liteModeEnabled: true,
            //     zoomGesturesEnabled: true,
            //     tiltGesturesEnabled: false,
            onMapCreated: (GoogleMapController controller) {
              // rootBundle.loadString('assets/map_style').then((string) {
              //   _controller.setMapStyle(string);
              // });

              _controller = controller;
            },
            // myLocationButtonEnabled: true,
            // zoomControlsEnabled: true,
            initialCameraPosition: CameraPosition(
              target: locationPoints,
              zoom: 17.0,
              bearing: 15.0, // 1
              tilt: 59.0, // 2
            ),
          ));
        } else {
          return GoogleMap(
            // liteModeEnabled: true,
            polylines: orderBloc.getPolyLine(),
            mapType: MapType.normal,
            // zoomGesturesEnabled: true,
            // tiltGesturesEnabled: false,
            initialCameraPosition: CameraPosition(
              target: LatLng(snap.data.latitude, snap.data.longitude),
              zoom: 17,
              bearing: 15.0, // 1
              tilt: 59.0, // 2
            ),

            onMapCreated: (GoogleMapController controller) {
              orderBloc.showPinsOnMap();

              // rootBundle
              //     .loadString('assets/map_style')
              //     .then((string) {
              //   _controller.setMapStyle(string);
              // });

              _controller = controller;
            },
            markers: googleMapBloc.marker.values.toSet(),
          );
        }
      },
    );
  }

  Future<void> _showDialog(context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        FlutterStatusbarcolor.setStatusBarColor(AppColors.dialogStatusBar);
        Future.delayed(Duration(seconds: 4), () {
          Navigator.pop(context);
        });
        return LoadingDialogWidget();
      },
    ).then((value) => FlutterStatusbarcolor.setStatusBarColor(Colors.white));
  }
}
