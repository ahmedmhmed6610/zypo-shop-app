import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop/data/models/MyProductUserModel.dart';
import 'package:shop/ui/widgets/filter_widgets/filter_result_widgets/filter_result_search_widget.dart';
import 'package:shop/utils/app_size_boxes.dart';

import '../../../../translations/locale_keys.g.dart';
import '../../../../utils/app_palette.dart';
import '../../../../utils/dimensions.dart';
import '../../../screens/filter_screens/filter_screen.dart';

class FilterAndSearchAppBarWidget2 extends StatelessWidget {
  FilterAndSearchAppBarWidget2({Key? key,required this.myProductUserResponseModel}) : super(key: key);
  List<MyProductUserResponseModel>? myProductUserResponseModel;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: FilterResultSearchWidget(myProductUserResponseModel: myProductUserResponseModel,),
        ),
        15.widthBox,
        InkWell(
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => FilterScreen(),
          )),
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: Dimensions.paddingSize,
                vertical: Dimensions.paddingSize),
            decoration: BoxDecoration(
                color: AppPalette.primary,
                borderRadius: BorderRadius.circular(Dimensions.radiusDefault)),
            child: Row(
              children: [
                const Icon(Icons.sort, color: AppPalette.white),
                10.widthBox,
                Text(
                  LocaleKeys.filter.tr(),
                  style: const TextStyle(color: AppPalette.white),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
