
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:connectivity/connectivity.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop/business_logic/home_cubit/home_cubit.dart';
import 'package:shop/business_logic/my_products_cubit/my_products_cubit.dart';
import 'package:shop/business_logic/wishlist_cubit/wishlist_cubit.dart';
import 'package:shop/data/models/response_user_model.dart';
import 'package:shop/data/models/user_data_model.dart';
import 'package:shop/data/webservices/api_services/auth_services.dart';
import 'package:shop/helpers/cache_helper.dart';
import 'package:shop/helpers/components.dart';
import 'package:shop/ui/screens/auth/forgert_password_screens/forget_password_otp_screen.dart';
import 'package:shop/utils/app_palette.dart';
import 'package:shop/globals.dart' as globals;

import '../../data/models/login_model.dart';
import '../../translations/locale_keys.g.dart';
import '../../ui/base/custom_toast.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> with AuthServices, CacheHelper {
  AuthCubit() : super(AuthInitial());

  static AuthCubit get(BuildContext context) => BlocProvider.of(context);

  bool registerLoading = false;
  bool showPassword = true;
  bool showConfirmedPassword = true;
  bool otpLoading = false;
  bool isLoggedOut = false;
  bool loginLoading = false;
  bool loading = false;
  bool forgetPasswordLoading = false;
  bool confirmPasswordOTPLoading = false;
  bool resetPasswordLoading = false;
  String? phoneNum = "";
  String? verifyToken = "";
  SnackBar? snackBar;
  UserDataModel userDataModel = UserDataModel.empty();
  LoginModel? loginModel;
  ResponseModel? responseModel;

  togglePassword() {
    showPassword = !showPassword;
    emit(AuthenticationTogglePasswordState());
  }
  toggleConfirmedPassword() {
    showConfirmedPassword = !showConfirmedPassword;
    emit(AuthenticationToggleConfirmedPasswordState());
  }

  loadData(BuildContext context) {
    HomeCubit.get(context);
    if (globals.token.isNotEmpty) {
      AddProductCubit.get(context);
      WishlistCubit.get(context);
    }
  }

  registerFunction(BuildContext context,
      {required String firstName,
        required String lastName,
        required String email,
        required String phoneNumber,
        required String password,
        required String cPassword}) async {
    phoneNum = "+2$phoneNumber";
    registerLoading = true;
    emit(RegisterLoadingState());
    Connectivity().checkConnectivity().then((connectivityResult) {
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        AuthServices.registerUserAndSendOtp(
            firstName, lastName, email, phoneNumber, password, cPassword)
            .then((value) {
          if (value?.success == true) {
            registerLoading = false;
            emit(RegisterSuccessState(value));
          } else {
            registerLoading = false;
            emit(RegisterErrorState(value?.message));
          }
        });
      } else {
        registerLoading = false;
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

  loginFunction(BuildContext context,
      {required String phoneNumber, required String password}) async {
    emit(LoginLoadingState());
    loginLoading = true;

    Connectivity().checkConnectivity().then((connectivityResult) {
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        AuthServices.checkLoginUser(phoneNumber, password).then((value) {
          loginModel = value;
          if (loginModel?.status == true) {
            loginLoading = false;
            emit(LoginSuccessState(loginModel));
          } else {
            loginLoading = false;
            emit(LoginErrorState('${loginModel?.message.toString()}'));
          }
        });
      } else {
        loginLoading = false;
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

  updateFCMToken(String? fcmToken) async {
    Connectivity().checkConnectivity().then((connectivityResult) {
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        AuthServices.updateFcmToken(fcmToken).then((value) {
          if (value?.success == true) {
            responseModel = value;
            CacheHelper.saveData(key: 'fcmToken', value: fcmToken);
            // CustomFlutterToast(fcmToken);
            // print('token device updated');
            // print(fcmToken);
            // print(value?.message);
            // CustomFlutterToast(value?.message);
          } else {

          }
        });
      } else {
        loginLoading = false;
        customFlutterToast('no internet connection');
      }
    });
  }

  getPhoneNumber() {
    return phoneNum;
  }

  // void logout() async {
  //   emit(AuthenticationLoading());
  //   // await authRepo.updateFcmToken(unAuthenticate: true);
  //   // await authRepo.deleteUser();
  //   emit(AuthenticationStateUnauthenticated());
  // }

  /// pin code
  // final defaultPinTheme = PinTheme(
  //   width: 56,
  //   height: 56,
  //   textStyle: TextStyle(
  //       fontSize: 20,
  //       color: Color.fromRGBO(30, 60, 87, 1),
  //       fontWeight: FontWeight.w600),
  //   decoration: BoxDecoration(
  //     border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
  //     borderRadius: BorderRadius.circular(20),
  //   ),
  // );
  // defaultPinTheme() =>
  //     PinTheme(
  //       width: 48.w,
  //       height: 48.h,
  //       textStyle: const TextStyle(
  //         fontSize: 15,
  //         color: AppPalette.black,
  //         fontWeight: FontWeight.w400,
  //       ),
  //       decoration: BoxDecoration(
  //         color: AppPalette.lightPrimary,
  //         borderRadius: BorderRadius.circular(8),
  //         border: Border.all(color: AppPalette.primary),
  //       ),
  //     );


  void verifySupervisorOtp(BuildContext context,
      {required String phoneNumber, required String code}) async {
    otpLoading = true;
    emit(ResponseLoadingState());
    Connectivity().checkConnectivity().then((connectivityResult) {
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        AuthServices.verifySupervisorOtpNetWork(phoneNumber, code).then((
            value) {
          responseModel = value;
          if (responseModel?.success == true) {
            loginLoading = false;
            emit(ResponseSuccessState(responseModel));
          } else {
            loginLoading = false;
            emit(ResponseErrorState('${loginModel?.message.toString()}'));
          }
        });
      } else {
        loginLoading = false;
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

  //reset password
  forgetPasswordFunction(BuildContext context,
      {required String phoneNumber}) async {
    phoneNum = "+2$phoneNumber";
    print('phoneNum');
    print(phoneNum);
    forgetPasswordLoading = true;
    emit(ResponseLoadingState());
    Connectivity().checkConnectivity().then((connectivityResult) {
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        AuthServices.forgetPasswordNetWork(phoneNumber: phoneNum!).then((
            value) {
          responseModel = value;
          if (responseModel?.success == true) {
            forgetPasswordLoading = false;
            print('phoneNum');
            print(responseModel?.success);
            print(responseModel?.message);
            forgetPasswordLoading = false;
            customFlutterToast(responseModel?.message);
            emit(ResponseSuccessState(responseModel));
            navigateReplaceTo(context: context, widget: ForgetPasswordOTPScreen(phone: phoneNumber,));
         //   Get.offAll(ForgetPasswordOTPScreen());
          } else {
            print('phoneNum');
            print(responseModel?.success);
            print(responseModel?.message);
            forgetPasswordLoading = false;
            customFlutterToast(responseModel?.message);
            emit(ResponseErrorState('${loginModel?.message.toString()}'));
          }
        });
      } else {
        forgetPasswordLoading = false;
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

  resendCondeFunction(BuildContext context,
      {required String phoneNumber}) async {
    phoneNum = "+2$phoneNumber";
    print('phoneNum');
    print(phoneNum);
    forgetPasswordLoading = true;
    emit(ResponseLoadingState());
    Connectivity().checkConnectivity().then((connectivityResult) {
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        AuthServices.resendCodeAgainOtpNetWork(phoneNumber: phoneNum!).then((
            value) {
          responseModel = value;
          if (responseModel?.success == true) {
            forgetPasswordLoading = false;
            print('phoneNum');
            print(responseModel?.success);
            print(responseModel?.message);
            forgetPasswordLoading = false;
            customFlutterToast(responseModel?.message);
            emit(ResponseSuccessState(responseModel));
          //  navigateReplaceTo(context: context, widget: ForgetPasswordOTPScreen());
         //   Get.offAll(ForgetPasswordOTPScreen());
          } else {
            print('phoneNum');
            print(responseModel?.success);
            print(responseModel?.message);
            forgetPasswordLoading = false;
            customFlutterToast(responseModel?.message);
            emit(ResponseErrorState('${loginModel?.message.toString()}'));
          }
        });
      } else {
        forgetPasswordLoading = false;
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

  confirmPasswordOTPFunction(BuildContext context,
      {required String phoneNumber, required String code}) async {
    phoneNum = "+2$phoneNumber";
    verifyToken = code;
    confirmPasswordOTPLoading = true;
    emit(ResponseLoadingState());
    Connectivity().checkConnectivity().then((connectivityResult) {
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        AuthServices.confirmPasswordOTPNetWork(
            phoneNumber: phoneNum!, code: code).then((value) {
          responseModel = value;
          if (responseModel?.success == true) {
            loginLoading = false;
            emit(ResponseSuccessState(responseModel));
          } else {
            loginLoading = false;
            emit(ResponseErrorState('${loginModel?.message.toString()}'));
          }
        });
      } else {
        loginLoading = false;
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

  resetPasswordFunction(BuildContext context,
      {required String password}) async {
    resetPasswordLoading = true;
    emit(ResponseLoadingState());
    Connectivity().checkConnectivity().then((connectivityResult) {
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        AuthServices.resetPasswordNetWork(
            phoneNumber: phoneNum, code: verifyToken, password: password).then((
            value) {
          responseModel = value;
          if (responseModel?.success == true) {
            loginLoading = false;
            emit(ResponseSuccessState(responseModel));
          } else {
            loginLoading = false;
            emit(ResponseErrorState('${loginModel?.message.toString()}'));
          }
        });
      } else {
        loginLoading = false;
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
