import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

callNumber({required String phoneNumber}) async {
  // const number = phone; //set the number here
  await FlutterPhoneDirectCaller.callNumber(phoneNumber);
}
