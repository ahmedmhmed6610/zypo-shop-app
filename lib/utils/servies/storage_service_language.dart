import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../localization_app/localization_service.dart';



abstract class StorageKeysLanguage {
  StorageKeysLanguage();

  //Declare all storage keys here & create its correpsonding setters & getters
  static const String activeLocale = "ACTIVE_LOCAL";


}

class StorageServiceLanguage extends GetxService {
  late final SharedPreferences _prefs;

  Future<StorageServiceLanguage> init() async {
    _prefs = await SharedPreferences.getInstance();
    return this;
  }


  Locale get activeLocale {
    return Locale(_prefs.getString(StorageKeysLanguage.activeLocale) ??
        SupportedLocales.arabic.toString());
  }

  setActiveLocale(Locale activeLocal) {
    _prefs.setString(StorageKeysLanguage.activeLocale, activeLocal.toString());
  }
  
}

initialServicesLanguageUser () async{
  await Get.putAsync(() => StorageServiceLanguage().init());
}

