part of 'add_favorite_user_cubit.dart';

@immutable
abstract class AddFavoriteUserState {}

class AddFavoriteUserInitial extends AddFavoriteUserState {}

class AddSubscribeUserLoadingState extends AddFavoriteUserState {}

class AddSubscribeUserSuccessfullyState extends AddFavoriteUserState {
  String? message;
  AddSubscribeUserSuccessfullyState(this.message);
}
class AddSubscribeUserErrorState extends AddFavoriteUserState {
  String? error;
  AddSubscribeUserErrorState(this.error);
}

class AddSubscribeUserProductLoadingState extends AddFavoriteUserState {}

class AddSubscribeUserProductSuccessfullyState extends AddFavoriteUserState {
  String? message;
  AddSubscribeUserProductSuccessfullyState(this.message);
}
class AddSubscribeUserProductErrorState extends AddFavoriteUserState {
  String? error;
  AddSubscribeUserProductErrorState(this.error);
}
