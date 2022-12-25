// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:shop/helpers/cache_helper.dart';

import '../ui/screens/auth/login_screen.dart';

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

submit({required BuildContext context, Widget? widget}) {
  CacheHelper.saveData(key: 'onBoardingSeen', value: true).then((value) {
    navigateAndFinish(context: context, widget: const LoginScreen());
  });
}

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

// Widget appBarFlexSpace() => Container(
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [
//             HexColor('#66D26D'),
//             HexColor('#66D26D'),
//           ],
//           begin: Alignment.topCenter,
//           end: Alignment.bottomCenter,
//         ),
//       ),
//     );

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


Widget progressIndicator() => const Center(
      child: CircularProgressIndicator(
        color: Colors.red,
      ),
    );

Widget? navigateTo({required BuildContext context, required Widget widget}) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => widget));
  return null;
}

Widget? navigateReplaceTo({required BuildContext context, required Widget widget}) {
  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => widget));
  return null;
}

Widget? navigateAndFinish(
    {required BuildContext context, required Widget widget}) {
  Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute(builder: (context) => widget), (route) => false);
  return null;
}

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

enum order_status {
  pending,
  inProgress,
  completed,
  canceled,
  // delivering,
  // delivered,
  // pickuped
}
order_status? getOrderStatus(String status) {
  order_status? orderStatus;
  switch (status) {
    case 'pending':
      orderStatus = order_status.pending;
      break;
    case 'inProgress':
      orderStatus = order_status.inProgress;
      break;
    case 'completed':
      orderStatus = order_status.completed;
      break;
    // case 'delivering':
    //   orderStatus = order_status.delivering;
    //   break;
    case 'canceled':
      orderStatus = order_status.canceled;
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

// AwesomeDialog showNotificationDialog(
//     {context, String? message, newOrder = false}) {
//   return AwesomeDialog(
//       padding: EdgeInsets.zero,
//       customHeader: Icon(
//         Icons.info,
//         color: defaultColor,
//         size: 80.sp,
//       ),
//       context: context,
//       borderSide: BorderSide(color: defaultColor),
//       animType: AnimType.SCALE,
//       autoHide: const Duration(seconds: 5),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20.0),
//         child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
//           heightSeperator(6),
//           Text(
//             newOrder ? 'Neue Bestellung' : 'Aktion erfolgreich',
//             style: TextStyle(
//                 fontSize: 16.sp,
//                 fontFamily: 'Poppins-Regular',
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black,
//                 height: 1.6),
//             textAlign: TextAlign.center,
//           ),
//           Text(
//             '$message',
//             style: TextStyle(
//                 fontSize: 16.sp,
//                 fontFamily: 'Poppins-Regular',
//                 fontWeight: FontWeight.w300,
//                 color: Colors.black,
//                 height: 1.6),
//             textAlign: TextAlign.center,
//           ),
//           heightSeperator(35),
//         ]),
//       ))
//     ..show();
// }
