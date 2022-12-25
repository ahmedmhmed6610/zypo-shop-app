import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop/utils/app_palette.dart';
import 'package:shop/utils/dimensions.dart';

class AddButtonWidget extends StatelessWidget {
  Widget child;
  AddButtonWidget({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.r,
      width: 40.r,
      child: Material(
        color: AppPalette.primary,
        shadowColor: AppPalette.shadowColor2,
        elevation: 3.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
        ),
        child: child,
      ),
    );
  }
}
