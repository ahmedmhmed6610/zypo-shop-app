import 'dart:async';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shop/utils/app_palette.dart';

import '../../translations/locale_keys.g.dart';
import '../../ui/screens/main_screens/home_screen.dart';
import '../../ui/screens/main_screens/my_products_screen.dart';
import '../../ui/screens/main_screens/profile_screen.dart';
import '../../ui/screens/main_screens/wishList_screen.dart';


part 'app_layout_state.dart';

class AppLayoutCubit extends Cubit<AppLayoutState> {
  Timer? timer;
  AppLayoutCubit() : super(AppLayoutInitial()){
   checkUserConnection();
   checkConnectionInternet();
  }

  static AppLayoutCubit get(BuildContext context) => BlocProvider.of(context);
  int selectedIndex = 0;
  onItemTapped(int index) {
    selectedIndex = index;
    emit(OnItemTappedState());
  }

  bool activeConnection = false;
  String T = "";

   List<Widget> layoutScreens = <Widget>[
    const HomeScreen(),
    const WishListScreen(),
    MyProductsScreen(),
    const ProfileScreen(),
  ];


  List<BottomNavigationBarItem> bottomNavigationBarItem = [
    BottomNavigationBarItem(
        icon: SvgPicture.asset('assets/images/svg/home.svg',
            width: 25, height: 25, color: Colors.black),
        label: LocaleKeys.home.tr(),
        activeIcon: SvgPicture.asset('assets/images/svg/home.svg',
            width: 25, height: 25, color: AppPalette.primary)),
    BottomNavigationBarItem(
        icon: SvgPicture.asset('assets/images/svg/star.svg',
            width: 25, height: 25, color: Colors.black),
        label: LocaleKeys.favorite.tr(),
        activeIcon: SvgPicture.asset('assets/images/svg/star.svg',
            width: 25, height: 25, color: AppPalette.primary)),
    BottomNavigationBarItem(
        icon: SvgPicture.asset('assets/images/svg/list-ul.svg',
            width: 25, height: 25, color: Colors.black),
        label: LocaleKeys.myProducts.tr(),
        activeIcon: SvgPicture.asset('assets/images/svg/list-ul.svg',
            width: 25, height: 25, color: AppPalette.primary)),
    BottomNavigationBarItem(
        icon: SvgPicture.asset('assets/images/svg/profile.svg',
            width: 25, height: 25, color: Colors.black),
        label: LocaleKeys.account.tr(),
        activeIcon: SvgPicture.asset('assets/images/svg/profile.svg',
            width: 25, height: 25, color: AppPalette.primary)),
  ];

  checkConnectionInternet(){

    timer = Timer.periodic(const Duration(seconds: 10), (Timer t) => checkUserConnection());
  }

  Future checkUserConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        activeConnection = true;
        T = "Turn off the data and repress again";
      //  CustomFlutterToast(T);
        // CustomFlutterToast(ActiveConnection.toString());
        print(T);
         emit(ConnectionSuccess());
      }
    } on SocketException catch (_) {
      activeConnection = true;
      T = "Turn off the data and repress again";
     // CustomFlutterToast(T);
      // CustomFlutterToast(ActiveConnection.toString());
      print(T);
       emit(ConnectionFailure());
    }
  }

}
