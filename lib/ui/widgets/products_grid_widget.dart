import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop/data/models/product_model.dart';
import 'package:shop/ui/widgets/product_widgets/product_item.dart';

class ProductsGridWidget extends StatelessWidget {
  List<ProductModel> products = [];
  ProductsGridWidget({Key? key, required this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 5.0.h,
        crossAxisSpacing: 22.0.w,
        childAspectRatio: 1.3 / 2,
      ),
      itemCount: products.length,
      // itemBuilder: (context, index) => Container(
      //   color: Colors.red,
      // ),
      itemBuilder: (context, index) => SizedBox(
        child: ProductItem(
          product: products.elementAt(index),),
      ),
    );
  }
}
