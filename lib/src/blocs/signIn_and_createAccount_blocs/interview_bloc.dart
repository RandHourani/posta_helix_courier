
import 'package:intl/intl.dart';
import 'package:posta_courier/models/interview_model.dart';
import 'package:posta_courier/src/reasources/repository.dart';
import 'package:posta_courier/src/utils/util.dart';
import 'package:rxdart/rxdart.dart';

class InterviewBloc {
  final _interviewDate = BehaviorSubject<String>();
  final _interviewTime = BehaviorSubject<InterviewDataModel>();
  final _interviewHM = BehaviorSubject<List<InterviewModel>>();
  final _interviewHours = BehaviorSubject<String>();
  final _interviewMintes = BehaviorSubject<String>();
  final _interviewMins = BehaviorSubject<List<String>>();
  final _selectedTime = BehaviorSubject<String>();
  final _repository = Repository();

  Observable<String> get interviewDate => _interviewDate.stream;

  Observable<InterviewDataModel> get interviewTime => _interviewTime.stream;

  Observable<List<InterviewModel>> get interviewHM => _interviewHM.stream;

  Observable<List<String>> get interviewMins => _interviewMins.stream;

  Observable<String> get selectedTime => _selectedTime.stream;

  Stream<bool> get submitValid => Observable.combineLatest2(
      selectedTime, interviewDate, (selectedTime, interviewDate) => true);

  addInterviewDate(String date) {
    _interviewDate.add(date);
  }

  fetchAllAvailableTime() async {
    List<List<String>> list = List();
    List<InterviewModel> times = List();
    if (_interviewDate.value == null) {
      InterviewDataModel time = await _repository.requestInterViewData(
          Utils.dateFormat5(Utils.dateTimeFormat1(DateTime.now().toString()))
              .toString());
      _interviewTime.sink.add(time);
    } else {
      InterviewDataModel time = await _repository.requestInterViewData(
          Utils.dateFormat5(_interviewDate.value).toString());
      _interviewTime.sink.add(time);

      for (int i = 0; i < _interviewTime.value.interviewTime.length; i++) {
        list.add(_interviewTime.value.interviewTime[i].split(":"));
      }

      int i = 0;
      while (i < list.length - 1) {
        if (list[i].first == list[i + 1].first) {
          List<String> mints = List();
          mints.add(list[i].last);
          mints.add(list[i + 1].last);
          times.add(InterviewModel.fromJson({
            "hour": list[i].first,
            "mins": mints,
          }));
          i++;
        } else {
          if (i == 0) {
            List<String> mints = List();
            mints.add(list[i].last);
            times.add(InterviewModel.fromJson({
              "hour": list[i].first,
              "mins": mints,
            }));
            i++;
          } else {
            i++;
          }
        }
      }

      _interviewHM.add(times);
    }
  }

  setHour(String value) {
    _interviewHours.add(value);
  }

  setMins(String value) {
    _interviewMintes.add(value);
  }

  setSelectedTime() {
    _selectedTime.add(_interviewHours.value.toString() +
        ":" +
        _interviewMintes.value.toString());
  }

  setInterviewMins(int index) {
    _interviewMins.add(_interviewHM.value[index].mins);
  }

  resetTime() {
    _selectedTime.add(null);
  }

  resetInterview() {
    _selectedTime.add(null);
    _interviewDate.add(null);
  }

  sendInterviewData() {
    _repository.interview(convertDateDisplay(_interviewDate.value.toString()) +
        " " +
        _selectedTime.value.toString());
  }

  getSelectedTime(String time) {
    if (int.parse(dateFormat3(time)) > 12) {
      return (int.parse(dateFormat3(time)) - 12).toString() +
          ":" +
          dateFormat4(time) +
          " pm";
    } else {
      return dateFormat3(time)+ ":" + dateFormat4(time) + " am";
    }
  }
  static String dateFormat3(String date) {
    final DateFormat displayFormater = DateFormat('yyyy-MM-dd HH:mm:ss');
    final DateFormat serverFormater = DateFormat('HH');
    final DateTime displayDate = displayFormater.parse(date);
    final String formatted = serverFormater.format(displayDate);
    return formatted;
  }
  static String dateFormat4(String date) {
    final DateFormat displayFormater = DateFormat('yyyy-MM-dd HH:mm:ss');
    final DateFormat serverFormater = DateFormat('mm');
    final DateTime displayDate = displayFormater.parse(date);
    final String formatted = serverFormater.format(displayDate);
    return formatted;
  }
  getSelectedDate() {
    return _interviewDate.value;
  }

  String convertDateDisplay(String date) {
    final DateFormat displayFormater = DateFormat('MMM dd, yyyy');
    final DateFormat serverFormater = DateFormat('yyyy-MM-dd');
    final DateTime displayDate = displayFormater.parse(date);
    final String formatted = serverFormater.format(displayDate);
    return formatted;
  }

  void dispose() {
    _interviewDate.close();
    _interviewTime.close();
    _selectedTime.close();
  }
}

final interviewBloc = InterviewBloc();
