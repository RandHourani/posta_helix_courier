import 'package:rxdart/rxdart.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart' show rootBundle;

class OnlineOfflineBloc{
  final _captainStatus=BehaviorSubject<bool>();
  final _goingOffline=BehaviorSubject<bool>();
  final _stopColor=BehaviorSubject<bool>();
  GoogleMapController _controller;
  GoogleMapController _controller2;

  Observable<bool> get captainStatus => _captainStatus.stream;
  Observable<bool> get goingOffline => _goingOffline.stream;
  Observable<bool> get stopColor => _stopColor.stream;


  setStatus(bool value)
  {
    _captainStatus.add(value);
  }

  setOfflineStatus(bool value)
  {
    _goingOffline.add(value);
  }

  setColor(bool value)
  {
    _stopColor.add(value);
  }

  onMapCreated(GoogleMapController controller) {
    _controller=controller;




  }

  void dispose()
  {_captainStatus.close();}

}
final onlineOfflineBloc=OnlineOfflineBloc();