
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:shop/data/models/SearchModel.dart';
import 'package:shop/data/webservices/api_services/search_user_serives.dart';
import 'package:shop/ui/screens/product_details_screen/product_search_details_screen.dart';
import 'package:shop/utils/app_size_boxes.dart';

import '../../../business_logic/wishlist_cubit/wishlist_cubit.dart';
import '../../../business_logic/wishlist_cubit/wishlist_state.dart';
import '../../../data/models/MyProductUserModel.dart';
import '../../../helpers/app_local_storage.dart';
import '../../../libraries/dialog_widget.dart';
import '../../../translations/locale_keys.g.dart';
import '../../../utils/app_palette.dart';
import '../../../utils/dimensions.dart';
import '../../../utils/styles.dart';
import '../../screens/auth/login_screen.dart';
import '../common_widgets/rating_widget.dart';

class SearchProductItem extends SearchDelegate {
  SearchProductItem(this.categoryId);
  String? categoryId ;

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.close))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back_ios),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {

    query == null ?  "" : query;
    categoryId  == null ? 'all' : categoryId;

    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
      child: FutureBuilder<MyProductUserModel?>(
          future: SearchUserService.searchUser(query,'$categoryId'),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return snapshot.data!.data!.isEmpty ?
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.paddingSizeDefault,
                    ),
                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          LocaleKeys.newRecommendations.tr(),
                          style:
                          Theme.of(context).textTheme.headline3,
                        ),
                      ],
                    ),
                  ),
                  35.heightBox,
                  Center(
                    child: SvgPicture.asset(
                        "assets/images/svg/addProduct.svg",
                        height: 150,
                        width: 150,
                        fit: BoxFit.contain),
                  ),
                ],
              ) :
              ListView.separated(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(vertical: 20.h),
                itemCount: snapshot.data!.data!.length,
                // itemExtent: 200.0,
                itemBuilder: (context, index) {
                  var dateList = snapshot.data!.data![index].createdAt?.split(' ');
                  var date = dateList![0].trim();
                  return InkWell(
                      onTap: () {
                        print('product idssssssss ${snapshot.data!.data![index].id}');
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ProductSearchDetailsScreen(productId: snapshot.data!.data![index].id,
                          product: snapshot.data!.data![index]),
                        ));
                      },
                      child: Container(
                        width: double.infinity,
                        height: 137.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                          // image: DecorationImage(
                          //     image: CachedNetworkImageProvider(
                          //       product.proPicture,
                          //     ),
                          //     fit: BoxFit.cover),
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
                        child: Row(
                          children: [
                            Expanded(
                                flex: 3,
                                child: Stack(
                                  alignment: Alignment.topLeft,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.all(Dimensions.paddingSizeSmall),
                                      decoration:  BoxDecoration(
                                        borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
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
                                        borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                                        child: CachedNetworkImage(
                                          fit: BoxFit.cover,
                                          imageUrl: '${snapshot.data?.data![index].imagesPath}${snapshot.data?.data![index].images![0].name}',
                                          placeholder: (context, url) => Image.asset('assets/images/loader.gif'),
                                          errorWidget: (context, url, error) => new Icon(Icons.error),
                                        ),
                                      ),
                                    ),
                                    // Container(
                                    //   margin: EdgeInsets.all(Dimensions.paddingSizeSmall),
                                    //   decoration:  BoxDecoration(
                                    //     borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                                    //     color: Colors.white,
                                    //   ),
                                    //   child: FadeInImage(
                                    //     image: NetworkImage(product.photoList[0]),
                                    //     fit: BoxFit.cover,
                                    //     height: 175.h,
                                    //     width: MediaQuery.of(context).size.width,
                                    //     placeholder:
                                    //     const AssetImage('assets/images/loader.gif'),
                                    //   ),
                                    // ),
                                    // Container(
                                    //   margin: EdgeInsets.all(Dimensions.paddingSizeSmall),
                                    //   decoration: BoxDecoration(
                                    //     borderRadius:
                                    //     BorderRadius.circular(Dimensions.radiusSmall),
                                    //     image: DecorationImage(
                                    //         image: CachedNetworkImageProvider(
                                    //           product.photoList[0],
                                    //         ),
                                    //         fit: BoxFit.cover),
                                    //     color: Colors.white,
                                    //   ),
                                    // ),

                                  ],
                                )),
                            Expanded(
                              flex: 6,
                              child: Container(
                                margin: EdgeInsets.only(
                                    top: Dimensions.paddingSizeSmall,
                                    bottom: Dimensions.paddingSizeSmall,
                                    left: Dimensions.paddingSizeSmall,
                                    right: Dimensions.paddingSizeSmall),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 5),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                '${snapshot.data?.data![index].name}',
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: AppTextStyles.poppinsMedium
                                                    .copyWith(color: Colors.black,fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      3.heightBox,
                                      Text(
                                        '${snapshot.data?.data![index].description}',
                                        style: AppTextStyles.caption,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      3.heightBox,
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${snapshot.data?.data![index].price} ${LocaleKeys.currencyPrice.tr()}",
                                            style: AppTextStyles.poppinsRegular
                                                .copyWith(fontWeight: FontWeight.w600),
                                          ),
                                          10.widthBox,
                                          snapshot.data?.data![index].oldPrice !=
                                              snapshot.data?.data![index].price
                                              ? Text(
                                            "${snapshot.data?.data![index].oldPrice} ${LocaleKeys.currencyPrice.tr()}",
                                            style: TextStyle(
                                                color: AppPalette.lightBlack,
                                                fontFamily: Fonts.poppins,
                                                fontWeight: FontWeight.w400,
                                                fontSize: Dimensions.fontSizeLarge,
                                                textBaseline:
                                                TextBaseline.ideographic,
                                                decoration:
                                                TextDecoration.lineThrough),
                                          )
                                              : Container(),

                                        ],
                                      ),
                                      Spacer(),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '${snapshot.data?.data![index].location}',
                                            style: AppTextStyles.caption,
                                          ),
                                          Text(
                                            date,
                                            style: AppTextStyles.caption,
                                          ),
                                        ],
                                      ),
                                    ]),
                              ),
                            ),
                          ],
                        ),
                      )
                    );
                },
                separatorBuilder: (context, index) => 10.0.heightBox,
              );
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children:   [
                Text(
                  "",
                  style: AppTextStyles.poppinsRegular,
                ),
                const Center(child: CircularProgressIndicator()),
              ],
            );
          }),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    query == null ?  "" : query;
    categoryId  == null ? 'all' : categoryId;

    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
      child: FutureBuilder<MyProductUserModel?>(
          future: SearchUserService.searchUser(query,'$categoryId'),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return snapshot.data!.data!.isEmpty ?
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.paddingSizeDefault,
                    ),
                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          LocaleKeys.newRecommendations.tr(),
                          style:
                          Theme.of(context).textTheme.headline3,
                        ),
                      ],
                    ),
                  ),
                  35.heightBox,
                  Center(
                    child: SvgPicture.asset(
                        "assets/images/svg/addProduct.svg",
                        height: 150,
                        width: 150,
                        fit: BoxFit.contain),
                  ),
                ],
              ) :
              ListView.separated(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(vertical: 20.h),
                itemCount: snapshot.data!.data!.length,
                // itemExtent: 200.0,
                itemBuilder: (context, index) {
                  var dateList = snapshot.data!.data![index].createdAt?.split(' ');
                  var date = dateList![0].trim();
                  return InkWell(
                      onTap: () {
                        print('product idssssssss ${snapshot.data!.data![index].id}');
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ProductSearchDetailsScreen(productId: snapshot.data!.data![index].id,
                              product: snapshot.data!.data![index]),
                        ));
                      },
                      child: Container(
                        width: double.infinity,
                        height: 137.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                          // image: DecorationImage(
                          //     image: CachedNetworkImageProvider(
                          //       product.proPicture,
                          //     ),
                          //     fit: BoxFit.cover),
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
                        child: Row(
                          children: [
                            Expanded(
                                flex: 3,
                                child: Stack(
                                  alignment: Alignment.topLeft,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.all(Dimensions.paddingSizeSmall),
                                      decoration:  BoxDecoration(
                                        borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
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
                                        borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                                        child: CachedNetworkImage(
                                          fit: BoxFit.cover,
                                          imageUrl: '${snapshot.data?.data![index].imagesPath}${snapshot.data?.data![index].images![0].name}',
                                          placeholder: (context, url) => Image.asset('assets/images/loader.gif'),
                                          errorWidget: (context, url, error) => new Icon(Icons.error),
                                        ),
                                      ),
                                    ),
                                    // Container(
                                    //   margin: EdgeInsets.all(Dimensions.paddingSizeSmall),
                                    //   decoration:  BoxDecoration(
                                    //     borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                                    //     color: Colors.white,
                                    //   ),
                                    //   child: FadeInImage(
                                    //     image: NetworkImage(product.photoList[0]),
                                    //     fit: BoxFit.cover,
                                    //     height: 175.h,
                                    //     width: MediaQuery.of(context).size.width,
                                    //     placeholder:
                                    //     const AssetImage('assets/images/loader.gif'),
                                    //   ),
                                    // ),
                                    // Container(
                                    //   margin: EdgeInsets.all(Dimensions.paddingSizeSmall),
                                    //   decoration: BoxDecoration(
                                    //     borderRadius:
                                    //     BorderRadius.circular(Dimensions.radiusSmall),
                                    //     image: DecorationImage(
                                    //         image: CachedNetworkImageProvider(
                                    //           product.photoList[0],
                                    //         ),
                                    //         fit: BoxFit.cover),
                                    //     color: Colors.white,
                                    //   ),
                                    // ),

                                  ],
                                )),
                            Expanded(
                              flex: 6,
                              child: Container(
                                margin: EdgeInsets.only(
                                    top: Dimensions.paddingSizeSmall,
                                    bottom: Dimensions.paddingSizeSmall,
                                    left: Dimensions.paddingSizeSmall,
                                    right: Dimensions.paddingSizeSmall),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 5),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                '${snapshot.data?.data![index].name}',
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: AppTextStyles.poppinsMedium
                                                    .copyWith(color: Colors.black,fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      3.heightBox,
                                      Text(
                                        '${snapshot.data?.data![index].description}',
                                        style: AppTextStyles.caption,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      3.heightBox,
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${snapshot.data?.data![index].price} ${LocaleKeys.currencyPrice.tr()}",
                                            style: AppTextStyles.poppinsRegular
                                                .copyWith(fontWeight: FontWeight.w600),
                                          ),
                                          10.widthBox,
                                          snapshot.data?.data![index].oldPrice !=
                                              snapshot.data?.data![index].price
                                              ? Text(
                                            "${snapshot.data?.data![index].oldPrice} ${LocaleKeys.currencyPrice.tr()}",
                                            style: TextStyle(
                                                color: AppPalette.lightBlack,
                                                fontFamily: Fonts.poppins,
                                                fontWeight: FontWeight.w400,
                                                fontSize: Dimensions.fontSizeLarge,
                                                textBaseline:
                                                TextBaseline.ideographic,
                                                decoration:
                                                TextDecoration.lineThrough),
                                          )
                                              : Container(),

                                        ],
                                      ),
                                      Spacer(),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '${snapshot.data?.data![index].location}',
                                            style: AppTextStyles.caption,
                                          ),
                                          Text(
                                            date,
                                            style: AppTextStyles.caption,
                                          ),
                                        ],
                                      ),
                                    ]),
                              ),
                            ),
                          ],
                        ),
                      )
                  );
                },
                separatorBuilder: (context, index) => 10.0.heightBox,
              );
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children:   [
                Text(
                  "",
                  style: AppTextStyles.poppinsRegular,
                ),
                const Center(child: CircularProgressIndicator()),
              ],
            );
          }),
    );
  }

}