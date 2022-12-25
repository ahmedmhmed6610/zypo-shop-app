// ignore_for_file: must_be_immutable

part of 'contact_us_cubit.dart';

@immutable
abstract class ContactUsState {}

class ContactUsInitial extends ContactUsState {}

class LoadingContactUs extends ContactUsState{}

class SuccessContactUs extends ContactUsState{
  ResponseModel responseModel;
  SuccessContactUs(this.responseModel);
}

class ErrorContactUs extends ContactUsState{
  String error;
  ErrorContactUs(this.error);
}
