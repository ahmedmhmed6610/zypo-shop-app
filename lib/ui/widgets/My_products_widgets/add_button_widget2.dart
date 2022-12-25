import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop/utils/app_palette.dart';
import 'package:shop/utils/dimensions.dart';

class AddButtonWidget2 extends StatelessWidget {
  Widget child;
  void Function()? onTap;
  Color? colorBackground;
  AddButtonWidget2({Key? key, required this.child,required this.onTap,required this.colorBackground}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 50.r,
        width: MediaQuery.of(context).size.width,
        child: Material(
          color: colorBackground,
          shadowColor: AppPalette.shadowColor2,
          elevation: 0.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
          ),
          child: child,
        ),
      ),
    );
  }
}
