import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:posta_courier/models/add_new_car_model.dart';
import 'package:posta_courier/models/captain_store_model.dart';
import 'package:posta_courier/models/car_model.dart';
import 'package:posta_courier/models/country_model.dart';
import 'package:posta_courier/src/reasources/repository.dart';
import 'package:posta_courier/validation/text_field_validation.dart';
import 'dart:io';
import 'package:rxdart/rxdart.dart';
import 'package:posta_courier/models/city_model.dart';
import 'package:posta_courier/src/blocs/signIn_and_createAccount_blocs/country_cities_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:posta_courier/src/reasources/repository.dart';
import 'package:posta_courier/db/providers/colors_provider.dart';
import 'package:posta_courier/db/providers/vehicle_brands.dart';
import 'approved_captain_bloc.dart';

class NewVehicleBloc {
  final _repository = Repository();
  TextFieldValidation validation = TextFieldValidation();

  final _carBrand = BehaviorSubject<CarDataModel>();
  final _selectedCarBrand = BehaviorSubject<String>();
  final _carBrandId = BehaviorSubject<String>();
  final _plateCode = BehaviorSubject<String>();
  final _plateNumber = BehaviorSubject<String>();
  final _carBrandModels = BehaviorSubject<CarDataModel>();
  final _carModelSelected = BehaviorSubject<String>();
  final _countries = BehaviorSubject<CityModel>();
  final _selectedCountriesName = BehaviorSubject<String>();
  final _carColor = BehaviorSubject<CarDataModel>();
  final _carColorSelected = BehaviorSubject<String>();
  final _carColorSelectedId = BehaviorSubject<int>();
  final _manufacturingYearSelected = BehaviorSubject<String>();
  final _manufacturingYearList = BehaviorSubject<List<String>>();
  final _selectedDate = BehaviorSubject<DateTime>();
  final _registrationExpireDateValidation = BehaviorSubject<String>();
  final _registrationExpireDate = BehaviorSubject<String>();
  final _lastQuery = BehaviorSubject<String>();
  final _calendarColor = BehaviorSubject<bool>();
  final _captainRegistered = BehaviorSubject<CaptainModel>();

  final _insuranceFront = BehaviorSubject<File>();
  final _insuranceBack = BehaviorSubject<File>();
  final _vehicleLicenseFront = BehaviorSubject<File>();
  final _vehicleLicenseBack = BehaviorSubject<File>();

  Observable<File> get insuranceFront => _insuranceFront.stream;

  Observable<File> get insuranceBack => _insuranceBack.stream;

  Observable<File> get vehicleLicenseFront => _vehicleLicenseFront.stream;

  Observable<File> get vehicleLicenseBack => _vehicleLicenseBack.stream;

  Observable<CityModel> get countries => _countries.stream;

  Observable<String> get selectedCountries => _selectedCountriesName.stream;
  List<String> matches = List();
  final list = BehaviorSubject<List<String>>();

  Function(String) get changePlateCode => _plateCode.sink.add;

  Function(String) get changePlateNumber => _plateNumber.sink.add;

  Observable<CarDataModel> get carBrand => _carBrand.stream;

  Observable<String> get selectedCarBrand => _selectedCarBrand.stream;

  Observable<String> get plateCode => _plateCode.stream.transform(
      validation.checkValidation(_plateCode.value, "please Enter plate code"));

  Observable<String> get plateNumber => _plateNumber.stream.transform(validation
      .checkValidation(_plateNumber.value, "please Enter plate number"));

  Observable<CarDataModel> get carModels => _carBrandModels.stream;

  Observable<String> get selectedModel => _carModelSelected.stream;

  Observable<CarDataModel> get carColor => _carColor.stream;

  Observable<String> get selectedColor => _carColorSelected.stream;

  Observable<String> get selectedManuYear => _manufacturingYearSelected.stream;

  Observable<List<String>> get manuYearList => _manufacturingYearList.stream;

  Observable<DateTime> get selectedDate => _selectedDate.stream;

  Observable<String> get registrationExpiredDate =>
      _registrationExpireDate.stream;

  Observable<String> get registrationExpireDateValidation =>
      _registrationExpireDateValidation.stream;

  Observable<bool> get calendarColor => _calendarColor.stream;

  Stream<bool> get submitValid => Observable.combineLatest3(
      selectedCarBrand,
      plateNumber,
      registrationExpiredDate,
      (
        selectedCarBrand,
        plateNumber,
        registrationExpiredDate,
      ) =>
          true);

  setCalendarColor(bool val) {
    _calendarColor.add(val);
  }

  checkRegistrationExpireDateValidation() {
    if (_registrationExpireDateValidation.value == null) {
      return true;
    } else {
      return false;
    }
  }

  fetchAllCarBrand() async {
    BrandsDBProvider.getAllBrands().then((value) async {
      if (value != null) {
      } else {
        CarDataModel carBrand = await _repository.requestCarBrand();
        _carBrand.sink.add(carBrand);
        for (int i = 0; i < _carBrand.value.carData.data.length; i++) {
          BrandsDBProvider.newBrand(
              ColorModelDetails(name: _carBrand.value.carData.data[i].name));
          BrandsDBProvider.getAllBrands()
              .then((value) => matches.add(value[i].name));
        }
        list.add(matches);
      }
    });
  }

  fetchAllCarModels() async {
    CarDataModel carModels =
        await _repository.requestCarModels(_carBrandId.value);
    _carBrandModels.sink.add(carModels);
  }

  getCountries() async {
    _countries.add(countryBloc.getCity());
  }

  fetchAllCarColor() async {
    CarDataModel carBrand = await _repository.requestCarColor();
    _carColor.sink.add(carBrand);
  }

  addCar() async {
    final storage = new FlutterSecureStorage();
    String id = await storage.read(key: "id");
    String auth = await storage.read(key: "accessToken");
    final request = await _repository.newVehicle(
        id,
        auth,
        _insuranceFront.value.path,
        _insuranceBack.value.path,
        _vehicleLicenseFront.value.path,
        _vehicleLicenseBack.value.path);
    approvedCaptainBloc.captainCars();
  }

  getCarBrandId() {
    return _carBrandId.value;
  }

  setSelectedCar(int id) async {
    final storage = new FlutterSecureStorage();
    String auth = await storage.read(key: "accessToken");

    var response = _repository.selectVehicle(id.toString(), auth);
  }

  setSelectedColor(String value) {
    _carColorSelected.add(value);
    ColorsDBProvider.db.getAllColors().then((value) {
      _carColorSelectedId.add(value[value
              .indexWhere((element) => element.name == _carColorSelected.value)]
          .id);
    });
  }

  getSelectedColor() {
    return _carColor.value.carData.data
        .indexWhere((element) => _carColorSelected.value == element.name);
  }

  getSelectedColorId() {
    return _carColorSelectedId.value;
  }

  Future<List<String>> getSuggestions(String query) async {
    // if (query == null) query = "a";
    if (_lastQuery.value != query) {
      _lastQuery.add(query);
      CarDataModel carBrand = await _repository.carBrandList(query);
      _carBrand.sink.add(carBrand);
      BrandsDBProvider.deleteAll();
      for (int i = 0; i < _carBrand.value.carData.data.length; i++) {
        BrandsDBProvider.newBrand(
            ColorModelDetails(name: _carBrand.value.carData.data[i].name));
        BrandsDBProvider.getAllBrands()
            .then((value) => matches.add(value[i].name));
      }
      list.add(matches.toSet().toList());

      list.value
          .retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
      return list.value;
    } else {
      list.value
          .retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
      return list.value.toSet().toList();
    }
  }

  setCarBrand(String value) {
    if (value == _selectedCarBrand.value) {
    } else {
      _selectedCarBrand.add(value);
      int index = list.value
          .indexWhere((element) => _selectedCarBrand.value == element);
      _carBrandId.add(_carBrand.value.carData.data[index].id.toString());
      print(_carBrandId.value);
      fetchAllCarModels();
    }
    int index =
        list.value.indexWhere((element) => _selectedCarBrand.value == element);
    _carBrandId.add(_carBrand.value.carData.data[index].id.toString());
  }

  getCarBrand() {
    return _selectedCarBrand.value;
  }

  setSelectedCountries(String value) {
    _selectedCountriesName.add(value);
  }

  getSelectedCountries() {
    return _countries
        .value
        .data[_countries.value.data.indexWhere(
            (element) => _selectedCountriesName.value == element.nameEN)]
        .id;
  }

  setSelectedModel(String value) {
    _carModelSelected.add(value);
  }

  getSelectedModel() {
    return _carModelSelected.value;
  }

  getSelectedModelId() {
    int index = _carBrandModels.value.carData.data
        .indexWhere((element) => _carModelSelected.value == element.name);
    return _carBrandModels.value.carData.data[index].id;
  }

  Iterable<int> get manufacturingYear sync* {
    int i = 1999;
    while (true) yield i++;
  }

  getManufacturingYear() {
    var list = manufacturingYear
        .skip(1) // don't use 0
        .take(getCurrentDate() - 1999)
        .toList();
    List<String> data = list.map((data) => data.toString()).toList();
    _manufacturingYearList.add(data);
    return _manufacturingYearList.value;
  }

  getCurrentDate() {
    var date = new DateTime.now().toString();
    var dateParse = DateTime.parse(date);
    var formattedDate = "${dateParse.year}";
    return int.parse(formattedDate.toString());
  }

  setManufacturingYear(String value) {
    _manufacturingYearSelected.add(value);
  }

  getManufacturingYearSelected() {
    return _manufacturingYearSelected.value;
  }

  getVehicleNumber() {
    return _plateNumber.value;
  }

  setRegistrationExpireDate(String value) {
    _registrationExpireDate.add(value);
  }

  getRegistrationExpireDate() {
    return _registrationExpireDate.value;
  }

  setRegistrationExpireDateValidation(String value) {
    _registrationExpireDateValidation.add(value);
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

  void takeImage(ImageSource source, String img) {
    _repository.takeImage(source).then((value) {
      if (value != null) {
        switch (img) {
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

  resetData() {
    _registrationExpireDate.add(null);
    _carColorSelected.add(null);
    _manufacturingYearSelected.add(null);
    _selectedCarBrand.add(null);
    getSuggestions(" ");
    _carModelSelected.add(null);
    _carBrandModels.add(null);
    _selectedCountriesName.add(null);
    _vehicleLicenseBack.add(null);
    _vehicleLicenseFront.add(null);
    _insuranceBack.add(null);
    _insuranceFront.add(null);
  }

  Stream<bool> get submitValid2 =>
      Observable.combineLatest4(
          vehicleLicenseFront,
          vehicleLicenseBack,
          insuranceFront,
          insuranceBack,
              (vehicleLicenseFront, vehicleLicenseBack, insuranceFront,
              insuranceBack) =>
          true);

  void dispose() {
    _carBrand.close();
  }
}

final newVehicleBloc = NewVehicleBloc();
