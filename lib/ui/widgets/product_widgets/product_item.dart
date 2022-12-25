import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:shop/business_logic/product_details_cubit/product_details_cubit.dart';
import 'package:shop/business_logic/wishlist_cubit/wishlist_cubit.dart';
import 'package:shop/business_logic/wishlist_cubit/wishlist_state.dart';
import 'package:shop/data/models/product_model.dart';
import 'package:shop/ui/screens/product_details_screen/product_details_screen.dart';
import 'package:shop/utils/app_palette.dart';
import 'package:shop/utils/app_size_boxes.dart';
import 'package:shop/utils/dimensions.dart';
import 'package:shop/utils/styles.dart';

import '../../../helpers/app_local_storage.dart';
import '../../../libraries/dialog_widget.dart';
import '../../../translations/locale_keys.g.dart';
import '../../screens/auth/login_screen.dart';

class ProductItem extends StatelessWidget {
  final ProductModel product;
  ProductItem({Key? key, required this.product}) : super(key: key);
  String? lottie;

  @override
  Widget build(BuildContext context) {
    var dateList = product.createdAt?.split(' ');
    var date = dateList![0].trim();
    return InkWell(
      onTap: () {
        BlocProvider.of<ProductDetailsCubit>(context).getProductDetailsUser('${product.id}');
        print('user id');
        print(product.id!);
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ProductDetailsScreen(product: product),
        ));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            child: Stack(
              children: <Widget>[
                Container(
                  height: 125.h,
                  width: MediaQuery.of(context).size.width,
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
                      ]
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      height: 125.h,
                      width: MediaQuery.of(context).size.width,
                      imageUrl: product.photoList![0],
                      placeholder: (context, url) => Image.asset('assets/images/loader.gif'),
                      errorWidget: (context, url, error) => new Icon(Icons.error),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                            product.oldPrice != null ?
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
                                "${product.proTax?.toStringAsFixed(1)} %",
                                style: AppTextStyles.poppinsRegular.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                            ) : Container() : Container(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          7.heightBox,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.r),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    product.name!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.poppinsMedium.copyWith(color: Colors.black),
                  ),
                ),
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
                          wishListController.toggleWishAction(
                              product: product);
                        }},
                      child: SizedBox(
                        height: 35.h,
                        width: 35.h,
                        child: Card(
                          shadowColor: AppPalette.white,
                          elevation: 5.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.r),
                          ),
                          color: AppPalette.white ,
                          child: Container(
                            // margin: const EdgeInsets.all(10.0),
                            // padding: const EdgeInsets.all(5.0),
                            // decoration: BoxDecoration(
                            //   borderRadius: BorderRadius.circular(25.r),
                            //   color: Colors.white,
                            //   boxShadow: const [
                            //     BoxShadow(
                            //       color: AppPalette.shadowColor,
                            //       spreadRadius: 0.1,
                            //       blurRadius: 3,
                            //       offset: Offset(0, 1), // changes position of shadow
                            //     ),
                            //   ],
                            // ),
                            child: AppLocalStorage.token == null ?
                            const Icon(
                              Icons.star_border,
                              color: AppPalette.primary,
                            ) :
                            Icon(
                              wishListController.wishListContain(
                                  productId: product.id!)
                                  ? Icons.star
                                  : Icons.star_border,
                              color: AppPalette.primary,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          3.heightBox,
          Text(
            product.description!,
            style: AppTextStyles.caption,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          3.heightBox,
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "${product.price} ${LocaleKeys.currencyPrice.tr()}",
                style: AppTextStyles.poppinsRegular
                    .copyWith(fontWeight: FontWeight.w600,fontSize: Dimensions.fontSizeSemiSmall),
              ),
              10.widthBox,
              product.oldPrice !=
                  product.price
                  ? Text(
                "${product.oldPrice} ${LocaleKeys.currencyPrice.tr()}",
                style: TextStyle(
                    color: AppPalette.lightBlack,
                    fontFamily: Fonts.poppins,
                    fontWeight: FontWeight.w400,
                    fontSize: Dimensions.fontSizeSemiSmall,
                    textBaseline:
                    TextBaseline.ideographic,
                    decoration:
                    TextDecoration.lineThrough),
              )
                  : Container(),

            ],
          ),
        ],
      ),
    );
  }
}
