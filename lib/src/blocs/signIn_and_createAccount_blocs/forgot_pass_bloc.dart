import 'package:posta_courier/models/activation_code_model.dart';
import 'package:posta_courier/src/reasources/repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:country_codes/country_codes.dart';
import 'package:posta_courier/src/blocs/signIn_and_createAccount_blocs/country_cities_bloc.dart';
import 'package:country_codes/country_codes.dart';

class ForgotPassBloc {
  var _repository = Repository();

  var _phone = BehaviorSubject<String>();
  var _password = BehaviorSubject<String>();
  var _confirmPassword = BehaviorSubject<String>();
  final _resetPass = BehaviorSubject<ActivationCodeModel>();

  var _isPasswordHide = BehaviorSubject<bool>();
  var _isConfirmPasswordHide = BehaviorSubject<bool>();
  final _passValidation = BehaviorSubject<String>();
  final _passMatching = BehaviorSubject<String>();
  var _countryCode = BehaviorSubject<String>();
  final _countryFlag = BehaviorSubject<String>();
  final _message = BehaviorSubject<String>();

  Function(String) get changePhone => _phone.sink.add;

  Function(String) get changePassword => _password.sink.add;

  Function(String) get changeConfirmPass => _confirmPassword.sink.add;

  Observable<String> get phone => _phone.stream;

  Observable<String> get password => _password.stream;

  Observable<String> get confirmPass => _confirmPassword.stream;

  Observable<bool> get isPasswordHide => _isPasswordHide.stream;

  Observable<bool> get isConfirmPasswordHide => _isConfirmPasswordHide.stream;

  Observable<String> get isPassValid => _passValidation.stream;

  Observable<String> get isPassMatching => _passMatching.stream;

  Observable<String> get countryCode => _countryCode.stream;

  Observable<String> get countryFlag => _countryFlag.stream;

  setCountryCode(String countryCode, String flag) {
    _countryCode.sink.add(countryCode.toString());
    _countryFlag.add(flag);
    print(_countryFlag.value);

    // countryBloc.getCities(flag);
  }

  getCountryCode() {
    return _countryFlag.value;
  }

  resetCountry() {
    _countryFlag.add(null);
    _countryCode.add(null);
  }

  getPhoneNumber() {
    return _countryCode.value.toString() + _phone.value.toString();
  }

  void onCountryChange(String countryCode) {
    _countryCode.sink.add(countryCode);
  }

  Stream<bool> get submitValid => Observable.combineLatest2(
      password, confirmPass, (password, confirmPass) => true);

  Future<void> getActivationCode() async {
    CountryDetails countryDetails = CountryCodes.detailsForLocale();

    String countryCode = _countryCode.value == null
        ? "962"
        : _countryCode.value;
    _countryCode.add(countryCode);
    String phoneNumber = countryCode + _phone.value;

    ActivationCodeModel response = await _repository
        .requestForgot(phoneNumber.replaceAll(RegExp(r'[^\d]+'), ''));


  }
  getMessage()
  {print(_message.value);
   return _message.value;}

   setMessage(String value)
  {
    _message.add(value);}




  Future<void> resetPass() async {
    CountryDetails countryDetails = CountryCodes.detailsForLocale();
    String countryCode = _countryCode.value == null
        ? "962"
        : _countryCode.value;
    _countryCode.add(countryCode);
    String phoneNumber = countryCode + _phone.value;

    ActivationCodeModel response = await _repository.forgotPassProviderRequest({
      "phone_number": phoneNumber.replaceAll(RegExp(r'[^\d]+'), ''),
      "activation_code": "123456",
      "password": _password.value.toString(),
      "password_confirmation": _confirmPassword.value.toString(),
    });
    _resetPass.add(response);
  }

  resetPassValidation() {
    if (_resetPass.value.message == "success") {
      return true;
    } else {
      return false;
    }
  }

  isPasswordMatching(String value) {
    _passMatching.add(value);
  }

  checkValidation() {
    if (_passValidation.value == null && _passMatching.value == null) {
      return true;
    } else {
      return false;
    }
  }

  getEmail() {
    return _phone.value;
  }

  getPass() {
    return _password.value;
  }

  getConfirmPass() {
    return _confirmPassword.value;
  }

  setPasswordVisibility(bool value) {
    _isPasswordHide.add(value);
  }

  setConfirmPasswordVisibility(bool value) {
    _isConfirmPasswordHide.add(value);
  }

  isPasswordValid(String value) {
    _passValidation.add(value);
  }

  dispose() {
    _phone.close();
    _password.close();
    _confirmPassword.close();
  }
}

final forgotPassBloc = ForgotPassBloc();
