import 'package:flutter/material.dart';
import 'package:shop/utils/app_palette.dart';

class MyProductsDivider extends StatelessWidget {
  MyProductsDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width / 3,
          child: const Divider(
            color: AppPalette.black,
            thickness: 2.2,
          ),
        ),
      ),
    );
  }
}
