
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop/utils/styles.dart';
import '../utils/app_palette.dart';
import '../utils/dimensions.dart';

ThemeData lightTheme = ThemeData(
  /// main colors
  primaryColor: AppPalette.primary,
  primaryColorLight: AppPalette.lightPrimary,
  disabledColor: Colors.white,
  splashColor: AppPalette.lightPrimary,
  scaffoldBackgroundColor: Colors.white,

  /// card theme
  cardTheme: CardTheme(
    color: Colors.white,
    shadowColor: AppPalette.shadowColor,
    elevation: 5,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(
          Dimensions.radiusDefault,
        ),
      ),
    ),
    margin: EdgeInsets.zero,
  ),
  iconTheme: IconThemeData(
    color: Colors.black,
    size: 24.sp,
  ),

  /// appBar theme
  appBarTheme: AppBarTheme(
    color: Colors.white,
    centerTitle: true,
    elevation: 5.0,
    shadowColor: AppPalette.lightPrimary,
    actionsIconTheme: IconThemeData(
      color: Colors.white,
      size: Dimensions.fontSizeOverLarge,
    ),
    titleTextStyle: AppTextStyles.poppinsRegular.copyWith(
      color: AppPalette.textColor,
      fontSize: Dimensions.fontSizeLarge,
    ),
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: AppPalette.primary,
    elevation: 20.0,
    backgroundColor: Colors.white,
  ),

  /// button theme
  buttonTheme: const ButtonThemeData(
    shape: StadiumBorder(),
    disabledColor: AppPalette.lightPrimary,
    buttonColor: AppPalette.primary,
    splashColor: AppPalette.lightPrimary,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppPalette.primary,
      textStyle: AppTextStyles.poppinsRegular.copyWith(
        fontSize: Dimensions.fontSizeLarge,
        color: Colors.white,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          10.r,
        ),
        side: BorderSide(
          width: 1.0.w,
          color: Colors.transparent,
        ),
      ),
      elevation: 3,
    ),
  ),

  /// text theme
  textTheme: TextTheme(
      headline1: AppTextStyles.poppinsRegular.copyWith(
        fontSize: Dimensions.fontSizeOverLarge,
        color: Colors.black,
      ),
      headline2: AppTextStyles.poppinsRegular.copyWith(
        fontSize: Dimensions.fontSizeLarge,
        color: AppPalette.lightBlack,
      ),
      bodyText1: AppTextStyles.poppinsRegular.copyWith(
        color: AppPalette.grey,
      ),
      caption: AppTextStyles.poppinsRegular.copyWith(
        color: AppPalette.primary,
      ),
      headline3: AppTextStyles.poppinsMedium.copyWith(
        color: Colors.black,
        fontSize: Dimensions.fontSizeExtraLarge,
      )),
  inputDecorationTheme: InputDecorationTheme(
    contentPadding: EdgeInsets.all(
      Dimensions.paddingSizeDefault,
    ),
    hintStyle: AppTextStyles.poppinsRegular.copyWith(
      color: AppPalette.grey,
    ),
    labelStyle: AppTextStyles.poppinsRegular.copyWith(
      color: Colors.black,
    ),
    errorStyle: AppTextStyles.poppinsRegular.copyWith(
      color: AppPalette.error,
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: AppPalette.primary,
        width: Dimensions.borderSmall,
      ),
      borderRadius: BorderRadius.all(
        Radius.circular(
          Dimensions.radiusDefault,
        ),
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: AppPalette.grey,
        width: Dimensions.borderSmall,
      ),
      borderRadius: BorderRadius.all(
        Radius.circular(
          Dimensions.radiusDefault,
        ),
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: AppPalette.error,
        width: Dimensions.borderSmall,
      ),
      borderRadius: BorderRadius.all(
        Radius.circular(
          Dimensions.radiusDefault,
        ),
      ),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: AppPalette.primary,
        width: Dimensions.borderSmall,
      ),
      borderRadius: BorderRadius.all(
        Radius.circular(
          Dimensions.radiusDefault,
        ),
      ),
    ),
  ),
);
