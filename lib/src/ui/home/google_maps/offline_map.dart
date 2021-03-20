import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:posta_courier/src/blocs/home_blocs/google_map_bloc.dart';
class OfflineMap extends StatelessWidget {
  LatLng locationPoints;

  OfflineMap({this.locationPoints});

  GoogleMapController _controller;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: googleMapBloc.zoomNumber,
      builder: (BuildContext context, AsyncSnapshot<double> snapshot) {
        if(snapshot.hasData)
          {return GoogleMap(
            liteModeEnabled: true,
            onMapCreated: (GoogleMapController controller) {
              rootBundle.loadString('assets/map_style').then((string) {
                _controller.setMapStyle(string);
              });

              _controller = controller;
            },
            myLocationButtonEnabled: true,
            zoomControlsEnabled: false,
            initialCameraPosition: CameraPosition(
              target: locationPoints,
              zoom: snapshot.data,
            ),
          ); }
        else
          {return GoogleMap(
            liteModeEnabled: true,
            onMapCreated: (GoogleMapController controller) {
              rootBundle.loadString('assets/map_style').then((string) {
                _controller.setMapStyle(string);
              });

              _controller = controller;
            },
            myLocationButtonEnabled: true,
            zoomControlsEnabled: true,
            initialCameraPosition: CameraPosition(
              target: locationPoints,
              zoom: 11.0,
            ),
          );}
      },
    );


    // return StreamBuilder(
    //     stream: googleMapBloc.currentLocation,
    //     builder: (context, snap) {
    //       googleMapBloc.getUserLocation();
    //       googleMapBloc.get();
    //
    //       if (snap.hasData) {
    //         return GoogleMap(
    //           onMapCreated: (GoogleMapController controller) {
    //             rootBundle.loadString('assets/map_style').then((string) {
    //               _controller.setMapStyle(string);
    //             });
    //
    //             _controller = controller;
    //           },
    //           myLocationButtonEnabled: true,
    //           zoomControlsEnabled: false,
    //           initialCameraPosition: CameraPosition(
    //             target: LatLng(snap.data.latitude, snap.data.longitude),
    //             zoom: 17,
    //             // bearing:20.0, // 1
    //             // tilt: 75.0, // 2
    //           ),
    //           markers: googleMapBloc.marker.values.toSet(),
    //         );
    //       } else {
    //         return GoogleMap(
    //           onMapCreated: (GoogleMapController controller) {
    //             rootBundle.loadString('assets/map_style').then((string) {
    //               _controller.setMapStyle(string);
    //             });
    //
    //             _controller = controller;
    //           },
    //           myLocationButtonEnabled: true,
    //           zoomControlsEnabled: false,
    //           initialCameraPosition: CameraPosition(
    //             target: locationPoints,
    //             zoom: 11.0,
    //           ),
    //         );
    //       }
    //     });
  }
}
