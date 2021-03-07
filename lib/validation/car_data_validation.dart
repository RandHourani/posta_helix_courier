import 'dart:async';

class CarDataValidation {
  final dateValidator = StreamTransformer<String, String>.fromHandlers(
      handleData: (String date, EventSink<String> sink) {
    if (date.length > 0) {
      sink.add(date);
    } else {
      sink.addError('* Please Enter  Date');
    }
  });

  final insuranceValidator = StreamTransformer<String, String>.fromHandlers(
      handleData: (String insurance, EventSink<String> sink) {
    final DateTime now = DateTime.now();
    List<String> birthdayArr = insurance.split("-");

    final difference = DateTime(int.parse(birthdayArr[0]),
            int.parse(birthdayArr[1]), int.parse(birthdayArr[2]))
        .difference(now)
        .inDays;
    if (insurance.length > 0) {
      if (difference > 0) {
        sink.add(" ");
      } else {
        sink.add("*date must be a date after $insurance");
      }
    } else {
      sink.add('* Please Enter insurance date');
    }
  });

  final licenseStartValidator = StreamTransformer<String, String>.fromHandlers(
      handleData: (String licenseStart, EventSink<String> sink) {
    final DateTime now = DateTime.now();
    List<String> birthdayArr = licenseStart.split("-");

    final difference = now
        .difference(DateTime(int.parse(birthdayArr[0]),
            int.parse(birthdayArr[1]), int.parse(birthdayArr[2])))
        .inDays;
    if (licenseStart.length > 0) {
      if (difference > 0) {
        sink.add(" ");
      } else {
        sink.add("*date must be a date before $licenseStart");
      }
    } else {
      sink.add('* Please Enter license start date');
    }
  });

  final licenseEndValidator = StreamTransformer<String, String>.fromHandlers(
      handleData: (String licenseEnd, EventSink<String> sink) {
    final DateTime now = DateTime.now();
    List<String> birthdayArr = licenseEnd.split("-");

    final difference = now
        .difference(DateTime(int.parse(birthdayArr[0]),
            int.parse(birthdayArr[1]), int.parse(birthdayArr[2])))
        .inDays;
    if (licenseEnd.length > 0) {
      if (difference < 0) {
        sink.add(" ");
      } else {
        sink.add("*date must be a date after $licenseEnd");
      }
    } else {
      sink.add('* Please Enter license start date');
    }
  });
}
