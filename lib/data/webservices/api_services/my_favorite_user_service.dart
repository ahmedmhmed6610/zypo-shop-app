
import 'package:dio/dio.dart';
import 'package:shop/data/models/MyFavoriteUserModel.dart';
import 'package:shop/data/models/SubscribeUserModel.dart';
import 'package:shop/helpers/app_local_storage.dart';
import 'package:shop/helpers/dio_helper.dart';
import 'package:shop/ui/base/custom_toast.dart';

import '../../models/NotificationModel.dart';
import '../api_constants.dart';

class MyFavoriteUserService {
  
  static Future<MyFavoriteUserModel?> getMyFavoriteUser(favoriteUserId) async {
    MyFavoriteUserModel? myFavoriteUserModel;
    
    try {
      
      Response response = await DioHelper.getData(uri: '${ApiConstants.myFavoriteUser}/$favoriteUserId/${ApiConstants.subscribersUser}',
          token: AppLocalStorage.token);

      if(response.statusCode == 200){
        print('response is ${response.data}');
        return MyFavoriteUserModel.fromJson(response.data);
      }else if(response.statusCode == 404){
       // customFlutterToast(response.data['data']);
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
    return myFavoriteUserModel;
  }


  static Future<SubscribeUserModel?> setSubscribeUser(favoriteUserId) async {
    SubscribeUserModel? subscribeUserModel;

    try {

      Response response = await DioHelper.getData(uri: '${ApiConstants.myFavoriteUser}/$favoriteUserId/${ApiConstants.subscribeUser}',
          token: AppLocalStorage.token);

      if(response.statusCode == 200){
        return SubscribeUserModel.fromJson(response.data);
      }else if(response.statusCode == 404){
        customFlutterToast(response.data['message']);
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
    return subscribeUserModel;
  }

  static Future<SubscribeUserModel?> deleteSubscribeUser(favoriteUserId) async {
    SubscribeUserModel? subscribeUserModel;

    try {

      Response response = await DioHelper.getData(uri: '${ApiConstants.myFavoriteUser}/$favoriteUserId/${ApiConstants.unsubscribeUser}',
          token: AppLocalStorage.token);

      if(response.statusCode == 200){
        return SubscribeUserModel.fromJson(response.data);
      }else if(response.statusCode == 404){
        customFlutterToast(response.data['message']);
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
    return subscribeUserModel;
  }


}