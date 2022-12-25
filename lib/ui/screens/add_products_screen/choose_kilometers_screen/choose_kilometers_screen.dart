// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:shop/business_logic/filter_cubit/filter_cubit.dart';
// import 'package:shop/business_logic/my_products_cubit/my_products_cubit.dart';
// import 'package:shop/business_logic/my_products_cubit/my_products_state.dart';
// import 'package:shop/data/models/brand_model.dart';
// import 'package:shop/translations/locale_keys.g.dart';
// import 'package:shop/ui/base/custom_button.dart';
// import 'package:shop/ui/widgets/filter_widgets/choose_brand_widgets/choose_brand_search_widget.dart';
// import 'package:shop/ui/widgets/filter_widgets/choose_color_screen/choose_color_search_widget.dart';
// import 'package:shop/utils/app_palette.dart';
// import 'package:shop/utils/app_size_boxes.dart';
// import 'package:shop/utils/dimensions.dart';
// import 'package:shop/utils/styles.dart';
//
// import '../../../../data/color_model.dart';
//
//
// class ChooseKilometersAddProductScreen extends StatefulWidget {
//   const ChooseKilometersAddProductScreen({Key? key}) : super(key: key);
//
//   @override
//   _ChooseKilometersAddProductScreenState createState() => _ChooseKilometersAddProductScreenState();
// }
//
// class _ChooseKilometersAddProductScreenState extends State<ChooseKilometersAddProductScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(LocaleKeys.filter.tr()),
//         elevation: 0.0,
//         leading: InkWell(
//           onTap: () => Navigator.push(context, MaterialPageRoute
//             (builder: (context) => AddProductScreen(
//               governmentId: widget
//                   .governmentId,
//               governmentName: widget
//                   .governmentName,
//               nameProduct: widget.nameProduct,
//               fromPrice: widget.fromPrice,
//               toPrice: widget.toPrice,
//               bedroom: widget.bedroom,
//               bathroom: widget.bathroom,
//               area: widget.area,
//               downPayment: widget.downPayment,
//               year: widget.year,
//               description: widget.description,
//               cityId: widget.cityId,
//               cityName: widget.cityName,
//               areaId: widget.areaId,
//               amenitiesType: widget.amenitiesType,
//               bodyType: widget.bodyType,
//               colorType: widget.colorType,
//               engineCapacityType: widget.engineCapacityType,
//               fuelType: widget.fuelType,
//               kiloMetresType: widget.kiloMetresType,
//               levelType: widget.levelType,
//               areaName: widget.areaName))),
//           child: const Icon(Icons.arrow_back_ios,
//               size: 20.0, color: AppPalette.black),
//         ),
//       ),
//       body: BlocBuilder<AddProductCubit, AddProductState>(
//         builder: (context, state) {
//           AddProductCubit filterCubit = AddProductCubit.get(context);
//           return Container(
//             padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   LocaleKeys.kilometers.tr(),
//                   style: AppTextStyles.poppinsMedium
//                       .copyWith(color: AppPalette.black),
//                 ),
//                 10.heightBox,
//                 ChooseColorSearchWidget(),
//                 5.heightBox,
//                 Expanded(
//                   child: ListView(
//                     children: [
//                       7.heightBox,
//                       ListView.builder(
//                         shrinkWrap: true,
//                         physics: const ScrollPhysics(),
//                         itemCount: filterCubit.addProductCubitKiloMeters.length,
//                         padding: EdgeInsets.zero,
//                         itemBuilder: (context, index) => InkWell(
//                           onTap: () => filterCubit.selectColorToFilter(
//                               color: filterCubit.addProductCubitKiloMeters[index]),
//                           child: Row(
//                             children: [
//                               Radio(
//                                   value: filterCubit.addProductCubitKiloMeters[index],
//                                   groupValue: filterCubit.selectedKiloMeters,
//                                   activeColor: AppPalette.primary,
//                                   onChanged: (ColorModel? colorModel) =>
//                                       filterCubit.selectKiloMetersModel(
//                                           colorModel: colorModel!),
//                                   visualDensity: const VisualDensity(
//                                     horizontal:
//                                     VisualDensity.minimumDensity,
//                                   ),
//                                   materialTapTargetSize:
//                                   MaterialTapTargetSize
//                                       .shrinkWrap),
//                               12.widthBox,
//                               Text(
//                                 filterCubit.addProductCubitKiloMeters[index].color,
//                                 style: AppTextStyles.poppinsRegular
//                                     .copyWith(color: AppPalette.black),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 5.heightBox,
//                 CustomButton(
//                   buttonText: LocaleKeys.apply.tr(),
//                   onPressed: () => Navigator.of(context).pop(),
//                   height: 48.h,
//                   fontSize: Dimensions.fontSizeLarge,
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
//
