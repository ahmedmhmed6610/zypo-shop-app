import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop/business_logic/auth_cubit/auth_cubit.dart';
import 'package:shop/helpers/validators.dart';
import 'package:shop/translations/locale_keys.g.dart';
import 'package:shop/ui/base/custom_button.dart';
import 'package:shop/utils/app_palette.dart';
import 'package:shop/utils/app_size_boxes.dart';
import 'package:shop/utils/dimensions.dart';
import 'package:shop/utils/styles.dart';

class ForgetPasswordOTPScreen extends StatefulWidget {
  ForgetPasswordOTPScreen({Key? key,this.phone}) : super(key: key);
  String? phone;

  @override
  State<ForgetPasswordOTPScreen> createState() => _ForgetPasswordOTPScreenState();
}

class _ForgetPasswordOTPScreenState extends State<ForgetPasswordOTPScreen> {
  final formKey = GlobalKey<FormState>();

  final pinController = TextEditingController();

  final focusNode = FocusNode();

  String value = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('phone number');
    print(widget.phone);
  }

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

        //  print("sssssssssss ${authCubit.phoneNum} ");
          return
              // authCubit.confirmPasswordOTPLoading
              //   ? Container()
              //   :
              Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    Image.asset(
                      "assets/images/otp.png",
                    ),
                    15.heightBox,
                    Text(LocaleKeys.pleaseEnterTheCode.tr(),
                        textAlign: TextAlign.center,
                        style: AppTextStyles.poppinsRegular.copyWith(
                            color: AppPalette.black,
                            fontWeight: FontWeight.w600)),
                    5.heightBox,
                    Text(
                        "${LocaleKeys.mobileNumber.tr()} ${authCubit.getPhoneNumber()}",
                        textAlign: TextAlign.center,
                        style: AppTextStyles.poppinsRegular.copyWith(
                            color: AppPalette.black,
                            fontWeight: FontWeight.w600)),
                    15.heightBox,
                    // Form(
                    //     key: formKey,
                    //     child: Pinput(
                    //       forceErrorState: false,
                    //       controller: pinController,
                    //       length: 4,
                    //       // errorText: 'Error',
                    //       androidSmsAutofillMethod:
                    //           AndroidSmsAutofillMethod.smsRetrieverApi,
                    //       defaultPinTheme: authCubit.defaultPinTheme(),
                    //       validator: (value) {
                    //         if (value != null) {
                    //           return Validators.validatePinCode(value);
                    //         }
                    //         return null;
                    //       },
                    //       onClipboardFound: (value) {
                    //         debugPrint('onClipboardFound: $value');
                    //         pinController.setText(value);
                    //       },
                    //       hapticFeedbackType: HapticFeedbackType.lightImpact,
                    //       onCompleted: (String val) {
                    //         value = val;
                    //         if (val.length == 4) {
                    //           authCubit.confirmPasswordOTPFunction(
                    //             context,
                    //             phoneNumber: authCubit.phoneNum!,
                    //             code: val,
                    //           );
                    //         }
                    //       },
                    //       cursor: Column(
                    //         mainAxisAlignment: MainAxisAlignment.end,
                    //         children: [
                    //           Container(
                    //             width: 22,
                    //             height: 1,
                    //             color: Colors.grey,
                    //             margin: const EdgeInsets.only(bottom: 9),
                    //           ),
                    //         ],
                    //       ),
                    //       // focusedPinTheme: defaultPinTheme(size).copyWith(
                    //       //   decoration:
                    //       //       defaultPinTheme(size).decoration!.copyWith(
                    //       //             borderRadius: BorderRadius.circular(8),
                    //       //             border: Border.all(color: Colors.grey),
                    //       //           ),
                    //       // ),
                    //       // submittedPinTheme: defaultPinTheme(size).copyWith(
                    //       //   decoration:
                    //       //       defaultPinTheme(size).decoration!.copyWith(
                    //       //             color: inputBorderColor,
                    //       //             borderRadius: BorderRadius.circular(8),
                    //       //             border: Border.all(color: inputBorderColor),
                    //       //           ),
                    //       // ),
                    //       // errorPinTheme: defaultPinTheme(size).copyBorderWith(
                    //       //   border: Border.all(color: Colors.redAccent),
                    //       // ),
                    //       pinputAutovalidateMode:
                    //           PinputAutovalidateMode.onSubmit,
                    //     )),
                    48.heightBox,
                    authCubit.forgetPasswordLoading ?
                        Center(
                          child: SizedBox(
                            height: 35,
                              width: 35,
                              child: const CircularProgressIndicator(color: AppPalette.primary,)),
                        ) :
                        Container(),
                    GestureDetector(
                      onTap: (){
                        authCubit.resendCondeFunction(context, phoneNumber: '${widget.phone}');
                      },
                      child: Text(
                        LocaleKeys.resendCode.tr(),
                        style: AppTextStyles.poppinsRegular,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              30.heightBox,
              if (!authCubit.confirmPasswordOTPLoading)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: CustomButton(
                      buttonText: LocaleKeys.verify.tr(),
                      height: 48.h,
                      fontSize: Dimensions.fontSizeLarge,
                      onPressed: () {
                        if (value.length == 4) {
                          authCubit.confirmPasswordOTPFunction(
                            context,
                            phoneNumber: authCubit.phoneNum!,
                            code: value,
                          );
                        }
                      }),
                )
              else
                const Center(
                  child: CircularProgressIndicator(
                    color: AppPalette.primary,
                  ),
                ),
              30.heightBox,
            ],
          );
        },
      ),
    );
  }
}
