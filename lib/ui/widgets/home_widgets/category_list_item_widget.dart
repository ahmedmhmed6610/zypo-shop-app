import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop/data/models/category_model.dart';
import 'package:shop/utils/app_size_boxes.dart';

import '../../../../utils/app_palette.dart';
import '../../../../utils/dimensions.dart';

class CategoryListItemWidget extends StatefulWidget {
  CategoryListItemWidget({
    Key? key,
    required this.categoryListItemModel,
    required this.onTap,
  }) : super(key: key);
  final CategoryModel categoryListItemModel;
  final Function() onTap;

  @override
  State<CategoryListItemWidget> createState() => _CategoryListItemWidgetState();
}

class _CategoryListItemWidgetState extends State<CategoryListItemWidget> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Column(
        children: [
          Container(
              height: 56.h,
              width: 56.w,
              margin: EdgeInsets.symmetric(
                horizontal: Dimensions.paddingSizeSmall,
              ),
              padding: EdgeInsets.all(Dimensions.paddingSize),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppPalette.white,
                boxShadow: [
                  BoxShadow(
                    color: AppPalette.shadowColor,
                    spreadRadius: 0.7,
                    blurRadius: 3,
                    offset: Offset(0, 2), // changes position of shadow
                  ),
                ],
              ),
              child:
              CachedNetworkImage(
                imageUrl: widget.categoryListItemModel.image!,
                height: 24.sp,
                width: 24.sp,
                fit: BoxFit.contain,
              )
              //     SvgPicture.asset(
              //   categoryListItemModel.icon,
              //   color: AppPalette.primary,
              // ),
              // ),
              ),
          7.heightBox,
          SizedBox(
            width: 56.w,
            child: Text(
              context.locale.languageCode.contains('en') ?
              widget.categoryListItemModel.name!.en! :
              context.locale.languageCode.contains('ar') ?
              widget.categoryListItemModel.name!.ar! :
              context.locale.languageCode.contains('tr') ?
              widget.categoryListItemModel.name!.tr! :
              context.locale.languageCode.contains('de') ?
              widget.categoryListItemModel.name!.de! : '',
              overflow: TextOverflow.ellipsis,
              softWrap: true,
              textAlign: TextAlign.center,
              maxLines: 1,
              style: Theme.of(context).textTheme.headline3?.copyWith(
                    fontSize: Dimensions.fontSizeSemiSmall,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
