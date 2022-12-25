// ignore_for_file: must_be_immutable

import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shop/utils/Themes.dart';
import 'package:shop/utils/app_palette.dart';
import 'package:shop/utils/app_size_boxes.dart';
import 'package:shop/utils/styles.dart';

import '../../business_logic/app_layout_cubit/app_layout_cubit.dart';
import '../../helpers/components.dart';
import '../../translations/locale_keys.g.dart';
import '../../ui/base/custom_button.dart';
import '../../ui/screens/layout/app_layout.dart';
import '../../utils/dimensions.dart';

class NoInternetConnectionScreen extends StatelessWidget {

  AppLayoutState appLayoutState;
  NoInternetConnectionScreen({Key? key,required this.appLayoutState}) : super(key: key);

  void showCustomDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 700),
      pageBuilder: (_, __, ___) {
        return Center(
          child: Container(
            height: 125,
            child: Column(
              children: [
                10.heightBox,
                AutoSizeText(
                  LocaleKeys.doYouQuit.tr(),
                  style: Theme.of(context).textTheme.headline2!.copyWith(
                      color: AppPalette.black,
                      fontWeight: FontWeight.w400,
                      fontFamily: Fonts.poppins,
                      fontSize: 17.0),
                ),
                10.heightBox,
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          SystemNavigator.pop();
                        },
                        child: Text(LocaleKeys.yes.tr())),
                    10.widthBox,
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                        child: Text(LocaleKeys.no.tr())
                    )
                  ],
                ),
                10.heightBox,
              ],
            ),
            margin: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        Tween<Offset> tween;
        if (anim.status == AnimationStatus.reverse) {
          tween = Tween(begin: Offset(-1, 0), end: Offset.zero);
        } else {
          tween = Tween(begin: Offset(1, 0), end: Offset.zero);
        }

        return SlideTransition(
          position: tween.animate(anim),
          child: FadeTransition(
            opacity: anim,
            child: child,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPalette.primary,
      body:  SafeArea(
        child: Column(
          children: [
            22.heightBox,
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 15.h),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () async{
                     if (appLayoutState is ConnectionFailure){
                       showCustomDialog(context);
                     }else if(appLayoutState is ConnectionSuccess){
                       navigateReplaceTo(context: context, widget: AppLayout());
                     }
                    },
                    child: Icon(Icons.arrow_back_ios,color: AppPalette.white,size: 25.sp,),
                  ),
                  Expanded(
                    child: Center(
                      child: AutoSizeText(
                        LocaleKeys.connection.tr(),
                        style: Theme.of(context).textTheme.headline2!.copyWith(
                            color: AppPalette.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 15.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            22.heightBox,
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                    color: AppPalette.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    35.heightBox,
                    Image.asset(
                      "assets/images/network_dis_connection.png",
                      fit: BoxFit.contain,
                    ),
                    SizedBox(height: 15.h,),
                    Shimmer.fromColors(
                      baseColor: Colors.black,
                      highlightColor: Themes.colorApp2,
                      child: Text(
                        LocaleKeys.internetConnection.tr(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppPalette.black
                        ),
                      ),
                    ),
                    SizedBox(height: 5.h,),
                    Center(
                      child: Padding(
                        padding:  const EdgeInsets.all(15),
                        child: Shimmer.fromColors(
                          baseColor: Colors.black,
                          highlightColor: AppPalette.lightPrimary,
                          child:  Text(
                              LocaleKeys.internetConnection2.tr(),
                              style:  const TextStyle(
                                  color: AppPalette.black,
                                  fontSize: 14.0,
                                  fontFamily: 'Poppins-Medium'),
                              textAlign: TextAlign.center),
                        ),
                      ),
                    ),
                    Spacer(),
                    appLayoutState is ConnectionFailure ? Container(
                      padding: EdgeInsets.only(
                        bottom: Dimensions.paddingSizeDefault,
                        right: Dimensions.paddingSizeDefault,
                        left: Dimensions.paddingSizeDefault,
                      ),
                      child: CustomButton(
                        buttonText: LocaleKeys.refresh.tr(),
                        onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (context) => AppLayout()), (route) => false),
                        height: 48.h,
                        fontSize: Dimensions.fontSizeLarge,
                      ),
                    ) : Container(),
                  ],
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}
