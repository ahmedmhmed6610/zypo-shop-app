import 'package:dio/dio.dart';
import 'package:shop/data/models/product_model.dart';
import 'package:shop/data/webservices/api_constants.dart';
import 'package:shop/helpers/dio_helper.dart';
import 'package:shop/ui/base/custom_toast.dart';
import '../../../helpers/app_local_storage.dart';
import '../../models/slider_model.dart';

mixin HomeServices{
  // recommendationProductsUrl
  var data = [];
  List<ProductModel> results = [];
  Future getRecommendationProductsFromAPI({Map<String, dynamic>? query,String? querySearch}) async {
    return await DioHelper.getData(
      uri: ApiConstants.recommendationProductsUrl,
      query: query,
    );
  }


 static Future getMyProductsFromAPI({Map<String, dynamic>? query,String? querySearch}) async {
    return await DioHelper.getData(
      uri: ApiConstants.myProductUrl,
      query: query,
      token: AppLocalStorage.token
    );
  }

  static Future getSearchProductsFromAPI({Map<String, dynamic>? query,String? categoryId,String? name}) async {

    var fromData = FormData.fromMap({
      "name": name,
      "category_id": categoryId,
    });

    return await DioHelper.postData(
        uri: ApiConstants.searchUser,
        query: query,
        data: fromData,
        token: AppLocalStorage.token
    );
  }


  static Future<SliderModel?> getSlider() async {
    SliderModel? loginModel;
    try {
      // Response response = await Dio().get(AppConstants.baseUrl + ApiConstants.profileUser,
      //     options:
      //     Options(headers: {'Authorization': 'Bearer ${globals.token}'  },sendTimeout: 10000,receiveTimeout: 10000));

      Response response = await DioHelper.getData(uri: ApiConstants.slider);


      if(response.statusCode == 200){
        return SliderModel.fromJson(response.data);
      }else {
        customFlutterToast(response.statusMessage);
      }

    } on DioError catch (e) {
      if (e.response != null) {
        // print('Dio error!');
        // print('STATUS: ${e.response?.statusCode}');
        // print('DATA: ${e.response?.data}');
        // print('DATA: ${e.response?.statusMessage}');
        // print('HEADERS: ${e.response?.headers}');
      } else {
        // Error due to setting up or sending the request
        // print('Error sending request!');
        // print(e.message);
      }
    }
    return loginModel;
  }

}