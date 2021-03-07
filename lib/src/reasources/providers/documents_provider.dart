import 'package:http/http.dart' as http;

import '../../constants/constants.dart';

class DocumentsProvider {
  Future<void> uploadDocumentImages(
      String idFront,
      String idBack,
      String licenseFront,
      String licenseBack,
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

    request.files.add(
        await http.MultipartFile.fromPath('captain[id_card_front]', idFront));
    request.files.add(
        await http.MultipartFile.fromPath('captain[id_card_back]', idBack));
    request.files.add(await http.MultipartFile.fromPath(
        'captain[driving_certificate_front]', licenseFront));
    request.files.add(await http.MultipartFile.fromPath(
        'captain[driving_certificate_back]', licenseBack));
    // request.files.add(await http.MultipartFile.fromPath(
    //     'car[insurance_document_front]', insuranceFront));
    // request.files.add(await http.MultipartFile.fromPath(
    //     'car[insurance_document_back]', insuranceBack));
    // request.files.add(await http.MultipartFile.fromPath(
    //     'car[car_document_front]',vehicleFront));
    //       request.files.add(await http.MultipartFile.fromPath(
    //     'car[car_document_back]',vehicleBack));

    request.files.add(http.MultipartFile.fromString('_method', 'PUT'));
    var res = await request.send();
    print(res.statusCode);
    print(res.reasonPhrase);
  }

  Future<void> uploadDocumentImages2(
      String idFront,
      String idBack,
      String licenseFront,
      String licenseBack,
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


    request.files.add(await http.MultipartFile.fromPath(
        'car[insurance_document_front]', insuranceFront));
    request.files.add(await http.MultipartFile.fromPath(
        'car[insurance_document_back]', insuranceBack));
    request.files.add(await http.MultipartFile.fromPath(
        'car[car_document_front]',vehicleFront));
          request.files.add(await http.MultipartFile.fromPath(
        'car[car_document_back]',vehicleBack));

    request.files.add(http.MultipartFile.fromString('_method', 'PUT'));
    var res = await request.send();
    print(res.statusCode);
    print(res.reasonPhrase);
  }
}
