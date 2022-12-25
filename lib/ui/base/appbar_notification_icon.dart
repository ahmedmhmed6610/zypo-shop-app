import 'package:flutter/material.dart';

import '../../utils/app_palette.dart';
import '../../utils/dimensions.dart';

class AppBarNotificationIcon extends StatelessWidget {
  const AppBarNotificationIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Dimensions.paddingSizeSmall),
      child: Card(
        elevation: 0,
        color: AppPalette.lightPrimary,
        child: Padding(
          padding: EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
          child: const Icon(
            Icons.notifications_none,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
