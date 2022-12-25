// ignore_for_file: must_be_immutable

part of 'filter_cubit.dart';

@immutable
abstract class FilterState {}

class FilterInitial extends FilterState {}

class SelectMainCategoryState extends FilterState {}

class SelectSubCategoryState extends FilterState {}

class SelectLocationState extends FilterState {}

class SelectBrandState extends FilterState {}


class ChangeConditionState extends FilterState {}
class ChangeWarrantyState extends FilterState {}
class ChangeStatusPropertiesState extends FilterState {}
class ChangeFinishedState extends FilterState {}
class ChangeTransmissionState extends FilterState {}

class SelectColorState extends FilterState {}

class FilterLoadingState extends FilterState {}
class FilterLocationLoadingState extends FilterState {}

class FilterSuccessState extends FilterState {
  List<MyProductUserResponseModel>? myProductUserResponseModel;
  FilterSuccessState(this.myProductUserResponseModel);
}

class FilterSuccessLocationState extends FilterState {
  LocationResponseModel? mapLocationModel;
  FilterSuccessLocationState(this.mapLocationModel);
}

class FilterLocationErrorState extends FilterState {
  String? error;
  FilterLocationErrorState(this.error);
}
class FilterErrorState extends FilterState {
  String? error;
  FilterErrorState(this.error);
}

