import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:posta_courier/models/activation_code_model.dart';
import 'package:posta_courier/models/registered_captain_model.dart';
import 'package:posta_courier/src/reasources/repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:posta_courier/src/blocs/signIn_and_createAccount_blocs/country_cities_bloc.dart';
import 'package:posta_courier/src/blocs/signIn_and_createAccount_blocs/get_captain_data_bloc.dart';
import 'package:posta_courier/src/blocs/signIn_and_createAccount_blocs/sign_up_bloc.dart';
import 'package:posta_courier/src/blocs/signIn_and_createAccount_blocs/forgot_pass_bloc.dart';

import 'package:country_codes/country_codes.dart';

class SignInBloc {
  var _repository = Repository();
  var _phoneNumber = BehaviorSubject<String>();
  var _password = BehaviorSubject<String>();
  final _countryCode = BehaviorSubject<String>();
  final _countryFlag = BehaviorSubject<String>();
  var _isPasswordHide = BehaviorSubject<bool>();
  final _captain = BehaviorSubject<LogInModel>();
  final _activationCode = BehaviorSubject<ActivationCodeModel>();
  final _loginValidation = BehaviorSubject<String>();

  Function(String) get changePhoneNumber => _phoneNumber.sink.add;

  Function(String) get changePassword => _password.sink.add;

  Function(String) get setCurrentCountryFlag => _countryFlag.sink.add;

  Function(String) get setCurrentCountryCode => _countryCode.sink.add;

  Observable<String> get phoneNumber => _phoneNumber.stream;

  Observable<String> get password => _password.stream;

  Observable<LogInModel> get captainDetails => _captain.stream;

  Observable<ActivationCodeModel> get activationCode => _activationCode.stream;

  Observable<bool> get isPasswordHide => _isPasswordHide.stream;

  Observable<String> get loginValidation => _loginValidation.stream;

  Observable<String> get countryCode => _countryCode.stream;

  Observable<String> get countryFlag => _countryFlag.stream;

  Stream<bool> get submitValid => Observable.combineLatest2(
      phoneNumber, password, (phoneNumber, password) => true);

  setPasswordVisibility(bool value) {
    _isPasswordHide.add(value);
  }

  setCountryCode(String countryCode, String flag) {
    _countryCode.sink.add(countryCode.toString());
    _countryFlag.add(flag);
    print(_countryFlag.value);
    countryBloc.getCities(flag);
    phoneBloc.setCountryCode(countryCode, flag);
    forgotPassBloc.setCountryCode(countryCode, flag);

  }



  getCountryCode() {
    return _countryFlag.value;
  }


  getPhoneNumber() {
    return _countryCode.value.toString() + _phoneNumber.value.toString();
  }

  void onCountryChange(String countryCode) {
    _countryCode.add(countryCode);
  }

  resetCountry() {
    _countryFlag.add(null);
    _countryCode.add(null);
  }
  resetPhone() {
   changePhoneNumber("");
  }

  signIn() async {
    String countryCode = _countryCode.value == null
        ? "962"
        : _countryCode.value;
    _countryCode.add(countryCode);
    String phoneNumber = countryCode + _phoneNumber.value;

    LogInModel captain = await _repository.logIn({
      "username": phoneNumber.replaceAll(RegExp(r'[^\d]+'), ''),
      "password": _password.value.toString(),
      "provider": "captains"
    });

    _captain.sink.add(captain);
    final storage = new FlutterSecureStorage();
    await storage.write(
        key: "accessToken", value: _captain.value.data.accessToken);
    await storage.write(key: "id", value: _captain.value.data.id.toString());
    checkCaptainDataBloc.checkUserAuth();
    checkCaptainDataBloc.checkCaptainData();
  }

  Future<void> getActivationCode() async {
    CountryDetails countryDetails = CountryCodes.detailsForLocale();
    String countryCode = _countryCode.value == null
        ? "962"
        : _countryCode.value.substring(1) ;
    _countryCode.add(countryCode);
    String phoneNumber = countryCode + _phoneNumber.value;
    ActivationCodeModel response = await _repository.requestActivationCode( phoneNumber.replaceAll(RegExp(r'[^\d]+'), ''),
     );

    _activationCode.sink.add(response);
  }

  logInValidation() {
    if (_captain.value.message == "success" &&
        _captain.value.message == "success") {
      _loginValidation.add(null);
      return true;
    } else {
      _loginValidation.add("Invalid username or password , Please try again");
      return false;
    }
  }

  setLoginValidation() {
    _loginValidation.add(null);
  }

  resetUser()
  {
    _phoneNumber.add(null);

  }
  dispose() {
    _phoneNumber.close();
    _password.close();
    _countryCode.close();
  }

}

final signInBloc = SignInBloc();
