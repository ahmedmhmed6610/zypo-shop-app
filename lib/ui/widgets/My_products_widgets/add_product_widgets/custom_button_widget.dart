import 'package:flutter/material.dart';
import 'package:shop/utils/app_palette.dart';
import 'package:shop/utils/dimensions.dart';

class CustomButtonWidget extends StatelessWidget {
  String title;
  Function() onTap;
  CustomButtonWidget({Key? key, required this.title, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppPalette.lightPrimary,
        borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
      ),
      child: ListTile(
        title: Text(title,maxLines: 1,overflow: TextOverflow.ellipsis),
        onTap: onTap,
        trailing: const Icon(Icons.arrow_forward_ios,
            size: 22.0, color: AppPalette.black),
      ),
    );
  }
}


class CustomButtonLocationWidget extends StatelessWidget {
  String title;
  Function() onTap;
  IconData? iconData;

  CustomButtonLocationWidget({Key? key, required this.title, required this.onTap,required this.iconData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppPalette.lightPrimary,
        borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
      ),
      child: ListTile(
        title: Text(title,maxLines: 1,overflow: TextOverflow.ellipsis),
        onTap: onTap,
        trailing:  Icon(iconData,
            size: 22.0, color: AppPalette.black),
      ),
    );
  }
}

