import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop/business_logic/profile_cubit/profile_cubit.dart';
import 'package:shop/translations/locale_keys.g.dart';
import 'package:shop/ui/screens/auth/add_new_password.dart';
import 'package:shop/ui/screens/auth/forgert_password_screens/add_new_password_screen.dart';
import 'package:shop/ui/screens/main_screens/profile_screen.dart';
import 'package:shop/ui/screens/user_screens/personal_data_screen.dart';
import 'package:shop/utils/app_constants.dart';
import 'package:shop/utils/app_palette.dart';
import 'package:shop/utils/app_size_boxes.dart';
import '../../../utils/dimensions.dart';
import '../../../utils/images.dart';
import '../../../utils/strings.dart';
import '../../../utils/styles.dart';
import '../../base/custom_button.dart';
import '../../base/custom_text_field.dart';
import '../../widgets/My_products_widgets/add_product_widgets/input_text_form_field.dart';
import 'forgert_password_screens/forget_password_phone_number_screen.dart';

class ChangePasswordScreen extends StatefulWidget {
  ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final FocusNode _passwordFocus = FocusNode();

  final TextEditingController _newPasswordController = TextEditingController();

  final TextEditingController _oldPasswordController = TextEditingController();

  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) =>  PersonalDataScreen()));
        return false;
      },
      child: Scaffold(
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
                  child: BlocBuilder<ProfileCubit,ProfileState>(
                    builder: (context, state) {
                      ProfileCubit profileCubit = ProfileCubit.get(context);
                      return ConstrainedBox(
                        constraints: BoxConstraints(minHeight: 500.h),
                        child: IntrinsicHeight(
                          child: Form(
                            key: formKey,
                            child: Column(
                              children: [
                                Image.asset(
                                  Images.addNewPass,
                                  height: 151.h,
                                  width: 239.w,
                                ),
                                40.heightBox,
                                Text(
                                  LocaleKeys.enterYourPassword.tr(),
                                  style: AppTextStyles.poppinsRegular.copyWith(
                                    fontSize: Dimensions.fontSizeLarge,
                                    color: Colors.black,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                38.heightBox,
                                InputTextFormField(
                                  hintText: LocaleKeys.oldPassword.tr(),
                                  textEditingController: _oldPasswordController,
                                  validator: (val) {
                                    if(val.isNotEmpty){
                                      if (val.length < 6) {
                                        return LocaleKeys.password_is_too_short
                                            .tr();
                                      } else {
                                        return null;
                                      }
                                    }else {
                                      return LocaleKeys.mustNotEmpty.tr();
                                    }
                                  },
                                  textInputType: TextInputType.text,
                                  secure: profileCubit.showOldPassword,
                                  suffixIcon: InkWell(
                                      onTap: (){
                                        profileCubit.toggleOldPassword();
                                      },
                                      child: Icon(
                                        profileCubit.showOldPassword
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: AppPalette.black,
                                      )),
                                  inputAction: TextInputAction.done,
                                  prefixIcon: const Icon(Icons.lock,
                                      color: AppPalette.primary),
                                ),
                                15.heightBox,
                                InputTextFormField(
                                  hintText: LocaleKeys.newPassword.tr(),
                                  textEditingController: _newPasswordController,
                                  validator: (val) {
                                    if(val.isNotEmpty){
                                      if (val.length < 6) {
                                        return LocaleKeys.password_is_too_short
                                            .tr();
                                      } else {
                                        return null;
                                      }
                                    }else {
                                      return LocaleKeys.mustNotEmpty.tr();
                                    }
                                  },
                                  textInputType: TextInputType.text,
                                  secure: profileCubit.showNewPassword,
                                  suffixIcon: InkWell(
                                      onTap: (){
                                        profileCubit.toggleNewPassword();
                                      },
                                      child: Icon(
                                        profileCubit.showNewPassword
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: AppPalette.black,
                                      )),
                                  inputAction: TextInputAction.done,
                                  prefixIcon: const Icon(Icons.lock,
                                      color: AppPalette.primary),
                                ),
                                35.heightBox,
                                state is updateChangePasswordLoadingState ?
                                CircularProgressIndicator(color: AppPalette.primary,) :
                                    Container(),
                                25.heightBox,
                                GestureDetector(
                                  onTap: (){
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => ForgetPasswordPhoneNumberScreen()));
                                  },
                                  child: Text(
                                    LocaleKeys.forgetPassword.tr(),
                                    style: AppTextStyles.poppinsRegular.copyWith(
                                      fontSize: Dimensions.fontSizeLarge,
                                      color: AppPalette.primary,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                15.heightBox,
                                const Spacer(),
                                CustomButton(
                                  buttonText: LocaleKeys.save.tr(),
                                  height: 45.h,
                                  fontSize: Dimensions.fontSizeLarge,
                                  onPressed: () {
                                   if(formKey.currentState!.validate()){
                                     print('new password');
                                     print(_newPasswordController.text);
                                     print('old password');
                                     print(_oldPasswordController.text);

                                     profileCubit.changePassword(context, _newPasswordController.text,
                                         _oldPasswordController.text);
                                   }
                                  },
                                )
                              ],
                            ),
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
                  title: Text(LocaleKeys.changePassword.tr()),
                  pinned: false,
                  iconTheme: Theme.of(context).iconTheme,
                  forceElevated: innerBoxIsScrolled,
                ),
              ];
            },
          ),
        ),
      ),
    );
  }
}
