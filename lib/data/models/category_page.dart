import 'package:shop/data/models/category_model.dart';

class CategoryPage {
  List<CategoryModel> categories = [];
  // int? totalPages;
  // int currentPage = 0;
  // int total = 0;
  bool loadingCategory = false;
  // bool loadingPagination = false;

  CategoryPage.empty() {
    categories = [];
    // totalPages = 0;
    // currentPage = 0;
    // total = 0;
    loadingCategory = false;
    // loadingPagination = false;
  }
}
