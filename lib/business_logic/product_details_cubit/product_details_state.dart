// ignore_for_file: must_be_immutable

part of 'product_details_cubit.dart';

@immutable
abstract class ProductDetailsState {}

class ProductDetailsInitial extends ProductDetailsState {}

class LoadingProductDetailsState extends ProductDetailsState {}
class ChangeConditionProductState extends ProductDetailsState {}

class SuccessProductDetailsState extends ProductDetailsState {
  List<ShowDetailsProductResponseModel>? showDetailsProductResponseModel;
  SuccessProductDetailsState(this.showDetailsProductResponseModel);
}

class ErrorProductDetailsState extends ProductDetailsState {
  final String error;
  ErrorProductDetailsState({required this.error});
}

class SubscribeUserDetailsLoadingState extends ProductDetailsState {}

class SubscribeUserDetailsSuccessfullyState extends ProductDetailsState {
  String? message;
  SubscribeUserDetailsSuccessfullyState(this.message);
}
class SubscribeUserDetailsErrorState extends ProductDetailsState {
  String? error;
  SubscribeUserDetailsErrorState(this.error);
}

