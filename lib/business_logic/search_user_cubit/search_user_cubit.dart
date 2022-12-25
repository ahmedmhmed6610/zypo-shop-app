import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shop/data/models/SearchModel.dart';
import 'package:shop/data/webservices/api_services/home_services.dart';
import 'package:shop/data/webservices/api_services/search_user_serives.dart';

import '../../data/models/product_page.dart';
import '../../helpers/app_local_storage.dart';

part 'search_user_state.dart';

class SearchUserCubit extends Cubit<SearchUserState> {
  SearchUserCubit() : super(SearchUserInitial());

  // SearchModel? searchModel;
  // SearchModel? searchModel;
  // getUserSearch(String name){
  //   emit(SearchUserLoading());
  //   SearchUserService.searchUser(name,"").then((value){
  //     searchModel = value;
  //     emit(SearchUserSuccess(value));
  //   }).catchError((onError){
  //     emit(SearchUserError('error'));
  //   });
  // }

  ProductPage recommendationProducts = ProductPage.empty();

  getSearchProducts({bool refresh = false,String? categoryId,String? nameText}) async{
    //   print("getMyProductUser");
    List<Data>?  _products = [];
    if (refresh) {
      recommendationProducts = ProductPage.empty();
    }
    if (recommendationProducts.currentPage != 0) {
      if (recommendationProducts.currentPage >=
          recommendationProducts.totalPages!) {
        return;
      }
    }
    recommendationProducts.currentPage != 0
        ? recommendationProducts.loadingPagination = true
        : recommendationProducts.loadingProducts = true;
    emit(SearchUserLoading());
    recommendationProducts.currentPage++;
    await HomeServices.getSearchProductsFromAPI(
      categoryId: categoryId,
      name: nameText,
      query: {'page': recommendationProducts.currentPage},
    ).then((value) {
      print('currentPage');
      print(recommendationProducts.currentPage);
      var data = value.data['data'];
      print('currentPage');
      print(data);
      print(value.data['data']);
      _products!.clear();
      if (data.isNotEmpty) {
        print("products $value \n ${value.data}");
        print('token response ${AppLocalStorage.token}');
        print('token response ${value.data['data']}');
        print('token response list $data');
        value.data['data'].forEach((element) {
          _products!.add(Data.fromJson(element));
        });
      } else {
        // print('list is empty');
        _products = [];
      }
      recommendationProducts.totalPages = value.data["meta"]["last_page"];
      if (_products!.isNotEmpty) {
        recommendationProducts.data!.addAll(_products!);
      }
      print("myProducts ${recommendationProducts.products[0].name}");
      recommendationProducts.loadingPagination = false;
      recommendationProducts.loadingProducts = false;
      emit(SearchUserSuccessDone(recommendationProducts.data));
      if (recommendationProducts.currentPage !=
          recommendationProducts.totalPages) {
        getSearchProducts();
      }
    }).catchError((e) {
      print("myProducts $e");
      print("token response error $e");
      recommendationProducts.loadingPagination = false;
      recommendationProducts.loadingProducts = false;
      emit(SearchUserError(e.toString()));
    });

  }

}
