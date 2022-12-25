import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shop/business_logic/app_ui_cubit/app_ui_cubit.dart';
import 'package:shop/business_logic/auth_cubit/auth_cubit.dart';
import 'package:shop/business_logic/categories_cubit/categories_cubit.dart';
import 'package:shop/data/models/category_model.dart';
import 'package:shop/data/models/dummy_data/dummy_products.dart';
import 'package:shop/translations/locale_keys.g.dart';
import 'package:shop/ui/widgets/category_widgets/search_widget.dart';
import 'package:shop/ui/widgets/products_grid_widget.dart';
import 'package:shop/ui/widgets/products_list_wiget.dart';
import 'package:shop/utils/app_palette.dart';
import 'package:shop/utils/app_size_boxes.dart';
import 'package:shop/utils/dimensions.dart';

import '../../../business_logic/filter_cubit/filter_cubit.dart';
import '../../../business_logic/home_cubit/home_cubit.dart';
import '../../../utils/styles.dart';
import '../../widgets/common_widgets/appbar_search_row.dart';
import '../../widgets/search_product_item_widget/search_product_item_widget.dart';
import '../filter_screens/choose_categories_screens/sub_category_screen.dart';

class CategoryScreen extends StatefulWidget {
  CategoryModel category;

  CategoryScreen({Key? key, required this.category}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class Debouncer {
  final int milliseconds;
  VoidCallback? action;
  Timer? _timer;

  Debouncer({required this.milliseconds});

  run(VoidCallback action) {
    if (null != _timer) {
      _timer!.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}


class _CategoryScreenState extends State<CategoryScreen> {
  final debouncer = Debouncer(milliseconds: 1000);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPalette.primary,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              25.heightBox,
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 15.r),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () => Navigator.of(context).pop(),
                      child: const Icon(Icons.arrow_back_ios,
                          size: 20.0, color: AppPalette.white),
                    ),
                    10.widthBox,
                    Expanded(
                      child: Text(
                        context.locale.languageCode.contains("en") ?
                        widget.category.name!.en! :
                        context.locale.languageCode.contains("ar")  ?
                        widget.category.name!.ar! :
                        context.locale.languageCode.contains("tr")  ?
                        widget.category.name!.tr! :
                        context.locale.languageCode.contains("de") ?
                        widget.category.name!.de!: " ",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: AppPalette.white,
                            fontSize: Dimensions.fontSizeLarge,fontFamily: Fonts.poppins),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              35.heightBox,
              Container(
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                    color: AppPalette.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25))),
                child: BlocBuilder<AppUiCubit, AppUiState>(
                  builder: (context, authState) {
                    AppUiCubit appUICubit = AppUiCubit.get(context);
                    return BlocBuilder<CategoriesCubit, CategoriesState>(
                      builder: (context, state) {
                        CategoriesCubit categoriesCubit = CategoriesCubit.get(context);
                        return Column(
                          children: [
                            25.heightBox,
                            // SearchWidget(category: widget.category, products: categoriesCubit
                            //     .productsByCategory[
                            // categoriesCubit
                            //     .selectedParent]!
                            //     .products,),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: BlocBuilder<CategoriesCubit, CategoriesState>(
                                  builder: (context, state){
                                    CategoriesCubit categoriesCubit = CategoriesCubit.get(context);
                                    return  BlocBuilder<FilterCubit,FilterState>(
                                      builder: (context,state){
                                        FilterCubit filterCubit = FilterCubit.get(context);
                                        return  Column(
                                          children: [
                                            Padding(
                                              padding:  EdgeInsets.symmetric(horizontal: 10.r),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: TextFormField(
                                                      textAlignVertical: TextAlignVertical.center,
                                                      onTap: () => categoriesCubit.productsByCategory[categoriesCubit.selectedParent]!.products.isEmpty ?
                                                      '' : showSearch(context: context, delegate: SearchProductItem(widget.category.id.toString())),
                                                      onChanged: (text){},
                                                      decoration: InputDecoration(
                                                        hintText: 'Search for product . . .',
                                                        filled: true,
                                                        fillColor: AppPalette.lightPrimary,
                                                        prefixIcon: InkWell(
                                                          onTap: (){

                                                          },
                                                          child: Container(
                                                              padding: EdgeInsets.all(
                                                                Dimensions.paddingSize,
                                                              ),
                                                              child: SvgPicture.asset("assets/images/svg/search.svg")),
                                                        ),
                                                        contentPadding: EdgeInsets.zero,
                                                        border: UnderlineInputBorder(
                                                          borderSide: BorderSide.none,
                                                          borderRadius: BorderRadius.circular(10.0),
                                                        ),
                                                        disabledBorder: UnderlineInputBorder(
                                                          borderSide: BorderSide.none,
                                                          borderRadius: BorderRadius.circular(10.0),
                                                        ),
                                                        enabledBorder: UnderlineInputBorder(
                                                          borderSide: BorderSide.none,
                                                          borderRadius: BorderRadius.circular(10.0),
                                                        ),
                                                        focusedBorder: UnderlineInputBorder(
                                                          borderSide: BorderSide.none,
                                                          borderRadius: BorderRadius.circular(10.0),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  7.widthBox,
                                                  GestureDetector(
                                                    onTap: (){
                                                      print(widget.category.name);
                                                      // CustomFlutterToast(category!.id);
                                                      // CustomFlutterToast(category!.name);

                                                      filterCubit.selectMainCategory(
                                                          category: widget.category);
                                                      categoriesCubit.setSelectedParent(
                                                          widget.category.id!);
                                                      filterCubit.selectedColorsModel = [];
                                                      Navigator.of(context).push(MaterialPageRoute(
                                                          builder: (context) => SubCategoryScreen(
                                                              category: widget.category)));

                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(10.0),
                                                          color: AppPalette.primary),
                                                      padding: EdgeInsets.symmetric(
                                                        vertical: Dimensions.paddingSize,
                                                        horizontal: Dimensions.paddingSizeDefault,
                                                      ),
                                                      child: SvgPicture.asset("assets/images/svg/filter.svg",color: AppPalette.white,),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            15.heightBox,
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: Dimensions.paddingSizeDefault,
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Text(LocaleKeys.showingResults.tr(),
                                                      style: AppTextStyles.poppinsRegular
                                                          .copyWith(color: AppPalette.black)),
                                                  Text(" ${categoriesCubit.productsByCategory
                                                  [categoriesCubit.selectedParent]!.products.length} ",
                                                      style: AppTextStyles.poppinsRegular),
                                                  Expanded(
                                                    child: Text( context.locale.languageCode.contains('en') ?
                                                    widget.category.name!.en! :
                                                    context.locale.languageCode.contains('ar') ?
                                                    widget.category.name!.ar! :
                                                    context.locale.languageCode.contains('tr') ?
                                                    widget.category.name!.tr! :
                                                    context.locale.languageCode.contains('de') ?
                                                    widget.category.name!.de! : '',
                                                        overflow: TextOverflow.ellipsis,
                                                        style: AppTextStyles.poppinsRegular
                                                            .copyWith(color: AppPalette.black)),
                                                  ),
                                                  const Spacer(),
                                                  InkWell(
                                                    onTap: appUICubit.toggleView,
                                                    child: Icon(
                                                        appUICubit.isGrid
                                                            ? Icons.list_sharp
                                                            : Icons.grid_view_sharp,
                                                        color: AppPalette.black),
                                                  ),
                                                ],
                                              ),
                                            ),

                                          ],
                                        );
                                      },
                                    );
                                  }
                              ),
                            ),
                            10.heightBox,
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0,
                                ),
                                child: categoriesCubit.productsByCategory[categoriesCubit.selectedParent]!.loadingProducts
                                    ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                                    : categoriesCubit.productsByCategory[categoriesCubit.selectedParent]!.products.isEmpty ?
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    // Padding(
                                    //   padding: EdgeInsets.symmetric(
                                    //     horizontal: Dimensions.paddingSizeDefault,
                                    //   ),
                                    //   child: Row(
                                    //     mainAxisAlignment:
                                    //     MainAxisAlignment.spaceBetween,
                                    //     crossAxisAlignment: CrossAxisAlignment.start,
                                    //     children: [
                                    //       Text(
                                    //         LocaleKeys.newRecommendations.tr(),
                                    //         style:
                                    //         Theme.of(context).textTheme.headline3,
                                    //       ),
                                    //     ],
                                    //   ),
                                    // ),
                                    Center(
                                      child: SvgPicture.asset(
                                          "assets/images/svg/addProduct.svg",
                                          height: 200,
                                          width: 200,
                                          fit: BoxFit.contain),
                                    ),
                                    25.heightBox
                                  ],
                                ) :
                                SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      appUICubit.isGrid
                                          ? ProductsGridWidget(
                                        products: categoriesCubit.productsByCategory
                                        [categoriesCubit.selectedParent]!.products,)
                                          : ProductListWidget(
                                        products: categoriesCubit
                                            .productsByCategory[
                                        categoriesCubit
                                            .selectedParent]!
                                            .products,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ), //todo delete
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      )


    );
  }
}
