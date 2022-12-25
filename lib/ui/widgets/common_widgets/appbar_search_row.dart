import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop/data/models/product_model.dart';
import 'package:shop/translations/locale_keys.g.dart';
import 'package:shop/ui/screens/notification_screen/notification_screen.dart';
import 'package:shop/utils/app_size_boxes.dart';

import '../../../utils/app_palette.dart';
import '../../../utils/dimensions.dart';
import '../search_product_item_widget/search_product_item_widget.dart';

class AppBarSearchRow extends StatelessWidget {
 // List<ProductModel> products = [];
 // void Function(String)? onChanged;
  List<ProductModel>? productModel;
  AppBarSearchRow({Key? key,this.productModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45.h,
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.paddingSize,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: TextFormField(
              textAlignVertical: TextAlignVertical.center,
              onTap: () => productModel!.isEmpty ? '' : showSearch(context: context, delegate: SearchProductItem("all")),
              onChanged: (onChanged){},
              decoration: InputDecoration(
                hintText: LocaleKeys.SearchForProduct.tr(),
                filled: true,
                fillColor: AppPalette.lightPrimary,
                prefixIcon: Container(
                    padding: EdgeInsets.all(
                      Dimensions.paddingSize,
                    ),
                    child: SvgPicture.asset("assets/images/svg/search.svg")),
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
          InkWell(
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const NotificationScreen()));
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: AppPalette.lightPrimary),
              padding: EdgeInsets.symmetric(
                vertical: Dimensions.paddingSize,
                horizontal: Dimensions.paddingSizeDefault,
              ),
              child:
                  SvgPicture.asset("assets/images/svg/notifications-outline.svg"),
            ),
          ),

        ],
      ),
    );
  }
}
