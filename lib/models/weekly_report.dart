class WeeklyReport {
  WeeklyReportModel report;

  WeeklyReport({this.report});

  factory WeeklyReport.fromJson(Map<String, dynamic> json) {
    return WeeklyReport(report: WeeklyReportModel.fromJson(json['data']));
  }
}

class WeeklyReportModel {
  List<WeeklyReportDetails> report;

  WeeklyReportModel({this.report});

  factory WeeklyReportModel.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<WeeklyReportDetails> details =
        list.map((i) => WeeklyReportDetails.fromJson(i)).toList();

    return WeeklyReportModel(report: details);
  }
}

class WeeklyReportDetails {
  int paymentId;
  String startDate;
  String endDate;
  int closing;
  String status;

  WeeklyReportDetails(
      {this.paymentId,
      this.startDate,
      this.endDate,
      this.closing,
      this.status});

  factory WeeklyReportDetails.fromJson(Map<String, dynamic> json) {
    return WeeklyReportDetails(
        paymentId: json['payment_id'] as int,
        startDate: json['start_date'] as String,
        endDate: json['end_date'] as String,
        closing: json['closing'] as int,
        status: json['status'] as String);
  }
}
