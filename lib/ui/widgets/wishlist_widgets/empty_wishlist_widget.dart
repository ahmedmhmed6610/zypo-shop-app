import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shop/translations/locale_keys.g.dart';
import 'package:shop/utils/app_palette.dart';
import 'package:easy_localization/easy_localization.dart';

class EmptyWishListWidget extends StatelessWidget {
  const EmptyWishListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SizedBox(
      height: height,
      width: width,
      child: Column(
        children: [
          Container(
            constraints: BoxConstraints(
                minHeight: height * 0.4, maxHeight: height * 0.6),
            child: Lottie.asset("assets/lottie/emptyWishList.json"),
          ),
          SizedBox(
            height: height * 0.04,
          ),
          AutoSizeText(
            LocaleKeys.emptyWishList.tr(),
            style: Theme.of(context).textTheme.headline2!.copyWith(
                color: AppPalette.black,
                fontWeight: FontWeight.w600,
                fontSize: 20.0),
          ),
          SizedBox(
            height: height * 0.1,
          ),
        ],
      ),
    );
  }
}
