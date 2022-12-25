import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:shop/business_logic/my_products_cubit/my_products_state.dart';
import 'package:shop/business_logic/personal_data_cubit/personal_data_cubit.dart';
import 'package:shop/business_logic/profile_cubit/profile_cubit.dart';
import 'package:shop/business_logic/update_profile_cubit/update_profile_cubit.dart';
import 'package:shop/helpers/components.dart';
import 'package:shop/translations/locale_keys.g.dart';
import 'package:shop/ui/base/custom_button.dart';
import 'package:shop/ui/screens/layout/app_layout.dart';
import 'package:shop/ui/widgets/My_products_widgets/add_product_widgets/input_text_form_field.dart';
import 'package:shop/utils/app_constants.dart';
import 'package:shop/utils/app_palette.dart';
import 'package:shop/utils/app_size_boxes.dart';
import 'package:shop/utils/styles.dart';
import '../../../libraries/dialog_widget.dart';
import '../../../utils/LoadingWidget.dart';
import '../../../utils/Themes.dart';
import '../../../utils/dimensions.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../base/custom_toast.dart';
import '../auth/add_new_password.dart';
import '../auth/change_password_screen.dart';
import '../filter_screens/widget_custom.dart';

class PersonalDataScreen extends StatefulWidget {
  PersonalDataScreen({Key? key}) : super(key: key);

  @override
  State<PersonalDataScreen> createState() => _PersonalDataScreenState();
}

class _PersonalDataScreenState extends State<PersonalDataScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

  }
  // final FocusNode _firstNameFocus = FocusNode();
  //
  // final FocusNode _lastNameFocus = FocusNode();
  //
  // final FocusNode _mobileFocus = FocusNode();
  //
  // final FocusNode _emailFocus = FocusNode();
  String? lottie;
 // final FocusNode _passwordFocus = FocusNode();

  // bool ActiveConnection = false;
  // String T = "";
  //
  // Future CheckUserConnection() async {
  //   try {
  //     final result = await InternetAddress.lookup('google.com');
  //     if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
  //       setState(() {
  //         ActiveConnection = true;
  //         T = "Turn off the data and repress again";
  //         print(T);
  //         print(ActiveConnection);
  //         CustomFlutterToast(T);
  //         CustomFlutterToast(ActiveConnection.toString());
  //       });
  //     }
  //   } on SocketException catch (_) {
  //     setState(() {
  //       ActiveConnection = false;
  //       T = "Turn On the data and repress again";
  //       print(T);
  //       print(ActiveConnection);
  //       CustomFlutterToast(T);
  //       CustomFlutterToast(ActiveConnection.toString());
  //     });
  //   }
  // }
  File? imageFile;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<ProfileCubit>(context, listen: false).getUserProfile();

    String profileImage =
        "https://img.freepik.com/free-vector/cute-gentleman-character-illustration_24877-60133.jpg?t=st=1658505623~exp=1658506223~hmac=3ee77155aae3cea1d1f3d7eccb20aa72617e4dfb894551a6223da59d10b52718&w=740";
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => AppLayout()));
        return false;
      },
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: AppPalette.primary,
        body: CustomAppBar(
          onTap: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => AppLayout()));
          },
          title: LocaleKeys.profile.tr(),
          widgetCustom:  BlocConsumer<ProfileCubit, ProfileState>(
            listener: (BuildContext context, ProfileState state) async {
              //  _handleLoginListener(context, state);
            },
            builder: (BuildContext context, ProfileState state) {
              ProfileCubit profileCubit = ProfileCubit.get(context);
              //      print("response is ${profileCubit.loginModel?.user?.userFirstName}");
              if (state is ErrorProfileState) {
                //  CustomFlutterToast(state.error);
                return LoadingWidget(data: '');
              } else if (state is SuccessProfileState) {
                var name = '${state.userDataModel?.user?.userName}';
                // var splitName = name.split(' ');
                // var firstName = splitName[0].trim();
                // var lastName = splitName[1].trim();
                //  CustomFlutterToast(state.userDataModel?.user?.phoneNumber);
                //  CustomFlutterToast(state.userDataModel?.user?.userName);
                profileCubit.firstNameController.text =
                '${state.userDataModel?.user?.userFirstName}';

                profileCubit.lastNameController.text =
                '${state.userDataModel?.user?.userLastName}';

                profileCubit.emailController.text =
                '${state.userDataModel?.user?.userEmail}';

                profileCubit.mobileController.text =
                '${state.userDataModel?.user?.phoneNumber}';

                String profileImageUser =
                    '${state.userDataModel?.user?.userImagePath}/${state.userDataModel?.user?.photo}';
                File profileImageUserName = File(
                    '${state.userDataModel?.user?.userImagePath}/${state.userDataModel?.user?.photo}');
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      25.heightBox,
                      BlocBuilder<UpdateProfileCubit, UpdateProfileState>(
                        builder: (context, stateUpdateProfile) {
                          UpdateProfileCubit updateProfileCubit =
                          UpdateProfileCubit.get(context);
                          return Column(
                            children: [
                              state.userDataModel?.user?.photo != null
                                  ? Center(
                                child: Stack(
                                  children: [
                                    imageFile != null
                                        ? GestureDetector(
                                      onTap: () async {
                                        showDialog(
                                            context: _scaffoldKey.currentContext!,
                                            builder: (context) =>
                                                Dialog(
                                                  backgroundColor: Colors.white,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(Dimensions.radiusDefault)),
                                                  alignment: Alignment.bottomCenter,
                                                  insetPadding: EdgeInsets.symmetric(
                                                      vertical: Dimensions.paddingSize, horizontal: Dimensions.paddingSize),
                                                  child: CustomDialogWidget(
                                                    msgStyle: const TextStyle(height: 2),
                                                    // title: LocaleKeys.chosePhotoWith.tr(),
                                                    titleStyle: const TextStyle(
                                                      color: Colors.blueGrey,
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                    actions: [
                                                      Padding(
                                                        padding:
                                                        EdgeInsets.symmetric(horizontal: Dimensions.paddingSmall),
                                                        child: IconsButton(
                                                          onPressed: () async {
                                                            try {
                                                              final image = await ImagePicker()
                                                                  .pickImage(
                                                                  source:
                                                                  ImageSource.gallery);
                                                              if (image ==
                                                                  null)
                                                                return;
                                                              final iamgeTempoary =
                                                              File(image
                                                                  .path);
                                                              setState(() =>
                                                              imageFile =
                                                                  iamgeTempoary);
                                                              // addProductCubit.updateImageProduct(context, stateProductDetails.showDetailsProductResponseModel![0].id.toString(), image1!);
                                                              updateProfileCubit.updateProfileImageUser(
                                                                  context,
                                                                  profileCubit
                                                                      .firstNameController
                                                                      .text,
                                                                  profileCubit
                                                                      .lastNameController
                                                                      .text,
                                                                  profileCubit
                                                                      .emailController
                                                                      .text,
                                                                  profileCubit
                                                                      .mobileController
                                                                      .text,
                                                                  imageFile!);
                                                            } on PlatformException catch (e) {
                                                              if (kDebugMode) {
                                                                print(e);
                                                              }
                                                            }
                                                            Navigator.pop(context);
                                                          },
                                                          text: LocaleKeys.gallery.tr(),
                                                          // color: Colors.transparent,
                                                          shape: OutlineInputBorder(
                                                              borderSide: const BorderSide(color: AppPalette.black),
                                                              borderRadius:
                                                              BorderRadius.circular(Dimensions.radiusDefault)),
                                                          textStyle: const TextStyle(color: Colors.black),
                                                          padding: EdgeInsets.symmetric(
                                                              horizontal: Dimensions.paddingSizeExtraSmall,
                                                              vertical: Dimensions.paddingSizeDefault),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                        EdgeInsets.symmetric(horizontal: Dimensions.paddingSmall),
                                                        child: IconsButton(
                                                          onPressed: () async {
                                                            try {
                                                              final image = await ImagePicker()
                                                                  .pickImage(
                                                                  source:
                                                                  ImageSource.camera);
                                                              if (image ==
                                                                  null)
                                                                return;
                                                              final iamgeTempoary =
                                                              File(image
                                                                  .path);
                                                              setState(() =>
                                                              imageFile =
                                                                  iamgeTempoary);
                                                              // addProductCubit.updateImageProduct(context, stateProductDetails.showDetailsProductResponseModel![0].id.toString(), image1!);
                                                              updateProfileCubit.updateProfileImageUser(
                                                                  context,
                                                                  profileCubit
                                                                      .firstNameController
                                                                      .text,
                                                                  profileCubit
                                                                      .lastNameController
                                                                      .text,
                                                                  profileCubit
                                                                      .emailController
                                                                      .text,
                                                                  profileCubit
                                                                      .mobileController
                                                                      .text,
                                                                  imageFile!);
                                                            } on PlatformException catch (e) {
                                                              if (kDebugMode) {
                                                                print(e);
                                                              }
                                                            }
                                                            Navigator.pop(context);
                                                          },
                                                          text: LocaleKeys.camera.tr(),
                                                          // iconData: Icons.done,
                                                          color: AppPalette.primary,
                                                          textStyle: const TextStyle(color: Colors.white),
                                                          shape: OutlineInputBorder(
                                                              borderSide: BorderSide.none,
                                                              borderRadius:
                                                              BorderRadius.circular(Dimensions.radiusDefault)),
                                                          padding: EdgeInsets.symmetric(
                                                              horizontal: Dimensions.paddingSizeExtraSmall,
                                                              vertical: Dimensions.paddingSizeDefault),
                                                          // iconColor: Colors.white,
                                                        ),
                                                      ),
                                                    ],
                                                    animationBuilder: lottie != null
                                                        ? LottieBuilder.asset(
                                                      lottie.toString(),
                                                    )
                                                        : null,
                                                    customView: Dialogs.holder,
                                                    color: Colors.white,
                                                  ),
                                                )
                                        );

                                      },
                                      child: ClipOval(
                                        child: Image.file(
                                          imageFile!,
                                          width: 95.w,
                                          height: 95.h,
                                          fit: BoxFit
                                              .cover,
                                        ),
                                      ),
                                    )
                                        : GestureDetector(
                                      onTap: () async {
                                        showDialog(
                                            context: _scaffoldKey.currentContext!,
                                            builder: (context) =>
                                                Dialog(
                                                  backgroundColor: Colors.white,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(Dimensions.radiusDefault)),
                                                  alignment: Alignment.bottomCenter,
                                                  insetPadding: EdgeInsets.symmetric(
                                                      vertical: Dimensions.paddingSize, horizontal: Dimensions.paddingSize),
                                                  child: CustomDialogWidget(
                                                    msgStyle: const TextStyle(height: 2),
                                                    //  title: LocaleKeys.chosePhotoWith.tr(),
                                                    titleStyle: const TextStyle(
                                                      color: Colors.blueGrey,
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                    actions: [
                                                      Padding(
                                                        padding:
                                                        EdgeInsets.symmetric(horizontal: Dimensions.paddingSmall),
                                                        child: IconsButton(
                                                          onPressed: () async {
                                                            try {
                                                              final image = await ImagePicker()
                                                                  .pickImage(
                                                                  source:
                                                                  ImageSource.gallery);
                                                              if (image ==
                                                                  null)
                                                                return;
                                                              final iamgeTempoary =
                                                              File(image
                                                                  .path);
                                                              setState(() =>
                                                              imageFile =
                                                                  iamgeTempoary);
                                                              // addProductCubit.updateImageProduct(context, stateProductDetails.showDetailsProductResponseModel![0].id.toString(), image1!);
                                                              updateProfileCubit.updateProfileImageUser(
                                                                  context,
                                                                  profileCubit
                                                                      .firstNameController
                                                                      .text,
                                                                  profileCubit
                                                                      .lastNameController
                                                                      .text,
                                                                  profileCubit
                                                                      .emailController
                                                                      .text,
                                                                  profileCubit
                                                                      .mobileController
                                                                      .text,
                                                                  imageFile!);
                                                            } on PlatformException catch (e) {
                                                              if (kDebugMode) {
                                                                print(e);
                                                              }
                                                            }
                                                            Navigator.pop(context);
                                                          },
                                                          text: LocaleKeys.gallery.tr(),
                                                          // color: Colors.transparent,
                                                          shape: OutlineInputBorder(
                                                              borderSide: const BorderSide(color: AppPalette.black),
                                                              borderRadius:
                                                              BorderRadius.circular(Dimensions.radiusDefault)),
                                                          textStyle: const TextStyle(color: Colors.black),
                                                          padding: EdgeInsets.symmetric(
                                                              horizontal: Dimensions.paddingSizeExtraSmall,
                                                              vertical: Dimensions.paddingSizeDefault),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                        EdgeInsets.symmetric(horizontal: Dimensions.paddingSmall),
                                                        child: IconsButton(
                                                          onPressed: () async {
                                                            try {
                                                              final image = await ImagePicker()
                                                                  .pickImage(
                                                                  source:
                                                                  ImageSource.camera);
                                                              if (image ==
                                                                  null)
                                                                return;
                                                              final iamgeTempoary =
                                                              File(image
                                                                  .path);
                                                              setState(() =>
                                                              imageFile =
                                                                  iamgeTempoary);
                                                              // addProductCubit.updateImageProduct(context, stateProductDetails.showDetailsProductResponseModel![0].id.toString(), image1!);
                                                              updateProfileCubit.updateProfileImageUser(
                                                                  context,
                                                                  profileCubit
                                                                      .firstNameController
                                                                      .text,
                                                                  profileCubit
                                                                      .lastNameController
                                                                      .text,
                                                                  profileCubit
                                                                      .emailController
                                                                      .text,
                                                                  profileCubit
                                                                      .mobileController
                                                                      .text,
                                                                  imageFile!);
                                                            } on PlatformException catch (e) {
                                                              if (kDebugMode) {
                                                                print(e);
                                                              }
                                                            }
                                                            Navigator.pop(context);
                                                          },
                                                          text: LocaleKeys.camera.tr(),
                                                          // iconData: Icons.done,
                                                          color: AppPalette.primary,
                                                          textStyle: const TextStyle(color: Colors.white),
                                                          shape: OutlineInputBorder(
                                                              borderSide: BorderSide.none,
                                                              borderRadius:
                                                              BorderRadius.circular(Dimensions.radiusDefault)),
                                                          padding: EdgeInsets.symmetric(
                                                              horizontal: Dimensions.paddingSizeExtraSmall,
                                                              vertical: Dimensions.paddingSizeDefault),
                                                          // iconColor: Colors.white,
                                                        ),
                                                      ),
                                                    ],
                                                    animationBuilder: lottie != null
                                                        ? LottieBuilder.asset(
                                                      lottie.toString(),
                                                    )
                                                        : null,
                                                    customView: Dialogs.holder,
                                                    color: Colors.white,
                                                  ),
                                                )
                                        );

                                      },
                                      child: ClipOval(
                                        child:
                                        FadeInImage(
                                          image: NetworkImage(
                                              profileImageUser),
                                          fit: BoxFit
                                              .cover,
                                          width: 95.w,
                                          height: 95.h,
                                          placeholder: const AssetImage('assets/images/loader.gif'),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: MediaQuery.of(context).size.height * 0.024 * .1,
                                      right: MediaQuery.of(context).size.height * 0.024 * .2,
                                      child: GestureDetector(
                                        onTap: () async {
                                          showDialog(
                                              context: _scaffoldKey.currentContext!,
                                              builder: (context) =>
                                                  Dialog(
                                                    backgroundColor: Colors.white,
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(Dimensions.radiusDefault)),
                                                    alignment: Alignment.bottomCenter,
                                                    insetPadding: EdgeInsets.symmetric(
                                                        vertical: Dimensions.paddingSize, horizontal: Dimensions.paddingSize),
                                                    child: CustomDialogWidget(
                                                      msgStyle: const TextStyle(height: 2),
                                                      //   title: LocaleKeys.chosePhotoWith.tr(),
                                                      titleStyle: const TextStyle(
                                                        color: Colors.blueGrey,
                                                        overflow: TextOverflow.ellipsis,
                                                      ),
                                                      actions: [
                                                        Padding(
                                                          padding:
                                                          EdgeInsets.symmetric(horizontal: Dimensions.paddingSmall),
                                                          child: IconsButton(
                                                            onPressed: () async {
                                                              try {
                                                                final image = await ImagePicker()
                                                                    .pickImage(
                                                                    source:
                                                                    ImageSource.gallery);
                                                                if (image ==
                                                                    null)
                                                                  return;
                                                                final iamgeTempoary =
                                                                File(image
                                                                    .path);
                                                                setState(() =>
                                                                imageFile =
                                                                    iamgeTempoary);
                                                                // addProductCubit.updateImageProduct(context, stateProductDetails.showDetailsProductResponseModel![0].id.toString(), image1!);
                                                                updateProfileCubit.updateProfileImageUser(
                                                                    context,
                                                                    profileCubit
                                                                        .firstNameController
                                                                        .text,
                                                                    profileCubit
                                                                        .lastNameController
                                                                        .text,
                                                                    profileCubit
                                                                        .emailController
                                                                        .text,
                                                                    profileCubit
                                                                        .mobileController
                                                                        .text,
                                                                    imageFile!);
                                                              } on PlatformException catch (e) {
                                                                if (kDebugMode) {
                                                                  print(e);
                                                                }
                                                              }
                                                              Navigator.pop(context);
                                                            },
                                                            text: LocaleKeys.gallery.tr(),
                                                            // color: Colors.transparent,
                                                            shape: OutlineInputBorder(
                                                                borderSide: const BorderSide(color: AppPalette.black),
                                                                borderRadius:
                                                                BorderRadius.circular(Dimensions.radiusDefault)),
                                                            textStyle: const TextStyle(color: Colors.black),
                                                            padding: EdgeInsets.symmetric(
                                                                horizontal: Dimensions.paddingSizeExtraSmall,
                                                                vertical: Dimensions.paddingSizeDefault),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                          EdgeInsets.symmetric(horizontal: Dimensions.paddingSmall),
                                                          child: IconsButton(
                                                            onPressed: () async {
                                                              try {
                                                                final image = await ImagePicker()
                                                                    .pickImage(
                                                                    source:
                                                                    ImageSource.camera);
                                                                if (image ==
                                                                    null)
                                                                  return;
                                                                final iamgeTempoary =
                                                                File(image
                                                                    .path);
                                                                setState(() =>
                                                                imageFile =
                                                                    iamgeTempoary);
                                                                // addProductCubit.updateImageProduct(context, stateProductDetails.showDetailsProductResponseModel![0].id.toString(), image1!);
                                                                updateProfileCubit.updateProfileImageUser(
                                                                    context,
                                                                    profileCubit
                                                                        .firstNameController
                                                                        .text,
                                                                    profileCubit
                                                                        .lastNameController
                                                                        .text,
                                                                    profileCubit
                                                                        .emailController
                                                                        .text,
                                                                    profileCubit
                                                                        .mobileController
                                                                        .text,
                                                                    imageFile!);
                                                              } on PlatformException catch (e) {
                                                                if (kDebugMode) {
                                                                  print(e);
                                                                }
                                                              }
                                                              Navigator.pop(context);
                                                            },
                                                            text: LocaleKeys.camera.tr(),
                                                            // iconData: Icons.done,
                                                            color: AppPalette.primary,
                                                            textStyle: const TextStyle(color: Colors.white),
                                                            shape: OutlineInputBorder(
                                                                borderSide: BorderSide.none,
                                                                borderRadius:
                                                                BorderRadius.circular(Dimensions.radiusDefault)),
                                                            padding: EdgeInsets.symmetric(
                                                                horizontal: Dimensions.paddingSizeExtraSmall,
                                                                vertical: Dimensions.paddingSizeDefault),
                                                            // iconColor: Colors.white,
                                                          ),
                                                        ),
                                                      ],
                                                      animationBuilder: lottie != null
                                                          ? LottieBuilder.asset(
                                                        lottie.toString(),
                                                      )
                                                          : null,
                                                      customView: Dialogs.holder,
                                                      color: Colors.white,
                                                    ),
                                                  )
                                          );

                                        },
                                        child: Container(
                                          width: 25,
                                          height: 25,
                                          decoration: BoxDecoration(
                                              color: AppPalette
                                                  .primary,
                                              borderRadius:
                                              BorderRadius
                                                  .circular(
                                                  10)),
                                          child: const Icon(
                                            Icons.edit,
                                            color:
                                            AppPalette.white,
                                            size: 18,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                                  : Center(
                                child: Column(
                                  children: [
                                    imageFile != null
                                        ? GestureDetector(
                                      onTap: () async {
                                        showDialog(
                                            context: _scaffoldKey.currentContext!,
                                            builder: (context) =>
                                                Dialog(
                                                  backgroundColor: Colors.white,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(Dimensions.radiusDefault)),
                                                  alignment: Alignment.bottomCenter,
                                                  insetPadding: EdgeInsets.symmetric(
                                                      vertical: Dimensions.paddingSize, horizontal: Dimensions.paddingSize),
                                                  child: CustomDialogWidget(
                                                    msgStyle: const TextStyle(height: 2),
                                                    //   title: LocaleKeys.chosePhotoWith.tr(),
                                                    titleStyle: const TextStyle(
                                                      color: Colors.blueGrey,
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                    actions: [
                                                      Padding(
                                                        padding:
                                                        EdgeInsets.symmetric(horizontal: Dimensions.paddingSmall),
                                                        child: IconsButton(
                                                          onPressed: () async {
                                                            try {
                                                              final image = await ImagePicker()
                                                                  .pickImage(
                                                                  source:
                                                                  ImageSource.gallery);
                                                              if (image ==
                                                                  null)
                                                                return;
                                                              final iamgeTempoary =
                                                              File(image
                                                                  .path);
                                                              setState(() =>
                                                              imageFile =
                                                                  iamgeTempoary);
                                                              // addProductCubit.updateImageProduct(context, stateProductDetails.showDetailsProductResponseModel![0].id.toString(), image1!);
                                                              updateProfileCubit.updateProfileImageUser(
                                                                  context,
                                                                  profileCubit
                                                                      .firstNameController
                                                                      .text,
                                                                  profileCubit
                                                                      .lastNameController
                                                                      .text,
                                                                  profileCubit
                                                                      .emailController
                                                                      .text,
                                                                  profileCubit
                                                                      .mobileController
                                                                      .text,
                                                                  imageFile!);
                                                            } on PlatformException catch (e) {
                                                              if (kDebugMode) {
                                                                print(e);
                                                              }
                                                            }
                                                            Navigator.pop(context);
                                                          },
                                                          text: LocaleKeys.gallery.tr(),
                                                          // color: Colors.transparent,
                                                          shape: OutlineInputBorder(
                                                              borderSide: const BorderSide(color: AppPalette.black),
                                                              borderRadius:
                                                              BorderRadius.circular(Dimensions.radiusDefault)),
                                                          textStyle: const TextStyle(color: Colors.black),
                                                          padding: EdgeInsets.symmetric(
                                                              horizontal: Dimensions.paddingSizeExtraSmall,
                                                              vertical: Dimensions.paddingSizeDefault),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                        EdgeInsets.symmetric(horizontal: Dimensions.paddingSmall),
                                                        child: IconsButton(
                                                          onPressed: () async {
                                                            try {
                                                              final image = await ImagePicker()
                                                                  .pickImage(
                                                                  source:
                                                                  ImageSource.camera);
                                                              if (image ==
                                                                  null)
                                                                return;
                                                              final iamgeTempoary =
                                                              File(image
                                                                  .path);
                                                              setState(() =>
                                                              imageFile =
                                                                  iamgeTempoary);
                                                              // addProductCubit.updateImageProduct(context, stateProductDetails.showDetailsProductResponseModel![0].id.toString(), image1!);
                                                              updateProfileCubit.updateProfileImageUser(
                                                                  context,
                                                                  profileCubit
                                                                      .firstNameController
                                                                      .text,
                                                                  profileCubit
                                                                      .lastNameController
                                                                      .text,
                                                                  profileCubit
                                                                      .emailController
                                                                      .text,
                                                                  profileCubit
                                                                      .mobileController
                                                                      .text,
                                                                  imageFile!);
                                                            } on PlatformException catch (e) {
                                                              if (kDebugMode) {
                                                                print(e);
                                                              }
                                                            }
                                                            Navigator.pop(context);
                                                          },
                                                          text: LocaleKeys.camera.tr(),
                                                          // iconData: Icons.done,
                                                          color: AppPalette.primary,
                                                          textStyle: const TextStyle(color: Colors.white),
                                                          shape: OutlineInputBorder(
                                                              borderSide: BorderSide.none,
                                                              borderRadius:
                                                              BorderRadius.circular(Dimensions.radiusDefault)),
                                                          padding: EdgeInsets.symmetric(
                                                              horizontal: Dimensions.paddingSizeExtraSmall,
                                                              vertical: Dimensions.paddingSizeDefault),
                                                          // iconColor: Colors.white,
                                                        ),
                                                      ),
                                                    ],
                                                    animationBuilder: lottie != null
                                                        ? LottieBuilder.asset(
                                                      lottie.toString(),
                                                    )
                                                        : null,
                                                    customView: Dialogs.holder,
                                                    color: Colors.white,
                                                  ),
                                                )
                                        );

                                      },
                                      child: ClipOval(
                                        child: Image.file(
                                          imageFile!,
                                          width: 95.w,
                                          height: 95.h,
                                          fit: BoxFit
                                              .cover,
                                        ),
                                      ),
                                    )
                                        : GestureDetector(
                                      onTap: () async {
                                        showDialog(
                                            context: _scaffoldKey.currentContext!,
                                            builder: (context) =>
                                                Dialog(
                                                  backgroundColor: Colors.white,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(Dimensions.radiusDefault)),
                                                  alignment: Alignment.bottomCenter,
                                                  insetPadding: EdgeInsets.symmetric(
                                                      vertical: Dimensions.paddingSize, horizontal: Dimensions.paddingSize),
                                                  child: CustomDialogWidget(
                                                    msgStyle: const TextStyle(height: 2),
                                                    //   title: LocaleKeys.chosePhotoWith.tr(),
                                                    titleStyle: const TextStyle(
                                                      color: Colors.blueGrey,
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                    actions: [
                                                      Padding(
                                                        padding:
                                                        EdgeInsets.symmetric(horizontal: Dimensions.paddingSmall),
                                                        child: IconsButton(
                                                          onPressed: () async {
                                                            try {
                                                              final image = await ImagePicker()
                                                                  .pickImage(
                                                                  source:
                                                                  ImageSource.gallery);
                                                              if (image ==
                                                                  null)
                                                                return;
                                                              final iamgeTempoary =
                                                              File(image
                                                                  .path);
                                                              setState(() =>
                                                              imageFile =
                                                                  iamgeTempoary);
                                                              // addProductCubit.updateImageProduct(context, stateProductDetails.showDetailsProductResponseModel![0].id.toString(), image1!);
                                                              updateProfileCubit.updateProfileImageUser(
                                                                  context,
                                                                  profileCubit
                                                                      .firstNameController
                                                                      .text,
                                                                  profileCubit
                                                                      .lastNameController
                                                                      .text,
                                                                  profileCubit
                                                                      .emailController
                                                                      .text,
                                                                  profileCubit
                                                                      .mobileController
                                                                      .text,
                                                                  imageFile!);
                                                            } on PlatformException catch (e) {
                                                              if (kDebugMode) {
                                                                print(e);
                                                              }
                                                            }
                                                            Navigator.pop(context);
                                                          },
                                                          text: LocaleKeys.gallery.tr(),
                                                          // color: Colors.transparent,
                                                          shape: OutlineInputBorder(
                                                              borderSide: const BorderSide(color: AppPalette.black),
                                                              borderRadius:
                                                              BorderRadius.circular(Dimensions.radiusDefault)),
                                                          textStyle: const TextStyle(color: Colors.black),
                                                          padding: EdgeInsets.symmetric(
                                                              horizontal: Dimensions.paddingSizeExtraSmall,
                                                              vertical: Dimensions.paddingSizeDefault),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                        EdgeInsets.symmetric(horizontal: Dimensions.paddingSmall),
                                                        child: IconsButton(
                                                          onPressed: () async {
                                                            try {
                                                              final image = await ImagePicker()
                                                                  .pickImage(
                                                                  source:
                                                                  ImageSource.camera);
                                                              if (image ==
                                                                  null)
                                                                return;
                                                              final iamgeTempoary =
                                                              File(image
                                                                  .path);
                                                              setState(() =>
                                                              imageFile =
                                                                  iamgeTempoary);
                                                              // addProductCubit.updateImageProduct(context, stateProductDetails.showDetailsProductResponseModel![0].id.toString(), image1!);
                                                              updateProfileCubit.updateProfileImageUser(
                                                                  context,
                                                                  profileCubit
                                                                      .firstNameController
                                                                      .text,
                                                                  profileCubit
                                                                      .lastNameController
                                                                      .text,
                                                                  profileCubit
                                                                      .emailController
                                                                      .text,
                                                                  profileCubit
                                                                      .mobileController
                                                                      .text,
                                                                  imageFile!);
                                                            } on PlatformException catch (e) {
                                                              if (kDebugMode) {
                                                                print(e);
                                                              }
                                                            }
                                                            Navigator.pop(context);
                                                          },
                                                          text: LocaleKeys.camera.tr(),
                                                          // iconData: Icons.done,
                                                          color: AppPalette.primary,
                                                          textStyle: const TextStyle(color: Colors.white),
                                                          shape: OutlineInputBorder(
                                                              borderSide: BorderSide.none,
                                                              borderRadius:
                                                              BorderRadius.circular(Dimensions.radiusDefault)),
                                                          padding: EdgeInsets.symmetric(
                                                              horizontal: Dimensions.paddingSizeExtraSmall,
                                                              vertical: Dimensions.paddingSizeDefault),
                                                          // iconColor: Colors.white,
                                                        ),
                                                      ),
                                                    ],
                                                    animationBuilder: lottie != null
                                                        ? LottieBuilder.asset(
                                                      lottie.toString(),
                                                    )
                                                        : null,
                                                    customView: Dialogs.holder,
                                                    color: Colors.white,
                                                  ),
                                                )
                                        );

                                      },
                                      child: SizedBox(
                                          width: 95.w,
                                          height: 95.h,
                                          child:
                                          Container(
                                            decoration:
                                            BoxDecoration(
                                                shape: BoxShape
                                                    .circle,
                                                image:
                                                DecorationImage(
                                                  image:
                                                  CachedNetworkImageProvider(profileImage),
                                                  fit:
                                                  BoxFit.cover,
                                                )),
                                          )),
                                    ),
                                    Positioned(
                                      bottom: MediaQuery.of(context).size.height * 0.024 * .1,
                                      right: MediaQuery.of(context).size.height * 0.024 * .2,
                                      child: GestureDetector(
                                        onTap: () async {
                                          try {
                                            final image =
                                            await ImagePicker()
                                                .pickImage(
                                                source: ImageSource
                                                    .gallery);
                                            if (image == null)
                                              return;
                                            final iamgeTempoary =
                                            File(image.path);
                                            setState(() =>
                                            imageFile =
                                                iamgeTempoary);
                                            // addProductCubit.updateImageProduct(context, stateProductDetails.showDetailsProductResponseModel![0].id.toString(), image1!);
                                            updateProfileCubit.updateProfileImageUser(
                                                context,
                                                profileCubit
                                                    .firstNameController
                                                    .text,
                                                profileCubit
                                                    .lastNameController
                                                    .text,
                                                profileCubit
                                                    .emailController
                                                    .text,
                                                profileCubit
                                                    .mobileController
                                                    .text,
                                                imageFile!);
                                          } on PlatformException catch (e) {
                                            if (kDebugMode) {
                                              print(e);
                                            }
                                          }
                                        },
                                        child: Container(
                                          width: 25,
                                          height: 25,
                                          decoration: BoxDecoration(
                                              color: AppPalette
                                                  .primary,
                                              borderRadius:
                                              BorderRadius
                                                  .circular(
                                                  10)),
                                          child: const Icon(
                                            Icons.edit,
                                            color:
                                            AppPalette.white,
                                            size: 18,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              10.heightBox,
                              updateProfileCubit.updateIsPhotoLoading ?
                              SpinKitDoubleBounce(
                                color: AppPalette.primary,
                                size: 50.0.sp,
                              ) : Container(),
                              5.heightBox,
                            ],
                          );
                        },
                      ),
                      33.heightBox,
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.paddingSizeSmall),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              InputTextFormField(
                                hintText: LocaleKeys.firstName.tr(),
                                textEditingController:
                                profileCubit.firstNameController,
                                validator: (val) {
                                  if (val.isEmpty) {
                                    return LocaleKeys.enter_your_name
                                        .tr();
                                  } else {
                                    return null;
                                  }
                                },
                                // focusNode: _firstNameFocus,
                                // nextFocusNode: _lastNameFocus,
                                textInputType: TextInputType.name,
                                inputAction: TextInputAction.next,
                              ),
                              12.heightBox,
                              InputTextFormField(
                                hintText: LocaleKeys.lastName.tr(),
                                textEditingController:
                                profileCubit.lastNameController,
                                validator: (val) {
                                  if (val.isEmpty) {
                                    return LocaleKeys.enter_your_name
                                        .tr();
                                  } else {
                                    return null;
                                  }
                                },
                                // focusNode: _lastNameFocus,
                                // nextFocusNode: _mobileFocus,
                                textInputType: TextInputType.name,
                                inputAction: TextInputAction.next,
                              ),
                              12.heightBox,
                              InputTextFormField(
                                hintText: LocaleKeys.mobileNumber.tr(),
                                textEditingController:
                                profileCubit.mobileController,
                                validator: (val) {
                                  if (val.length < 8) {
                                    return LocaleKeys
                                        .enter_a_valid_phone
                                        .tr();
                                  } else {
                                    return null;
                                  }
                                },
                                // focusNode: _mobileFocus,
                                // nextFocusNode: _emailFocus,
                                textInputType: TextInputType.phone,
                                inputAction: TextInputAction.next,
                              ),
                              12.heightBox,
                              InputTextFormField(
                                hintText: LocaleKeys.email.tr(),
                                textEditingController:
                                profileCubit.emailController,
                                validator: (val) {
                                  if (!RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      .hasMatch(val)) {
                                    return LocaleKeys
                                        .enter_a_valid_email
                                        .tr()
                                        .toString();
                                  } else {
                                    return null;
                                  }
                                },
                                // focusNode: _emailFocus,
                                // nextFocusNode: _passwordFocus,
                                textInputType:
                                TextInputType.emailAddress,
                                inputAction: TextInputAction.next,
                              ),
                              12.heightBox,
                              InputTextFormField(
                                hintText: '*******',
                                readOnly: true,
                                textEditingController:
                                profileCubit.passwordController,
                                validator: (val) {
                                  // if (val.length < 6) {
                                  //   return LocaleKeys.password_is_too_short.tr();
                                  // } else {
                                  //   return null;
                                  // }
                                },
                                //focusNode: _passwordFocus,
                                textInputType:
                                TextInputType.visiblePassword,
                                secure: profileCubit.showPassword,
                                suffixIcon: InkWell(
                                    onTap: profileCubit.togglePassword,
                                    child: Icon(
                                      profileCubit.showPassword
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: AppPalette.black,
                                    )),
                                // showPassword: profileCubit.togglePassword,
                                inputAction: TextInputAction.done,
                              ),
                              25.heightBox,
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ChangePasswordScreen()));
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      LocaleKeys.changePassword.tr(),
                                      style:
                                      AppTextStyles.poppinsRegular,
                                    ),
                                  ],
                                ),
                              ),
                              25.heightBox,
                              BlocBuilder<UpdateProfileCubit,UpdateProfileState>(
                                builder: (context, state) {
                                  UpdateProfileCubit updateProfileCubit = UpdateProfileCubit.get(context);
                                  return Column(
                                    children: [
                                      state is updateProfileLoadingState ?
                                      SpinKitDoubleBounce(
                                        color: AppPalette.primary,
                                        size: 50.0.sp,
                                      ) : Container(),
                                      15.heightBox,
                                      Padding(
                                        padding:  EdgeInsets.symmetric(horizontal: 35.h),
                                        child: CustomButton(
                                          width: double.infinity,
                                          buttonText: LocaleKeys.save.tr(),
                                          onPressed: () => updateProfileUser(
                                              updateProfileCubit,
                                              profileCubit),
                                          height: 48.h,
                                          fontSize: Dimensions.fontSizeLarge,
                                        ),
                                      ),
                                    ],
                                  );
                                },)
                            ],
                          ),
                        ),
                      ),
                      15.heightBox,
                    ],
                  ),
                );
              }
              return LoadingWidget(data: '');
            },
          ),),
      ),
    );
  }

  // void _handleLoginListener(BuildContext context, ProfileState state) {
  //   if (state is updateProfilerErrorState) {
  //     customFlutterToast(state.error);
  //   } else if (state is updateProfileSuccessState) {
  //     customFlutterToast(state.responseModel?.message);
  //     //  CacheHelper.saveData(key: 'userName', value: '${state.loginModel?.user?.userName}');
  //     Navigator.pushNamedAndRemoveUntil(
  //         context, AppConstants.appLayout, (_) => false);
  //   }else {
  //     SpinKitDoubleBounce(
  //       color: Themes.colorApp9,
  //       size: 50.0.sp,
  //     );
  //   }
  // }

  void updateProfileUser(
      UpdateProfileCubit cubit,ProfileCubit profileCubit) {
    if (_formKey.currentState!.validate()) {
      print('personal userss');
      print(profileCubit.firstNameController.text);
      print(profileCubit.lastNameController.text);
      print(profileCubit.emailController.text);
      print(profileCubit.mobileController.text);
      cubit.updateProfileUser(
          context: context,
          firstName: profileCubit.firstNameController.text,
          lastName: profileCubit.lastNameController.text,
          email: profileCubit.emailController.text,
          phoneNumber: profileCubit.mobileController.text);
    }
  }


  loadData() {
    BlocProvider.of<ProfileCubit>(context, listen: false).getUserProfile();
  }
}
