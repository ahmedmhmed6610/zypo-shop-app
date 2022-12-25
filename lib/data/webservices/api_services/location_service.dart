
import 'package:dio/dio.dart';
import 'package:shop/data/models/government_model.dart';
import 'package:shop/helpers/app_local_storage.dart';
import 'package:shop/helpers/dio_helper.dart';
import 'package:shop/ui/base/custom_toast.dart';

import '../../models/area_model.dart';
import '../../models/cities_model.dart';
import '../api_constants.dart';

class LocationService{
  
  static Future<GovernmentModel?> getGovernment() async {
    GovernmentModel? governmentModel;
    
    try {
      
      Response response = await DioHelper.getData(uri: ApiConstants.allGovernorates,token: AppLocalStorage.token);

      if(response.statusCode == 200){
        print('Dio error!..dddddddddddd.');
        print(response.data);
        return GovernmentModel.fromJson(response.data);
      }else if(response.statusCode == 404){
        print('Dio error!...dd');
        customFlutterToast(response.data['data']);
      }
    }on DioError catch (e){
      if (e.response != null) {
        print('Dio error!');
        print('STATUS: ${e.response?.statusCode}');
        print('DATA: ${e.response?.data}');
        print('HEADERS: ${e.response?.headers}');
      } else {
        // Error due to setting up or sending the request
        // print('Error sending request!');
        // print(e.message);
      }
    }
    return governmentModel;
  }

  static Future<CitiesModel?> getCityOfGovernment(String governmentId) async {
    CitiesModel? citiesModel;

    try {

      Response response = await DioHelper.getData(uri: '${ApiConstants.governorates}/states/$governmentId',token:  AppLocalStorage.token);

      if(response.statusCode == 200){
        return CitiesModel.fromJson(response.data);
      }else if(response.statusCode == 404){
        customFlutterToast(response.data['data']);
      }
    }on DioError catch (e){
      if (e.response != null) {
        // print('Dio error!');
        // print('STATUS: ${e.response?.statusCode}');
        // print('DATA: ${e.response?.data}');
        // print('HEADERS: ${e.response?.headers}');
      } else {
        // Error due to setting up or sending the request
        // print('Error sending request!');
        // print(e.message);
      }
    }
    return citiesModel;
  }

  static Future<AreaModel?> getAreaOfCities(String citiesId) async {
    AreaModel? areaModel;

    try {

      Response response = await DioHelper.getData(uri: '${ApiConstants.cities}/$citiesId/areas',token:  AppLocalStorage.token);

      if(response.statusCode == 200){
        // print(response.data);
        return AreaModel.fromJson(response.data);
      }else if(response.statusCode == 404){
        customFlutterToast(response.data['data']);
      }
    }on DioError catch (e){
      if (e.response != null) {
        // print('Dio error!');
        // print('STATUS: ${e.response?.statusCode}');
        // print('DATA: ${e.response?.data}');
        // print('HEADERS: ${e.response?.headers}');
      } else {
        // Error due to setting up or sending the request
        // print('Error sending request!');
        // print(e.message);
      }
    }
    return areaModel;
  }


}