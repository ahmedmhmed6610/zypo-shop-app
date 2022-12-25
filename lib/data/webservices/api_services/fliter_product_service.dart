
// ignore_for_file: unnecessary_null_comparison

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shop/data/models/mapLocationModel.dart';

import '../../../helpers/dio_helper.dart';
import '../../../ui/base/custom_toast.dart';
import '../../models/MyProductUserModel.dart';
import '../api_constants.dart';

class FilterProductService {

  static Future<MyProductUserModel?> getOptionOfCategory (
      String categoryId,
      String categoryName,
      String subCategoryId,
      String brandId,
      String governmentId,
      String cityId,
      String areaId,
      String priceMin,
      String priceMax,
      String status,
      String latitude,
      String longitude,
      String float,
      ///option Vehicles
      String optionValueFuelType,
      String optionValueYear,
      String optionValueKiloMeter,
      String optionValueTransmissionType,
      String optionValueColorType,
      String optionValueBodyType,
      String optionValueEngineCapacityType,
      String optionValueModelBrand,
      ///option  properties
      String optionValueTypeApartment,
      String optionValueDownPayment,
      String optionValueAmenities,
      String optionValueBedroom,
      String optionValueBathroom,
      String optionValueArea,
      String optionValueLevel,
      String optionValueFurnished,
      String optionValueStatus,
      /// Electronics
      String optionValueWarranty,
      /// Home Furniture
      String optionValueFurniture,
      /// Home Fashion
      String optionValueHomeFashion,
      /// Books
      String optionValueBooks,
      /// Kids
      String optionValueKids,
      /// Business
      String optionValueBusiness,) async {
    MyProductUserModel? optionModel;
    try{

      // print('categoryId is ');
      // print(categoryId);
      // print(categoryName);
      // print(status);

      if(categoryName.contains('Vehicles')){
        print("OOOOOOOOOOOOOOOO");
      // var optionValueYearList = optionValueYear.split('-');
      //
      // var optionValueFromYear = optionValueYearList[0].trim();
      //   print("xxxxxxxxxxxxxxxxxxxx");
      // var optionValueToYear = optionValueYearList[0].trim();
      //   print("yyyyyyyyyyyyyyyyyyyyyyyyyyy");
      // var optionValueKiloMeterList = optionValueKiloMeter.split('-');
      //   print("hhhhhhhhhhhhhhhhhhhhhhhhhhhhh");
      // var optionValueFromKiloMeter = optionValueKiloMeterList[0].trim();
      // var optionValueToKiloMeter = optionValueKiloMeterList[0].trim();
        print('filter search Vehicles product service');
        if (kDebugMode) {
          print('filter search Vehicles product service');
          print('categoryName $categoryId');
          print('categoryName $categoryName');
          print('subCategoryId $subCategoryId');
          print('optionValueFuelType $optionValueFuelType');
          print('optionValueYear $optionValueYear');
          print('optionValueKiloMeter $optionValueKiloMeter');
          print('optionValueTransmissionType $optionValueTransmissionType');
          print('optionValueColorType $optionValueColorType');
          print('optionValueBodyType $optionValueBodyType');
          print('optionValueEngineCapacityType $optionValueEngineCapacityType');
          print('optionValueModelBrand $optionValueModelBrand');
          print('optionValueFromYear $optionValueYear');
          print('optionValueFromKiloMeter $optionValueYear');
          print('optionValueToKiloMeter $optionValueYear');
          print('optionValueToYear $optionValueYear');
        }
        Response response = await  DioHelper.getData(uri: ApiConstants.filters,
            query :{
              'category_id' : categoryId,
              'sub_category_id' : subCategoryId,
              'brand_id' : brandId == 'null' ? '' : brandId,
              'country_id' : governmentId,
              'state_id' : cityId,
              'price_min' : priceMin == 'null' ? '' : priceMin,
              'price_max' : priceMax == 'null' ? '' : priceMax,
              'status' : status,
              'latitude  ' :  latitude == 'null' ? '' : latitude,
              'longitude ' :  longitude == 'null' ? '' : longitude,
              'float ' : float,
              optionValueFuelType == '' || optionValueFuelType == 'null'  ?  '' :
              'options[fuelType]' : optionValueFuelType,
                optionValueYear == 'null,null' ? '' : 'options[year]' : optionValueYear,
               optionValueKiloMeter == 'null,null' ? '' : 'options[kiloMeter]' : optionValueKiloMeter,
              optionValueTransmissionType == '' || optionValueTransmissionType == 'null' ?  '' :
              'options[transmissionType]' : optionValueTransmissionType,
              optionValueColorType == '' || optionValueColorType == 'null' ?  '' :
              'options[colorType]' : optionValueColorType,
              optionValueBodyType == '' || optionValueBodyType == 'null' ?  '' :
              'options[bodyType]' : optionValueBodyType,
              optionValueEngineCapacityType == '' || optionValueEngineCapacityType == 'null' ?  '' :
              'options[engineCapacity]' : optionValueEngineCapacityType,
              optionValueModelBrand == '' || optionValueModelBrand == 'null' ?  '' :
              'options[ModelCarBrand]' : optionValueModelBrand,
            });
        print("response is ${response.data}");
        if(response.statusCode == 200){
          print("response is ${response.data}");
          return MyProductUserModel.fromJson(response.data);
        }else if(response.statusCode == 404){
          customFlutterToast(response.data["message"]);
          customFlutterToast(response.data["data"]);
        }

      }
      else if(categoryName.contains('Properties')){

        if (kDebugMode) {
          print('filter search Properties product service');
          print('categoryId $categoryId');
          print('categoryName $categoryName');
          print('subCategoryId $subCategoryId');
          print('brandId $brandId');
          print('governmentId $governmentId');
          print('cityId $cityId');
          print('priceMax $priceMax');
          print('priceMin $priceMin');
          print('status $status');
          print('latitude $latitude');
          print('longitude $longitude');
          print('float $float');

          print('optionValueTypeApartment $optionValueTypeApartment');
          print('optionValueDownPayment $optionValueDownPayment');
          print('optionValueAmenities $optionValueAmenities');
          print('optionValueBedroom $optionValueBedroom');
          print('optionValueBathroom $optionValueBathroom');
          print('optionValueBodyType $optionValueBodyType');
          print('optionValueArea $optionValueArea');
          print('optionValueFurnished $optionValueFurnished');
          print('optionValueStatus $optionValueStatus');

        }

        Response response = await  DioHelper.getData(uri: ApiConstants.filters,
              query:  {
                'category_id' : categoryId,
                'sub_category_id' : subCategoryId,
             //   'brand_id' : brandId == 'null' ? '' : brandId,
                'country_id' : governmentId,
                'state_id' : cityId,
                'price_min' : priceMin == '' ? '' : priceMin,
                'price_max' : priceMax == '' ? '' : priceMax,
              //  'status' : status,
                'latitude  ' :  latitude ,
                'longitude ' :  longitude,
                'float ' : float,
                optionValueTypeApartment == '' || optionValueTypeApartment == 'null' ? '' :
                'options[TypeApartment]' : optionValueTypeApartment ,
                optionValueDownPayment == '' || optionValueDownPayment == 'null' ? '' :
                'options[DownPayment]' : optionValueDownPayment ,
                optionValueAmenities == '' || optionValueAmenities == 'null' ? '' :
                'options[Amenities]' : optionValueAmenities ,
                optionValueBedroom == '' || optionValueBedroom == 'null' ? '' :
                'options[Bedroom]' : optionValueBedroom ,
                optionValueBathroom == '' || optionValueBathroom == 'null' ? '' :
                'options[Bathroom]' : optionValueBathroom ,
                optionValueLevel == '' || optionValueLevel == 'null' ? '' :
                'options[Level]' : optionValueLevel ,
                optionValueArea == '' || optionValueArea == 'null' ? '' :
                'options[Area]' : optionValueArea ,
                // optionValueFurnished == '' || optionValueFurnished == 'ّ' ? '' :
                // 'options[Furnished]' : optionValueFurnished,
                optionValueStatus == '' || optionValueStatus == 'null' ? '' :
                'options[Status]' : optionValueStatus ,
              });

          if(response.statusCode == 200){
             print("response is ${response.data}");
            return MyProductUserModel.fromJson(response.data);
          }else if(response.statusCode == 404){
            customFlutterToast(response.data["message"]);
            customFlutterToast(response.data["data"]);
          }

        }
      else if(categoryName.contains('Electronics')){

        print('optionValueWarranty');
       print(optionValueWarranty);
       print('float');
       print(float);
        if (kDebugMode) {
          print('filter search product service');
          print('categoryId $categoryId');
          print('categoryName $categoryId');
          print('subCategoryId $subCategoryId');
          print('brandId $brandId');
          print('governmentId $governmentId');
          print('cityId $cityId');
          print('areaId $areaId');
          print('priceMin $priceMin');
          print('priceMax $priceMax');
          print('status $status');
          print('latitude $latitude');
          print('longitude $longitude');
          print('float $float');
          print('optionValueWarranty $optionValueWarranty');
        }
        Response response = await  DioHelper.getData(uri: ApiConstants.filters,
            query:  {
              'category_id' : categoryId,
              'sub_category_id' : subCategoryId,
              'brand_id' : brandId == 'null' ? '' : brandId,
              'country_id' : governmentId,
              'state_id' : cityId,
              'price_min' : priceMin == 'null' ? '' : priceMin,
              'price_max' : priceMax == 'null' ? '' : priceMax,
              'status' : status,
              'latitude  ' :  latitude == 'null' ? '' : latitude,
              'longitude ' :  longitude == 'null' ? '' : longitude,
              'float ' : float == 'null' ? '' : float,
              optionValueWarranty == 'null' || optionValueWarranty == '' ?  '' :  'options[warranty]' : optionValueWarranty
              // float.contains('') ?
              // 'float' : float : null,
            });

        if(response.statusCode == 200){
        //  print("response is ${response.data}");
          return MyProductUserModel.fromJson(response.data);
        }else if(response.statusCode == 404){
          customFlutterToast(response.data["message"]);
          customFlutterToast(response.data["data"]);
        }

      }
      else if(categoryName.contains('Fashion')){
        Response response = await  DioHelper.getData(uri: ApiConstants.filters,
            query: {
          'category_id' : categoryId,
          'sub_category_id' : subCategoryId,
          'brand_id' : brandId,
              'country_id' : governmentId,
              'state_id' : cityId,
          'price_min' : priceMin,
          'price_max' : priceMax,
          'status' : status,
          'latitude  ' : latitude,
          'longitude ' : longitude,
          'float ' : float,
          optionValueHomeFashion == '' || optionValueHomeFashion == 'null' ?  '' :  'options[HomeFashionType]' : optionValueHomeFashion
        });

        if(response.statusCode == 200){
        //  print("response is ${response.data}");
          return MyProductUserModel.fromJson(response.data);
        }else if(response.statusCode == 404){
          customFlutterToast(response.data["message"]);
          customFlutterToast(response.data["data"]);
        }

      }
      else if(categoryName.contains('Home Furniture')){
        Response response = await  DioHelper.getData(uri: ApiConstants.filters,
            query:
            {
              'category_id' : categoryId,
              'sub_category_id' : subCategoryId,
              'brand_id' : brandId,
              'country_id' : governmentId,
              'state_id' : cityId,
              'price_min' : priceMin,
              'price_max' : priceMax,
              'status' : status,
              'latitude  ' : latitude,
              'longitude ' : longitude,
              'float ' : float,
              optionValueFurniture == '' || optionValueFurniture == 'null' ?  '' :  'options[furnitureType]' : optionValueFurniture
            });

        if(response.statusCode == 200){
       //   print("response is ${response.data}");
          return MyProductUserModel.fromJson(response.data);
        }else if(response.statusCode == 404){
          customFlutterToast(response.data["message"]);
          customFlutterToast(response.data["data"]);

        }

      }
      else if(categoryName.contains('Books, Sports & Hobbies')){

        Response response = await  DioHelper.getData(uri: ApiConstants.filters,query:
        {
          'category_id' : categoryId,
          'sub_category_id' : subCategoryId,
          'brand_id' : brandId,
          'country_id' : governmentId,
          'state_id' : cityId,
          'price_min' : priceMin,
          'price_max' : priceMax,
          'status' : status,
          'latitude  ' : latitude,
          'longitude ' : longitude,
          'float ' : float,
          optionValueBooks == '' || optionValueBooks == 'null' ? '' : 'options[BooksType]' : optionValueBooks
        });

        if(response.statusCode == 200){
        //  print("response is ${response.data}");
          return MyProductUserModel.fromJson(response.data);
        }else if(response.statusCode == 404){
          customFlutterToast(response.data["message"]);
          customFlutterToast(response.data["data"]);

        }
      }
      else if(categoryName.contains('Kids & Babies')){

        Response response = await  DioHelper.getData(uri: ApiConstants.filters,query:
        {
          'category_id' : categoryId,
          'sub_category_id' : subCategoryId,
          'brand_id' : brandId,
          'country_id' : governmentId,
          'state_id' : cityId,
          'price_min' : priceMin,
          'price_max' : priceMax,
          'status' : status,
          'latitude  ' : latitude,
          'longitude ' : longitude,
          'float ' : float,
          optionValueKids == '' || optionValueKids == 'null' ? '' : 'options[KidsType]' : optionValueKids
        });

        if(response.statusCode == 200){
        //  print("response is ${response.data}");
          return MyProductUserModel.fromJson(response.data);
        }else if(response.statusCode == 404){
          customFlutterToast(response.data["message"]);
          customFlutterToast(response.data["data"]);
        }

      }
      else if(categoryName.contains('Business - Industrial - Agriculture')){

        Response response = await  DioHelper.getData(uri: ApiConstants.filters,query:
        {
          'category_id' : categoryId,
          'sub_category_id' : subCategoryId,
          'brand_id' : brandId,
          'country_id' : governmentId,
          'state_id' : cityId,
          'price_min' : priceMin,
          'price_max' : priceMax,
          'status' : status,
          'latitude  ' : latitude,
          'longitude ' : longitude,
          'float ' : float,
          optionValueBusiness == '' || optionValueBusiness == 'null' ? '' : 'options[BusinessType]' : optionValueBusiness
        });

        if(response.statusCode == 200){
         // print("response is ${response.data}");
          return MyProductUserModel.fromJson(response.data);
        }else if(response.statusCode == 404){
          customFlutterToast(response.data["message"]);
          customFlutterToast(response.data["data"]);
        }

      }


    }on DioError catch(e){
      print('Dio error!');
      print('STATUS: ${e.response?.statusCode}');
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
    return optionModel;

  }

  static Future<MyProductUserModel?> getUserProducts (String productId) async {
    MyProductUserModel? optionModel;
    try{

      Response response = await  DioHelper.getData(uri: '/users/$productId/products',);

      if(response.statusCode == 200){
     //   print("response is ${response.data}");
        return MyProductUserModel.fromJson(response.data);
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

  static Future<MapLocationModel?> getLocationFromMap (String governorate,String city,String area) async {
    MapLocationModel? mapLocationModel;
    try{

      if (kDebugMode) {
        print('filter search location service');
        print('categoryId $governorate');
        print('categoryName $city');
        print('subCategoryId $area');
      }
      Response response = await  DioHelper.getData(uri: ApiConstants.getLocation,
          query:  {
            'governorate' : governorate,
            'city' : city,
            'area' : area,
          });

      if(response.statusCode == 200){
        //   print("response is ${response.data}");
        return MapLocationModel.fromJson(response.data);
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
    return mapLocationModel;

  }

}