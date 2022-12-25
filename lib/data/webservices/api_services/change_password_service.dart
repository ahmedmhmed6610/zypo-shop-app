
import 'package:dio/dio.dart';
import 'package:shop/data/models/government_model.dart';
import 'package:shop/data/models/response_user_model.dart';
import 'package:shop/helpers/app_local_storage.dart';
import 'package:shop/helpers/dio_helper.dart';
import 'package:shop/ui/base/custom_toast.dart';

import '../../models/area_model.dart';
import '../../models/cities_model.dart';
import '../api_constants.dart';

class ChangePasswordService{
  
  static Future<ResponseModel?> changePassword(String newPassword,String oldPassword) async {
    ResponseModel? responseModel;

    var fromData = FormData.fromMap({

    });

    try {
      
      Response response = await DioHelper.postData(uri: ApiConstants.changePassword,token: AppLocalStorage.token,
      data: {
        "old_password" : oldPassword,
        "new_password" : newPassword,
      });

      if(response.statusCode == 200){
        return ResponseModel.fromJson(response.data);
      }else if(response.statusCode == 404){
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
        print('Error sending request!');
        print(e.message);
      }
    }
    return responseModel;
  }

}