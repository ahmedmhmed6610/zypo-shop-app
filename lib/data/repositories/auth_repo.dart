// ignore_for_file: unrelated_type_equality_checks

import 'dart:async';

import '../../helpers/app_local_storage.dart';
import '../../utils/app_constants.dart';

class AuthRepo {
  final String _sharedPreferenceUserToken = AppConstants.userToken;
  final String _sharedPreferenceUserData = AppConstants.userData;


  Future<dynamic> deleteUser() async {
    AppLocalStorage.token = null;
    AppLocalStorage.user = null;
    await AppLocalStorage.removeValue(_sharedPreferenceUserToken);
    await AppLocalStorage.removeValue(_sharedPreferenceUserData);
  }

  // for  user token
  Future<dynamic> setUserToken(String userToken) async {
    AppLocalStorage.token = userToken;
    await AppLocalStorage.saveValue(_sharedPreferenceUserToken, userToken);
  }

  Future<dynamic> getUserToken() async {
    return AppLocalStorage.getValue(_sharedPreferenceUserToken);
  }

  get getToken {
    return AppLocalStorage.getValue(_sharedPreferenceUserToken) == '' ? "" : AppLocalStorage.getValue(_sharedPreferenceUserToken);
  }

}
