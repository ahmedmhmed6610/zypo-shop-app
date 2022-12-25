// ignore_for_file: deprecated_member_use

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:shop/translations/locale_keys.g.dart';
import 'package:shop/utils/Themes.dart';

import '../business_logic/my_products_cubit/my_products_cubit.dart';
import '../libraries/dialog_widget.dart';
import 'app_palette.dart';
import 'dimensions.dart';

Widget defaultButton(
        {Color? background,
        textColor,
        fontFamily = 'Poppins-Regular',
        fontSize = 16.0,
        paddingVertical = 14.0,
        paddingHorizontal = 17.0,
        String text = '',
        elevation = 10.0,
        Function? function,
        required double borderRadius}) =>
    OutlinedButton(
        onPressed: () {
          function!();
        },
        style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(
              horizontal: paddingHorizontal, vertical: paddingVertical)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius),
                  side: const BorderSide(color: Colors.red))),
          side: MaterialStateProperty.all(
              BorderSide(width: 1.0.w, color: Colors.transparent)),
          elevation: MaterialStateProperty.all(elevation),
          backgroundColor: MaterialStateProperty.all(background),
        ),
        child: Text(
          text,
          style: TextStyle(
              color: textColor, fontSize: fontSize, fontFamily: fontFamily),
        ));

// submit({required BuildContext context, Widget? widget}) {
//   CacheHelper.saveData(key: 'onBoardingSeen', value: true).then((value) {
//     navigateAndFinish(context: context, widget:  const LoginScreen());
//   });
// }

void showToast(
        {required String message,
        required BuildContext context,
        required ToastStates state,
        duration = 7}) =>
    Fluttertoast.showToast(
        msg: message,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: toastColor(state),
        textColor: Colors.white,
        fontSize: 16.0.sp,
        toastLength: Toast.LENGTH_SHORT);

void showToast2(
    {required String message,
      required BuildContext context,
      required ToastStates state,
      duration = 7}) =>
    Fluttertoast.showToast(
        msg: message,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: toastColor(state),
        textColor: Colors.white,
        fontSize: 16.0.sp,
        toastLength: Toast.LENGTH_SHORT);

Widget appBarFlexSpace() => Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            HexColor('#66D26D'),
            HexColor('#66D26D'),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    );

List<Widget> appBarActions(context) => [
      // InkWell(
      //     onTap: () {},
      //     child: Icon(
      //       Icons.notifications,
      //       size: 24.sp,
      //     )),
      SizedBox(
        width: 10.w,
      )
    ];

// Widget defaultTextFormField(
//         {TextEditingController? controller,
//         required TextInputType type,
//         required String label,
//         IconData? icon,
//         bool isPassword = false,
//         bool securePassword = true,
//         String? Function(String? val)? validator,
//         IconData? suffix,
//         VoidCallback? onTap,
//         Function(String)? onChanged,
//         Function? unsecurePassword}) =>
//     TextFormField(
//       textInputAction: TextInputAction.next,
//       cursorWidth: 3.w,
//       textAlignVertical: TextAlignVertical.center,
//       autovalidateMode: AutovalidateMode.onUserInteraction,
//       enableInteractiveSelection: true,
//       cursorColor: Colors.grey,
//       onTap: onTap,
//       onChanged: onChanged,
//       validator: validator,
//       controller: controller,
//       keyboardType: type,
//       obscureText: isPassword ? securePassword : false,
//       style: TextStyle(
//           color: HexColor('#040100'),
//           fontSize: 16.0.sp,
//           fontFamily: 'Montserrat-Medium'),
//       decoration: InputDecoration(
//         fillColor: Colors.white10.withOpacity(.9),
//         filled: true,
//         contentPadding: EdgeInsets.only(
//             left: 14.0.w, bottom: 18.0.h, top: 15.0.h, right: 10.w),
//         labelStyle: TextStyle(
//           color: HexColor('#242424').withOpacity(.6),
//           fontSize: 16.0.sp,
//           fontFamily: 'Poppins-Regular',
//         ),
//         labelText: label,
//         prefixIcon: Icon(
//           icon,
//           color: defaultColor,
//         ),
//         enabledBorder: OutlineInputBorder(
//             borderSide: BorderSide(color: HexColor('#040100'))),
//         errorBorder: OutlineInputBorder(
//             borderSide: BorderSide(color: HexColor('#040100'))),
//         focusedBorder: OutlineInputBorder(
//             borderSide: BorderSide(color: HexColor('#040100'))),
//         suffix: InkWell(
//           onTap: () {
//             unsecurePassword!();
//           },
//           child: Icon(
//             suffix,
//             color: HexColor('#040100'),
//           ),
//         ),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(7.r),
//         ),
//       ),
//     );
//
// Widget progressIndicator() => Center(
//       child: CircularProgressIndicator(
//         color: defaultColor,
//       ),
//     );

// Widget? navigateTo({required BuildContext context, required Widget widget}) {
//   Navigator.of(context).push(MaterialPageRoute(builder: (context) => widget));
// }
//
// Widget? navigateReplaceTo({required BuildContext context, required Widget widget}) {
//   Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => widget));
// }
//
// Widget? navigateAndFinish(
//     {required BuildContext context, required Widget widget}) {
//   Navigator.pushAndRemoveUntil(context,
//       MaterialPageRoute(builder: (context) => widget), (route) => false);
// }

enum ToastStates { success, error, warning }

Color toastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.success:
      color = Colors.green;
      break;
    case ToastStates.error:
      color = Colors.red;
      break;
    case ToastStates.warning:
      color = Colors.amber;
      break;
  }
  return color;
}

enum Order_status {
  pending,
  inProgress,
  completed,
  canceled,
  // delivering,
  // delivered,
  // pickuped
}
Order_status? getOrderStatus(String status) {
  Order_status? orderStatus;
  switch (status) {
    case 'pending':
      orderStatus = Order_status.pending;
      break;
    case 'inProgress':
      orderStatus = Order_status.inProgress;
      break;
    case 'completed':
      orderStatus = Order_status.completed;
      break;
    // case 'delivering':
    //   orderStatus = order_status.delivering;
    //   break;
    case 'canceled':
      orderStatus = Order_status.canceled;
      break;
    // case 'delivered':
    //   orderStatus = order_status.delivered;
    //   break;
    // case 'pickuped':
    //   orderStatus = order_status.pickuped;
    //   break;
  }
  return orderStatus;
}

String? getOrderStatusInGermany(String orderStatus) {
  String? status;
  switch (orderStatus) {
    case 'canceled':
      status = 'Storniert';
      break;
    case 'inProgress':
      status = 'in Bearbeitung';
      break;
    case 'pending':
      status = 'Offen';
      break;
    // case 'pickuped':
    //   status = 'Abholung';
    //   break;
    case 'completed':
      status = 'Lieferbereit';
      break;
    // case 'delivering':
    //   status = 'Lieferung';
    //   break;
    // case 'delivered':
    //   status = 'Ausgeliefert';
    //   break;
    default:
      status = 'in Bearbeitung';
      break;
  }
  return status;
}

Widget heightSeperator(double height) => SizedBox(
      height: height,
    );

Widget widthSeparator(double width) => SizedBox(
      width: width,
    );
String germanyNumberFormat(double num) =>
    NumberFormat.currency(locale: 'de', symbol: '€').format(num);

String germanyDateFormat(var date) => date is String
    ? DateFormat.yMd('de').format(DateTime.parse(date))
    : DateFormat.yMd('de').format(date);
String germanyTimeFormat(String time) =>
    DateFormat.Hm('de').format(DateTime.parse('2021-12-13 ' + time));
AwesomeDialog showNotificationDialog(
    {context, String? message, newOrder = false}) {
  return AwesomeDialog(
      padding: EdgeInsets.zero,
      customHeader: Icon(
        Icons.info,
        color: Themes.colorApp1,
        size: 80.sp,
      ),
      context: context,
      borderSide: const BorderSide(color: Themes.colorApp1),
      animType: AnimType.SCALE,
      autoHide: const Duration(seconds: 5),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          heightSeperator(6),
          Text(
            newOrder ? 'Neue Bestellung' : 'Aktion erfolgreich',
            style: TextStyle(
                fontSize: 16.sp,
                fontFamily: 'Poppins-Regular',
                fontWeight: FontWeight.bold,
                color: Colors.black,
                height: 1.6),
            textAlign: TextAlign.center,
          ),
          Text(
            '$message',
            style: TextStyle(
                fontSize: 16.sp,
                fontFamily: 'Poppins-Regular',
                fontWeight: FontWeight.w300,
                color: Colors.black,
                height: 1.6),
            textAlign: TextAlign.center,
          ),
          heightSeperator(35),
        ]),
      ))
    ..show();
}


Future showNotification(BuildContext context,String? lottie,String productId){
  return  showDialog(
      context: context,
      builder: (context) =>
          Dialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Dimensions.radiusDefault)),
            alignment: Alignment.bottomCenter,
            insetPadding: EdgeInsets.symmetric(
                vertical: Dimensions.paddingSize, horizontal: Dimensions.paddingSize),
            child: CustomDialogWidget(
              msgStyle: const TextStyle(color: AppPalette.black),
              title: LocaleKeys.productShowTimeHasExpired.tr(),
              msg: LocaleKeys.wantToRenewOrDelete.tr(),
              titleStyle: const TextStyle(color: AppPalette.grey),
              actions: [
                Padding(
                  padding:
                  EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
                  child: IconsButton(
                    onPressed: () async {
                      BlocProvider.of<AddProductCubit>(context).deleteProductItem(context, productId: productId, isSold: '0');
                      //   addProductCubit.deleteProductItem(context,productId: product.id.toString(),isSold: '0');

                    },
                    text: LocaleKeys.delete.tr(),
                    // color: Colors.transparent,
                    shape: OutlineInputBorder(
                        borderSide: const BorderSide(color: AppPalette.black),
                        borderRadius:
                        BorderRadius.circular(Dimensions.radiusDefault)),
                    textStyle: const TextStyle(color: Colors.black),
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.paddingSizeExtraSmall,
                        vertical: Dimensions.paddingSizeDefault),
                  ),
                ),
                Padding(
                  padding:
                  EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
                  child: IconsButton(
                    onPressed: () {
                      BlocProvider.of<AddProductCubit>(context).renewProductStatus(context,productId);
                    },
                    text: LocaleKeys.renew.tr(),
                    // iconData: Icons.done,
                    color: AppPalette.primary,
                    textStyle: const TextStyle(color: Colors.white),
                    shape: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius:
                        BorderRadius.circular(Dimensions.radiusDefault)),
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.paddingSizeExtraSmall,
                        vertical: Dimensions.paddingSizeDefault),
                    // iconColor: Colors.white,
                  ),
                ),
              ],
              animationBuilder: lottie != null
                  ? LottieBuilder.asset(
                lottie.toString(),
              )
                  : null,
              customView: Dialogs.holder,
              color: Colors.white,
            ),
          )
  );
}