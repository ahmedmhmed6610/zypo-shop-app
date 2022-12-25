import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/data/models/NotificationModel.dart';
import 'package:shop/data/webservices/api_services/notification_service.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(NotificationInitial());

  static NotificationCubit get (BuildContext context) => BlocProvider.of(context);


  getNotificationUser(){
    emit(NotificationLoadingState());
    NotificationService.getNotificationUser().then((value){
      // print('list is ');
      // print(value?.notificationResponseModel?.length);
      // print(value?.notificationResponseModel![0].title);
      emit(NotificationSuccessfullyState(value?.notificationResponseModel));
    });
  }
}
