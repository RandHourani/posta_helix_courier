import 'package:posta_courier/src/blocs/signIn_and_createAccount_blocs/vehicle_bloc.dart';
import 'package:posta_courier/src/utils/util.dart';

class VehicleModel {
  static Map<String, dynamic> carData = {
    "captain": {},
    "car": {
      "color_id": vehicleBloc.getSelectedColor() != null
          ? vehicleBloc.getSelectedColor()
          : 1,
      "brand_model_id": vehicleBloc.getSelectedModelId() != null
          ? vehicleBloc.getSelectedModelId()
          : null,
      "number": vehicleBloc.getPlateNumber().toString(),
      "state": vehicleBloc.getSelectedCity(),
      "insurance_expired_date": vehicleBloc.getRegistrationExpireDate() != null
          ? Utils.dateFormat2(
              vehicleBloc.getRegistrationExpireDate().toString())
          : null,
      "car_manufacture_year":
          vehicleBloc.getManufacturingYearSelected().toString(),
      "city_id": vehicleBloc.getSelectedCityId(),
      "brand_id": vehicleBloc.getCarBrand() != null
          ? int.parse(vehicleBloc.getSelectedBrandId())
          : null,
    }
  };

  getCarData() {
    return carData;
  }
}
