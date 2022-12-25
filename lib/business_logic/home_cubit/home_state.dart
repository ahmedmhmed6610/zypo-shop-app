// ignore_for_file: must_be_immutable

part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class RecommendationProductsLoadingState extends HomeState {}

class RecommendationProductsSuccessState extends HomeState {}

class RecommendationProductsErrorState extends HomeState {
  String error;
  RecommendationProductsErrorState({required this.error});
}

class SearchUserLoading extends HomeState {}

class SearchUserSuccess extends HomeState {
  MyProductUserModel? searchModel;
  SearchUserSuccess(this.searchModel);
}

class SearchUserError extends HomeState {
  String? error;
  SearchUserError(this.error);
}

class SliderLoadingState extends HomeState {}
class SliderErrorState extends HomeState {
  String? error;
  SliderErrorState(this.error);
}
class SliderSuccessState extends HomeState {
  List<SliderResponseModel>? sliderResponseModel;
  SliderSuccessState(this.sliderResponseModel);
}



