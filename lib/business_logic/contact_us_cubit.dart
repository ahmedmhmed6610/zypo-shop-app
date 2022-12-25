import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/data/models/response_user_model.dart';
import 'package:shop/data/webservices/api_services/contact_us_service.dart';

part 'contact_us_state.dart';

class ContactUsCubit extends Cubit<ContactUsState> {
  ContactUsCubit() : super(ContactUsInitial());

  static ContactUsCubit get(BuildContext context) =>
      BlocProvider.of(context);

  bool isLoading = false;
  ResponseModel? responseModel;
  sendContactUsData(context,
      {required String name, required String email, required String message}) async {
    emit(LoadingContactUs());
    ContactUsService.setContactUserData(name,email,message).then((value) {
      responseModel = value;
      if (responseModel?.success == true) {
        emit(SuccessContactUs(responseModel!));
      } else {
        emit(ErrorContactUs(responseModel!.message!));
      }
    });
  }

}
