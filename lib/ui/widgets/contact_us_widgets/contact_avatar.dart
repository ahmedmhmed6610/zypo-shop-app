import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop/utils/app_palette.dart';

class ContactAvatar extends StatelessWidget {
  const ContactAvatar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      height: MediaQuery.of(context).size.height * 0.22,
      decoration:
          const BoxDecoration(shape: BoxShape.circle, color: AppPalette.white),
      child: SvgPicture.asset("assets/images/svg/contact.svg",
          fit: BoxFit.scaleDown),
    );
  }
}
