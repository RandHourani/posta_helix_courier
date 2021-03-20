import 'package:country_provider/country_provider.dart';
import 'package:posta_courier/models/city_model.dart';
import 'package:posta_courier/models/country_model.dart';
import 'package:posta_courier/src/reasources/repository.dart';
import 'package:posta_courier/db/providers/cities_provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:country_codes/country_codes.dart';

class CountryBloc {
  final _repository = Repository();
  final _cities = BehaviorSubject<CityModel>();
  final _country = BehaviorSubject<CountryModel>();
  final _selectedCountryCode = BehaviorSubject<String>();
  final _countryCode = BehaviorSubject<List<String>>();
  final _prevCountryCode = BehaviorSubject<String>();

  Observable<CityModel> get cities => _cities.stream;

  Observable<CountryModel> get country => _country.stream;

  Observable<List<String>> get countryDetails => _countryCode.stream;

  getCities(String countryCode) async {
    if (_selectedCountryCode.value == countryCode) {
    } else {
      CitiesDBProvider.deleteAll();

      _selectedCountryCode.add(countryCode);
      CityModel response = await _repository.getCities(countryCode);
      _cities.add(response);
      for (int i = 0; i < _cities.value.data.length; i++) {
        CitiesDBProvider.newCity(City(nameEN: _cities.value.data[i].nameEN));
      }
    }
  }

  getCity() {
    return _cities.value;
  }

  getCountry() async {
    CountryModel response = await _repository.getCountries();
    _country.add(response);
    List<String> list = List();
    for (int i = 0; i < _country.value.data.data.length; i++) {
      if (_country.value.data.data[i].nameEG == "Syria") {
        list.add("963");
      } else {
        Country result = await CountryProvider.getCountryByFullname(
            _country.value.data.data[i].nameEG);
        list.add(result.callingCodes.first);
      }
    }
    _countryCode.add(list);
  }

  getCountryName(int countryId) {
    getCities(_country
        .value
        .data
        .data[_country.value.data.data
        .indexWhere((element) => element.id == countryId)]
        .countryCode);
  }

  getCityById(int id) {
    return _cities.value.data[_cities.value.data.indexWhere((element) =>
    element.id == id)].nameEN;
  }

  getCountryDetails(int index) {
    return _countryCode.value[index];
  }
}

final countryBloc = CountryBloc();
