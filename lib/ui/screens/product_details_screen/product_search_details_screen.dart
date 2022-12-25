import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_launch/flutter_launch.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:readmore/readmore.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shop/data/models/show_details_product_model.dart';
import 'package:shop/helpers/call_helper.dart';
import 'package:shop/translations/locale_keys.g.dart';
import 'package:shop/ui/base/custom_button.dart';
import 'package:shop/ui/screens/my_favorite_user_screen/my_favorite_user_screen.dart';
import 'package:shop/ui/widgets/product_details_widgets/product_images_slider.dart';
import 'package:shop/utils/app_palette.dart';
import 'package:shop/utils/app_size_boxes.dart';
import 'package:shop/utils/dimensions.dart';
import 'package:shop/utils/styles.dart';
import '../../../business_logic/add_favorite_user_cubit/add_favorite_user_cubit.dart';
import '../../../business_logic/app_layout_cubit/app_layout_cubit.dart';
import '../../../business_logic/filter_cubit/filter_cubit.dart';
import '../../../business_logic/my_favorite_user_cubit/my_favorite_user_cubit.dart';
import '../../../business_logic/product_details_cubit/product_details_cubit.dart';
import '../../../business_logic/profile_cubit/profile_cubit.dart';
import '../../../business_logic/wishlist_cubit/wishlist_cubit.dart';
import '../../../business_logic/wishlist_cubit/wishlist_state.dart';
import '../../../data/internet_connectivity/error_screens_connection.dart';
import '../../../data/models/MyProductUserModel.dart';
import '../../../data/models/SearchModel.dart';
import '../../../data/models/product_model.dart';
import '../../../helpers/app_local_storage.dart';
import '../../../helpers/cache_helper.dart';
import '../../../libraries/dialog_widget.dart';
import '../../../utils/firebase_dynamic_link.dart';
import '../../widgets/My_products_widgets/add_button_widget.dart';
import '../../widgets/product_details_widgets/product_details_widget.dart';
import '../auth/login_screen.dart';
import '../layout/app_layout.dart';
import '../user_products_screen/user_products_screen.dart';

class ProductSearchDetailsScreen extends StatefulWidget {
  int? productId;
  MyProductUserResponseModel? product;

  ProductSearchDetailsScreen({Key? key, required this.productId, this.product})
      : super(key: key);

  @override
  State<ProductSearchDetailsScreen> createState() =>
      _ProductSearchDetailsScreenState();
}

class _ProductSearchDetailsScreenState
    extends State<ProductSearchDetailsScreen> {
  String? userId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<ProductDetailsCubit>(context)
        .getProductDetailsUser('${widget.product?.id}');
    AppLocalStorage.token != null
        ? BlocProvider.of<ProfileCubit>(context).getUserProfile()
        : null;
    BlocProvider.of<AppLayoutCubit>(context).checkConnectionInternet();
    userId = CacheHelper.getData(key: 'UserId');
    print('product id ${widget.productId!}');
    print('product idsss ${widget.product?.id}');
//  CustomFlutterToast(widget.product.category);
  }

  String imageUser =
      'https://img.freepik.com/free-photo/excited-man-celebrating-victory-rejoicing-making-fist-pump-gesture-winning-looking-satisfied-saying-yes-achieve-goal-standing-light-turquoise-wall_1258-23890.jpg?w=1060&t=st=1660172869~exp=1660173469~hmac=0ed5bff0eaf4351e4f8be5777ffbcc142793655b001ccf3f66e9743a45634605';
  String? lottie;

  @override
  Widget build(BuildContext context) {
    final stateProfile = context.watch<ProfileCubit>().state;
    final stateSubscribeDetails = context.watch<ProductDetailsCubit>().state;
    final stateCheckConnectionInternet = context.watch<AppLayoutCubit>().state;
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop();
        return false;
      },
      child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            iconTheme: Theme.of(context).iconTheme,
            backgroundColor: AppPalette.white,
            title: Text(
              stateCheckConnectionInternet is ConnectionSuccess ?
              stateSubscribeDetails is SuccessProductDetailsState ?
              '${stateSubscribeDetails.showDetailsProductResponseModel == null ?
              '' : stateSubscribeDetails.showDetailsProductResponseModel![0].name}' : '' : '',
              style: TextStyle(color: AppPalette.primary),
            ),
            leading: InkWell(
              onTap: () {
                if (stateCheckConnectionInternet is ConnectionSuccess) {
                  Navigator.of(context).pop();
                } else {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => AppLayout()));
                }
              },
              child: const Icon(Icons.arrow_back_ios,
                  size: 20.0, color: AppPalette.primary),
            ),
          ),
          body: stateCheckConnectionInternet is ConnectionSuccess ?
          RefreshIndicator(
            onRefresh: () async {
              BlocProvider.of<ProductDetailsCubit>(context)
                  .getProductDetailsUser('${widget.productId}');
              BlocProvider.of<ProfileCubit>(context).getUserProfile();
            },
            child: BlocConsumer<ProductDetailsCubit, ProductDetailsState>(
              listener: (context, state) {},
              builder: (context, Productstate) {
                ProductDetailsCubit productDetailsCubit =
                    ProductDetailsCubit.get(context);

                if (Productstate is SuccessProductDetailsState) {
                  productDetailsCubit.nameOfProductController.text =
                      Productstate.showDetailsProductResponseModel![0].name ??
                          '';

                  return Productstate.showDetailsProductResponseModel == null
                      ? ErrorScreenConnection()
                      : Column(
                          children: [
                            10.heightBox,
                            Expanded(
                                child: ListView(
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              children: [
                                ProductImagesSlider(
                                  images: Productstate
                                      .showDetailsProductResponseModel![0]
                                      .photoList!,
                                  phoneNumber:
                                      '${Productstate.showDetailsProductResponseModel![0].user?.phoneNumber}',
                                  productName:
                                      '${Productstate.showDetailsProductResponseModel![0].name}',
                                  whatsAppNumber:
                                      '${Productstate.showDetailsProductResponseModel![0].whatsNumber}',
                                  userId: Productstate
                                      .showDetailsProductResponseModel![0]
                                      .user!
                                      .id!,
                                ),
                                7.heightBox,
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          Dimensions.paddingSizeDefault),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '${Productstate.showDetailsProductResponseModel![0].name}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontFamily: Fonts.poppins,
                                                fontSize: 16.sp,
                                                color: AppPalette.black),
                                          ),
                                          5.widthBox,
                                          Row(
                                            children: [
                                              AddButtonWidget(
                                                child: IconButton(
                                                    color: AppPalette.primary,
                                                    onPressed: () async {
                                                      // var firebaseDynamicLinkService =
                                                      //     await FirebaseDynamicLinkService
                                                      //         .createDynamicLinkProduct2(
                                                      //             myProductUserResponseModel:
                                                      //                 widget
                                                      //                     .product);
                                                      //
                                                      // print(
                                                      //     'firebaseDynamicLinkService');
                                                      // print(
                                                      //     firebaseDynamicLinkService);
                                                      // print(widget.product?.id);
                                                      // await Share.share(
                                                      //   'go to the product \n $firebaseDynamicLinkService',
                                                      // );
                                                    },
                                                    icon: SvgPicture.asset(
                                                      "assets/images/svg/share.svg",
                                                      fit: BoxFit.scaleDown,
                                                      color: AppPalette.white,
                                                    )),
                                              ),
                                              5.widthBox,
                                              BlocBuilder<WishlistCubit,
                                                  WishlistState>(
                                                builder: (context, state) {
                                                  WishlistCubit
                                                      wishListController =
                                                      WishlistCubit.get(
                                                          context);
                                                  return InkWell(
                                                    onTap: () {
                                                      if (AppLocalStorage
                                                              .token ==
                                                          null) {
                                                        showDialog(
                                                            context: context,
                                                            builder:
                                                                (context) =>
                                                                    Dialog(
                                                                      backgroundColor:
                                                                          Colors
                                                                              .white,
                                                                      shape: RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(Dimensions.radiusDefault)),
                                                                      alignment:
                                                                          Alignment
                                                                              .bottomCenter,
                                                                      insetPadding: EdgeInsets.symmetric(
                                                                          vertical: Dimensions
                                                                              .paddingSize,
                                                                          horizontal:
                                                                              Dimensions.paddingSize),
                                                                      child:
                                                                          CustomDialogWidget(
                                                                        msgStyle:
                                                                            const TextStyle(height: 2),
                                                                        title: LocaleKeys
                                                                            .youHaveToLoginFirst
                                                                            .tr(),
                                                                        msg: LocaleKeys
                                                                            .loginAndSellBuy
                                                                            .tr(),
                                                                        titleStyle:
                                                                            const TextStyle(
                                                                          color:
                                                                              Colors.blueGrey,
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                        ),
                                                                        actions: [
                                                                          Padding(
                                                                            padding:
                                                                                EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
                                                                            child:
                                                                                IconsButton(
                                                                              onPressed: () async {
                                                                                // addProductCubit.deleteProductItem(context,productId: product.id.toString(),isSold: '0');
                                                                                Navigator.pop(context);
                                                                              },
                                                                              text: LocaleKeys.cancel.tr(),
                                                                              // color: Colors.transparent,
                                                                              shape: OutlineInputBorder(borderSide: const BorderSide(color: AppPalette.black), borderRadius: BorderRadius.circular(Dimensions.radiusDefault)),
                                                                              textStyle: const TextStyle(color: Colors.black),
                                                                              padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall, vertical: Dimensions.paddingSizeDefault),
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding:
                                                                                EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
                                                                            child:
                                                                                IconsButton(
                                                                              onPressed: () {
                                                                                //  addProductCubit.deleteProductItem(context,productId: product.id.toString(),isSold: '1');
                                                                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const LoginScreen()));
                                                                              },
                                                                              text: LocaleKeys.login.tr(),
                                                                              // iconData: Icons.done,
                                                                              color: AppPalette.primary,
                                                                              textStyle: const TextStyle(color: Colors.white),
                                                                              shape: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(Dimensions.radiusDefault)),
                                                                              padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall, vertical: Dimensions.paddingSizeDefault),
                                                                              // iconColor: Colors.white,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                        animationBuilder: lottie !=
                                                                                null
                                                                            ? LottieBuilder.asset(
                                                                                lottie.toString(),
                                                                              )
                                                                            : null,
                                                                        customView:
                                                                            Dialogs.holder,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                    ));
                                                      } else {
                                                        wishListController
                                                            .toggleWishActionFilter(
                                                                product: widget
                                                                    .product!);
                                                      }
                                                    },
                                                    child: AddButtonWidget(
                                                      child: Container(
                                                        child: AppLocalStorage
                                                                    .token ==
                                                                null
                                                            ? const Icon(
                                                                Icons
                                                                    .star_border,
                                                                color:
                                                                    AppPalette
                                                                        .white,
                                                              )
                                                            : Icon(
                                                                wishListController.wishListContain(
                                                                        productId:
                                                                            widget
                                                                                .productId!)
                                                                    ? Icons.star
                                                                    : Icons
                                                                        .star_border,
                                                                color:
                                                                    AppPalette
                                                                        .white,
                                                              ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                      3.heightBox,
                                      Row(
                                        children: [
                                          Text(
                                            "${Productstate.showDetailsProductResponseModel![0].price} ${LocaleKeys.currencyPrice.tr()}",
                                            style: AppTextStyles.poppinsRegular
                                                .copyWith(
                                                    fontWeight:
                                                        FontWeight.w600),
                                          ),
                                          10.widthBox,
                                          Productstate
                                                      .showDetailsProductResponseModel![
                                                          0]
                                                      .oldPrice !=
                                                  Productstate
                                                      .showDetailsProductResponseModel![
                                                          0]
                                                      .price
                                              ? Text(
                                                  "${Productstate.showDetailsProductResponseModel![0].oldPrice} ${LocaleKeys.currencyPrice.tr()}",
                                                  style: TextStyle(
                                                      color:
                                                          AppPalette.lightBlack,
                                                      fontFamily: Fonts.poppins,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: Dimensions
                                                          .fontSizeLarge,
                                                      textBaseline: TextBaseline
                                                          .ideographic,
                                                      decoration: TextDecoration
                                                          .lineThrough),
                                                )
                                              : Container(),
                                        ],
                                      ),
                                      10.heightBox,
                                      ReadMoreText(
                                        Productstate
                                            .showDetailsProductResponseModel![0]
                                            .description!,
                                        trimLines: 2,
                                        colorClickableText: AppPalette.primary,
                                        trimMode: TrimMode.Line,
                                        trimCollapsedText:
                                            LocaleKeys.showMore.tr(),
                                        trimExpandedText: 'Show less',
                                        style: AppTextStyles.caption,
                                      ),
                                      7.heightBox,
                                      BlocBuilder<FilterCubit, FilterState>(
                                        builder: (context, state) {
                                          FilterCubit filterCuibt =
                                              FilterCubit.get(context);
                                          return BlocConsumer<
                                              AddFavoriteUserCubit,
                                              AddFavoriteUserState>(
                                            listener:
                                                (context, stateSubscribeUser) {
                                              if (stateSubscribeUser
                                                  is AddSubscribeUserSuccessfullyState) {
                                                if (stateSubscribeDetails
                                                    is SuccessProductDetailsState) {
                                                  if (stateSubscribeDetails
                                                          .showDetailsProductResponseModel![
                                                              0]
                                                          .isSubscriber ==
                                                      true) {
                                                    AwesomeDialog(
                                                      context: context,
                                                      dialogType:
                                                          DialogType.success,
                                                      animType:
                                                          AnimType.rightSlide,
                                                      btnOkText:
                                                          LocaleKeys.ok.tr(),
                                                      btnCancelText: LocaleKeys
                                                          .cancel
                                                          .tr(),
                                                      title: LocaleKeys.success2
                                                          .tr(),
                                                      titleTextStyle:
                                                          const TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                      descTextStyle:
                                                          const TextStyle(
                                                              fontSize: 13,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300),
                                                      dismissOnTouchOutside:
                                                          false,
                                                      desc: LocaleKeys
                                                          .intentToScreenFavoriteUser
                                                          .tr(),
                                                      btnCancelOnPress: () {
                                                        Navigator.of(context)
                                                            .pushReplacement(
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            ProductSearchDetailsScreen(
                                                                              product: widget.product,
                                                                              productId: widget.productId,
                                                                            )));
                                                      },
                                                      btnOkOnPress: () {
                                                        Navigator.of(context)
                                                            .pushReplacement(
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            AppLayout()));
                                                      },
                                                    ).show();
                                                  } else if (stateSubscribeDetails
                                                          .showDetailsProductResponseModel![
                                                              0]
                                                          .isSubscriber ==
                                                      false) {
                                                    AwesomeDialog(
                                                      context: context,
                                                      dialogType:
                                                          DialogType.success,
                                                      btnOkText:
                                                          LocaleKeys.ok.tr(),
                                                      btnCancelText: LocaleKeys
                                                          .cancel
                                                          .tr(),
                                                      animType:
                                                          AnimType.rightSlide,
                                                      title: LocaleKeys.success
                                                          .tr(),
                                                      titleTextStyle:
                                                          const TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                      descTextStyle:
                                                          const TextStyle(
                                                              fontSize: 13,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300),
                                                      dismissOnTouchOutside:
                                                          false,
                                                      desc: LocaleKeys
                                                          .intentToScreenFavoriteUser
                                                          .tr(),
                                                      btnCancelOnPress: () {
                                                        Navigator.of(context)
                                                            .pushReplacement(
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            AppLayout()));
                                                      },
                                                      btnOkOnPress: () {
                                                        Navigator.of(context)
                                                            .pushReplacement(
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            AppLayout()));
                                                      },
                                                    ).show();
                                                  }
                                                }
                                              }
                                            },
                                            builder:
                                                (context, stateFavoriteUser) {
                                              AddFavoriteUserCubit
                                                  myFavoriteUserCubit =
                                                  AddFavoriteUserCubit.get(
                                                      context);
                                              return GestureDetector(
                                                onTap: () {
                                                  // print('userId $userId');
                                                  filterCuibt.getUserProducts(
                                                      '${Productstate.showDetailsProductResponseModel![0].user?.id}');
                                                  Navigator.of(context)
                                                      .push(MaterialPageRoute(
                                                    builder: (context) =>
                                                        UserProductsScreen(
                                                      intentValue:
                                                          'homeProductDetails',
                                                      showDetailsProductResponseModel:
                                                          Productstate
                                                              .showDetailsProductResponseModel![0],
                                                    ),
                                                  ));
                                                },
                                                child: Card(
                                                  color: AppPalette.white,
                                                  elevation: 2.0,
                                                  shadowColor: AppPalette.white,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15)),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10.0),
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Productstate
                                                                        .showDetailsProductResponseModel![
                                                                            0]
                                                                        .user
                                                                        ?.photo ==
                                                                    null
                                                                ? Container(
                                                                    width: 40.h,
                                                                    height:
                                                                        42.h,
                                                                    decoration: BoxDecoration(
                                                                        image: DecorationImage(
                                                                            image: CachedNetworkImageProvider(
                                                                                imageUser),
                                                                            fit: BoxFit
                                                                                .cover),
                                                                        borderRadius:
                                                                            BorderRadius.circular(Dimensions.radiusSmall)),
                                                                  )
                                                                : Container(
                                                                    width: 40.h,
                                                                    height:
                                                                        42.h,
                                                                    decoration: BoxDecoration(
                                                                        image: DecorationImage(
                                                                            image: CachedNetworkImageProvider('${Productstate.showDetailsProductResponseModel![0].user?.userImagePath}/'
                                                                                '${Productstate.showDetailsProductResponseModel![0].user?.photo}'),
                                                                            fit: BoxFit.cover),
                                                                        borderRadius: BorderRadius.circular(Dimensions.radiusSmall)),
                                                                  ),
                                                            8.widthBox,
                                                            Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                2.heightBox,
                                                                Text(
                                                                  '${Productstate.showDetailsProductResponseModel![0].user?.firstName}'
                                                                  ' ${Productstate.showDetailsProductResponseModel![0].user?.lastName}',
                                                                  style: const TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                                4.heightBox,
                                                                Row(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    const Icon(
                                                                      Icons
                                                                          .star,
                                                                      color: AppPalette
                                                                          .gold,
                                                                      size: 20,
                                                                    ),
                                                                    5.widthBox,
                                                                    Text(
                                                                      Productstate
                                                                          .showDetailsProductResponseModel![
                                                                              0]
                                                                          .rate
                                                                          .toString(),
                                                                      style: const TextStyle(
                                                                          color:
                                                                              AppPalette.grey),
                                                                    )
                                                                  ],
                                                                ),
                                                                // Spacer(),
                                                              ],
                                                            ),
                                                            const Spacer(),
                                                            AppLocalStorage
                                                                        .token !=
                                                                    null
                                                                ? stateProfile
                                                                        is SuccessProfileState
                                                                    ? stateProfile.userDataModel!.user!.id ==
                                                                            Productstate.showDetailsProductResponseModel![0].user!.id
                                                                        ? Container()
                                                                        : Row(
                                                                            children: [
                                                                              Card(
                                                                                shadowColor: AppPalette.white,
                                                                                elevation: 2.0,
                                                                                color: AppPalette.white,
                                                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                                                                child: Container(
                                                                                    width: 40.h,
                                                                                    height: 40.h,
                                                                                    child: Center(
                                                                                        child: IconButton(
                                                                                            color: AppPalette.white,
                                                                                            onPressed: () async {
                                                                                              if (AppLocalStorage.token == null) {
                                                                                                showDialog(
                                                                                                    context: context,
                                                                                                    builder: (context) => Dialog(
                                                                                                          backgroundColor: Colors.white,
                                                                                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.radiusDefault)),
                                                                                                          alignment: Alignment.bottomCenter,
                                                                                                          insetPadding: EdgeInsets.symmetric(vertical: Dimensions.paddingSize, horizontal: Dimensions.paddingSize),
                                                                                                          child: CustomDialogWidget(
                                                                                                            msgStyle: const TextStyle(height: 2),
                                                                                                            title: LocaleKeys.youHaveToLoginFirst.tr(),
                                                                                                            msg: LocaleKeys.loginAndSellBuy.tr(),
                                                                                                            titleStyle: const TextStyle(
                                                                                                              color: Colors.blueGrey,
                                                                                                              overflow: TextOverflow.ellipsis,
                                                                                                            ),
                                                                                                            actions: [
                                                                                                              Padding(
                                                                                                                padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
                                                                                                                child: IconsButton(
                                                                                                                  onPressed: () async {
                                                                                                                    // addProductCubit.deleteProductItem(context,productId: product.id.toString(),isSold: '0');
                                                                                                                    Navigator.pop(context);
                                                                                                                  },
                                                                                                                  text: LocaleKeys.cancel.tr(),
                                                                                                                  // color: Colors.transparent,
                                                                                                                  shape: OutlineInputBorder(borderSide: const BorderSide(color: AppPalette.black), borderRadius: BorderRadius.circular(Dimensions.radiusDefault)),
                                                                                                                  textStyle: const TextStyle(color: Colors.black),
                                                                                                                  padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall, vertical: Dimensions.paddingSizeDefault),
                                                                                                                ),
                                                                                                              ),
                                                                                                              Padding(
                                                                                                                padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
                                                                                                                child: IconsButton(
                                                                                                                  onPressed: () {
                                                                                                                    //  addProductCubit.deleteProductItem(context,productId: product.id.toString(),isSold: '1');
                                                                                                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const LoginScreen()));
                                                                                                                  },
                                                                                                                  text: LocaleKeys.login.tr(),
                                                                                                                  // iconData: Icons.done,
                                                                                                                  color: AppPalette.primary,
                                                                                                                  textStyle: const TextStyle(color: Colors.white),
                                                                                                                  shape: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(Dimensions.radiusDefault)),
                                                                                                                  padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall, vertical: Dimensions.paddingSizeDefault),
                                                                                                                  // iconColor: Colors.white,
                                                                                                                ),
                                                                                                              ),
                                                                                                            ],
                                                                                                            animationBuilder: lottie != null
                                                                                                                ? LottieBuilder.asset(
                                                                                                                    lottie.toString(),
                                                                                                                  )
                                                                                                                : null,
                                                                                                            customView: Dialogs.holder,
                                                                                                            color: Colors.white,
                                                                                                          ),
                                                                                                        ));
                                                                                              } else {
                                                                                                if (stateSubscribeDetails is SuccessProductDetailsState) {
                                                                                                  if (stateSubscribeDetails.showDetailsProductResponseModel![0].isSubscriber == true) {
                                                                                                    myFavoriteUserCubit.deleteSubscribeUser(Productstate.showDetailsProductResponseModel![0].user!.id.toString());
                                                                                                  } else if (stateSubscribeDetails.showDetailsProductResponseModel![0].isSubscriber == false) {
                                                                                                    myFavoriteUserCubit.addSubscribeUser(Productstate.showDetailsProductResponseModel![0].user!.id.toString());
                                                                                                  }
                                                                                                }
                                                                                              }
                                                                                            },
                                                                                            icon: stateSubscribeDetails is SuccessProductDetailsState
                                                                                                ? stateSubscribeDetails.showDetailsProductResponseModel![0].isSubscriber == true
                                                                                                    ? const Icon(
                                                                                                        Icons.favorite,
                                                                                                        color: AppPalette.primary,
                                                                                                      )
                                                                                                    : stateSubscribeDetails.showDetailsProductResponseModel![0].isSubscriber == false
                                                                                                        ? const Icon(
                                                                                                            Icons.favorite_border,
                                                                                                            color: AppPalette.primary,
                                                                                                          )
                                                                                                        : const Icon(Icons.abc_sharp)
                                                                                                : const Icon(Icons.abc_sharp)))),
                                                                              ),
                                                                            ],
                                                                          )
                                                                    : Container()
                                                                : Row(
                                                                    children: [
                                                                      Card(
                                                                        shadowColor:
                                                                            AppPalette.white,
                                                                        elevation:
                                                                            2.0,
                                                                        color: AppPalette
                                                                            .white,
                                                                        shape: RoundedRectangleBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(10)),
                                                                        child: Container(
                                                                            width: 40.h,
                                                                            height: 40.h,
                                                                            child: Center(
                                                                                child: IconButton(
                                                                                    color: AppPalette.white,
                                                                                    onPressed: () async {
                                                                                      if (AppLocalStorage.token == null) {
                                                                                        showDialog(
                                                                                            context: context,
                                                                                            builder: (context) => Dialog(
                                                                                                  backgroundColor: Colors.white,
                                                                                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.radiusDefault)),
                                                                                                  alignment: Alignment.bottomCenter,
                                                                                                  insetPadding: EdgeInsets.symmetric(vertical: Dimensions.paddingSize, horizontal: Dimensions.paddingSize),
                                                                                                  child: CustomDialogWidget(
                                                                                                    msgStyle: const TextStyle(height: 2),
                                                                                                    title: LocaleKeys.youHaveToLoginFirst.tr(),
                                                                                                    msg: LocaleKeys.loginAndSellBuy.tr(),
                                                                                                    titleStyle: const TextStyle(
                                                                                                      color: Colors.blueGrey,
                                                                                                      overflow: TextOverflow.ellipsis,
                                                                                                    ),
                                                                                                    actions: [
                                                                                                      Padding(
                                                                                                        padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
                                                                                                        child: IconsButton(
                                                                                                          onPressed: () async {
                                                                                                            // addProductCubit.deleteProductItem(context,productId: product.id.toString(),isSold: '0');
                                                                                                            Navigator.pop(context);
                                                                                                          },
                                                                                                          text: LocaleKeys.cancel.tr(),
                                                                                                          // color: Colors.transparent,
                                                                                                          shape: OutlineInputBorder(borderSide: const BorderSide(color: AppPalette.black), borderRadius: BorderRadius.circular(Dimensions.radiusDefault)),
                                                                                                          textStyle: const TextStyle(color: Colors.black),
                                                                                                          padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall, vertical: Dimensions.paddingSizeDefault),
                                                                                                        ),
                                                                                                      ),
                                                                                                      Padding(
                                                                                                        padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
                                                                                                        child: IconsButton(
                                                                                                          onPressed: () {
                                                                                                            //  addProductCubit.deleteProductItem(context,productId: product.id.toString(),isSold: '1');
                                                                                                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const LoginScreen()));
                                                                                                          },
                                                                                                          text: LocaleKeys.login.tr(),
                                                                                                          // iconData: Icons.done,
                                                                                                          color: AppPalette.primary,
                                                                                                          textStyle: const TextStyle(color: Colors.white),
                                                                                                          shape: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(Dimensions.radiusDefault)),
                                                                                                          padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall, vertical: Dimensions.paddingSizeDefault),
                                                                                                          // iconColor: Colors.white,
                                                                                                        ),
                                                                                                      ),
                                                                                                    ],
                                                                                                    animationBuilder: lottie != null
                                                                                                        ? LottieBuilder.asset(
                                                                                                            lottie.toString(),
                                                                                                          )
                                                                                                        : null,
                                                                                                    customView: Dialogs.holder,
                                                                                                    color: Colors.white,
                                                                                                  ),
                                                                                                ));
                                                                                      } else {
                                                                                        if (stateSubscribeDetails is SuccessProductDetailsState) {
                                                                                          if (stateSubscribeDetails.showDetailsProductResponseModel![0].isSubscriber == true) {
                                                                                            myFavoriteUserCubit.deleteSubscribeUser(Productstate.showDetailsProductResponseModel![0].user!.id.toString());
                                                                                          } else if (stateSubscribeDetails.showDetailsProductResponseModel![0].isSubscriber == false) {
                                                                                            myFavoriteUserCubit.addSubscribeUser(Productstate.showDetailsProductResponseModel![0].user!.id.toString());
                                                                                          }
                                                                                        }
                                                                                      }
                                                                                    },
                                                                                    icon: stateSubscribeDetails is SuccessProductDetailsState
                                                                                        ? stateSubscribeDetails.showDetailsProductResponseModel![0].isSubscriber == true
                                                                                            ? const Icon(
                                                                                                Icons.favorite,
                                                                                                color: AppPalette.primary,
                                                                                              )
                                                                                            : stateSubscribeDetails.showDetailsProductResponseModel![0].isSubscriber == false
                                                                                                ? const Icon(
                                                                                                    Icons.favorite_border,
                                                                                                    color: AppPalette.primary,
                                                                                                  )
                                                                                                : const Icon(Icons.abc_sharp)
                                                                                        : const Icon(Icons.abc_sharp)))),
                                                                      ),
                                                                    ],
                                                                  ),
                                                          ],
                                                        ),
                                                        5.heightBox,
                                                        stateFavoriteUser
                                                                is AddSubscribeUserLoadingState
                                                            ? const Center(
                                                                child: SizedBox(
                                                                    width: 25,
                                                                    height: 25,
                                                                    child:
                                                                        CircularProgressIndicator(
                                                                      color: AppPalette
                                                                          .primary,
                                                                    )))
                                                            : Container(),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        },
                                      ),
                                      20.heightBox,
                                      // Text(
                                      //   Productstate
                                      //       .showDetailsProductResponseModel![0].name!,
                                      //   style: AppTextStyles.poppinsMedium
                                      //       .copyWith(color: Colors.black),
                                      // ),
                                      // InputTextFormField(
                                      //   hintText: LocaleKeys.nameOfProduct.tr(),
                                      //   textEditingController: productDetailsCubit.nameOfProductController,
                                      //   validator: (val) {
                                      //     if (val.isEmpty) {
                                      //       return LocaleKeys.mustNotEmpty.tr();
                                      //     } else {
                                      //       return null;
                                      //     }
                                      //   },
                                      // ),
                                      Column(
                                        children: [
                                          ProductDetailsWidget(
                                              title: LocaleKeys.category.tr(),
                                              subtitle: context.locale.languageCode
                                                      .contains("en")
                                                  ? Productstate
                                                          .showDetailsProductResponseModel![
                                                              0]
                                                          .category
                                                          ?.name
                                                          ?.en! ??
                                                      ''
                                                  : context.locale.languageCode
                                                          .contains("ar")
                                                      ? Productstate
                                                              .showDetailsProductResponseModel![
                                                                  0]
                                                              .category
                                                              ?.name
                                                              ?.ar! ??
                                                          ' '
                                                      : context.locale.languageCode
                                                              .contains("tr")
                                                          ? Productstate
                                                                  .showDetailsProductResponseModel![
                                                                      0]
                                                                  .category
                                                                  ?.name
                                                                  ?.tr! ??
                                                              ' '
                                                          : context.locale
                                                                  .languageCode
                                                                  .contains("de")
                                                              ? Productstate.showDetailsProductResponseModel![0].category?.name?.de! ?? ' '
                                                              : " "),
                                          const Divider(color: AppPalette.grey),
                                          ProductDetailsWidget(
                                              title:
                                                  LocaleKeys.subCategory.tr(),
                                              subtitle: context.locale.languageCode
                                                      .contains("en")
                                                  ? Productstate
                                                          .showDetailsProductResponseModel![
                                                              0]
                                                          .subcategory
                                                          ?.name
                                                          ?.en! ??
                                                      ''
                                                  : context.locale.languageCode
                                                          .contains("ar")
                                                      ? Productstate
                                                              .showDetailsProductResponseModel![
                                                                  0]
                                                              .subcategory
                                                              ?.name
                                                              ?.ar! ??
                                                          ' '
                                                      : context.locale
                                                              .languageCode
                                                              .contains("tr")
                                                          ? Productstate
                                                                  .showDetailsProductResponseModel![0]
                                                                  .subcategory
                                                                  ?.name
                                                                  ?.tr! ??
                                                              ' '
                                                          : context.locale.languageCode.contains("de")
                                                              ? Productstate.showDetailsProductResponseModel![0].subcategory?.name?.de! ?? ' '
                                                              : " "),
                                          const Divider(color: AppPalette.grey),
                                          Productstate.showDetailsProductResponseModel![0].brand?.name?.en! !=
                                                  ''
                                              ? ProductDetailsWidget(
                                                  title: LocaleKeys.brand.tr(),
                                                  subtitle: context.locale.languageCode
                                                          .contains("en")
                                                      ? Productstate
                                                              .showDetailsProductResponseModel![
                                                                  0]
                                                              .brand
                                                              ?.name
                                                              ?.en! ??
                                                          ''
                                                      : context.locale.languageCode
                                                              .contains("ar")
                                                          ? Productstate
                                                                  .showDetailsProductResponseModel![
                                                                      0]
                                                                  .brand
                                                                  ?.name
                                                                  ?.ar! ??
                                                              ''
                                                          : context.locale
                                                                  .languageCode
                                                                  .contains(
                                                                      "tr")
                                                              ? Productstate
                                                                      .showDetailsProductResponseModel![0]
                                                                      .brand
                                                                      ?.name
                                                                      ?.tr! ??
                                                                  ''
                                                              : context.locale.languageCode.contains("de")
                                                                  ? Productstate.showDetailsProductResponseModel![0].brand?.name?.de! ?? ''
                                                                  : " ")
                                              : Container(),
                                          Productstate
                                                      .showDetailsProductResponseModel![
                                                          0]
                                                      .brand
                                                      ?.name
                                                      ?.en! !=
                                                  ''
                                              ? const Divider(
                                                  color: AppPalette.grey)
                                              : Container(),
                                          ProductDetailsWidget(
                                              title: LocaleKeys.location.tr(),
                                              subtitle: Productstate
                                                  .showDetailsProductResponseModel![
                                                      0]
                                                  .location!),
                                          const Divider(color: AppPalette.grey),
                                          Productstate
                                                  .showDetailsProductResponseModel![
                                                      0]
                                                  .category!
                                                  .name!
                                                  .en!
                                                  .contains('Properties')
                                              ? Container()
                                              : Column(
                                                  children: [
                                                    ProductDetailsWidget(
                                                        title: LocaleKeys.status
                                                            .tr(),
                                                        subtitle: Productstate
                                                                    .showDetailsProductResponseModel![
                                                                        0]
                                                                    .status! ==
                                                                1
                                                            ? LocaleKeys.newProd
                                                                .tr()
                                                            : LocaleKeys.used
                                                                .tr()),
                                                    const Divider(
                                                        color: AppPalette.grey),
                                                  ],
                                                ),
                                          Productstate
                                                  .showDetailsProductResponseModel![
                                                      0]
                                                  .category!
                                                  .name!
                                                  .en!
                                                  .contains('Vehicles')
                                              ? CustomOptionListItemVehicles(
                                                  showDetailsProductResponseModel:
                                                      Productstate
                                                          .showDetailsProductResponseModel![0],
                                                )
                                              : Container(),
                                          Productstate
                                                  .showDetailsProductResponseModel![
                                                      0]
                                                  .category!
                                                  .name!
                                                  .en!
                                                  .contains('Properties')
                                              ? CustomOptionListItemProperties(
                                                  showDetailsProductResponseModel:
                                                      Productstate
                                                          .showDetailsProductResponseModel![0],
                                                )
                                              : Container(),
                                          Productstate
                                                  .showDetailsProductResponseModel![
                                                      0]
                                                  .category!
                                                  .name!
                                                  .en!
                                                  .contains('Fashion')
                                              ? CustomOptionListItemFashion(
                                                  showDetailsProductResponseModel:
                                                      Productstate
                                                          .showDetailsProductResponseModel![0],
                                                )
                                              : Container(),
                                          Productstate
                                                  .showDetailsProductResponseModel![
                                                      0]
                                                  .category!
                                                  .name!
                                                  .en!
                                                  .contains('Home Furniture')
                                              ? CustomOptionListItemFashion(
                                                  showDetailsProductResponseModel:
                                                      Productstate
                                                          .showDetailsProductResponseModel![0],
                                                )
                                              : Container(),
                                          Productstate
                                                  .showDetailsProductResponseModel![
                                                      0]
                                                  .category!
                                                  .name!
                                                  .en!
                                                  .contains('Kids & Babies')
                                              ? CustomOptionListItemFashion(
                                                  showDetailsProductResponseModel:
                                                      Productstate
                                                          .showDetailsProductResponseModel![0],
                                                )
                                              : Container(),
                                          Productstate
                                                  .showDetailsProductResponseModel![
                                                      0]
                                                  .category!
                                                  .name!
                                                  .en!
                                                  .contains(
                                                      'Books, Sports & Hobbies')
                                              ? CustomOptionListItemFashion(
                                                  showDetailsProductResponseModel:
                                                      Productstate
                                                          .showDetailsProductResponseModel![0],
                                                )
                                              : Container(),
                                          Productstate
                                                  .showDetailsProductResponseModel![
                                                      0]
                                                  .category!
                                                  .name!
                                                  .en!
                                                  .contains(
                                                      'Business - Industrial - Agriculture')
                                              ? CustomOptionListItemFashion(
                                                  showDetailsProductResponseModel:
                                                      Productstate
                                                          .showDetailsProductResponseModel![0],
                                                )
                                              : Container(),
                                          Productstate
                                                  .showDetailsProductResponseModel![
                                                      0]
                                                  .category!
                                                  .name!
                                                  .en!
                                                  .contains('Electronics')
                                              ? CustomOptionListItemFashion(
                                                  showDetailsProductResponseModel:
                                                      Productstate
                                                          .showDetailsProductResponseModel![0],
                                                )
                                              : Container(),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )),
                            5.heightBox,
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: Dimensions.paddingSizeDefault,
                                  vertical: Dimensions.paddingSizeLarge),
                              child: Column(
                                children: [
                                  AppLocalStorage.token != null
                                      ? stateProfile is SuccessProfileState
                                          ? stateProfile.userDataModel!.user!
                                                      .id ==
                                                  Productstate
                                                      .showDetailsProductResponseModel![
                                                          0]
                                                      .user!
                                                      .id
                                              ? Container()
                                              : Row(
                                                  children: [
                                                    Expanded(
                                                      child: CustomButton(
                                                        buttonText: LocaleKeys
                                                            .call
                                                            .tr(),
                                                        onPressed: () async {
                                                          if (AppLocalStorage
                                                                  .token ==
                                                              null) {
                                                            showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) =>
                                                                        Dialog(
                                                                          backgroundColor:
                                                                              Colors.white,
                                                                          shape:
                                                                              RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.radiusDefault)),
                                                                          alignment:
                                                                              Alignment.bottomCenter,
                                                                          insetPadding: EdgeInsets.symmetric(
                                                                              vertical: Dimensions.paddingSize,
                                                                              horizontal: Dimensions.paddingSize),
                                                                          child:
                                                                              CustomDialogWidget(
                                                                            msgStyle:
                                                                                const TextStyle(height: 2),
                                                                            title:
                                                                                LocaleKeys.youHaveToLoginFirst.tr(),
                                                                            msg:
                                                                                LocaleKeys.loginAndSellBuy.tr(),
                                                                            titleStyle:
                                                                                const TextStyle(
                                                                              color: Colors.blueGrey,
                                                                              overflow: TextOverflow.ellipsis,
                                                                            ),
                                                                            actions: [
                                                                              Padding(
                                                                                padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
                                                                                child: IconsButton(
                                                                                  onPressed: () async {
                                                                                    // addProductCubit.deleteProductItem(context,productId: product.id.toString(),isSold: '0');
                                                                                    Navigator.pop(context);
                                                                                  },
                                                                                  text: LocaleKeys.cancel.tr(),
                                                                                  // color: Colors.transparent,
                                                                                  shape: OutlineInputBorder(borderSide: const BorderSide(color: AppPalette.black), borderRadius: BorderRadius.circular(Dimensions.radiusDefault)),
                                                                                  textStyle: const TextStyle(color: Colors.black),
                                                                                  padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall, vertical: Dimensions.paddingSizeDefault),
                                                                                ),
                                                                              ),
                                                                              Padding(
                                                                                padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
                                                                                child: IconsButton(
                                                                                  onPressed: () {
                                                                                    //  addProductCubit.deleteProductItem(context,productId: product.id.toString(),isSold: '1');
                                                                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const LoginScreen()));
                                                                                  },
                                                                                  text: LocaleKeys.login.tr(),
                                                                                  // iconData: Icons.done,
                                                                                  color: AppPalette.primary,
                                                                                  textStyle: const TextStyle(color: Colors.white),
                                                                                  shape: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(Dimensions.radiusDefault)),
                                                                                  padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall, vertical: Dimensions.paddingSizeDefault),
                                                                                  // iconColor: Colors.white,
                                                                                ),
                                                                              ),
                                                                            ],
                                                                            animationBuilder: lottie != null
                                                                                ? LottieBuilder.asset(
                                                                                    lottie.toString(),
                                                                                  )
                                                                                : null,
                                                                            customView:
                                                                                Dialogs.holder,
                                                                            color:
                                                                                Colors.white,
                                                                          ),
                                                                        ));
                                                          } else {
                                                            await callNumber(
                                                                phoneNumber:
                                                                    '${Productstate.showDetailsProductResponseModel![0].user?.phoneNumber}');
                                                          }
                                                        },
                                                        svgIcon:
                                                            "assets/images/svg/phoneCall.svg",
                                                        height: 42.h,
                                                        fontSize: Dimensions
                                                            .fontSizeLarge,
                                                      ),
                                                    ),
                                                    10.widthBox,
                                                    Productstate
                                                                .showDetailsProductResponseModel![
                                                                    0]
                                                                .whatsNumber !=
                                                            null
                                                        ? Expanded(
                                                            child: CustomButton(
                                                              buttonText:
                                                                  LocaleKeys
                                                                      .whatsApp
                                                                      .tr(),
                                                              onPressed:
                                                                  () async {
                                                                if (AppLocalStorage
                                                                        .token ==
                                                                    null) {
                                                                  showDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (context) =>
                                                                              Dialog(
                                                                                backgroundColor: Colors.white,
                                                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.radiusDefault)),
                                                                                alignment: Alignment.bottomCenter,
                                                                                insetPadding: EdgeInsets.symmetric(vertical: Dimensions.paddingSize, horizontal: Dimensions.paddingSize),
                                                                                child: CustomDialogWidget(
                                                                                  msgStyle: const TextStyle(height: 2),
                                                                                  title: LocaleKeys.youHaveToLoginFirst.tr(),
                                                                                  msg: LocaleKeys.loginAndSellBuy.tr(),
                                                                                  titleStyle: const TextStyle(
                                                                                    color: Colors.blueGrey,
                                                                                    overflow: TextOverflow.ellipsis,
                                                                                  ),
                                                                                  actions: [
                                                                                    Padding(
                                                                                      padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
                                                                                      child: IconsButton(
                                                                                        onPressed: () async {
                                                                                          // addProductCubit.deleteProductItem(context,productId: product.id.toString(),isSold: '0');
                                                                                          Navigator.pop(context);
                                                                                        },
                                                                                        text: LocaleKeys.cancel.tr(),
                                                                                        // color: Colors.transparent,
                                                                                        shape: OutlineInputBorder(borderSide: const BorderSide(color: AppPalette.black), borderRadius: BorderRadius.circular(Dimensions.radiusDefault)),
                                                                                        textStyle: const TextStyle(color: Colors.black),
                                                                                        padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall, vertical: Dimensions.paddingSizeDefault),
                                                                                      ),
                                                                                    ),
                                                                                    Padding(
                                                                                      padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
                                                                                      child: IconsButton(
                                                                                        onPressed: () {
                                                                                          //  addProductCubit.deleteProductItem(context,productId: product.id.toString(),isSold: '1');
                                                                                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const LoginScreen()));
                                                                                        },
                                                                                        text: LocaleKeys.login.tr(),
                                                                                        // iconData: Icons.done,
                                                                                        color: AppPalette.primary,
                                                                                        textStyle: const TextStyle(color: Colors.white),
                                                                                        shape: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(Dimensions.radiusDefault)),
                                                                                        padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall, vertical: Dimensions.paddingSizeDefault),
                                                                                        // iconColor: Colors.white,
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                  animationBuilder: lottie != null
                                                                                      ? LottieBuilder.asset(
                                                                                          lottie.toString(),
                                                                                        )
                                                                                      : null,
                                                                                  customView: Dialogs.holder,
                                                                                  color: Colors.white,
                                                                                ),
                                                                              ));
                                                                } else {
                                                                  bool
                                                                      whatsapp =
                                                                      await FlutterLaunch.hasApp(
                                                                          name:
                                                                              "whatsapp");

                                                                  if (whatsapp) {
                                                                    await FlutterLaunch.launchWhatsapp(
                                                                        phone:
                                                                            '${Productstate.showDetailsProductResponseModel![0].whatsNumber}',
                                                                        message:
                                                                            '');
                                                                  } else {
                                                                    print(
                                                                        "Whatsapp não instalado");
                                                                  }
                                                                }
                                                              },
                                                              svgIcon:
                                                                  "assets/images/svg/icon_whatsapp.svg",
                                                              height: 42.h,
                                                              fontSize: Dimensions
                                                                  .fontSizeLarge,
                                                            ),
                                                          )
                                                        : Container(),
                                                  ],
                                                )
                                          : Container()
                                      : Row(
                                          children: [
                                            Expanded(
                                              child: CustomButton(
                                                buttonText:
                                                    LocaleKeys.call.tr(),
                                                onPressed: () async {
                                                  if (AppLocalStorage.token ==
                                                      null) {
                                                    showDialog(
                                                        context: context,
                                                        builder:
                                                            (context) => Dialog(
                                                                  backgroundColor:
                                                                      Colors
                                                                          .white,
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              Dimensions.radiusDefault)),
                                                                  alignment:
                                                                      Alignment
                                                                          .bottomCenter,
                                                                  insetPadding: EdgeInsets.symmetric(
                                                                      vertical:
                                                                          Dimensions
                                                                              .paddingSize,
                                                                      horizontal:
                                                                          Dimensions
                                                                              .paddingSize),
                                                                  child:
                                                                      CustomDialogWidget(
                                                                    msgStyle: const TextStyle(
                                                                        height:
                                                                            2),
                                                                    title: LocaleKeys
                                                                        .youHaveToLoginFirst
                                                                        .tr(),
                                                                    msg: LocaleKeys
                                                                        .loginAndSellBuy
                                                                        .tr(),
                                                                    titleStyle:
                                                                        const TextStyle(
                                                                      color: Colors
                                                                          .blueGrey,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                    ),
                                                                    actions: [
                                                                      Padding(
                                                                        padding:
                                                                            EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
                                                                        child:
                                                                            IconsButton(
                                                                          onPressed:
                                                                              () async {
                                                                            // addProductCubit.deleteProductItem(context,productId: product.id.toString(),isSold: '0');
                                                                            Navigator.pop(context);
                                                                          },
                                                                          text: LocaleKeys
                                                                              .cancel
                                                                              .tr(),
                                                                          // color: Colors.transparent,
                                                                          shape: OutlineInputBorder(
                                                                              borderSide: const BorderSide(color: AppPalette.black),
                                                                              borderRadius: BorderRadius.circular(Dimensions.radiusDefault)),
                                                                          textStyle:
                                                                              const TextStyle(color: Colors.black),
                                                                          padding: EdgeInsets.symmetric(
                                                                              horizontal: Dimensions.paddingSizeExtraSmall,
                                                                              vertical: Dimensions.paddingSizeDefault),
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding:
                                                                            EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
                                                                        child:
                                                                            IconsButton(
                                                                          onPressed:
                                                                              () {
                                                                            //  addProductCubit.deleteProductItem(context,productId: product.id.toString(),isSold: '1');
                                                                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const LoginScreen()));
                                                                          },
                                                                          text: LocaleKeys
                                                                              .login
                                                                              .tr(),
                                                                          // iconData: Icons.done,
                                                                          color:
                                                                              AppPalette.primary,
                                                                          textStyle:
                                                                              const TextStyle(color: Colors.white),
                                                                          shape: OutlineInputBorder(
                                                                              borderSide: BorderSide.none,
                                                                              borderRadius: BorderRadius.circular(Dimensions.radiusDefault)),
                                                                          padding: EdgeInsets.symmetric(
                                                                              horizontal: Dimensions.paddingSizeExtraSmall,
                                                                              vertical: Dimensions.paddingSizeDefault),
                                                                          // iconColor: Colors.white,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                    animationBuilder: lottie !=
                                                                            null
                                                                        ? LottieBuilder
                                                                            .asset(
                                                                            lottie.toString(),
                                                                          )
                                                                        : null,
                                                                    customView:
                                                                        Dialogs
                                                                            .holder,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                ));
                                                  } else {
                                                    await callNumber(
                                                        phoneNumber:
                                                            '${Productstate.showDetailsProductResponseModel![0].user?.phoneNumber}');
                                                  }
                                                },
                                                svgIcon:
                                                    "assets/images/svg/phoneCall.svg",
                                                height: 42.h,
                                                fontSize:
                                                    Dimensions.fontSizeLarge,
                                              ),
                                            ),
                                            10.widthBox,
                                            Productstate
                                                        .showDetailsProductResponseModel![
                                                            0]
                                                        .whatsNumber !=
                                                    null
                                                ? Expanded(
                                                    child: CustomButton(
                                                      buttonText: LocaleKeys
                                                          .whatsApp
                                                          .tr(),
                                                      onPressed: () async {
                                                        if (AppLocalStorage
                                                                .token ==
                                                            null) {
                                                          showDialog(
                                                              context: context,
                                                              builder:
                                                                  (context) =>
                                                                      Dialog(
                                                                        backgroundColor:
                                                                            Colors.white,
                                                                        shape: RoundedRectangleBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(Dimensions.radiusDefault)),
                                                                        alignment:
                                                                            Alignment.bottomCenter,
                                                                        insetPadding: EdgeInsets.symmetric(
                                                                            vertical:
                                                                                Dimensions.paddingSize,
                                                                            horizontal: Dimensions.paddingSize),
                                                                        child:
                                                                            CustomDialogWidget(
                                                                          msgStyle:
                                                                              const TextStyle(height: 2),
                                                                          title: LocaleKeys
                                                                              .youHaveToLoginFirst
                                                                              .tr(),
                                                                          msg: LocaleKeys
                                                                              .loginAndSellBuy
                                                                              .tr(),
                                                                          titleStyle:
                                                                              const TextStyle(
                                                                            color:
                                                                                Colors.blueGrey,
                                                                            overflow:
                                                                                TextOverflow.ellipsis,
                                                                          ),
                                                                          actions: [
                                                                            Padding(
                                                                              padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
                                                                              child: IconsButton(
                                                                                onPressed: () async {
                                                                                  // addProductCubit.deleteProductItem(context,productId: product.id.toString(),isSold: '0');
                                                                                  Navigator.pop(context);
                                                                                },
                                                                                text: LocaleKeys.cancel.tr(),
                                                                                // color: Colors.transparent,
                                                                                shape: OutlineInputBorder(borderSide: const BorderSide(color: AppPalette.black), borderRadius: BorderRadius.circular(Dimensions.radiusDefault)),
                                                                                textStyle: const TextStyle(color: Colors.black),
                                                                                padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall, vertical: Dimensions.paddingSizeDefault),
                                                                              ),
                                                                            ),
                                                                            Padding(
                                                                              padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
                                                                              child: IconsButton(
                                                                                onPressed: () {
                                                                                  //  addProductCubit.deleteProductItem(context,productId: product.id.toString(),isSold: '1');
                                                                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const LoginScreen()));
                                                                                },
                                                                                text: LocaleKeys.login.tr(),
                                                                                // iconData: Icons.done,
                                                                                color: AppPalette.primary,
                                                                                textStyle: const TextStyle(color: Colors.white),
                                                                                shape: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(Dimensions.radiusDefault)),
                                                                                padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall, vertical: Dimensions.paddingSizeDefault),
                                                                                // iconColor: Colors.white,
                                                                              ),
                                                                            ),
                                                                          ],
                                                                          animationBuilder: lottie != null
                                                                              ? LottieBuilder.asset(
                                                                                  lottie.toString(),
                                                                                )
                                                                              : null,
                                                                          customView:
                                                                              Dialogs.holder,
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                      ));
                                                        } else {
                                                          bool whatsapp =
                                                              await FlutterLaunch
                                                                  .hasApp(
                                                                      name:
                                                                          "whatsapp");

                                                          if (whatsapp) {
                                                            await FlutterLaunch
                                                                .launchWhatsapp(
                                                                    phone:
                                                                        '${Productstate.showDetailsProductResponseModel![0].whatsNumber}',
                                                                    message:
                                                                        '');
                                                          } else {
                                                            print(
                                                                "Whatsapp não instalado");
                                                          }
                                                        }
                                                      },
                                                      svgIcon:
                                                          "assets/images/svg/icon_whatsapp.svg",
                                                      height: 42.h,
                                                      fontSize: Dimensions
                                                          .fontSizeLarge,
                                                    ),
                                                  )
                                                : Container(),
                                          ],
                                        ),
                                ],
                              ),
                            ),
                          ],
                        );
                }
                else if (Productstate is ErrorProductDetailsState) {
                  return ErrorScreenConnection(onPressed: (){
                    BlocProvider.of<ProductDetailsCubit>(context)
                        .getProductDetailsUser('${widget.productId}');
                  } ,);
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ) :
          ErrorScreenConnection(onPressed: (){
            if(widget.product?.id == null){
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => AppLayout()));
            }else {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => AppLayout()));
            }
          } ,)),
    );
  }
}

class CustomOptionListItemFashion extends StatelessWidget {
  CustomOptionListItemFashion(
      {Key? key, required this.showDetailsProductResponseModel})
      : super(key: key);
  ShowDetailsProductResponseModel showDetailsProductResponseModel;

  @override
  Widget build(BuildContext context) {
    return showDetailsProductResponseModel.options!.isEmpty
        ? Container()
        : showDetailsProductResponseModel.options![0].value != 'null'
            ? Column(
                children: [
                  ProductDetailsWidget(
                    title: LocaleKeys.type.tr(),
                    subtitle:
                        '${context.locale.languageCode.contains('en') ? showDetailsProductResponseModel.options![0].value : context.locale.languageCode.contains('ar') ? showDetailsProductResponseModel.options![0].valueAr : ''}',
                  ),
                  const Divider(color: AppPalette.grey),
                ],
              )
            : Container();
  }
}

class CustomOptionListItemVehicles extends StatelessWidget {
  CustomOptionListItemVehicles(
      {Key? key, required this.showDetailsProductResponseModel})
      : super(key: key);
  ShowDetailsProductResponseModel showDetailsProductResponseModel;

  @override
  Widget build(BuildContext context) {
    return showDetailsProductResponseModel.options!.isEmpty
        ? Container()
        : Column(
            children: [
              showDetailsProductResponseModel.options![0].value != 'null'
                  ? Column(
                      children: [
                        ProductDetailsWidget(
                          title: LocaleKeys.fuelType.tr(),
                          subtitle:
                              '${context.locale.languageCode.contains('en') ? showDetailsProductResponseModel.options![0].value : context.locale.languageCode.contains('ar') ? showDetailsProductResponseModel.options![0].valueAr : ''}',
                        ),
                        const Divider(color: AppPalette.grey),
                      ],
                    )
                  : Container(),
              showDetailsProductResponseModel.options![1].value!
                      .contains('null')
                  ? Container()
                  : Column(
                      children: [
                        ProductDetailsWidget(
                          title: LocaleKeys.year.tr(),
                          subtitle:
                              '${context.locale.languageCode.contains('en') ? showDetailsProductResponseModel.options![1].value : context.locale.languageCode.contains('ar') ? showDetailsProductResponseModel.options![1].valueAr : ''}',
                        ),
                        const Divider(color: AppPalette.grey),
                      ],
                    ),
              showDetailsProductResponseModel.options![2].value!
                      .contains('null')
                  ? Container()
                  : Column(
                      children: [
                        ProductDetailsWidget(
                          title: LocaleKeys.kilometers.tr(),
                          subtitle:
                              '${context.locale.languageCode.contains('en') ? showDetailsProductResponseModel.options![2].value : context.locale.languageCode.contains('ar') ? showDetailsProductResponseModel.options![2].valueAr : ''}',
                        ),
                        const Divider(color: AppPalette.grey),
                      ],
                    ),
              showDetailsProductResponseModel.options![3].value!
                      .contains('null')
                  ? Container()
                  : Column(
                      children: [
                        ProductDetailsWidget(
                          title: LocaleKeys.transmissionType.tr(),
                          subtitle:
                              '${context.locale.languageCode.contains('en') ? showDetailsProductResponseModel.options![3].value : context.locale.languageCode.contains('ar') ? showDetailsProductResponseModel.options![3].valueAr : ''}',
                        ),
                        const Divider(color: AppPalette.grey),
                      ],
                    ),
              showDetailsProductResponseModel.options![4].value!
                      .contains('null')
                  ? Container()
                  : Column(
                      children: [
                        ProductDetailsWidget(
                          title: LocaleKeys.color.tr(),
                          subtitle:
                              '${context.locale.languageCode.contains('en') ? showDetailsProductResponseModel.options![4].value : context.locale.languageCode.contains('ar') ? showDetailsProductResponseModel.options![4].valueAr : ''}',
                        ),
                        const Divider(color: AppPalette.grey),
                      ],
                    ),
              showDetailsProductResponseModel.options![5].value!
                      .contains('null')
                  ? Container()
                  : Column(
                      children: [
                        ProductDetailsWidget(
                          title: LocaleKeys.bodyType.tr(),
                          subtitle:
                              '${context.locale.languageCode.contains('en') ? showDetailsProductResponseModel.options![5].value : context.locale.languageCode.contains('ar') ? showDetailsProductResponseModel.options![5].valueAr : ''}',
                        ),
                        const Divider(color: AppPalette.grey),
                      ],
                    ),
              showDetailsProductResponseModel.options![6].value!
                      .contains('null')
                  ? Container()
                  : Column(
                      children: [
                        ProductDetailsWidget(
                          title: LocaleKeys.engineCapacity.tr(),
                          subtitle:
                              '${context.locale.languageCode.contains('en') ? showDetailsProductResponseModel.options![6].value : context.locale.languageCode.contains('ar') ? showDetailsProductResponseModel.options![6].valueAr : ''}',
                        ),
                        const Divider(color: AppPalette.grey),
                      ],
                    ),
              showDetailsProductResponseModel.options![7].value!
                      .contains('null')
                  ? Container()
                  : Column(
                      children: [
                        ProductDetailsWidget(
                          title: LocaleKeys.modelName.tr(),
                          subtitle:
                              '${context.locale.languageCode.contains('en') ? showDetailsProductResponseModel.options![7].value : context.locale.languageCode.contains('ar') ? showDetailsProductResponseModel.options![7].valueAr : ''}',
                        ),
                      ],
                    ),
            ],
          );
  }
}

class CustomOptionListItemProperties extends StatelessWidget {
  CustomOptionListItemProperties(
      {Key? key, required this.showDetailsProductResponseModel})
      : super(key: key);
  ShowDetailsProductResponseModel showDetailsProductResponseModel;

  @override
  Widget build(BuildContext context) {
    return showDetailsProductResponseModel.options!.isEmpty
        ? Container()
        : Column(
            children: [
              showDetailsProductResponseModel.options![0].value!
                      .contains('null')
                  ? Container()
                  : Column(
                      children: [
                        ProductDetailsWidget(
                          title: LocaleKeys.type.tr(),
                          subtitle:
                              '${context.locale.languageCode.contains('en') ? showDetailsProductResponseModel.options![0].value : context.locale.languageCode.contains('ar') ? showDetailsProductResponseModel.options![0].valueAr : ''}',
                        ),
                        const Divider(color: AppPalette.grey),
                      ],
                    ),
              showDetailsProductResponseModel.options![1].value!
                      .contains('null')
                  ? Container()
                  : Column(
                      children: [
                        ProductDetailsWidget(
                          title: LocaleKeys.downPayment.tr(),
                          subtitle:
                              '${context.locale.languageCode.contains('en') ? showDetailsProductResponseModel.options![1].value : context.locale.languageCode.contains('ar') ? showDetailsProductResponseModel.options![1].valueAr : ''}',
                        ),
                        const Divider(color: AppPalette.grey),
                      ],
                    ),
              showDetailsProductResponseModel.options![2].value!
                      .contains('null')
                  ? Container()
                  : Column(
                      children: [
                        ProductDetailsWidget(
                          title: LocaleKeys.amenities.tr(),
                          subtitle:
                              '${context.locale.languageCode.contains('en') ? showDetailsProductResponseModel.options![2].value : context.locale.languageCode.contains('ar') ? showDetailsProductResponseModel.options![2].valueAr : ''}',
                        ),
                        const Divider(color: AppPalette.grey),
                      ],
                    ),
              showDetailsProductResponseModel.options![3].value!
                      .contains('null')
                  ? Container()
                  : Column(
                      children: [
                        ProductDetailsWidget(
                          title: LocaleKeys.bedroom.tr(),
                          subtitle:
                              '${context.locale.languageCode.contains('en') ? showDetailsProductResponseModel.options![3].value : context.locale.languageCode.contains('ar') ? showDetailsProductResponseModel.options![3].valueAr : ''}',
                        ),
                        const Divider(color: AppPalette.grey),
                      ],
                    ),
              showDetailsProductResponseModel.options![4].value!
                      .contains('null')
                  ? Container()
                  : Column(
                      children: [
                        ProductDetailsWidget(
                          title: LocaleKeys.bathroom.tr(),
                          subtitle:
                              '${context.locale.languageCode.contains('en') ? showDetailsProductResponseModel.options![4].value : context.locale.languageCode.contains('ar') ? showDetailsProductResponseModel.options![4].valueAr : ''}',
                        ),
                        const Divider(color: AppPalette.grey),
                      ],
                    ),
              showDetailsProductResponseModel.options![5].value!
                      .contains('null')
                  ? Container()
                  : Column(
                      children: [
                        ProductDetailsWidget(
                          title: LocaleKeys.area.tr(),
                          subtitle:
                              '${context.locale.languageCode.contains('en') ? showDetailsProductResponseModel.options![5].value : context.locale.languageCode.contains('ar') ? showDetailsProductResponseModel.options![5].valueAr : ''}',
                        ),
                        const Divider(color: AppPalette.grey),
                      ],
                    ),
              showDetailsProductResponseModel.options![6].value!
                      .contains('null')
                  ? Container()
                  : Column(
                      children: [
                        ProductDetailsWidget(
                          title: LocaleKeys.level.tr(),
                          subtitle:
                              '${context.locale.languageCode.contains('en') ? showDetailsProductResponseModel.options![6].value : context.locale.languageCode.contains('ar') ? showDetailsProductResponseModel.options![6].valueAr : ''}',
                        ),
                        const Divider(color: AppPalette.grey),
                      ],
                    ),
              showDetailsProductResponseModel.options![7].value!
                      .contains('null')
                  ? Container()
                  : Column(
                      children: [
                        ProductDetailsWidget(
                          title: LocaleKeys.finished.tr(),
                          subtitle:
                              '${context.locale.languageCode.contains('en') ? showDetailsProductResponseModel.options![7].value : context.locale.languageCode.contains('ar') ? showDetailsProductResponseModel.options![7].valueAr : ''}',
                        ),
                        const Divider(color: AppPalette.grey),
                      ],
                    ),
              showDetailsProductResponseModel.options![8].value!
                      .contains('null')
                  ? Container()
                  : Column(
                      children: [
                        ProductDetailsWidget(
                          title: LocaleKeys.status.tr(),
                          subtitle:
                              '${context.locale.languageCode.contains('en') ? showDetailsProductResponseModel.options![8].value : context.locale.languageCode.contains('ar') ? showDetailsProductResponseModel.options![8].valueAr : ''}',
                        ),
                      ],
                    ),
            ],
          );
  }
}
