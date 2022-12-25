// ignore_for_file: deprecated_member_use

import 'dart:io';
import 'package:device_preview/device_preview.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_translator/google_translator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop/business_logic/app_layout_cubit/app_layout_cubit.dart';
import 'package:shop/business_logic/app_ui_cubit/app_ui_cubit.dart';
import 'package:shop/business_logic/auth_cubit/auth_cubit.dart';
import 'package:shop/business_logic/brand_cubit/brand_cubit.dart';
import 'package:shop/business_logic/categories_cubit/categories_cubit.dart';
import 'package:shop/business_logic/contact_us_cubit.dart';
import 'package:shop/business_logic/filter_cubit/filter_cubit.dart';
import 'package:shop/business_logic/home_cubit/home_cubit.dart';
import 'package:shop/business_logic/locations_cubit/locations_cubit.dart';
import 'package:shop/business_logic/my_favorite_user_cubit/my_favorite_user_cubit.dart';
import 'package:shop/business_logic/my_products_cubit/my_products_cubit.dart';
import 'package:shop/business_logic/notification_cubit/notification_cubit.dart';
import 'package:shop/business_logic/personal_data_cubit/personal_data_cubit.dart';
import 'package:shop/business_logic/product_details_cubit/product_details_cubit.dart';
import 'package:shop/business_logic/profile_cubit/profile_cubit.dart';
import 'package:shop/business_logic/search_user_cubit/search_user_cubit.dart';
import 'package:shop/business_logic/wishlist_cubit/wishlist_cubit.dart';
import 'package:shop/data/internet_connectivity/bloc/network_bloc.dart';
import 'package:shop/helpers/cache_helper.dart';
import 'package:shop/translations/codegen_loader.g.dart';
import 'business_logic/add_ads_poduct_cubit/add_ads_product_cubit.dart';
import 'business_logic/add_favorite_user_cubit/add_favorite_user_cubit.dart';
import 'business_logic/update_profile_cubit/update_profile_cubit.dart';
import 'helpers/app_local_storage.dart';
import 'helpers/app_router.dart';
import 'helpers/bloc_observer.dart';
import 'helpers/dio_helper.dart';
import 'helpers/logger_helper.dart';
import 'themes/light_theme.dart';
import 'utils/app_constants.dart';
import 'utils/strings.dart';


SharedPreferences? sharedPreferences;

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {}

Future<void> main() async {
  // this line because there is no ssl certificate
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  await EasyLocalization.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await Firebase.initializeApp();
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  ///requesting permission for ios
  await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: true,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  //on app terminated notification
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await AppLocalStorage.init();
  await CacheHelper.init();

  // check token is null or no
  CacheHelper().getToken != null ? AppLocalStorage.token = CacheHelper().getToken : null;
  CacheHelper().getLanguage != null ? AppLocalStorage.language = CacheHelper().getLanguage : null;
  // CacheHelper.getData(key: 'userName') != null ? globals.userName = CacheHelper.getData(key: 'userName') : null;


  LoggerHelper.init();
  DioHelper.init();
  AppLocalStorage.token =
  await AppLocalStorage.getValue(AppConstants.userToken);
  AppLocalStorage.user = await _getUserDataLocalStorage();
  late String initialRoute;
  initialRoute = await _getInitialRoute();
  BlocOverrides.runZoned(
        () {
      runApp(
        Phoenix(
          child: EasyLocalization(
            child: MyApp(
              appRouter: AppRouter(),
              initialRoute: AppConstants.splashScreen,
            ),
            assetLoader: const CodegenLoader(),
            supportedLocales:const [ Locale('en'),  Locale('ar')],
            path: 'assets/translations',
            fallbackLocale: const Locale('en'),
          ),
        ), // DevicePreview(
        //   enabled: !kReleaseMode,
        //   builder: (context) => MyApp(
        //     appRouter: AppRouter(),
        //     initialRoute: initialRoute,
        //   ), // Wrap your app
        // ),
      );
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
   MyApp({
    Key? key,
    required this.appRouter,
    required this.initialRoute,
  }) : super(key: key);
  final AppRouter appRouter;
  final String initialRoute;
  final String apiKey = "AIzaSyAL_RDg-PfMZ0Ge8qKALvPPdGTHldRL0cc";
  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;


  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => NotificationCubit(),
          ),
          BlocProvider(
            create: (context) => MyFavoriteUserCubit(),
          ),
          BlocProvider(
            create: (context) => AddFavoriteUserCubit(),
          ),
          BlocProvider(
            create: (context) => UpdateProfileCubit(),
          ),
          BlocProvider(
            create: (context) => AppUiCubit(),
          ),
          BlocProvider<HomeCubit>(
            create: (context) => HomeCubit(),
          ),
          BlocProvider<AuthCubit>(
            create: (context) => AuthCubit(),
          ),
          BlocProvider(
            create: (context) => CategoriesCubit(),
          ),
          BlocProvider(
            create: (context) => NetworkBloc(),
          ),
          BlocProvider(
            create: (context) => ContactUsCubit(),
          ),
          BlocProvider(
            create: (context) => ProfileCubit(),
          ),
          BlocProvider(
            create: (context) => WishlistCubit(),
          ),
          BlocProvider(
            create: (context) => AddProductCubit(),
          ),
          BlocProvider(
            create: (context) => AddAdsProductCubit(),
          ),
          BlocProvider(
            create: (context) => PersonalDataCubit(),
          ),
          BlocProvider(
            create: (context) => SearchUserCubit(),
          ),
          BlocProvider(
            create: (context) => AppLayoutCubit(),
          ),
          BlocProvider(
            create: (context) => FilterCubit(),
          ),
          BlocProvider<ProductDetailsCubit>(
            create: (context) => ProductDetailsCubit(),
          ),
          BlocProvider(
            create: (context) => CategoriesCubit(),
          ),
          BlocProvider(
            create: (context) => BrandCubit(),
          ),
          BlocProvider(
            create: (context) => LocationsCubit(),
          ),
          BlocProvider(
            create: (context) => CategoriesCubit(),
          ),
        ],
        child: ScreenUtilInit(
            designSize: const Size(360, 730),
            builder: (BuildContext context, Widget? child) =>
                MaterialApp(
                  // useInheritedMediaQuery: true,
                  navigatorObservers: [
                    FirebaseAnalyticsObserver(analytics: analytics),
                  ],
                  builder: DevicePreview.appBuilder,
                  // home: VerificationCodeScreen(),
                  supportedLocales: context.supportedLocales,
                  localizationsDelegates: context.localizationDelegates,
                  locale: context.locale,
                  // ignore: always_specify_types
                  debugShowCheckedModeBanner: false,
                  title: AppStrings.appName,
                  onGenerateRoute: appRouter.generateRoute,
                  initialRoute: initialRoute,
                  theme: lightTheme,
                )
        ),);
  }
}

Future<User?> _getUserDataLocalStorage() async {
  if (await AppLocalStorage.containsKey(AppConstants.userData)) {
    return User.fromJson(await AppLocalStorage.getMap(AppConstants.userData));
  }
  return null;
}

Future<String> _getInitialRoute() async {
  if (await AppLocalStorage.containsKey(AppConstants.onBoardingSeen)) {
    if (await AppLocalStorage.containsKey(AppConstants.userToken)) {
      return AppConstants.splashScreen;
    } else {
      return AppConstants.loginScreen;
    }
  } else {
    return AppConstants.onBoardingScreen;
  }
}

/// this class because there is no ssl certificate
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
