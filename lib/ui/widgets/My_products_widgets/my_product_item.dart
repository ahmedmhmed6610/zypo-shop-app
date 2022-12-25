import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop/data/models/MyProductUserModel.dart';
import 'package:shop/translations/locale_keys.g.dart';
import 'package:shop/utils/app_palette.dart';
import 'package:shop/utils/app_size_boxes.dart';
import 'package:shop/utils/dimensions.dart';
import 'package:shop/utils/styles.dart';

import '../../../business_logic/product_details_cubit/product_details_cubit.dart';
import '../../../data/models/product_model.dart';
import '../../../utils/app_constants.dart';
import '../../screens/add_products_screen/change_product_screen2.dart';

class MyProductGridItem extends StatelessWidget {
  final ProductModel product;
  Function() onDelete;
  MyProductGridItem({Key? key, required this.product, required this.onDelete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Container(
              width: 155.w,
              height: 194.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
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
                borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl:  product.images!.isNotEmpty ? '${product.imagesPath}${product.images![0].name!}' : profileImage,
                  placeholder: (context, url) => Image.asset('assets/images/loader.gif'),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
            Positioned(
              top: 10.h,
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
                  Row(
                    children: [
                      buildIcon(
                          iconData: Icons.edit, color: AppPalette.primary, onTap: () {
                        BlocProvider.of<ProductDetailsCubit>(context).getProductDetailsUser('${product.id}');
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => ChangeProductScreen2(product: product,)));

                      }),
                      5.widthBox,
                      buildIcon(
                          iconData: Icons.delete,
                          color: AppPalette.removeIconColor,
                          onTap: onDelete),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
        8.heightBox,
        Text(
          product.name!,
          maxLines: 1,
          style: AppTextStyles.poppinsMedium.copyWith(color: Colors.black),
        ),
        2.heightBox,
        Row(
          children: [
            Expanded(
              child: Text(
                "${product.price} ${LocaleKeys.currencyPrice.tr()}",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.poppinsRegular,
              ),
            ),
            10.widthBox,
          ],
        ),
      ],
    );
  }

  buildIcon(
      {required IconData iconData,
        required Color color,
        required Function() onTap}) {
    return SizedBox(
      height: 30.r,
      width: 30.r,
      child: InkWell(
        onTap: onTap,
        child: Material(
          color: Colors.white,
          shadowColor: AppPalette.shadowColor2,
          elevation: 3.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.r),
          ),
          child: Center(
            child: Icon(
              iconData,
              color: color,
              size: 22.r,
            ),
          ),
        ),
      ),
    );
  }
}
