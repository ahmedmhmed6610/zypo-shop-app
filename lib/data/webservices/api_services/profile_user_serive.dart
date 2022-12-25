
// ignore_for_file: avoid_print

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:shop/data/models/login_model.dart';
import 'package:shop/data/webservices/api_constants.dart';
import 'package:shop/helpers/dio_helper.dart';

import '../../../helpers/app_local_storage.dart';
import '../../models/response_user_model.dart';

class ProfileUserService {

  static Future<LoginModel?> checkProfileDetails() async {
    LoginModel? loginModel;
    try {

      Response response = await DioHelper.postData(uri: ApiConstants.profileUser,token: AppLocalStorage.token);

      print('token is response ${AppLocalStorage.token}');
      print('token is response ${response.statusCode}');
      print('token is response ${response.data}');
      return LoginModel.fromJson(response.data);

    } on DioError catch (e) {
      if (e.response != null) {
        print('Dio error!');
        print('STATUS: ${e.response?.statusCode}');
        print('DATA: ${e.response?.data}');
        print('DATA: ${e.response?.statusMessage}');
        print('HEADERS: ${e.response?.headers}');
      } else {
        // Error due to setting up or sending the request
        print('Error sending request!');
        print(e.message);
      }
    }
    return loginModel;
  }

  static Future<ResponseModel?> updateProfileUser(
  {firstName,
     lastName,
     email,
     phoneNumber,
     image}
) async {
    ResponseModel? responseModel;
  //  String fileName = image.path.split('/').last;

    // print('selected images');
    // print(image);
    // print(photoUser);
    // print(fileName);
    // print(fileNameUser);

    var fromData = FormData.fromMap({
      "first_name": firstName,
      "last_name": lastName,
      "email": email,
      "phone_number": phoneNumber,
  //    "photo": await MultipartFile.fromFile(image.path, filename:fileName)
     // "photo": null
    });

    try {
      Response response = await DioHelper.postData(uri: ApiConstants.updateProfileUser,
          data: fromData,token: AppLocalStorage.token);

      return ResponseModel.fromJson(response.data);

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
    return responseModel;
  }

  static Future<ResponseModel?> updateProfileImageUser(
      String firstName,
      String lastName,String email, String phoneNumber,File photo
      ) async {
    ResponseModel? responseModel;
      String fileName = photo.path.split('/').last;

    // print('selected images');
    // print(image);
    // print(photoUser);
    // print(fileName);
    // print(fileNameUser);

    var fromData = FormData.fromMap({
      "first_name": firstName,
      "last_name": lastName,
      "email": email,
      "phone_number": phoneNumber,
      "photo": await MultipartFile.fromFile(photo.path, filename:fileName)
    });

    try {
      Response response = await DioHelper.postData(uri: ApiConstants.updateProfileUser,
          data: fromData,token: AppLocalStorage.token);

      return ResponseModel.fromJson(response.data);

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
    return responseModel;
  }

 }