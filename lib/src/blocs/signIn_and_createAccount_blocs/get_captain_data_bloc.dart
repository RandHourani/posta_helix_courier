
import 'package:posta_courier/models/get_captain_model.dart';
import 'package:posta_courier/models/registered_captain_model.dart';
import 'package:posta_courier/src/blocs/home_blocs/online_offline_bloc.dart';
import 'package:posta_courier/src/reasources/repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:posta_courier/src/blocs/home_blocs/approved_captain_bloc.dart';

class IncompleteBloc {
  final _repository = Repository();
  final _checkAuth = BehaviorSubject<LogInModel>();
  final _personalDataCheck = BehaviorSubject<bool>();
  final _vehicleDataCheck = BehaviorSubject<bool>();
  final _documentDataCheck = BehaviorSubject<bool>();
  final _captainDataCheck = BehaviorSubject<CaptainData>();
  final _activeSugg = BehaviorSubject<ActiveSuggestion>();
  final _fullName = BehaviorSubject<String>();

  Observable<bool> get personal => _personalDataCheck.stream;

  Observable<bool> get vehicle => _vehicleDataCheck.stream;

  Observable<bool> get documents => _documentDataCheck.stream;

  Observable<LogInModel> get checkUser => _checkAuth.stream;

  Observable<CaptainData> get captainData => _captainDataCheck.stream;

  Observable<String> get fullName => _fullName.stream;

  Observable<ActiveSuggestion> get suggestion => _activeSugg.stream;

  getCaptainData() {
    return _checkAuth.value;
  }

  resetSuggestion() {
    _activeSugg.add(null);
  }

  setSuggestion(ActiveSuggestion value) {
    _activeSugg.add(value);
  }

  checkUserAuth() async {
    final storage = new FlutterSecureStorage();
    String accessToken = await storage.read(key: "accessToken");
    LogInModel user = await _repository.checkAuth({
      "Authorization": "Bearer " + accessToken,
      "version_code": 48.toString()
    });
    _checkAuth.add(user);

    print(_checkAuth.value.data.lastCheck);
    if (_checkAuth.value.data.activeSuggestion != null) {
      print("sugg");
      _activeSugg.add(_checkAuth.value.data.activeSuggestion);
    } else {
      print("test");
    }
    _fullName.add(
        _checkAuth.value.data.firstName + " " + _checkAuth.value.data.lastName);
    if (_checkAuth.value.data.car.car.isEmpty) {
      _vehicleDataCheck.add(false);
    } else {
      _vehicleDataCheck.add(true);
    }
    approvedCaptainBloc.checkUserAuth();
    if (_checkAuth.value.data.drivingCertificateBack == null ||
        _checkAuth.value.data.drivingCertificateFront == null ||
        _checkAuth.value.data.idCardFront == null ||
        _checkAuth.value.data.idCardBack == null ||
        _checkAuth.value.data.car == null) {
      _documentDataCheck.add(false);
    } else {
      _documentDataCheck.add(true);
    }
    if (_checkAuth.value.data.id != null) {
      _personalDataCheck.add(true);
    } else {
      _personalDataCheck.add(false);
    }
  }

  checkCaptainData() async {
    final storage = new FlutterSecureStorage();
    String id = await storage.read(key: "id");
    CaptainData data = await _repository.getCaptainData(id.toString());
    _captainDataCheck.add(data);
  }

  getUserData() {
    return _checkAuth.value.data.firstName +
        " " +
        _checkAuth.value.data.firstName;
  }

  checkPersonalDetails(bool value) {
    _personalDataCheck.add(value);
  }

  getData() {
    return _checkAuth.value;
  }

  checkUserStatus() {
    _checkAuth.value.data.lastCheck == 1
        ? onlineOfflineBloc.setStatus(true)
        : onlineOfflineBloc.setStatus(false);
  }

  checkVehicleDetails(bool value) {
    _vehicleDataCheck.add(value);
  }

  checkDocuments(bool value) {
    _documentDataCheck.add(value);
  }
}
final checkCaptainDataBloc=IncompleteBloc();
