import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop/utils/app_palette.dart';

class SuccessAlertDialog extends StatelessWidget {
  final String title;
  final String confirmLabel;
  final String imageUrl;
  Function()? onTap;
  SuccessAlertDialog(
      {Key? key,
      required this.title,
      required this.confirmLabel,
      required this.imageUrl,
      this.onTap})
      : super(key: key);

  static showConfirmationDialog(
    BuildContext context, {
    required String title,
    required String confirmLabel,
    required String imageUrl,
    Function()? onTap,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          content: SuccessAlertDialog(
            title: title,
            confirmLabel: confirmLabel,
            imageUrl: imageUrl,
            onTap: onTap,
          ),
          insetPadding: const EdgeInsets.all(0),
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.r),
            ),
          ),
          contentPadding: EdgeInsets.all(10.r),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.height * 0.31,
      width: size.width * 0.8,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            child: InkWell(
              onTap: onTap,
              child: const Icon(Icons.close),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                margin: EdgeInsets.only(
                  top: 10.h,
                  bottom: 8.h,
                ),
                child: SvgPicture.asset(imageUrl,
                    height: 120.h, fit: BoxFit.scaleDown),
              ),
              Padding(
                padding: EdgeInsets.all(6.h),
                child: Tooltip(
                  message: title,
                  decoration: BoxDecoration(
                      color: AppPalette.primary.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(10.r)),
                  margin: EdgeInsets.all(18.r),
                  preferBelow: false,
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 15.sp,
                      color: AppPalette.black,
                    ),
                    // maxFontSize: 15.sp,
                    // minFontSize: 13.sp,
                    softWrap: true,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: onTap,
                child: Text(confirmLabel),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
