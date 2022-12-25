import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:shop/data/webservices/api_services/my_favorite_user_service.dart';

import '../../data/models/MyFavoriteUserModel.dart';
import '../../data/models/NotificationModel.dart';
import '../../data/models/SubscribeUserModel.dart';
import '../../data/models/product_page.dart';
import '../../data/models/show_details_product_model.dart';
import '../../ui/screens/product_details_screen/product_details_screen.dart';

part 'my_favorite_user_state.dart';

class MyFavoriteUserCubit extends Cubit<MyFavoriteUserState> {
  MyFavoriteUserCubit() : super(MyFavoriteUserInitial());

  static MyFavoriteUserCubit get (BuildContext context) => BlocProvider.of(context);

  ProductPage wishSubScribeList = ProductPage.empty();

  List<MyFavoriteUserResponseModel>? myFavoriteResponseModel;

  getMyFavoriteUser(String favoriteUserId){
    emit(MyFavoriteUserLoadingState());
    MyFavoriteUserService.getMyFavoriteUser(favoriteUserId).then((value){
      myFavoriteResponseModel = value?.subscribers;
      emit(MyFavoriteUserSuccessfullyState(myFavoriteResponseModel));
    });
  }

  addSubscribeUser(String favoriteUserId){
    emit(SubscribeUserLoadingState());
    MyFavoriteUserService.setSubscribeUser(favoriteUserId).then((value){

      emit(SubscribeUserSuccessfullyState(value?.message));
    });
  }

  deleteSubscribeUser(String favoriteUserId){
    emit(SubscribeUserLoadingState());
    print('favoriteUserId');
    print(favoriteUserId);
    MyFavoriteUserService.deleteSubscribeUser(favoriteUserId).then((value){
      print('success message');
      print(value?.message);
      emit(SubscribeUserSuccessfullyState(value?.message));
    });
  }


  // toggleWishActionFilter({required ShowDetailsProductResponseModel product}) {
  //   if (wishListContainFilter(productId: product.user!.id!)) {
  //     removeFromWishListFilter(product: product);
  //   } else {
  //     addToWishListFilter(product: product);
  //   }
  // }
  //
  // addToWishListFilter({required ShowDetailsProductResponseModel product}) async {
  //   if (wishListContainFilter(productId: product.id!)) {
  //     return;
  //   } else {
  //     wishSubScribeList.productsSubscribersList.insert(0, product);
  //     emit(SubscribeUserSuccessfullyState(''));
  //      await addSubscribeUser(product.id!.toString());
  //     wishSubScribeList.productsSubscribersList.removeWhere((element) => element.id == product.id);
  //     emit(SubscribeUserSuccessfullyState(''));
  //   }
  // }
  //
  // removeFromWishListFilter({required ShowDetailsProductResponseModel product}) async {
  //   if (wishListContainFilter(productId: product.user!.id!)) {
  //     int oldIndex = wishSubScribeList.productsSubscribersList.indexWhere((element) => element.id == product.id);
  //     wishSubScribeList.productsSubscribersList.removeWhere((element) => element.id == product.id);
  //     emit(SubscribeUserSuccessfullyState(''));
  //     await deleteSubscribeUser(product.id!.toString());
  //     wishSubScribeList.productsSubscribersList.insert(oldIndex, product);
  //     emit(SubscribeUserSuccessfullyState(''));
  //   } else {
  //     return;
  //   }
  // }
  //
  //
  // bool wishListContainFilter({required int productId}) {
  //   bool ret = false;
  //   for (var element in wishSubScribeList.productsSubscribersList) {
  //     if (element.id == productId) {
  //       ret = true;
  //     }
  //   }
  //   return ret;
  // }

}
