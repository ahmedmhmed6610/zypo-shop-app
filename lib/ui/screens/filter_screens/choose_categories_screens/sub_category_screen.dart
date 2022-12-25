import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shop/business_logic/categories_cubit/categories_cubit.dart';
import 'package:shop/business_logic/filter_cubit/filter_cubit.dart';
import 'package:shop/data/models/category_model.dart';
import 'package:shop/helpers/components.dart';
import 'package:shop/translations/locale_keys.g.dart';
import 'package:shop/ui/screens/filter_screens/filter_screen.dart';
import 'package:shop/ui/widgets/profile_widgets/list_tile_item_widget.dart';
import 'package:shop/utils/app_palette.dart';
import 'package:shop/utils/app_size_boxes.dart';
import 'package:shop/utils/dimensions.dart';

class SubCategoryScreen extends StatefulWidget {
  CategoryModel category;
  SubCategoryScreen(
      {Key? key, this.governmentId, this.governmentName, this.cityId, this.cityName,
        this.areaId, this.areaName, this.locationUser, this.fromPrice, this.toPrice,
        this.fromArea,this.toArea,this.bedroom,this.bathroom,this.nameProduct,
        this.fromkiloMetresType,this.tokiloMetresType,this.fromDownPayment,this.toDownPayment,
        this.fuelType, this.bodyType, this.amenitiesType, this.colorType, this.engineCapacityType, this.kiloMetresType,
        this.levelType,this.fromYear,this.toYear,required this.category}) : super(key: key);

  String? governmentId, governmentName;
  String? cityId, cityName;
  String? areaId, areaName;
  String? locationUser,nameProduct;
  String? brandId,fromDownPayment,toDownPayment;
  String? status,fromYear,toYear,bedroom,bathroom;
  String? fromPrice, toPrice,fromArea,toArea;
  String? kiloMetresType,fuelType, amenitiesType, bodyType, colorType, engineCapacityType,
      fromkiloMetresType,tokiloMetresType, levelType;

  @override
  State<SubCategoryScreen> createState() => _SubCategoryScreenState();
}

class _SubCategoryScreenState extends State<SubCategoryScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: AppPalette.primary,
      //   title: Text(context.locale.languageCode.contains('en') ?
      //   widget.category.name!.en! :
      //   context.locale.languageCode.contains('ar') ?
      //   widget.category.name!.ar! :
      //   context.locale.languageCode.contains('tr') ?
      //   widget.category.name!.tr! :
      //   context.locale.languageCode.contains('de') ?
      //   widget.category.name!.de! : '',
      //       style: TextStyle(color: AppPalette.white)),
      //   elevation: 0.0,
      //   leading: InkWell(
      //     onTap: () =>  Navigator.push(context, MaterialPageRoute
      //       (builder: (context) => FilterScreen())),
      //     child: const Icon(Icons.arrow_back_ios,
      //         size: 20.0, color: AppPalette.white),
      //   ),
      // ),
      backgroundColor: AppPalette.primary,
      body: SafeArea(
        child: Column(
          children: [
            22.heightBox,
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 15.h),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: ()=> navigateTo(context: context, widget: FilterScreen()),
                    child: Icon(Icons.arrow_back_ios,color: AppPalette.white,size: 25.sp,),
                  ),
                  Expanded(
                    child: Center(
                      child: AutoSizeText(
                          context.locale.languageCode.contains('en') ?
                          widget.category.name!.en! :
                          context.locale.languageCode.contains('ar') ?
                          widget.category.name!.ar! :
                          context.locale.languageCode.contains('tr') ?
                          widget.category.name!.tr! :
                          context.locale.languageCode.contains('de') ?
                          widget.category.name!.de! : '',
                        style: Theme.of(context).textTheme.headline2!.copyWith(
                            color: AppPalette.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 15.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            22.heightBox,
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                    color: AppPalette.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25))),
                child: BlocBuilder<CategoriesCubit, CategoriesState>(
                  builder: (context, state) {
                    CategoriesCubit categoriesCubit = CategoriesCubit.get(context);
                    return BlocBuilder<FilterCubit, FilterState>(
                      builder: (context, state) {
                        FilterCubit filterCubit = FilterCubit.get(context);
                        return Container(
                          padding: EdgeInsets.only(
                            top: Dimensions.paddingSizeDefault,
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
                                textStyle: filterCubit.selectedSubCategory == null
                                    ? const TextStyle(color: AppPalette.primary)
                                    : null,
                                onTap: () {
                                  filterCubit.selectSubCategory(category: null);
                                  Navigator.push(context, MaterialPageRoute
                                    (builder: (context) => FilterScreen()));

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
                                    : categoriesCubit
                                    .categoriesByParent[
                                categoriesCubit.selectedParent]!
                                    .categories.isNotEmpty ?
                                ListView.builder(
                                        itemCount: categoriesCubit
                                            .categoriesByParent[
                                                categoriesCubit.selectedParent]!
                                            .categories
                                            .length,
                                        physics: const BouncingScrollPhysics(),
                                        itemBuilder: (context, index) =>
                                            ListTileItemWidget(
                                          title:
                                          context.locale.languageCode.contains('en') ?
                                          categoriesCubit.categoriesByParent[categoriesCubit.selectedParent]!.categories[index].name!.en! :
                                          context.locale.languageCode.contains('ar') ?
                                          categoriesCubit.categoriesByParent[categoriesCubit.selectedParent]!.categories[index].name!.ar! :
                                          context.locale.languageCode.contains('tr') ?
                                          categoriesCubit.categoriesByParent[categoriesCubit.selectedParent]!.categories[index].name!.tr! :
                                          context.locale.languageCode.contains('de') ?
                                          categoriesCubit.categoriesByParent[categoriesCubit.selectedParent]!.categories[index].name!.de! : '',
                                          trailing: const Icon(Icons.arrow_forward_ios,
                                              size: 22.0, color: AppPalette.black),
                                          textStyle: filterCubit.isSubCategorySelected(
                                                  category: categoriesCubit
                                                      .categoriesByParent[
                                                          categoriesCubit.selectedParent]!
                                                      .categories[index])
                                              ? const TextStyle(color: AppPalette.primary)
                                              : null,
                                          onTap: () {
                                            filterCubit.selectSubCategory(
                                                category: categoriesCubit
                                                    .categoriesByParent[
                                                        categoriesCubit.selectedParent]!
                                                    .categories[index]);
                                            // filterCubit.selectedBrandsModel = [];
                                            filterCubit.selectedColorsModel = [];
                                            CategoriesCubit.get(context)
                                                .getBrandsByCategory(
                                                    categoryID: categoriesCubit
                                                        .categoriesByParent[
                                                            categoriesCubit
                                                                .selectedParent]!
                                                        .categories[index]
                                                        .id!);
                                            Navigator.pushReplacement(context, MaterialPageRoute
                                              (builder: (context) => FilterScreen()));
                                          },
                                        ),
                                      ) : Center(
                                  child: SvgPicture.asset("assets/images/svg/addProduct.svg",
                                      fit: BoxFit.contain),
                                )
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
