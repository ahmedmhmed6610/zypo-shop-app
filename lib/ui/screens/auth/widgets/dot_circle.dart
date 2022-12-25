import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../utils/images.dart';

class DotCircle extends StatelessWidget {
  const DotCircle({
    Key? key,
    this.left,
    this.top,
    this.right,
    this.bottom,
    this.height = 16,
    this.width = 16,
  }) : super(key: key);
  final double? left, top, right, bottom;
  final double height, width;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: left?.w,
      top: top?.h,
      right: right?.w,
      bottom: bottom?.h,
      child: SvgPicture.asset(
        Images.loginDot,
        height: height.h,
        width: width.w,
      ),
    );
  }
}
