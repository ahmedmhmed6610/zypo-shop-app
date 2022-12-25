// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:material_dialogs/material_dialogs.dart';
// import 'package:material_dialogs/widgets/buttons/icon_button.dart';
//
// import '../../../../business_logic/my_products_cubit/my_products_cubit.dart';
// import '../../../../data/models/MyProductUserModel.dart';
// import '../../../../libraries/dialog_widget.dart';
// import '../../../../translations/locale_keys.g.dart';
// import '../../../../utils/app_palette.dart';
// import '../../../../utils/dimensions.dart';
// import '../my_product_item.dart';
//
// class OrdersList extends StatefulWidget {
//   final int? tabIndex;
//   final String? lottie;
//   AddProductCubit? addProductCubit;
//
//   OrdersList(
//       {Key? key,
//       required this.addProductCubit,
//       required this.tabIndex,
//       this.lottie})
//       : super(key: key);
//
//   @override
//   State<OrdersList> createState() => _OrdersListState();
// }
//
// class _OrdersListState extends State<OrdersList> {
//   @override
//   Widget build(BuildContext context) {
//     if (widget.addProductCubit!.myProductUserResponseModel!.data == null ||
//             widget.addProductCubit!.myProductUserResponseModel!.data!.isEmpty) {
//       return Center(
//             child: SvgPicture.asset("assets/images/svg/addProduct.svg",
//                 fit: BoxFit.contain),
//           );
//     } else {
//       return SizedBox(
//         height: 150,
//           width: 150,
//           child: GridView.builder(
//               shrinkWrap: true,
//               physics: const BouncingScrollPhysics(),
//               padding: EdgeInsets.symmetric(vertical: 20.h),
//               gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
//                 maxCrossAxisExtent: 200.0,
//                 mainAxisSpacing: 20.0.h,
//                 crossAxisSpacing: 15.0.w,
//                 childAspectRatio: 1 / 1.8,
//               ),
//               itemCount: widget
//                   .addProductCubit!.myProductUserResponseModel!.data!.length,
//               // itemBuilder: (context, index) => Container(
//               //   color: Colors.red,
//               // ),
//               itemBuilder: (context, index) => MyProductGridItem(
//                 product: widget.addProductCubit!.myProductUserResponseModel!.data!
//                     .elementAt(index),
//                 onDelete: () async {
//                   final MyProductUserResponseModel product = widget
//                       .addProductCubit!.myProductUserResponseModel!.data!
//                       .elementAt(index);
//                   showDialog(
//                       context: context,
//                       builder: (context) => Dialog(
//                             backgroundColor: Colors.white,
//                             shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(
//                                     Dimensions.radiusDefault)),
//                             alignment: Alignment.bottomCenter,
//                             insetPadding: EdgeInsets.symmetric(
//                                 vertical: Dimensions.paddingSize,
//                                 horizontal: Dimensions.paddingSize),
//                             child: CustomDialogWidget(
//                               msgStyle: const TextStyle(height: 2),
//                               title: LocaleKeys
//                                   .areYouSureYouWantToDeleteThisProduct
//                                   .tr(),
//                               msg: widget.addProductCubit!
//                                   .myProductUserResponseModel!.data![index].name,
//                               titleStyle: const TextStyle(
//                                 color: Colors.blueGrey,
//                                 overflow: TextOverflow.ellipsis,
//                               ),
//                               actions: [
//                                 Padding(
//                                   padding: EdgeInsets.symmetric(
//                                       horizontal: Dimensions.paddingSizeLarge),
//                                   child: IconsButton(
//                                     onPressed: () async {
//                                       widget.addProductCubit!.deleteProductItem(
//                                           context,
//                                           productId: product.id.toString(),
//                                           isSold: '0');
//                                     },
//                                     text: LocaleKeys.delete.tr(),
//                                     // color: Colors.transparent,
//                                     shape: OutlineInputBorder(
//                                         borderSide:
//                                             const BorderSide(color: AppPalette.black),
//                                         borderRadius: BorderRadius.circular(
//                                             Dimensions.radiusDefault)),
//                                     textStyle:
//                                         const TextStyle(color: Colors.black),
//                                     padding: EdgeInsets.symmetric(
//                                         horizontal:
//                                             Dimensions.paddingSizeExtraSmall,
//                                         vertical: Dimensions.paddingSizeDefault),
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: EdgeInsets.symmetric(
//                                       horizontal: Dimensions.paddingSizeLarge),
//                                   child: IconsButton(
//                                     onPressed: () {
//                                       widget.addProductCubit!.deleteProductItem(
//                                           context,
//                                           productId: product.id.toString(),
//                                           isSold: '1');
//                                     },
//                                     text: LocaleKeys.productSold.tr(),
//                                     // iconData: Icons.done,
//                                     color: AppPalette.primary,
//                                     textStyle:
//                                         const TextStyle(color: Colors.white),
//                                     shape: OutlineInputBorder(
//                                         borderSide: BorderSide.none,
//                                         borderRadius: BorderRadius.circular(
//                                             Dimensions.radiusDefault)),
//                                     padding: EdgeInsets.symmetric(
//                                         horizontal:
//                                             Dimensions.paddingSizeExtraSmall,
//                                         vertical: Dimensions.paddingSizeDefault),
//                                     // iconColor: Colors.white,
//                                   ),
//                                 ),
//                               ],
//                               animationBuilder: widget.lottie != null
//                                   ? LottieBuilder.asset(
//                                       widget.lottie.toString(),
//                                     )
//                                   : null,
//                               customView: Dialogs.holder,
//                               color: Colors.white,
//                             ),
//                           ));
//                 },
//               ),
//             ),
//         );
//     }
//   }
// }
