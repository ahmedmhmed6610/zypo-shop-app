// ignore_for_file: must_be_immutable, camel_case_types

part of 'profile_cubit.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class LoadingProfileState extends ProfileState {}

class ChangeIconNewPasswordState extends ProfileState {}
class ChangeIconOldPasswordState extends ProfileState {}

class SuccessProfileState extends ProfileState {
  LoginModel? userDataModel;
  SuccessProfileState(this.userDataModel);

}

class ChangePasswordSuccessProfileState extends ProfileState {
  String? responseModel;
  ChangePasswordSuccessProfileState(this.responseModel);

}

class ErrorProfileState extends ProfileState {
  final String error;
  ErrorProfileState({required this.error});

}

class updateChangePasswordLoadingState extends ProfileState {}

class updateProfileSuccessState extends ProfileState {
  ResponseModel? responseModel;
  updateProfileSuccessState(this.responseModel);
}


class updateChangePasswordErrorState extends ProfileState {
  String? error;
  updateChangePasswordErrorState(this.error);
}

class AuthenticationLoading extends ProfileState {}

class AuthenticationStateUnauthenticated extends ProfileState {}

