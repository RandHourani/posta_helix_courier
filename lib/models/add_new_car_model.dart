
import 'package:posta_courier/src/blocs/home_blocs/new_vehicle_bloc.dart';
import 'package:posta_courier/src/utils/util.dart';

class NewCarModel{
  static Map<String, dynamic> car = {
  "brand_id":newVehicleBloc.getCarBrandId(),
  "color_id":( newVehicleBloc.getSelectedColor().toInt() + 1),
    "brand_model_id": (newVehicleBloc.getSelectedModelId().toInt() ),
    "number": newVehicleBloc.getVehicleNumber().toString(),
    "insurance_expired_date":
    Utils.dateFormat2(newVehicleBloc.getRegistrationExpireDate().toString()).toString(),
    "car_manufacture_year": newVehicleBloc.getManufacturingYearSelected().toString(),
    "city_id": 1
  };

  getCarData()
  {
    return car;
  }

}