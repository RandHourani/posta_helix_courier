import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:posta_courier/models/activation_code_model.dart';
import 'package:posta_courier/models/bank_model.dart';
import 'package:posta_courier/models/booking_action_model.dart';
import 'package:posta_courier/models/captain_cars_model.dart';
import 'package:posta_courier/models/captain_store_model.dart';
import 'package:posta_courier/models/car_model.dart';
import 'package:posta_courier/models/city_model.dart';
import 'package:posta_courier/models/country_model.dart';
import 'package:posta_courier/models/get_captain_model.dart';
import 'package:posta_courier/models/interview_model.dart';
import 'package:posta_courier/models/nationality_model.dart';
import 'package:posta_courier/models/online_offline_model.dart';
import 'package:posta_courier/models/order_model.dart';
import 'package:posta_courier/models/registered_captain_model.dart';
import 'package:posta_courier/models/report_problem_model.dart';
import 'package:posta_courier/models/ride_model.dart';
import 'package:posta_courier/models/unsuccessful_order_model.dart';
import 'package:posta_courier/models/wallet_model.dart';
import 'package:posta_courier/models/weekly_report.dart';
import 'package:posta_courier/models/weekly_report_details_model.dart';
import 'package:posta_courier/models/tikets_question_model.dart';
import 'package:posta_courier/src/reasources/providers/activation_code_provider.dart';
import 'package:posta_courier/src/reasources/providers/captain_authentication_provider.dart';
import 'package:posta_courier/src/reasources/providers/captain_store_provider.dart';
import 'package:posta_courier/src/reasources/providers/car_data_provider.dart';
import 'package:posta_courier/src/reasources/providers/countries_provider.dart';
import 'package:posta_courier/src/reasources/providers/documents_provider.dart';
import 'package:posta_courier/src/reasources/providers/forgot_pass_provider.dart';
import 'package:posta_courier/src/reasources/providers/interview_data_provider.dart';
import 'package:posta_courier/src/reasources/providers/new_order_provider.dart';
import 'package:posta_courier/src/reasources/providers/notification_provider.dart';
import 'package:posta_courier/src/reasources/providers/personal_data_provider.dart';
import 'package:posta_courier/src/reasources/providers/report_problem_provider.dart';
import 'package:posta_courier/src/reasources/providers/sign_in_provider.dart';
import 'package:posta_courier/src/reasources/providers/unsuccesful_reason_provider.dart';
import 'package:posta_courier/src/reasources/providers/vehicle_provider.dart';
import 'package:posta_courier/src/reasources/providers/wallet_provider.dart';
import 'package:posta_courier/src/reasources/providers/weekly_report_provider.dart';
import 'package:posta_courier/src/reasources/providers/ticket_provider.dart';
import 'package:posta_courier/src/reasources/providers/logout_provider.dart';

class Repository {
  final activationCodeProvider = ActivationCodeProvider();
  final carDataProvide = CarDataProvide();
  final accountDatProvide = PersonalDataProvider();
  final interviewDatProvide = InterviewDataProvider();
  final captainProvider = CaptainProvider();
  final documentProvider = DocumentsProvider();
  final captainAuthProvider = CaptainAuthProvider();
  final unsuccessfulOrderProvider = UnsuccessfulOrderProvider();
  final countriesProvider = CountriesProvider();
  final logInProvider = SignInProvider();
  final forgotPassProvider = ForgotPassProvider();
  final walletProvider = WalletProvider();
  final vehicleProvider = VehicleProvider();
  final orderProvider = OrderProvider();
  final notificationProvider = NotificationProvider();
  final weeklyReportProvider = WeeklyReportProvider();
  final reportProblemProvider = ReportProblemProvider();
  final ticketProvider = TicketProvider();
  final logoutProvider = LogOutProvider();

  // final newOrderProvider = NewOrderProvider();

  Future<File> takeImage(ImageSource source) async {
    var image = await ImagePicker.pickImage(source: source,
      imageQuality: 25
    );
    return image;
  }

  Future<ActivationCodeModel> requestActivationCode(String body) {
    return activationCodeProvider.request(body);
  }  Future<ActivationCodeModel> requestForgot(String body) {
    return activationCodeProvider.requestForgotPass(body);
  }

  Future<ActivationCodeModel> forgotPassProviderRequest(
      Map<String, String> body) {
    return forgotPassProvider.forgotPassRequest(body);
  }

  Future<ActivationCodeModel> requestVerify(Map<String, String> body) {
    return activationCodeProvider.verify(body);
  }

  Future<ActivationCodeModel> checkUserName(Map<String, dynamic> body) {
    return activationCodeProvider.checkUserName(body);
  }

  Future<CountryModel> getCountries() {
    return countriesProvider.country();
  }

  Future<CityModel> getCities(String countryCode) {
    return countriesProvider.city(countryCode);
  }

  Future<CarDataModel> requestCarBrand() {
    return carDataProvide.carBrand();
  }

  Future<CarDataModel> carBrandList(String query) {
    return carDataProvide.carBrandList(query);
  }

  Future<CarDataModel> requestCarColor() {
    return carDataProvide.carColorRequest();
  }

  Future<CarDataModel> requestCarModels(String id) {
    return carDataProvide.carBrandModel(id);
  }

  Future<NationalityModel> requestNationality() {
    return accountDatProvide.nationality();
  }
   setProfileImage(File img) {
    return accountDatProvide.setProfileImage(img);
  }


  Future<InterviewDataModel> requestInterViewData(String date) {
    return interviewDatProvide.getInterviewTime(date);
  }

  Future<CaptainModel> createAccount(Map<String, dynamic> body) {
    return captainProvider.request(body);
  }

  Future<CaptainData> getCaptainData(String id) {
    return captainProvider.getCaptainData(id);
  }

  Future<LogInModel> logIn(Map<String, String> body) {
    return logInProvider.request(body);
  }

  newVehicle(
    String id,
    auth,
    String insuranceFront,
    String insuranceBack,
    String vehicleFront,
    String vehicleBack,
  ) {
    return captainProvider.newVehicleRequest(
        id, auth, insuranceFront, insuranceBack, vehicleFront, vehicleBack);
  }

  Future<CaptainModel> vehicle(String id, auth) {
    return captainProvider.vehicleRequest(id, auth);
  }
selectVehicle(String id, String auth) {
    return captainProvider.selectCar(id, auth);
  }

  Future<void> uploadDocuments(
      String idFront,
      String idBack,
      String licenseFront,
      String licenseBack,
      String insuranceFront,
      String insuranceBack,
      String vehicleFront,
      String vehicleBack,
      String id,
      String auth) {
    return documentProvider.uploadDocumentImages(
        idFront,
        idBack,
        licenseFront,
        licenseBack,
        insuranceFront,
        insuranceBack,
        vehicleFront,
        vehicleBack,
        id,
        auth);
  }  Future<void> uploadDocuments2(
      String idFront,
      String idBack,
      String licenseFront,
      String licenseBack,
      String insuranceFront,
      String insuranceBack,
      String vehicleFront,
      String vehicleBack,
      String id,
      String auth) {
    return documentProvider.uploadDocumentImages2(
        idFront,
        idBack,
        licenseFront,
        licenseBack,
        insuranceFront,
        insuranceBack,
        vehicleFront,
        vehicleBack,
        id,
        auth);
  }

  Future<void> interview(String body) async {
    return interviewDatProvide.interview(body);
  }

  Future<LogInModel> checkAuth(Map<String, String> header) {
    return captainAuthProvider.checkAuth(header);
  }

  Future<CaptainCarsData> captainCars(Map<String, String> header) {
    return captainAuthProvider.captainCarList(header);
  }

  Future<OnlineOfflineModel> checkCaptainStatus(Map<String, String> header) {
    return captainAuthProvider.checkCaptainStatus(header);
  }

  Future<CaptainWallet> walletAccount(Map<String, String> header, String code) {
    return walletProvider.getWalletAccount(header, code);
  }

  Future<WalletModel> walletDetails(
      Map<String, String> header, String accountId) {
    return walletProvider.wallet(header, accountId);
  }

  Future<OrderModel> getOrders(String filter) {
    return orderProvider.getOrders(filter);
  }

  Future<RideModel> getRide(int id) {
    return orderProvider.getRide(id);
  }

  Future<UnsuccessfulOrderModel> unsuccessfulReason(String type) {
    return unsuccessfulOrderProvider.unsuccessfulReason(type);
  }

  Future<void> acceptSuggestion(int id) {
    return orderProvider.acceptSuggestion(id);
  }

  Future<void> rejectSuggestion(int id) {
    return orderProvider.rejectSuggestion(id);
  }

//
  Future<BookingAction> bookingAction(int id) {
    return orderProvider.bookingAction(id);
  }

  Future<BookingAction> setPOD(int id, String img, File sign, String ref) {
    return orderProvider.POD(id, img, sign, ref);
  }

//
  Future<void> setBookingPay(int bookingId, int price) {
    return orderProvider.setBookingPay(bookingId, price);
  }

  Future<void> setShipperPay(int bookingId, int price, String type) {
    return orderProvider.setShipperPay(bookingId, price, type);
  }

//
  Future<void> setUnsuccessfulOrder(int reasonId, String action, int orderId) {
    return unsuccessfulOrderProvider.setUnsuccessfulOrder(
        reasonId, action, orderId);
  }

  Future<void> setNotificationToken(String token) {
    return notificationProvider.notification(token);
  }

  Future<WeeklyReport> getWeeklyReport() {
    return weeklyReportProvider.getWeeklyReport();
  }

  Future<WeeklyReportDetailsModel> getWeeklyReportDetails(String id) {
    return weeklyReportProvider.getWeeklyReportDetails(id);
  }

  Future<QuestionModel> reportProblem(String id) {
    return reportProblemProvider.getTicketQuestion(id);
  }

  postQuestions(Map<String, dynamic> body) {
    reportProblemProvider.postTicketQuestion(body);
  }

  Future<TicketsQuestionModel> ticket(String typeId, String parentId) {
    return reportProblemProvider.getQuestion(typeId, parentId);
  }

  logout() {
    logoutProvider.logOut();
  }
}
