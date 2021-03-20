import 'package:country_code_picker/country_code_picker.dart';
import 'package:posta_courier/models/activation_code_model.dart';
import 'package:posta_courier/src/blocs/signIn_and_createAccount_blocs/country_cities_bloc.dart';
import 'package:posta_courier/src/reasources/repository.dart';
import 'package:posta_courier/src/utils/util.dart';

import 'package:rxdart/rxdart.dart';
import 'package:country_codes/country_codes.dart';

class PhoneBloc {
  final _phoneNumber = BehaviorSubject<String>();
  final _countryCode = BehaviorSubject<String>();
  final _countryFlag = BehaviorSubject<String>();
  final _isInternetConnected = BehaviorSubject<bool>();
  final _repository = Repository();
  final _activationCode = BehaviorSubject<ActivationCodeModel>();
  String val = "";
  final _checkUser = BehaviorSubject<ActivationCodeModel>();

  Function(String) get setCurrentCountryCode => _countryCode.sink.add;

  Function(String) get setCurrentCountryFlag => _countryFlag.sink.add;

  Function(String) get changePhoneNumber => _phoneNumber.sink.add;

  Observable<String> get phoneNumber => _phoneNumber.stream;

  Observable<String> get countryCode => _countryCode.stream;

  Observable<String> get countryFlag => _countryFlag.stream;

  Observable<ActivationCodeModel> get activationCode => _activationCode.stream;

  Observable<bool> get checkInternet => _isInternetConnected.stream;

  Observable<ActivationCodeModel> get checkUser => _checkUser.stream;

  void onCountryChange(CountryCode countryCode) {
    _countryCode.sink.add(countryCode.toString());
  }

  setCountryCode(String countryCode, String flag) {
    _countryCode.sink.add(countryCode.toString());
    _countryFlag.add(flag);
  }

  add(String value) {
    val = val + value;
  }

  getCountryCode() {
    String flag = "JO";

    if (_countryFlag.value == null) {
      _countryFlag.add(flag);

      return _countryFlag.value;
    } else {
      return _countryFlag.value;
    }
  }

  resetCountry() {
    _countryFlag.add(null);
    _countryCode.add(null);
  }

  resetPhone() {
    _phoneNumber.add(null);
  }

  Future<void> getActivationCode() async {
    CountryDetails countryDetails = CountryCodes.detailsForLocale();
    String countryCode =
    _countryCode.value == null ? "962" : _countryCode.value;
    _countryCode.add(countryCode);
    print(_countryCode.value);
    String phoneNumber = countryCode + _phoneNumber.value;
    ActivationCodeModel response = await _repository.requestActivationCode(
      phoneNumber.replaceAll(RegExp(r'[^\d]+'), ''),
    );
    _activationCode.sink.add(response);
  }

  internetChecked() {
    Utils.isInternetConnected()
        .then((value) => _isInternetConnected.add(value));
  }

  getPhoneNumber() {
    return _countryCode.value + _phoneNumber.value.toString();
  }

  userValidationII() {
    return _activationCode.value.message;
  }

  void dispose() {
    _phoneNumber.close();
    _countryCode.close();
    _activationCode.close();
  }
}

final phoneBloc = PhoneBloc();
