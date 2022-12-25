// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:shop/utils/app_palette.dart';
//
// class AppTextField extends StatelessWidget {
//   const AppTextField({
//     Key? key,
//     required this.name,
//     this.hint,
//     this.label,
//     this.textType,
//     this.onTextChange,
//     this.maxLength,
//     this.onTap,
//     this.suffixWidget,
//     this.controller,
//     this.obsecureTxt = false,
//     this.inputAction,
//     this.initialValue,
//     this.maxLines = 1,
//     this.validator,
//     this.readOnly = false,
//   }) : super(key: key);
//   final String? label;
//   final String? hint;
//   final TextInputType? textType;
//   final ValueChanged<String?>? onTextChange;
//   final String name;
//   final Widget? suffixWidget;
//   final TextEditingController? controller;
//   final bool obsecureTxt;
//   final Function()? onTap;
//   final FormFieldValidator<String?>? validator;
//   final TextInputAction? inputAction;
//   final String? initialValue;
//   final int? maxLines;
//   final int? maxLength;
//   final bool? readOnly;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 0.09.sh,
//       margin: EdgeInsets.only(
//         bottom: 4.h,
//       ),
//       child: FormBuilderTextField(
//         onTap: onTap,
//         controller: controller,
//         initialValue: initialValue,
//         autovalidateMode: AutovalidateMode.onUserInteraction,
//         maxLines: maxLines,
//         readOnly: readOnly!,
//         maxLength: maxLength,
//         enableSuggestions: true,
//         textInputAction: inputAction,
//         style: TextStyle(
//             color: AppPalette.black, fontWeight: FontWeight.w400, fontSize: 14.sp),
//         decoration: InputDecoration(
//           suffixIcon: suffixWidget,
//           suffixIconConstraints: BoxConstraints.tight(
//             Size(50.w, 0.06.sh),
//           ),
//           labelText: label,
//           labelStyle: TextStyle(
//               color: AppPalette.black, fontWeight: FontWeight.w400, fontSize: 12.sp),
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12.r),
//           ),
//           errorMaxLines: 1,
//           errorBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12.r),
//             borderSide: const BorderSide(
//               color: Colors.red,
//             ),
//           ),
//           errorStyle: TextStyle(
//               color: AppPalette.black, fontWeight: FontWeight.w400, fontSize: 10.sp),
//           contentPadding: EdgeInsets.all(12.r),
//           disabledBorder: InputBorder.none,
//           focusedBorder: OutlineInputBorder(
//             borderSide:  const BorderSide(
//               color: AppPalette.primary,
//             ),
//             borderRadius: BorderRadius.circular(12.r),
//           ),
//           alignLabelWithHint: true,
//           hintText: hint,
//           isDense: true,
//         ),
//         cursorColor: AppPalette.primary,
//         textAlignVertical: TextAlignVertical.bottom,
//         keyboardType: textType,
//         onChanged: onTextChange,
//         name: name,
//         obscureText: obsecureTxt,
//         validator: validator,
//       ),
//     );
//   }
// }
