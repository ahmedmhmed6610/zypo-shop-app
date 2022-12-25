import 'package:shop/data/models/MyProductUserModel.dart';
import 'package:shop/data/models/product_model.dart';
import 'package:shop/data/models/show_details_product_model.dart';

import 'SearchModel.dart';

class ProductPage {
  List<ProductModel> products = [];
  List<MyProductUserResponseModel> productsList = [];
  List<ShowDetailsProductResponseModel> productsSubscribersList = [];
  List<Data>? data = [];
  int? totalPages;
  int currentPage = 0;
  int total = 0;
  bool loadingProducts = false;
  bool loadingPagination = false;

  ProductPage.empty() {
    products = [];
    totalPages = 0;
    currentPage = 0;
    total = 0;
    loadingProducts = false;
    loadingPagination = false;
  }
}
