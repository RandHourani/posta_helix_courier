import 'dart:async';

class PersonalDataValidators {
  final mainAddressValidator = StreamTransformer<String, String>.fromHandlers(
      handleData: (String Maddress, EventSink<String> sink) {
    if (Maddress.length > 0) {
      sink.add(Maddress);
    } else {
      sink.addError('*please Enter Main Address');
    }
  });
  final subAddressValidator = StreamTransformer<String, String>.fromHandlers(
      handleData: (String subAddress, EventSink<String> sink) {
    if (subAddress.length > 0) {
      sink.add(subAddress);
    } else {
      sink.addError('*please Enter Description of your Address');
    }
  });

  final bankAccountValidator = StreamTransformer<String, String>.fromHandlers(
      handleData: (String bankAccount, EventSink<String> sink) {
    if (bankAccount.length > 0) {
      sink.add(bankAccount);
    } else {
      sink.addError('* Please Enter Bank Account');
    }
  });
  final birthdayValidator = StreamTransformer<String, String>.fromHandlers(
      handleData: (String birthday, EventSink<String> sink) {
    final DateTime now = DateTime.now();
    List<String> birthdayArr = birthday.split("-");

    final difference = now
        .difference(DateTime(int.parse(birthdayArr[0]),
            int.parse(birthdayArr[1]), int.parse(birthdayArr[2])))
        .inDays;
    if (birthday.length > 0) {
      if (difference >= 7671) {
        sink.add(" ");
      } else {
        sink.add("*age less than 21 Years");
      }
    } else {
      sink.add('* Please Enter your Birthday');
    }
  });
}
