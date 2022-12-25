import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop/translations/locale_keys.g.dart';
import 'package:shop/utils/app_palette.dart';
import 'package:shop/utils/app_size_boxes.dart';
import 'package:shop/utils/dimensions.dart';
import 'package:easy_localization/easy_localization.dart';

class ContactHintWidget extends StatelessWidget {
  const ContactHintWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 50.w,
          height: 50.h,
          child: Card(
            shadowColor: AppPalette.white,
            shape: RoundedRectangleBorder(
               borderRadius: BorderRadius.circular(Dimensions.radiusSmall)
           ),
            elevation: 3,
            child: const Icon(Icons.mail, size: 35.0, color: AppPalette.primary),
          ),
        ),
        10.widthBox,
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(LocaleKeys.email.tr(),
                style: const TextStyle(color: AppPalette.black)),
            8.heightBox,
            const Text("info@info.com",
                style: TextStyle(color: AppPalette.black))
          ],
        ),
      ],
    );
  }
}
