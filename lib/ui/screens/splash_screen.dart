import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shop/ui/screens/layout/app_layout.dart';
import 'package:shop/utils/app_palette.dart';

import '../../helpers/app_local_storage.dart';
import 'onboarding/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  // void _checkVersion() async {
  //
  //   final newVersion = NewVersion(
  //     androidId: "com.snapchat.android",
  //   );
  //   final status = await newVersion.getVersionStatus();
  //   print("DEVICE : " + status!.localVersion);
  //   print("STORE : " + status.storeVersion);
  //   newVersion.showUpdateDialog(
  //     context: context,
  //     versionStatus: status,
  //     dialogTitle: "UPDATE!!!",
  //     dismissButtonText: "Skip",
  //     //  dialogText: "Please update the app from " + "${status.localVersion}" + " to " + "${status.storeVersion}",
  //     dismissAction: () {
  //       SystemNavigator.pop();
  //     },
  //     updateButtonText: "Lets update",
  //   );
  //
  //   print("DEVICE : " + status.localVersion);
  //   print("STORE : " + status.storeVersion);
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  //  _checkVersion();
    if (kDebugMode) {
      print("token is ${AppLocalStorage.token}");
    }
    Timer(const Duration(seconds: 3), () => Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => AppLocalStorage.token != "" ? AppLayout() :
        const OnBoardingScreen()), (route) => false));
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light),
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration:  const BoxDecoration(
            color: AppPalette.primary,
          ),
          child: Center(
            child: Image.asset('assets/images/image_splash.png',color: AppPalette.white,
              fit: BoxFit.contain,width: 215,height: 73,),
          ),
        ),
      ),
    );
  }
}
