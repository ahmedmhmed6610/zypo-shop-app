import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:shop/business_logic/wishlist_cubit/wishlist_cubit.dart';
import 'package:shop/business_logic/wishlist_cubit/wishlist_state.dart';
import 'package:shop/data/models/MyProductUserModel.dart';
import 'package:shop/utils/app_palette.dart';
import 'package:shop/utils/app_size_boxes.dart';
import 'package:shop/utils/dimensions.dart';
import 'package:shop/utils/styles.dart';

import '../../../helpers/app_local_storage.dart';
import '../../../libraries/dialog_widget.dart';
import '../../../translations/locale_keys.g.dart';
import '../../screens/auth/login_screen.dart';
import '../../screens/product_details_screen/product_filter_details_screen.dart';

class FilterProductItem extends StatelessWidget {
  final MyProductUserResponseModel product;
  FilterProductItem({Key? key, required this.product}) : super(key: key);

  String? lottie;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ProductFilterDetailsScreen(productId: product.id,location: product.location,
          product: product),
        ));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: 175.h,
                decoration:  BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: AppPalette.shadowColor2,
                      spreadRadius: 0.7,
                      blurRadius: 3,
                      offset: Offset(0, 2), // changes position of shadow
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    height: 175.h,
                    width: MediaQuery.of(context).size.width,
                    imageUrl: product.photoList![0],
                    placeholder: (context, url) => Image.asset('assets/images/loader.gif'),
                    errorWidget: (context, url, error) => new Icon(Icons.error),
                  ),
                ),
              ),
              // Container(
              //   width: MediaQuery.of(context).size.width,
              //   height: 175.h,
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
              //     image: DecorationImage(
              //         image: CachedNetworkImageProvider(
              //           product.photoList![0],
              //         ),
              //         fit: BoxFit.cover),
              //     color: Colors.white,
              //     boxShadow: const [
              //       BoxShadow(
              //         color: AppPalette.shadowColor2,
              //         spreadRadius: 0.7,
              //         blurRadius: 3,
              //         offset: Offset(0, 2), // changes position of shadow
              //       ),
              //     ],
              //   ),
              // ),
              // Image.network(
              //   product.proPicture,
              //   fit: BoxFit.fill,
              //   width: MediaQuery.of(context).size.width,
              //   height: 194.h,
              // ),
              Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BlocBuilder<WishlistCubit, WishlistState>(
                        builder: (context, state) {
                          WishlistCubit wishListController =
                          WishlistCubit.get(context);
                          return InkWell(
                            onTap: () {
                              if (AppLocalStorage.token == null){
                                showDialog(
                                    context: context,
                                    builder: (context) =>
                                        Dialog(
                                          backgroundColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(Dimensions.radiusDefault)),
                                          alignment: Alignment.bottomCenter,
                                          insetPadding: EdgeInsets.symmetric(
                                              vertical: Dimensions.paddingSize, horizontal: Dimensions.paddingSize),
                                          child: CustomDialogWidget(
                                            msgStyle: const TextStyle(height: 2),
                                            title: LocaleKeys.youHaveToLoginFirst.tr(),
                                            msg: LocaleKeys.loginAndSellBuy.tr(),
                                            titleStyle: const TextStyle(
                                              color: Colors.blueGrey,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            actions: [
                                              Padding(
                                                padding:
                                                EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
                                                child: IconsButton(
                                                  onPressed: () async {
                                                    // addProductCubit.deleteProductItem(context,productId: product.id.toString(),isSold: '0');
                                                    Navigator.pop(context);
                                                  },
                                                  text: LocaleKeys.cancel.tr(),
                                                  // color: Colors.transparent,
                                                  shape: OutlineInputBorder(
                                                      borderSide: const BorderSide(color: AppPalette.black),
                                                      borderRadius:
                                                      BorderRadius.circular(Dimensions.radiusDefault)),
                                                  textStyle: const TextStyle(color: Colors.black),
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: Dimensions.paddingSizeExtraSmall,
                                                      vertical: Dimensions.paddingSizeDefault),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
                                                child: IconsButton(
                                                  onPressed: () {
                                                    //  addProductCubit.deleteProductItem(context,productId: product.id.toString(),isSold: '1');
                                                    Navigator.of(context).push(MaterialPageRoute(
                                                        builder: (context) => const LoginScreen()));
                                                  },
                                                  text: LocaleKeys.login.tr(),
                                                  // iconData: Icons.done,
                                                  color: AppPalette.primary,
                                                  textStyle: const TextStyle(color: Colors.white),
                                                  shape: OutlineInputBorder(
                                                      borderSide: BorderSide.none,
                                                      borderRadius:
                                                      BorderRadius.circular(Dimensions.radiusDefault)),
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: Dimensions.paddingSizeExtraSmall,
                                                      vertical: Dimensions.paddingSizeDefault),
                                                  // iconColor: Colors.white,
                                                ),
                                              ),
                                            ],
                                            animationBuilder: lottie != null
                                                ? LottieBuilder.asset(
                                              lottie.toString(),
                                            )
                                                : null,
                                            customView: Dialogs.holder,
                                            color: Colors.white,
                                          ),
                                        )
                                );
                              }else {
                                wishListController.toggleWishActionFilter(
                                    product: product);
                              }},
                            child: Container(
                              margin: const EdgeInsets.all(10.0),
                              padding: const EdgeInsets.all(5.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3.r),
                                color: Colors.white,
                                // boxShadow: const [
                                //   BoxShadow(
                                //     color: AppPalette.shadowColor,
                                //     spreadRadius: 0.1,
                                //     blurRadius: 1,
                                //     offset: Offset(0, 1), // changes position of shadow
                                //   ),
                                // ],
                              ),
                              child: Icon(
                                wishListController.wishListContainFilter(
                                    productId: product.id!)
                                    ? Icons.star
                                    : Icons.star_border,
                                color: AppPalette.primary,
                              ),
                            ),
                          );
                        },
                      ),
                      product.proTax != 0.0 ?
                      Container(
                        margin: const EdgeInsets.all(10.0),
                        padding: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3.r),
                          color: product.proTax != 0.0 ? AppPalette.primary : null,
                          boxShadow: const [
                            BoxShadow(
                              color: AppPalette.shadowColor,
                              spreadRadius: 0.7,
                              blurRadius: 3,
                              offset:
                              Offset(0, 2), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Text(
                          "${product.proTax!.toStringAsFixed(1)} %",
                          style: AppTextStyles.poppinsRegular.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ) : Container() ,
                    ],
                  ),
                ),
              ),
            ],
          ),
          8.heightBox,
          Text(
            product.name!,
            maxLines: 1,
            style: AppTextStyles.poppinsMedium.copyWith(color: Colors.black),
          ),
          6.heightBox,
          Text(
            "${product.price} ${LocaleKeys.currencyPrice.tr()}",
            style: AppTextStyles.poppinsRegular,
          ),
        ],
      ),
    );
  }
}
