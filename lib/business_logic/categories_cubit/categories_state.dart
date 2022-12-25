part of 'categories_cubit.dart';

@immutable
abstract class CategoriesState {}

class CategoriesInitial extends CategoriesState {}

class ParentLoadingState extends CategoriesState {}

class SuccessParentsState extends CategoriesState {}

class ErrorParentsState extends CategoriesState {
  final String error;
  ErrorParentsState({required this.error});
}

class SetSelectedParentState extends CategoriesState {}

class LoadingCategoriesByParentState extends CategoriesState {}

class SuccessCategoriesByParentState extends CategoriesState {}

class ErrorCategoriesByParentState extends CategoriesState {
  final String error;
  ErrorCategoriesByParentState({required this.error});
}

class LoadingProductsByCategoryState extends CategoriesState {}

class SuccessProductsByCategoryState extends CategoriesState {}

class ErrorProductsByCategoryState extends CategoriesState {
  final String error;
  ErrorProductsByCategoryState({required this.error});
}

class LoadingBrandsByCategoryState extends CategoriesState {}

class SuccessBrandsByCategoryState extends CategoriesState {}

class ErrorBrandsByCategoryState extends CategoriesState {
  final String error;
  ErrorBrandsByCategoryState({required this.error});
}
