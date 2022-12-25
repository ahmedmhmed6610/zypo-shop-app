
import 'package:dio/dio.dart';
import 'package:shop/data/models/response_user_model.dart';
import 'package:shop/data/webservices/api_constants.dart';

import '../../../helpers/app_local_storage.dart';
import '../../../helpers/dio_helper.dart';
import '../../../ui/base/custom_toast.dart';

class ContactUsService {

  static Future<ResponseModel?> setContactUserData(
      String name, String email,String message) async {
    ResponseModel? responseModel;
    var fromData = FormData.fromMap({
      'name': name,
      'email': email,
      'message': message,
    });

    try {
      Response response = await DioHelper.postData(uri: ApiConstants.contactUsUser,data: fromData,token: AppLocalStorage.token);
      print(name);
      print(email);
      print(message);
      print(AppLocalStorage.token);

      if(response.statusCode == 200){
        print('statusCode');
        print(response.statusCode);
       // CustomFlutterToast(response.statusCode.toString());
        return ResponseModel.fromJson(response.data);
      }else if(response.statusCode == 404){
        customFlutterToast(response.data["success"].toString());
        customFlutterToast(response.data["message"]);
      }

    } on DioError catch (e) {
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
    return responseModel;
  }

}