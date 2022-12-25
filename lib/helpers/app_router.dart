import 'package:flutter/material.dart';
import 'package:shop/ui/screens/onboarding/onboarding_screen.dart';
import 'package:shop/ui/screens/auth/add_new_password.dart';
import 'package:shop/ui/screens/auth/forget_password.dart';
import 'package:shop/ui/screens/auth/login_screen.dart';
import 'package:shop/ui/screens/auth/signup_screen.dart';
import 'package:shop/ui/screens/layout/app_layout.dart';
import 'package:shop/ui/screens/splash_screen.dart';
import '../data/repositories/auth_repo.dart';
import '../utils/app_constants.dart';

class AppRouter {
  late AuthRepo authRepo;

  // ignore: always_specify_types
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppConstants.splashScreen:
        // ignore: always_specify_types
        return MaterialPageRoute(
          builder: (_) => SplashScreen(),
        );
      case AppConstants.onBoardingScreen:
        // ignore: always_specify_types
        return MaterialPageRoute(
          builder: (_) => const OnBoardingScreen(),
        );
      case AppConstants.loginScreen:
        // ignore: always_specify_types
        return MaterialPageRoute(
          // ignore: always_specify_types
          builder: (_) => const LoginScreen(),
        );
      case AppConstants.signUpScreen:
        // ignore: always_specify_types
        return MaterialPageRoute(
          // ignore: always_specify_types
          builder: (_) => const SignUPScreen(),
        );
      case AppConstants.appLayout:
        // ignore: always_specify_types
        return MaterialPageRoute(
          // ignore: always_specify_types
          builder: (_) => AppLayout(),
        );
      case AppConstants.forgetPasswordScreen:
        // ignore: always_specify_types
        return MaterialPageRoute(
          // ignore: always_specify_types
          builder: (_) => const ForgetPassword(),
        );
      case AppConstants.addNewPasswordScreen:
        // ignore: always_specify_types
        return MaterialPageRoute(
          // ignore: always_specify_types
          builder: (_) => AddNewPassword(),
        );
    }
    return null;
  }
}
