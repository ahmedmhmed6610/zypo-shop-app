// ignore_for_file: must_be_immutable, camel_case_types

part of 'update_profile_cubit.dart';

@immutable
abstract class UpdateProfileState {}

class ProfileInitial extends UpdateProfileState {}



class updateProfileLoadingState extends UpdateProfileState {}

class updateProfileSuccessState extends UpdateProfileState {
  ResponseModel? responseModel;
  updateProfileSuccessState(this.responseModel);
}

class updateProfilerErrorState extends UpdateProfileState {
  String? error;
  updateProfilerErrorState(this.error);
}

class updateProfileImageLoadingState extends UpdateProfileState {}

class updateProfileImageSuccessState extends UpdateProfileState {
  ResponseModel? responseModel;
  updateProfileImageSuccessState(this.responseModel);
}

class updateProfilerImageErrorState extends UpdateProfileState {
  String? error;
  updateProfilerImageErrorState(this.error);
}

