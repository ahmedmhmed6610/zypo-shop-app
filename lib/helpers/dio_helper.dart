import 'package:dio/dio.dart';
import '../utils/app_constants.dart';
import 'logger_helper.dart';

class DioHelper {

  static late Dio dio;
  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: AppConstants.baseUrl,
        receiveDataWhenStatusError: true,
        //to skip exception and continue in code
        validateStatus: (int? status) => true,
      ),
    );
  }

  static Future<dynamic> getData(
      {required String uri,
      String lang = 'de',
      String? token,
      dynamic query}) async {
     LoggerHelper.loggerNoStack.i('Api Call : ' + uri);
    dio.options.headers = (token != null
        ? {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          }
        : {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          });
    return await dio.get(uri, queryParameters: query,options: Options(
      receiveTimeout: 50000,
      sendTimeout: 50000,));
  }

  static Future<dynamic> postData(
      {required String uri,
      dynamic data,
      String lang = 'de',
      String? token = '',
      Map<String, dynamic>? query}) async {
     LoggerHelper.loggerNoStack.i('Api Call : ' + uri);
    if (token!.isNotEmpty) {
      dio.options.headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ' + token,
      };
    } else {
      dio.options.headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };
    }

    return await dio.post(uri, data: data, queryParameters: query,options: Options(
      receiveTimeout: 2000000,
      sendTimeout: 2000000,
    ));
  }

  static Future<dynamic> postUpdateImage(
      {required String uri,
        dynamic data,
        String lang = 'de',
        String? token = '',
        Map<String, dynamic>? query}) async {
    LoggerHelper.loggerNoStack.i('Api Call : ' + uri);
    if (token!.isNotEmpty) {
      dio.options.headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ' + token,
      };
    } else {
      dio.options.headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };
    }

    return await dio.post(uri, data: data, queryParameters: query,options: Options(
      receiveTimeout: 50000,
      sendTimeout: 50000,
    ));
  }

  static Future<dynamic> deleteData(
      {required String uri,
      dynamic data,
      String? token = '',
      Map<String, dynamic>? query}) async {
    // LoggerHelper.loggerNoStack.i('Api Call : ' + uri);
    if (token!.isNotEmpty) {
      dio.options.headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ' + token,
      };
    } else {
      dio.options.headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };
    }
    return dio.delete(uri, data: data, queryParameters: query,options: Options(
      receiveTimeout: 50000,
      sendTimeout: 50000,
    ));
  }

  static Future<dynamic> putData(
      {required String uri,
      Map<String, dynamic>? data,
        String? token = '',
      String lang = 'de',
      Map<String, dynamic>? query}) async {
    LoggerHelper.loggerNoStack.i('Api Call :' + uri);
    if (token!.isNotEmpty) {
      dio.options.headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ' + token,
      };
    } else {
      dio.options.headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };
    }
    return dio.put(uri, data: data, queryParameters: query,options: Options(
      receiveTimeout: 50000,
      sendTimeout: 50000,
    ));
  }
}
