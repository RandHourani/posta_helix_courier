import 'dart:io';
import 'dart:typed_data';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:posta_courier/src/reasources/repository.dart';
import 'package:posta_courier/src/blocs/home_blocs/order_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:posta_courier/models/booking_action_model.dart';

class PodBlock {
  final _repository = Repository();
  final _image = BehaviorSubject<File>();
  final _sign = BehaviorSubject<File>();
  final _referenceController = BehaviorSubject<String>();

  Function(String) get changeReference => _referenceController.sink.add;

  Observable<File> get image => _image.stream;

  Observable<File> get signature => _sign.stream;
  Observable<String> get reference => _referenceController.stream;
  Stream<bool> get submitValid => Observable.combineLatest2(
    reference,image,
          ( reference,image) =>
      true);

  void updateImage(ImageSource source) {
    _repository.takeImage(source).then((value) {
      upload(value);
    });
  }

  setSign(File value) {
    _sign.add(value);


    POD();
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
    var response = await _repository.setPOD(orderBloc.getBookingId(),
        _image.value.path,_sign.value, "000000");
    // orderBloc.addBookingDetails(response);
    reset();
  }
}

final podBloc = PodBlock();
