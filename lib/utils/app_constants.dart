class AppConstants {
  // Api Endpoints
  //TODO:set urls
  static const String baseUrl = 'http://shop-crm.germaniatek.net/api';
  static const String loginUri = '';

  // routes
  static const String splashScreen = '/splash-screen';
  static const String onBoardingScreen = '/on-boarding-screen';
  static const String loginScreen = '/login-screen';
  static const String signUpScreen = '/signup-screen';
  static const String appLayout = '/app-layout';
  static const String profileScreen = '/profile-screen';
  static const String forgetPasswordScreen = '/forget-password-screen';
  static const String addNewPasswordScreen = '/add-new-password-screen';
  // Shared Key
  static const String userToken = 'token';
  static const String language = 'language';
  static const String onBoardingSeen = 'onBoarding-Seen';
  static const String userData = 'user-data';
  static const String imageBasePath = 'assets/images';

}

var  personalData = 'personalData';
String? fcmToken;
String profileImage =
    "https://img.freepik.com/free-vector/cute-gentleman-character-illustration_24877-60133.jpg?t=st=1658505623~exp=1658506223~hmac=3ee77155aae3cea1d1f3d7eccb20aa72617e4dfb894551a6223da59d10b52718&w=740";

// https://img.freepik.com/free-vector/cute-gentleman-character-illustration_24877-60133.jpg?t=st=1658505623~exp=1658506223~hmac=3ee77155aae3cea1d1f3d7eccb20aa72617e4dfb894551a6223da59d10b52718&w=740
// flutter pub run easy_localization:generate -S "assets/translations" -O "lib/translations"
//
//
// flutter pub run easy_localization:generate -S "assets/translations" -O "lib/translations" -o "locale_keys.g.dart" -f keys
