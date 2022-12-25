part of 'app_layout_cubit.dart';

@immutable
abstract class AppLayoutState {}

class AppLayoutInitial extends AppLayoutState {}

class OnItemTappedState extends AppLayoutState {}

class ConnectionSuccess extends AppLayoutState {}

class ConnectionFailure extends AppLayoutState {}
