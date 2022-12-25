
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:shop/business_logic/app_layout_cubit/app_layout_cubit.dart';
import 'package:shop/data/internet_connectivity/error_screens_connection.dart';
import 'package:shop/data/internet_connectivity/no_internet.dart';
import 'package:shop/helpers/components.dart';
import 'package:shop/ui/screens/add_products_screen/change_product_screen2.dart';
import 'package:shop/utils/app_size_boxes.dart';

import '../../../business_logic/my_products_cubit/my_products_cubit.dart';
import '../../../business_logic/my_products_cubit/my_products_state.dart';
import '../../../business_logic/product_details_cubit/product_details_cubit.dart';
import '../../../data/models/product_model.dart';
import '../../../data/models/show_details_product_model.dart';
import '../../../libraries/dialog_widget.dart';
import '../../../translations/locale_keys.g.dart';
import '../../../utils/app_palette.dart';
import '../../../utils/dimensions.dart';
import '../../../utils/styles.dart';
import '../../base/custom_button.dart';
import '../../base/custom_toast.dart';
import '../../widgets/My_products_widgets/add_product_widgets/input_text_form_field.dart';
import '../../widgets/My_products_widgets/add_product_widgets/update_images_section_widget.dart';
import '../../widgets/common_widgets/dialogs/success_dialog.dart';
import '../filter_screens/widget_custom.dart';

class EditImagesProductScreen extends StatefulWidget {
  final ShowDetailsProductResponseModel productModel;
  final ProductModel? product;
  final int? productId;
  final String? productName;
  const EditImagesProductScreen({Key? key,required this.productModel,required this.productId,
  required this.productName,required this.product}) : super(key: key);

  @override
  State<EditImagesProductScreen> createState() => _EditImagesProductScreenState();
}

class _EditImagesProductScreenState extends State<EditImagesProductScreen> {

  String? lottie;
  File? image1;
  File? image2;
  File? image3;
  File? image4;
  File? image5;
  late String images;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   // BlocProvider.of<ProductDetailsCubit>(context).getProductDetailsUser(stateProductDetails.showDetailsProductResponseModel![0].id!);
    print('product id ${widget.productModel.id}');
  }
  @override
  Widget build(BuildContext context) {
   // final stateProductDetails = context.watch<ProductDetailsCubit>().state;
   final stateProductConnection = context.watch<AppLayoutCubit>().state;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProductDetailsCubit()..getProductDetailsUser('${widget.product?.id}')
        ),
      ],
      child: WillPopScope(
        onWillPop: () async{
          BlocProvider.of<ProductDetailsCubit>(context).getProductDetailsUser('${widget.product?.id}');
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => ChangeProductScreen2(
                  product: widget.product
              )));
          return false;
        },
        child: Scaffold(
          backgroundColor: AppPalette.primary,
          body: CustomAppBar(
            onTap: () {
              BlocProvider.of<ProductDetailsCubit>(context).getProductDetailsUser('${widget.product?.id}');
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => ChangeProductScreen2(
                      product: widget.product
                  )));
            },
            title: LocaleKeys.editImageAds.tr(),
            widgetCustom:  stateProductConnection is ConnectionSuccess ?
            BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
              builder: (context, stateProductDetails) {
                if (stateProductDetails is SuccessProductDetailsState) {
                  ProductDetailsCubit productDetailsCubit = ProductDetailsCubit.get(context);
                  return  Scaffold(
                    backgroundColor: AppPalette.white,
                    body: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            BlocConsumer<AddProductCubit, AddProductState>(
                              listener: (context, addProductState) {
                                if (addProductState is UpdateImageErrorState) {
                                  // customFlutterToast(addProductState.message);
                                  //  AwesomeDialog(
                                  //    context: context,
                                  //    btnOkText: LocaleKeys.ok.tr(),
                                  //    btnCancelText: LocaleKeys.cancel.tr(),
                                  //    dialogType: DialogType.warning,
                                  //    animType: AnimType.rightSlide,
                                  //    title: LocaleKeys.errorConnectionScreens.tr(),
                                  //    desc: LocaleKeys.errorConnectionScreens2.tr(),
                                  //    btnCancelOnPress: () {
                                  //      Navigator.of(context).pushReplacement(MaterialPageRoute(
                                  //          builder: (context) => EditImagesProductScreen(
                                  //        productId: widget.productId,
                                  //        product: widget.product,
                                  //        productModel: stateProductDetails.showDetailsProductResponseModel![0],
                                  //        productName: '',)));
                                  //    },
                                  //    btnOkOnPress: () {
                                  //      Navigator.of(context).pushReplacement(MaterialPageRoute(
                                  //          builder: (context) => EditImagesProductScreen(
                                  //        productId: widget.productId,
                                  //        product: widget.product,
                                  //        productModel: stateProductDetails.showDetailsProductResponseModel![0],
                                  //        productName: '',)));
                                  //    },
                                  //  ).show();
                                } else if (addProductState is UpdateImageSuccessState) {
                                  SuccessAlertDialog.showConfirmationDialog(context,
                                      title: '${addProductState.message}',
                                      confirmLabel: "Done",
                                      imageUrl: "assets/images/svg/addProduct.svg", onTap: () {
                                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                                          builder: (context) => EditImagesProductScreen(
                                            productId: widget.productId,
                                            product: widget.product,
                                            productModel: stateProductDetails.showDetailsProductResponseModel![0],
                                            productName: '',),
                                        ));
                                      });
                                }
                              },
                              builder: (context, state) {
                                AddProductCubit addProductCubit = AddProductCubit.get(context);
                                return Column(
                                  children: [
                                    heightSeperator(15.h),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Stack(
                                          children: <Widget>[
                                            InkWell(
                                              onTap: () async{
                                                if(stateProductDetails.showDetailsProductResponseModel![0].images!.isNotEmpty){
                                                  if(stateProductDetails.showDetailsProductResponseModel![0].images![0].name == null){
                                                  }
                                                }else {
                                                  selectImageByCameraOrGallery(context, image1, lottie,
                                                      addProductCubit,stateProductDetails.showDetailsProductResponseModel![0].id.toString());
                                                }
                                                //   print('images list ${stateProductDetails.showDetailsProductResponseModel![0].images!.length}');
                                              },
                                              child: Container(
                                                  margin: EdgeInsets.symmetric(
                                                      horizontal: Dimensions.paddingSizeExtraSmall),
                                                  height: 125.h,
                                                  width: 125.w,
                                                  decoration: BoxDecoration(
                                                    color: AppPalette.lightPrimary,
                                                    borderRadius: BorderRadius.circular(
                                                        Dimensions.radiusDefault),
                                                  ),
                                                  child: image1 != null ? Image.file(image1!,fit: BoxFit.cover) :
                                                  CachedNetworkImage(
                                                    height: 125.h,
                                                    width: 125.w,
                                                    fit: BoxFit.cover,
                                                    imageUrl:  '${stateProductDetails.showDetailsProductResponseModel![0].imagesPath}${stateProductDetails.showDetailsProductResponseModel![0].images![0].name}',
                                                    placeholder: (context, url) => Image.asset('assets/images/loader.gif'),
                                                    errorWidget: (context, url, error) => const Icon(Icons.error),
                                                  )
                                              ),
                                            ),
                                            stateProductDetails.showDetailsProductResponseModel![0].images!.isNotEmpty ?
                                            stateProductDetails.showDetailsProductResponseModel![0].images![0].name != null?
                                            Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Align(
                                                alignment: Alignment.topRight,
                                                child: SizedBox(
                                                  width: 35,
                                                  height: 35,
                                                  child: IconButton(onPressed: (){
                                                    stateProductDetails.showDetailsProductResponseModel![0].images!.length != 1 ?
                                                    stateProductDetails.showDetailsProductResponseModel![0].images!.isNotEmpty ?
                                                    addProductCubit.deleteImageProduct(context, stateProductDetails.showDetailsProductResponseModel![0].images![0].id.toString()) :
                                                    null :
                                                    AwesomeDialog(
                                                      context: context,
                                                      btnOkText: LocaleKeys.ok.tr(),
                                                      btnCancelText: LocaleKeys.cancel.tr(),
                                                      dialogType: DialogType.warning,
                                                      animType: AnimType.rightSlide,
                                                      title: LocaleKeys.warning.tr(),
                                                      desc: LocaleKeys.cannotBeDeletedImage.tr(),
                                                      btnCancelOnPress: () {
                                                        //  _getCurrentLocation();
                                                      },
                                                      btnOkOnPress: () {
                                                        // _getCurrentLocation();
                                                      },
                                                    ).show();
                                                  }, icon: const Icon(
                                                    Icons.cancel_outlined,color: AppPalette.error,
                                                  )),
                                                ),
                                              ),
                                            ) : Container() : Container(),
                                          ],
                                        ),
                                        5.widthBox,
                                        Stack(
                                          children: <Widget>[
                                            InkWell(
                                              onTap: () async{
                                                if(stateProductDetails.showDetailsProductResponseModel![0].images!.length > 1){
                                                  if(stateProductDetails.showDetailsProductResponseModel![0].images![1].name == null){

                                                  }
                                                }else {
                                                  selectImageByCameraOrGallery(context, image2, lottie,
                                                      addProductCubit,stateProductDetails.showDetailsProductResponseModel![0].id.toString());
                                                }
                                              },
                                              child: Container(
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: Dimensions.paddingSizeExtraSmall),
                                                height: 125.h,
                                                width: 125.w,
                                                decoration: BoxDecoration(
                                                  color: AppPalette.lightPrimary,
                                                  borderRadius: BorderRadius.circular(
                                                      Dimensions.radiusDefault),
                                                ),
                                                child: stateProductDetails.showDetailsProductResponseModel![0].images!.length > 1 ?
                                                image2 != null ? Image.file(image2!,fit: BoxFit.cover) :
                                                CachedNetworkImage(
                                                  height: 125.h,
                                                  width: 125.w,
                                                  fit: BoxFit.cover,
                                                  imageUrl:  '${stateProductDetails.showDetailsProductResponseModel![0].imagesPath}${stateProductDetails.showDetailsProductResponseModel![0].images![1].name}',
                                                  placeholder: (context, url) => Image.asset('assets/images/loader.gif'),
                                                  errorWidget: (context, url, error) => const Icon(Icons.error),
                                                ) :
                                                SvgPicture.asset('assets/images/svg/camera_photo.svg',width: 75,height: 75,
                                                    fit: BoxFit.scaleDown,color: AppPalette.primary),
                                              ),
                                            ),
                                            stateProductDetails.showDetailsProductResponseModel![0].images!.length > 1 ?
                                            stateProductDetails.showDetailsProductResponseModel![0].images![1].name != null?
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 0),
                                              child: Align(
                                                alignment: Alignment.topRight,
                                                child: SizedBox(
                                                  width: 35,
                                                  height: 35,
                                                  child: IconButton(onPressed: (){
                                                    stateProductDetails.showDetailsProductResponseModel![0].images!.length != 1 ?
                                                    stateProductDetails.showDetailsProductResponseModel![0].images!.length > 1 ?
                                                    addProductCubit.deleteImageProduct(context, stateProductDetails.showDetailsProductResponseModel![0].images![1].id.toString()) :
                                                    null :
                                                    AwesomeDialog(
                                                      context: context,
                                                      btnOkText: LocaleKeys.ok.tr(),
                                                      btnCancelText: LocaleKeys.cancel.tr(),
                                                      dialogType: DialogType.warning,
                                                      animType: AnimType.rightSlide,
                                                      title: LocaleKeys.warning.tr(),
                                                      desc: LocaleKeys.cannotBeDeletedImage.tr(),
                                                      btnCancelOnPress: () {
                                                        //  _getCurrentLocation();
                                                      },
                                                      btnOkOnPress: () {
                                                        // _getCurrentLocation();
                                                      },
                                                    ).show();

                                                  }, icon: const Icon(
                                                    Icons.cancel_outlined,color: AppPalette.error,
                                                  )),
                                                ),
                                              ),
                                            ) : Container() : Container(),
                                          ],
                                        ),
                                      ],
                                    ),
                                    heightSeperator(15.h),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Stack(
                                          children: <Widget>[
                                            InkWell(
                                              onTap: () async{
                                                if(stateProductDetails.showDetailsProductResponseModel![0].images!.length > 2){
                                                  if(stateProductDetails.showDetailsProductResponseModel![0].images![2].name == null){

                                                  }
                                                }else {
                                                  selectImageByCameraOrGallery(context, image3, lottie,
                                                      addProductCubit,stateProductDetails.showDetailsProductResponseModel![0].id.toString());
                                                }

                                              },
                                              child: Container(
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: Dimensions.paddingSizeExtraSmall),
                                                height: 125.h,
                                                width: 125.w,
                                                decoration: BoxDecoration(
                                                  color: AppPalette.lightPrimary,
                                                  borderRadius: BorderRadius.circular(
                                                      Dimensions.radiusDefault),
                                                ),
                                                child: stateProductDetails.showDetailsProductResponseModel![0].images!.length > 2 ?
                                                image3 != null ? Image.file(image3!,fit: BoxFit.cover) :
                                                CachedNetworkImage(
                                                  height: 125.h,
                                                  width: 125.w,
                                                  fit: BoxFit.cover,
                                                  imageUrl:  '${stateProductDetails.showDetailsProductResponseModel![0].imagesPath}${stateProductDetails.showDetailsProductResponseModel![0].images![2].name}',
                                                  placeholder: (context, url) => Image.asset('assets/images/loader.gif'),
                                                  errorWidget: (context, url, error) => const Icon(Icons.error),
                                                ) :
                                                SvgPicture.asset('assets/images/svg/camera_photo.svg',width: 75,height: 75,
                                                    fit: BoxFit.scaleDown,color: AppPalette.primary),
                                              ),
                                            ),
                                            stateProductDetails.showDetailsProductResponseModel![0].images!.length > 2 ?
                                            stateProductDetails.showDetailsProductResponseModel![0].images![2].name != null?
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 0),
                                              child: Align(
                                                alignment: Alignment.topRight,
                                                child: SizedBox(
                                                  width: 35,
                                                  height: 35,
                                                  child: IconButton(onPressed: (){
                                                    stateProductDetails.showDetailsProductResponseModel![0].images!.length != 1 ?
                                                    stateProductDetails.showDetailsProductResponseModel![0].images!.length > 2 ?
                                                    addProductCubit.deleteImageProduct(context, stateProductDetails.showDetailsProductResponseModel![0].images![2].id.toString()) :
                                                    null :
                                                    AwesomeDialog(
                                                      context: context,
                                                      btnOkText: LocaleKeys.ok.tr(),
                                                      btnCancelText: LocaleKeys.cancel.tr(),
                                                      dialogType: DialogType.warning,
                                                      animType: AnimType.rightSlide,
                                                      title: LocaleKeys.warning.tr(),
                                                      desc: LocaleKeys.cannotBeDeletedImage.tr(),
                                                      btnCancelOnPress: () {
                                                        //  _getCurrentLocation();
                                                      },
                                                      btnOkOnPress: () {
                                                        // _getCurrentLocation();
                                                      },
                                                    ).show();
                                                  }, icon: const Icon(
                                                    Icons.cancel_outlined,color: AppPalette.error,
                                                  )),
                                                ),
                                              ),
                                            ) : Container() : Container(),
                                          ],
                                        ),
                                        5.widthBox,
                                        Stack(
                                          children: <Widget>[
                                            InkWell(
                                                onTap: () async{
                                                  if(stateProductDetails.showDetailsProductResponseModel![0].images!.length > 3){
                                                    if(stateProductDetails.showDetailsProductResponseModel![0].images![3].name == null){

                                                    }
                                                  }else {
                                                    selectImageByCameraOrGallery(context, image4, lottie,
                                                        addProductCubit,stateProductDetails.showDetailsProductResponseModel![0].id.toString());
                                                  }

                                                },
                                                child: Container(
                                                  margin: EdgeInsets.symmetric(
                                                      horizontal: Dimensions.paddingSizeExtraSmall),
                                                  height: 125.h,
                                                  width: 125.w,
                                                  decoration: BoxDecoration(
                                                    color: AppPalette.lightPrimary,
                                                    borderRadius: BorderRadius.circular(
                                                        Dimensions.radiusDefault),
                                                  ),
                                                  child: stateProductDetails.showDetailsProductResponseModel![0].images!.length > 3 ?
                                                  image4 != null ? Image.file(image4!,fit: BoxFit.cover) :
                                                  CachedNetworkImage(
                                                    height: 125.h,
                                                    width: 125.w,
                                                    fit: BoxFit.cover,
                                                    imageUrl:  '${stateProductDetails.showDetailsProductResponseModel![0].imagesPath}${stateProductDetails.showDetailsProductResponseModel![0].images![3].name}',
                                                    placeholder: (context, url) => Image.asset('assets/images/loader.gif'),
                                                    errorWidget: (context, url, error) => const Icon(Icons.error),
                                                  ) :                                                SvgPicture.asset('assets/images/svg/camera_photo.svg',width: 75,height: 75,
                                                      fit: BoxFit.scaleDown,color: AppPalette.primary),                     )),
                                            stateProductDetails.showDetailsProductResponseModel![0].images!.length > 3 ?
                                            stateProductDetails.showDetailsProductResponseModel![0].images![3].name != null?
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 0),
                                              child: Align(
                                                alignment: Alignment.topRight,
                                                child: SizedBox(
                                                  width: 35,
                                                  height: 35,
                                                  child: IconButton(onPressed: (){
                                                    stateProductDetails.showDetailsProductResponseModel![0].images!.length != 1 ?
                                                    stateProductDetails.showDetailsProductResponseModel![0].images!.length > 3 ?
                                                    addProductCubit.deleteImageProduct(context, stateProductDetails.showDetailsProductResponseModel![0].images![3].id.toString()) :
                                                    null :
                                                    AwesomeDialog(
                                                      context: context,
                                                      btnOkText: LocaleKeys.ok.tr(),
                                                      btnCancelText: LocaleKeys.cancel.tr(),
                                                      dialogType: DialogType.warning,
                                                      animType: AnimType.rightSlide,
                                                      title: LocaleKeys.warning.tr(),
                                                      desc: LocaleKeys.cannotBeDeletedImage.tr(),
                                                      btnCancelOnPress: () {
                                                        //  _getCurrentLocation();
                                                      },
                                                      btnOkOnPress: () {
                                                        // _getCurrentLocation();
                                                      },
                                                    ).show();
                                                  }, icon: const Icon(
                                                    Icons.cancel_outlined,color: AppPalette.error,
                                                  )),
                                                ),
                                              ),
                                            ) : Container() : Container(),
                                          ],
                                        ),
                                      ],
                                    ),
                                    heightSeperator(15.h),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Stack(
                                          children: <Widget>[
                                            InkWell(
                                              onTap: () async{
                                                if(stateProductDetails.showDetailsProductResponseModel![0].images!.length > 4){
                                                  if(stateProductDetails.showDetailsProductResponseModel![0].images![4].name == null){

                                                  }
                                                }else {
                                                  selectImageByCameraOrGallery(context, image5, lottie,
                                                      addProductCubit,stateProductDetails.showDetailsProductResponseModel![0].id.toString());
                                                }

                                              },
                                              child: Container(
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: Dimensions.paddingSizeExtraSmall),
                                                height: 125.h,
                                                width: 125.w,
                                                decoration: BoxDecoration(
                                                  color: AppPalette.lightPrimary,
                                                  borderRadius: BorderRadius.circular(
                                                      Dimensions.radiusDefault),
                                                ),
                                                child: stateProductDetails.showDetailsProductResponseModel![0].images!.length > 4 ?
                                                image5 != null ? Image.file(image5!,fit: BoxFit.cover) :
                                                CachedNetworkImage(
                                                  height: 125.h,
                                                  width: 125.w,
                                                  fit: BoxFit.cover,
                                                  imageUrl:  '${stateProductDetails.showDetailsProductResponseModel![0].imagesPath}${stateProductDetails.showDetailsProductResponseModel![0].images![4].name}',
                                                  placeholder: (context, url) => Image.asset('assets/images/loader.gif'),
                                                  errorWidget: (context, url, error) => const Icon(Icons.error),
                                                ) :
                                                SvgPicture.asset('assets/images/svg/camera_photo.svg',width: 75,height: 75,
                                                    fit: BoxFit.scaleDown,color: AppPalette.primary),                     ),
                                            ),
                                            stateProductDetails.showDetailsProductResponseModel![0].images!.length > 4 ?
                                            stateProductDetails.showDetailsProductResponseModel![0].images![4].name != null?
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 0),
                                              child: Align(
                                                alignment: Alignment.topRight,
                                                child: SizedBox(
                                                  width: 35,
                                                  height: 35,
                                                  child: IconButton(onPressed: (){
                                                    stateProductDetails.showDetailsProductResponseModel![0].images!.length != 1 ?
                                                    stateProductDetails.showDetailsProductResponseModel![0].images!.length > 4 ?
                                                    addProductCubit.deleteImageProduct(context, stateProductDetails.showDetailsProductResponseModel![0].images![4].id.toString()) :
                                                    null :
                                                    AwesomeDialog(
                                                      context: context,
                                                      btnOkText: LocaleKeys.ok.tr(),
                                                      btnCancelText: LocaleKeys.cancel.tr(),
                                                      dialogType: DialogType.warning,
                                                      animType: AnimType.rightSlide,
                                                      title: LocaleKeys.warning.tr(),
                                                      desc: LocaleKeys.cannotBeDeletedImage.tr(),
                                                      btnCancelOnPress: () {
                                                        //  _getCurrentLocation();
                                                      },
                                                      btnOkOnPress: () {
                                                        // _getCurrentLocation();
                                                      },
                                                    ).show();
                                                  }, icon: const Icon(
                                                    Icons.cancel_outlined,color: AppPalette.error,
                                                  )),
                                                ),
                                              ),
                                            ) : Container() : Container(),
                                          ],
                                        ),
                                        5.widthBox,
                                        Visibility(
                                          child: Stack(
                                            children: <Widget>[
                                              InkWell(
                                                onTap: () async{},
                                                child: Container(
                                                    margin: EdgeInsets.symmetric(
                                                        horizontal: Dimensions.paddingSizeExtraSmall),
                                                    height: 125.h,
                                                    width: 125.w,
                                                    decoration: const BoxDecoration(
                                                      color: Colors.transparent,
                                                    ),
                                                    child: const SizedBox(width: 75,height: 75)),
                                              ),
                                            ],
                                          ),
                                          visible: true,
                                        ),
                                      ],
                                    ),
                                    heightSeperator(15.h),
                                    state is UpdateImageLoadingState
                                        ? const Center(
                                      child: CircularProgressIndicator(),
                                    ) : Container(
                                      padding: EdgeInsets.only(
                                        bottom: Dimensions.paddingSizeDefault,
                                        right: Dimensions.paddingSizeDefault,
                                        left: Dimensions.paddingSizeDefault,
                                      ),
                                    ),
                                    15.heightBox,
                                    Container(
                                      padding: EdgeInsets.only(
                                        bottom: Dimensions.paddingSizeDefault,
                                        right: Dimensions.paddingSizeDefault,
                                        left: Dimensions.paddingSizeDefault,
                                      ),
                                      child: CustomButton(
                                        buttonText: LocaleKeys.save.tr(),
                                        onPressed: () {
                                          //  print('option list is $nameOfProduct');
                                          BlocProvider.of<ProductDetailsCubit>(context).getProductDetailsUser('${widget.product?.id}');
                                          Navigator.of(context).pushReplacement(MaterialPageRoute(
                                              builder: (context) => ChangeProductScreen2(
                                                  product: widget.product

                                              )));

                                        },
                                        height: 48.h,
                                        fontSize: Dimensions.fontSizeLarge,
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ) : NoInternetConnectionScreen(appLayoutState: stateProductConnection),),
        ),
      ),
    );
  }

  void selectImageByCameraOrGallery(BuildContext context,File? image1,String? lottie,
      AddProductCubit addProductCubit,String stateProductDetails){
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
                          addProductCubit.updateImageProduct(context, stateProductDetails, image1!);

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
                          addProductCubit.updateImageProduct(context, stateProductDetails, image1!);
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
    );}


}
