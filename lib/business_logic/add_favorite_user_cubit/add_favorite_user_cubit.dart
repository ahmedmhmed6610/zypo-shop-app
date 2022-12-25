import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/webservices/api_services/my_favorite_user_service.dart';
part 'add_favorite_user_state.dart';

class AddFavoriteUserCubit extends Cubit<AddFavoriteUserState> {
  AddFavoriteUserCubit() : super(AddFavoriteUserInitial());

 static AddFavoriteUserCubit get (BuildContext context) => BlocProvider.of(context);

  addSubscribeUser(String favoriteUserId){
    emit(AddSubscribeUserLoadingState());
    MyFavoriteUserService.setSubscribeUser(favoriteUserId).then((value){

      emit(AddSubscribeUserSuccessfullyState(value?.message));
    });
  }

  deleteSubscribeUser(String favoriteUserId){
    emit(AddSubscribeUserLoadingState());
    print('favoriteUserId');
    print(favoriteUserId);
    MyFavoriteUserService.deleteSubscribeUser(favoriteUserId).then((value){
      print('success message');
      print(value?.message);
      emit(AddSubscribeUserSuccessfullyState(value?.message));
    });
  }

  addSubscribeUserProduct(String favoriteUserId){
    emit(AddSubscribeUserProductLoadingState());
    MyFavoriteUserService.setSubscribeUser(favoriteUserId).then((value){

      emit(AddSubscribeUserProductSuccessfullyState(value?.message));
    });
  }

  deleteSubscribeUserProduct(String favoriteUserId){
    emit(AddSubscribeUserProductLoadingState());
    print('favoriteUserId');
    print(favoriteUserId);
    MyFavoriteUserService.deleteSubscribeUser(favoriteUserId).then((value){
      print('success message');
      print(value?.message);
      emit(AddSubscribeUserProductSuccessfullyState(value?.message));
    });
  }

}
