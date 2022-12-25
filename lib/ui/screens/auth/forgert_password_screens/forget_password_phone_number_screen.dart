import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop/business_logic/auth_cubit/auth_cubit.dart';
import 'package:shop/translations/locale_keys.g.dart';
import 'package:shop/ui/base/custom_button.dart';
import 'package:shop/ui/widgets/My_products_widgets/add_product_widgets/input_text_form_field.dart';
import 'package:shop/utils/app_palette.dart';
import 'package:shop/utils/app_size_boxes.dart';
import 'package:shop/utils/dimensions.dart';
import 'package:shop/utils/styles.dart';

class ForgetPasswordPhoneNumberScreen extends StatelessWidget {
  ForgetPasswordPhoneNumberScreen({Key? key}) : super(key: key);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: Theme.of(context).iconTheme,
        title: Text(
          LocaleKeys.forgotPassword.tr(),
        ),
        leading: InkWell(
          onTap: () => Navigator.of(context).pop(),
          child: const Icon(Icons.arrow_back_ios,
              size: 20.0, color: AppPalette.black),
        ),
      ),
      body: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          AuthCubit authCubit = BlocProvider.of<AuthCubit>(context);
          return Form(
            key: _formKey,
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      Image.asset(
                        "assets/images/resetPassword.png",
                      ),
                      15.heightBox,
                      Text(LocaleKeys.enterYourMobilePhone.tr(),
                          textAlign: TextAlign.center,
                          style: AppTextStyles.poppinsRegular.copyWith(
                              color: AppPalette.black,
                              fontWeight: FontWeight.w600)),
                      25.heightBox,
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: InputTextFormField(
                          hintText: LocaleKeys.mobileNumber.tr(),
                          textEditingController: _phoneController,
                          validator: (val) {
                            if (val.length < 8) {
                              return LocaleKeys.enter_a_valid_phone.tr();
                            } else {
                              return null;
                            }
                          },
                          textInputType: TextInputType.phone,
                          inputAction: TextInputAction.next,
                          prefixIcon: const Icon(Icons.phone_android,
                              color: AppPalette.primary),
                        ),
                      ),
                      15.heightBox,
                    ],
                  ),
                ),
                30.heightBox,
                if (!authCubit.forgetPasswordLoading)
                  Container()
                else
                  const Center(
                    child: CircularProgressIndicator(
                      color: AppPalette.primary,
                    ),
                  ),
                30.heightBox,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: CustomButton(
                    buttonText: LocaleKeys.confirm.tr(),
                    height: 48.h,
                    fontSize: Dimensions.fontSizeLarge,
                    onPressed: () => confirm(context, authCubit),
                  ),
                ),
                10.heightBox,
              ],
            ),
          );
        },
      ),
    );
  }

  void confirm(BuildContext context, AuthCubit cubit) {
    if (_formKey.currentState!.validate()) {
      cubit.forgetPasswordFunction(
        context,
        phoneNumber: _phoneController.text,
      );
    }
  }
}
