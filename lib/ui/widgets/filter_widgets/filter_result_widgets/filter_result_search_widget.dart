import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop/translations/locale_keys.g.dart';
import 'package:shop/utils/app_palette.dart';
import 'package:shop/utils/dimensions.dart';

import '../../../../data/models/MyProductUserModel.dart';
import '../../search_product_item_widget/search_product_item_widget.dart';

class FilterResultSearchWidget extends StatelessWidget {
   FilterResultSearchWidget({Key? key,required this.myProductUserResponseModel}) : super(key: key);
  List<MyProductUserResponseModel>? myProductUserResponseModel;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlignVertical: TextAlignVertical.center,
      onTap: () => myProductUserResponseModel!.isEmpty ? '' : showSearch(context: context,
          delegate: SearchProductItem(myProductUserResponseModel![0].category?.id.toString())),
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
    );
  }
}
