import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop/translations/locale_keys.g.dart';
import 'package:shop/utils/app_constants.dart';
import 'package:shop/utils/app_size_boxes.dart';
import '../../../utils/dimensions.dart';
import '../../../utils/images.dart';
import '../../../utils/strings.dart';
import '../../../utils/styles.dart';
import '../../base/custom_button.dart';
import '../../base/custom_text_field.dart';

class AddNewPassword extends StatelessWidget {
  AddNewPassword({Key? key}) : super(key: key);
  final FocusNode _passwordFocus = FocusNode();
  final TextEditingController _passwordController = TextEditingController();

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
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: 500.h),
                  child: IntrinsicHeight(
                    child: Column(
                      children: [
                        Image.asset(
                          Images.addNewPass,
                          height: 151.h,
                          width: 239.w,
                        ),
                        40.heightBox,
                        Text(
                          LocaleKeys.enterNewPassword.tr(),
                          style: AppTextStyles.poppinsRegular.copyWith(
                            fontSize: Dimensions.fontSizeLarge,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        38.heightBox,
                        CustomTextField(
                          hintText: LocaleKeys.password.tr(),
                          controller: _passwordController,
                          focusNode: _passwordFocus,
                          inputAction: TextInputAction.done,
                          inputType: TextInputType.visiblePassword,
                          prefixIcon: Icons.lock,
                          isPassword: true,
                          onSubmit: (String text) {},
                        ),
                        const Spacer(),
                        CustomButton(
                          buttonText: LocaleKeys.save.tr(),
                          height: 35.h,
                          fontSize: Dimensions.fontSizeLarge,
                          onPressed: () {
                            Navigator.popAndPushNamed(
                              context,
                              AppConstants.loginScreen,
                            );
                          },
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                title: Text(LocaleKeys.forgetPassword.tr(),),
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
}
