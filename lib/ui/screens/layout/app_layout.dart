import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:new_version_plus/new_version_plus.dart';
import 'package:shop/business_logic/app_layout_cubit/app_layout_cubit.dart';
import 'package:shop/business_logic/auth_cubit/auth_cubit.dart';
import 'package:shop/business_logic/categories_cubit/categories_cubit.dart';
import 'package:shop/business_logic/home_cubit/home_cubit.dart';
import 'package:shop/business_logic/profile_cubit/profile_cubit.dart';
import 'package:shop/data/internet_connectivity/no_internet.dart';
import 'package:shop/helpers/cache_helper.dart';
import 'package:shop/helpers/components.dart';
import 'package:shop/translations/locale_keys.g.dart';
import 'package:shop/ui/base/custom_toast.dart';
import 'package:shop/ui/screens/main_screens/home_screen.dart';
import 'package:shop/ui/screens/main_screens/profile_screen.dart';
import 'package:shop/ui/screens/main_screens/wishList_screen.dart';
import 'package:shop/ui/screens/main_screens/my_products_screen.dart';
import 'package:shop/ui/screens/user_products_screen/user_products_screen.dart';
import 'package:shop/utils/app_palette.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../business_logic/filter_cubit/filter_cubit.dart';
import '../../../business_logic/my_products_cubit/my_products_cubit.dart';
import '../../../business_logic/product_details_cubit/product_details_cubit.dart';
import '../../../data/models/MyFavoriteUserModel.dart';
import '../../../data/models/MyProductUserModel.dart';
import '../../../data/models/product_model.dart';
import '../../../data/models/show_details_product_model.dart';
import '../../../helpers/app_local_storage.dart';
import '../../../utils/Themes.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/components.dart';
import '../../../utils/dimensions.dart';
import '../filter_screens/choose_categories_screens/main_category_screen.dart';
import '../product_details_screen/product_details_screen.dart';
import '../user_products_screen/user_products_share_screen.dart';
import 'widget/bottom_nav_item.dart';

class AppLayout extends StatefulWidget {

  AppLayout({Key? key}) : super(key: key);

  @override
  State<AppLayout> createState() => _AppLayoutState();
}

class _AppLayoutState extends State<AppLayout> with WidgetsBindingObserver {
  late StreamSubscription onTokenRefreshListen;

  String? lottie;

  Future<void> setupInteractedMessage() async {
    FirebaseMessaging.onMessage.listen((message) {
      if (message.data['type'] == 'Renew') {
        if (message.notification!.body != null) {
          showNotification(context, lottie,message.data['product_id']);
        } else {
          showNotificationDialog(
              context: context,
              message: 'Du hast eine neue Bestellung',
              newOrder: true);
        }
      }

      FirebaseMessaging.onMessageOpenedApp.listen((message) {
        customFlutterToast(message.data['product_id']);
        showNotification(context, lottie,message.data['product_id']);
        if (message.data['type'] == 'Renew') {
          //  OrdersCubit.get(context).getAllOrders();
          if (message.notification!.body != null) {
            customFlutterToast(message.data['product_id']);
            showNotification(context, lottie,message.data['product_id']);
          } else {
            showNotificationDialog(
                context: context,
                message: 'Du hast eine neue Bestellung',
                newOrder: true);
          }
        }
      });
    });

  }


  void _checkVersion() async {
    final newVersion = NewVersionPlus(
      iOSId: 'com.germaniatek.markety',
      androidId: 'com.germaniatek.markety',
    );
    final status = await newVersion.getVersionStatus();
    if (status != null) {
      debugPrint(status.releaseNotes);
      debugPrint(status.appStoreLink);
      debugPrint(status.localVersion);
      debugPrint(status.storeVersion);
      debugPrint(status.canUpdate.toString());
      newVersion.showUpdateDialog(
        context: context,
        versionStatus: status,
        allowDismissal: false,
        launchMode: LaunchMode.externalApplication,
        dialogTitle: LocaleKeys.updateApp.tr(),
        dismissButtonText: "Skip",
        dialogText: "Please update the app from " + "${status.localVersion}" + " to " + "${status.storeVersion}",
        dismissAction: () {
          SystemNavigator.pop();
        },
        updateButtonText: "Lets update",
        // dialogText: 'Custom Text',
      );
    }

    // You can let the plugin handle fetching the status and showing a dialog,
    // or you can fetch the status and display your own dialog, or no dialog.
    // const simpleBehavior = true;
    //
    // if (simpleBehavior) {
    //   basicStatusCheck(newVersion);
    // }
    // else {
    //   advancedStatusCheck(newVersion);
    // }
  }

  basicStatusCheck(NewVersionPlus newVersion) async{
   // newVersion.showAlertIfNecessary(context: context);
    final status = await newVersion.getVersionStatus();
    if (status != null) {
      debugPrint(status.releaseNotes);
      debugPrint(status.appStoreLink);
      debugPrint(status.localVersion);
      debugPrint(status.storeVersion);
      debugPrint(status.canUpdate.toString());
      newVersion.showUpdateDialog(
        context: context,
        versionStatus: status,
        allowDismissal: false,
        launchMode: LaunchMode.externalApplication,
        dialogTitle: LocaleKeys.updateApp.tr(),
        dismissButtonText: "Skip",
        dialogText: "Please update the app from " + "${status.localVersion}" + " to " + "${status.storeVersion}",
        dismissAction: () {
          SystemNavigator.pop();
        },
        updateButtonText: "Lets update",
        // dialogText: 'Custom Text',
      );
    }
   // advancedStatusCheck(newVersion);
  }

  advancedStatusCheck(NewVersionPlus newVersion) async {
    final status = await newVersion.getVersionStatus();
    if (status != null) {
      debugPrint(status.releaseNotes);
      debugPrint(status.appStoreLink);
      debugPrint(status.localVersion);
      debugPrint(status.storeVersion);
      debugPrint(status.canUpdate.toString());
      newVersion.showUpdateDialog(
        context: context,
        versionStatus: status,
        allowDismissal: false,
        launchMode: LaunchMode.externalApplication,
        dialogTitle: "UPDATE!!!",
        dismissButtonText: "Skip",
        dialogText: "Please update the app from " + "${status.localVersion}" + " to " + "${status.storeVersion}",
        dismissAction: () {
          SystemNavigator.pop();
        },
        updateButtonText: "Lets update",
       // dialogText: 'Custom Text',
      );
    }
  }

  // void fetchLinkDataUser() async {
  //   // FirebaseDynamicLinks.getInitialLInk does a call to firebase to get us the real link because we have shortened it.
  //   PendingDynamicLinkData? link = await FirebaseDynamicLinks.instance.getInitialLink();
  //
  //   // This link may exist if the app was opened fresh so we'll want to handle it the same way onLink will.
  //   handleLinkDataUser(link!);
  //
  //   // This will handle incoming links if the application is already opened
  //   FirebaseDynamicLinks.instance.onLink(onSuccess: (PendingDynamicLinkData? dynamicLink) async {
  //     handleLinkDataUser(dynamicLink!);
  //   });
  // }

  late ShowDetailsProductResponseModel showDetailsProductResponseModel = ShowDetailsProductResponseModel();
  late MyFavoriteUserResponseModel myFavoriteUserResponseModel = MyFavoriteUserResponseModel();
  // void handleLinkDataUser(PendingDynamicLinkData data) {
  //   final Uri? uri = data.link;
  //   if(uri != null) {
  //     final queryParams = uri.queryParameters;
  //     if(queryParams.length > 0) {
  //       String? userName = queryParams["id"];
  //       print('user id');
  //       print(userName);
  //
  //       BlocProvider.of<ProductDetailsCubit>(context).getProductDetails(
  //           productId: int.parse('$userName'));
  //       Navigator.of(context).push(MaterialPageRoute(
  //         builder: (context) => UserProductsScreen(showDetailsProductResponseModel: showDetailsProductResponseModel,
  //             myProductUserResponseModel: myFavoriteUserResponseModel),
  //       ));
  //       // verify the username is parsed correctly
  //       print("My users username is: $userName");
  //     }
  //   }
  // }


  // void fetchLinkData() async {
  //   // FirebaseDynamicLinks.getInitialLInk does a call to firebase to get us the real link because we have shortened it.
  //   PendingDynamicLinkData? link = await FirebaseDynamicLinks.instance.getInitialLink();
  //
  //   // This link may exist if the app was opened fresh so we'll want to handle it the same way onLink will.
  //   handleLinkData(link!);
  //
  //   // This will handle incoming links if the application is already opened
  //   FirebaseDynamicLinks.instance.onLink(onSuccess: (PendingDynamicLinkData? dynamicLink) async {
  //     handleLinkData(dynamicLink!);
  //   });
  // }

  late ProductModel productModel = ProductModel();
  late MyProductUserResponseModel myProductUserResponseModel = MyProductUserResponseModel();
  // void handleLinkData(PendingDynamicLinkData data) {
  //   final Uri? uri = data.link;
  //   if(uri != null) {
  //     final queryParams = uri.queryParameters;
  //     if(queryParams.length > 0) {
  //       String? userName = queryParams["id"];
  //       print('user id');
  //       print(userName);
  //       BlocProvider.of<ProductDetailsCubit>(context)
  //           .getProductDetailsUser('$userName');
  //
  //       Navigator.of(context).push(MaterialPageRoute(
  //         builder: (context) => ProductDetailsScreen(product: productModel,myProductUserResponseModel: myProductUserResponseModel),
  //       ));
  //       // verify the username is parsed correctly
  //       print("My users username is: $userName");
  //     }
  //   }
  // }

  // void handleLinkDataUser(PendingDynamicLinkData data) {
  //   final Uri? uri = data.link;
  //   if(uri != null) {
  //     final queryParams = uri.queryParameters;
  //     if(queryParams.length > 0) {
  //       String? userName = queryParams["id"];
  //       BlocProvider.of<FilterCubit>(context).getUserProducts('$userName');
  //       print('user id');
  //       print(userName);
  //       Navigator.of(context).push(MaterialPageRoute(
  //         builder: (context) => UserProductSahareScreen(myFavoriteResponseModel: favoriteUserResponseModel,
  //         showDetailsProductResponseModel: showDetailsProductResponseModel),
  //       ));
  //       // verify the username is parsed correctly
  //       print("My users username is: $userName");
  //     }
  //   }
  // }

  @override
  void initState() {
    super.initState();




    if(AppLocalStorage.token == null){
      // fetchLinkData();
      // fetchLinkDataUser();
    }else {
      FirebaseMessaging.instance.getToken().then((value) {
        if (value != null) {
          if (fcmToken == null) {
            //   HalalLocationCubit.get(context).updateFCMToken(value);
            AuthCubit.get(context).updateFCMToken(value);
            //    BlocProvider.of<AuthCubit>(context).updateFCMToken(fcmToken);
            //  print('token device');
            //   CustomFlutterToast(value);
          }
        }
      });
      // fetchLinkData();
      // fetchLinkDataUser();
      ///when token expires from firebase
      onTokenRefreshListen =
          FirebaseMessaging.instance.onTokenRefresh.listen((value) {
            AuthCubit.get(context).updateFCMToken(value);
            //  HalalLocationCubit.get(context).updateFCMToken(value);
          });

      FirebaseMessaging.instance.getInitialMessage();
      //FCM messages
      setupInteractedMessage();



      WidgetsBinding.instance.addObserver(this);

    }

    setState(() {
      AppLocalStorage.language =  CacheHelper().getLanguage != null ? CacheHelper().getLanguage : context.locale;
      loadData();
      _checkVersion();
      // loadDataProduct();
      // loadDataProfile();
      // AppLocalStorage.language = CacheHelper().getLanguage;

    });
  }

  var _alertShowing = false;


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        print('back screen');
       // SystemNavigator.pop();
        final showDialogs  =  await showDialog<bool>(
          context: context,
          builder: (c) => AlertDialog(
            title:  Text(LocaleKeys.warning.tr()),
            content:  Text(LocaleKeys.doYouQuit.tr()),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    SystemNavigator.pop();
                  },
                  child: Text(LocaleKeys.yes.tr())),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                    _alertShowing = false;
                  },
                  child: Text(LocaleKeys.no.tr())
              )
            ],
          ),
        );

        return showDialogs!;
      },
      child: RefreshIndicator(
        onRefresh: () async{
          loadData();
          loadDataProduct();
          //  loadDataProfile();
        },
        child: Scaffold(
          body: BlocConsumer<AppLayoutCubit,AppLayoutState>(
              listener: (context, state) {
                if (state is ConnectionSuccess){
                  // loadData();
                  // loadDataProduct();
                  // loadDataProfile();
                  AppLayoutCubit appLayoutCubit = AppLayoutCubit.get(context);
                  AnnotatedRegion<SystemUiOverlayStyle>(
                    value: const SystemUiOverlayStyle(
                      statusBarColor: Colors.white,
                      statusBarBrightness: Brightness.light,
                      statusBarIconBrightness: Brightness.dark,
                    ),
                    child: Scaffold(
                      extendBody: true,
                      body: Column(
                        children: [
                          Expanded(
                            child: appLayoutCubit.layoutScreens[appLayoutCubit.selectedIndex],
                          ),
                        ],
                      ),
                      floatingActionButton: FloatingActionButton(
                        // splashColor: Colors.blue,
                        // elevation: 5,
                        backgroundColor: AppPalette.primary,
                        onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => MainCategoryScreen(),
                        )),
                        child: SvgPicture.asset(
                          "assets/images/svg/search.svg",
                          color: AppPalette.white,
                          fit: BoxFit.contain,
                          height: 27.sp,
                          width: 27.sp,
                        ),
                      ),
                      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
                      bottomNavigationBar: BottomNavigationBar(
                        onTap: (value) {
                          setState(() {
                            appLayoutCubit.selectedIndex = value;
                          });
                          appLayoutCubit.layoutScreens[appLayoutCubit.selectedIndex];
                        },
                        currentIndex: appLayoutCubit.selectedIndex,
                        selectedFontSize: 12,
                        unselectedFontSize: 12,
                        type: BottomNavigationBarType.fixed,
                        selectedIconTheme:
                        const IconThemeData(color: AppPalette.primary),
                        unselectedIconTheme:
                        const IconThemeData(color: Colors.black),
                        items: appLayoutCubit.bottomNavigationBarItem,
                      ),
                    ),
                  );
                }else if (state is ConnectionFailure){
                  NoInternetConnectionScreen(appLayoutState: state,);
                }
              },
              builder: (context, state) {
                if(state is ConnectionFailure){
                  return  NoInternetConnectionScreen(appLayoutState: state,);
                }else if(state is ConnectionSuccess){
                  return  BlocBuilder<AppLayoutCubit, AppLayoutState>(
                    builder: (context, state) {
                      AppLayoutCubit appLayoutCubit = AppLayoutCubit.get(context);
                      return AnnotatedRegion<SystemUiOverlayStyle>(
                        value: const SystemUiOverlayStyle(
                          statusBarColor: Colors.white,
                          statusBarBrightness: Brightness.light,
                          statusBarIconBrightness: Brightness.dark,
                        ),
                        child: RefreshIndicator(
                          onRefresh: () async{
                            loadData();
                            loadDataProduct();
                            //  loadDataProfile();
                          },
                          child: Scaffold(
                            extendBody: true,
                            body: Column(
                              children: [
                                Expanded(
                                  child: appLayoutCubit.layoutScreens[appLayoutCubit.selectedIndex],
                                ),
                              ],
                            ),
                            floatingActionButton: FloatingActionButton(
                              // splashColor: Colors.blue,
                              // elevation: 5,
                              backgroundColor: AppPalette.primary,
                              onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => MainCategoryScreen(),
                              )),
                              child: SvgPicture.asset(
                                "assets/images/svg/search.svg",
                                color: AppPalette.white,
                                fit: BoxFit.contain,
                                height: 27.sp,
                                width: 27.sp,
                              ),
                            ),
                            floatingActionButtonLocation:
                            FloatingActionButtonLocation.centerDocked,
                            bottomNavigationBar: Container(
                              height: 75.h,
                              child: BottomNavigationBar(
                                onTap: (value) {
                                  setState(() {
                                    appLayoutCubit.selectedIndex = value;
                                  });
                                  appLayoutCubit.layoutScreens[appLayoutCubit.selectedIndex];
                                },
                                currentIndex: appLayoutCubit.selectedIndex,
                                selectedFontSize: 12,
                                unselectedFontSize: 12,
                                type: BottomNavigationBarType.fixed,
                                selectedIconTheme:
                                const IconThemeData(color: AppPalette.primary),
                                unselectedIconTheme:
                                const IconThemeData(color: Colors.black),
                                items: appLayoutCubit.bottomNavigationBarItem,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }else {
                  return Scaffold(
                      body: Center(
                        child: AnimatedTextKit(
                          animatedTexts: [
                            WavyAnimatedText(LocaleKeys.markety.tr(),
                                textStyle: TextStyle(
                                    fontSize: 20.0.sp,
                                    color: Themes.colorApp13,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Poppins-bold')),
                          ],
                          isRepeatingAnimation: true,
                          totalRepeatCount: 6,
                          onTap: () {},
                        ),
                      ));
                }

              }),
        ),
      ),
    );
  }

  loadData() {
    BlocProvider.of<CategoriesCubit>(context, listen: false)
        .getParentCategories();

    if(AppLocalStorage.token != null){
      BlocProvider.of<ProfileCubit>(context).getUserProfile();
      print('user profile');
    }else {}

  }

  loadDataProduct() {
    BlocProvider.of<HomeCubit>(context, listen: false)
        .getRecommendationProducts(refresh: true);

    BlocProvider.of<AddProductCubit>(context, listen: false).getMyProductUser(refresh: true);

  }
  loadDataProfile() {
    BlocProvider.of<ProfileCubit>(context, listen: false)
        .getUserProfile();
  }


}
