import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop/data/models/product_model.dart';
import 'package:shop/ui/widgets/product_widgets/product_list_item.dart';
import 'package:shop/utils/app_size_boxes.dart';

class ProductListWidget extends StatelessWidget {
  List<ProductModel> products = [];
  ProductListWidget({Key? key, required this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(vertical: 20.h),
      itemCount: products.length,
      // itemExtent: 200.0,
      itemBuilder: (context, index) =>
          ProductListItem(product: products[index]),
      separatorBuilder: (context, index) => 10.0.heightBox,
    );
  }
}
