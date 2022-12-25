// import 'dart:io';
//
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:shop/business_logic/my_products_cubit/my_products_cubit.dart';
// import 'package:shop/business_logic/my_products_cubit/my_products_state.dart';
// import 'package:shop/data/models/MyProductUserModel.dart';
// import 'package:shop/data/models/show_details_product_model.dart';
// import 'package:shop/utils/app_palette.dart';
// import 'package:shop/utils/app_size_boxes.dart';
// import 'package:shop/utils/dimensions.dart';
//
// class UpdateImagesSectionWidget extends StatefulWidget {
//   final ShowDetailsProductResponseModel productModel;
//   UpdateImagesSectionWidget({Key? key,required this.productModel}) : super(key: key);
//
//   @override
//   State<UpdateImagesSectionWidget> createState() => _UpdateImagesSectionWidgetState();
// }
//
// class _UpdateImagesSectionWidgetState extends State<UpdateImagesSectionWidget> {
//
//   File? image1;
//   File? image2;
//   File? image3;
//   File? image4;
//   File? image5;
//   late String images;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     BlocProvider.of<AddProductCubit>(context).getMyProductUser();
//   }
//   @override
//   Widget build(BuildContext context) {
//    return BlocBuilder<AddProductCubit, AddProductState>(
//       builder: (context, state) {
//         AddProductCubit addProductCubit = AddProductCubit.get(context);
//         return SizedBox(
//           width: double.infinity,
//           height: 125.h,
//           child:  ListView(
//             shrinkWrap: true,
//             scrollDirection: Axis.horizontal,
//             children: [
//               Stack(
//                 children: <Widget>[
//                   InkWell(
//                     onTap: () async{
//                       if(stateProductDetails.showDetailsProductResponseModel![0].images!.isNotEmpty){
//                         if(stateProductDetails.showDetailsProductResponseModel![0].images![0].name == null){
//                         }
//                       }else {
//                         try {
//                           final image = await ImagePicker().pickImage(source: ImageSource.gallery);
//                           if (image == null) return;
//                           final iamgeTempoary = File(image.path);
//                           setState(() => image1 = iamgeTempoary);
//                           addProductCubit.updateImageProduct(context, stateProductDetails.showDetailsProductResponseModel![0].id.toString(), image1!);
//                         } on PlatformException catch (e) {
//                           if (kDebugMode) {
//                             print(e);
//                           }
//                         }
//                       }
//                       //   print('images list ${stateProductDetails.showDetailsProductResponseModel![0].images!.length}');
//                     },
//                     child: Container(
//                       margin: EdgeInsets.symmetric(
//                           horizontal: Dimensions.paddingSizeExtraSmall),
//                       height: 125.h,
//                       width: 125.w,
//                       decoration: BoxDecoration(
//                         color: AppPalette.lightPrimary,
//                         borderRadius: BorderRadius.circular(
//                             Dimensions.radiusDefault),
//                       ),
//                       child: stateProductDetails.showDetailsProductResponseModel![0].images!.isNotEmpty ?
//                       image1 != null ? Image.file(image1!,fit: BoxFit.cover) :
//                       Image.network('${stateProductDetails.showDetailsProductResponseModel![0].imagesPath}${stateProductDetails.showDetailsProductResponseModel![0].images![0].name}',fit: BoxFit.cover) :
//                       SvgPicture.asset('assets/images/svg/camera_photo.svg',width: 75,height: 75,
//                           fit: BoxFit.scaleDown,color: AppPalette.primary),
//
//                     ),
//                   ),
//                   stateProductDetails.showDetailsProductResponseModel![0].images!.isNotEmpty ?
//                   stateProductDetails.showDetailsProductResponseModel![0].images![0].name != null?
//                   Padding(
//                     padding: const EdgeInsets.all(5.0),
//                     child: Align(
//                       alignment: Alignment.topRight,
//                       child: SizedBox(
//                         width: 35,
//                         height: 35,
//                         child: IconButton(onPressed: (){
//                           stateProductDetails.showDetailsProductResponseModel![0].images!.isNotEmpty ?
//                           addProductCubit.deleteImageProduct(context, stateProductDetails.showDetailsProductResponseModel![0].images![0].id.toString()) :
//                           null;
//                         }, icon: const Icon(
//                           Icons.cancel_outlined,color: AppPalette.error,
//                         )),
//                       ),
//                     ),
//                   ) : Container() : Container(),
//                 ],
//               ),
//               5.widthBox,
//               Stack(
//                 children: <Widget>[
//                   InkWell(
//                     onTap: () async{
//                       if(stateProductDetails.showDetailsProductResponseModel![0].images!.length > 1){
//                         if(stateProductDetails.showDetailsProductResponseModel![0].images![1].name == null){
//
//                         }
//                       }else {
//                         try {
//                           final image = await ImagePicker().pickImage(source: ImageSource.gallery);
//                           if (image == null) return;
//                           final iamgeTempoary = File(image.path);
//                           setState(() => image2 = iamgeTempoary);
//                           addProductCubit.updateImageProduct(context, stateProductDetails.showDetailsProductResponseModel![0].id.toString(), image2!);
//                         } on PlatformException catch (e) {
//                           if (kDebugMode) {
//                             print(e);
//                           }
//                         }
//                       }
//                     },
//                     child: Container(
//                       margin: EdgeInsets.symmetric(
//                           horizontal: Dimensions.paddingSizeExtraSmall),
//                       height: 125.h,
//                       width: 125.w,
//                       decoration: BoxDecoration(
//                         color: AppPalette.lightPrimary,
//                         borderRadius: BorderRadius.circular(
//                             Dimensions.radiusDefault),
//                       ),
//                       child: stateProductDetails.showDetailsProductResponseModel![0].images!.length > 1 ?
//                       image2 != null ? Image.file(image2!,fit: BoxFit.cover) :
//                       Image.network('${stateProductDetails.showDetailsProductResponseModel![0].imagesPath}${stateProductDetails.showDetailsProductResponseModel![0].images![1].name}',
//                           fit: BoxFit.cover) :
//                       SvgPicture.asset('assets/images/svg/camera_photo.svg',width: 75,height: 75,
//                           fit: BoxFit.scaleDown,color: AppPalette.primary),
//                     ),
//                   ),
//                   stateProductDetails.showDetailsProductResponseModel![0].images!.length > 1 ?
//                   stateProductDetails.showDetailsProductResponseModel![0].images![1].name != null?
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 0),
//                     child: Align(
//                       alignment: Alignment.topRight,
//                       child: SizedBox(
//                         width: 35,
//                         height: 35,
//                         child: IconButton(onPressed: (){
//                           stateProductDetails.showDetailsProductResponseModel![0].images!.length > 1 ?
//                           addProductCubit.deleteImageProduct(context, stateProductDetails.showDetailsProductResponseModel![0].images![1].id.toString()) :
//                           null;
//                         }, icon: const Icon(
//                           Icons.cancel_outlined,color: AppPalette.error,
//                         )),
//                       ),
//                     ),
//                   ) : Container() : Container(),
//                 ],
//               ),
//               5.widthBox,
//               Stack(
//                 children: <Widget>[
//                   InkWell(
//                     onTap: () async{
//                       if(stateProductDetails.showDetailsProductResponseModel![0].images!.length > 2){
//                         if(stateProductDetails.showDetailsProductResponseModel![0].images![2].name == null){
//
//                         }
//                       }else {
//                         try {
//                           final image = await ImagePicker().pickImage(source: ImageSource.gallery);
//                           if (image == null) return;
//                           final iamgeTempoary = File(image.path);
//                           setState(() => image3 = iamgeTempoary);
//                           addProductCubit.updateImageProduct(context, stateProductDetails.showDetailsProductResponseModel![0].id.toString(), image3!);
//                         } on PlatformException catch (e) {
//                           if (kDebugMode) {
//                             print(e);
//                           }
//                         }
//                       }
//
//                     },
//                     child: Container(
//                       margin: EdgeInsets.symmetric(
//                           horizontal: Dimensions.paddingSizeExtraSmall),
//                       height: 125.h,
//                       width: 125.w,
//                       decoration: BoxDecoration(
//                         color: AppPalette.lightPrimary,
//                         borderRadius: BorderRadius.circular(
//                             Dimensions.radiusDefault),
//                       ),
//                       child: stateProductDetails.showDetailsProductResponseModel![0].images!.length > 2 ?
//                       image3 != null ? Image.file(image3!,fit: BoxFit.cover) :
//                       Image.network('${stateProductDetails.showDetailsProductResponseModel![0].imagesPath}${stateProductDetails.showDetailsProductResponseModel![0].images![2].name}',
//                           fit: BoxFit.cover) :
//                       SvgPicture.asset('assets/images/svg/camera_photo.svg',width: 75,height: 75,
//                           fit: BoxFit.scaleDown,color: AppPalette.primary),
//                     ),
//                   ),
//                   stateProductDetails.showDetailsProductResponseModel![0].images!.length > 2 ?
//                   stateProductDetails.showDetailsProductResponseModel![0].images![2].name != null?
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 0),
//                     child: Align(
//                       alignment: Alignment.topRight,
//                       child: SizedBox(
//                         width: 35,
//                         height: 35,
//                         child: IconButton(onPressed: (){
//                           stateProductDetails.showDetailsProductResponseModel![0].images!.length > 2 ?
//                           addProductCubit.deleteImageProduct(context, stateProductDetails.showDetailsProductResponseModel![0].images![2].id.toString()) :
//                           null;
//                         }, icon: const Icon(
//                           Icons.cancel_outlined,color: AppPalette.error,
//                         )),
//                       ),
//                     ),
//                   ) : Container() : Container(),
//                 ],
//               ),
//               5.widthBox,
//               Stack(
//                 children: <Widget>[
//                   InkWell(
//                       onTap: () async{
//                         if(stateProductDetails.showDetailsProductResponseModel![0].images!.length > 3){
//                           if(stateProductDetails.showDetailsProductResponseModel![0].images![3].name == null){
//
//                           }
//                         }else {
//                           try {
//                             final image = await ImagePicker().pickImage(source: ImageSource.gallery);
//                             if (image == null) return;
//                             final iamgeTempoary = File(image.path);
//                             setState(() => image4 = iamgeTempoary);
//                             //  addProductCubit.updateImageProduct(context, stateProductDetails.showDetailsProductResponseModel![0].id.toString(), image4!);
//                           } on PlatformException catch (e) {
//                             if (kDebugMode) {
//                               print(e);
//                             }
//                           }
//                         }
//
//                       },
//                       child: Container(
//                         margin: EdgeInsets.symmetric(
//                             horizontal: Dimensions.paddingSizeExtraSmall),
//                         height: 125.h,
//                         width: 125.w,
//                         decoration: BoxDecoration(
//                           color: AppPalette.lightPrimary,
//                           borderRadius: BorderRadius.circular(
//                               Dimensions.radiusDefault),
//                         ),
//                         child: stateProductDetails.showDetailsProductResponseModel![0].images!.length > 3 ?
//                         image4 != null ? Image.file(image4!,fit: BoxFit.cover) :
//                         Image.network('${stateProductDetails.showDetailsProductResponseModel![0].imagesPath}${stateProductDetails.showDetailsProductResponseModel![0].images![3].name}',fit: BoxFit.cover) :
//                         SvgPicture.asset('assets/images/svg/camera_photo.svg',width: 75,height: 75,
//                             fit: BoxFit.scaleDown,color: AppPalette.primary),                     )),
//                   stateProductDetails.showDetailsProductResponseModel![0].images!.length > 3 ?
//                   stateProductDetails.showDetailsProductResponseModel![0].images![3].name != null?
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 0),
//                     child: Align(
//                       alignment: Alignment.topRight,
//                       child: SizedBox(
//                         width: 35,
//                         height: 35,
//                         child: IconButton(onPressed: (){
//                           stateProductDetails.showDetailsProductResponseModel![0].images!.length > 3 ?
//                           addProductCubit.deleteImageProduct(context, stateProductDetails.showDetailsProductResponseModel![0].images![3].id.toString()) :
//                           null;
//                         }, icon: const Icon(
//                           Icons.cancel_outlined,color: AppPalette.error,
//                         )),
//                       ),
//                     ),
//                   ) : Container() : Container(),
//                 ],
//               ),
//               5.widthBox,
//               Stack(
//                 children: <Widget>[
//                   InkWell(
//                     onTap: () async{
//                       if(stateProductDetails.showDetailsProductResponseModel![0].images!.length > 4){
//                         if(stateProductDetails.showDetailsProductResponseModel![0].images![4].name == null){
//
//                         }
//                       }else {
//                         try {
//                           final image = await ImagePicker().pickImage(source: ImageSource.gallery);
//                           if (image == null) return;
//                           final iamgeTempoary = File(image.path);
//                           setState(() => image5 = iamgeTempoary);
//                           addProductCubit.updateImageProduct(context, stateProductDetails.showDetailsProductResponseModel![0].id.toString(), image5!);
//                         } on PlatformException catch (e) {
//                           if (kDebugMode) {
//                             print(e);
//                           }
//                         }
//                       }
//
//                     },
//                     child: Container(
//                       margin: EdgeInsets.symmetric(
//                           horizontal: Dimensions.paddingSizeExtraSmall),
//                       height: 125.h,
//                       width: 125.w,
//                       decoration: BoxDecoration(
//                         color: AppPalette.lightPrimary,
//                         borderRadius: BorderRadius.circular(
//                             Dimensions.radiusDefault),
//                       ),
//                       child: stateProductDetails.showDetailsProductResponseModel![0].images!.length > 4 ?
//                       image5 != null ? Image.file(image5!,fit: BoxFit.cover) :
//                       Image.network('${stateProductDetails.showDetailsProductResponseModel![0].imagesPath}${stateProductDetails.showDetailsProductResponseModel![0].images![4].name}',fit: BoxFit.cover) :
//                       SvgPicture.asset('assets/images/svg/camera_photo.svg',width: 75,height: 75,
//                           fit: BoxFit.scaleDown,color: AppPalette.primary),                     ),
//                   ),
//                   stateProductDetails.showDetailsProductResponseModel![0].images!.length > 4 ?
//                   stateProductDetails.showDetailsProductResponseModel![0].images![4].name != null?
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 0),
//                     child: Align(
//                       alignment: Alignment.topRight,
//                       child: SizedBox(
//                         width: 35,
//                         height: 35,
//                         child: IconButton(onPressed: (){
//                           stateProductDetails.showDetailsProductResponseModel![0].images!.length > 4 ?
//                           addProductCubit.deleteImageProduct(context, stateProductDetails.showDetailsProductResponseModel![0].images![4].id.toString()) :
//                           null;
//                         }, icon: const Icon(
//                           Icons.cancel_outlined,color: AppPalette.error,
//                         )),
//                       ),
//                     ),
//                   ) : Container() : Container(),
//                 ],
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
//
// class ImageProductUser extends StatelessWidget {
//    MyProductUserResponseModel productModel;
//    int? indexImage;
//    int index;
//    AddProductCubit addProductCubit;
//    ImageProductUser({Key? key,required this.productModel,required this.indexImage, required this.index,
//      required this.addProductCubit}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     indexImage = productModel.images!.length;
//     return GestureDetector(
//       onTap: (){
//         addProductCubit.pickProductImage();
//       },
//       child: Container(
//         margin: EdgeInsets.symmetric(
//             horizontal: Dimensions.paddingSizeExtraSmall),
//         height: 100.h,
//         width: 100.w,
//         decoration: BoxDecoration(
//           color: AppPalette.lightPrimary,
//           borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
//           image: indexImage == 1 ?  DecorationImage(image:NetworkImage('${productModel.imagesPath}${productModel.images![index].name}')) :
//            null ,
//
//         )),
//     );
//
//   }
// }
