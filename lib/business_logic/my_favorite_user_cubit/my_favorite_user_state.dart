part of 'my_favorite_user_cubit.dart';

@immutable
abstract class MyFavoriteUserState {}

class MyFavoriteUserInitial extends MyFavoriteUserState {}

class MyFavoriteUserLoadingState extends MyFavoriteUserState {}
class MyFavoriteUserSuccessfullyState extends MyFavoriteUserState {
  List<MyFavoriteUserResponseModel>? myFavoriteResponseModel;
  MyFavoriteUserSuccessfullyState(this.myFavoriteResponseModel);
}
class MyFavoriteUserErrorState extends MyFavoriteUserState {
  String? error;
  MyFavoriteUserErrorState(this.error);
}

class SubscribeUserLoadingState extends MyFavoriteUserState {}

class SubscribeUserSuccessfullyState extends MyFavoriteUserState {
  String? message;
  SubscribeUserSuccessfullyState(this.message);
}
class SubscribeUserErrorState extends MyFavoriteUserState {
  String? error;
  SubscribeUserErrorState(this.error);
}

