import 'package:flutter/material.dart';
import 'app_palette.dart';
import 'dimensions.dart';

class Fonts {
  static const String poppins = "Poppins";
}

class AppTextStyles {
  //poppins
  static final TextStyle poppinsLight = TextStyle(
    color: AppPalette.primary,
    fontFamily: Fonts.poppins,
    fontWeight: FontWeight.w300,
    fontSize: Dimensions.fontSizeDefault,
  );
  static final TextStyle caption = TextStyle(
    color: AppPalette.grey,
    fontFamily: Fonts.poppins,
    fontWeight: FontWeight.w300,
    fontSize: Dimensions.fontSizeSmall,
  );
  static final TextStyle poppinsRegular = TextStyle(
    color: AppPalette.primary,
    fontFamily: Fonts.poppins,
    fontWeight: FontWeight.w400,
    fontSize: Dimensions.fontSizeLarge,
  );

  static final TextStyle poppinsMedium = TextStyle(
    color: AppPalette.primary,
    fontFamily: Fonts.poppins,
    fontWeight: FontWeight.w500,
    fontSize: Dimensions.fontSizeDefault,
  );
}
