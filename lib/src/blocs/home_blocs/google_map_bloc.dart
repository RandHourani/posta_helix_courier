import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:location/location.dart';
import 'package:posta_courier/src/reasources/repository.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:ui' as ui;

class GoogleMapBloc {
  final _repository = Repository();
  var _currentLocation = BehaviorSubject<LocationData>();
  var _zoomNumber = BehaviorSubject<double>();

  final Map<String, Marker> _marker = {};

  Map<String, Marker> get marker => _marker;

  var location = new Location();

  Observable<LocationData> get currentLocation => _currentLocation.stream;

  Observable<double> get zoomNumber => _zoomNumber.stream;

  setZoomMap(double number) {
    _zoomNumber.add(number);
  }

  getUserLocation() async {
   await location.getLocation().then((value) {
     get(value);
     _currentLocation.add(value);} );
  }

  void get(LocationData data) async {

    final Uint8List markerIcon =
        await getBytesFromAsset('assets/images/my_location.png', 90);
    final marker = Marker(
      markerId: MarkerId("curr_loc"),
      position: LatLng(
          data.latitude, data.longitude),
      infoWindow: InfoWindow(title: "My Location"),
      icon: BitmapDescriptor.fromBytes(markerIcon),
    );
    _marker["Current Location"] = marker;
    
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
        .buffer
        .asUint8List();
  }

  getCurrentLocation() {
    return _currentLocation.value;
  }
}

final googleMapBloc = GoogleMapBloc();
