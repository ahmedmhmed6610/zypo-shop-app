import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop/utils/app_size_boxes.dart';

import '../../../utils/app_palette.dart';

class CustomAppBar extends StatelessWidget {
   CustomAppBar({Key? key,required this.onTap,required this.title,required this.widgetCustom}) : super(key: key);
  Widget widgetCustom;
  void Function()? onTap;
  String? title;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
          children: [
            22.heightBox,
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 15.h),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: onTap,
                    child: Icon(Icons.arrow_back_ios,color: AppPalette.white,size: 25.sp,),
                  ),
                  Expanded(
                    child: Center(
                      child: AutoSizeText(
                        '$title',
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
                  child: widgetCustom,
                ))
          ],
        ));
  }
}
