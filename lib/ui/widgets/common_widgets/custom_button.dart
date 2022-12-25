import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop/utils/dimensions.dart';
import 'package:shop/utils/styles.dart';

class CustomButton extends StatelessWidget {
  final Function()? onPressed;
  final String buttonText;
  final EdgeInsets? margin;
  final double? height;
  final double? width;
  final double? fontSize;
  final IconData? icon;
  const CustomButton({
    Key? key,
    this.onPressed,
    required this.buttonText,
    this.margin,
    this.width,
    this.height,
    this.fontSize,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: width,
        height: height,
        child: Padding(
          padding: margin ?? EdgeInsets.zero,
          child: ElevatedButton(
            onPressed: onPressed,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  icon != null
                      ? Padding(
                          padding: EdgeInsets.only(
                              right: Dimensions.paddingSizeExtraSmall),
                          child: Icon(
                            icon,
                            color: Colors.white,
                            size: 22.sp,
                          ),
                        )
                      : const SizedBox(),
                  Text(buttonText,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.poppinsRegular.copyWith(
                        color: Colors.white,
                        fontSize: fontSize ?? Dimensions.fontSizeDefault,
                      )),
                ]),
          ),
        ));
  }
}
