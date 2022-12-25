import 'package:shop/data/webservices/api_constants.dart';
import 'package:shop/helpers/dio_helper.dart';

import '../../../helpers/app_local_storage.dart';

mixin WishListServices {
  Future getWishListFromApi({Map<String, dynamic>? query}) async {
    return await DioHelper.getData(
        uri: ApiConstants.userFavoritesUrl, query: query, token: AppLocalStorage.token);
  }

  Future addProductToFavouriteFromApi({required int productId}) async {
    return await DioHelper.postData(
        uri: ApiConstants.addProductToFavoriteUrl,
        data: {"product_id": productId},
        token: AppLocalStorage.token);
  }

  Future removeProductFromFavouriteFromApi({required int productId}) async {
    return await DioHelper.postData(
        uri: ApiConstants.removeProductFromFavoriteUrl,
        data: {"product_id": productId},
        token: AppLocalStorage.token);
  }
  // static const addProductToFavoriteUrl = "/add/product/favorites";
  // static const removeProductFromFavoriteUrl = "/remove/product/favorites";
}
