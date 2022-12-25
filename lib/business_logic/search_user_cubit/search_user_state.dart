// ignore_for_file: must_be_immutable

part of 'search_user_cubit.dart';

@immutable
abstract class SearchUserState {}

class SearchUserInitial extends SearchUserState {}

class SearchUserLoading extends SearchUserState {}

class SearchUserSuccess extends SearchUserState {
  SearchModel? searchModel;
  SearchUserSuccess(this.searchModel);
}

class SearchUserSuccessDone extends SearchUserState {
  List<Data>? searchModel;
  SearchUserSuccessDone(this.searchModel);
}

class SearchUserError extends SearchUserState {
  String? error;
  SearchUserError(this.error);
}
