import 'dart:io';
import 'dart:typed_data';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:posta_courier/src/blocs/home_blocs/unsuccessful_order_bloc.dart';
import 'package:posta_courier/src/reasources/repository.dart';
import 'package:posta_courier/src/blocs/home_blocs/order_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:posta_courier/models/booking_action_model.dart';
import 'package:signature/signature.dart';
import 'package:flutter/material.dart';

class PodBlock {
  final _repository = Repository();
  final _image = BehaviorSubject<File>();
  final _sign = BehaviorSubject<Uint8List>();
  final _checkSign = BehaviorSubject<bool>();
  final _referenceController = BehaviorSubject<String>();

  Function(String) get changeReference => _referenceController.sink.add;

  Observable<File> get image => _image.stream;

  Observable<Uint8List> get sign => _sign.stream;

  Observable<Uint8List> get signature => _sign.stream;

  Observable<bool> get checkSignature => _checkSign.stream;

  Observable<String> get reference => _referenceController.stream;

  Stream<bool> get submitValid2 =>
      Observable.combineLatest2(reference, image, (reference, image) => true);

  Stream<bool> get submitValid => Observable.combineLatest2(
      reference, checkSignature, (reference, sign) => true);

  void updateImage(ImageSource source) {
    _repository.takeImage(source).then((value) {
      upload(value);
    });
  }

  setSign(Uint8List value) {
    _sign.add(value);
    POD();
  }

  setUnsuccessfulSign(Uint8List value) {
    _sign.add(value);
    if (_image.value == null) {
      unsuccessfulOrderBloc.setUnsuccessfulOrder(
          null, _sign.value, _referenceController.value);
    } else {
      unsuccessfulOrderBloc.setUnsuccessfulOrder(
          _image.value.path, _sign.value, _referenceController.value);
    }
  }

  checkSign(bool value) {
    _checkSign.add(value);
  }

  upload(File file) {
    _image.add(file);
  }

  reset() {
    _image.add(null);
    _referenceController.add(null);
    _sign.add(null);
  }

  POD() async {
    if (_image.value == null) {
      var response = await _repository.setPOD(orderBloc.getBookingId(), null,
          _sign.value, _referenceController.value);
      orderBloc.setOrderSheet(response.data.status);
    } else {
      var response = await _repository.setPOD(orderBloc.getBookingId(),
          _image.value.path, _sign.value, _referenceController.value);
      orderBloc.setOrderSheet(response.data.status);
    }

    // reset();
  }
}

final podBloc = PodBlock();
