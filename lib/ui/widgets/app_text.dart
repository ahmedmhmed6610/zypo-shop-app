import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  const AppText({
    required this.text,
    this.textOverflow,
    this.textAlign,
    this.textStyle,
    this.padding = EdgeInsets.zero,
    this.maxLines,
    this.textSoftwrap,
    Key? key,
  }) : super(key: key);
  final String text;
  final TextOverflow? textOverflow;
  final TextAlign? textAlign;
  final TextStyle? textStyle;
  final EdgeInsets? padding;
  final int? maxLines;
  final bool? textSoftwrap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding!,
      child: Text(
        text,
        style: textStyle,
        overflow: textOverflow,
        textAlign: textAlign,
        maxLines: maxLines,
        softWrap: textSoftwrap,
      ),
    );
  }
}
