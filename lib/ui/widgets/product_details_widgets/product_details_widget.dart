import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop/utils/dimensions.dart';
import 'package:shop/utils/styles.dart';

class ProductDetailsWidget extends StatelessWidget {
  // Map<String, String> productDetails = {};
  // ProductDetailsWidget({Key? key, required this.productDetails})
  //     : super(key: key);
  String title;
  String subtitle;
  ProductDetailsWidget({Key? key, required this.title, required this.subtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "$title : ",
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.poppinsRegular.copyWith(color: Colors.black,fontSize: 15),
          ),
          Text(
            subtitle,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.poppinsLight.copyWith(
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w100,
                fontSize: Dimensions.fontSizeSemiSmall),
          )
        ],
      ),
    );
    // return ListView.separated(
    //     shrinkWrap: true,
    //     physics: const ScrollPhysics(),
    //     itemBuilder: (context, index) => Row(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           mainAxisAlignment: MainAxisAlignment.start,
    //           children: [
    //             Text(
    //               "${productDetails.keys.toList()[index]} : ",
    //               style: AppTextStyles.poppinsRegular
    //                   .copyWith(color: Colors.black),
    //             ),
    //             Text(
    //               productDetails.values.toList()[index],
    //               style: AppTextStyles.poppinsLight.copyWith(
    //                   color: Colors.grey.shade600,
    //                   fontWeight: FontWeight.w100,
    //                   fontSize: Dimensions.fontSizeSemiSmall),
    //             )
    //           ],
    //         ),
    //     separatorBuilder: (context, index) =>
    //         const Divider(color: AppPalette.grey),
    //     itemCount: productDetails.length);
  }
}
