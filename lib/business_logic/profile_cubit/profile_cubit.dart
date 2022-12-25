import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/data/models/login_model.dart';
import 'package:shop/data/repositories/auth_repo.dart';
import 'package:shop/data/webservices/api_services/profile_user_serive.dart';
import 'package:shop/ui/screens/layout/app_layout.dart';
import 'package:shop/ui/screens/main_screens/profile_screen.dart';
import 'package:shop/ui/screens/user_screens/personal_data_screen.dart';

import '../../data/models/response_user_model.dart';
import '../../data/webservices/api_services/change_password_service.dart';
import '../../helpers/cache_helper.dart';
import '../../translations/locale_keys.g.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial()){
   // getUserProfile();
  }

  static ProfileCubit get(BuildContext context) => BlocProvider.of(context);

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();


  int index = 0;

  bool isLoading = false;
  bool updateIsLoading = false;
  bool showPassword = true;
  bool showNewPassword = true;
  bool showOldPassword = true;
  LoginModel? loginModel;

  getUserProfile(){
    isLoading = true;
    emit(LoadingProfileState());
    ProfileUserService.checkProfileDetails().then((value){
      if(value?.status == true){
        isLoading = false;
        loginModel = value!;
        // print('image url');
        // print('${value.user?.userImagePath}/${value.user?..photo}');
       // CustomFlutterToast(value?.user?.userName);
        emit(SuccessProfileState(value));

      }else {
        isLoading = false;
      //  CustomFlutterToast(value?.message);
      }
    }).catchError((onError){
      isLoading = false;
      emit(ErrorProfileState(error: ''));
    });
  }



  changePassword(BuildContext context,String newPassword,String oldPassword){
    emit(updateChangePasswordLoadingState());
    ChangePasswordService.changePassword(newPassword,oldPassword).then((value){
      if(value?.success == true){
        emit(ChangePasswordSuccessProfileState(value?.message));
       // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const ProfileScreen()), (route) => false);
        print('password update success');
      }else {
        print('password update error');
        emit(updateChangePasswordErrorState(value?.message));
        AwesomeDialog(
          context: context,
          dialogType: DialogType.warning,
          animType: AnimType.rightSlide,
          title: LocaleKeys.warning.tr(),
          btnOkText: LocaleKeys.ok.tr(),
          btnCancelText: LocaleKeys.cancel.tr(),
          desc: LocaleKeys.checkPassword.tr(),
          btnCancelOnPress: () {},
          btnOkOnPress: () {},
        ).show();
       // emit(updateChangePasswordErrorState(value?.message));
      }
    }).catchError((onError){
      emit(updateChangePasswordErrorState('no internet connection'));
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
    });
  }


  togglePassword() {
    showPassword = !showPassword;
   //  emit(ChangeIconOldPasswordState());
    print('showPassword ssss');
  }

  toggleNewPassword() {
    showNewPassword = !showNewPassword;
    emit(ChangeIconNewPasswordState());
    print('showPassword ssss');
  }

  toggleOldPassword() {
    showOldPassword = !showOldPassword;
    emit(ChangeIconOldPasswordState());
    print('showPassword ssss');
  }


  changeIndex(int index) {
    this.index = index;
   // emit(ChangeIndexState());
  }

  void logout() async {
    emit(AuthenticationLoading());
    await AuthRepo().deleteUser();
    CacheHelper.removeData(key: 'fcmToken');
    emit(AuthenticationStateUnauthenticated());
  }



}
