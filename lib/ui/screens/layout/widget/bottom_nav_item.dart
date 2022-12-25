import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop/utils/app_size_boxes.dart';

import '../../../../translations/locale_keys.g.dart';
import '../../../../utils/dimensions.dart';
import '../../../../utils/styles.dart';

class BottomNavItem extends StatelessWidget {
  final String icon;
  final Function()? onTap;
  final bool isSelected;
  final String? title;
  const BottomNavItem({Key? key,
    required this.icon,
    required this.title,
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
            SvgPicture.asset(
              icon,
              color: isSelected ? Theme.of(context).primaryColor : Colors.black,
              fit: BoxFit.scaleDown,
              height: 12,
              width: 12,
            ),
        Text(
          '$title',
          style: TextStyle(
            color: isSelected ? Theme.of(context).primaryColor : Colors.black,
            fontFamily: Fonts.poppins,
            fontSize: 10,
          ),
        ),
            // 1.heightBox,
            // if (isSelected)
            //   SvgPicture.asset(
            //     "assets/images/svg/Line.svg",
            //     color: isSelected ? Theme.of(context).primaryColor : Colors.black,
            //     fit: BoxFit.scaleDown,
            //     width: 25.sp,
            //   ),
          ],
        ),
        onPressed: onTap,
      ),
    );
  }
}
