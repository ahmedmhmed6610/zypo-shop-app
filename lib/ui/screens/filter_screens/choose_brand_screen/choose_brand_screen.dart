// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:shop/business_logic/brand_cubit/brand_cubit.dart';
// import 'package:shop/business_logic/categories_cubit/categories_cubit.dart';
// import 'package:shop/business_logic/filter_cubit/filter_cubit.dart';
// import 'package:shop/data/models/brand_model.dart';
// import 'package:shop/translations/locale_keys.g.dart';
// import 'package:shop/ui/base/custom_button.dart';
// import 'package:shop/ui/widgets/filter_widgets/choose_brand_widgets/choose_brand_search_widget.dart';
// import 'package:shop/utils/app_palette.dart';
// import 'package:shop/utils/app_size_boxes.dart';
// import 'package:shop/utils/dimensions.dart';
// import 'package:shop/utils/styles.dart';
//
// class ChooseBrandScreen extends StatelessWidget {
//   ChooseBrandScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(LocaleKeys.filter.tr()),
//         elevation: 0.0,
//         leading: InkWell(
//           onTap: () => Navigator.of(context).pop(),
//           child: const Icon(Icons.arrow_back_ios,
//               size: 20.0, color: AppPalette.black),
//         ),
//       ),
//       body: BlocBuilder<CategoriesCubit, CategoriesState>(
//         builder: (context, state) {
//           CategoriesCubit categoriesCubit = CategoriesCubit.get(context);
//           return BlocBuilder<FilterCubit, FilterState>(
//             builder: (context, state) {
//               FilterCubit filterCubit = FilterCubit.get(context);
//               return Container(
//                 padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       LocaleKeys.chooseBrand.tr(),
//                       style: AppTextStyles.poppinsMedium
//                           .copyWith(color: AppPalette.black),
//                     ),
//                     10.heightBox,
//                     ChooseBrandSearchWidget(),
//                     5.heightBox,
//                     Expanded(
//                       child: categoriesCubit
//                               .brandsByCategory[
//                                   filterCubit.selectedSubCategory == null
//                                       ? categoriesCubit.selectedParent
//                                       : filterCubit.selectedSubCategory!.id]!
//                               .loadingBrand
//                           ? const Center(
//                               child: CircularProgressIndicator(),
//                             )
//                           : ListView(
//                               children: [
//                                 7.heightBox,
//                                 ListView.builder(
//                                   shrinkWrap: true,
//                                   physics: const ScrollPhysics(),
//                                   itemCount: categoriesCubit
//                                       .brandsByCategory[filterCubit
//                                                   .selectedSubCategory !=
//                                               null
//                                           ? filterCubit.selectedSubCategory!.id
//                                           : categoriesCubit.selectedParent]!
//                                       .brands
//                                       .length,
//                                   padding: EdgeInsets.zero,
//
//                                   itemBuilder: (context, index) => InkWell(
//                                     onTap: () => filterCubit.selectBrandModel(
//                                         brandModel: categoriesCubit
//                                             .brandsByCategory[filterCubit
//                                                         .selectedSubCategory !=
//                                                     null
//                                                 ? filterCubit
//                                                     .selectedSubCategory!.id
//                                                 : categoriesCubit
//                                                     .selectedParent]!
//                                             .brands[index]),
//                                     child: Row(
//                                       children: [
//                                         Checkbox(
//                                             value: filterCubit.isBrandSelected(
//                                                 brandModel: categoriesCubit
//                                                     .brandsByCategory[filterCubit.selectedSubCategory != null
//                                                         ? filterCubit
//                                                             .selectedSubCategory!
//                                                             .id
//                                                         : categoriesCubit
//                                                             .selectedParent]!
//                                                     .brands[index]),
//                                             // groupValue: filterCubit.selectedBrandModel,
//                                             activeColor: AppPalette.primary,
//                                             onChanged: (val) => filterCubit.selectBrandModel(
//                                                 brandModel: categoriesCubit
//                                                     .brandsByCategory[filterCubit.selectedSubCategory != null
//                                                         ? filterCubit
//                                                             .selectedSubCategory!
//                                                             .id
//                                                         : categoriesCubit.selectedParent]!
//                                                     .brands[index]),
//                                             visualDensity: const VisualDensity(
//                                               horizontal:
//                                                   VisualDensity.minimumDensity,
//                                             ),
//                                             materialTapTargetSize: MaterialTapTargetSize.shrinkWrap),
//                                         12.widthBox,
//                                         Text(
//                                           categoriesCubit
//                                               .brandsByCategory[filterCubit
//                                                           .selectedSubCategory !=
//                                                       null
//                                                   ? filterCubit
//                                                       .selectedSubCategory!.id
//                                                   : categoriesCubit
//                                                       .selectedParent]!
//                                               .brands[index]
//                                               .brandName!,
//                                           style: AppTextStyles.poppinsRegular
//                                               .copyWith(
//                                                   color: AppPalette.black),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   // value: filterCubit.locations[index],
//                                   // title: Text(filterCubit.locations[index].location),
//                                   // contentPadding: EdgeInsets.zero,
//                                   // activeColor: AppPalette.primary,
//                                   // groupValue: filterCubit.selectedLocation,
//                                   // onChanged: (LocationModel? location) =>
//                                   //     filterCubit.selectLocation(location: location!))
//                                 ),
//                               ],
//                             ),
//                     ),
//                     5.heightBox,
//                     CustomButton(
//                       buttonText: LocaleKeys.apply.tr(),
//                       onPressed: () => Navigator.of(context).pop(),
//                       height: 48.h,
//                       fontSize: Dimensions.fontSizeLarge,
//                     ),
//                   ],
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
