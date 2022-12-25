import 'package:flutter/material.dart';
import 'package:shop/utils/app_palette.dart';
import 'package:shop/utils/dimensions.dart';

class ContactUsBackground extends StatelessWidget {
  ContactUsBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            flex: 4,
            child: Container(
              decoration: BoxDecoration(
                  color: AppPalette.primary,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(Dimensions.radiusOverLarge),
                      bottomRight:
                          Radius.circular(Dimensions.radiusOverLarge))),
            )),
        Expanded(
            flex: 3,
            child: Container(
              decoration: const BoxDecoration(
                color: AppPalette.white,
              ),
            )),
      ],
    );
  }
}
