
import 'package:shop/data/models/BrandModelCarModel.dart';

import '../../data/models/MyProductUserModel.dart';
import '../../data/models/product_model.dart';
import '../../data/models/response_user_model.dart';

abstract class AddProductState {}

class AddProductInitial extends AddProductState {}

class ChangeConditionState extends AddProductState {}

class PickProductImagesState extends AddProductState {}

class DeleteProductImagesState extends AddProductState {}

class SelectMainCatState extends AddProductState {}

class SelectSubCatState extends AddProductState {}

class SelectOnlyBrandState extends AddProductState {}
class SelectOnlyColorState extends AddProductState {}
class SelectAmenitiesState extends AddProductState {}

class SelectProductLocationState extends AddProductState {}

class SelectColorState extends AddProductState {}


class AddProductLoadingState extends AddProductState {}

class UpdateImageLoadingState extends AddProductState {}

class AddProductSuccessState extends AddProductState {}

class UpdateImageSuccessState extends AddProductState {
  String? message;
  UpdateImageSuccessState(this.message);
}

class UpdateImageErrorState extends AddProductState {
  String? message;
  UpdateImageErrorState(this.message);
}

class UpdateProductSuccessState extends AddProductState {
  String? message;
  UpdateProductSuccessState(this.message);
}
class UpdateProductLoadingState extends AddProductState {}
class UpdateProductErrorState extends AddProductState {
  String? error;
  UpdateProductErrorState(this.error);
}

class AddProductErrorState extends AddProductState {
  String error;
  AddProductErrorState({required this.error});
}

class GetProductsLoadingState extends AddProductState {}
class ChangeWarrantyAddProductState extends AddProductState {}
class ChangeTransmissionTypeAddProductState extends AddProductState {}
class ChangeTypeHomeFashionAddProductState extends AddProductState {}
class ChangeTypeHomeFurnitureAddProductState extends AddProductState {}
class ChangeTypeBooksAddProductState extends AddProductState {}
class ChangeTypeKidsAddProductState extends AddProductState {}
class ChangeTypeBusinessAddProductState extends AddProductState {}
class ChangeStatusPropertiesAddProductState extends AddProductState {}
class ChangeFinishedAddProductState extends AddProductState {}

class GetProductsSuccessState extends AddProductState {}

class GetProductsSuccessState2 extends AddProductState {
  List<MyProductUserResponseModel>? myProductUserResponseModel;
  GetProductsSuccessState2(this.myProductUserResponseModel);
}

class GetMyProductsSuccessState extends AddProductState {
  List<ProductModel>? myProductUserResponseModel;
  GetMyProductsSuccessState(this.myProductUserResponseModel);
}

class GetProductsErrorState extends AddProductState {
  String error;
  GetProductsErrorState({required this.error});
}


class GetOptionLoadingState extends AddProductState {}

class GetOptionSuccessState extends AddProductState {
  BrandModelCarModel? brandModelCarModel;
  GetOptionSuccessState(this.brandModelCarModel);
}

class GetOptionErrorState extends AddProductState {
  String error;
  GetOptionErrorState(this.error);
}

class DeleteProductsLoadingState extends AddProductState{}

class DeleteProductsSuccessState extends AddProductState{
  ResponseModel? responseModel;
  DeleteProductsSuccessState(this.responseModel);
}

class DeleteProductsErrorState extends AddProductState{
  String error;
  DeleteProductsErrorState(this.error);
}

