import 'package:rxdart/rxdart.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:shared_preferences/shared_preferences.dart';

class OnlineOfflineBloc{
  final _captainStatus=BehaviorSubject<bool>();
  final _goingOffline=BehaviorSubject<bool>();
  final _stopColor=BehaviorSubject<bool>();
  GoogleMapController _controller;
  GoogleMapController _controller2;

  Observable<bool> get captainStatus => _captainStatus.stream;
  Observable<bool> get stopColor => _stopColor.stream;


  setStatus(bool value) async {
    _captainStatus.add(value);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("status", _captainStatus.value);
  }

  setColor(bool value) {
    _stopColor.add(value);
  }

  onMapCreated(GoogleMapController controller) {
    _controller = controller;
  }

  getCaptainStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setStatus(prefs.getBool("status"));
    return prefs.getBool("status");
  }

  void dispose() {
    _captainStatus.close();
  }
}
final onlineOfflineBloc=OnlineOfflineBloc();