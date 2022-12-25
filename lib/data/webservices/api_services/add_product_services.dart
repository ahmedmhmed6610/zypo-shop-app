
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../helpers/app_local_storage.dart';
import '../../../helpers/dio_helper.dart';
import '../../../helpers/logger_helper.dart';
import '../../../ui/base/custom_toast.dart';
import '../../../utils/app_constants.dart';
import '../../models/BrandModelCarModel.dart';
import '../../models/MyProductUserModel.dart';
import '../../models/option_model.dart';
import '../../models/response_user_model.dart';
import '../api_constants.dart';


mixin AddProductServices {
  Future addProductFromApi(dynamic data) async {
    return await DioHelper.postData(
        uri: ApiConstants.addProductUrl, data: data, token: AppLocalStorage.token,);
  }


  static Future<OptionModel?> getOptionOfCategory (String categoryId) async {
    OptionModel? optionModel;
    try{

      Response response = await  DioHelper.getData(uri: '${ApiConstants.categories}/$categoryId${ApiConstants.options}');

      if(response.statusCode == 200){
        return OptionModel.fromJson(response.data);
      }else if(response.statusCode == 404){
        customFlutterToast(response.data["message"]);
        customFlutterToast(response.data["data"]);
      }
    }on DioError catch(e){
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
    return optionModel;

  }


  static Future<ResponseModel?> renewProduct (BuildContext context,String productId) async {
    ResponseModel? responseModel;
    try{

      Response response = await  DioHelper.postData(uri: ApiConstants.renewProduct,
      token: AppLocalStorage.token,data: {
        'product_id' : productId
          });

      if(response.statusCode == 200){
        return ResponseModel.fromJson(response.data);
      }else if(response.statusCode == 404){
        customFlutterToast(response.data["message"]);
        customFlutterToast(response.data["data"]);
      }
    }on DioError catch(e){
      if (e.response != null) {
        // print('Dio error!');
        // print('STATUS: ${e.response?.statusCode}');
        // print('DATA: ${e.response?.data}');
        // print('HEADERS: ${e.response?.headers}');
      } else {
        // // Error due to setting up or sending the request
        // print('Error sending request!');
        // print(e.message);
      }
    }
    return responseModel;

  }


  static Future<BrandModelCarModel?> getModelFromVehicle (String brandId) async {
    BrandModelCarModel? brandModelCarModel;
    try{

      Response response = await  DioHelper.getData(uri: '${ApiConstants.modelVehicles}/$brandId');

      if(response.statusCode == 200){
        return BrandModelCarModel.fromJson(response.data);
      }else if(response.statusCode == 404){
        customFlutterToast(response.data["message"]);
        customFlutterToast(response.data["data"]);
      }
    }on DioError catch(e){
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
    return brandModelCarModel;

  }

  static Future<ResponseModel?> addProductFromApi2(
      String nameOfProductController, String newPriceController,String oldPriceController, String locationController,
      String description, String selectedMainCat,String selectedSubCat, String brandController,
      String governmentController, String cityController,String areaController, String statusController,) async {
    ResponseModel? responseModel;


    var fromData = FormData.fromMap({
      'name': nameOfProductController,
      'price': newPriceController,
      "old_price": oldPriceController,
      "location": locationController,
      "description": description,
      "category_id": selectedMainCat,
      "sub_category_id": selectedSubCat,
      "brand_id": brandController,
      "governorate_id": governmentController,
      "city_id": cityController,
      "area_id": areaController,
      "status": statusController,
      "images[]": '',

    });

    try {
      Response response = await DioHelper.postData(uri: ApiConstants.addProductUrl,data: fromData,token: AppLocalStorage.token);
      // print(nameOfProductController);
      // print(newPriceController);
      // print(response.data);
      // print(response.statusCode);
      if(response.statusCode == 200){
        return ResponseModel.fromJson(response.data);
      }else if(response.statusCode == 404){
        //  CustomFlutterToast(response.data["success"].toString());
        customFlutterToast(response.data["message"]);
        customFlutterToast(response.data["data"]);
        // CustomFlutterToast(response.statusCode.toString());
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

  Future getProductsFromApi({Map<String, dynamic>? query}) async {
    // print("IIIIIIIIII");
    // print(AppLocalStorage.token);
    return await DioHelper.getData(
        uri: ApiConstants.addProductUrl, token: AppLocalStorage.token, query: query);

  }

  static Future<MyProductUserModel?> getMyProducts({Map<String, dynamic>? query,String? querySearch}) async{
    MyProductUserModel? myProductUserModel;

    try{
      Response response = await DioHelper.getData(
        uri: ApiConstants.myProductUrl, token: AppLocalStorage.token,query: query);

      if(response.statusCode == 200){
        //print("response is ${response.data}");
        // CustomFlutterToast(response.data["message"]);
        // CustomFlutterToast(response.data["success"]);
        // CustomFlutterToast(response.data["data"]);
        // CustomFlutterToast('token is is ${AppLocalStorage.token}');
     //   customFlutterToast('token is is ${AppLocalStorage.token}');
        return MyProductUserModel.fromJson(response.data);

      }else {
        if(AppLocalStorage.token == null){

        }
        // customFlutterToast(response.data["message"]);
        // customFlutterToast(response.data["success"]);
        // customFlutterToast(response.data["data"]);
      //  customFlutterToast('token is is ${AppLocalStorage.token}');
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

    return myProductUserModel;
  }

  static Future<ResponseModel?> deleteProductFromApi(
      BuildContext context,
      String productId, String isSold) async {
    ResponseModel? responseModel;


    // print('parameter');
    // print(isSold);
    // print(productId);
    // print(AppLocalStorage.token);

    LoggerHelper.loggerNoStack.i('Api Call :  ${AppConstants.baseUrl}${ApiConstants.addProductUrl}/$productId/$isSold');

    try {
      Response response = await DioHelper.deleteData(uri: '${AppConstants.baseUrl}${ApiConstants.addProductUrl}/$productId/$isSold',
      token: AppLocalStorage.token);

      // print('parameter 2');
      // print(response.data);
      // print(response.statusCode);

      if(response.statusCode == 200){
        return ResponseModel.fromJson(response.data);
      }else if(response.statusCode == 302){
        //  CustomFlutterToast(response.data["success"].toString());
        customFlutterToast(response.data["message"]);
        customFlutterToast(response.data["data"]);
        // CustomFlutterToast(response.statusCode.toString());
      }


    } on DioError catch (e) {
      if (e.response != null) {
        // print('Dio error!');
        // print('STATUS: ${e.response?.statusCode}');
        // print('DATA: ${e.response?.statusMessage}');
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
