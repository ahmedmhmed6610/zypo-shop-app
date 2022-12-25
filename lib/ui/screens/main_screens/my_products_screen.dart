import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shop/business_logic/my_products_cubit/my_products_cubit.dart';
import 'package:shop/helpers/app_local_storage.dart';
import 'package:shop/translations/locale_keys.g.dart';
import 'package:shop/ui/widgets/My_products_widgets/add_new_product_widget.dart';
import 'package:shop/ui/widgets/My_products_widgets/my_product_grid_widget.dart';
import 'package:shop/ui/widgets/My_products_widgets/my_products_divider.dart';
import 'package:shop/utils/app_size_boxes.dart';
import 'package:shop/utils/styles.dart';

import '../../../business_logic/home_cubit/home_cubit.dart';
import '../../../helpers/components.dart';
import '../../../utils/app_palette.dart';
import '../../../utils/dimensions.dart';
import '../../widgets/common_widgets/appbar_search_row.dart';

class MyProductsScreen extends StatefulWidget {
  MyProductsScreen({Key? key}) : super(key: key);

  @override
  State<MyProductsScreen> createState() => _MyProductsScreenState();
}

class _MyProductsScreenState extends State<MyProductsScreen> {
  String? lottie;

  LocationPermission? permission;
  Position? _currentPosition;
  String lanAddress = "";
  String latAddress = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadDataProduct();
  }

  Future<Position?> determinePosition() async {
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        return Future.error('Location Not Available');
      }
    }
    return _getCurrentLocation();
  }

  Future<Position?> _getCurrentLocation() async {
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        //Pass the lat and long to the function
        _getAddressFromLatLng(position.latitude, position.longitude);
      });
    }).catchError((e) {
      print(e);
    });
  }

  _getAddressFromLatLng(double latitude, double longitude) async {
    try {
      List<Placemark> p = await placemarkFromCoordinates(latitude, longitude);

      Placemark place = p[0];

      setState(() {
        latAddress = "$latitude";
        lanAddress = "$longitude";
        print('latAddress');
        print(latAddress);
        print(lanAddress);
      });
    } catch (e) {
      print(e);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppPalette.primary,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  HomeCubit homeCubit = HomeCubit.get(context);
                  return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: kTextTabBarHeight),
                        25.heightBox,
                        AppBarSearchRow(
                            productModel: homeCubit.recommendationProducts.products),
                        AppLocalStorage.token != null ?
                        Column(
                          children: [
                            15.heightBox,
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.sp),
                              child: AddNewProductWidget(colorBackground: AppPalette.white, colorText: AppPalette.primary,),
                            ),
                          ],
                        ) : Container(),
                      ]);
                },
              ),
              15.heightBox,
              Container(
               // height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                    color: AppPalette.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15))
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    25.heightBox,
                    AppLocalStorage.token != null
                        ? const MyProductsGridWidget()
                        : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              heightSeperator(35.h),
                              SvgPicture.asset(
                                  "assets/images/svg/product_not_found.svg",
                                  fit: BoxFit.fill),
                              heightSeperator(35.h),
                              Text(
                                LocaleKeys.canAddNewProduct.tr(),
                                textAlign: TextAlign.center,
                                style: AppTextStyles.poppinsRegular.copyWith(
                                  color: AppPalette.lightBlack,
                                  fontFamily: Fonts.poppins,
                                  fontWeight: FontWeight.w400,
                                  fontSize: Dimensions.fontSizeDefault,
                                ),
                              ),
                              heightSeperator(25.h),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.sp),
                                child: AddNewProductWidget(colorBackground: AppPalette.primary, colorText: AppPalette.white,),
                              ),
                              5.heightBox,
                            ],
                          ),
                    10.heightBox,
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  loadDataProduct() {
    BlocProvider.of<AddProductCubit>(context, listen: false).getMyProductUser();
    // getCurrentLocation();
  }
}
