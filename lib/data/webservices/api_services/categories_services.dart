import 'package:shop/data/webservices/api_constants.dart';
import 'package:shop/helpers/dio_helper.dart';

mixin CategoriesServices {
  Future getParentCategoriesFromAPI() async {
    return await DioHelper.getData(
      uri: ApiConstants.categoriesUrl,
    );
  }

  Future getSubCatsByCategoryAPI({
    required int parentID,
  }) async {
    return await DioHelper.getData(
      uri: "${ApiConstants.categoriesUrl}/$parentID/subcats",
    );
  }

  Future getBrandsByCategoryAPI({
    required int parentID,
  }) async {
    return await DioHelper.getData(
      uri: "${ApiConstants.categoriesUrl}/$parentID/brands",
    );
  }

  Future getProductsByCategoryAPI(
      {required int parentID, Map<String, dynamic>? query}) async {
    return await DioHelper.getData(
        uri: "${ApiConstants.categoriesUrl}/$parentID/products", query: query);
  }
}
