// ignore_for_file: must_be_immutable

import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shop/utils/Themes.dart';
import 'package:shop/utils/app_palette.dart';
import 'package:shop/utils/app_size_boxes.dart';

import '../../business_logic/app_layout_cubit/app_layout_cubit.dart';
import '../../helpers/components.dart';
import '../../translations/locale_keys.g.dart';
import '../../ui/base/custom_button.dart';
import '../../ui/screens/layout/app_layout.dart';
import '../../utils/dimensions.dart';

class ErrorScreenConnection extends StatelessWidget {

  ErrorScreenConnection({Key? key,this.onPressed}) : super(key: key);
  Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Image.asset(
            "assets/images/network_dis_connection.png",
            height: 200,
            fit: BoxFit.contain,
            width: 200,
          ),
          SizedBox(height: 15.h,),
          Shimmer.fromColors(
            baseColor: Colors.black,
            highlightColor: Themes.grayColor,
            child: Text(
              LocaleKeys.errorConnectionScreens.tr(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
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
                    LocaleKeys.errorConnectionScreens2.tr(),
                    style:  const TextStyle(
                        color: AppPalette.lightPrimary,
                        fontSize: 15.0,
                        fontFamily: 'Poppins-Medium'),
                    textAlign: TextAlign.center),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              bottom: Dimensions.paddingSizeDefault,
              right: Dimensions.paddingSizeLarge,
              left: Dimensions.paddingSizeLarge,
            ),
            child: CustomButton(
              buttonText: LocaleKeys.refresh.tr(),
              onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => AppLayout()), (route) => false),
              height: 48.h,
              fontSize: Dimensions.fontSizeLarge,
            ),
          ),
          0.heightBox
        ],
      ),
    );
  }
}
