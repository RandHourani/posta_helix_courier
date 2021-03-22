import 'dart:async';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:posta_courier/models/bank_model.dart';
import 'package:posta_courier/models/captain_store_model.dart';
import 'package:posta_courier/models/get_captain_model.dart';
import 'package:posta_courier/models/nationality_model.dart';
import 'package:posta_courier/src/reasources/repository.dart';
import 'package:posta_courier/validation/text_field_validation.dart';
import 'package:posta_courier/db/providers/nationalities_provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:posta_courier/src/blocs/signIn_and_createAccount_blocs/signIn_bloc.dart';
import 'package:posta_courier/src/utils/util.dart';

class PersonalDetailsBloc {
  final _firstNameController = BehaviorSubject<String>();
  final _lastNameController = BehaviorSubject<String>();
  final _personalDetailsValidation = BehaviorSubject<bool>();
  final _birthdayController = BehaviorSubject<String>();
  final _birthdayValidation = BehaviorSubject<String>();
  final _issueDateValidation = BehaviorSubject<String>();
  final _expiredDateValidation = BehaviorSubject<String>();
  final _driverLicenseIssueDate = BehaviorSubject<String>();
  final _driverLicenseExpiredOn = BehaviorSubject<String>();
  var _password = BehaviorSubject<String>();
  var _confirmPassword = BehaviorSubject<String>();
  var _isPasswordHide = BehaviorSubject<bool>();
  var _isConfirmPasswordHide = BehaviorSubject<bool>();
  final _male = BehaviorSubject<bool>();
  final _female = BehaviorSubject<bool>();
  final _selectedGender = ReplaySubject<bool>(maxSize: 1);
  final _selectedDate = BehaviorSubject<DateTime>();
  final _genderValidation = ReplaySubject<String>(maxSize: 1);
  final _email = BehaviorSubject<String>();
  final _invalidEmailError = BehaviorSubject<String>();
  final _passValidation = BehaviorSubject<String>();
  final _passMatching = BehaviorSubject<String>();
  final _message = BehaviorSubject<String>();
  final _calendarColor = BehaviorSubject<bool>();
  final _calendarColorIssueDate = BehaviorSubject<bool>();
  final _calendarColorExpiredDate = BehaviorSubject<bool>();
  final _captainRegistered = BehaviorSubject<CaptainModel>();

  TextFieldValidation validation = TextFieldValidation();

  final _repository = Repository();
  final _nationality = BehaviorSubject<NationalityModel>();
  final _selectedNationality = BehaviorSubject<String>();
  final _selectedNationalityID = BehaviorSubject<int>();
  final _bank = BehaviorSubject<BankModel>();
  final _selectedBank = BehaviorSubject<String>();
  final _selectedBankID = BehaviorSubject<int>();

  Function(String) get changeFirstName => _firstNameController.sink.add;

  Function(String) get changeLastName => _lastNameController.sink.add;

  Function(String) get changePassword => _password.sink.add;

  Function(String) get changeConfirmPass => _confirmPassword.sink.add;

  Function(String) get changeEmail {
    // _invalidEmailError.add(null);
    return _email.sink.add;
  }

  Observable<String> get password => _password.stream;

  Observable<String> get confirmPass => _confirmPassword.stream;

  Observable<bool> get isPasswordHide => _isPasswordHide.stream;

  Observable<String> get isEmailValid => _invalidEmailError.stream;

  Observable<String> get isPassValid => _passValidation.stream;

  Observable<String> get isPassMatching => _passMatching.stream;

  Observable<bool> get isConfirmPasswordHide => _isConfirmPasswordHide.stream;

  Observable<bool> get personalDetailsValidation =>
      _personalDetailsValidation.stream;

  Stream<String> get email => _email.stream;

  Observable<String> get firstName => _firstNameController.stream;

  Observable<String> get lastName => _lastNameController.stream;

  Observable<String> get birthday => _birthdayController.stream;

  Observable<String> get birthdayValidation => _birthdayValidation.stream;

  Observable<String> get issueDateValidation => _issueDateValidation.stream;

  Observable<String> get expiredDateValidation => _expiredDateValidation.stream;

  Observable<String> get licenseIssueDate => _driverLicenseIssueDate.stream;

  Observable<String> get licenseExpiredDate => _driverLicenseExpiredOn.stream;

  Observable<DateTime> get selectedDate => _selectedDate.stream;

  Observable<bool> get male => _male.stream;

  Observable<bool> get female => _female.stream;

  Observable<bool> get gender => _selectedGender.stream;

  Observable<String> get genderValidation => _genderValidation.stream;

  Stream<NationalityModel> get nationality => _nationality.stream;

  Observable<String> get selectedNationality => _selectedNationality.stream;

  Observable<BankModel> get bank => _bank.stream;

  Observable<String> get selectedBank => _selectedBank.stream;

  Observable<String> get message => _message.stream;

  Observable<bool> get calendarColor => _calendarColor.stream;

  Observable<bool> get calendarColorIssueDate => _calendarColorIssueDate.stream;

  Observable<bool> get calendarColorExpiredDate =>
      _calendarColorExpiredDate.stream;

  Stream<bool> get submitValid => Observable.combineLatest8(
      firstName,
      lastName,
      email,
      password,
      confirmPass,
      birthday,
      licenseIssueDate,
      licenseExpiredDate,
      (firstName, lastName, email, password, confirmPass, birthday,
              licenseIssueDate, licenseExpiredDate) =>
          true);

  checkPersonalDetailsValidation() {
    if (_invalidEmailError.value == null &&
        _passValidation.value == null &&
        _passMatching.value == null &&
        _issueDateValidation.value == null &&
        _expiredDateValidation.value == null &&
        _birthdayValidation.value == null) {
      _personalDetailsValidation.add(true);
      return true;
    } else {
      _personalDetailsValidation.add(false);
      return false;
    }
  }

  checkEditPersonalDetailsValidation() {
    if (_invalidEmailError.value == null &&
        _issueDateValidation.value == null &&
        _expiredDateValidation.value == null &&
        _birthdayValidation.value == null) {
      _personalDetailsValidation.add(true);
      return true;
    } else {
      _personalDetailsValidation.add(false);
      return false;
    }
  }

  setGenderMale() {
    _male.add(true);
    _female.add(false);
    _selectedGender.add(true);
  }

  setGenderFemale() {
    _female.add(true);
    _male.add(false);
    _selectedGender.add(true);
  }

  getGender() {
    if (_female.value) {
      return false;
    } else {
      return true;
    }
  }

  setGenderValidation(String value) {
    _genderValidation.add(value);
  }

  setEmailValidation(String value) {
    _invalidEmailError.add(value);
  }

  getFirstName() {
    return _firstNameController.value;
  }

  getLastName() {
    return _lastNameController.value;
  }

  getMaleGender() {
    return true;
  }

  getEmail() {
    return _email.value;
  }

  setPasswordVisibility(bool value) {
    _isPasswordHide.add(value);
  }

  isPasswordValid(String value) {
    _passValidation.add(value);
  }

  isPasswordMatching(String value) {
    _passMatching.add(value);
  }

  setConfirmPasswordVisibility(bool value) {
    _isConfirmPasswordHide.add(value);
  }

  setBirthday(String value) {
    _birthdayController.add(value);
  }

  getBirthday() {
    return _birthdayController.value;
  }

  setBirthdayValidation(String value) {
    _birthdayValidation.add(value);
  }

  setDriverIssueDateValidation(String value) {
    _issueDateValidation.add(value);
  }

  setDriverExpiredDateValidation(String value) {
    _expiredDateValidation.add(value);
  }

  setLicenseIssueDate(String value) {
    _driverLicenseIssueDate.add(value.toString());
  }

  setLicenseExpiredOn(String value) {
    _driverLicenseExpiredOn.add(value);
  }

  setInitDate(DateTime value) {
    _selectedDate.add(value);
  }

  getSelectedDate() {
    _selectedDate.value.toString();
  }

  setCalendarColor(bool val) {
    _calendarColor.add(val);
  }

  setCalendarColorIssue(bool val) {
    _calendarColorIssueDate.add(val);
  }

  setCalendarColorExpired(bool val) {
    _calendarColorExpiredDate.add(val);
  }

  getPassword() {
    return _password.value;
  }

  getConfirmPassword() {
    return _confirmPassword.value;
  }

  getDriverIssueDate() {
    return _driverLicenseIssueDate.value;
  }

  getDriverExpiredDate() {
    return _driverLicenseExpiredOn.value;
  }

  fetchAllNationality() async {
    if (_nationality.value == null) {
      NationalityModel nationality = await _repository.requestNationality();
      _nationality.sink.add(nationality);
      for (int i = 0; i < _nationality.value.personalData.data.length; i++) {
        NationalitiesDBProvider.newNationality(NationalityDetails(
            name: _nationality.value.personalData.data[i].name));
      }
    } else {}
  }

  setSelectedNationality(String value) {
    _selectedNationality.add(value);
    NationalitiesDBProvider.db.getAllNationalities().then((value) {
      _selectedNationalityID.add(value[value.indexWhere(
              (element) => element.name == _selectedNationality.value)]
          .id);
    });
  }

  setSelectedBank(String value) {
    _selectedBank.add(value);
  }

  getBankId() {
    _selectedBankID.add(_bank.value.bank.data
        .indexWhere((element) => element.name == _selectedBank.value));
    return _selectedBankID.value + 1;
  }

  getNationalityId() {
    return _selectedNationalityID.value == null
        ? 1
        : _selectedNationalityID.value;
  }

  createAccount() async {
    _invalidEmailError.add(null);
    var response = await _repository.createAccount(captain.getData());
    _captainRegistered.sink.add(response);
    print(_captainRegistered.value.message);
    _captainRegistered.value.data != null
        ? _message.add("success")
        : _message.add("The captain.email has already been taken.");

    print("_message.value");
    print(_message.value);

    if (_message.value == "The captain.email has already been taken.") {
      setEmailValidation("The email address has already been taken");
    } else {
      setEmailValidation(null);
      _message.add("success");
      print(_message.value);
      final storage = new FlutterSecureStorage();
      await storage.write(
          key: "accessToken", value: _captainRegistered.value.data.accessToken);
      await storage.write(
          key: "id", value: _captainRegistered.value.data.id.toString());
    }

    print(_captainRegistered.value.message);
  }

  editAccount() async {
    _invalidEmailError.add(null);
    var response = await _repository.editAccount({
      "captain": {
        "first_name": getFirstName().toString(),
        "last_name": getLastName().toString(),
        "birthday": Utils.dateFormat2(getBirthday().toString()),
        "driving_certificate_end_date":
            Utils.dateFormat2(getDriverExpiredDate().toString()),
        "driving_certificate_start_date":
            Utils.dateFormat2(getDriverIssueDate().toString()),
        "email": getEmail().toString(),
        "gender": getGender(),
        "nationality_id": getNationalityId(),
      },
      "car": [],
    });
    _captainRegistered.sink.add(response);
    print(_captainRegistered.value.message);
    _captainRegistered.value.data != null
        ? _message.add("success")
        : _message.add("The captain.email has already been taken.");

    print("_message.value");
    print(_message.value);

    if (_message.value == "The captain.email has already been taken.") {
      setEmailValidation("The email address has already been taken");
    } else {
      setEmailValidation(null);
      _message.add("success");
      // print("_message.value");
      // print(_message.value);
      // final storage = new FlutterSecureStorage();
      // await storage.write(
      //     key: "accessToken", value: _captainRegistered.value.data.accessToken);
      // await storage.write(
      //     key: "id", value: _captainRegistered.value.data.id.toString());
    }
  }

  setCaptainData(CaptainData model) {
    _firstNameController.add(model.data.firstName);
    _lastNameController.add(model.data.lastName);
    _email.add(model.data.email);
    _birthdayController.add(model.data.birthday);
    _selectedNationality.add(model.data.nationality.name);
    _selectedNationalityID.add(model.data.nationality.id);
    _driverLicenseIssueDate.add(model.data.drivingCertificateSD);
    _driverLicenseExpiredOn.add(model.data.drivingCertificateED);
  }

  setNationality(int index) {
    NationalitiesDBProvider.db.getAllNationalities().then((value) {
      _selectedNationality.add(value[index - 1].name);
    });
  }

  getMessage() {
    return _message.value;
  }

  resetData() {
    _firstNameController.add(null);
    _lastNameController.add(null);
    _email.add(null);
    _birthdayController.add(null);
    _driverLicenseIssueDate.add(null);
    _driverLicenseExpiredOn.add(null);
    _password.add(null);
    _message.add(null);
    _confirmPassword.add(null);
    _captainRegistered.add(null);
    _selectedNationality.add(null);
    setGenderMale();
  }

  void dispose() {
    _firstNameController.close();
    _lastNameController.close();
    _birthdayController.close();
    _male.close();
    _female.close();
    _genderValidation.close();
    _selectedGender.close();
    _password.close();
    _confirmPassword.close();
    _isConfirmPasswordHide.close();
    _isPasswordHide.close();
    _birthdayController.close();
    _driverLicenseIssueDate.close();
    _driverLicenseExpiredOn.close();
    _email.close();
    _nationality.close();
    _bank.close();
    _calendarColorIssueDate.close();
    _calendarColorExpiredDate.close();
    _calendarColor.close();
  }
}

final personalDetailsBloc = PersonalDetailsBloc();
