import 'package:flutter/material.dart';
import 'package:shop/translations/locale_keys.g.dart';
import 'package:shop/utils/app_palette.dart';
import 'package:shop/utils/app_size_boxes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shop/utils/styles.dart';

class MyLocationWidget extends StatelessWidget {
  MyLocationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Row(
        children: [
          const Icon(Icons.my_location, color: AppPalette.primary, size: 22.0),
          12.widthBox,
          Text(LocaleKeys.currentLocation.tr(),
              style: AppTextStyles.poppinsRegular
                  .copyWith(color: AppPalette.black)),
        ],
      ),
    );
  }
}
