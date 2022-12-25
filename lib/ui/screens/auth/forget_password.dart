import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shop/utils/app_constants.dart';
import 'package:shop/utils/app_palette.dart';
import '../../../utils/app_size_boxes.dart';
import '../../../utils/styles.dart';
import '../../../utils/dimensions.dart';
import '../../../utils/images.dart';
import '../../base/custom_button.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({Key? key}) : super(key: key);
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
                          Images.forgetPassword,
                          height: 151.h,
                          width: 239.w,
                        ),
                        40.heightBox,
                        Text(
                          'Please enter the 4 Digit code sent to mobile number 01066410518',
                          style: AppTextStyles.poppinsRegular.copyWith(
                            fontSize: Dimensions.fontSizeLarge,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        47.heightBox,
                        _buildPinCodeFields(context),
                        30.heightBox,
                        Text(
                          'Resend code!',
                          style: AppTextStyles.poppinsRegular,
                        ),
                        const Spacer(),
                        CustomButton(
                          buttonText: 'Verify',
                          height: 35.h,
                          fontSize: Dimensions.fontSizeLarge,
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              AppConstants.addNewPasswordScreen,
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
                title: const Text('Forgot password'),
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

  Widget _buildPinCodeFields(BuildContext context) {
    return PinCodeTextField(
      appContext: context,
      autoFocus: true,
      cursorColor: Colors.black,
      keyboardType: TextInputType.number,
      length: 6,
      obscureText: false,
      animationType: AnimationType.scale,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(5),
        fieldHeight: 50,
        fieldWidth: 40,
        borderWidth: 1,
        activeColor: Colors.black54,
        inactiveColor: AppPalette.lightPrimary,
        inactiveFillColor: AppPalette.primary,
        activeFillColor: AppPalette.lightPrimary,
        selectedColor: AppPalette.primary,
        selectedFillColor: AppPalette.lightPrimary,
      ),
      animationDuration: const Duration(milliseconds: 300),
      backgroundColor: Colors.white,
      enableActiveFill: true,
      onCompleted: (submitedCode) {},
      onChanged: (value) {
      },
    );
  }
}
