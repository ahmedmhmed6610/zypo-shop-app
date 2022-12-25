part of 'add_ads_product_cubit.dart';

@immutable
abstract class AddAdsProductState {}

class AddAdsProductInitial extends AddAdsProductState {}

class AddAdsProductLoading extends AddAdsProductState {}

class AddAdsProductSuccessfully extends AddAdsProductState {
 final String? message;
 AddAdsProductSuccessfully(this.message);
}

class AddAdsProductFailure extends AddAdsProductState {
  final String? message;
  AddAdsProductFailure(this.message);
}

