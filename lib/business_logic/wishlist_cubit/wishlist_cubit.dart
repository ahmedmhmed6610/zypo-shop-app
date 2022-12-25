import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/data/models/MyProductUserModel.dart';
import 'package:shop/business_logic/wishlist_cubit/wishlist_state.dart';
import 'package:shop/data/models/product_model.dart';
import 'package:shop/data/models/product_page.dart';
import 'package:shop/data/webservices/api_services/wishlist_services.dart';

class WishlistCubit extends Cubit<WishlistState> with WishListServices {
  WishlistCubit() : super(WishlistInitial()) {
    getWishList();
  }
  static WishlistCubit get(BuildContext context) => BlocProvider.of(context);
  ProductPage wishList = ProductPage.empty();
  // List<ProductModel> wishList = [
  //   products[0],
  // ];

  getWishList({bool refresh = false}) async {
    List<ProductModel> _products = [];
    if (refresh) {
      wishList = ProductPage.empty();
    }
    if (wishList.currentPage != 0) {
      if (wishList.currentPage >= wishList.totalPages!) {
        return;
      }
    }
    wishList.currentPage != 0
        ? wishList.loadingPagination = true
        : wishList.loadingProducts = true;
    emit(WishListLoadingState());
    wishList.currentPage++;
    await getWishListFromApi(
      query: {'page': wishList.currentPage},
    ).then((value) {
     // print("products $value \n ${value.data}");
      var data = value.data['data'];
      _products.clear();
      if (data.isNotEmpty) {
        data.forEach((element) {
          _products.add(ProductModel.fromJson(element["product"]));
        });
      } else {
        _products = [];
      }
      wishList.totalPages = value.data["meta"]["last_page"];
      if (_products.isNotEmpty) {
        wishList.products.addAll(_products);
      }
    //  print("myProducts ${wishList.products.length}");
      wishList.loadingPagination = false;
      wishList.loadingProducts = false;
      emit(WishListSuccessState());
      if (wishList.currentPage != wishList.totalPages) {
        getWishList();
      }
    }).catchError((e) {
    //  print("myProducts $e");
      wishList.loadingPagination = false;
      wishList.loadingProducts = false;
      emit(WishListErrorState(error: e.toString()));
    });
  }

  toggleWishAction({required ProductModel product}) {
    if (wishListContain(productId: product.id!)) {
      removeFromWishList(product: product);
    } else {
      addToWishList(product: product);
    }
  }

  addToWishList({required ProductModel product}) async {
    if (wishListContain(productId: product.id!)) {
      return;
    } else {
      wishList.products.insert(0, product);
      emit(AddProductToWishList());
      var response = await addProductToFavouriteFromApi(productId: product.id!);
      if (!response.data["success"]) {
        wishList.products.removeWhere((element) => element.id == product.id);
        emit(AddProductToWishList());
      }
    }
  }

  removeFromWishList({required ProductModel product}) async {
    if (wishListContain(productId: product.id!)) {
      int oldIndex =
      wishList.products.indexWhere((element) => element.id == product.id);
      wishList.products.removeWhere((element) => element.id == product.id);
      emit(RemoveProductFromWishList());
      var response =
      await removeProductFromFavouriteFromApi(productId: product.id!);
      if (!response.data["success"]) {
        wishList.products.insert(oldIndex, product);
        emit(RemoveProductFromWishList());
      }
    } else {
      return;
    }
  }



  toggleWishActionFilter({required MyProductUserResponseModel? product}) {
    if (wishListContain(productId: product!.id!)) {
      removeFromWishListFilter(product: product);
    } else {
      addToWishListFilter(product: product);
    }
  }

  addToWishListFilter({required MyProductUserResponseModel product}) async {
    if (wishListContainFilter(productId: product.id!)) {
      return;
    } else {
      wishList.productsList.insert(0, product);
      emit(AddProductToWishList());
      var response = await addProductToFavouriteFromApi(productId: product.id!);
      if (!response.data["success"]) {
        wishList.products.removeWhere((element) => element.id == product.id);
        emit(AddProductToWishList());
      }
    }
  }


  removeFromWishListFilter({required MyProductUserResponseModel product}) async {
    if (wishListContain(productId: product.id!)) {
      int oldIndex =
      wishList.productsList.indexWhere((element) => element.id == product.id);
      wishList.productsList.removeWhere((element) => element.id == product.id);
      emit(RemoveProductFromWishList());
      var response =
      await removeProductFromFavouriteFromApi(productId: product.id!);
      if (!response.data["success"]) {
        wishList.productsList.insert(oldIndex, product);
        emit(RemoveProductFromWishList());
      }
    } else {
      return;
    }
  }


  bool wishListContain({required int? productId}) {
    bool ret = false;
    for (var element in wishList.products) {
      if (element.id == productId) {
        ret = true;
      }
    }
    return ret;
  }



  bool wishListContainFilter({required int productId}) {
    bool ret = false;
    for (var element in wishList.products) {
      if (element.id == productId) {
        ret = true;
      }
    }
    return ret;
  }
}
