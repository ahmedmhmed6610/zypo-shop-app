import 'package:shop/data/models/brand_model.dart';

class BrandPage {
  List<BrandModel> brands = [];
  // int? totalPages;
  // int currentPage = 0;
  // int total = 0;
  bool loadingBrand = false;
  // bool loadingPagination = false;

  BrandPage.empty() {
    brands = [];
    // totalPages = 0;
    // currentPage = 0;
    // total = 0;
    loadingBrand = false;
    // loadingPagination = false;
  }
}
