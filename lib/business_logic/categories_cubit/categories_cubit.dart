import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/data/models/brand_model.dart';
import 'package:shop/data/models/brand_page.dart';
import 'package:shop/data/models/category_model.dart';
import 'package:shop/data/models/category_page.dart';
import 'package:shop/data/models/product_model.dart';
import 'package:shop/data/models/product_page.dart';
import 'package:shop/data/webservices/api_services/categories_services.dart';

import '../../ui/base/custom_toast.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> with CategoriesServices {
  CategoriesCubit() : super(CategoriesInitial());
  static CategoriesCubit get(BuildContext context) => BlocProvider.of(context);
  List<CategoryModel> categories = [];
  bool parentLoading = false;
  int selectedParent = 0;

  Map<int, CategoryPage> categoriesByParent = {};
  Map<int, ProductPage> productsByCategory = {};
  Map<int, BrandPage> brandsByCategory = {};

  getParentCategories() async {
    List<CategoryModel> _parents = [];
    parentLoading = true;
    emit(ParentLoadingState());
    await getParentCategoriesFromAPI().then((value) {
      List responseParents = value.data['data'];
      _parents.clear();
      if (responseParents.isNotEmpty) {
        for (var element in responseParents) {
          _parents.add(CategoryModel.fromJson(element));
        }
      } else {
        _parents = [];
      }
      categories = _parents;
      parentLoading = false;
      emit(SuccessParentsState());
    }).catchError((e) {
      parentLoading = false;
      emit(ErrorParentsState(error: e.toString()));
      customFlutterToast('no internet connection');

    });
  }

  setSelectedParent(int parentId) {
    selectedParent = parentId;
    emit(SetSelectedParentState());
    getCategoriesByParent();
    getProductsByCategory();
    getBrandsByCategory(categoryID: parentId);
  }

  getCategoriesByParent() async {
    List<CategoryModel> _categories = [];

    if (categoriesByParent.containsKey(selectedParent)) {
      return;
    } else {
      categoriesByParent[selectedParent] = CategoryPage.empty();
    }
    categoriesByParent[selectedParent]!.loadingCategory = true;
    emit(LoadingCategoriesByParentState());
    await getSubCatsByCategoryAPI(
      parentID: selectedParent,
    ).then((value) {
      List responseCategories = value.data['data'];
      _categories.clear();
      if (responseCategories.isNotEmpty) {
        for (var element in responseCategories) {
          // if(element['status'].toString().trim()=='active') {
          _categories.add(CategoryModel.fromJson(element));
          // }
        }
      } else {
        _categories = [];
      }

      if (_categories.isNotEmpty) {
        categoriesByParent[selectedParent]!.categories.addAll(_categories);
      }
      categoriesByParent[selectedParent]!.loadingCategory = false;
      emit(SuccessCategoriesByParentState());
    }).catchError((e) {
      categoriesByParent[selectedParent]!.loadingCategory = false;
      emit(ErrorCategoriesByParentState(error: e.toString()));
    });
  }

  getBrandsByCategory({required int categoryID}) async {
    List<BrandModel> _brands = [];

    if (brandsByCategory.containsKey(categoryID)) {
      return;
    } else {
      brandsByCategory[categoryID] = BrandPage.empty();
    }
    brandsByCategory[categoryID]!.loadingBrand = true;
    emit(LoadingBrandsByCategoryState());
    await getBrandsByCategoryAPI(
      parentID: categoryID,
    ).then((value) {
      List responseBrands = value.data['data'];
      _brands.clear();
      if (responseBrands.isNotEmpty) {
        for (var element in responseBrands) {
          // if(element['status'].toString().trim()=='active') {
          _brands.add(BrandModel.fromJson(element));
          // }
        }
      } else {
        _brands = [];
      }

      if (_brands.isNotEmpty) {
        brandsByCategory[categoryID]!.brands.addAll(_brands);
      }
      brandsByCategory[categoryID]!.loadingBrand = false;
      emit(SuccessBrandsByCategoryState());
    }).catchError((e) {
      brandsByCategory[categoryID]!.loadingBrand = false;
      emit(ErrorBrandsByCategoryState(error: e.toString()));
    });
  }

  getProductsByCategory() async {
    List<ProductModel> _products = [];

    if (productsByCategory.containsKey(selectedParent)) {
      if (productsByCategory[selectedParent]!.currentPage != 0) {
        if (productsByCategory[selectedParent]!.currentPage ==
            productsByCategory[selectedParent]!.totalPages) {
          return;
        }
      }
    } else {
      productsByCategory[selectedParent] = ProductPage.empty();
    }
    productsByCategory[selectedParent]!.currentPage != 0
        ? productsByCategory[selectedParent]!.loadingPagination = true
        : productsByCategory[selectedParent]!.loadingProducts = true;
    emit(LoadingProductsByCategoryState());
    productsByCategory[selectedParent]!.currentPage++;
    await getProductsByCategoryAPI(
      parentID: selectedParent,
      query: {'page': productsByCategory[selectedParent]!.currentPage},
    ).then((value) {
      List responseProducts = value.data['data'];
      _products.clear();
      if (responseProducts.isNotEmpty) {
        for (var element in responseProducts) {
          // if(element['status'].toString().trim()=='active') {
          _products.add(ProductModel.fromJson(element));
          // }
        }
      } else {
        _products = [];
      }
      productsByCategory[selectedParent]!.totalPages =
          value.data["meta"]["last_page"];
      productsByCategory[selectedParent]!.total = value.data["meta"]['total'];
      if (_products.isNotEmpty) {
        productsByCategory[selectedParent]!.products.addAll(_products);
      }
      // else {
      //   categoriesByParent[selectedParent]!.currentPage--;
      // }
      productsByCategory[selectedParent]!.loadingPagination = false;
      productsByCategory[selectedParent]!.loadingProducts = false;
      emit(SuccessProductsByCategoryState());
    }).catchError((e) {
      if (productsByCategory[selectedParent]!.currentPage >= 1) {
        productsByCategory[selectedParent]!.currentPage--;
      }
      productsByCategory[selectedParent]!.loadingPagination = false;
      productsByCategory[selectedParent]!.loadingProducts = false;
      emit(ErrorProductsByCategoryState(error: e.toString()));
    });

    if (productsByCategory[selectedParent]!.currentPage !=
        productsByCategory[selectedParent]!.totalPages) {
      if (productsByCategory[selectedParent]!.currentPage <
          productsByCategory[selectedParent]!.totalPages!) {
        getCategoriesByParent();
      }
    }
  }
}
