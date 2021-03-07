import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:posta_courier/models/activation_code_model.dart';
import 'package:posta_courier/src/reasources/repository.dart';

import 'package:rxdart/rxdart.dart';

class OtpForgotPassBloc {
  final _firstDigit = BehaviorSubject<String>();
  final _secondDigit = BehaviorSubject<String>();
  final _thirdDigit = BehaviorSubject<String>();
  final _fourthDigit = BehaviorSubject<String>();
  final _fifthDigit = BehaviorSubject<String>();
  final _sixthDigit = BehaviorSubject<String>();
  final _codeValidation = BehaviorSubject<bool>();
  final _validation = BehaviorSubject<bool>();
  final _verify = BehaviorSubject<ActivationCodeModel>();
  final _repository = Repository();

  String otpCode = "";

  Observable<String> get firstDigit => _firstDigit.stream;

  Observable<String> get secondDigit => _secondDigit.stream;

  Observable<String> get thirdDigit => _thirdDigit.stream;

  Observable<String> get forthDigit => _fourthDigit.stream;

  Observable<String> get fifthDigit => _fifthDigit.stream;

  Observable<String> get sixthDigit => _sixthDigit.stream;

  Observable<bool> get codeValidation => _codeValidation.stream;

  Observable<ActivationCodeModel> get verify => _verify.stream;

  setValidation(bool val) {
    _codeValidation.add(val);
  }

  add(String value) {
    otpCode = otpCode + value;
  }

  firstAdd() {
    if (otpCode.length == 0 || otpCode.isEmpty) {
      _firstDigit.add("");
    } else {
      _firstDigit.add('${otpCode[0]}');
      setValidation(true);
    }
  }

  secondAdd() {
    String secondDigit = otpCode.length == 0 ? "" : otpCode.substring(1);
    _secondDigit.add(otpCode.length <= 1 ? "" : '${secondDigit[0]}');
  }

  thirdAdd() {
    String thirdDigit = otpCode.length <= 2 ? "" : otpCode.substring(2);
    _thirdDigit.add(otpCode.length <= 2 ? "" : '${thirdDigit[0]}');
  }

  fourthAdd() {
    String fourthDigit = otpCode.length <= 3 ? "" : otpCode.substring(3);
    _fourthDigit.add(otpCode.length <= 3 ? "" : '${fourthDigit[0]}');
  }

  fifthAdd() {
    String fifthDigit = otpCode.length <= 4 ? "" : otpCode.substring(4);
    _fifthDigit.add(otpCode.length <= 4 ? "" : '${fifthDigit[0]}');
  }

  sixthAdd() {
    String sixthDigit = otpCode.length <= 5 ? "" : otpCode.substring(5);
    _sixthDigit.add(otpCode.length <= 5 ? null : '${sixthDigit[0]}');
  }

  remove() {
    otpCode = otpCode.substring(0, otpCode.length - 1);
  }

  resetCode() {
    otpCode = "";
  }

  // Future<void> getVerify(phoneNumber) async {
  //   print("phone" + phoneNumber.toString());
  //   ActivationCodeModel response = await _repository.requestVerify({
  //     "phone_number": phoneNumber.toString().replaceAll(RegExp(r'[^\d]+'), ''),
  //     "activation_code": getActivationCode().toString(),
  //     "provider": "captains"
  //   });
  //   _verify.sink.add(response);
  //   if (_verify.value.message == "success") {
  //     _validation.add(true);
  //   } else {
  //     _validation.add(false);
  //   }
  // }

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
    return _firstDigit.value +
        _secondDigit.value +
        _thirdDigit.value +
        _fourthDigit.value +
        _fifthDigit.value +
        _sixthDigit.value;
  }
}

final otpForgotPassBloc = OtpForgotPassBloc();
