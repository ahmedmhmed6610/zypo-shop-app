import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/data/models/brand_model.dart';
import 'package:shop/data/models/dummy_data/dummy_brands.dart';

part 'brand_state.dart';

class BrandCubit extends Cubit<BrandState> {
  BrandCubit() : super(BrandInitial());
  static BrandCubit get(BuildContext context) => BlocProvider.of(context);
  Map<int, List<BrandModel>> brandsByCategory = dummyBrandsByCategory;

  getBrandsBySubCategory(int categoryId) {
    if (brandsByCategory.containsKey(categoryId)) {
      return brandsByCategory[categoryId];
    } else {
      return [];
    }
  }
}
