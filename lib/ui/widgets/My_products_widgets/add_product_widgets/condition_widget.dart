import 'package:flutter/material.dart';
import 'package:shop/utils/dimensions.dart';

class ConditionWidget extends StatelessWidget {
  String title;
  Function() onTap;
  Color color;
  Color textColor;
  ConditionWidget(
      {Key? key,
      required this.title,
      required this.onTap,
      required this.color,
      required this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(Dimensions.radiusDefault)),
        padding: EdgeInsets.symmetric(
            horizontal: Dimensions.fontSizeSmall,
            vertical: Dimensions.paddingSmall),
        child: Text(title, overflow: TextOverflow.ellipsis,maxLines : 1, style: TextStyle(color: textColor,fontSize: 13)),
      ),
    );
  }
}
