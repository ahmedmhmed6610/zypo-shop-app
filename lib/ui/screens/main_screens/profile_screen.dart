
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:shop/business_logic/my_favorite_user_cubit/my_favorite_user_cubit.dart';
import 'package:shop/helpers/app_local_storage.dart';
import 'package:shop/helpers/cache_helper.dart';

import 'package:shop/translations/locale_keys.g.dart';
import 'package:shop/ui/screens/auth/login_screen.dart';
import 'package:shop/ui/screens/my_favorite_user_screen/my_favorite_user_screen.dart';
import 'package:shop/ui/screens/notification_screen/notification_screen.dart';
import 'package:shop/ui/screens/user_screens/contact_us_screen.dart';
import 'package:shop/ui/screens/user_screens/languages_screen.dart';
import 'package:shop/ui/screens/user_screens/personal_data_screen.dart';
import 'package:shop/ui/screens/user_screens/settings_screen.dart';
import 'package:shop/ui/widgets/profile_widgets/list_tile_item_widget.dart';
import 'package:shop/utils/app_palette.dart';

import 'package:shop/utils/app_size_boxes.dart';
import 'package:shop/utils/dimensions.dart';
import 'package:shop/utils/styles.dart';
import '../../../business_logic/profile_cubit/profile_cubit.dart';
import '../../../libraries/dialog_widget.dart';
import '../../../utils/app_constants.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../widgets/common_widgets/dialogs/confirm_alert_dialog_logout.dart';
import '../add_ads_screen/add_ads_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late String imageUrl;
  late String imageProfile;
  late String firstName;
  late String lastName;
  String? lottie;
  // Timer? timer;
  String? profileImages = 'https://img.freepik.com/free-vector/cute-gentleman-character-illustration_24877-60133.jpg?t=st=1658505623~exp=1658506223~hmac=3ee77155aae3cea1d1f3d7eccb20aa72617e4dfb894551a6223da59d10b52718&w=740';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(AppLocalStorage.token != null){
      BlocProvider.of<ProfileCubit>(context).getUserProfile();
      print('user profile');
    }else {}

    //  profileImages =
    //     "https://img.freepik.com/free-vector/cute-gentleman-character-illustration_24877-60133.jpg?t=st=1658505623~exp=1658506223~hmac=3ee77155aae3cea1d1f3d7eccb20aa72617e4dfb894551a6223da59d10b52718&w=740";
    // print(imageProfile);
    // imageProfile = imageUrl + CacheHelper.getData(key: 'photo');
    // imageProfile != null ? profileImage : imageProfile ;
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ProfileCubit>().state;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              color: AppPalette.primary,
              child: Column(
                children: [
                  75.heightBox,
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                          color: AppPalette.white,
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25))
                      ),
                      child: Column(
                        children: [
                          100.heightBox,
                          ListTileItemWidget(
                            title: LocaleKeys.personalData.tr(),
                            trailing: const Icon(Icons.arrow_forward_ios,
                                size: 22.0, color: AppPalette.black),
                            onTap: () {
                              if (AppLocalStorage.token == null){
                                showDialog(
                                    context: context,
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
                                            title: LocaleKeys.youHaveToLoginFirst.tr(),
                                            msg: LocaleKeys.loginAndSellBuy.tr(),
                                            titleStyle: const TextStyle(
                                              color: Colors.blueGrey,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            actions: [
                                              Padding(
                                                padding:
                                                EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
                                                child: IconsButton(
                                                  onPressed: () async {
                                                    // addProductCubit.deleteProductItem(context,productId: product.id.toString(),isSold: '0');
                                                    Navigator.pop(context);
                                                  },
                                                  text: LocaleKeys.cancel.tr(),
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
                                                EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
                                                child: IconsButton(
                                                  onPressed: () {
                                                    //  addProductCubit.deleteProductItem(context,productId: product.id.toString(),isSold: '1');
                                                    Navigator.of(context).push(MaterialPageRoute(
                                                        builder: (context) => const LoginScreen()));
                                                  },
                                                  text: LocaleKeys.login.tr(),
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
                              }else {

                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => PersonalDataScreen(),
                                ));
                              }
                            },
                          ),
                          // ListTileItemWidget(
                          //   title: LocaleKeys.myFavoriteUser.tr(),
                          //   trailing: const Icon(Icons.arrow_forward_ios,
                          //       size: 22.0, color: AppPalette.black),
                          //   onTap: () {
                          //     if (AppLocalStorage.token == null){
                          //       showDialog(
                          //           context: context,
                          //           builder: (context) =>
                          //               Dialog(
                          //                 backgroundColor: Colors.white,
                          //                 shape: RoundedRectangleBorder(
                          //                     borderRadius: BorderRadius.circular(Dimensions.radiusDefault)),
                          //                 alignment: Alignment.bottomCenter,
                          //                 insetPadding: EdgeInsets.symmetric(
                          //                     vertical: Dimensions.paddingSize, horizontal: Dimensions.paddingSize),
                          //                 child: CustomDialogWidget(
                          //                   msgStyle: const TextStyle(height: 2),
                          //                   title: LocaleKeys.youHaveToLoginFirst.tr(),
                          //                   msg: LocaleKeys.loginAndSellBuy.tr(),
                          //                   titleStyle: const TextStyle(
                          //                     color: Colors.blueGrey,
                          //                     overflow: TextOverflow.ellipsis,
                          //                   ),
                          //                   actions: [
                          //                     Padding(
                          //                       padding:
                          //                       EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
                          //                       child: IconsButton(
                          //                         onPressed: () async {
                          //                           // addProductCubit.deleteProductItem(context,productId: product.id.toString(),isSold: '0');
                          //                           Navigator.pop(context);
                          //                         },
                          //                         text: LocaleKeys.cancel.tr(),
                          //                         // color: Colors.transparent,
                          //                         shape: OutlineInputBorder(
                          //                             borderSide: const BorderSide(color: AppPalette.black),
                          //                             borderRadius:
                          //                             BorderRadius.circular(Dimensions.radiusDefault)),
                          //                         textStyle: const TextStyle(color: Colors.black),
                          //                         padding: EdgeInsets.symmetric(
                          //                             horizontal: Dimensions.paddingSizeExtraSmall,
                          //                             vertical: Dimensions.paddingSizeDefault),
                          //                       ),
                          //                     ),
                          //                     Padding(
                          //                       padding:
                          //                       EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
                          //                       child: IconsButton(
                          //                         onPressed: () {
                          //                           //  addProductCubit.deleteProductItem(context,productId: product.id.toString(),isSold: '1');
                          //                           Navigator.of(context).push(MaterialPageRoute(
                          //                               builder: (context) => const LoginScreen()));
                          //                         },
                          //                         text: LocaleKeys.login.tr(),
                          //                         // iconData: Icons.done,
                          //                         color: AppPalette.primary,
                          //                         textStyle: const TextStyle(color: Colors.white),
                          //                         shape: OutlineInputBorder(
                          //                             borderSide: BorderSide.none,
                          //                             borderRadius:
                          //                             BorderRadius.circular(Dimensions.radiusDefault)),
                          //                         padding: EdgeInsets.symmetric(
                          //                             horizontal: Dimensions.paddingSizeExtraSmall,
                          //                             vertical: Dimensions.paddingSizeDefault),
                          //                         // iconColor: Colors.white,
                          //                       ),
                          //                     ),
                          //                   ],
                          //                   animationBuilder: lottie != null
                          //                       ? LottieBuilder.asset(
                          //                     lottie.toString(),
                          //                   )
                          //                       : null,
                          //                   customView: Dialogs.holder,
                          //                   color: Colors.white,
                          //                 ),
                          //               )
                          //       );
                          //     }else {
                          //       state is SuccessProfileState ?
                          //       Navigator.of(context).push(MaterialPageRoute(
                          //         builder: (context) => MyFavoriteUserScreen(userId: state.userDataModel!.user!.id.toString(),),
                          //       )) :  null;
                          //     }
                          //   },
                          // ),
                          ListTileItemWidget(
                            title: LocaleKeys.addAds.tr(),
                            trailing: const Icon(Icons.arrow_forward_ios,
                                size: 22.0, color: AppPalette.black),
                            onTap: () {
                              if (AppLocalStorage.token == null){
                                showDialog(
                                    context: context,
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
                                            title: LocaleKeys.youHaveToLoginFirst.tr(),
                                            msg: LocaleKeys.loginAndSellBuy.tr(),
                                            titleStyle: const TextStyle(
                                              color: Colors.blueGrey,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            actions: [
                                              Padding(
                                                padding:
                                                EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
                                                child: IconsButton(
                                                  onPressed: () async {
                                                    // addProductCubit.deleteProductItem(context,productId: product.id.toString(),isSold: '0');
                                                    Navigator.pop(context);
                                                  },
                                                  text: LocaleKeys.cancel.tr(),
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
                                                EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
                                                child: IconsButton(
                                                  onPressed: () {
                                                    //  addProductCubit.deleteProductItem(context,productId: product.id.toString(),isSold: '1');
                                                    Navigator.of(context).push(MaterialPageRoute(
                                                        builder: (context) => const LoginScreen()));
                                                  },
                                                  text: LocaleKeys.login.tr(),
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
                              }else {
                                state is SuccessProfileState ?
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const AddAdsScreen())) :  null;
                              }
                            },
                          ),
                          // ListTileItemWidget(
                          //   title: LocaleKeys.settings.tr(),
                          //   onTap: () => Navigator.of(context).push(
                          //       MaterialPageRoute(builder: (context) => SettingsScreen())),
                          //   trailing: const Icon(Icons.arrow_forward_ios,
                          //       size: 22.0, color: AppPalette.black),
                          // ),
                          ListTileItemWidget(
                            title: LocaleKeys.language.tr(),
                            onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) => LanguagesScreen())),
                            trailing: const Icon(Icons.arrow_forward_ios,
                                size: 22.0, color: AppPalette.black),
                          ),
                          ListTileItemWidget(
                            title: LocaleKeys.contactUs.tr(),
                            onTap: () {
                              if (AppLocalStorage.token == null){
                                showDialog(
                                    context: context,
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
                                            title: LocaleKeys.youHaveToLoginFirst.tr(),
                                            msg: LocaleKeys.loginAndSellBuy.tr(),
                                            titleStyle: const TextStyle(
                                              color: Colors.blueGrey,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            actions: [
                                              Padding(
                                                padding:
                                                EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
                                                child: IconsButton(
                                                  onPressed: () async {
                                                    // addProductCubit.deleteProductItem(context,productId: product.id.toString(),isSold: '0');
                                                    Navigator.pop(context);
                                                  },
                                                  text: LocaleKeys.cancel.tr(),
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
                                                EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
                                                child: IconsButton(
                                                  onPressed: () {
                                                    //  addProductCubit.deleteProductItem(context,productId: product.id.toString(),isSold: '1');
                                                    Navigator.of(context).push(MaterialPageRoute(
                                                        builder: (context) => const LoginScreen()));
                                                  },
                                                  text: LocaleKeys.login.tr(),
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
                              }else {

                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ContactUsScreen(),
                                ));
                              }
                            },
                            trailing: const Icon(Icons.arrow_forward_ios,
                                size: 22.0, color: AppPalette.black),
                          ),
                          AppLocalStorage.token != null ?
                          ListTileItemWidget(
                            title: LocaleKeys.logout.tr(),
                            onTap: () async {
                              bool response = await showDialog(
                                context: context,
                                builder: (context) => ConfirmAlertDialogLogout(
                                  title: LocaleKeys.logoutConfirmation.tr(),
                                  confirmationButton: LocaleKeys.logout.tr(),
                                  cancelButton: LocaleKeys.cancel.tr(),
                                ),
                              );
                              if (response) {
                                BlocProvider.of<ProfileCubit>(context).logout();
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(builder: (context) => const LoginScreen()),
                                        (route) => false);
                              }
                            },
                            trailing: const Icon(Icons.arrow_forward_ios,
                                size: 22.0, color: AppPalette.black),
                          ) :
                          ListTileItemWidget(
                            title: LocaleKeys.login.tr(),
                            onTap: () async {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const LoginScreen()));
                            },
                            trailing: const Icon(Icons.arrow_forward_ios,
                                size: 22.0, color: AppPalette.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                25.heightBox,
                state is SuccessProfileState ?
                Column(
                  children: [
                    Center(
                      child: SizedBox(
                          width: 95.w,
                          height: 95.h,
                          child: ClipOval(
                            child: FadeInImage(
                              image: state.userDataModel?.user?.photo != null ?
                              NetworkImage('${state.userDataModel?.user?.userImagePath}/${state.userDataModel?.user?.photo}') :
                              NetworkImage('$profileImages'),
                              fit: BoxFit.cover,
                              width: 95.w,
                              height: 95.h,
                              placeholder: const AssetImage('assets/images/loader.gif'),
                            ),
                          ),)
                    ),
                    Center(
                      child: Text(
                        '${state.userDataModel?.user?.userFirstName} ${state.userDataModel?.user?.userLastName}',
                        style: AppTextStyles.poppinsMedium.copyWith(
                          color: AppPalette.primary,
                          fontSize: Dimensions.fontSizeLarge,
                        ),
                      ),
                    ),
                  ],
                ) :
                Column(
                  children: [
                    Center(
                        child: SizedBox(
                          width: 95.w,
                          height: 95.h,
                          child: ClipOval(
                            child: FadeInImage(
                              image: NetworkImage('$profileImages'),
                              fit: BoxFit.cover,
                              width: 95.w,
                              height: 95.h,
                              placeholder: const AssetImage('assets/images/loader.gif'),
                            ),
                          ),)
                    ),
                    8.heightBox,
                    Center(
                      child: Text(
                        AppLocalStorage.token == null ? LocaleKeys.guest.tr() : '',
                        style: AppTextStyles.poppinsMedium.copyWith(
                          color: Colors.white,
                          fontSize: Dimensions.fontSizeLarge,
                        ),
                      ),
                    ),
                  ],
                ),

              ],
            ),

          ],
        ),
      ),
    );
  }

  Widget _buildBlocWidget() {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is AuthenticationStateUnauthenticated) {
          Navigator.pushReplacementNamed(
            context,
            AppConstants.loginScreen,
          );
        }
      },
      builder: (context, state) {
        var cubit = ProfileCubit.get(context);
        if (state is AuthenticationLoading) {
          return const Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
          );
        } else {
          return _logoutButton(cubit);
        }
      },
    );
  }

  Widget _logoutButton(ProfileCubit cubit) => IconButton(
        onPressed: () {
          cubit.logout();
        },
        icon: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Icon(
            FontAwesomeIcons.arrowRightFromBracket,
            color: Colors.red,
          ),
        ),
      );
}
