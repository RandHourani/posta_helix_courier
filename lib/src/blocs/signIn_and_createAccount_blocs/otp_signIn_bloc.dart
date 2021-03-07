import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:posta_courier/models/activation_code_model.dart';
import 'package:posta_courier/src/reasources/repository.dart';

import 'package:rxdart/rxdart.dart';

class OtpSignInBloc {
  final _firstDigit = BehaviorSubject<String>();
  final _secondDigit = BehaviorSubject<String>();
  final _thirdDigit = BehaviorSubject<String>();
  final _fourthDigit = BehaviorSubject<String>();
  final _fifthDigit = BehaviorSubject<String>();
  final _sixthDigit = BehaviorSubject<String>();
  final _signUpCode = BehaviorSubject<String>();
  final _codeValidation = BehaviorSubject<bool>();
  final _validation = BehaviorSubject<bool>();
  final _verify = BehaviorSubject<ActivationCodeModel>();
  final _repository = Repository();

  String phoneCode = "";

  Observable<String> get firstDigit => _firstDigit.stream;

  Observable<String> get secondDigit => _secondDigit.stream;

  Observable<String> get thirdDigit => _thirdDigit.stream;

  Observable<String> get forthDigit => _fourthDigit.stream;

  Observable<String> get fifthDigit => _fifthDigit.stream;

  Observable<String> get sixthDigit => _sixthDigit.stream;

  Observable<bool> get codeValidation => _validation.stream;

  Observable<ActivationCodeModel> get verify => _verify.stream;

  setValidation(bool val) {
    _codeValidation.add(val);
  }

  add(String value) {
    phoneCode = phoneCode + value;
  }

  firstAdd() {
    if (phoneCode.length == 0 || phoneCode.isEmpty) {
      _firstDigit.add("");
    } else {
      _firstDigit.add('${phoneCode[0]}');
      _codeValidation.add(true);
    }
  }

  secondAdd() {
    String secondDigit = phoneCode.length == 0 ? "" : phoneCode.substring(1);
    _secondDigit.add(phoneCode.length <= 1 ? "" : '${secondDigit[0]}');
  }

  thirdAdd() {
    String thirdDigit = phoneCode.length <= 2 ? "" : phoneCode.substring(2);
    _thirdDigit.add(phoneCode.length <= 2 ? "" : '${thirdDigit[0]}');
  }

  fourthAdd() {
    String fourthDigit = phoneCode.length <= 3 ? "" : phoneCode.substring(3);
    _fourthDigit.add(phoneCode.length <= 3 ? "" : '${fourthDigit[0]}');
  }

  fifthAdd() {
    String fifthDigit = phoneCode.length <= 4 ? "" : phoneCode.substring(4);
    _fifthDigit.add(phoneCode.length <= 4 ? "" : '${fifthDigit[0]}');
  }

  sixthAdd() {
    String sixthDigit = phoneCode.length <= 5 ? "" : phoneCode.substring(5);
    _sixthDigit.add(phoneCode.length <= 5 ? null : '${sixthDigit[0]}');
  }

  remove() {
    phoneCode = phoneCode.substring(0, phoneCode.length - 1);
  }

  resetCode() {
    phoneCode = "";
  }

  Future<void> getVerify(phoneNumber) async {
    _signUpCode.add( getActivationCode().toString());
    ActivationCodeModel response = await _repository.requestVerify({
      "phone_number": phoneNumber.toString().replaceAll(RegExp(r'[^\d]+'), ''),
      "activation_code": getActivationCode().toString(),
      "provider": "captains"
    });
    _verify.sink.add(response);
    print("_verify.value.message");
    print(_verify.value.message);
    if (_verify.value.message == "success") {
      _validation.add(true);
      _codeValidation.add(true);

      final storage = new FlutterSecureStorage();
      await storage.write(key: "code",value:_signUpCode.value);
    } else {
      _validation.add(false);
      _codeValidation.add(false);
    }


  }
  getSignUpCode()
  {return _signUpCode.value;}




  checkCodeValidation() {
    return _validation.value;
  }

  void dispose() {
    _firstDigit.close();
    _secondDigit.close();
    _thirdDigit.close();
    _fourthDigit.close();
    _fifthDigit.close();
    _sixthDigit.close();
    _codeValidation.close();
  }

  getActivationCode() {
    return (_firstDigit.value +
        _secondDigit.value +
        _thirdDigit.value +
        _fourthDigit.value +
        _fifthDigit.value +
        _sixthDigit.value);
  }
}

final otpBloc = OtpSignInBloc();
