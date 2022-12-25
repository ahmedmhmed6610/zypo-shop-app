// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:shop/utils/app_palette.dart';
import 'package:shop/utils/dimensions.dart';

class ListTileItemWidget extends StatelessWidget {
  String title;
  Widget? trailing;
  Widget? leading;
  Function() onTap;
  BoxBorder? border;
  TextStyle? textStyle;

  ListTileItemWidget(
      {Key? key,
      required this.title,
      this.trailing,
      this.leading,
      this.textStyle,
      required this.onTap,
      this.border})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
        border: border,
        color: AppPalette.white,
        boxShadow: const [
          BoxShadow(
            color: AppPalette.shadowColor2,
            spreadRadius: 0.7,
            blurRadius: 3,
            offset: Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      margin: EdgeInsets.symmetric(
          horizontal: Dimensions.paddingSize,
          vertical: Dimensions.paddingSmall),
      child: ListTile(
        title: Text(title, style: textStyle),
        trailing: trailing,
        leading: leading,
        onTap: onTap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
        ),
      ),
    );
  }
}
