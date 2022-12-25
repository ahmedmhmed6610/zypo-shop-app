import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/data/models/product_model.dart';
import 'package:shop/data/models/product_page.dart';
import 'package:shop/data/webservices/api_services/home_services.dart';

import '../../data/models/MyProductUserModel.dart';
import '../../data/models/SearchModel.dart';
import '../../data/models/slider_model.dart';
import '../../data/webservices/api_services/search_user_serives.dart';
import '../../ui/base/custom_toast.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> with HomeServices {
  HomeCubit() : super(HomeInitial()) {
    getRecommendationProducts();
    getSliderHome();
  }

  static HomeCubit get(BuildContext context) => BlocProvider.of(context);


  List<SliderResponseModel>? sliderResponseModel;
  bool isLoadingValue = false;

  getSliderHome (){
  //  print('loading slider is');
   // isLoadingValue = true;
    emit(SliderLoadingState());
    HomeServices.getSlider().then((value){
      sliderResponseModel = value?.sliderResponseModel;
      print('list slider');
      print('list slider ${sliderResponseModel!.length}');
      print('${sliderResponseModel!.length}');
      emit(SliderSuccessState(value?.sliderResponseModel));
    }).catchError((onError){
    //  print('error is ${onError.toString()}');
      emit(SliderErrorState(onError.toString()));
    });
  }

  ProductPage recommendationProducts = ProductPage.empty();

  SearchModel? searchModel;
  MyProductUserModel? myProductUserModel;
  getUserSearch(String name,String categoryId){
    emit(SearchUserLoading());
    SearchUserService.searchUser(name,categoryId).then((value){
      myProductUserModel = value;
      emit(SearchUserSuccess(value));
    });
  }


  getRecommendationProducts({bool refresh = false}) async {
    List<ProductModel> _products = [];

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
    emit(RecommendationProductsLoadingState());
    recommendationProducts.currentPage++;
    await getRecommendationProductsFromAPI(
      query: {'page': recommendationProducts.currentPage.toString()},
    ).then((value) {
      var data = value.data['data'];
      print('currentPage');
      print(recommendationProducts.currentPage);
      print(data);

      _products.clear();
      if (data.isNotEmpty) {
        // print("products $value \n ${value.data}");
        // print('token response ${AppLocalStorage.token}');
        // print('token response ${value.data['data']}');
        // print('token response list $data');
        value.data['data'].forEach((element) {
          _products.add(ProductModel.fromJson(element));
        });
      } else {
       // print('list is empty');
        _products = [];
      }
      recommendationProducts.totalPages = value.data["meta"]["last_page"];
      if (_products.isNotEmpty) {
        recommendationProducts.products.addAll(_products);
      }
     // print("myProducts ${recommendationProducts.products[0].name}");
      recommendationProducts.loadingPagination = false;
      recommendationProducts.loadingProducts = false;
      emit(RecommendationProductsSuccessState());
      if (recommendationProducts.currentPage !=
          recommendationProducts.totalPages) {
        getRecommendationProducts();
      }
    }).catchError((e) {
      // print("myProducts $e");
      // print("token response error $e");
      recommendationProducts.loadingPagination = false;
      recommendationProducts.loadingProducts = false;
      emit(RecommendationProductsErrorState(error: e.toString()));

    });
  }
  // getRecommendationProductsFromAPI()
}
