import 'dart:async';

import 'package:email_validator/email_validator.dart';

import 'package:intl/intl.dart';
import 'package:posta_courier/src/blocs/signIn_and_createAccount_blocs/forgot_pass_bloc.dart';
import 'package:posta_courier/src/blocs/signIn_and_createAccount_blocs/personal_details_bloc.dart';
import 'package:posta_courier/src/blocs/signIn_and_createAccount_blocs/vehicle_bloc.dart';
import 'package:posta_courier/src/blocs/home_blocs/new_vehicle_bloc.dart';
import 'package:posta_courier/src/utils/util.dart';
import 'package:regexed_validator/regexed_validator.dart';

class TextFieldValidation {
  StreamTransformer<String, String> checkValidation(
      String textFieldValue, String errorValue) {
    return StreamTransformer<String, String>.fromHandlers(
        handleData: (textFieldValue, EventSink<String> sink) {
      if (textFieldValue.length > 0) {
        sink.add(textFieldValue);
      } else {
        sink.addError(errorValue);
      }
    });
  }

  checkEmailValidation(String email, screen) {
    if (validator.email(email.trim())) {
      personalDetailsBloc.setEmailValidation(null);
    } else {
      personalDetailsBloc.setEmailValidation('Please enter a valid email');
    }
  }

  checkPassValidation(String password, screen) {
    bool hasUppercase = password.contains(new RegExp(r'[A-Z]'));
    bool hasDigits = password.contains(new RegExp(r'[0-9]'));
    bool hasLowercase = password.contains(new RegExp(r'[a-z]'));
    bool whiteSpace = password.contains(new RegExp(r"\s+\b|\b\s"));
    bool hasMinLength = password.length > 6;

    if (password.length > 0) {
      personalDetailsBloc.isPasswordValid(null);

      if (password.length < 8) {
        screen == 'PERSONAL_DETAILS'
            ? personalDetailsBloc.isPasswordValid(
                "Invalid password ,Be sure password contains at least 8 characters "
                ", please try again")
            : forgotPassBloc.isPasswordValid(
                "Invalid password ,Be sure password contains at least 8 characters "
                ", please try again");
      } else {
        if (whiteSpace) {
          screen == 'PERSONAL_DETAILS'
              ? personalDetailsBloc.isPasswordValid(
                  "Invalid password ,Be sure it dose not contain whitespaces , please try again")
              : forgotPassBloc.isPasswordValid(
                  "Invalid password ,Be sure it dose not contain whitespaces , please try again");
        } else {
          if (validator.password(password)) {
            screen == 'PERSONAL_DETAILS'
                ? personalDetailsBloc.isPasswordValid(null)
                : forgotPassBloc.isPasswordValid(null);
          } else {
            screen == 'PERSONAL_DETAILS'
                ? personalDetailsBloc.isPasswordValid(
                    "Invalid password ,Be sure it contains at least one lowercase letter,"
                    " one uppercase letter, one numeric digit, and one special character,"
                    "and doesn't contain whitespaces , please try again")
                : forgotPassBloc.isPasswordValid(
                    "Invalid password ,Be sure it contains at least one lowercase letter,"
                    " one uppercase letter, one numeric digit, and one special character,"
                    "and doesn't contain whitespaces , please try again");
          }
        }
      }
    } else {
      personalDetailsBloc.isPasswordValid(null);
    }
  }

  checkPasswordMatching(String password, String confirmPass) {
    if (confirmPass.length > 0) {
      personalDetailsBloc.isPasswordMatching(null);
      if (password != confirmPass) {
        personalDetailsBloc
            .isPasswordMatching("Password not matching ,please try again");
      } else {
        personalDetailsBloc.isPasswordMatching(null);
      }
    } else {}
  }

  checkNewPasswordMatching(String password, String confirmPass) {
    if (confirmPass.length > 0) {
      personalDetailsBloc.isPasswordMatching(null);
      if (password != confirmPass) {
        forgotPassBloc
            .isPasswordMatching("Password not matching ,please try again");
      } else {
        forgotPassBloc.isPasswordMatching(null);
      }
    } else {}
  }

  checkBirthdayValidation(DateTime birthday) {
    final date1 = DateTime(
        DateTime.now().year - 21, DateTime.now().month, DateTime.now().day);
    final difference1 = DateTime.now().difference(date1).inDays;
    final date2 = DateTime.now();
    final difference2 = date2.difference(birthday).inDays;

    if (difference2 >= difference1) {
      personalDetailsBloc.setBirthdayValidation(null);
    } else {
      personalDetailsBloc.setBirthdayValidation(
          "You must be at least 21 years of age to sign up");
    }
  }

  checkDriverLicenseIssueDateValidation(String issueDate) {
    DateFormat format = DateFormat("yyyy-MM-dd");
    final difference1 =
        DateTime.now().difference(format.parse(issueDate)).inDays;

    if (difference1 > 0) {
      personalDetailsBloc.setDriverIssueDateValidation(null);
    } else {
      personalDetailsBloc.setDriverIssueDateValidation(
          "Driver license issue date must be before " +
              Utils.dateFormat1(DateTime.now().toString()).toString());
    }
  }

  checkDriverLicenseExpiredDateValidation(String expiredDate) {
    DateFormat format = DateFormat("yyyy-MM-dd");

    final difference1 =
        DateTime.now().difference(format.parse(expiredDate)).inDays;

    if (difference1 < 0) {
      personalDetailsBloc.setDriverExpiredDateValidation(null);
    } else {
      personalDetailsBloc.setDriverExpiredDateValidation(
          "Driver license expired date must be after " +
              Utils.dateFormat1(DateTime.now().toString()));
    }
  }

  checkRegistrationExpiredDateValidation(String date) {
    DateFormat format = DateFormat("yyyy-MM-dd");

    final difference1 = DateTime.now().difference(format.parse(date)).inHours;

    if (difference1 >= 1 && difference1 < 24 || difference1 > 24) {
      vehicleBloc.setRegistrationExpireDateValidation(null);
    } else {
      vehicleBloc.setRegistrationExpireDateValidation(
          "Registration expired date must be after " +
              Utils.dateFormat1(DateTime.now().toString()));
    }
  }

  checkNewCarRegistrationExpiredDateValidation(String date) {
    DateFormat format = DateFormat("yyyy-MM-dd");

    final difference1 = DateTime
        .now()
        .difference(format.parse(date))
        .inHours;

    if (difference1 <= 24 && difference1 < 48 ||
        difference1 < 24 && difference1 < 24 ||
        difference1 >= 1 && difference1 <= 24) {
      newVehicleBloc.setRegistrationExpireDateValidation(null);
    } else {
      newVehicleBloc.setRegistrationExpireDateValidation(
          "Registration expired date must be after " +
              Utils.dateFormat1(DateTime.now().toString()));
    }
  }
}
