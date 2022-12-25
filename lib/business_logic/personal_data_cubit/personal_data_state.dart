part of 'personal_data_cubit.dart';

@immutable
abstract class PersonalDataState {}

class PersonalDataInitial extends PersonalDataState {}

class ChangeProfilePictureState extends PersonalDataState {}

class TogglePasswordState extends PersonalDataState {}
