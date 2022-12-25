
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:shop/business_logic/add_ads_poduct_cubit/add_ads_product_cubit.dart';
import 'package:shop/helpers/components.dart';
import 'package:shop/ui/screens/layout/app_layout.dart';

import '../../../libraries/dialog_widget.dart';
import '../../../translations/locale_keys.g.dart';
import '../../../utils/app_palette.dart';
import '../../../utils/dimensions.dart';
import '../../../utils/styles.dart';
import '../../base/custom_button.dart';
import '../../base/custom_toast.dart';
import '../../widgets/My_products_widgets/add_product_widgets/input_text_form_field.dart';
import '../../widgets/common_widgets/dialogs/success_dialog.dart';
import '../edit_images_product_screen/edit_images_product_screen.dart';

class AddAdsScreen extends StatefulWidget {
  const AddAdsScreen({Key? key}) : super(key: key);

  @override
  State<AddAdsScreen> createState() => _AddAdsScreenState();
}

class _AddAdsScreenState extends State<AddAdsScreen> {

  TextEditingController addLinkController = TextEditingController();

  List<String> profileImageList = [
    "https://img.freepik.com/free-vector/cute-gentleman-character-illustration_24877-"
        "60133.jpg?t=st=1658505623~exp=1658506223~hmac=3ee77155aae3cea1d1f3d7eccb20aa72617e4dfb894551a6223da59d10b52718&w=740",
  ];

  File? image1;
  String? fileName;
  String? lottie;
  List<String>? imagesList;
  List<File> images = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: Theme.of(context).iconTheme,
        title: Text(LocaleKeys.addAds.tr()),
        leading: InkWell(
          onTap: () => Navigator.of(context).pop(),
          child: const Icon(Icons.arrow_back_ios,
              size: 20.0, color: AppPalette.black),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: BlocConsumer<AddAdsProductCubit,AddAdsProductState>(
              listener: (context, state) {
                if(state is AddAdsProductSuccessfully){
                  SuccessAlertDialog.showConfirmationDialog(context,
                      title: '${state.message}',
                      confirmLabel: "Done",
                      imageUrl: "assets/images/svg/addProduct.svg", onTap: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => AppLayout(),
                        ));
                      });

                }else if (state is AddAdsProductFailure){
                  customFlutterToast(state.message);
                }
              },
              builder: (context, state) {
                AddAdsProductCubit addAdsProductCubit = AddAdsProductCubit.get(context);
                return Column(
                  children: [
                    SizedBox(
                      height: 215.h,
                      width: MediaQuery.of(context).size.width,
                      child: Swiper(
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: [
                              GestureDetector(
                                onTap: (){
                                  // _dialogBuilder(context, images[index]);
                                  // Navigator.push(context, MaterialPageRoute(
                                  //     builder: (context) => ImageDetailsZoomScreen(images: images,productName: productName,
                                  //       phoneNumber: phoneNumber ,whatsAppNumber: whatsAppNumber, userId: userId,)));
                                  // print(images[index]);
                                },
                                child: image1 != null ? Image.file(image1!,fit: BoxFit.cover,
                                  height: 175.h,  width: MediaQuery.of(context).size.width,) :
                                Container(
                                  height: 175.h,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                                    image: DecorationImage(
                                        image: CachedNetworkImageProvider(profileImageList[index],),
                                        fit: BoxFit.fill),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10.h,
                                width: MediaQuery.of(context).size.width,
                              ),
                            ],
                          );
                        },
                        itemCount: profileImageList.length,
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
                    heightSeperator(15.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CustomButton(
                          height: 60,
                          width: 60,
                          icon: Icons.add_a_photo_rounded,
                          onPressed: () async{
                            showDialog(
                                context: context,
                                builder: (context) =>
                                    Dialog(
                                      backgroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(Dimensions.radiusDefault)),
                                      alignment: Alignment.bottomCenter,
                                      insetPadding: EdgeInsets.symmetric(
                                          vertical: Dimensions.paddingSize, horizontal: Dimensions.paddingSize),
                                      child: CustomDialogWidget(
                                        msgStyle: const TextStyle(height: 2),
                                        //   title: LocaleKeys.chosePhotoWith.tr(),
                                        titleStyle: const TextStyle(
                                          color: Colors.blueGrey,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        actions: [
                                          Padding(
                                            padding:
                                            EdgeInsets.symmetric(horizontal: Dimensions.paddingSmall),
                                            child: IconsButton(
                                              onPressed: () async {
                                                try {
                                                  final image = await ImagePicker()
                                                      .pickImage(
                                                      source:
                                                      ImageSource.gallery);
                                                  if (image ==
                                                      null)
                                                    return;
                                                  final iamgeTempoary =
                                                  File(image
                                                      .path);
                                                  setState(() =>
                                                  image1 =
                                                      iamgeTempoary);
                                                  // addProductCubit.updateImageProduct(context, stateProductDetails.myFavoriteResponseModel![0].id.toString(), image1!);
                                                } on PlatformException catch (e) {
                                                  if (kDebugMode) {
                                                    print(e);
                                                  }
                                                }
                                                Navigator.pop(context);
                                              },
                                              text: LocaleKeys.gallery.tr(),
                                              // color: Colors.transparent,
                                              shape: OutlineInputBorder(
                                                  borderSide: const BorderSide(color: AppPalette.black),
                                                  borderRadius:
                                                  BorderRadius.circular(Dimensions.radiusDefault)),
                                              textStyle: const TextStyle(color: Colors.black),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: Dimensions.paddingSizeExtraSmall,
                                                  vertical: Dimensions.paddingSizeDefault),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                            EdgeInsets.symmetric(horizontal: Dimensions.paddingSmall),
                                            child: IconsButton(
                                              onPressed: () async {
                                                try {
                                                  final image = await ImagePicker()
                                                      .pickImage(
                                                      source:
                                                      ImageSource.camera);
                                                  if (image ==
                                                      null)
                                                    return;
                                                  final iamgeTempoary =
                                                  File(image
                                                      .path);
                                                  setState(() =>
                                                  image1 =
                                                      iamgeTempoary);
                                                  // addProductCubit.updateImageProduct(context, stateProductDetails.myFavoriteResponseModel![0].id.toString(), image1!);
                                                } on PlatformException catch (e) {
                                                  if (kDebugMode) {
                                                    print(e);
                                                  }
                                                }
                                                Navigator.pop(context);
                                              },
                                              text: LocaleKeys.camera.tr(),
                                              // iconData: Icons.done,
                                              color: AppPalette.primary,
                                              textStyle: const TextStyle(color: Colors.white),
                                              shape: OutlineInputBorder(
                                                  borderSide: BorderSide.none,
                                                  borderRadius:
                                                  BorderRadius.circular(Dimensions.radiusDefault)),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: Dimensions.paddingSizeExtraSmall,
                                                  vertical: Dimensions.paddingSizeDefault),
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
                                    )
                            );
                          },
                          buttonText: '',
                        ),
                        widthSeparator(10.w),
                        Text(
                          LocaleKeys.addImageAds.tr(),
                          style: TextStyle(
                            color: AppPalette.black,
                            fontFamily: Fonts.poppins,
                            fontWeight: FontWeight.w300,
                            fontSize: Dimensions.fontSizeLarge,
                          ),
                        ),
                      ],
                    ),
                    heightSeperator(15.h),
                    InputTextFormField(
                      hintText: LocaleKeys.addLink.tr(),
                      textEditingController: addLinkController,
                      textInputType: TextInputType.url,
                      validator: (val) {
                        // if (val.isEmpty) {
                        //   return LocaleKeys.mustNotEmpty.tr();
                        // }
                      },
                    ),
                    heightSeperator(15.h),
                    Row(
                      children: [
                        Text(
                          LocaleKeys.instructions.tr(),
                          style: TextStyle(
                            color: AppPalette.black,
                            fontFamily: Fonts.poppins,
                            fontWeight: FontWeight.w500,
                            fontSize: Dimensions.fontSizeDefault,
                          ),
                        ),
                      ],
                    ),
                    heightSeperator(10.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 7,
                          width: 7,
                          child: CircleAvatar(
                            backgroundColor: AppPalette.black,
                            radius: 25,
                          ),
                        ),
                        widthSeparator(5.w),
                        Expanded(
                          child: Text(
                            LocaleKeys.imageMustUpload.tr(),
                            maxLines: 2,
                            style: TextStyle(
                              color: AppPalette.black,
                              fontFamily: Fonts.poppins,
                              fontWeight: FontWeight.w300,
                              fontSize: Dimensions.fontSizeDefault,
                            ),
                          ),
                        ),
                      ],
                    ),
                    heightSeperator(7.h),
                    Row(
                      children: [
                        const SizedBox(
                          height: 7,
                          width: 7,
                          child: CircleAvatar(
                            backgroundColor: AppPalette.black,
                            radius: 25,
                          ),
                        ),
                        widthSeparator(5.w),
                        Expanded(
                          child: Text(
                            LocaleKeys.addLinkAdvertisement.tr(),
                            maxLines: 2,
                            style: TextStyle(
                              color: AppPalette.black,
                              fontFamily: Fonts.poppins,
                              fontWeight: FontWeight.w300,
                              fontSize: Dimensions.fontSizeDefault,
                            ),
                          ),
                        ),
                      ],
                    ),
                    heightSeperator(7.h),
                    Row(
                      children: [
                        const SizedBox(
                          height: 7,
                          width: 7,
                          child: CircleAvatar(
                            backgroundColor: AppPalette.black,
                            radius: 25,
                          ),
                        ),
                        widthSeparator(5.w),
                        Expanded(
                          child: Text(
                            LocaleKeys.advertisementWillBeAccepted.tr(),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: AppPalette.black,
                              fontFamily: Fonts.poppins,
                              fontWeight: FontWeight.w300,
                              fontSize: Dimensions.fontSizeDefault,
                            ),
                          ),
                        ),
                      ],
                    ),
                    heightSeperator(10.h),
                    state is AddAdsProductLoading
                        ? const Center(
                      child: CircularProgressIndicator(),
                    ) : Container(
                      padding: EdgeInsets.only(
                        bottom: Dimensions.paddingSizeDefault,
                        right: Dimensions.paddingSizeDefault,
                        left: Dimensions.paddingSizeDefault,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        top: Dimensions.paddingSizeExtraMediumLarge,
                        bottom: Dimensions.paddingSizeExtraSmall,
                        right: Dimensions.paddingSizeExtraSmall,
                        left: Dimensions.paddingSizeExtraSmall,
                      ),
                      child: CustomButton(
                        buttonText: LocaleKeys.save.tr(),
                        onPressed: () {
                          print('option list is ${addLinkController.text}');
                          print('option list is $fileName');
                          addAdsProductCubit.addAdsProductUser(context, addLinkController.text, image1!);
                        },
                        height: 48.h,
                        fontSize: Dimensions.fontSizeLarge,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
