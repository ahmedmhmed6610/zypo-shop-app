import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../utils/Themes.dart';

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

void customFlutterToast(msg){
  Fluttertoast.showToast(
    msg: msg,
    fontSize: 15,
    backgroundColor: Themes.colorApp9,
    gravity: ToastGravity.BOTTOM,
    textColor: Themes.whiteColor,
    timeInSecForIosWeb: 1,
    toastLength: Toast.LENGTH_SHORT,
  );
}

void showCustomToast(
        {required String message,
        required BuildContext context,
        required ToastStates state,
        dynamic duration = 7}) =>
    Fluttertoast.showToast(
        msg: message,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: toastColor(state),
        textColor: Colors.white,
        toastLength: Toast.LENGTH_SHORT);
