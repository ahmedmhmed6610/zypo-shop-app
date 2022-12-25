import 'package:dio/dio.dart';
import 'package:shop/data/models/response_user_model.dart';
import 'package:shop/data/webservices/api_constants.dart';
import 'package:shop/helpers/app_local_storage.dart';
import 'package:shop/helpers/dio_helper.dart';
import 'package:shop/ui/base/custom_toast.dart';
import '../../models/login_model.dart';

mixin AuthServices {
  static const String baseUrl = 'http://shop-crm.germaniatek.net/api';


  static Future<ResponseModel?> registerUserAndSendOtp(
   String firstName,
   String lastName,
   String email,
   String phoneNumber,
   String password,
   String cPassword) async {
    ResponseModel? responseModel;
    var fromData = FormData.fromMap({
      "email": email,
      "phone_number": phoneNumber,
      "password": password,
      "c_password": cPassword,
      'first_name' : firstName,
      'last_name' : lastName
    });
    try {
      Response response = await DioHelper.postData(uri: ApiConstants.registerUrl,data: fromData);

      if(response.statusCode == 200){
        return ResponseModel.fromJson(response.data);
      }else if (response.statusCode == 404){
       // CustomFlutterToast(response.data["success"].toString());
        customFlutterToast(response.data["message"]);
        customFlutterToast(response.data["data"]);
      //  CustomFlutterToast(response.statusCode.toString());
      }

      // Response response = await Dio().post(baseUrl +ApiConstants.loginUrl, data: fromData,options: Options(
      //     receiveTimeout: 10000,
      //     sendTimeout: 10000
      // ));


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

  // Future registerAndSendOtp(
  //     {required String userName,
  //     required String email,
  //     required String phoneNumber,
  //     required String password}) async {
  //   return await DioHelper.postData(
  //     uri: ApiConstants.registerUrl,
  //     data: {
  //       "user_name": userName,
  //       "email": email,
  //       "phone_number": phoneNumber,
  //       "password": password
  //     },
  //   );
  // }

  static Future<LoginModel?> checkLoginUser(
      String phoneNumber, String password) async {
    LoginModel? loginUserModel;

    var fromData = FormData.fromMap({
      'phone_number': phoneNumber,
      'password': password,
    });

    try {
      Response response = await DioHelper.postData(uri: ApiConstants.loginUrl,data: fromData);
      // print(phoneNumber);
      // print(password);
       print(response.data);
      // print(response.statusCode);
      if(response.statusCode == 200){
        return LoginModel.fromJson(response.data);
      }else if(response.statusCode == 404){
       //  CustomFlutterToast(response.data["success"].toString());
         customFlutterToast(response.data["message"].toString());
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
    return loginUserModel;
  }

  static Future<ResponseModel?> updateFcmToken(
      String? fcmToken) async {
    ResponseModel? responseModel;
    var fromData = FormData.fromMap({
      'fcm_token': fcmToken,
    });

    try {
      Response response = await DioHelper.postData(uri: ApiConstants.updateFCMTokenUri,data: fromData,token: AppLocalStorage.token);
      // print('fcmToken');
      // print(fcmToken);
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

  static Future<ResponseModel?> verifySupervisorOtpNetWork(
      String phoneNumber, String code) async {
    ResponseModel? responseModel;

    var fromData = FormData.fromMap({"phone": phoneNumber, "otp": code});

    try {
      Response response = await DioHelper.postData(uri: ApiConstants.verifyUrl,data: fromData);
      // print(phoneNumber);
      // print(code);
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

  static Future<ResponseModel?> resendCodeAgainOtpNetWork({required String phoneNumber}) async{
    ResponseModel? responseModel;

    FormData data = FormData.fromMap({
      "phone_number" : phoneNumber
    });

    try{

      Response response = await DioHelper.postData(
          uri: ApiConstants.resendVerifyCode, data: data);

      if(response.statusCode == 200){
        return ResponseModel.fromJson(response.data);
      }else {
        customFlutterToast(response.data["message"]);
        customFlutterToast(response.data["success"].toString());
        customFlutterToast(response.data["data"].toString());
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

    return responseModel;
  }



  // Future verifySupervisorOtpNetWork(String phoneNumber, String code) async {
  //   return await DioHelper.postData(
  //     uri: ApiConstants.verifyUrl,
  //     data: {"phone": phoneNumber, "otp": code},
  //   );
  // }

 static Future<ResponseModel?> forgetPasswordNetWork({required String phoneNumber}) async{
    ResponseModel? responseModel;

    FormData data = FormData.fromMap({
      "phone" : phoneNumber
    });

    try{

      Response response = await DioHelper.postData(
          uri: ApiConstants.forgotPasswordUrl, data: data);

      if(response.statusCode == 200){
        return ResponseModel.fromJson(response.data);
      }else {
        customFlutterToast(response.data["message"]);
        customFlutterToast(response.data["success"]);
        customFlutterToast(response.data["data"]);
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

    return responseModel;
  }



  static Future<ResponseModel?> confirmPasswordOTPNetWork({required String phoneNumber , required String code}) async{
    ResponseModel? responseModel;

    FormData data = FormData.fromMap({"phone": phoneNumber, "reset_token": code});

    try{

      Response response = await DioHelper.postData(
          uri: ApiConstants.confirmPasswordOTPUrl, data: data);

      if(response.statusCode == 200){
        return ResponseModel.fromJson(response.data);
      }else {
        customFlutterToast(response.data["message"]);
        customFlutterToast(response.data["success"]);
        customFlutterToast(response.data["data"]);
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

    return responseModel;
  }

  static Future<ResponseModel?> resetPasswordNetWork({ required  String? phoneNumber,
    required String? code,
    required String password}) async{
    ResponseModel? responseModel;

    try{

      Response response = await DioHelper.postData(
        uri: ApiConstants.resetPasswordUrl,
        data: {
          "phone": phoneNumber,
          "reset_token": code,
          "password": password,
          "confirm_password": password,
        },
      );

      if(response.statusCode == 200){
        return ResponseModel.fromJson(response.data);
      }else {
        customFlutterToast(response.data["message"]);
        customFlutterToast(response.data["success"]);
        customFlutterToast(response.data["data"]);
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

    return responseModel;
  }

}
