import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop/utils/app_size_boxes.dart';

class BottomNavItem2 extends StatelessWidget {
  final String icon;
  final Function()? onTap;
  final bool isSelected;
  const BottomNavItem2({Key? key,
    required this.icon,
    this.onTap,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: IconButton(
        icon: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
                width: 95.w,
                height: 95.h,
                child: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: CachedNetworkImageProvider(icon),
                          fit: BoxFit.contain)),
                )),
            1.heightBox,
            if (isSelected)
              SizedBox(
                  width: 95.w,
                  height: 95.h,
                  child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: CachedNetworkImageProvider(icon),
                            fit: BoxFit.contain)),
                  )),
          ],
        ),
        onPressed: onTap,
      ),
    );
  }
}
