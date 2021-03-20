import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:posta_courier/models/captain_store_model.dart';
import 'package:posta_courier/models/car_model.dart';
import 'package:posta_courier/models/city_model.dart';
import 'package:posta_courier/models/get_captain_model.dart';
import 'package:posta_courier/models/registered_captain_model.dart';
import 'package:posta_courier/src/reasources/repository.dart';
import 'package:posta_courier/validation/text_field_validation.dart';
import 'package:posta_courier/db/providers/colors_provider.dart';
import 'package:posta_courier/db/providers/vehicle_brands.dart';
import 'package:posta_courier/src/utils/util.dart';
import 'package:rxdart/rxdart.dart';

import 'country_cities_bloc.dart';

class VehicleBloc {
  final _repository = Repository();
  TextFieldValidation validation = TextFieldValidation();

  final _carBrand = BehaviorSubject<CarDataModel>();
  final _selectedCarBrand = BehaviorSubject<String>();
  final _carBrandId = BehaviorSubject<String>();
  final _lastQuery = BehaviorSubject<String>();

  final _plateNumber = BehaviorSubject<String>();

  final _carBrandModels = BehaviorSubject<CarDataModel>();
  final _carModelSelected = BehaviorSubject<String>();
  final _carModelSelectedId = BehaviorSubject<int>();

  final _countries = BehaviorSubject<CityModel>();
  final _selectedCountriesName = BehaviorSubject<String>();

  final _carColor = BehaviorSubject<CarDataModel>();
  final _carColorSelected = BehaviorSubject<String>();
  final _carColorSelectedId = BehaviorSubject<int>();

  final _manufacturingYearSelected = BehaviorSubject<String>();
  final _manufacturingYearList = BehaviorSubject<List<String>>();

  final _registrationExpireDateValidation = BehaviorSubject<String>();
  final _registrationExpireDate = BehaviorSubject<String>();

  final _calendarColor = BehaviorSubject<bool>();
  List<String> matches = List();
  final list = BehaviorSubject<List<String>>();

  Function(String) get changePlateNumber => _plateNumber.sink.add;

  Observable<CityModel> get countries => _countries.stream;

  Observable<String> get selectedCountries => _selectedCountriesName.stream;

  Observable<CarDataModel> get carBrand => _carBrand.stream;

  Observable<String> get selectedCarBrand => _selectedCarBrand.stream;

  Observable<String> get plateNumber => _plateNumber.stream;

  Observable<CarDataModel> get carModels => _carBrandModels.stream;

  Observable<String> get selectedModel => _carModelSelected.stream;

  Observable<CarDataModel> get carColor => _carColor.stream;

  Observable<String> get selectedColor => _carColorSelected.stream;

  Observable<String> get selectedManuYear => _manufacturingYearSelected.stream;

  Observable<List<String>> get manuYearList => _manufacturingYearList.stream;

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

  setPlateNumber(String val) {
    _plateNumber.add(val);
    print(_plateNumber.value);
  }

  setVehicleDetails(CaptainData data) {
    _plateNumber.add(data.data.car.number);
    _carColorSelectedId.add(data.data.car.colorId);
  }

  fetchAllCarBrand() async {
    BrandsDBProvider.getAllBrands().then((value) async {
      if (value.length > 0) {
        print(value.length);
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
    print(_carBrandId.value);

    CarDataModel carModels =
        await _repository.requestCarModels(_carBrandId.value);
    _carBrandModels.sink.add(carModels);
    _carModelSelected.add(_carBrandModels.value.carData.data[0].name);
  }

  fetchSelectedCarBrandModels(int id) async {
    print(_carBrandId.value);

    CarDataModel carModels =
    await _repository.requestCarModels(_carBrandId.value);
    _carBrandModels.sink.add(carModels);
    _carModelSelected.add(_carBrandModels
        .value
        .carData
        .data[_carBrandModels.value.carData.data
        .indexWhere((element) => element.id == id)]
        .name);
  }

  getCountries() async {
    _countries.add(countryBloc.getCity());
  }

  fetchAllCarColor() async {
    if (_carColor.value == null) {
      CarDataModel carBrand = await _repository.requestCarColor();
      _carColor.sink.add(carBrand);
    } else {}
  }

  createVehicle() async {
    final storage = new FlutterSecureStorage();
    String id = await storage.read(key: "id");
    String auth = await storage.read(key: "accessToken");
    var response = await _repository.vehicle(id, auth, {
      "captain": {},
      "car": {
        "color_id":
        _carColorSelectedId.value != null ? _carColorSelectedId.value : 1,
        "brand_model_id":
        getSelectedModelId() != null ? getSelectedModelId() : null,
        "number": getPlateNumber().toString(),
        "state": _selectedCountriesName.value == null
            ? _countries.value.data[0].nameEN
            : _selectedCountriesName.value,
        "insurance_expired_date":
        vehicleBloc.getRegistrationExpireDate() != null
            ? Utils.dateFormat2(getRegistrationExpireDate().toString())
            : null,
        "car_manufacture_year": getManufacturingYearSelected().toString(),
        "city_id": getSelectedCityId(),
        "brand_id": getCarBrand() != null
            ? int.parse(vehicleBloc.getSelectedBrandId())
            : null,
      }
    });
  }

  checkRegistrationExpireDateValidation() {
    if (_registrationExpireDateValidation.value == null) {
      return true;
    } else {
      return false;
    }
  }

  setSelectedColor(String value) {
    _carColorSelected.add(value);
    _carColorSelectedId.add(_carColor
        .value
        .carData
        .data[_carColor.value.carData.data
        .indexWhere((element) => element.name == value)]
        .id);
  }

  setSelectedColorId(int value) {
    _carColorSelectedId.add(value);
    _carColorSelected.add(_carColor
        .value
        .carData
        .data[_carColor.value.carData.data
        .indexWhere((element) => element.id == _carColorSelectedId.value)]
        .name);
  }

  int getSelectedColor() {
    return _carColorSelectedId.value == null ? 1 : _carColorSelectedId.value;
  }

  Future<List<String>> getSuggestions(String query) async {
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
    if (value == _selectedCarBrand.value) {} else {
      _selectedCarBrand.add(value);
      int index = list.value
          .indexWhere((element) => _selectedCarBrand.value == element);
      _carBrandId.add(_carBrand.value.carData.data[index].id.toString());
      print(_carBrandId.value);
      fetchAllCarModels();
    }
  }

  findCarBrandModel(int index) {
    fetchSelectedCarBrandModels(index);

    // _carModelSelected.add(_carBrandModels
    //     .value
    //     .carData
    //     .data[_carBrandModels.value.carData.data
    //         .indexWhere((element) => element.id == index)]
    //     .name);
    _carModelSelectedId.add(index);
  }

  getCarBrand() {
    return _selectedCarBrand.value;
  }

  setSelectedCountries(String value) {
    print(value);
    _selectedCountriesName.add(value);
  }

  setSelectedModel(String value) {
    _carModelSelected.add(value);
    print(value);
  }

  getSelectedModel() {
    return _carModelSelected.value;
  }

  getSelectedModelId() {
    print(_carModelSelected.value);
    _carModelSelectedId.add(_carBrandModels
        .value
        .carData
        .data[_carBrandModels.value.carData.data
        .indexWhere((element) => element.name == _carModelSelected.value)]
        .id);
    return _carModelSelectedId.value;
  }

  setSelectedModelId(int value) {
    _carModelSelectedId.add(value);
  }

  getSelectedBrandId() {
    return _carBrandId.value;
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

  setRegistrationExpireDate(String value) {
    _registrationExpireDate.add(value);
  }

  getRegistrationExpireDate() {
    return _registrationExpireDate.value;
  }

  setRegistrationExpireDateValidation(String value) {
    _registrationExpireDateValidation.add(value);
  }

  getPlateNumber() {
    return _plateNumber.value;
  }

  getSelectedCity() {
    // print(_selectedCountriesName.value);
    // if (_selectedCountriesName.value == null) {
    //   print(_selectedCountriesName.value);
    //
    //   _selectedCountriesName.add(_countries.value.data.first.nameEN);
    // } else {}
    // print(_selectedCountriesName.value);
    return _selectedCountriesName.value;
  }

  int getSelectedCityId() {
    if (_selectedCountriesName.value != null) {
      return _countries
          .value
          .data[_countries.value.data.indexWhere(
              (element) => _selectedCountriesName.value == element.nameEN)]
          .id;
    } else {
      return _countries.value.data.first.id;
    }
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
  }

  void dispose() {
    _carBrand.close();
  }
}

final vehicleBloc = VehicleBloc();
