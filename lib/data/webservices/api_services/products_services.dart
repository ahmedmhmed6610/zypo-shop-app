// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:shop/data/models/show_details_product_model.dart';
import 'package:shop/data/webservices/api_constants.dart';
import 'package:shop/helpers/app_local_storage.dart';
import 'package:shop/helpers/dio_helper.dart';
import 'package:shop/ui/base/custom_toast.dart';

mixin ProductsServices {

  Future getProductDetailsFromApi({required int productId}) async {
    return await DioHelper.getData(
      uri: "${ApiConstants.addProductUrl}/$productId",
    );
  }

 static Future<ShowDetailsProductModel?> getProductDetails(String productId) async{
    ShowDetailsProductModel? showDetailsProductModel;
    try{

      Response response = await DioHelper.getData(uri: "${ApiConstants.addProductUrl}/$productId", token: AppLocalStorage.token);

      if(response.statusCode == 200){
        print('response is ${response.data}');
        return ShowDetailsProductModel.fromJson(response.data);
      }else if(response.statusCode == 404){
        customFlutterToast(response.data['data']);
        customFlutterToast(response.data["success"].toString());
        customFlutterToast(response.data["message"]);
      }
    } on DioError catch(e){
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
    return showDetailsProductModel;
  }
}
