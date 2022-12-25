import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../utils/app_palette.dart';
import '../../utils/dimensions.dart';
import '../../utils/styles.dart';

class CustomButton extends StatelessWidget {
  final Function()? onPressed;
  final String buttonText;
  final EdgeInsets? margin;
  final double? height;
  final double? width;
  final double? fontSize;
  final IconData? icon;
  final String? svgIcon;
  const CustomButton({
    Key? key,
    this.onPressed,
    required this.buttonText,
    this.margin,
    this.width,
    this.height,
    this.fontSize,
    this.icon,
    this.svgIcon,
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
                  svgIcon != null
                      ? Padding(
                          padding: EdgeInsets.only(
                              right: Dimensions.paddingSizeExtraSmall),
                          child: SizedBox(
                            child: SvgPicture.asset(svgIcon!,
                                fit: BoxFit.scaleDown, color: AppPalette.white),
                            height: 22.sp,
                            width: 22.sp,
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
