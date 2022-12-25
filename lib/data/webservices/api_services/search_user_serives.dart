

// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:shop/helpers/dio_helper.dart';
import 'package:shop/ui/base/custom_toast.dart';

import '../../../helpers/app_local_storage.dart';
import '../../models/MyProductUserModel.dart';
import '../../models/SearchModel.dart';
import '../../models/details_product_model.dart';
import '../../models/product_page.dart';
import '../api_constants.dart';

class SearchUserService {


  static Future<MyProductUserModel?> searchUser(
      String name,String categoryId) async {
    MyProductUserModel? productModel;

    var fromData = FormData.fromMap({
      "name": name,
      "category_id": categoryId,
    });
    try {
      Response response = await DioHelper.postData(uri: ApiConstants.searchUser,data: fromData);

      if(response.statusCode == 200){
        print('response.data');
        print(response.data);
        print(response.statusCode);
        return MyProductUserModel.fromJson(response.data);
      }else if (response.statusCode == 404){
        customFlutterToast(response.data['message']);
      }



    } on DioError catch (e) {
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
    return productModel;
  }

  static Future<DetailsProductModel?> detailsProduct(
      String productId) async {
    DetailsProductModel? detailsProductModel;

    try {
      Response response = await DioHelper.getData(uri: "${ApiConstants.addProductUrl}/$productId",token: AppLocalStorage.token);

      if(response.statusCode == 200){
        print(response.data);
        print(response.statusMessage);
        print(response.statusCode);

        return DetailsProductModel.fromJson(response.data);
      }else if (response.statusCode == 404){
        customFlutterToast(response.data['message']);
      }


      // Response response = await Dio().post(baseUrl +ApiConstants.loginUrl, data: fromData,options: Options(
      //     receiveTimeout: 10000,
      //     sendTimeout: 10000
      // ));

    } on DioError catch (e) {
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
    return detailsProductModel;
  }

 }