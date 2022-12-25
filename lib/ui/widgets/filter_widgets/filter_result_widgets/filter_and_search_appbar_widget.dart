import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop/data/models/MyProductUserModel.dart';
import 'package:shop/ui/widgets/filter_widgets/filter_result_widgets/filter_result_search_widget.dart';
import 'package:shop/utils/app_size_boxes.dart';

class FilterAndSearchAppBarWidget extends StatelessWidget {
  FilterAndSearchAppBarWidget({Key? key,required this.myProductUserResponseModel}) : super(key: key);
  List<MyProductUserResponseModel>? myProductUserResponseModel;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: FilterResultSearchWidget(myProductUserResponseModel: myProductUserResponseModel,),
        ),
        8.widthBox,
        // InkWell(
        //   onTap: () => Navigator.of(context).push(MaterialPageRoute(
        //     builder: (context) => FilterScreen(),
        //   )),
        //   child: Container(
        //     padding: EdgeInsets.symmetric(
        //         horizontal: Dimensions.paddingSize,
        //         vertical: Dimensions.paddingSmall),
        //     decoration: BoxDecoration(
        //         color: AppPalette.primary,
        //         borderRadius: BorderRadius.circular(Dimensions.radiusDefault)),
        //     child: Row(
        //       children: [
        //         const Icon(Icons.sort, color: AppPalette.white),
        //         10.widthBox,
        //         Text(
        //           LocaleKeys.filter.tr(),
        //           style: const TextStyle(color: AppPalette.white),
        //         )
        //       ],
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
