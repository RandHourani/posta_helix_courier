import 'package:http/http.dart' as http;

import '../../constants/constants.dart';
import 'package:posta_courier/src/blocs/home_blocs/approved_captain_bloc.dart';
import 'package:posta_courier/src/blocs/signIn_and_createAccount_blocs/get_captain_data_bloc.dart';

class DocumentsProvider {
  Future<void> uploadDocumentImages(String idFront, String idBack,
      String licenseFront, String licenseBack, String id, String auth) async {
    var documentUrl = Constants.MAIN_URL + "captain/" + id;
    var request = http.MultipartRequest('POST', Uri.parse(documentUrl));
    request.headers.addAll({
      "Authorization": "Bearer " + auth,
      "Accept": "application/json",
    });
    if (idFront != null) {
      request.files.add(
          await http.MultipartFile.fromPath('captain[id_card_front]', idFront));
    } else {}
    if (idBack != null) {
      request.files.add(
          await http.MultipartFile.fromPath('captain[id_card_back]', idBack));
    } else {}
    if (licenseFront != null) {
      request.files.add(await http.MultipartFile.fromPath(
          'captain[driving_certificate_front]', licenseFront));
    } else {}
    if (licenseBack != null) {
      request.files.add(await http.MultipartFile.fromPath(
          'captain[driving_certificate_back]', licenseBack));
    }

    request.files.add(http.MultipartFile.fromString('_method', 'PUT'));
    var res = await request.send();
    print(res.statusCode);
    print(res.reasonPhrase);
    checkCaptainDataBloc.checkCaptainData();
  }

  Future<void> uploadDocumentImages2(
      String insuranceFront,
      String insuranceBack,
      String vehicleFront,
      String vehicleBack,
      String id,
      String auth) async {
    var documentUrl = Constants.MAIN_URL + "captain/" + id;
    var request = http.MultipartRequest('POST', Uri.parse(documentUrl));
    request.headers.addAll({
      "Authorization": "Bearer " + auth,
      "Accept": "application/json",
    });

    if (insuranceFront != null) {
      request.files.add(await http.MultipartFile.fromPath(
          'car[insurance_document_front]', insuranceFront));
    } else {}
    if (insuranceBack != null) {
      request.files.add(await http.MultipartFile.fromPath(
          'car[insurance_document_back]', insuranceBack));
    } else {}

    if (vehicleFront != null) {
      request.files.add(await http.MultipartFile.fromPath(
          'car[car_document_front]', vehicleFront));
    } else {}
    if (vehicleBack != null) {
      request.files.add(await http.MultipartFile.fromPath(
          'car[car_document_back]', vehicleBack));
    } else {}

    request.files.add(http.MultipartFile.fromString('_method', 'PUT'));
    var res = await request.send();
    print(res.statusCode);
    print(res.reasonPhrase);
    checkCaptainDataBloc.checkCaptainData();
  }
}
