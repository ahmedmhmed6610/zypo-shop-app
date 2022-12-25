import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shop/business_logic/my_products_cubit/my_products_cubit.dart';
import 'package:shop/business_logic/my_products_cubit/my_products_state.dart';
import 'package:shop/utils/app_palette.dart';
import 'package:shop/utils/app_size_boxes.dart';
import 'package:shop/utils/dimensions.dart';

class ImagesSectionWidget extends StatefulWidget {
  ImagesSectionWidget({Key? key}) : super(key: key);

  @override
  State<ImagesSectionWidget> createState() => _ImagesSectionWidgetState();
}

class _ImagesSectionWidgetState extends State<ImagesSectionWidget> {

  File? image1;
  File? image2;
  File? image3;
  File? image4;
  File? image5;
  String? fileName;
  List<String>? imagesList;
  List<File> images = [];

  Future PickImage1(List<File> images) async {
    try {
      images = [];
      var image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      var iamgeTempoary = File(image.path) ;
      setState(() => image1 = iamgeTempoary);
      fileName = image.path.split('/').last;
      images.add(iamgeTempoary);
     // imagesList?.add(fileName!);


    } on PlatformException catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future PickImage2(List<File> images) async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final iamgeTempoary = File(image.path);
      setState(() => image2 = iamgeTempoary);
      fileName = image.path.split('/').last;
      images.add(iamgeTempoary);
      // imagesList?.add(fileName!);


    } on PlatformException catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future PickImage3(List<File> images) async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final iamgeTempoary = File(image.path);
      setState(() => image3 = iamgeTempoary);
      fileName = image.path.split('/').last;
      images.add(iamgeTempoary);
      // imagesList?.add(fileName!);


    } on PlatformException catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future PickImage4(List<File> images) async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final iamgeTempoary = File(image.path);
      setState(() => image4 = iamgeTempoary);
      fileName = image.path.split('/').last;
      images.add(iamgeTempoary);
      // imagesList?.add(fileName!);


    } on PlatformException catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future PickImage5(List<File> images) async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final iamgeTempoary = File(image.path);
      setState(() => image5 = iamgeTempoary);
      fileName = image.path.split('/').last;
      images.add(iamgeTempoary);
      // imagesList?.add(fileName!);


    } on PlatformException catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddProductCubit, AddProductState>(
      builder: (context, state) {
        AddProductCubit addProductCubit = AddProductCubit.get(context);
        return SizedBox(
          width: double.infinity,
          height: 125.h,
          child: ListView(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            children: [
              // 15.widthBox,
              // Center(
              //   child: AddButtonWidget(
              //     child: IconButton(
              //       onPressed: addProductCubit.pickProductImage,
              //       icon: const Icon(
              //         Icons.add,
              //         color: AppPalette.white,
              //       ),
              //     ),
              //   ),
              // ),
              10.widthBox,
              ListView(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: [
                  Stack(
                    children: <Widget>[
                      InkWell(
                        onTap: () async{
                         // PickImage1(addProductCubit.images);
                          try {
                            final image = await ImagePicker().pickImage(source: ImageSource.gallery);
                            if (image == null) return;
                            final iamgeTempoary = File(image.path);
                            setState(() => image1 = iamgeTempoary);
                            fileName = image.path.split('/').last;
                            addProductCubit.images.add(File(image.path));
                            // imagesList?.add(fileName!);


                          } on PlatformException catch (e) {
                            if (kDebugMode) {
                              print(e);
                            }
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
                          child: image1 != null ? Image.file(image1!,fit: BoxFit.cover) :
                          SvgPicture.asset('assets/images/svg/camera_photo.svg',width: 75,height: 75,
                            fit: BoxFit.scaleDown,color: AppPalette.primary),
                        ),
                      ),
                      image1 != null ?
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: SizedBox(
                            width: 35,
                            height: 35,
                            child: IconButton(onPressed: (){
                              image1 = null;
                              addProductCubit.images.removeAt(1);
                            }, icon: const Icon(
                              Icons.cancel_outlined,color: AppPalette.error,
                            )),
                          ),
                        ),
                      ) :
                      Container()
                    ],
                  ),
                  5.widthBox,
                  Stack(
                    children: <Widget>[
                      InkWell(
                        onTap: () async{
                        //  PickImage2(addProductCubit.images);
                          try {
                            final image = await ImagePicker().pickImage(source: ImageSource.gallery);
                            if (image == null) return;
                            final iamgeTempoary = File(image.path);
                            setState(() => image2 = iamgeTempoary);
                            fileName = image.path.split('/').last;
                            addProductCubit.images.add(File(image.path));
                            // imagesList?.add(fileName!);


                          } on PlatformException catch (e) {
                            if (kDebugMode) {
                              print(e);
                            }
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
                          child: image2 != null ? Image.file(image2!,fit: BoxFit.cover) :
                          SvgPicture.asset('assets/images/svg/camera_photo.svg',width: 75,height: 75,
                            fit: BoxFit.scaleDown,color: AppPalette.primary),
                        ),
                      ),
                      image2 != null ?
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 0),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: SizedBox(
                            width: 35,
                            height: 35,
                            child: IconButton(onPressed: (){
                              image2 = null;
                              addProductCubit.images.removeAt(2);
                            }, icon: const Icon(
                              Icons.cancel_outlined,color: AppPalette.error,
                            )),
                          ),
                        ),
                      ) :
                      Container()
                    ],
                  ),
                  5.widthBox,
                  Stack(
                    children: <Widget>[
                      InkWell(
                        onTap: () async{
                          //  PickImage2(addProductCubit.images);
                          try {
                            final image = await ImagePicker().pickImage(source: ImageSource.gallery);
                            if (image == null) return;
                            final iamgeTempoary = File(image.path);
                            setState(() => image3 = iamgeTempoary);
                            fileName = image.path.split('/').last;
                            addProductCubit.images.add(File(image.path));
                            // imagesList?.add(fileName!);


                          } on PlatformException catch (e) {
                            if (kDebugMode) {
                              print(e);
                            }
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
                          child: image3 != null ? Image.file(image3!,fit: BoxFit.cover) :
                          SvgPicture.asset('assets/images/svg/camera_photo.svg',width: 75,height: 75,
                              fit: BoxFit.scaleDown,color: AppPalette.primary),
                        ),
                      ),
                      image3 != null ?
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 0),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: SizedBox(
                            width: 35,
                            height: 35,
                            child: IconButton(onPressed: (){
                              image3 = null;
                              addProductCubit.images.removeAt(3);
                            }, icon: const Icon(
                              Icons.cancel_outlined,color: AppPalette.error,
                            )),
                          ),
                        ),
                      ) :
                      Container()
                    ],
                  ),
                  5.widthBox,
                  Stack(
                    children: <Widget>[
                      InkWell(
                        onTap: () async{
                          //  PickImage2(addProductCubit.images);
                          try {
                            final image = await ImagePicker().pickImage(source: ImageSource.gallery);
                            if (image == null) return;
                            final iamgeTempoary = File(image.path);
                            setState(() => image4 = iamgeTempoary);
                            fileName = image.path.split('/').last;
                            addProductCubit.images.add(File(image.path));
                            // imagesList?.add(fileName!);


                          } on PlatformException catch (e) {
                            if (kDebugMode) {
                              print(e);
                            }
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
                          child: image4 != null ? Image.file(image4!,fit: BoxFit.cover) :
                          SvgPicture.asset('assets/images/svg/camera_photo.svg',width: 75,height: 75,
                            fit: BoxFit.scaleDown,color: AppPalette.primary),
                        ),
                      ),
                      image4 != null ?
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 0),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: SizedBox(
                            width: 35,
                            height: 35,
                            child: IconButton(onPressed: (){
                              image4 = null;
                              addProductCubit.images.removeAt(4);
                            }, icon: const Icon(
                              Icons.cancel_outlined,color: AppPalette.error,
                            )),
                          ),
                        ),
                      ) :
                      Container()
                    ],
                  ),
                  5.widthBox,
                  Stack(
                    children: <Widget>[
                      InkWell(
                        onTap: () async{
                          //  PickImage2(addProductCubit.images);
                          try {
                            final image = await ImagePicker().pickImage(source: ImageSource.gallery);
                            if (image == null) return;
                            final iamgeTempoary = File(image.path);
                            setState(() => image5 = iamgeTempoary);
                            fileName = image.path.split('/').last;
                            addProductCubit.images.add(File(image.path));
                            // imagesList?.add(fileName!);


                          } on PlatformException catch (e) {
                            if (kDebugMode) {
                              print(e);
                            }
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
                          child: image5 != null ? Image.file(image5!,fit: BoxFit.cover) :
                          SvgPicture.asset('assets/images/svg/camera_photo.svg',width: 75,height: 75,
                            fit: BoxFit.scaleDown,color: AppPalette.primary),
                        ),
                      ),
                      image5 != null ?
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 0),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: SizedBox(
                            width: 35,
                            height: 35,
                            child: IconButton(onPressed: (){
                              image5 = null;
                              addProductCubit.images.removeAt(5);
                            }, icon: const Icon(
                              Icons.cancel_outlined,color: AppPalette.error,
                            )),
                          ),
                        ),
                      ) :
                      Container()
                    ],
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
