import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop/business_logic/categories_cubit/categories_cubit.dart';
import 'package:shop/business_logic/filter_cubit/filter_cubit.dart';
import 'package:shop/translations/locale_keys.g.dart';
import 'package:shop/ui/screens/filter_screens/choose_categories_screens/sub_category_screen.dart';
import 'package:shop/ui/widgets/profile_widgets/list_tile_item_widget.dart';
import 'package:shop/utils/app_palette.dart';
import 'package:shop/utils/app_size_boxes.dart';
import 'package:shop/utils/dimensions.dart';

import '../../../../helpers/components.dart';
import '../../layout/app_layout.dart';

class MainCategoryScreen extends StatelessWidget {
  MainCategoryScreen({Key? key,this.governmentId,this.governmentName,this.cityId,this.cityName,
    this.areaId,this.areaName,this.nameProduct,this.fromYear,
    this.toYear,this.fromPrice,this.toPrice,this.locationUser}) : super(key: key);

  String? governmentId, governmentName;
  String? cityId, cityName;
  String? areaId, areaName,fromYear,toYear;
  String? locationUser,fromPrice,toPrice,nameProduct;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: AppPalette.primary,
      //   title: Text(LocaleKeys.allCategories.tr(),style: TextStyle(color: AppPalette.white),),
      //   elevation: 0.0,
      //   leading: InkWell(
      //     onTap: () => Navigator.of(context).pop(),
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
                    onTap: ()=> Navigator.of(context).pop(),
                    child: Icon(Icons.arrow_back_ios,color: AppPalette.white,size: 25.sp,),
                  ),
                  Expanded(
                    child: Center(
                      child: AutoSizeText(
                        LocaleKeys.allCategories.tr(),
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
                          child: ListView.builder(
                            itemCount: categoriesCubit.categories.length,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) => ListTileItemWidget(
                              title: context.locale.languageCode.contains('en') ?
                              categoriesCubit.categories[index].name!.en! :
                              context.locale.languageCode.contains('ar') ?
                              categoriesCubit.categories[index].name!.ar! :
                              context.locale.languageCode.contains('tr') ?
                              categoriesCubit.categories[index].name!.tr! :
                              context.locale.languageCode.contains('de') ?
                              categoriesCubit.categories[index].name!.de! : '',
                              leading: CachedNetworkImage(
                                  imageUrl: categoriesCubit.categories[index].image!,
                                  height: 24.sp,
                                  width: 24.sp,
                                  fit: BoxFit.cover),
                              trailing: const Icon(Icons.arrow_forward_ios,
                                  size: 22.0, color: AppPalette.black),
                              textStyle: filterCubit.isSelected(
                                      category: categoriesCubit.categories[index])
                                  ? const TextStyle(color: AppPalette.primary)
                                  : null,
                              onTap: () {
                                filterCubit.selectMainCategory(
                                    category: categoriesCubit.categories[index]);
                                categoriesCubit.setSelectedParent(
                                    categoriesCubit.categories[index].id!);
                                filterCubit.selectedColorsModel = [];
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => SubCategoryScreen(category: categoriesCubit.categories[index]),
                                ));
                              },
                            ),
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
