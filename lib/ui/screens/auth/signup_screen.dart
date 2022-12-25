import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shop/business_logic/auth_cubit/auth_cubit.dart';
import 'package:shop/translations/locale_keys.g.dart';
import 'package:shop/ui/screens/auth/verification_code_screen.dart';
import 'package:shop/ui/widgets/My_products_widgets/add_product_widgets/input_text_form_field.dart';
import '../../../utils/Themes.dart';
import 'widgets/dot_circle.dart';
import 'package:shop/utils/app_size_boxes.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/app_palette.dart';
import '../../../utils/dimensions.dart';
import '../../../utils/images.dart';
import '../../base/custom_button.dart';
import '../../base/custom_toast.dart';

class SignUPScreen extends StatefulWidget {
  const SignUPScreen({Key? key}) : super(key: key);
  @override
  State<SignUPScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUPScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FocusNode _firstNameFocus = FocusNode();
  final FocusNode _lastNameFocus = FocusNode();
  final FocusNode _mobileFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _confirmedPasswordFocus = FocusNode();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmedController = TextEditingController();
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: NestedScrollView(
          body: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(
                  Dimensions.paddingSizeLarge,
                  Dimensions.paddingSizeExtraLarge,
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
                              left: 110,
                              top: 0,
                              width: 8,
                              height: 8,
                            ),
                            const DotCircle(
                              right: 111,
                              top: 20,
                              width: 8,
                              height: 8,
                            ),
                            const DotCircle(
                              left: 160,
                              top: 90,
                              width: 8,
                              height: 8,
                            ),
                            const DotCircle(
                              left: 90,
                              top: 50,
                              height: 19,
                              width: 19,
                            ),
                            Form(
                              key: _formKey,
                              child: Column(
                                children: <Widget>[
                                  buildLoginImageItem(),
                                  39.heightBox,
                                  Text(
                                    LocaleKeys.welComeShop.tr(),
                                    style:
                                        Theme.of(context).textTheme.headline3,
                                  ),
                                  7.heightBox,
                                  Text(
                                    LocaleKeys.keepDateSignUp.tr(),
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  ),
                                  30.heightBox,
                                  InputTextFormField(
                                    hintText: LocaleKeys.firstName.tr(),
                                    textEditingController: _firstNameController,
                                    validator: (val) {
                                      if (val.length < 2) {
                                        return LocaleKeys.enter_your_name.tr();
                                      } else {
                                        return null;
                                      }
                                    },
                                    focusNode: _firstNameFocus,
                                    nextFocusNode: _lastNameFocus,
                                    textInputType: TextInputType.text,
                                    inputAction: TextInputAction.next,
                                    prefixIcon: const Icon(Icons.person,
                                        color: AppPalette.primary),
                                  ),
                                  // CustomTextField(
                                  //   // hintText: 'first name',
                                  //   // controller: _firstNameController,
                                  //   focusNode: _firstNameFocus,
                                  //   nextFocus: _lastNameFocus,
                                  //   inputType: TextInputType.text,
                                  //   inputAction: TextInputAction.next,
                                  //   prefixIcon: Icons.person,
                                  // ),
                                  16.heightBox,
                                  InputTextFormField(
                                    hintText: LocaleKeys.lastName.tr(),
                                    textEditingController: _lastNameController,
                                    validator: (val) {
                                      if (val.length < 2) {
                                        return LocaleKeys.enter_your_name.tr();
                                      } else {
                                        return null;
                                      }
                                    },
                                    focusNode: _lastNameFocus,
                                    nextFocusNode: _mobileFocus,
                                    textInputType: TextInputType.text,
                                    inputAction: TextInputAction.next,
                                    prefixIcon: const Icon(Icons.person,
                                        color: AppPalette.primary),
                                  ),
                                  // CustomTextField(
                                  //   hintText: 'last name',
                                  //   controller: _lastNameController,
                                  //   focusNode: _lastNameFocus,
                                  //   nextFocus: _mobileFocus,
                                  //   inputAction: TextInputAction.next,
                                  //   inputType: TextInputType.text,
                                  //   prefixIcon: Icons.person,
                                  //   onSubmit: (String text) {},
                                  // ),
                                  16.heightBox,
                                  // CustomTextField(
                                  //   hintText: 'mobile number',
                                  //   controller: _mobileController,
                                  //   focusNode: _mobileFocus,
                                  //   nextFocus: _emailFocus,
                                  //   inputAction: TextInputAction.next,
                                  //   inputType: TextInputType.number,
                                  //   prefixIcon: Icons.phone_android,
                                  //   onSubmit: (String text) {},
                                  // ),
                                  InputTextFormField(
                                    hintText: LocaleKeys.mobileNumber.tr(),
                                    textEditingController: _mobileController,
                                    maxLength: 15,
                                    validator: (val) {
                                      if (val.length < 7) {
                                        return LocaleKeys.enter_a_valid_phone
                                            .tr();
                                      } else {
                                        return null;
                                      }
                                    },
                                    focusNode: _mobileFocus,
                                    nextFocusNode: _emailFocus,
                                    textInputType: TextInputType.phone,
                                    inputAction: TextInputAction.next,
                                    prefixIcon: const Icon(Icons.phone_android,
                                        color: AppPalette.primary),
                                  ),
                                  16.heightBox,
                                  // CustomTextField(
                                  //   hintText: 'Email',
                                  //   controller: _emailController,
                                  //   focusNode: _emailFocus,
                                  //   nextFocus: _passwordFocus,
                                  //   inputAction: TextInputAction.next,
                                  //   inputType: TextInputType.emailAddress,
                                  //   prefixIcon: Icons.email_outlined,
                                  //   onSubmit: (String text) {},
                                  // ),
                                  InputTextFormField(
                                    hintText: LocaleKeys.email.tr(),
                                    textEditingController: _emailController,
                                    validator: (val) {
                                      if (!RegExp(
                                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                          .hasMatch(val)) {
                                        return LocaleKeys.enter_a_valid_email
                                            .tr()
                                            .toString();
                                      } else {
                                        return null;
                                      }
                                    },
                                    focusNode: _emailFocus,
                                    nextFocusNode: _passwordFocus,
                                    textInputType: TextInputType.emailAddress,
                                    inputAction: TextInputAction.next,
                                    prefixIcon: const Icon(Icons.email_outlined,
                                        color: AppPalette.primary),
                                  ),
                                  16.heightBox,
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
                                    nextFocusNode: _confirmedPasswordFocus,
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
                                  28.heightBox,
                                  // InputTextFormField(
                                  //   hintText: AppStrings.confirmedPassword,
                                  //   textEditingController: _passwordConfirmedController,
                                  //   validator: (val) {
                                  //     if (val.length < 6) {
                                  //       return LocaleKeys.password_is_too_short
                                  //           .tr();
                                  //     } else {
                                  //       return null;
                                  //     }
                                  //   },
                                  //   focusNode: _passwordFocus,
                                  //   textInputType:
                                  //   TextInputType.text,
                                  //   nextFocusNode: _confirmedPasswordFocus,
                                  //   secure: cubit.showConfirmedPassword,
                                  //   suffixIcon: InkWell(
                                  //       onTap: (){
                                  //         setState(() {
                                  //           cubit.showConfirmedPassword = !cubit.showConfirmedPassword;
                                  //         });
                                  //       },
                                  //       child: Icon(
                                  //         cubit.showConfirmedPassword
                                  //             ? Icons.visibility
                                  //             : Icons.visibility_off,
                                  //         color: AppPalette.black,
                                  //       )),
                                  //   inputAction: TextInputAction.done,
                                  //   prefixIcon: const Icon(Icons.lock,
                                  //       color: AppPalette.primary),
                                  // ),
                                  // 28.heightBox,
                                  if (cubit.registerLoading)
                                    SpinKitDoubleBounce(
                                      color: Themes.colorApp9,
                                      size: 50.0.sp,
                                    )
                                  else
                                    Container(),
                                  28.heightBox,
                                  CustomButton(
                                    buttonText: LocaleKeys.signUp.tr(),
                                    height: 48.h,
                                    fontSize: Dimensions.fontSizeLarge,
                                    onPressed: () {
                                      _register(cubit);
                                    },
                                  ),
                                  25.heightBox,
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        LocaleKeys.haveAccount.tr(),
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
                                          Navigator.pushNamed(
                                            context,
                                            AppConstants.loginScreen,
                                          );
                                        },
                                        child: Text(
                                          LocaleKeys.login.tr(),
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
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                title: const Text('Sign Up'),
                pinned: false,
                iconTheme: Theme.of(context).iconTheme,
                forceElevated: innerBoxIsScrolled,
              ),
            ];
          },
        ),
      ),
    );
  }

  void _register(AuthCubit cubit) async {
    String _firstName = _firstNameController.text.trim();
    String _lastName = _lastNameController.text.trim();
    String _mobile = _mobileController.text.trim();
    String _email = _emailController.text.trim();
    String _password = _passwordController.text.trim();
    if (_formKey.currentState!.validate()) {
      cubit.registerFunction(context,
          firstName: _firstName,
          lastName: _lastName,
          email: _email,
          phoneNumber: '+2$_mobile',
          password: _password,
          cPassword: _password);
    }
  }

  void _handleLoginListener(BuildContext context, AuthState state) {
    if (state is RegisterErrorState) {
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
    } else if (state is RegisterSuccessState) {
      customFlutterToast(state.responseModel!.message);
      _clearFormData();
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) =>VerificationCodeScreen()), (route) => false);
    }
  }

  void _clearFormData() {
    _firstNameController.clear();
    _lastNameController.clear();
    _mobileController.clear();
    _emailController.clear();
    _passwordController.clear();
    _passwordConfirmedController.clear();
  }

  Widget buildLoginImageItem() => Stack(
        alignment: Alignment.center,
        children: <Widget>[
          SvgPicture.asset(
            Images.loginImageChild,
            height: 50.h,
            width: 50.w,
          ),
          SvgPicture.asset(
            Images.loginImageContainer,
            height: 68.h,
            width: 68.w,
          ),
        ],
      );
}
