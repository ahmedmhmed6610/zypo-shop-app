import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_launch/flutter_launch.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:pinch_zoom/pinch_zoom.dart';
import 'package:shop/helpers/components.dart';
import 'package:shop/utils/app_palette.dart';
import 'package:photo_view/photo_view_gallery.dart';

import '../../../business_logic/profile_cubit/profile_cubit.dart';
import '../../../helpers/app_local_storage.dart';
import '../../../helpers/call_helper.dart';
import '../../../libraries/dialog_widget.dart';
import '../../../translations/locale_keys.g.dart';
import '../../../utils/dimensions.dart';
import '../../../utils/styles.dart';
import '../../base/custom_button.dart';
import '../auth/login_screen.dart';

class ImageDetailsZoomScreen extends StatefulWidget {
  List<String> images = [];
  String phoneNumber, whatsAppNumber, productName;
  int userId;

  ImageDetailsZoomScreen(
      {Key? key,
      required this.userId,
      required this.images,
      required this.productName,
      required this.phoneNumber,
      required this.whatsAppNumber})
      : super(key: key);

  @override
  _ImageDetailsZoomScreenState createState() => _ImageDetailsZoomScreenState();
}

class _ImageDetailsZoomScreenState extends State<ImageDetailsZoomScreen> {
  String? lottie;
  int countLengthImage = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<ProfileCubit>(context).getUserProfile();
    print('image is ${widget.images.length}');
  }

  @override
  Widget build(BuildContext context) {
    final stateProfile = context.watch<ProfileCubit>().state;
    // TODO: implement build
    return Scaffold(
      backgroundColor: AppPalette.black,
      // appBar: AppBar(
      //   title: Text('Gallery'),
      // ),
      // Implemented with a PageView, simpler than setting it up yourself
      // You can either specify images directly or by using a builder as in this tutorial
      body: SafeArea(
        child: Column(
          children: [
            heightSeperator(10.h),
            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                child: Row(
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${countLengthImage}',
                            style: TextStyle(
                              color: AppPalette.white,
                              fontFamily: Fonts.poppins,
                              fontWeight: FontWeight.w300,
                              fontSize: Dimensions.fontSizeExtraExtraLarge,
                            ),
                          ),
                          widthSeparator(2.w),
                          Text(
                            '/',
                            style: TextStyle(
                              color: AppPalette.white,
                              fontFamily: Fonts.poppins,
                              fontWeight: FontWeight.w300,
                              fontSize: Dimensions.fontSizeExtraExtraLarge,
                            ),
                          ),
                          widthSeparator(2.w),
                          Text(
                            '${widget.images.length}',
                            style: TextStyle(
                              color: AppPalette.white,
                              fontFamily: Fonts.poppins,
                              fontWeight: FontWeight.w300,
                              fontSize: Dimensions.fontSizeExtraExtraLarge,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Text(
                        widget.productName,
                        style: TextStyle(
                          color: AppPalette.white,
                          fontFamily: Fonts.poppins,
                          fontWeight: FontWeight.w300,
                          fontSize: Dimensions.fontSizeLarge,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                              child: Icon(Icons.cancel_outlined,
                                  color: AppPalette.white, size: 25),
                          onTap: (){
                                Navigator.pop(context);
                          },),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: SizedBox(
                height: 200.h,
                child: PhotoViewGallery.builder(
                  onPageChanged: (page) {
                   setState(() {
                     print('page $page');
                     countLengthImage = page + 1;
                     print('page current $countLengthImage');
                   });
                  },
                  itemCount: widget.images.length,
                  builder: (context, index) {
                    return PhotoViewGalleryPageOptions(
                      imageProvider: NetworkImage(
                        widget.images[index],
                      ),
                      // Contained = the smallest possible size to fit one dimension of the screen
                      minScale: PhotoViewComputedScale.contained * 0.8,
                      // Covered = the smallest possible size to fit the whole screen
                      maxScale: PhotoViewComputedScale.covered * 2,
                    );
                  },
                  scrollPhysics: BouncingScrollPhysics(),
                  // Set the background color to the "classic white"
                  backgroundDecoration: BoxDecoration(
                    color: Theme.of(context).canvasColor,
                  ),
                  scrollDirection: Axis.horizontal,
                  loadingBuilder: (context, event) {
                    return Center(child: CircularProgressIndicator());
                  },
                  // loadingChild: Center(
                  //   child: CircularProgressIndicator(),
                  // ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  heightSeperator(50.h),
                  AppLocalStorage.token != null
                      ? stateProfile is SuccessProfileState
                          ? stateProfile.userDataModel!.user!.id ==
                                  widget.userId
                              ? Container()
                              : Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 10.w),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: CustomButton(
                                          buttonText: LocaleKeys.call.tr(),
                                          onPressed: () async {
                                            if (AppLocalStorage.token == null) {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) => Dialog(
                                                        backgroundColor:
                                                            Colors.white,
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    Dimensions
                                                                        .radiusDefault)),
                                                        alignment: Alignment
                                                            .bottomCenter,
                                                        insetPadding: EdgeInsets
                                                            .symmetric(
                                                                vertical: Dimensions
                                                                    .paddingSize,
                                                                horizontal:
                                                                    Dimensions
                                                                        .paddingSize),
                                                        child:
                                                            CustomDialogWidget(
                                                          msgStyle:
                                                              const TextStyle(
                                                                  height: 2),
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
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                          actions: [
                                                            Padding(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          Dimensions
                                                                              .paddingSizeLarge),
                                                              child:
                                                                  IconsButton(
                                                                onPressed:
                                                                    () async {
                                                                  // addProductCubit.deleteProductItem(context,productId: product.id.toString(),isSold: '0');
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                text: LocaleKeys
                                                                    .cancel
                                                                    .tr(),
                                                                // color: Colors.transparent,
                                                                shape: OutlineInputBorder(
                                                                    borderSide: const BorderSide(
                                                                        color: AppPalette
                                                                            .black),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            Dimensions.radiusDefault)),
                                                                textStyle: const TextStyle(
                                                                    color: Colors
                                                                        .black),
                                                                padding: EdgeInsets.symmetric(
                                                                    horizontal:
                                                                        Dimensions
                                                                            .paddingSizeExtraSmall,
                                                                    vertical:
                                                                        Dimensions
                                                                            .paddingSizeDefault),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          Dimensions
                                                                              .paddingSizeLarge),
                                                              child:
                                                                  IconsButton(
                                                                onPressed: () {
                                                                  //  addProductCubit.deleteProductItem(context,productId: product.id.toString(),isSold: '1');
                                                                  Navigator.of(
                                                                          context)
                                                                      .push(MaterialPageRoute(
                                                                          builder: (context) =>
                                                                              const LoginScreen()));
                                                                },
                                                                text: LocaleKeys
                                                                    .login
                                                                    .tr(),
                                                                // iconData: Icons.done,
                                                                color: AppPalette
                                                                    .primary,
                                                                textStyle: const TextStyle(
                                                                    color: Colors
                                                                        .white),
                                                                shape: OutlineInputBorder(
                                                                    borderSide:
                                                                        BorderSide
                                                                            .none,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            Dimensions.radiusDefault)),
                                                                padding: EdgeInsets.symmetric(
                                                                    horizontal:
                                                                        Dimensions
                                                                            .paddingSizeExtraSmall,
                                                                    vertical:
                                                                        Dimensions
                                                                            .paddingSizeDefault),
                                                                // iconColor: Colors.white,
                                                              ),
                                                            ),
                                                          ],
                                                          animationBuilder:
                                                              lottie != null
                                                                  ? LottieBuilder
                                                                      .asset(
                                                                      lottie
                                                                          .toString(),
                                                                    )
                                                                  : null,
                                                          customView:
                                                              Dialogs.holder,
                                                          color: Colors.white,
                                                        ),
                                                      ));
                                            } else {
                                              await callNumber(
                                                  phoneNumber:
                                                      widget.phoneNumber);
                                            }
                                          },
                                          svgIcon:
                                              "assets/images/svg/phoneCall.svg",
                                          height: 42.h,
                                          fontSize: Dimensions.fontSizeLarge,
                                        ),
                                      ),
                                      widthSeparator(10.w),
                                      Expanded(
                                        child: CustomButton(
                                          buttonText: LocaleKeys.whatsApp.tr(),
                                          onPressed: () async {
                                            if (AppLocalStorage.token == null) {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) => Dialog(
                                                        backgroundColor:
                                                            Colors.white,
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    Dimensions
                                                                        .radiusDefault)),
                                                        alignment: Alignment
                                                            .bottomCenter,
                                                        insetPadding: EdgeInsets
                                                            .symmetric(
                                                                vertical: Dimensions
                                                                    .paddingSize,
                                                                horizontal:
                                                                    Dimensions
                                                                        .paddingSize),
                                                        child:
                                                            CustomDialogWidget(
                                                          msgStyle:
                                                              const TextStyle(
                                                                  height: 2),
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
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                          actions: [
                                                            Padding(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          Dimensions
                                                                              .paddingSizeLarge),
                                                              child:
                                                                  IconsButton(
                                                                onPressed:
                                                                    () async {
                                                                  // addProductCubit.deleteProductItem(context,productId: product.id.toString(),isSold: '0');
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                text: LocaleKeys
                                                                    .cancel
                                                                    .tr(),
                                                                // color: Colors.transparent,
                                                                shape: OutlineInputBorder(
                                                                    borderSide: const BorderSide(
                                                                        color: AppPalette
                                                                            .black),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            Dimensions.radiusDefault)),
                                                                textStyle: const TextStyle(
                                                                    color: Colors
                                                                        .black),
                                                                padding: EdgeInsets.symmetric(
                                                                    horizontal:
                                                                        Dimensions
                                                                            .paddingSizeExtraSmall,
                                                                    vertical:
                                                                        Dimensions
                                                                            .paddingSizeDefault),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          Dimensions
                                                                              .paddingSizeLarge),
                                                              child:
                                                                  IconsButton(
                                                                onPressed: () {
                                                                  //  addProductCubit.deleteProductItem(context,productId: product.id.toString(),isSold: '1');
                                                                  Navigator.of(
                                                                          context)
                                                                      .push(MaterialPageRoute(
                                                                          builder: (context) =>
                                                                              const LoginScreen()));
                                                                },
                                                                text: LocaleKeys
                                                                    .login
                                                                    .tr(),
                                                                // iconData: Icons.done,
                                                                color: AppPalette
                                                                    .primary,
                                                                textStyle: const TextStyle(
                                                                    color: Colors
                                                                        .white),
                                                                shape: OutlineInputBorder(
                                                                    borderSide:
                                                                        BorderSide
                                                                            .none,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            Dimensions.radiusDefault)),
                                                                padding: EdgeInsets.symmetric(
                                                                    horizontal:
                                                                        Dimensions
                                                                            .paddingSizeExtraSmall,
                                                                    vertical:
                                                                        Dimensions
                                                                            .paddingSizeDefault),
                                                                // iconColor: Colors.white,
                                                              ),
                                                            ),
                                                          ],
                                                          animationBuilder:
                                                              lottie != null
                                                                  ? LottieBuilder
                                                                      .asset(
                                                                      lottie
                                                                          .toString(),
                                                                    )
                                                                  : null,
                                                          customView:
                                                              Dialogs.holder,
                                                          color: Colors.white,
                                                        ),
                                                      ));
                                            } else {
                                              print('whatsAppNumber ${widget.whatsAppNumber}');

                                              if(widget.whatsAppNumber != 'null'){
                                                bool whatsapp =
                                                await FlutterLaunch.hasApp(name: "whatsapp");

                                                if (whatsapp) {
                                                  await FlutterLaunch.launchWhatsapp(
                                                      phone: widget.whatsAppNumber, message: '');
                                                } else {
                                                  print("Whatsapp não instalado");
                                                }
                                              }else {

                                                AwesomeDialog(
                                                  context: context,
                                                  dialogType: DialogType.warning,
                                                  animType: AnimType.leftSlide,
                                                  title: LocaleKeys.warning.tr(),
                                                  desc: LocaleKeys.whatsAppNotFound.tr(),
                                                  btnOkText: LocaleKeys.ok.tr(),
                                                  btnCancelText: LocaleKeys.cancel.tr(),
                                                  btnCancelOnPress: () {},
                                                  btnOkOnPress: () {},
                                                ).show();

                                              }

                                            }
                                          },
                                          svgIcon:
                                              "assets/images/svg/icon_whatsapp.svg",
                                          height: 42.h,
                                          fontSize: Dimensions.fontSizeLarge,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                          : Container()
                      : Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: Row(
                            children: [
                              Expanded(
                                child: CustomButton(
                                  buttonText: LocaleKeys.call.tr(),
                                  onPressed: () async {
                                    if (AppLocalStorage.token == null) {
                                      showDialog(
                                          context: context,
                                          builder: (context) => Dialog(
                                                backgroundColor: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius
                                                        .circular(Dimensions
                                                            .radiusDefault)),
                                                alignment:
                                                    Alignment.bottomCenter,
                                                insetPadding:
                                                    EdgeInsets.symmetric(
                                                        vertical: Dimensions
                                                            .paddingSize,
                                                        horizontal: Dimensions
                                                            .paddingSize),
                                                child: CustomDialogWidget(
                                                  msgStyle: const TextStyle(
                                                      height: 2),
                                                  title: LocaleKeys
                                                      .youHaveToLoginFirst
                                                      .tr(),
                                                  msg: LocaleKeys
                                                      .loginAndSellBuy
                                                      .tr(),
                                                  titleStyle: const TextStyle(
                                                    color: Colors.blueGrey,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  actions: [
                                                    Padding(
                                                      padding: EdgeInsets.symmetric(
                                                          horizontal: Dimensions
                                                              .paddingSizeLarge),
                                                      child: IconsButton(
                                                        onPressed: () async {
                                                          // addProductCubit.deleteProductItem(context,productId: product.id.toString(),isSold: '0');
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        text: LocaleKeys.cancel
                                                            .tr(),
                                                        // color: Colors.transparent,
                                                        shape: OutlineInputBorder(
                                                            borderSide:
                                                                const BorderSide(
                                                                    color: AppPalette
                                                                        .black),
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    Dimensions
                                                                        .radiusDefault)),
                                                        textStyle:
                                                            const TextStyle(
                                                                color: Colors
                                                                    .black),
                                                        padding: EdgeInsets.symmetric(
                                                            horizontal: Dimensions
                                                                .paddingSizeExtraSmall,
                                                            vertical: Dimensions
                                                                .paddingSizeDefault),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.symmetric(
                                                          horizontal: Dimensions
                                                              .paddingSizeLarge),
                                                      child: IconsButton(
                                                        onPressed: () {
                                                          //  addProductCubit.deleteProductItem(context,productId: product.id.toString(),isSold: '1');
                                                          Navigator.of(context).push(
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          const LoginScreen()));
                                                        },
                                                        text: LocaleKeys.login
                                                            .tr(),
                                                        // iconData: Icons.done,
                                                        color:
                                                            AppPalette.primary,
                                                        textStyle:
                                                            const TextStyle(
                                                                color: Colors
                                                                    .white),
                                                        shape: OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide.none,
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    Dimensions
                                                                        .radiusDefault)),
                                                        padding: EdgeInsets.symmetric(
                                                            horizontal: Dimensions
                                                                .paddingSizeExtraSmall,
                                                            vertical: Dimensions
                                                                .paddingSizeDefault),
                                                        // iconColor: Colors.white,
                                                      ),
                                                    ),
                                                  ],
                                                  animationBuilder:
                                                      lottie != null
                                                          ? LottieBuilder.asset(
                                                              lottie.toString(),
                                                            )
                                                          : null,
                                                  customView: Dialogs.holder,
                                                  color: Colors.white,
                                                ),
                                              ));
                                    } else {
                                      await callNumber(
                                          phoneNumber: widget.phoneNumber);
                                    }
                                  },
                                  svgIcon: "assets/images/svg/phoneCall.svg",
                                  height: 42.h,
                                  fontSize: Dimensions.fontSizeLarge,
                                ),
                              ),
                              widthSeparator(5.w),
                              Expanded(
                                child: CustomButton(
                                  buttonText: LocaleKeys.whatsApp.tr(),
                                  onPressed: () async {
                                    if (AppLocalStorage.token == null) {
                                      showDialog(
                                          context: context,
                                          builder: (context) => Dialog(
                                                backgroundColor: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius
                                                        .circular(Dimensions
                                                            .radiusDefault)),
                                                alignment:
                                                    Alignment.bottomCenter,
                                                insetPadding:
                                                    EdgeInsets.symmetric(
                                                        vertical: Dimensions
                                                            .paddingSize,
                                                        horizontal: Dimensions
                                                            .paddingSize),
                                                child: CustomDialogWidget(
                                                  msgStyle: const TextStyle(
                                                      height: 2),
                                                  title: LocaleKeys
                                                      .youHaveToLoginFirst
                                                      .tr(),
                                                  msg: LocaleKeys
                                                      .loginAndSellBuy
                                                      .tr(),
                                                  titleStyle: const TextStyle(
                                                    color: Colors.blueGrey,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  actions: [
                                                    Padding(
                                                      padding: EdgeInsets.symmetric(
                                                          horizontal: Dimensions
                                                              .paddingSizeLarge),
                                                      child: IconsButton(
                                                        onPressed: () async {
                                                          // addProductCubit.deleteProductItem(context,productId: product.id.toString(),isSold: '0');
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        text: LocaleKeys.cancel
                                                            .tr(),
                                                        // color: Colors.transparent,
                                                        shape: OutlineInputBorder(
                                                            borderSide:
                                                                const BorderSide(
                                                                    color: AppPalette
                                                                        .black),
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    Dimensions
                                                                        .radiusDefault)),
                                                        textStyle:
                                                            const TextStyle(
                                                                color: Colors
                                                                    .black),
                                                        padding: EdgeInsets.symmetric(
                                                            horizontal: Dimensions
                                                                .paddingSizeExtraSmall,
                                                            vertical: Dimensions
                                                                .paddingSizeDefault),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.symmetric(
                                                          horizontal: Dimensions
                                                              .paddingSizeLarge),
                                                      child: IconsButton(
                                                        onPressed: () {
                                                          //  addProductCubit.deleteProductItem(context,productId: product.id.toString(),isSold: '1');
                                                          Navigator.of(context).push(
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          const LoginScreen()));
                                                        },
                                                        text: LocaleKeys.login
                                                            .tr(),
                                                        // iconData: Icons.done,
                                                        color:
                                                            AppPalette.primary,
                                                        textStyle:
                                                            const TextStyle(
                                                                color: Colors
                                                                    .white),
                                                        shape: OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide.none,
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    Dimensions
                                                                        .radiusDefault)),
                                                        padding: EdgeInsets.symmetric(
                                                            horizontal: Dimensions
                                                                .paddingSizeExtraSmall,
                                                            vertical: Dimensions
                                                                .paddingSizeDefault),
                                                        // iconColor: Colors.white,
                                                      ),
                                                    ),
                                                  ],
                                                  animationBuilder:
                                                      lottie != null
                                                          ? LottieBuilder.asset(
                                                              lottie.toString(),
                                                            )
                                                          : null,
                                                  customView: Dialogs.holder,
                                                  color: Colors.white,
                                                ),
                                              ));
                                    } else {
                                      bool whatsapp =
                                          await FlutterLaunch.hasApp(
                                              name: "whatsapp");

                                      if (whatsapp) {
                                        await FlutterLaunch.launchWhatsapp(
                                            phone: widget.whatsAppNumber,
                                            message: '');
                                      } else {
                                        print("Whatsapp não instalado");
                                      }
                                    }
                                  },
                                  svgIcon:
                                      "assets/images/svg/icon_whatsapp.svg",
                                  height: 42.h,
                                  fontSize: Dimensions.fontSizeLarge,
                                ),
                              ),
                            ],
                          ),
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
