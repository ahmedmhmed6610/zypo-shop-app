import 'package:flutter/material.dart';
import 'package:shop/utils/app_palette.dart';

class InputTextFormField extends StatelessWidget {
  String hintText;
  Widget? prefixIcon;
  Widget? suffixIcon;
  TextEditingController textEditingController;
  Function(String) validator;
  int maxLines;
  int? maxLength;
  FocusNode? focusNode;
  Color? fillColor ;
  bool? readOnly;
  FocusNode? nextFocusNode;
  TextInputType? textInputType;
  TextInputAction? inputAction;
  bool secure;
  void Function(String)? onChanged;

  InputTextFormField({
    Key? key,
    this.prefixIcon,
    required this.hintText,
    required this.textEditingController,
    required this.validator,
    this.suffixIcon,
    this.fillColor,
    this.onChanged,
    this.readOnly,
    this.maxLines = 1,
    this.maxLength ,
    this.focusNode,
    this.nextFocusNode,
    this.textInputType,
    this.inputAction,
    this.secure = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: TextFormField(
        controller: textEditingController,
        textAlignVertical: TextAlignVertical.center,
        validator: (val) => validator(val!),
        maxLines: maxLines,
        focusNode: focusNode,
        maxLength: maxLength,
        onChanged: onChanged,
        onFieldSubmitted: (_) =>
            FocusScope.of(context).requestFocus(nextFocusNode),
        keyboardType: textInputType,
        textInputAction: inputAction,
        obscureText: secure,
        readOnly: readOnly ?? false,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: AppPalette.lightBlack),
          filled: true,
          fillColor: fillColor ?? AppPalette.lightPrimary,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          // contentPadding: EdgeInsets.zero,
          border: UnderlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10.0),
          ),
          disabledBorder: UnderlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10.0),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10.0),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }
}
