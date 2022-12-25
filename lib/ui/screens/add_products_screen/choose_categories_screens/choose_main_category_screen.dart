// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop/business_logic/categories_cubit/categories_cubit.dart';
import 'package:shop/business_logic/my_products_cubit/my_products_cubit.dart';
import 'package:shop/business_logic/my_products_cubit/my_products_state.dart';
import 'package:shop/translations/locale_keys.g.dart';
import 'package:shop/ui/widgets/profile_widgets/list_tile_item_widget.dart';
import 'package:shop/utils/app_palette.dart';
import 'package:shop/utils/dimensions.dart';

import '../../filter_screens/widget_custom.dart';
import '../add_product_screen.dart';

class ChooseMainCategoryScreen extends StatefulWidget {
  ChooseMainCategoryScreen({Key? key,required this.data,required this.governmentId,required this.governmentName,
    required this.cityId,required this.cityName,required this.areaId,required this.areaName,required this.locationUser,
    required this.fromPrice,required this.toPrice,required this.nameProduct,required this.description,
    required this.bodyType,required this.engineCapacityType,required this.colorType,required this.fuelType,
    required this.levelType,required this.kiloMetresType,required this.amenitiesType,this.whatsAppNumber,
    this.fromYear,this.toYear,this.bathroom,this.bedroom,this.fromArea,this.toArea,this.fromDownPayment,
    this.toDownPayment,this.fromkiloMetresType,this.tokiloMetresType,this.brandId,this.status,
    this.typeApartment,this.statusApartment,this.typeFashion,this.typeWarrannt,this.typeCondtion,
    this.typeHomeFurniture,this.typeBooks,this.typeKids,this.typeBusiness,this.warrantyElectronic,this.transmissionVehicles,
    this.area,this.downPayment,this.year,this.productId}) : super(key: key);

  final String? data;
  final String? governmentId,governmentName,productId,whatsAppNumber;
  final String? cityId,cityName,year,area,downPayment,typeCondtion,typeWarrannt,
      typeApartment,statusApartment,typeFashion,typeHomeFurniture,
      typeBooks,typeKids,typeBusiness,warrantyElectronic,transmissionVehicles;
  final String? areaId,areaName,fuelType,amenitiesType,bodyType,colorType,engineCapacityType,kiloMetresType,levelType;
  final String? locationUser,fromPrice,toPrice,nameProduct,description;
  String? brandId,fromDownPayment,toDownPayment;
  String? status,fromYear,toYear,bedroom,bathroom;
  String? fromArea,toArea,fromkiloMetresType,tokiloMetresType;

  @override
  State<ChooseMainCategoryScreen> createState() => _ChooseMainCategoryScreenState();
}

class _ChooseMainCategoryScreenState extends State<ChooseMainCategoryScreen> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('name product');
    print(widget.nameProduct);
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        backgroundColor: AppPalette.primary,
        body: CustomAppBar(
          onTap: () {
            Navigator.of(context).pop();
          },
          title: LocaleKeys.allCategories.tr(),
          widgetCustom:  BlocBuilder<CategoriesCubit, CategoriesState>(
            builder: (context, state) {
              CategoriesCubit categoriesCubit = CategoriesCubit.get(context);
              return BlocBuilder<AddProductCubit, AddProductState>(
                builder: (context, state) {
                  AddProductCubit addProductCubit = AddProductCubit.get(context);
                  return Container(
                    padding: EdgeInsets.only(
                      top: Dimensions.paddingSizeSmall,
                      right: Dimensions.paddingSmall,
                      left: Dimensions.paddingSmall,
                    ),
                    child: ListView.builder(
                      itemCount: categoriesCubit.categories.length,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) => ListTileItemWidget(
                        title: context.locale.languageCode.contains("en") ?
                        categoriesCubit.categories[index].name!.en! :
                        context.locale.languageCode.contains("ar")  ?
                        categoriesCubit.categories[index].name!.ar! :
                        context.locale.languageCode.contains("tr")  ?
                        categoriesCubit.categories[index].name!.tr! :
                        context.locale.languageCode.contains("de") ?
                        categoriesCubit.categories[index].name!.de! : " ",
                        leading: CachedNetworkImage(
                            imageUrl: categoriesCubit.categories[index].image!,
                            height: 24.sp,
                            width: 24.sp,
                            fit: BoxFit.cover),
                        trailing: const Icon(Icons.arrow_forward_ios,
                            size: 22.0, color: AppPalette.black),
                        textStyle: addProductCubit.isMainCatSelected(
                            category: categoriesCubit.categories[index])
                            ? const TextStyle(color: AppPalette.primary)
                            : null,
                        onTap: () {
                          print('name product');
                          print(widget.nameProduct);
                          categoriesCubit.setSelectedParent(
                              categoriesCubit.categories[index].id!);
                          addProductCubit.selectMainCat(
                              category: categoriesCubit.categories[index]);
                          Navigator.of(context).pop();

                          // addProductCubit.selectedColorsModel = [];
                          // Navigator.of(context).pop();
                        },
                      ),
                    ),
                  );
                },
              );
            },
          ),)
      ),
    );
  }
}
