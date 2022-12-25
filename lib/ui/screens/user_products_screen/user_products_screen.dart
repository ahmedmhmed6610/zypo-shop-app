import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:shop/business_logic/add_favorite_user_cubit/add_favorite_user_cubit.dart';
import 'package:shop/business_logic/app_layout_cubit/app_layout_cubit.dart';
import 'package:shop/business_logic/profile_cubit/profile_cubit.dart';
import 'package:shop/data/internet_connectivity/no_internet.dart';
import 'package:shop/translations/locale_keys.g.dart';
import 'package:shop/ui/screens/my_favorite_user_screen/my_favorite_user_screen.dart';
import 'package:shop/ui/screens/product_details_screen/product_details_screen.dart';
import 'package:shop/ui/screens/product_details_screen/product_search_details_screen.dart';
import 'package:shop/utils/app_size_boxes.dart';
import '../../../business_logic/app_ui_cubit/app_ui_cubit.dart';
import '../../../business_logic/filter_cubit/filter_cubit.dart';
import '../../../business_logic/my_favorite_user_cubit/my_favorite_user_cubit.dart';
import '../../../business_logic/product_details_cubit/product_details_cubit.dart';
import '../../../data/models/MyFavoriteUserModel.dart';
import '../../../data/models/product_model.dart';
import '../../../data/models/show_details_product_model.dart';
import '../../../helpers/app_local_storage.dart';
import '../../../helpers/cache_helper.dart';
import '../../../helpers/call_helper.dart';
import '../../../helpers/components.dart';
import '../../../libraries/dialog_widget.dart';
import '../../../utils/Themes.dart';
import '../../../utils/app_palette.dart';
import '../../../utils/dimensions.dart';
import '../../../utils/firebase_dynamic_link.dart';
import '../../../utils/styles.dart';
import '../../widgets/My_products_widgets/add_button_widget.dart';
import '../../widgets/product_widgets/filter_product_item.dart';
import '../../widgets/product_widgets/filter_product_list_item.dart';
import '../auth/login_screen.dart';
import '../layout/app_layout.dart';
import '../product_details_screen/product_filter_details_screen.dart';

class UserProductsScreen extends StatefulWidget {
  UserProductsScreen(
      {Key? key, this.showDetailsProductResponseModel, this.myProductUserResponseModel, this.product,this.intentValue})
      : super(key: key);
  ShowDetailsProductResponseModel? showDetailsProductResponseModel;
  MyFavoriteUserResponseModel? myProductUserResponseModel;
  ProductModel? product;
  String? intentValue;

  @override
  _UserProductsScreenState createState() => _UserProductsScreenState();
}

class _UserProductsScreenState extends State<UserProductsScreen> {
  String imageUser =
      'https://img.freepik.com/free-photo/excited-man-celebrating-victory-rejoicing-making-fist-pump-gesture-winning-looking-satisfied-saying-yes-achieve-goal-standing-light-turquoise-wall_1258-23890.jpg?w=1060&t=st=1660172869~exp=1660173469~hmac=0ed5bff0eaf4351e4f8be5777ffbcc142793655b001ccf3f66e9743a45634605';
  String? lottie;
  String? userId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    BlocProvider.of<ProfileCubit>(context).getUserProfile();
  //  BlocProvider.of<FilterCubit>(context).getUserProducts('2');
   if(widget.showDetailsProductResponseModel!.id == null){

   }else {
     BlocProvider.of<ProductDetailsCubit>(context).getProductDetails(
         productId: widget.showDetailsProductResponseModel!.id!);
   }
    userId = CacheHelper.getData(key: 'UserId');
    print('intentValue ${widget.intentValue}');
    print('userId $userId');
  }

  @override
  Widget build(BuildContext context) {
    final stateSubscribeDetails = context.watch<ProductDetailsCubit>().state;
    final stateProfile = context.watch<ProfileCubit>().state;
    return WillPopScope(
      onWillPop: () async{
        if(widget.showDetailsProductResponseModel!.id == null){
          navigateReplaceTo(context: context, widget: AppLayout());
        }else {
          navigateReplaceTo(context: context, widget: AppLayout());
        }

        return false;
      },
      child: BlocConsumer<AppLayoutCubit, AppLayoutState>(
        listener: (context, state) {
          if (state is ConnectionSuccess) {
            BlocBuilder<FilterCubit, FilterState>(
              builder: (context, filterState) {
                FilterCubit filterCubit = FilterCubit.get(context);
                if (filterState is FilterSuccessState) {
                  var listDate = widget.showDetailsProductResponseModel?.user?.createdAt?.split(' ');
                  var dateCreate = listDate![0].trim();
                  return Scaffold(
                    backgroundColor: AppPalette.primary,
                    body: SafeArea(
                      child: Column(
                        children: [
                          15.heightBox,
                          Padding(
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
                                      LocaleKeys.userProducts.tr(),
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
                          15.heightBox,
                          BlocConsumer<AddFavoriteUserCubit,
                              AddFavoriteUserState>(
                            listener: (context, stateSubscribeUser) {
                              if(stateSubscribeUser is AddSubscribeUserProductSuccessfullyState){
                                if(stateSubscribeDetails is SuccessProductDetailsState){
                                  if (stateSubscribeDetails.showDetailsProductResponseModel![0].isSubscriber == true) {
                                    AwesomeDialog(
                                      context: context,
                                      dialogType: DialogType.success,
                                      animType: AnimType.rightSlide,
                                      btnOkText: LocaleKeys.ok.tr(),
                                      btnCancelText: LocaleKeys.cancel.tr(),
                                      title: LocaleKeys.success2.tr(),
                                      titleTextStyle: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                      descTextStyle: const TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w300),
                                      dismissOnTouchOutside: false,
                                      desc: LocaleKeys
                                          .intentToScreenFavoriteUser
                                          .tr(),
                                      btnCancelOnPress: () {
                                        print('intentValue');
                                        print(widget.intentValue);
                                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                                            builder: (context) => UserProductsScreen(
                                              showDetailsProductResponseModel: widget.showDetailsProductResponseModel,
                                              product: widget.product,)));
                                      },
                                      btnOkOnPress: () {
                                        Navigator.of(context)
                                            .pushReplacement(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    AppLayout()));
                                      },
                                    ).show();

                                  } else if (stateSubscribeDetails.showDetailsProductResponseModel![0].isSubscriber == false) {
                                    AwesomeDialog(
                                      context: context,
                                      dialogType: DialogType.success,
                                      animType: AnimType.rightSlide,
                                      btnOkText: LocaleKeys.ok.tr(),
                                      btnCancelText: LocaleKeys.cancel.tr(),
                                      title: LocaleKeys.success.tr(),
                                      titleTextStyle: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                      descTextStyle: const TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w300),
                                      dismissOnTouchOutside: false,
                                      desc: LocaleKeys
                                          .intentToScreenFavoriteUser
                                          .tr(),
                                      btnCancelOnPress: () {
                                        print('intentValue');
                                        print(widget.intentValue);
                                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                                            builder: (context) => UserProductsScreen(
                                              showDetailsProductResponseModel: widget.showDetailsProductResponseModel,
                                              product: widget.product,)));
                                      },
                                      btnOkOnPress: () {
                                        Navigator.of(context)
                                            .pushReplacement(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    AppLayout()));
                                      },
                                    ).show();
                                  }
                                }
                              }

                            },
                            builder: (context, stateFavoriteUser) {
                              AddFavoriteUserCubit myFavoriteUserCubit =
                              AddFavoriteUserCubit.get(context);
                              return GestureDetector(
                                onTap: () {},
                                child: Padding(
                                  padding:
                                  EdgeInsets.symmetric(horizontal: 5.h),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            widget.showDetailsProductResponseModel!
                                                .user?.photo ==
                                                null
                                                ? Container(
                                              width: 40.h,
                                              height: 42.h,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: CachedNetworkImageProvider(
                                                          imageUser),
                                                      fit: BoxFit
                                                          .cover),
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      Dimensions
                                                          .radiusSmall)),
                                            )
                                                : Container(
                                              width: 40.h,
                                              height: 42.h,
                                              decoration:
                                              BoxDecoration(
                                                  image:
                                                  DecorationImage(
                                                      image: CachedNetworkImageProvider(
                                                          '${widget.showDetailsProductResponseModel?.user?.userImagePath}/'
                                                              '${widget.showDetailsProductResponseModel?.user?.photo}'),
                                                      fit: BoxFit
                                                          .cover),
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      Dimensions
                                                          .radiusSmall)),
                                            ),
                                            8.widthBox,
                                            Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                2.heightBox,
                                                Text(
                                                  '${widget.showDetailsProductResponseModel?.user?.firstName}'
                                                      ' ${widget.showDetailsProductResponseModel?.user?.lastName}',
                                                  style: const TextStyle(
                                                      color: AppPalette.white,
                                                      fontWeight:
                                                      FontWeight.bold),
                                                ),
                                                7.heightBox,
                                                Text(
                                                  '${LocaleKeys.memberSince.tr()} $dateCreate',
                                                  style: const TextStyle(
                                                      color: AppPalette.white,
                                                      fontFamily: Fonts.poppins,
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.w400),
                                                ),
                                              ],
                                            ),
                                            const Spacer(),
                                            stateProfile is SuccessProfileState ?
                                            stateProfile
                                                .userDataModel!
                                                .user!
                                                .id ==
                                                widget
                                                    .showDetailsProductResponseModel
                                                    ?.user!
                                                    .id
                                                ? Row(
                                              children: [
                                                Card(
                                                  shadowColor:
                                                  AppPalette
                                                      .white,
                                                  elevation: 0.0,
                                                  color:
                                                  AppPalette
                                                      .white,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          5)),
                                                  child:
                                                  Container(
                                                    width: 35.h,
                                                    height: 35.h,
                                                    child: Center(
                                                      child: IconButton(
                                                          color: AppPalette
                                                              .primary,
                                                          onPressed:
                                                              () async {
                                                                // var firebaseDynamicLinkService =
                                                                // await FirebaseDynamicLinkService.createDynamicLinkUser(
                                                                //     product: widget.showDetailsProductResponseModel);
                                                                //
                                                                // print('firebaseDynamicLinkService');
                                                                // print(firebaseDynamicLinkService);
                                                                // await Share.share('go to the product \n $firebaseDynamicLinkService',);
                                                              },
                                                          icon: SvgPicture
                                                              .asset(
                                                            "assets/images/svg/share.svg",
                                                            fit: BoxFit
                                                                .scaleDown,
                                                            color:
                                                            AppPalette.primary,
                                                          )),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                                : Row(
                                              children: [
                                                Card(
                                                  shadowColor:
                                                  AppPalette
                                                      .white,
                                                  elevation: 0.0,
                                                  color:
                                                  AppPalette
                                                      .white,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          5)),
                                                  child: Container(
                                                      width: 35.h,
                                                      height: 35.h,
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
                                                                if(stateSubscribeDetails is SuccessProductDetailsState){
                                                                  if (stateSubscribeDetails.showDetailsProductResponseModel![0].isSubscriber == true) {
                                                                    myFavoriteUserCubit.deleteSubscribeUserProduct('${widget.showDetailsProductResponseModel?.user!.id.toString()}');
                                                                  } else if (stateSubscribeDetails.showDetailsProductResponseModel![0].isSubscriber == false) {
                                                                    myFavoriteUserCubit.addSubscribeUserProduct('${widget.showDetailsProductResponseModel?.user!.id.toString()}');
                                                                  }
                                                                }

                                                              }
                                                            },

                                                            icon: stateSubscribeDetails is SuccessProductDetailsState ?
                                                            stateSubscribeDetails.showDetailsProductResponseModel![0].isSubscriber == true
                                                                ? const Icon(
                                                              Icons.favorite,
                                                              color: AppPalette.primary,
                                                            )
                                                                : stateSubscribeDetails.showDetailsProductResponseModel![0].isSubscriber == false ?
                                                            const Icon(
                                                              Icons.favorite_border,
                                                              color: AppPalette.primary,
                                                            ) : const SizedBox(
                                                                width: 15,height: 15,
                                                                child: CircularProgressIndicator(color: AppPalette.primary,)) :
                                                            const SizedBox(
                                                                width: 15,height: 15,
                                                                child: CircularProgressIndicator(color: AppPalette.primary,))
                                                            ,)
                                                      )
                                                  ),
                                                ),
                                                5.widthBox,
                                                Card(
                                                  shadowColor:
                                                  AppPalette
                                                      .white,
                                                  elevation: 0.0,
                                                  color:
                                                  AppPalette
                                                      .white,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          5)),
                                                  child:
                                                  Container(
                                                    width: 35.h,
                                                    height: 35.h,
                                                    child: Center(
                                                      child: IconButton(
                                                          color: AppPalette
                                                              .primary,
                                                          onPressed:
                                                              () async {
                                                            if (AppLocalStorage.token ==
                                                                null) {
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
                                                              print('phone user');
                                                              print(widget.showDetailsProductResponseModel?.user?.phoneNumber);
                                                              await callNumber(phoneNumber: '${widget.showDetailsProductResponseModel?.user?.phoneNumber}');
                                                            }
                                                          },
                                                          icon: SvgPicture
                                                              .asset(
                                                            "assets/images/svg/phoneCall.svg",
                                                            fit: BoxFit
                                                                .scaleDown,
                                                            color:
                                                            AppPalette.primary,
                                                          )),
                                                    ),
                                                  ),
                                                ),
                                                5.widthBox,
                                                Card(
                                                  shadowColor:
                                                  AppPalette
                                                      .white,
                                                  elevation: 0.0,
                                                  color:
                                                  AppPalette
                                                      .white,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          5)),
                                                  child:
                                                  Container(
                                                    width: 35.h,
                                                    height: 35.h,
                                                    child: Center(
                                                      child: IconButton(
                                                          color: AppPalette
                                                              .primary,
                                                          onPressed:
                                                              () async {
                                                                // var firebaseDynamicLinkService =
                                                                // await FirebaseDynamicLinkService.createDynamicLinkUser(
                                                                //     product: widget.showDetailsProductResponseModel);
                                                                //
                                                                // print('firebaseDynamicLinkService');
                                                                // print(firebaseDynamicLinkService);
                                                                // await Share.share('go to the product \n $firebaseDynamicLinkService',);
                                                          },
                                                          icon: SvgPicture
                                                              .asset(
                                                            "assets/images/svg/share.svg",
                                                            fit: BoxFit
                                                                .scaleDown,
                                                            color:
                                                            AppPalette.primary,
                                                          )),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                                : Row(
                                              children: [
                                                Card(
                                                  shadowColor:
                                                  AppPalette
                                                      .white,
                                                  elevation: 0.0,
                                                  color:
                                                  AppPalette
                                                      .white,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          5)),
                                                  child: Container(
                                                      width: 35.h,
                                                      height: 35.h,
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
                                                                  if(stateSubscribeDetails is SuccessProductDetailsState){
                                                                    if (stateSubscribeDetails.showDetailsProductResponseModel![0].isSubscriber == true) {
                                                                      myFavoriteUserCubit.deleteSubscribeUserProduct('${widget.showDetailsProductResponseModel?.user!.id.toString()}');
                                                                    } else if (stateSubscribeDetails.showDetailsProductResponseModel![0].isSubscriber == false) {
                                                                      myFavoriteUserCubit.addSubscribeUserProduct('${widget.showDetailsProductResponseModel?.user!.id.toString()}');
                                                                    }
                                                                  }

                                                                }
                                                              },

                                                              icon:  const Icon(
                                                                Icons.favorite_border,
                                                                color: AppPalette.primary,
                                                              ))
                                                      )
                                                  ),
                                                ),
                                                5.widthBox,
                                                Card(
                                                  shadowColor:
                                                  AppPalette
                                                      .white,
                                                  elevation: 0.0,
                                                  color:
                                                  AppPalette
                                                      .white,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          5)),
                                                  child:
                                                  Container(
                                                    width: 35.h,
                                                    height: 35.h,
                                                    child: Center(
                                                      child: IconButton(
                                                          color: AppPalette
                                                              .primary,
                                                          onPressed:
                                                              () async {
                                                            if (AppLocalStorage.token ==
                                                                null) {
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
                                                              print('phone user');
                                                              print(widget.showDetailsProductResponseModel?.user?.phoneNumber);
                                                              await callNumber(phoneNumber: '${widget.showDetailsProductResponseModel?.user?.phoneNumber}');
                                                            }
                                                          },
                                                          icon: SvgPicture
                                                              .asset(
                                                            "assets/images/svg/phoneCall.svg",
                                                            fit: BoxFit
                                                                .scaleDown,
                                                            color:
                                                            AppPalette.primary,
                                                          )),
                                                    ),
                                                  ),
                                                ),
                                                5.widthBox,
                                                Card(
                                                  shadowColor:
                                                  AppPalette
                                                      .white,
                                                  elevation: 0.0,
                                                  color:
                                                  AppPalette
                                                      .white,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          5)),
                                                  child:
                                                  Container(
                                                    width: 35.h,
                                                    height: 35.h,
                                                    child: Center(
                                                      child: IconButton(
                                                          color: AppPalette
                                                              .primary,
                                                          onPressed:
                                                              () async {
                                                                // var firebaseDynamicLinkService =
                                                                // await FirebaseDynamicLinkService.createDynamicLinkUser(
                                                                //     product: widget.showDetailsProductResponseModel);
                                                                //
                                                                // print('firebaseDynamicLinkService');
                                                                // print(firebaseDynamicLinkService);
                                                                // await Share.share('go to the product \n $firebaseDynamicLinkService',);
                                                          },
                                                          icon: SvgPicture
                                                              .asset(
                                                            "assets/images/svg/share.svg",
                                                            fit: BoxFit
                                                                .scaleDown,
                                                            color:
                                                            AppPalette.primary,
                                                          )),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        5.heightBox,
                                        stateFavoriteUser
                                        is AddSubscribeUserProductLoadingState
                                            ? const Center(
                                            child: SizedBox(
                                                width: 25,
                                                height: 25,
                                                child:
                                                CircularProgressIndicator(
                                                  color: AppPalette.white,
                                                )))
                                            : Container(),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          10.heightBox,
                          Expanded(
                            child: Container(
                              height: MediaQuery.of(context).size.height,
                              decoration: const BoxDecoration(
                                  color: AppPalette.white,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(25),
                                      topRight: Radius.circular(25))),
                              child: Padding(
                                padding:  EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      BlocBuilder<AppUiCubit, AppUiState>(
                                        builder: (context, state) {
                                          AppUiCubit appUICubit = AppUiCubit.get(context);
                                          return Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: Dimensions.paddingSize),
                                            child: ListView(
                                              physics: const BouncingScrollPhysics(),
                                              shrinkWrap: true,
                                              children: [
                                                25.heightBox,
                                                10.heightBox,
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(LocaleKeys.showingResults.tr(),
                                                        style: AppTextStyles.poppinsRegular
                                                            .copyWith(color: AppPalette.black)),
                                                    Text(
                                                        " ${filterCubit.myProductUserResponseModel!.length} ",
                                                        style: AppTextStyles.poppinsRegular),
                                                    Text(LocaleKeys.userProducts.tr(),
                                                        style: AppTextStyles.poppinsRegular
                                                            .copyWith(color: AppPalette.black)),
                                                    const Spacer(),
                                                    InkWell(
                                                      onTap: appUICubit.toggleView,
                                                      child: Icon(
                                                          appUICubit.isGrid
                                                              ? Icons.list_sharp
                                                              : Icons.grid_view_sharp,
                                                          color: AppPalette.black),
                                                    ),
                                                  ],
                                                ),
                                                // 8.heightBox,
                                                filterCubit.myProductUserResponseModel!.isNotEmpty
                                                    ? appUICubit.isGrid
                                                    ? GridView.builder(
                                                    shrinkWrap: true,
                                                    physics: const BouncingScrollPhysics(),
                                                    padding: EdgeInsets.symmetric(
                                                        vertical: 20.h),
                                                    gridDelegate:
                                                    SliverGridDelegateWithMaxCrossAxisExtent(
                                                      maxCrossAxisExtent: 200.0,
                                                      mainAxisSpacing: 5.0.h,
                                                      crossAxisSpacing: 15.0.w,
                                                      childAspectRatio: 1 / 1.69,
                                                    ),
                                                    itemCount: filterCubit
                                                        .myProductUserResponseModel!.length,
                                                    // itemBuilder: (context, index) => Container(
                                                    //   color: Colors.red,
                                                    // ),
                                                    itemBuilder: (context, index) {
                                                      return FilterProductItem(
                                                        product: filterCubit
                                                            .myProductUserResponseModel![
                                                        index],
                                                      );
                                                    })
                                                    : ListView.separated(
                                                  shrinkWrap: true,
                                                  physics: const BouncingScrollPhysics(),
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 20.h),
                                                  itemCount: filterCubit
                                                      .myProductUserResponseModel!.length,
                                                  // itemExtent: 200.0,
                                                  itemBuilder: (context, index) =>
                                                      FilterProductListItem(
                                                          product: filterCubit
                                                              .myProductUserResponseModel![
                                                          index]),
                                                  separatorBuilder: (context, index) =>
                                                  10.0.heightBox,
                                                )
                                                    : Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                                  children: [
                                                    // Padding(
                                                    //   padding: EdgeInsets.symmetric(
                                                    //     horizontal: Dimensions.paddingSizeDefault,
                                                    //   ),
                                                    //   child: Row(
                                                    //     mainAxisAlignment:
                                                    //     MainAxisAlignment.spaceBetween,
                                                    //     crossAxisAlignment: CrossAxisAlignment.start,
                                                    //     children: [
                                                    //       Text(
                                                    //         LocaleKeys.newRecommendations.tr(),
                                                    //         style:
                                                    //         Theme.of(context).textTheme.headline3,
                                                    //       ),
                                                    //     ],
                                                    //   ),
                                                    // ),
                                                    35.heightBox,
                                                    Center(
                                                      child: SvgPicture.asset(
                                                          "assets/images/svg/addProduct.svg",
                                                          height: 150,
                                                          width: 150,
                                                          fit: BoxFit.contain),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                return const Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                );
              },
            );
          } else if (state is ConnectionFailure) {
            NoInternetConnectionScreen(
              appLayoutState: state,
            );
          } else {
            Scaffold(
                body: Center(
                  child: AnimatedTextKit(
                    animatedTexts: [
                      WavyAnimatedText(LocaleKeys.markety.tr(),
                          textStyle: TextStyle(
                              fontSize: 20.0.sp,
                              color: Themes.colorApp13,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins-bold')),
                    ],
                    isRepeatingAnimation: true,
                    totalRepeatCount: 6,
                    onTap: () {},
                  ),
                ));
          }
        },
        builder: (context, state) {
          var listDate = '1/8/2022 14:30';
          var dateCreate = listDate[0].trim();
          if (state is ConnectionSuccess) {
            return BlocBuilder<FilterCubit, FilterState>(
              builder: (context, filterState) {
                FilterCubit filterCubit = FilterCubit.get(context);
                if (filterState is FilterSuccessState) {
                  print('success usesrs');
                  return Scaffold(
                    backgroundColor: AppPalette.primary,
                    body: SafeArea(
                      child: Column(
                        children: [
                          15.heightBox,
                          Padding(
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
                                      LocaleKeys.userProducts.tr(),
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
                          15.heightBox,
                          BlocConsumer<AddFavoriteUserCubit,
                              AddFavoriteUserState>(
                            listener: (context, stateSubscribeUser) {
                              if(stateSubscribeUser is AddSubscribeUserProductSuccessfullyState){
                                if(stateSubscribeDetails is SuccessProductDetailsState){
                                  if (stateSubscribeDetails.showDetailsProductResponseModel![0].isSubscriber == true) {
                                    AwesomeDialog(
                                      context: context,
                                      dialogType: DialogType.success,
                                      animType: AnimType.rightSlide,
                                      btnOkText: LocaleKeys.ok.tr(),
                                      btnCancelText: LocaleKeys.cancel.tr(),
                                      title: LocaleKeys.success2.tr(),
                                      titleTextStyle: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                      descTextStyle: const TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w300),
                                      dismissOnTouchOutside: false,
                                      desc: LocaleKeys
                                          .intentToScreenFavoriteUser
                                          .tr(),
                                      btnCancelOnPress: () {
                                        print('intentValue');
                                        print(widget.intentValue);
                                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                                            builder: (context) => UserProductsScreen(
                                              showDetailsProductResponseModel: widget.showDetailsProductResponseModel,
                                              product: widget.product,)));
                                      },
                                      btnOkOnPress: () {
                                        Navigator.of(context)
                                            .pushReplacement(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    AppLayout()));
                                      },
                                    ).show();

                                  } else if (stateSubscribeDetails.showDetailsProductResponseModel![0].isSubscriber == false) {
                                    AwesomeDialog(
                                      context: context,
                                      dialogType: DialogType.success,
                                      animType: AnimType.rightSlide,
                                      btnOkText: LocaleKeys.ok.tr(),
                                      btnCancelText: LocaleKeys.cancel.tr(),
                                      title: LocaleKeys.success.tr(),
                                      titleTextStyle: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                      descTextStyle: const TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w300),
                                      dismissOnTouchOutside: false,
                                      desc: LocaleKeys
                                          .intentToScreenFavoriteUser
                                          .tr(),
                                      btnCancelOnPress: () {
                                        print('intentValue');
                                        print(widget.intentValue);
                                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                                            builder: (context) => UserProductsScreen(
                                              showDetailsProductResponseModel: widget.showDetailsProductResponseModel,
                                              product: widget.product,)));
                                      },
                                      btnOkOnPress: () {
                                        Navigator.of(context)
                                            .pushReplacement(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    AppLayout()));
                                      },
                                    ).show();
                                  }
                                }
                              }

                            },
                            builder: (context, stateFavoriteUser) {
                              AddFavoriteUserCubit myFavoriteUserCubit =
                              AddFavoriteUserCubit.get(context);
                              return GestureDetector(
                                onTap: () {},
                                child: Padding(
                                  padding:
                                  EdgeInsets.symmetric(horizontal: 5.h),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            widget.showDetailsProductResponseModel!
                                                .user?.photo ==
                                                null
                                                ? Container(
                                              width: 40.h,
                                              height: 42.h,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: CachedNetworkImageProvider(
                                                          imageUser),
                                                      fit: BoxFit
                                                          .cover),
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      Dimensions
                                                          .radiusSmall)),
                                            )
                                                : Container(
                                              width: 40.h,
                                              height: 42.h,
                                              decoration:
                                              BoxDecoration(
                                                  image:
                                                  DecorationImage(
                                                      image: CachedNetworkImageProvider(
                                                          '${widget.showDetailsProductResponseModel?.user?.userImagePath}/'
                                                              '${widget.showDetailsProductResponseModel?.user?.photo}'),
                                                      fit: BoxFit
                                                          .cover),
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      Dimensions
                                                          .radiusSmall)),
                                            ),
                                            8.widthBox,
                                            Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                2.heightBox,
                                                Text(
                                                  '${widget.showDetailsProductResponseModel?.user?.firstName}'
                                                      ' ${widget.showDetailsProductResponseModel?.user?.lastName}',
                                                  style: const TextStyle(
                                                      color: AppPalette.white,
                                                      fontWeight:
                                                      FontWeight.bold),
                                                ),
                                                7.heightBox,
                                                Text(
                                                  '${LocaleKeys.memberSince.tr()} $dateCreate',
                                                  style: const TextStyle(
                                                      color: AppPalette.white,
                                                      fontFamily: Fonts.poppins,
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.w400),
                                                ),
                                              ],
                                            ),
                                            const Spacer(),
                                            stateProfile is SuccessProfileState ?
                                            stateProfile
                                                .userDataModel!
                                                .user!
                                                .id ==
                                                widget
                                                    .showDetailsProductResponseModel
                                                    ?.user!
                                                    .id
                                                ? Row(
                                              children: [
                                                Card(
                                                  shadowColor:
                                                  AppPalette
                                                      .white,
                                                  elevation: 0.0,
                                                  color:
                                                  AppPalette
                                                      .white,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          5)),
                                                  child:
                                                  Container(
                                                    width: 35.h,
                                                    height: 35.h,
                                                    child: Center(
                                                      child: IconButton(
                                                          color: AppPalette
                                                              .primary,
                                                          onPressed:
                                                              () async {
                                                                // var firebaseDynamicLinkService =
                                                                // await FirebaseDynamicLinkService.createDynamicLinkUser(
                                                                //     product: widget.showDetailsProductResponseModel);
                                                                //
                                                                // print('firebaseDynamicLinkService');
                                                                // print(firebaseDynamicLinkService);
                                                                // await Share.share('go to the product \n $firebaseDynamicLinkService',);
                                                              },
                                                          icon: SvgPicture
                                                              .asset(
                                                            "assets/images/svg/share.svg",
                                                            fit: BoxFit
                                                                .scaleDown,
                                                            color:
                                                            AppPalette.primary,
                                                          )),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                                : Row(
                                              children: [
                                                Card(
                                                  shadowColor:
                                                  AppPalette
                                                      .white,
                                                  elevation: 0.0,
                                                  color:
                                                  AppPalette
                                                      .white,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          5)),
                                                  child: Container(
                                                      width: 35.h,
                                                      height: 35.h,
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
                                                                if(stateSubscribeDetails is SuccessProductDetailsState){
                                                                  if (stateSubscribeDetails.showDetailsProductResponseModel![0].isSubscriber == true) {
                                                                    myFavoriteUserCubit.deleteSubscribeUserProduct('${widget.showDetailsProductResponseModel?.user!.id.toString()}');
                                                                  } else if (stateSubscribeDetails.showDetailsProductResponseModel![0].isSubscriber == false) {
                                                                    myFavoriteUserCubit.addSubscribeUserProduct('${widget.showDetailsProductResponseModel?.user!.id.toString()}');
                                                                  }
                                                                }

                                                              }
                                                            },

                                                            icon: stateSubscribeDetails is SuccessProductDetailsState ?
                                                            stateSubscribeDetails.showDetailsProductResponseModel![0].isSubscriber == true
                                                                ? const Icon(
                                                              Icons.favorite,
                                                              color: AppPalette.primary,
                                                            )
                                                                : stateSubscribeDetails.showDetailsProductResponseModel![0].isSubscriber == false ?
                                                            const Icon(
                                                              Icons.favorite_border,
                                                              color: AppPalette.primary,
                                                            ) : const SizedBox(
                                                                width: 15,height: 15,
                                                                child: CircularProgressIndicator(color: AppPalette.primary,)) :
                                                            const SizedBox(
                                                                width: 15,height: 15,
                                                                child: CircularProgressIndicator(color: AppPalette.primary,))
                                                            ,)
                                                      )
                                                  ),
                                                ),
                                                5.widthBox,
                                                Card(
                                                  shadowColor:
                                                  AppPalette
                                                      .white,
                                                  elevation: 0.0,
                                                  color:
                                                  AppPalette
                                                      .white,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          5)),
                                                  child:
                                                  Container(
                                                    width: 35.h,
                                                    height: 35.h,
                                                    child: Center(
                                                      child: IconButton(
                                                          color: AppPalette
                                                              .primary,
                                                          onPressed:
                                                              () async {
                                                            if (AppLocalStorage.token ==
                                                                null) {
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
                                                              print('phone user');
                                                              print(widget.showDetailsProductResponseModel?.user?.phoneNumber);
                                                              await callNumber(phoneNumber: '${widget.showDetailsProductResponseModel?.user?.phoneNumber}');
                                                            }
                                                          },
                                                          icon: SvgPicture
                                                              .asset(
                                                            "assets/images/svg/phoneCall.svg",
                                                            fit: BoxFit
                                                                .scaleDown,
                                                            color:
                                                            AppPalette.primary,
                                                          )),
                                                    ),
                                                  ),
                                                ),
                                                5.widthBox,
                                                Card(
                                                  shadowColor:
                                                  AppPalette
                                                      .white,
                                                  elevation: 0.0,
                                                  color:
                                                  AppPalette
                                                      .white,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          5)),
                                                  child:
                                                  Container(
                                                    width: 35.h,
                                                    height: 35.h,
                                                    child: Center(
                                                      child: IconButton(
                                                          color: AppPalette
                                                              .primary,
                                                          onPressed:
                                                              () async {
                                                                // var firebaseDynamicLinkService =
                                                                // await FirebaseDynamicLinkService.createDynamicLinkUser(
                                                                //     product: widget.showDetailsProductResponseModel);
                                                                //
                                                                // print('firebaseDynamicLinkService');
                                                                // print(firebaseDynamicLinkService);
                                                                // await Share.share('go to the product \n $firebaseDynamicLinkService',);
                                                          },
                                                          icon: SvgPicture
                                                              .asset(
                                                            "assets/images/svg/share.svg",
                                                            fit: BoxFit
                                                                .scaleDown,
                                                            color:
                                                            AppPalette.primary,
                                                          )),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                                : Row(
                                              children: [
                                                Card(
                                                  shadowColor:
                                                  AppPalette
                                                      .white,
                                                  elevation: 0.0,
                                                  color:
                                                  AppPalette
                                                      .white,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          5)),
                                                  child: Container(
                                                      width: 35.h,
                                                      height: 35.h,
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
                                                                if(stateSubscribeDetails is SuccessProductDetailsState){
                                                                  if (stateSubscribeDetails.showDetailsProductResponseModel![0].isSubscriber == true) {
                                                                    myFavoriteUserCubit.deleteSubscribeUserProduct('${widget.showDetailsProductResponseModel?.user!.id.toString()}');
                                                                  } else if (stateSubscribeDetails.showDetailsProductResponseModel![0].isSubscriber == false) {
                                                                    myFavoriteUserCubit.addSubscribeUserProduct('${widget.showDetailsProductResponseModel?.user!.id.toString()}');
                                                                  }
                                                                }

                                                              }
                                                            },

                                                            icon:  const Icon(
                                                              Icons.favorite_border,
                                                              color: AppPalette.primary,
                                                            ))
                                                      )
                                                  ),
                                                ),
                                                5.widthBox,
                                                Card(
                                                  shadowColor:
                                                  AppPalette
                                                      .white,
                                                  elevation: 0.0,
                                                  color:
                                                  AppPalette
                                                      .white,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          5)),
                                                  child:
                                                  Container(
                                                    width: 35.h,
                                                    height: 35.h,
                                                    child: Center(
                                                      child: IconButton(
                                                          color: AppPalette
                                                              .primary,
                                                          onPressed:
                                                              () async {
                                                            if (AppLocalStorage.token ==
                                                                null) {
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
                                                              print('phone user');
                                                              print(widget.showDetailsProductResponseModel?.user?.phoneNumber);
                                                              await callNumber(phoneNumber: '${widget.showDetailsProductResponseModel?.user?.phoneNumber}');
                                                            }
                                                          },
                                                          icon: SvgPicture
                                                              .asset(
                                                            "assets/images/svg/phoneCall.svg",
                                                            fit: BoxFit
                                                                .scaleDown,
                                                            color:
                                                            AppPalette.primary,
                                                          )),
                                                    ),
                                                  ),
                                                ),
                                                5.widthBox,
                                                Card(
                                                  shadowColor:
                                                  AppPalette
                                                      .white,
                                                  elevation: 0.0,
                                                  color:
                                                  AppPalette
                                                      .white,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          5)),
                                                  child:
                                                  Container(
                                                    width: 35.h,
                                                    height: 35.h,
                                                    child: Center(
                                                      child: IconButton(
                                                          color: AppPalette
                                                              .primary,
                                                          onPressed:
                                                              () async {
                                                                // var firebaseDynamicLinkService =
                                                                // await FirebaseDynamicLinkService.createDynamicLinkUser(
                                                                //     product: widget.showDetailsProductResponseModel);
                                                                //
                                                                // print('firebaseDynamicLinkService');
                                                                // print(firebaseDynamicLinkService);
                                                                // await Share.share('go to the product \n $firebaseDynamicLinkService',);
                                                          },
                                                          icon: SvgPicture
                                                              .asset(
                                                            "assets/images/svg/share.svg",
                                                            fit: BoxFit
                                                                .scaleDown,
                                                            color:
                                                            AppPalette.primary,
                                                          )),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        5.heightBox,
                                        stateFavoriteUser
                                        is AddSubscribeUserProductLoadingState
                                            ? const Center(
                                            child: SizedBox(
                                                width: 25,
                                                height: 25,
                                                child:
                                                CircularProgressIndicator(
                                                  color: AppPalette.white,
                                                )))
                                            : Container(),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          10.heightBox,
                          Expanded(
                            child: Container(
                              height: MediaQuery.of(context).size.height,
                              decoration: const BoxDecoration(
                                  color: AppPalette.white,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(25),
                                      topRight: Radius.circular(25))),
                              child: Padding(
                                padding:  EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      BlocBuilder<AppUiCubit, AppUiState>(
                                        builder: (context, state) {
                                          AppUiCubit appUICubit = AppUiCubit.get(context);
                                          return Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: Dimensions.paddingSize),
                                            child: ListView(
                                              physics: const BouncingScrollPhysics(),
                                              shrinkWrap: true,
                                              children: [
                                                25.heightBox,
                                                10.heightBox,
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(LocaleKeys.showingResults.tr(),
                                                        style: AppTextStyles.poppinsRegular
                                                            .copyWith(color: AppPalette.black)),
                                                    Text(
                                                        " ${filterCubit.myProductUserResponseModel!.length} ",
                                                        style: AppTextStyles.poppinsRegular),
                                                    Text(LocaleKeys.userProducts.tr(),
                                                        style: AppTextStyles.poppinsRegular
                                                            .copyWith(color: AppPalette.black)),
                                                    const Spacer(),
                                                    InkWell(
                                                      onTap: appUICubit.toggleView,
                                                      child: Icon(
                                                          appUICubit.isGrid
                                                              ? Icons.list_sharp
                                                              : Icons.grid_view_sharp,
                                                          color: AppPalette.black),
                                                    ),
                                                  ],
                                                ),
                                                // 8.heightBox,
                                                filterCubit.myProductUserResponseModel!.isNotEmpty
                                                    ? appUICubit.isGrid
                                                    ? GridView.builder(
                                                    shrinkWrap: true,
                                                    physics: const BouncingScrollPhysics(),
                                                    padding: EdgeInsets.symmetric(
                                                        vertical: 20.h),
                                                    gridDelegate:
                                                    SliverGridDelegateWithMaxCrossAxisExtent(
                                                      maxCrossAxisExtent: 200.0,
                                                      mainAxisSpacing: 5.0.h,
                                                      crossAxisSpacing: 15.0.w,
                                                      childAspectRatio: 1 / 1.69,
                                                    ),
                                                    itemCount: filterCubit
                                                        .myProductUserResponseModel!.length,
                                                    // itemBuilder: (context, index) => Container(
                                                    //   color: Colors.red,
                                                    // ),
                                                    itemBuilder: (context, index) {
                                                      return FilterProductItem(
                                                        product: filterCubit
                                                            .myProductUserResponseModel![
                                                        index],
                                                      );
                                                    })
                                                    : ListView.separated(
                                                  shrinkWrap: true,
                                                  physics: const BouncingScrollPhysics(),
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 20.h),
                                                  itemCount: filterCubit
                                                      .myProductUserResponseModel!.length,
                                                  // itemExtent: 200.0,
                                                  itemBuilder: (context, index) =>
                                                      FilterProductListItem(
                                                          product: filterCubit
                                                              .myProductUserResponseModel![
                                                          index]),
                                                  separatorBuilder: (context, index) =>
                                                  10.0.heightBox,
                                                )
                                                    : Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                                  children: [
                                                    // Padding(
                                                    //   padding: EdgeInsets.symmetric(
                                                    //     horizontal: Dimensions.paddingSizeDefault,
                                                    //   ),
                                                    //   child: Row(
                                                    //     mainAxisAlignment:
                                                    //     MainAxisAlignment.spaceBetween,
                                                    //     crossAxisAlignment: CrossAxisAlignment.start,
                                                    //     children: [
                                                    //       Text(
                                                    //         LocaleKeys.newRecommendations.tr(),
                                                    //         style:
                                                    //         Theme.of(context).textTheme.headline3,
                                                    //       ),
                                                    //     ],
                                                    //   ),
                                                    // ),
                                                    35.heightBox,
                                                    Center(
                                                      child: SvgPicture.asset(
                                                          "assets/images/svg/addProduct.svg",
                                                          height: 150,
                                                          width: 150,
                                                          fit: BoxFit.contain),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                return const Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                );
              },
            );
          } else if (state is ConnectionFailure) {
            return NoInternetConnectionScreen(
              appLayoutState: state,
            );
          } else {
            return Scaffold(
                body: Center(
                  child: AnimatedTextKit(
                    animatedTexts: [
                      WavyAnimatedText(LocaleKeys.markety.tr(),
                          textStyle: TextStyle(
                              fontSize: 20.0.sp,
                              color: Themes.colorApp13,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins-bold')),
                    ],
                    isRepeatingAnimation: true,
                    totalRepeatCount: 6,
                    onTap: () {},
                  ),
                ));
          }
        },
      ),
    );
  }
}
