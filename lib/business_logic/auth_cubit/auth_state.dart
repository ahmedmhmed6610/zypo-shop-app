// ignore_for_file: must_be_immutable

part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class LoginLoadingState extends AuthState {}

class LoginSuccessState extends AuthState {
  LoginModel? loginModel;
  LoginSuccessState(this.loginModel);
}

class LoginErrorState extends AuthState {
  final String error;
  LoginErrorState(this.error);
}

class AuthenticationTogglePasswordState extends AuthState {}
class AuthenticationToggleConfirmedPasswordState extends AuthState {}

class RegisterLoadingState extends AuthState {}

class RegisterSuccessState extends AuthState {
  ResponseModel? responseModel;
  RegisterSuccessState(this.responseModel);
}

class RegisterErrorState extends AuthState {
  String? error;
  RegisterErrorState(this.error);
}

class LoadingAuthState extends AuthState {}

class ResponseLoadingState extends AuthState {}

class ResponseSuccessState extends AuthState {
  ResponseModel? responseModel;
  ResponseSuccessState(this.responseModel);
}

class ResponseErrorState extends AuthState {
  String error;
  ResponseErrorState(this.error);
}




