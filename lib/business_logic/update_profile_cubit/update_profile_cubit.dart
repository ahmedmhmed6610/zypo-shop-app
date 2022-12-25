import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/data/models/login_model.dart';
import 'package:shop/data/repositories/auth_repo.dart';
import 'package:shop/data/webservices/api_services/profile_user_serive.dart';
import 'package:shop/helpers/components.dart';
import 'package:shop/ui/screens/layout/app_layout.dart';
import 'package:shop/ui/screens/main_screens/profile_screen.dart';
import 'package:shop/ui/screens/user_screens/personal_data_screen.dart';

import '../../data/models/response_user_model.dart';
import '../../data/webservices/api_services/change_password_service.dart';
import '../../helpers/cache_helper.dart';
import '../../translations/locale_keys.g.dart';
import '../../ui/base/custom_toast.dart';

part 'update_profile_state.dart';

class UpdateProfileCubit extends Cubit<UpdateProfileState> {
  UpdateProfileCubit() : super(ProfileInitial()){
   // getUserProfile();
  }

  static UpdateProfileCubit get(BuildContext context) =>
      BlocProvider.of(context);

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();


  int index = 0;

  bool isLoading = false;
  bool updateIsLoading = false;
  bool updateIsPhotoLoading = false;
  bool showPassword = true;
  bool showNewPassword = true;
  bool showOldPassword = true;
  LoginModel? loginModel;


  updateProfileUser({ context, firstName, lastName, email,  phoneNumber, photo}){
    updateIsLoading = true;
    print('personal user');
    print(firstName);
    print(lastName);
    print(email);
    print(phoneNumber);
    emit(updateProfileLoadingState());
    ProfileUserService.updateProfileUser(firstName: firstName,
        lastName: lastName,
        email: email,
        phoneNumber:  phoneNumber,
        image:photo).then((value){
      if(value?.success == true){
        updateIsLoading = false;
        CacheHelper.saveData(key: 'FirstName', value: firstName);
        CacheHelper.saveData(key: 'LastName', value: lastName);
       // CacheHelper.saveData(key: 'photo', value: photo);
      //  customFlutterToast(value?.message);
        emit(updateProfileSuccessState(value));
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => AppLayout()));
        print('success update profile');
      }else {
        updateIsLoading = false;
        print('error update profile');
        print('${value?.message}');
        emit(updateProfilerErrorState(value?.message));
        AwesomeDialog(
          context: context,
          dialogType: DialogType.warning,
          animType: AnimType.RIGHSLIDE,
          title: LocaleKeys.warning.tr(),
          btnOkText: LocaleKeys.ok.tr(),
          btnCancelText: LocaleKeys.cancel.tr(),
          desc: LocaleKeys.internetConnection.tr(),
          btnCancelOnPress: () {},
          btnOkOnPress: () {},
        ).show();
      }
    });
  }

  updateProfileImageUser(BuildContext context,String firstName,
      String lastName,String email, String phoneNumber,File photo){
    updateIsPhotoLoading = true;
    emit(updateProfileImageLoadingState());
    ProfileUserService.updateProfileImageUser(firstName,lastName,
    email,phoneNumber,photo).then((value){
      if(value?.success == true){
        updateIsPhotoLoading = false;
       // Navigator.of(context).push(MaterialPageRoute(builder: (context) => AppLayout()));
         emit(updateProfileImageSuccessState(value));
      //  navigateReplaceTo(context: context, widget: AppLayout());
        print('success update profile');
      }else {
        updateIsPhotoLoading = false;
        print('error update profile');
        emit(updateProfilerImageErrorState(value?.message));
        AwesomeDialog(
          context: context,
          dialogType: DialogType.warning,
          animType: AnimType.RIGHSLIDE,
          title: LocaleKeys.warning.tr(),
          btnOkText: LocaleKeys.ok.tr(),
          btnCancelText: LocaleKeys.cancel.tr(),
          desc: LocaleKeys.internetConnection.tr(),
          btnCancelOnPress: () {},
          btnOkOnPress: () {},
        ).show();
      }
    });
  }

}
