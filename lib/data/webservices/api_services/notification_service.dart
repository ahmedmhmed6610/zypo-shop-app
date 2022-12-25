
import 'package:dio/dio.dart';
import 'package:shop/helpers/app_local_storage.dart';
import 'package:shop/helpers/dio_helper.dart';
import 'package:shop/ui/base/custom_toast.dart';

import '../../models/NotificationModel.dart';
import '../api_constants.dart';

class NotificationService{
  
  static Future<NotificationModel?> getNotificationUser() async {
    NotificationModel? notificationModel;
    
    try {
      
      Response response = await DioHelper.getData(uri: ApiConstants.notification,token: AppLocalStorage.token);

      if(response.statusCode == 200){
        return NotificationModel.fromJson(response.data);
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
    return notificationModel;
  }



}