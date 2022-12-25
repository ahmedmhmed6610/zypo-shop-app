// ignore_for_file: must_be_immutable

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/business_logic/categories_cubit/categories_cubit.dart';
import 'package:shop/business_logic/my_products_cubit/my_products_cubit.dart';
import 'package:shop/business_logic/my_products_cubit/my_products_state.dart';

import 'package:shop/data/models/category_model.dart';
import 'package:shop/ui/screens/add_products_screen/add_product_screen.dart';
import 'package:shop/ui/widgets/profile_widgets/list_tile_item_widget.dart';
import 'package:shop/utils/app_palette.dart';
import 'package:shop/utils/dimensions.dart';

import '../../../../translations/locale_keys.g.dart';
import '../../filter_screens/widget_custom.dart';


class ChooseSubCategoryScreen extends StatefulWidget {
  CategoryModel category;


  ChooseSubCategoryScreen({Key? key,  required this.category,required this.data,required this.governmentId,required this.governmentName,
    required this.cityId,required this.cityName,required this.areaId,required this.areaName,required this.locationUser,
    required this.fromPrice,required this.toPrice,required this.nameProduct,required this.description,
    required this.bodyType,required this.engineCapacityType,required this.colorType,required this.fuelType,
    required this.levelType,required this.kiloMetresType,required this.amenitiesType,required this.whatsAppNumber,
    this.productId, this.year, this.area, this.downPayment,
    this.fromYear,this.toYear,this.bathroom,this.bedroom,this.fromArea,this.toArea,this.fromDownPayment,
    this.toDownPayment,this.fromkiloMetresType,this.tokiloMetresType,this.brandId,this.status,}) : super(key: key);

  final String? data;
  final String? governmentId,governmentName,productId,whatsAppNumber;
  final String? cityId,cityName,year,area,downPayment;
  final String? areaId,areaName,fuelType,amenitiesType,bodyType,colorType,engineCapacityType,kiloMetresType,levelType;
  final String? locationUser,fromPrice,toPrice,nameProduct,description;
  String? brandId,fromDownPayment,toDownPayment,oldPrice, newPrice;
  String? status,fromYear,toYear,bedroom,bathroom;
  String? fromArea,toArea,fromkiloMetresType,tokiloMetresType;

  @override
  _ChooseSubCategoryScreenState createState() => _ChooseSubCategoryScreenState();
}

class _ChooseSubCategoryScreenState extends State<ChooseSubCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPalette.primary,
      body: CustomAppBar(
        onTap: () {
          Navigator.of(context).pop();
        },
        title:  context.locale.languageCode.contains('en') ?
        widget.category.name!.en! :
        context.locale.languageCode.contains('ar') ?
        widget.category.name!.ar! :
        context.locale.languageCode.contains('tr') ?
        widget.category.name!.tr! :
        context.locale.languageCode.contains('de') ?
        widget.category.name!.de! : '',
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
                  child: Column(
                    children: [
                      ListTileItemWidget(
                        title: "${LocaleKeys.seeAll.tr()} "
                            "${context.locale.languageCode.contains('en') ?
                        widget.category.name?.en :
                        context.locale.languageCode.contains('ar') ?
                        widget.category.name?.ar :
                        context.locale.languageCode.contains('tr') ?
                        widget.category.name?.tr :
                        context.locale.languageCode.contains('de') ?
                        widget.category.name?.de : ''}",
                        trailing: const Icon(Icons.arrow_forward_ios,
                            size: 22.0, color: AppPalette.black),
                        // border: filterCubit.selectedSubCategory == null
                        //     ? Border.all(color: AppPalette.primary)
                        //     : null,
                        textStyle: addProductCubit.selectedSubCat == null
                            ? const TextStyle(color: AppPalette.primary)
                            : null,
                        onTap: () {
                          addProductCubit.selectSubCat(category: null);
                          Navigator.of(context).pop();
                          // Navigator.of(context).pushReplacement(MaterialPageRoute(
                          //   builder: (context) => FilterScreen(),
                          // ));
                        },
                      ),
                      Expanded(
                        child: categoriesCubit
                            .categoriesByParent[
                        categoriesCubit.selectedParent]!
                            .loadingCategory
                            ? const Center(
                          child: CircularProgressIndicator(),
                        )
                            : ListView.builder(
                          itemCount: categoriesCubit
                              .categoriesByParent[
                          categoriesCubit.selectedParent]!
                              .categories
                              .length,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) =>
                              ListTileItemWidget(
                                title: context.locale.languageCode
                                    .contains("en")
                                    ? categoriesCubit
                                    .categoriesByParent[
                                categoriesCubit.selectedParent]!
                                    .categories[index]
                                    .name!
                                    .en!
                                    : context.locale.languageCode.contains('ar')
                                    ? categoriesCubit
                                    .categoriesByParent[
                                categoriesCubit.selectedParent]!
                                    .categories[index]
                                    .name!
                                    .ar!
                                    : context.locale.languageCode
                                    .contains('tr')
                                    ? categoriesCubit
                                    .categoriesByParent[
                                categoriesCubit
                                    .selectedParent]!
                                    .categories[index]
                                    .name!
                                    .tr!
                                    : context.locale.languageCode
                                    .contains('de')
                                    ? categoriesCubit
                                    .categoriesByParent[
                                categoriesCubit
                                    .selectedParent]!
                                    .categories[index]
                                    .name!
                                    .de!
                                    : '',
                                trailing: const Icon(Icons.arrow_forward_ios,
                                    size: 22.0, color: AppPalette.black),
                                // border: filterCubit.isSubCategorySelected(
                                //         category: filterCubit.categories[index])
                                //     ? Border.all(color: AppPalette.primary)
                                //     : null,
                                textStyle: addProductCubit.isSubCatSelected(
                                    category: categoriesCubit
                                        .categoriesByParent[
                                    categoriesCubit.selectedParent]!
                                        .categories[index])
                                    ? const TextStyle(color: AppPalette.primary)
                                    : null,
                                onTap: () {
                                  addProductCubit.selectSubCat(
                                      category: categoriesCubit
                                          .categoriesByParent[
                                      categoriesCubit.selectedParent]!
                                          .categories[index]);
                                  CategoriesCubit.get(context)
                                      .getBrandsByCategory(
                                      categoryID: categoriesCubit
                                          .categoriesByParent[
                                      categoriesCubit
                                          .selectedParent]!
                                          .categories[index]
                                          .id!);
                                  addProductCubit.selectedBrand = null;
                                  Navigator.of(context).pop();
                                },
                              ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),),
    );
  }
}

