import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:posta_courier/src/reasources/repository.dart';
import 'package:rxdart/rxdart.dart';

class DocumentsBloc {
  final _repository = Repository();
  final _idFront = BehaviorSubject<File>();
  final _idBack = BehaviorSubject<File>();
  final _driverLicenseFront = BehaviorSubject<File>();
  final _driverLicenseBack = BehaviorSubject<File>();
  final _insuranceFront = BehaviorSubject<File>();
  final _insuranceBack = BehaviorSubject<File>();
  final _vehicleLicenseFront = BehaviorSubject<File>();
  final _vehicleLicenseBack = BehaviorSubject<File>();

  Observable<File> get idFront => _idFront.stream;

  Observable<File> get idBack => _idBack.stream;

  Observable<File> get driverLicenseFront => _driverLicenseFront.stream;

  Observable<File> get driverLicenseBack => _driverLicenseBack.stream;

  Observable<File> get insuranceFront => _insuranceFront.stream;

  Observable<File> get insuranceBack => _insuranceBack.stream;

  Observable<File> get vehicleLicenseFront => _vehicleLicenseFront.stream;

  Observable<File> get vehicleLicenseBack => _vehicleLicenseBack.stream;

  Stream<bool> get submitValid => Observable.combineLatest8(
      idFront,
      idBack,
      driverLicenseFront,
      driverLicenseBack,
      vehicleLicenseFront,
      vehicleLicenseBack,
      insuranceFront,
      insuranceBack,
      (idFront,
              idBack,
              driverLicenseFront,
              driverLicenseBack,
              vehicleLicenseFront,
              vehicleLicenseBack,
              insuranceFront,
              insuranceBack) =>
          true);

  void takeImage(ImageSource source, String img) {
    _repository.takeImage(source).then((value) {
      if (value != null) {
        switch (img) {
          case 'ID_FRONT':
            {
              updateIdFront(value);
            }
            break;
          case 'ID_BACK':
            {
              updateIdBack(value);
            }
            break;
          case 'DRIVER_LICENSE_FRONT':
            {
              updateDrivingLicenseFront(value);
            }
            break;
          case 'DRIVER_LICENSE_BACK':
            {
              updateDrivingLicenseBack(value);
            }
            break;
          case 'VEHICLE_INSURANCE_FRONT':
            {
              updateInsuranceFront(value);
            }
            break;
          case 'VEHICLE_INSURANCE_BACK':
            {
              updateInsuranceBack(value);
            }
            break;
          case 'VEHICLE_License_FRONT':
            {
              updateVehicleLicenseFront(value);
            }
            break;
          case 'VEHICLE_License_BACK':
            {
              updateVehicleLicenseBack(value);
            }
            break;

          default:
            {}
            break;
        }
      } else {}
    });
  }

  void updateImage(ImageSource source, String img) {
    _repository.takeImage(source).then((value) {
      if (value != null) {
        switch (img) {
          case 'ID_FRONT':
            {
              updateIdFront(value);
            }
            break;
          case 'ID_BACK':
            {
              updateIdBack(value);
            }
            break;
          case 'DRIVER_LICENSE_FRONT':
            {
              updateDrivingLicenseFront(value);
            }
            break;
          case 'DRIVER_LICENSE_BACK':
            {
              updateDrivingLicenseBack(value);
            }
            break;
          case 'VEHICLE_INSURANCE_FRONT':
            {
              updateInsuranceFront(value);
            }
            break;
          case 'VEHICLE_INSURANCE_BACK':
            {
              updateInsuranceBack(value);
            }
            break;
          case 'VEHICLE_License_FRONT':
            {
              updateVehicleLicenseFront(value);
            }
            break;
          case 'VEHICLE_License_BACK':
            {
              updateVehicleLicenseBack(value);
            }
            break;
          default:
            {}
            break;
        }
      } else {}
    });
  }

  addIdFront(File file) {
    _idFront.value != null ? addIdBack(file) : _idFront.add(file);
  }

  addIdBack(File file) {
    _idBack.value == null ? _idBack.add(file) : addDrivingLicenseFront(file);
  }

  addDrivingLicenseFront(File file) {
    _driverLicenseFront.add(file);
  }

  addDrivingLicenseBack(File file) {
    _driverLicenseBack.add(file);
  }

  addInsuranceFront(File file) {
    _insuranceFront.add(file);
  }

  addInsuranceBack(File file) {
    _insuranceBack.add(file);
  }

  updateIdFront(File file) {
    _idFront.add(file);
  }

  updateIdBack(File file) {
    _idBack.add(file);
  }

  updateDrivingLicenseFront(File file) {
    _driverLicenseFront.add(file);
  }

  updateDrivingLicenseBack(File file) {
    _driverLicenseBack.add(file);
  }

  updateInsuranceFront(File file) {
    _insuranceFront.add(file);
  }

  updateInsuranceBack(File file) {
    _insuranceBack.add(file);
  }

  updateVehicleLicenseFront(File file) {
    _vehicleLicenseFront.add(file);
  }

  updateVehicleLicenseBack(File file) {
    _vehicleLicenseBack.add(file);
  }

  uploadDocumentImages() async {
    final storage = new FlutterSecureStorage();
    String auth = await storage.read(key: "accessToken");
    String id = await storage.read(key: "id");
    _repository.uploadDocuments(
        _idFront.value.path,
        _idBack.value.path,
        _driverLicenseFront.value.path,
        _driverLicenseBack.value.path,
        _insuranceFront.value.path,
        _insuranceBack.value.path,
        _vehicleLicenseFront.value.path,
        _vehicleLicenseBack.value.path,
        id.toString(),
        auth.toString());
    _repository.uploadDocuments2(
        _idFront.value.path,
        _idBack.value.path,
        _driverLicenseFront.value.path,
        _driverLicenseBack.value.path,
        _insuranceFront.value.path,
        _insuranceBack.value.path,
        _vehicleLicenseFront.value.path,
        _vehicleLicenseBack.value.path,
        id.toString(),
        auth.toString());

  }

  dispose() {
    _idFront.close();
    _idBack.close();
    _driverLicenseFront.close();
    _driverLicenseBack.close();
    _insuranceFront.close();
    _insuranceBack.close();
    _vehicleLicenseFront.close();
    _vehicleLicenseBack.close();
  }
}

final documentsBloc = DocumentsBloc();
