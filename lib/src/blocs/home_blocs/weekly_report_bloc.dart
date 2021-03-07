import 'package:posta_courier/models/weekly_report.dart';
import 'package:posta_courier/models/weekly_report_details_model.dart';
import 'package:posta_courier/src/reasources/repository.dart';
import 'package:rxdart/rxdart.dart';

class WeeklyReportBloc {
  final _repository = Repository();
  final _weeklyReport = BehaviorSubject<WeeklyReport>();
  final _weeklyReportDetails = BehaviorSubject<WeeklyReportDetailsModel>();

  Observable<WeeklyReport> get weeklyReport => _weeklyReport.stream;

  Observable<WeeklyReportDetailsModel> get weeklyReportDetails =>
      _weeklyReportDetails.stream;

  getWeeklyReport() async {
    WeeklyReport weeklyReport = await _repository.getWeeklyReport();
    _weeklyReport.add(weeklyReport);
    getWeeklyReportDetails(
        _weeklyReport.value.report.report.first.paymentId.toString());
  }

  getWeeklyReportDetails(String id) async {
    WeeklyReportDetailsModel weeklyReport =
        await _repository.getWeeklyReportDetails(id);
    _weeklyReportDetails.add(weeklyReport);
  }

  getDetails() {
    return _weeklyReportDetails.value;
  }
}

final weeklyReportBloc = WeeklyReportBloc();
