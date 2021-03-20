import 'dart:io';

import 'package:expandable/expandable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:posta_courier/src/blocs/signIn_and_createAccount_blocs/get_captain_data_bloc.dart';
import 'package:posta_courier/models/captain_cars_model.dart';
import 'package:posta_courier/models/online_offline_model.dart';
import 'package:posta_courier/models/registered_captain_model.dart';
import 'package:posta_courier/src/reasources/repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:image_picker/image_picker.dart';

import 'order_bloc.dart';

class ApprovedCaptainBloc {
  final _repository = Repository();
  final _checkAuth = BehaviorSubject<LogInModel>();
  final _checkCaptainStatus = BehaviorSubject<OnlineOfflineModel>();
  final _cars = BehaviorSubject<CaptainCarsData>();
  final _phoneNumber = BehaviorSubject<String>();
  final _email = BehaviorSubject<String>();
  final _fullName = BehaviorSubject<String>();
  final _notificationToken = BehaviorSubject<String>();
  final _controller = BehaviorSubject<bool>();
  final _profileImage = BehaviorSubject<String>();
  final _profileImageUpdate = BehaviorSubject<File>();

  Observable<OnlineOfflineModel> get captainStatus =>
      _checkCaptainStatus.stream;

  Observable<String> get phone => _phoneNumber.stream;
  Observable<String> get profileImg => _profileImage.stream;
  Observable<File> get profileImage => _profileImageUpdate.stream;

  Observable<LogInModel> get checkUser => _checkAuth.stream;

  Observable<String> get email => _email.stream;

  Observable<String> get fullName => _fullName.stream;

  Observable<CaptainCarsData> get carList => _cars.stream;

  Observable<bool> get expandableController => _controller.stream;

  setExpandableController(bool value) {
    _controller.add(value);
  }

  setNotificationToken(String value) {
    if (value == _notificationToken.value) {
    } else {
      _notificationToken.add(value);
    }
    notificationToken();
  }

  logout() {
_repository.logout();
  }
  updateProfileImage(File file) {
    _profileImageUpdate.add(file);
    _repository.setProfileImage(file);
  }
  void updateImage(ImageSource source, String img) {
    _repository.takeImage(source).then((value) {
    updateProfileImage(value);
    });
  }

  checkUserAuth() async {
    _checkAuth.add(checkCaptainDataBloc.getCaptainData());
    _phoneNumber.add(_checkAuth.value.data.username);
    _email.add(_checkAuth.value.data.email);
    _fullName.add(
        _checkAuth.value.data.firstName + " " + _checkAuth.value.data.lastName);
    _profileImage.add(_checkAuth.value.data.profileImage);
  }

  captainCars() async {
    final storage = new FlutterSecureStorage();
    String accessToken = await storage.read(key: "accessToken");
    CaptainCarsData user = await _repository.captainCars({
      "Authorization": "Bearer " + accessToken,
    });
    _cars.add(user);
  }

  notificationToken() async {
    await _repository.setNotificationToken(_notificationToken.value);
  }

  checkCaptainStatus() async {
    final storage = new FlutterSecureStorage();
    String accessToken = await storage.read(key: "accessToken");
    OnlineOfflineModel status = await _repository.checkCaptainStatus({
      "Authorization": "Bearer " + accessToken,
    });
    _checkCaptainStatus.add(status);
  }

  void dispose() {
    _checkAuth.close();
    _phoneNumber.close();
    _email.close();
  }
}

final approvedCaptainBloc = ApprovedCaptainBloc();
