
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/servies/storage_service_language.dart';

class MyLocalController extends GetxController {

  Locale? myLocal;

  changelanguage(String codeCountry){
    Locale language = Locale(codeCountry);
    Get.find<StorageServiceLanguage>().setActiveLocale(language);
    Get.updateLocale(language);
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    String? myLanguage = Get.find<StorageServiceLanguage>().activeLocale.languageCode;
    if(myLanguage == 'ar'){
      myLocal = const Locale("ar");
    }else if(myLanguage == 'en'){
      myLocal = const Locale("en");
    }else {
      myLocal = Locale(Get.deviceLocale!.languageCode);
    }
  }
}