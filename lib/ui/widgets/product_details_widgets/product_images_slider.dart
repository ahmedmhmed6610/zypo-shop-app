import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop/ui/screens/product_details_screen/image_details_zoom_screen.dart';
import 'package:shop/utils/app_palette.dart';
import 'package:shop/utils/dimensions.dart';

import '../../../helpers/components.dart';
import '../../screens/layout/app_layout.dart';

class ProductImagesSlider extends StatelessWidget {
  List<String> images = [];
  String phoneNumber,whatsAppNumber,productName;
  int userId;
  ProductImagesSlider({Key? key, required this.userId, required this.productName,  required this.images,required this.phoneNumber,required this.whatsAppNumber}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 5,
          right: 2.h,
          left: 2.h,
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 15.h),
            child: Row(
              children: [
                GestureDetector(
                  onTap: ()=> navigateReplaceTo(context: context, widget: AppLayout()),
                  child: Icon(Icons.arrow_back_ios,color: AppPalette.white,size: 25.sp,),
                ),
                Expanded(
                  child: Center(
                    child: AutoSizeText(
                      productName,
                      style: Theme.of(context).textTheme.headline2!.copyWith(
                          color: AppPalette.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 15.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 230.h,
          width: MediaQuery.of(context).size.width,
          child: Swiper(
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: [
                  GestureDetector(
                    onTap: (){
                      // _dialogBuilder(context, images[index]);
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => ImageDetailsZoomScreen(images: images,productName: productName,
                            phoneNumber: phoneNumber ,whatsAppNumber: whatsAppNumber, userId: userId,)));
                      print(images[index]);
                    },
                    child: Container(
                      height: 200.h,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                        image: DecorationImage(
                            image: CachedNetworkImageProvider(images[index],),
                            fit: BoxFit.cover),
                      ),
                    ),
                  ),
                  // SizedBox(
                  //   height: 30.h,
                  //   width: MediaQuery.of(context).size.width,
                  // ),
                ],
              );
            },
            itemCount: images.length,
            pagination: SwiperPagination(
              builder: DotSwiperPaginationBuilder(
                  color: AppPalette.grey.withOpacity(0.7),
                  activeColor: AppPalette.primary,
                  activeSize: 13.0,
                  size: 9.0),
              alignment: Alignment.bottomCenter,
            ),
            viewportFraction: 1,
            scale: 0.9,
            autoplay: true,
            allowImplicitScrolling: true,
            autoplayDelay: 3000,
            duration: 600,
            curve: Curves.easeIn,
          ),
        ),
      ],
    );
  }
}
