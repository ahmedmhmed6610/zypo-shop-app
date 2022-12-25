

import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop/translations/locale_keys.g.dart';
import 'package:shop/utils/app_size_boxes.dart';

import '../../../helpers/components.dart';
import '../../../utils/app_palette.dart';
import '../../../utils/dimensions.dart';
import '../../base/custom_button.dart';
import '../layout/app_layout.dart';

class ProductSoldScreen extends StatefulWidget {
  const ProductSoldScreen({Key? key}) : super(key: key);

  @override
  _ProductSoldScreenState createState() => _ProductSoldScreenState();
}

class _ProductSoldScreenState extends State<ProductSoldScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height * 0.024;
    return Scaffold(
      backgroundColor: AppPalette.primary,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            25.heightBox,
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 15.h),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: ()=> navigateReplaceTo(context: context, widget: AppLayout()),
                    child: Icon(Icons.arrow_back_ios,color: AppPalette.white,size: 25.sp,),
                  ),
                  Expanded(
                    child: Center(
                      child: AutoSizeText(
                        LocaleKeys.productSold.tr(),
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
            25.heightBox,
            Container(
              decoration: const BoxDecoration(
                  color: AppPalette.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: height * 0,),
                  Image.asset(
                    "assets/images/product_sold.png",
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: height * 2),
                  Text(
                    LocaleKeys.saleOne.tr(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      color: AppPalette.black,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: height * .5),
                  Text(
                    LocaleKeys.saleTwo.tr(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      color: AppPalette.black,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: height * 5),
              Container(
                  padding: EdgeInsets.only(
                    bottom: Dimensions.paddingSizeDefault,
                    right: Dimensions.paddingSizeDefault,
                    left: Dimensions.paddingSizeDefault,
                  ),
                  child: CustomButton(
                    buttonText: LocaleKeys.back.tr(),
                    onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => AppLayout()), (route) => false),
                    height: 48.h,
                    fontSize: Dimensions.fontSizeLarge,
                  )),
                ],
              ),
            ),
          ],
        )
      )),
    );
  }
}
