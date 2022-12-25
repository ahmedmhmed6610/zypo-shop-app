

// ignore_for_file: avoid_print

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:shop/helpers/dio_helper.dart';
import 'package:translator/translator.dart';

import '../../../helpers/app_local_storage.dart';
import '../../../ui/base/custom_toast.dart';
import '../../models/products_model.dart';
import '../../models/response_user_model.dart';
import '../api_constants.dart';

class ProductService {

  final translator = GoogleTranslator();


  static  Future<ProductsModel?> updateVehiclesProduct(
      BuildContext context, String query,
      String categoryName, String name, String price, String oldPrice, String whatsAppNumber, String status, String governmentId,
      String cityId, String areaId, String location, String brandId, String longitude, String latitude, description,
      String optionRequestFuelType, String optionRequestYear, String optionRequestKiloMeter,
      String optionRequestTransmissionType, String optionRequestColorType, String optionRequestBodyType,
      String optionRequestEngineCapacityType, String optionRequestModelBrand, String optionValueFuelType,
      String optionValueYear, String optionValueKiloMeter, String optionValueTransmissionType, String optionValueColorType,
      String optionValueBodyType, String optionValueEngineCapacityType,
      String optionValueModelBrand,
      ) async {

    print('optionValueFuelType');
    print(optionValueFuelType);
    print(optionValueYear);
    print(optionValueKiloMeter);
    print(optionValueTransmissionType);
    print(optionValueBodyType);
    print(optionValueEngineCapacityType);
    print(optionValueModelBrand);
    print(optionRequestFuelType);
    print(optionRequestYear);
    print(optionRequestKiloMeter);
    print(optionRequestTransmissionType);
    print(optionRequestColorType);
    print(optionRequestBodyType);
    print(optionRequestEngineCapacityType);
    print(optionRequestModelBrand);

    ProductsModel? productModel;
    try {

      print('optionValueFuelType');
      print(optionValueFuelType);
      print(optionValueYear);
      print(optionValueKiloMeter);
      print(optionValueTransmissionType);
      print(optionValueBodyType);
      print(optionValueEngineCapacityType);
      print(optionValueModelBrand);
      print(optionRequestFuelType);
      print(optionRequestYear);
      print(optionRequestKiloMeter);
      print(optionRequestTransmissionType);
      print(optionRequestColorType);
      print(optionRequestBodyType);
      print(optionRequestEngineCapacityType);
      print(optionRequestModelBrand);

      Map<String, dynamic> _data = {};
      _data = {
        "name"            :  name ,
        "product_id"      :  query ,
        "price"           :  price,
        "old_price"       :  oldPrice,
        "whats_number": whatsAppNumber,
        "description"     :  description ,
        "location"        : location,
        "country_id"  : governmentId,
        "state_id"         : cityId,
        //  "area_id"         : areaId,
        "status"          : status,
        "brand_id"        : brandId,
        "longitude": longitude,
        "latitude": latitude,
        'options[fuelType]' : optionValueFuelType,
        'options[year]' : optionValueYear != '' ? optionValueYear : 'null',
        'options[kiloMeter]' :  optionValueKiloMeter != '' ? optionValueKiloMeter : 'null',
        'options[transmissionType]' : optionValueTransmissionType ,
        'options[colorType]' : optionValueColorType ,
        'options[bodyType]' : optionValueBodyType,
        'options[engineCapacity]' : optionValueEngineCapacityType,
        'options[ModelCarBrand]' : optionValueModelBrand,
        /////// option arabic
        'options_ar[fuelType]' : optionRequestFuelType,
        'options_ar[year]' : optionRequestYear,
        'options_ar[kiloMeter]' :  optionRequestKiloMeter,
        'options_ar[transmissionType]' : optionRequestTransmissionType,
        'options_ar[colorType]' : optionRequestColorType,
        'options_ar[bodyType]' : optionRequestBodyType,
        'options_ar[engineCapacity]' : optionRequestEngineCapacityType,
        'options_ar[ModelCarBrand]' : optionRequestModelBrand,

      };

      Response response = await DioHelper.postData(uri: ApiConstants.updateProduct,token: AppLocalStorage.token,
          data: FormData.fromMap(_data));


      if(response.statusCode == 200){
        return ProductsModel.fromJson(response.data);
      }else if(response.statusCode == 500){
      //  CustomFlutterToast(response.statusMessage);
      }

    } on Exception catch (e) {
      print('error: $e');
    }
    return productModel;
  }

 static  Future<ProductsModel?> updatePropertiesProduct(BuildContext context,
     String query,String categoryName, String name,
     String price,String oldPrice, String whatsAppNumber, String status,
     String governmentId, String cityId, String areaId, String location,
     String brandId, String longitude, String latitude, String description,String optionRequestTypeApartment,
     String optionRequestDownPayment, String optionRequestAmenities, String optionRequestBedroom,
     String optionRequestBathroom, String optionRequestArea, String optionRequestLevel,
     String optionRequestFurnished, String optionRequestStatus, String optionValueTypeApartment,
     String optionValueDownPayment, String optionValueAmenities, String optionValueBedroom,
     String optionValueBathroom, String optionValueArea, String optionValueLevel,
     String optionValueFurnished, String optionValueStatus,) async {
    ProductsModel? productModel;
    try {

      Map<String, dynamic> _data = {};
      _data = {
        "name"            :  name ,
        "product_id"      :  query ,
        "price"           :  price,
        "old_price"       :  oldPrice,
        "whats_number": whatsAppNumber,
        "description"     :  description ,
        "location"        : location,
        "country_id"  : governmentId,
        "state_id"         : cityId,
        //  "area_id"         : areaId,
        "status"          : '0',
        //  "brand_id"        : brandId,
        "longitude": longitude,
        "latitude": latitude,
        'options_ar[TypeApartment]' : optionRequestTypeApartment ,
        'options_ar[DownPayment]' : optionRequestDownPayment != '' ? optionRequestDownPayment : 'null',
        'options_ar[Amenities]' : optionRequestAmenities ,
        'options_ar[Bedroom]' :  optionRequestBedroom != '' ? optionRequestBedroom : 'null',
        'options_ar[Bathroom]' :  optionRequestBathroom != '' ? optionRequestBathroom : 'null',
        'options_ar[Area]' :  optionRequestArea != '' ? optionRequestArea : 'null',
        'options_ar[Level]' :  optionRequestLevel,
        'options_ar[Furnished]' : optionRequestFurnished,
        'options_ar[Status]' : optionRequestStatus,
        ///// option arabic
        'options[TypeApartment]' : optionValueTypeApartment ,
        'options[DownPayment]' : optionValueDownPayment != '' ? optionValueDownPayment : 'null',
        'options[Amenities]' : optionValueAmenities ,
        'options[Bedroom]' :  optionValueBedroom != '' ? optionValueBedroom : 'null',
        'options[Bathroom]' :  optionValueBathroom != '' ? optionValueBathroom : 'null',
        'options[Area]' :  optionValueArea != '' ? optionValueArea : 'null',
        'options[Level]' :  optionValueLevel,
        'options[Furnished]' : optionValueFurnished,
        'options[Status]' : optionValueStatus,
      };

      Response response = await DioHelper.postData(uri: ApiConstants.updateProduct,token: AppLocalStorage.token,
          data: FormData.fromMap(_data));

      print(response.statusCode);
      print(AppLocalStorage.token);
      print(query);
      print(response.data);

      if(response.statusCode == 200){
        return ProductsModel.fromJson(response.data);
      }else if(response.statusCode == 500){
      //  CustomFlutterToast(response.statusMessage);
      }

    } on Exception catch (e) {
      print('error: $e');
    }
    return productModel;
  }


  static  Future<ProductsModel?> updateElectronicsProduct(BuildContext context,
      String query, String categoryName, String name, String price, String oldPrice, String whatsAppNumber,
      String status, String governmentId, String cityId, String areaId,
      String location, String brandId, String longitude, String latitude,  String description, String optionRequestWarranty,
      String optionValueWarranty,) async {
    ProductsModel? productModel;

    print('queryProduct  $query');
    print('categoryName  $categoryName');
    print('name number $name');
    print('price $price');
    print('oldPrice $oldPrice');
    print('whatsAppNumber $whatsAppNumber');
    print('status $status');
    print('governmentId $governmentId');
    print('cityId $cityId');
    print('areaId $areaId');
    print('location $location');
    print('brandId $brandId');
    print('longitude $longitude');
    print('latitude $latitude');
    print('description $description');
    print('optionRequestWarranty $optionRequestWarranty');
    print('optionValueWarranty $optionValueWarranty');

    try {

      Map<String, dynamic> _data = {};
      _data = {
        "name"            :  name ,
        "product_id"      :  query ,
        "price"           :  price,
        "old_price"       :  oldPrice,
        "whats_number": whatsAppNumber,
        "description"     :  description ,
        "location"        : location,
        "country_id"  : governmentId,
        "state_id"         : cityId,
        //  "area_id"         : areaId,
        "status"          : status,
        "brand_id"        : brandId,
        "longitude": longitude,
        "latitude": latitude,
        'options[warranty]' : optionValueWarranty,
        'options_ar[warranty]' : optionRequestWarranty,
      };

      Response response = await DioHelper.postData(uri: ApiConstants.updateProduct,token: AppLocalStorage.token,
          data: FormData.fromMap(_data));

      print(response.statusCode);
      print(AppLocalStorage.token);
      print(query);
      print(response.data);

      return ProductsModel.fromJson(response.data);

    } on Exception catch (e) {
      print('error: $e');
    }
    return productModel;
  }

  static  Future<ProductsModel?> updateHomeFashionProduct(
      BuildContext context, String query,
      String categoryName, String name, String price, String oldPrice, String whatsAppNumber, String status,
      String governmentId, String cityId, String areaId, String location, String brandId,
      String longitude, String latitude, String description, String optionRequestHomeFashion,
      String optionValueHomeFashion,
    ) async {
    ProductsModel? productModel;
    try {
      // Response response = await Dio().get('http://shop-crm.germaniatek.net/api/products',
      // options: Options(
      //   headers: {
      //     'Authorization': 'Bearer ' + globals.token,
      //   }
      // ));

      print('change product response');
      print('loadingggggggs');
      print(query);
      print(name);
      print(price);
      print(oldPrice);
      print(whatsAppNumber);
      print(status);
      print(governmentId);
      print(cityId);
      print(areaId);
      print(location);
      print(brandId);
      print(longitude);
      print(latitude);
      print(description);
      print(optionRequestHomeFashion);
      print(optionValueHomeFashion);


      Map<String, dynamic> _data = {};
      _data = {
        "name"            :  name ,
        "product_id"      :  query ,
        "price"           :  price,
        "old_price"       :  oldPrice,
        "whats_number": whatsAppNumber,
        "description"     :  description ,
        "location"        : location,
        "country_id"  : governmentId,
        "state_id"         : cityId,
        //  "area_id"         : areaId,
        "status"          : status,
        //  "brand_id"        : brandId,
        "longitude": longitude,
        "latitude": latitude,
        'options[HomeFashionType]' : optionValueHomeFashion,
        'options_ar[HomeFashionType]' : optionRequestHomeFashion
      };
      Response response = await DioHelper.postData(uri: ApiConstants.updateProduct,token: AppLocalStorage.token,
          data: FormData.fromMap(_data));

      print('response.statusCode');
      print(response.statusCode);
      print(AppLocalStorage.token);
      print(query);
      print(response.statusMessage);

      return ProductsModel.fromJson(response.data);

    } on DioError catch (e){
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

  static  Future<ProductsModel?> updateHomeFurnitureProduct(BuildContext context,
      String query, String categoryName, String name, String price, String oldPrice,
      String whatsAppNumber, String status, String governmentId, String cityId, String areaId, String location,
      String brandId, String longitude, String latitude,  String description, String optionRequestFurniture,
      String optionValueFurniture,) async {
    ProductsModel? productModel;
    try {

      print('statusUser $status');
      print(status);
      Map<String, dynamic> _data = {};
      _data = {
        "name"            :  name ,
        "product_id"      :  query ,
        "price"           :  price,
        "old_price"       :  oldPrice,
        "whats_number": whatsAppNumber,
        "description"     :  description ,
        "location"        : location,
        "country_id"  : governmentId,
        "state_id"         : cityId,
        //  "area_id"         : areaId,
        "status"          : status,
        //  "brand_id"        : brandId,
        "longitude": longitude,
        "latitude": latitude,
        'options[furnitureType]' : optionValueFurniture,
        'options_ar[furnitureType]' : optionRequestFurniture,
      };
      Response response = await DioHelper.postData(uri: ApiConstants.updateProduct,token: AppLocalStorage.token,
          data: FormData.fromMap(_data));
      print(response.statusCode);
      print(AppLocalStorage.token);
      print(query);
      print(response.data);

      return ProductsModel.fromJson(response.data);

    } on Exception catch (e) {
      print('error: $e');
    }
    return productModel;
  }

  static  Future<ProductsModel?> updateBooksProduct(BuildContext context,
      String query,
      String categoryName, String name, String price,
      String oldPrice, String whatsAppNumber, String status, String governmentId,
      String cityId, String areaId, String location, String brandId,
      String longitude, String latitude, String description, String optionRequestBooks, String optionValueBooks,
     ) async {
    ProductsModel? productModel;
    try {

      Map<String, dynamic> _data = {};
      _data = {
        "name"            :  name ,
        "product_id"      :  query ,
        "price"           :  price,
        "old_price"       :  oldPrice,
        "whats_number": whatsAppNumber,
        "description"     :  description ,
        "location"        : location,
        "country_id"  : governmentId,
        "state_id"         : cityId,
      //  "area_id"         : areaId,
        "status"          : status,
        //"brand_id"        : brandId,
        "longitude": longitude,
        "latitude": latitude,
        'options[BooksType]' : optionValueBooks,
        'options_ar[BooksType]' : optionRequestBooks,
      };
      Response response = await DioHelper.postData(uri: ApiConstants.updateProduct,token: AppLocalStorage.token,
          data: FormData.fromMap(_data) );
      print(governmentId);
      print(cityId);
      print(areaId);
      print(location);
      print(response.statusCode);
      print(AppLocalStorage.token);
      print(query);
      print(response.data);

      return ProductsModel.fromJson(response.data);

    } on Exception catch (e) {
      print('error: $e');
    }
    return productModel;
  }

  static  Future<ProductsModel?> updateKidsProduct(BuildContext context,
      String query,
      String categoryName, String name,
      String price, String oldPrice, String whatsAppNumber, String status, String governmentId, String cityId,
      String areaId, String location, String brandId, String longitude, String latitude,  String description, String optionRequestKids,
      String optionValueKids,) async {
    ProductsModel? productModel;
    try {

      Map<String, dynamic> _data = {};
      _data = {
        "name"            :  name ,
        "product_id"      :  query ,
        "price"           :  price,
        "old_price"       :  oldPrice,
        "whats_number": whatsAppNumber,
        "description"     :  description ,
        "location"        : location,
        "country_id"  : governmentId,
        "state_id"         : cityId,
      //  "area_id"         : areaId,
        "status"          : status,
      //  "brand_id"        : brandId,
        "longitude": longitude,
        "latitude": latitude,
        'options[KidsType]' : optionValueKids,
        'options_ar[KidsType]' : optionRequestKids,
      };
      Response response = await DioHelper.postData(uri: ApiConstants.updateProduct,token: AppLocalStorage.token,
          data: FormData.fromMap(_data));
      print(response.statusCode);
      print(AppLocalStorage.token);
      print(query);
      print(response.statusMessage);
      print(response.data);

      return ProductsModel.fromJson(response.data);

    } on Exception catch (e) {
      print('errorss: $e');
    }
    return productModel;
  }

  static  Future<ProductsModel?> updateBusinessProduct(BuildContext context,
      String query,
      String categoryName, String name, String price,
      String oldPrice, String whatsAppNumber, String status, String governmentId, String cityId,
      String areaId, String location,
      String brandId, String longitude, String latitude, String description, String optionRequestBusiness,
      String optionValueBusiness) async {

    ProductsModel? productModel;

    print('response status');
    print(AppLocalStorage.token);
    print(name);
    print(query);
    print(price);
    print(oldPrice);
    print(whatsAppNumber);
    print(description);
    print(location);
    print(governmentId);
    print(cityId);
    print(price);
    print(longitude);
    print(latitude);
    print(optionValueBusiness);
    print(optionRequestBusiness);

    try {

      Map<String, dynamic> _data = {};
      _data = {
        "name"            :  name ,
        "product_id"      :  query ,
        "price"           :  price,
        "old_price"       :  oldPrice,
        "whats_number": whatsAppNumber,
        "description"     :  description ,
        "location"        : location,
        "country_id"  : governmentId,
        "state_id"         : cityId,
        //  "area_id"         : areaId,
        "status"          : status,
        //  "brand_id"        : brandId,
        "longitude": longitude,
        "latitude": latitude,
        'options[BusinessType]' : optionValueBusiness,
        'options_ar[BusinessType]' : optionRequestBusiness,
      };
      Response response = await DioHelper.postData(uri: ApiConstants.updateProduct,token: AppLocalStorage.token,data:
      FormData.fromMap(_data));
      print('response status');
      print(response.statusCode);
      print(AppLocalStorage.token);
      print(query);
      print(response.data);

      return ProductsModel.fromJson(response.data);

    } on Exception catch (e) {
      print('error: $e');
    }
    return productModel;
  }



 static  Future<ResponseModel?> updateImageProduct(BuildContext context,String query,File image) async {
   ResponseModel? responseModel;
   String fileName = image.path.split('/').last;
   print('selected images');
   print(image);
   print(fileName);
   print(query);

   var fromData = FormData.fromMap({
     "image":  await MultipartFile.fromFile(image.path, filename:fileName),
   });

   try {

     Response response = await DioHelper.postUpdateImage(uri: '/product/$query${ApiConstants.updateImageProduct}',
         token: AppLocalStorage.token,
         data: fromData);


     print(response.statusCode);
     print(AppLocalStorage.token);
     print(query);
     print(response.data);

     return ResponseModel.fromJson(response.data);

     // if(response.statusCode == 200){
     //
     // }else if(response.statusCode == 404){
     //   CustomFlutterToast(response.data["data"]);
     //   CustomFlutterToast(response.data["message"]);
     // }

   } on Exception catch (e) {
     print('error: $e');
   }
   return responseModel;
 }

 static  Future<ResponseModel?> deleteImageProduct(BuildContext context,String query) async {
   ResponseModel? responseModel;
   try {
     Response response = await DioHelper.getData(uri: '/product/image/$query${ApiConstants.deleteImageProduct}',
         token: AppLocalStorage.token,);

     print(response.statusCode);
     print(AppLocalStorage.token);
     print(query);
     print(response.data);



     if(response.statusCode == 200){
       return ResponseModel.fromJson(response.data);
     }else if(response.statusCode == 404){
       customFlutterToast(response.data["status"].toString());
       customFlutterToast(response.data["message"]);
     }

   } on Exception catch (e) {
     print('error: $e');
   }
   return responseModel;
 }


}