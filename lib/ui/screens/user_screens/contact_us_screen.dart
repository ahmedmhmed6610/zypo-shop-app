
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shop/business_logic/app_layout_cubit/app_layout_cubit.dart';
import 'package:shop/business_logic/contact_us_cubit.dart';
import 'package:shop/helpers/cache_helper.dart';
import 'package:shop/translations/locale_keys.g.dart';
import 'package:shop/ui/base/custom_button.dart';
import 'package:shop/ui/screens/layout/app_layout.dart';
import 'package:shop/ui/widgets/My_products_widgets/add_product_widgets/input_text_form_field.dart';
import 'package:shop/ui/widgets/contact_us_widgets/contact_avatar.dart';
import 'package:shop/ui/widgets/contact_us_widgets/contact_hint_widget.dart';
import 'package:shop/ui/widgets/contact_us_widgets/contact_us_background.dart';
import 'package:shop/utils/app_palette.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shop/utils/app_size_boxes.dart';
import 'package:shop/utils/dimensions.dart';

import '../../../data/internet_connectivity/no_internet.dart';
import '../../../utils/Themes.dart';
import '../../../utils/app_constants.dart';
import '../../base/custom_toast.dart';
import '../filter_screens/widget_custom.dart';

class ContactUsScreen extends StatefulWidget {
  ContactUsScreen({Key? key}) : super(key: key);

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _messageController = TextEditingController();

  String? firstName;
  String? lastName;
  String? email;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    firstName = CacheHelper.getData(key: 'FirstName');
    lastName = CacheHelper.getData(key: 'LastName');
    email = CacheHelper.getData(key: "Email");

    _nameController.text = firstName !=null ? '$firstName  $lastName' : 'User Name';
    _emailController.text = firstName !=null ? '$email' : 'User Name';

  }

  @override
  Widget build(BuildContext context) {
    final stateProductConnection = context.watch<AppLayoutCubit>().state;
    return Scaffold(
      backgroundColor: AppPalette.primary,
      body: CustomAppBar(
        onTap: () {
          AppLayoutCubit.get(context).onItemTapped(3);
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => AppLayout(),
              ),
                  (route) => false);
        },
        title: LocaleKeys.contactUs.tr(),
        widgetCustom:  stateProductConnection is ConnectionSuccess ?
        BlocConsumer<ContactUsCubit,ContactUsState>(
          listener: (BuildContext context, ContactUsState state){
            _handleLoginListener(context, state);
          },
          builder: (BuildContext context, ContactUsState state){
            ContactUsCubit cubit = ContactUsCubit.get(context);
            return Stack(
              children: [
             //   ContactUsBackground(),
                Align(
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: Dimensions.paddingSizeLarge,
                      left: Dimensions.paddingSizeExtraLarge,
                      right: Dimensions.paddingSizeExtraLarge,
                      bottom: Dimensions.paddingSizeDefault,
                    ),
                    child: Column(
                      children: [
                        Expanded(
                            child: SingleChildScrollView(
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const ContactAvatar(),
                                    10.heightBox,
                                    const ContactHintWidget(),
                                    15.heightBox,
                                    Card(
                                      shadowColor: AppPalette.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(Dimensions.radiusSmall)
                                      ),
                                      elevation: 3,
                                      child: Padding(
                                        padding:  EdgeInsets.all(5.sp),
                                        child: Column(
                                          children: [
                                            15.heightBox,
                                            InputTextFormField(
                                              hintText: LocaleKeys.name.tr(),
                                              textEditingController: _nameController,
                                              validator: (val) {
                                                if (val.isEmpty) {
                                                  return LocaleKeys.enter_your_name.tr();
                                                } else {
                                                  return null;
                                                }
                                              },
                                              // focusNode: _firstNameFocus,
                                              // nextFocusNode: _lastNameFocus,
                                              textInputType: TextInputType.name,
                                              inputAction: TextInputAction.next,
                                            ),
                                            20.heightBox,
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
                                              // focusNode: _emailFocus,
                                              // nextFocusNode: _passwordFocus,
                                              textInputType: TextInputType.emailAddress,
                                              inputAction: TextInputAction.next,
                                            ),
                                            20.heightBox,
                                            InputTextFormField(
                                              hintText: LocaleKeys.message.tr(),
                                              textEditingController: _messageController,
                                              validator: (val) {
                                                if (val.isEmpty) {
                                                  return LocaleKeys.message.tr();
                                                } else {
                                                  return null;
                                                }
                                              },
                                              // focusNode: _firstNameFocus,
                                              // nextFocusNode: _lastNameFocus,
                                              maxLines: 4,
                                              textInputType: TextInputType.name,
                                              inputAction: TextInputAction.next,
                                            ),
                                            20.heightBox,
                                          ],
                                        ),
                                      ),
                                    ),
                                    20.heightBox,
                                  ],
                                ),
                              ),
                            )),
                        if (state is LoadingContactUs)
                          SpinKitDoubleBounce(
                            color: Themes.colorApp13,
                            size: 50.0.sp,
                          ) else
                          Container(),
                        15.heightBox,
                        CustomButton(
                          buttonText: LocaleKeys.send.tr(),
                          onPressed: () => send(cubit),
                          height: 48.h,
                          fontSize: Dimensions.fontSizeLarge,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ) : NoInternetConnectionScreen(appLayoutState: stateProductConnection),),
    );
  }

  void _handleLoginListener(BuildContext context, ContactUsState state) {
    if(state is ErrorContactUs){
      customFlutterToast(state.error);
    }else if(state is SuccessContactUs){
      customFlutterToast(state.responseModel.message);
      _clearFormData();
      Navigator.pushNamedAndRemoveUntil(
          context, AppConstants.appLayout, (_) => false);
    }
  }

  void _clearFormData() {
    _nameController.clear();
    _emailController.clear();
    _messageController.clear();
  }

  void send(ContactUsCubit cubit) {
  Connectivity().checkConnectivity().then((connectivityResult){
    if(connectivityResult == ConnectivityResult.wifi || connectivityResult == ConnectivityResult.mobile){
      if (_formKey.currentState!.validate()) {
        customFlutterToast("${_nameController.text}");
        customFlutterToast("${_emailController.text}");
        customFlutterToast("${_messageController.text}");
        cubit.sendContactUsData(context, name: _nameController.text,
            email: _emailController.text, message: _messageController.text);
      }
    }else {
      customFlutterToast("no internet connection");
    }
  });
  }

}


