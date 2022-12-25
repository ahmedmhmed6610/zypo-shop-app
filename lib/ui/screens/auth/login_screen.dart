import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shop/business_logic/auth_cubit/auth_cubit.dart';
import 'package:shop/helpers/cache_helper.dart';
import 'package:shop/translations/locale_keys.g.dart';
import 'package:shop/ui/screens/auth/forgert_password_screens/forget_password_phone_number_screen.dart';
import 'package:shop/ui/widgets/My_products_widgets/add_product_widgets/input_text_form_field.dart';
import 'package:shop/utils/Themes.dart';
import '../../../data/repositories/auth_repo.dart';
import '../../../utils/app_palette.dart';
import '../../../utils/dimensions.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/images.dart';
import '../../../utils/app_size_boxes.dart';
import '../../base/custom_button.dart';
import '../../base/custom_toast.dart';
import '../auth/widgets/dot_circle.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FocusNode _mobileFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        body: SafeArea(
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(
                  Dimensions.paddingSizeLarge,
                  Dimensions.paddingSizeExtraExtraLarge,
                  Dimensions.paddingSizeLarge,
                  Dimensions.paddingSizeExtraLarge,
                ),
                child: BlocConsumer<AuthCubit, AuthState>(
                  listener: (BuildContext context, AuthState state) async {
                    _handleLoginListener(context, state);
                  },
                  builder: (BuildContext context, AuthState state) {
                    AuthCubit cubit = AuthCubit.get(context);
                    return ConstrainedBox(
                      constraints:
                      BoxConstraints(minHeight: constraints.minHeight),
                      child: IntrinsicHeight(
                        child: Stack(
                          children: [
                            const DotCircle(
                              left: 70,
                              top: 20,
                            ),
                            const DotCircle(
                              right: 70,
                              top: 20,
                            ),
                            const DotCircle(
                              left: 160,
                              top: 150,
                            ),
                            const DotCircle(
                              left: 30,
                              top: 110,
                              height: 41,
                              width: 41,
                            ),
                            Form(
                              key: _formKey,
                              child: Column(
                                children: <Widget>[
                                  buildLoginImageItem(),
                                  65.heightBox,
                                  Text(
                                    LocaleKeys.welComeShop.tr(),
                                    style:
                                    Theme.of(context).textTheme.headline3,
                                  ),
                                  7.heightBox,
                                  Text(
                                    LocaleKeys.keepDate.tr(),
                                    style:
                                    Theme.of(context).textTheme.bodyText1,
                                  ),
                                  30.heightBox,
                                  InputTextFormField(
                                    hintText: LocaleKeys.mobileNumber.tr(),
                                    textEditingController: _phoneController,
                                    maxLength: 15,
                                    validator: (val) {
                                      if (val.length < 7) {
                                        return LocaleKeys.enter_a_valid_phone.tr();
                                      } else {
                                        return null;
                                      }
                                    },
                                    focusNode: _mobileFocus,
                                    nextFocusNode: _passwordFocus,
                                    textInputType: TextInputType.phone,
                                    inputAction: TextInputAction.next,
                                    prefixIcon: const Icon(Icons.phone_android,
                                        color: AppPalette.primary),
                                  ),
                                  // CustomTextField(
                                  //   hintText: AppStrings.userName,
                                  //   controller: _phoneController,
                                  //   focusNode: _mobileFocus,
                                  //   nextFocus: _passwordFocus,
                                  //   inputType: TextInputType.emailAddress,
                                  //   prefixIcon: Icons.person,
                                  // ),
                                  16.heightBox,
                                  InputTextFormField(
                                    hintText: LocaleKeys.password.tr(),
                                    textEditingController: _passwordController,
                                    validator: (val) {
                                      if (val.length < 6) {
                                        return LocaleKeys.password_is_too_short
                                            .tr();
                                      } else {
                                        return null;
                                      }
                                    },
                                    focusNode: _passwordFocus,
                                    textInputType:
                                    TextInputType.text,
                                    secure: cubit.showPassword,
                                    suffixIcon: InkWell(
                                        onTap: cubit.togglePassword,
                                        child: Icon(
                                          cubit.showPassword
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color: AppPalette.black,
                                        )),
                                    inputAction: TextInputAction.done,
                                    prefixIcon: const Icon(Icons.lock,
                                        color: AppPalette.primary),
                                  ),
                                  // CustomTextField(
                                  //   hintText: AppStrings.password,
                                  //   controller: _passwordController,
                                  //   focusNode: _passwordFocus,
                                  //   inputAction: TextInputAction.done,
                                  //   inputType: TextInputType.visiblePassword,
                                  //   prefixIcon: Icons.lock,
                                  //   isPassword: true,
                                  //   onSubmit: (String text) {},
                                  // ),
                                  8.heightBox,
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: TextButton(
                                      onPressed: () {
                                        Navigator.of(context)
                                            .push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ForgetPasswordPhoneNumberScreen(),
                                            ));
                                      },
                                      child: Text(
                                        LocaleKeys.forgotPassword.tr(),
                                        style:
                                        Theme.of(context).textTheme.caption,
                                      ),
                                    ),
                                  ),
                                  30.heightBox,
                                  if (cubit.loginLoading)
                                    SpinKitDoubleBounce(
                                      color: Themes.colorApp9,
                                      size: 50.0.sp,
                                    ) else
                                  Container(),
                                  10.heightBox,
                                  CustomButton(
                                    buttonText: LocaleKeys.login.tr(),
                                    height: 48.h,
                                    fontSize: Dimensions.fontSizeLarge,
                                    onPressed: () {
                                      _login(cubit);
                                    },
                                  ),
                                  25.heightBox,
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pushNamed(
                                              AppConstants.appLayout);
                                        },
                                        child: Text(
                                          LocaleKeys.LoginVisitor.tr(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption,
                                        ),
                                      ),
                                    ],
                                  ),
                                  25.heightBox,
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        LocaleKeys.dontHaveAccount.tr(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1
                                            ?.copyWith(
                                          fontSize:
                                          Dimensions.fontSizeSmall,
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pushNamed(
                                              AppConstants.signUpScreen);
                                        },
                                        child: Text(
                                          LocaleKeys.signUp.tr(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _login(AuthCubit cubit) {
    if (_formKey.currentState!.validate()) {
      //print('sssssPhone${_phoneController.text}');
      cubit.loginFunction(context,
          phoneNumber: "+2${_phoneController.text}",
          password: _passwordController.text);
    }
  }

  void _handleLoginListener(BuildContext context, AuthState state) {
    if(state is LoginErrorState){
      customFlutterToast(state.error);
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
    }else if(state is LoginSuccessState){
      // CustomFlutterToast(state.loginModel?.user?.token);
      // CustomFlutterToast(state.loginModel?.user?.userName);
      // CustomFlutterToast(state.loginModel?.user?.phoneNumber);
      // CustomFlutterToast(state.loginModel?.user?.userEmail);
    //  CacheHelper().setToken('${state.loginModel?.user?.token}');
      AuthRepo().setUserToken('${state.loginModel?.user?.token}');
      CacheHelper.saveData(key: 'FirstName', value: '${state.loginModel?.user?.userFirstName}');
      CacheHelper.saveData(key: 'LastName', value: '${state.loginModel?.user?.userLastName}');
      CacheHelper.saveData(key: 'Email', value: '${state.loginModel?.user?.userEmail}');
      CacheHelper.saveData(key: 'UserId', value: '${state.loginModel?.user?.id}');
      _clearFormData();
      Navigator.pushNamedAndRemoveUntil(
          context, AppConstants.appLayout, (_) => false);
    }
    }


  void _clearFormData() {
    _phoneController.clear();
    _passwordController.clear();
  }

  Widget buildLoginImageItem() => SizedBox(
    width: 150,
    height: 150,
    child: Stack(
      alignment: Alignment.center,
      children: <Widget>[
        SvgPicture.asset(
          Images.loginImageChild,
        ),
        SvgPicture.asset(
          Images.loginImageContainer,
          height: 146.h,
          width: 146.w,
        ),
      ],
    ),
  );
}
