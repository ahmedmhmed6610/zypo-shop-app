
// ignore_for_file: avoid_print

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shop/data/models/login_model.dart';
import 'package:shop/data/webservices/api_constants.dart';
import 'package:shop/helpers/dio_helper.dart';

import '../../../helpers/app_local_storage.dart';
import '../../models/banner_response_model.dart';
import '../../models/response_user_model.dart';

class AddAdsProductService {


  static Future<BannerResponseModel?> addAdsProductUser(
      BuildContext context,
     // String text,
      String link,
      File image) async {
    BannerResponseModel? responseModel;

    String fileName = image.path.split('/').last;

    print('selected images');
    print(image);
    print(fileName);
    print(AppLocalStorage.token);

    var fromData = FormData.fromMap({
      "link": link,
      "image":  await MultipartFile.fromFile(image.path, filename:fileName),
    });

    try {
      Response response = await DioHelper.postData(uri: ApiConstants.addAdsProduct,data: fromData,token: AppLocalStorage.token);

      print('response ads is ${response.data}');
      return BannerResponseModel.fromJson(response.data);

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