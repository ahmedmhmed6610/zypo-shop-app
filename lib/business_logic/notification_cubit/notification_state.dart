// ignore_for_file: must_be_immutable

part of 'notification_cubit.dart';

@immutable
abstract class NotificationState {}

class NotificationInitial extends NotificationState {}

class NotificationLoadingState extends NotificationState {}
class NotificationSuccessfullyState extends NotificationState {
  List<NotificationResponseModel>? notificationResponseModel;
  NotificationSuccessfullyState(this.notificationResponseModel);
}
class NotificationErrorState extends NotificationState {
  String? error;
  NotificationErrorState(this.error);
}
