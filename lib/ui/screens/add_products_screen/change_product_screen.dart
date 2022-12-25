// import 'package:flutter/material.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:shop/business_logic/my_products_cubit/my_products_cubit.dart';
// import 'package:shop/business_logic/my_products_cubit/my_products_state.dart';
// import 'package:shop/data/models/MyProductUserModel.dart';
// import 'package:shop/translations/locale_keys.g.dart';
// import 'package:shop/ui/base/custom_button.dart';
// import 'package:shop/ui/base/custom_toast.dart';
// import 'package:shop/ui/screens/add_products_screen/choose_categories_screens/choose_main_category_screen.dart';
// import 'package:shop/ui/screens/add_products_screen/choose_categories_screens/choose_one_brand_screen.dart';
// import 'package:shop/ui/screens/add_products_screen/choose_categories_screens/choose_product_location_screen.dart';
// import 'package:shop/ui/screens/add_products_screen/choose_categories_screens/choose_sub_category_screen.dart';
// import 'package:shop/ui/widgets/My_products_widgets/add_button_widget.dart';
// import 'package:shop/ui/widgets/My_products_widgets/add_product_widgets/condition_widget.dart';
// import 'package:shop/ui/widgets/My_products_widgets/add_product_widgets/custom_button_widget.dart';
// import 'package:shop/ui/widgets/My_products_widgets/add_product_widgets/images_section_widget.dart';
// import 'package:shop/ui/widgets/My_products_widgets/add_product_widgets/input_text_form_field.dart';
// import 'package:shop/ui/widgets/My_products_widgets/add_product_widgets/update_images_section_widget.dart';
// import 'package:shop/utils/app_palette.dart';
// import 'package:shop/utils/app_size_boxes.dart';
// import 'package:shop/utils/dimensions.dart';
//
// import '../../../business_logic/locations_cubit/locations_cubit.dart';
// import '../../../business_logic/product_details_cubit/product_details_cubit.dart';
// import '../../../data/models/product_model.dart';
// import '../../widgets/common_widgets/dialogs/success_dialog.dart';
// import '../layout/app_layout.dart';
// import '../main_screens/my_products_screen.dart';
// import 'choose_categories_screens/choose_area_product_screen.dart';
// import 'choose_categories_screens/choose_city_product_screen.dart';
// import 'choose_categories_screens/choose_government_product_screen.dart';
//
// class ChangeProductScreen extends StatefulWidget {
//   final MyProductUserResponseModel? product;
//   ChangeProductScreen(
//       {Key? key, this.governmentId, this.governmentName, this.cityId, this.cityName,
//         this.areaId, this.areaName, this.locationUser, this.nameProduct, this.fromPrice, this.toPrice, this.description,
//         this.fuelType,this.bodyType,this.amenitiesType,this.colorType,this.engineCapacityType,this.kiloMetresType,
//         this.levelType, this.product,this.fromYear,this.toYear,this.productId})
//       : super(key: key);
//
//   String? governmentId, governmentName;
//   String? cityId, cityName,productId;
//   String? areaId, areaName,fromYear,toYear;
//   String? locationUser,fuelType,amenitiesType,bodyType,colorType,engineCapacityType,kiloMetresType,levelType;
//   String? fromPrice, toPrice, nameProduct, description;
//
//   @override
//   State<ChangeProductScreen> createState() => _ChangeProductScreenState();
// }
//
// class _ChangeProductScreenState extends State<ChangeProductScreen> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   TextEditingController nameOfProductController = TextEditingController();
//   TextEditingController oldPriceController = TextEditingController();
//   TextEditingController newPriceController = TextEditingController();
//   TextEditingController descriptionController = TextEditingController();
//   TextEditingController downPaymentController = TextEditingController();
//   TextEditingController areaPropertiesController = TextEditingController();
//   TextEditingController yearOfProductController = TextEditingController();
//   TextEditingController kiloMetresOfProductController = TextEditingController();
//   TextEditingController bedroomOfProductController = TextEditingController();
//   TextEditingController bathroomOfProductController = TextEditingController();
//   late String locationUser;
//   late String statusUser;
//   late String warrantyType;
//   late String optionValueList;
//   late String categoryId;
//   late String apartmentType;
//   late String statusApartmentType;
//   late String transmissionType;
//   late String furnishedType;
//   late String homeFurnitureType;
//   late String homeFashionType;
//   late String booksType;
//   String? statusProduct;
//   String? oldPrice;
//   var areaNameProduct, cityNameProduct,governmentNameProduct,locationProduct,locationList;
//   bool? statusProductChoose = false;
//   @override
//   void dispose() {
//     nameOfProductController.dispose();
//     oldPriceController.dispose();
//     newPriceController.dispose();
//     descriptionController.dispose();
//     super.dispose();
//   }
//
//   clearItemProduct(){
//     nameOfProductController.clear();
//     oldPriceController.clear();
//     newPriceController.clear();
//     descriptionController.clear();
//   }
//
//   // _submit(BuildContext context, {required AddProductCubit addProductCubit}) {
//   //   print(nameOfProductController.text);
//   //   print(descriptionController.text);
//   //   print(priceController.text);
//   //   if (_formKey.currentState!.validate()) {
//   //     addProductCubit.updateProduct(context,pr);
//   //   }
//   // }
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     //  CustomFlutterToast((widget.product.price!.toInt()).toString());
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.product?.name ?? LocaleKeys.newProduct.tr()),
//         elevation: 0.0,
//         leading: InkWell(
//           onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => AppLayout())),
//           child: const Icon(Icons.arrow_back_ios,
//               size: 20.0, color: AppPalette.black),
//         ),
//       ),
//       body: BlocConsumer<AddProductCubit, AddProductState>(
//         listener: (context, AddProductState) {
//           if (AddProductState is AddProductErrorState) {
//             CustomFlutterToast(AddProductState.error);
//           } else if (AddProductState is AddProductSuccessState) {
//             SuccessAlertDialog.showConfirmationDialog(context,
//                 title: 'Successfully updated product ',
//                 confirmLabel: "Done",
//                 imageUrl: "assets/images/svg/addProduct.svg", onTap: () {
//                   Navigator.of(context).pushReplacement(MaterialPageRoute(
//                     builder: (context) => AppLayout(),
//                   ));
//                 });
//           }
//         },
//         builder: (context, state) {
//           // var List = widget.product.images;
//           // var stringList = List!.join(",");
//           AddProductCubit addProductController = AddProductCubit.get(context);
//
//
//           return  BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
//             builder: (context, state) {
//               if (state is SuccessProductDetailsState) {
//                 nameOfProductController.text =
//                 widget.nameProduct == null ?
//                 '${state.myFavoriteResponseModel![0].name}' : '${widget.nameProduct}';
//
//                 oldPriceController.text =
//                 widget.fromPrice == null ?
//                 '${state.myFavoriteResponseModel![0].oldPrice}' :  '${widget.fromPrice}';
//
//                 newPriceController.text =
//                 widget.toPrice == null ?
//                 '${state.myFavoriteResponseModel![0].price}' :  '${widget.toPrice}';
//
//                 descriptionController.text =
//                 widget.description == null ?
//                      '${state.myFavoriteResponseModel![0].description}' :'${widget.description}';
//
//                 if(state.showDetailsProductResponseModel![0].location != null){
//                   locationProduct = state.showDetailsProductResponseModel![0].location ;
//                   locationList = locationProduct.split(' ');
//                   governmentNameProduct = locationList![0].trim();
//                   cityNameProduct = locationList![1].trim();
//                   areaNameProduct = locationList![2].trim();
//                 }else {
//                   governmentNameProduct = LocaleKeys.government.tr();
//                   cityNameProduct = LocaleKeys.city.tr();
//                   areaNameProduct = LocaleKeys.area.tr();
//                 }
//                 return  Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Expanded(
//                       child: ListView(
//                         shrinkWrap: true,
//                         physics: const BouncingScrollPhysics(),
//                         children: [
//                           Container(
//                             padding: EdgeInsets.only(
//                               top: Dimensions.paddingSizeDefault,
//                               right: Dimensions.paddingSizeDefault,
//                               left: Dimensions.paddingSizeDefault,
//                             ),
//                             child: Form(
//                               key: _formKey,
//                               child: ListView(
//                                 shrinkWrap: true,
//                                 physics: const ScrollPhysics(),
//                                 children: [
//                                   CustomButtonWidget(
//                                     title: '${state.showDetailsProductResponseModel![0].category?.name != null ?
//                                     context.locale.languageCode.contains('en') ?
//                                     state.showDetailsProductResponseModel![0].category?.name?.en :
//                                     context.locale.languageCode.contains('ar') ?
//                                     state.showDetailsProductResponseModel![0].category?.name?.ar! :
//                                     context.locale.languageCode.contains('tr') ?
//                                     state.showDetailsProductResponseModel![0].category?.name?.tr! :
//                                     context.locale.languageCode.contains('de') ?
//                                     state.showDetailsProductResponseModel![0].category?.name?.de! :
//                                     LocaleKeys.category.tr() : LocaleKeys.category.tr()}',
//                                     onTap: () {
//                                       print('images list is ');
//                                       print(state.showDetailsProductResponseModel![0].images!.length);
//                                       print(governmentNameProduct);
//                                       print(cityNameProduct);
//                                       print(areaNameProduct);
//                                     },
//                                   ),
//                                   15.heightBox,
//                                   CustomButtonWidget(
//                                       title: '${state.showDetailsProductResponseModel![0].subcategory?.name != null ?
//                                       context.locale.languageCode.contains('en') ?
//                                       state.showDetailsProductResponseModel![0].subcategory?.name?.en :
//                                       context.locale.languageCode.contains('ar') ?
//                                       state.showDetailsProductResponseModel![0].subcategory?.name?.ar! :
//                                       context.locale.languageCode.contains('tr') ?
//                                       state.showDetailsProductResponseModel![0].subcategory?.name?.tr! :
//                                       context.locale.languageCode.contains('de') ?
//                                       state.showDetailsProductResponseModel![0].subcategory?.name?.de! :
//                                       LocaleKeys.subCategory.tr() : LocaleKeys.subCategory.tr()}',
//                                       onTap: () {}),
//                                   15.heightBox,
//                                   InputTextFormField(
//                                     hintText: LocaleKeys.nameOfProduct.tr(),
//                                     textEditingController: nameOfProductController,
//                                     validator: (val) {
//                                       if (val.isEmpty) {
//                                         return LocaleKeys.mustNotEmpty.tr();
//                                       }
//                                     },
//                                   ),
//                                   15.heightBox,
//                                   InputTextFormField(
//                                     hintText: LocaleKeys.oldPrice.tr(),
//                                     textEditingController: oldPriceController,
//                                     textInputType: TextInputType.number,
//                                     suffixIcon: Container(
//                                       width: 100,
//                                       padding: EdgeInsets.all(
//                                         Dimensions.paddingSize,
//                                       ),
//                                       child:  Row(
//                                         children: [
//                                           Text('(${LocaleKeys.oldPriceText.tr()} ) ',
//                                               style: const TextStyle(
//                                                   color: AppPalette.black,
//                                                   fontWeight: FontWeight.w500)),
//                                           Text(LocaleKeys.currencyPrice.tr())
//                                         ],
//                                       ),),
//                                     validator: (val) {
//                                       // if (val.isEmpty) {
//                                       //   return "enter price";
//                                       // }
//                                     },
//                                   ),
//                                   15.heightBox,
//                                   InputTextFormField(
//                                     hintText: LocaleKeys.newPrice.tr(),
//                                     textEditingController: newPriceController,
//                                     textInputType: TextInputType.number,
//                                     suffixIcon: Container(
//                                       width: 100,
//                                       padding: EdgeInsets.all(
//                                         Dimensions.paddingSize,
//                                       ),
//                                       child:  Row(
//                                         children: [
//                                           Text('(${LocaleKeys.newPriceText.tr()} ) ',
//                                               style: const TextStyle(
//                                                   color: AppPalette.black,
//                                                   fontWeight: FontWeight.w500)),
//                                           Text(LocaleKeys.currencyPrice.tr())
//                                         ],
//                                       ),),
//                                     validator: (val) {
//                                       if (val.isEmpty) {
//                                         return LocaleKeys.mustNotEmpty.tr();
//                                       }
//                                     },
//                                   ),
//                                   15.heightBox,
//                                   // InputTextFormField(
//                                   //   hintText: LocaleKeys.newPrice.tr(),
//                                   //   textEditingController: priceController,
//                                   //   textInputType: TextInputType.number,
//                                   //   suffixIcon: Container(
//                                   //       padding: EdgeInsets.all(
//                                   //         Dimensions.paddingSize,
//                                   //       ),
//                                   //       child: SvgPicture.asset(
//                                   //         "assets/images/svg/doller.svg",
//                                   //         color: AppPalette.black,
//                                   //       )),
//                                   //   validator: (val) {
//                                   //     if (val.isEmpty) {
//                                   //       return "enter price";
//                                   //     }
//                                   //   },
//                                   // ),
//                                   // 15.heightBox,
//                                   // CustomButtonWidget(
//                                   //   title: state.showDetailsProductResponseModel![0].location ??
//                                   //       LocaleKeys.locations.tr(),
//                                   //   onTap: () {
//                                   //     // Navigator.of(context)
//                                   //     //     .push(MaterialPageRoute(
//                                   //     //     builder: (context) =>
//                                   //     //     ChooseProductLocationScreen();
//                                   //   },
//                                   // ),
//                                   // if (addProductController.selectedSubCat != null ||
//                                   //     addProductController.selectedMainCat != null)
//                                   //   15.heightBox,
//                                   // if (addProductController.selectedSubCat != null ||
//                                   //     addProductController.selectedMainCat != null)
//                                   // 15.heightBox,
//                                   // Text(LocaleKeys.brand.tr(),
//                                   //     style: const TextStyle(
//                                   //         color: AppPalette.black,
//                                   //         fontWeight: FontWeight.w500)),
//                                   CustomButtonWidget(
//                                       title: widget.governmentName == null
//                                           ? governmentNameProduct
//                                           : widget.governmentName!,
//                                       onTap: () {
//                                         BlocProvider.of<LocationsCubit>(
//                                             context).getGovernment();
//                                         Navigator.of(context).push(
//                                             MaterialPageRoute(
//                                               builder: (context) =>
//                                                   ChooseGovernmentProductScreen(
//                                                       description: descriptionController.text,
//                                                       levelType: '',
//                                                       kiloMetresType: '',
//                                                       amenitiesType: '',
//                                                       fuelType: '',
//                                                       engineCapacityType: '',
//                                                       colorType: '',
//                                                       bodyType: '',
//                                                       productId: widget.product?.id.toString(),
//                                                       data: 'changeProductScreen',
//                                                       governmentId: widget.governmentId,
//                                                       governmentName: widget.governmentName,
//                                                       cityId: widget.cityId,
//                                                       cityName: widget.cityName,
//                                                       areaId: widget.areaId,
//                                                       areaName: widget.areaName,
//                                                       toPrice: newPriceController.text,
//                                                       fromPrice: oldPriceController.text,
//                                                       nameProduct: nameOfProductController.text,
//                                                       locationUser: ''),
//                                             ));
//                                       }),
//                                   13.heightBox,
//                                   Row(
//                                     children: [
//                                       Expanded(
//                                         child: CustomButtonWidget(
//                                             title: widget.cityName == null
//                                                 ? cityNameProduct
//                                                 : widget.cityName!,
//                                             onTap: () {
//                                               if (widget.governmentId ==
//                                                   null) {
//                                                 CustomFlutterToast(
//                                                     'من فضلك اختر المحافظة');
//                                               } else {
//                                                 BlocProvider.of<
//                                                     LocationsCubit>(
//                                                     context)
//                                                     .getCityOfGovernment(
//                                                     '${widget
//                                                         .governmentId}');
//                                                 Navigator.of(context)
//                                                     .push(
//                                                     MaterialPageRoute(
//                                                       builder: (
//                                                           context) =>
//                                                           ChooseCityProductScreen(
//                                                               description: descriptionController.text,
//                                                               levelType: '',
//                                                               kiloMetresType: '',
//                                                               amenitiesType: '',
//                                                               fuelType: '',
//                                                               engineCapacityType: '',
//                                                               colorType: '',
//                                                               bodyType: '',
//                                                               productId: widget.product?.id.toString(),
//                                                               data: 'changeProductScreen',
//                                                               governmentId: widget.governmentId,
//                                                               governmentName: widget.governmentName,
//                                                               cityId: widget.cityId,
//                                                               cityName: widget.cityName,
//                                                               areaId: widget.areaId,
//                                                               areaName: widget.areaName,
//                                                               toPrice: newPriceController.text,
//                                                               fromPrice: oldPriceController.text,
//                                                               nameProduct: nameOfProductController.text,
//                                                               locationUser: ''),
//                                                     ));
//                                               }
//                                             }),
//                                       ),
//                                       15.widthBox,
//                                       Expanded(
//                                         child: CustomButtonWidget(
//                                             title: widget.areaName == null
//                                                 ? areaNameProduct
//                                                 : widget.areaName!,
//                                             onTap: () {
//                                               if (widget.cityId == null) {
//                                                 CustomFlutterToast(
//                                                     'من فضلك اختر المحافظة');
//                                               } else {
//                                                 BlocProvider.of<
//                                                     LocationsCubit>(
//                                                     context)
//                                                     .getAreaOfCity(
//                                                     '${widget.cityId}');
//                                                 Navigator.of(context)
//                                                     .push(
//                                                     MaterialPageRoute(
//                                                       builder: (
//                                                           context) =>
//                                                           ChooseAreaProductScreen(
//                                                               description: descriptionController.text,
//                                                               levelType: '',
//                                                               kiloMetresType: '',
//                                                               amenitiesType: '',
//                                                               fuelType: '',
//                                                               engineCapacityType: '',
//                                                               colorType: '',
//                                                               bodyType: '',
//                                                               productId: widget.product?.id.toString(),
//                                                               data: 'changeProductScreen',
//                                                               governmentId: widget.governmentId,
//                                                               governmentName: widget.governmentName,
//                                                               cityId: widget.cityId,
//                                                               cityName: widget.cityName,
//                                                               areaId: widget.areaId,
//                                                               areaName: widget.areaName,
//                                                               toPrice: newPriceController.text,
//                                                               fromPrice: oldPriceController.text,
//                                                               nameProduct: nameOfProductController.text,
//                                                               locationUser: ''),
//                                                     ));
//                                               }
//                                             }),
//                                       ),
//                                     ],
//                                   ),
//                                   15.heightBox,
//                                   CustomButtonWidget(
//                                       title:  '${state.showDetailsProductResponseModel![0].brand?.name?.en != '' ?
//                                       context.locale.languageCode.contains('en') ?
//                                       state.showDetailsProductResponseModel![0].brand?.name?.en :
//                                       context.locale.languageCode.contains('ar') ?
//                                       state.showDetailsProductResponseModel![0].brand?.name?.ar! :
//                                       context.locale.languageCode.contains('tr') ?
//                                       state.showDetailsProductResponseModel![0].brand?.name?.tr! :
//                                       context.locale.languageCode.contains('de') ?
//                                       state.showDetailsProductResponseModel![0].brand?.name?.de! :
//                                       LocaleKeys.brand.tr() : LocaleKeys.brand.tr()}',
//                                       onTap: (){
//
//                                         // print('category id ${widget.product?.category?.id}');
//                                         // print(widget.product?.category?.id);
//                                         // Navigator.of(context)
//                                         //     .push(MaterialPageRoute(
//                                         //   builder: (context) =>
//                                         //       ChooseOneBrandScreen(data: 'changeProduct',product: widget.product,)
//                                         // ));
//                                       }),
//                                   15.heightBox,
//                                   Text(LocaleKeys.condition.tr(),
//                                       style: const TextStyle(
//                                           color: AppPalette.black,
//                                           fontWeight: FontWeight.w500)),
//                                   10.heightBox,
//                                   Row(
//                                     children: [
//                                       ConditionWidget(
//                                           title: LocaleKeys.newProd.tr(),
//                                           color: widget.product?.status == 1 ? AppPalette.primary : AppPalette.lightPrimary,
//                                           onTap: (){
//                                             //  addProductController.changeCondition;
//                                           },
//                                           textColor: widget.product?.status == 1 ? AppPalette.white : AppPalette.black
//                                       ),
//                                       8.widthBox,
//                                       ConditionWidget(
//                                         title: LocaleKeys.used.tr(),
//                                         color: widget.product?.status == 0 ? AppPalette.primary : AppPalette.lightPrimary,
//                                         onTap: (){
//                                           //  addProductController.changeCondition;
//                                         },
//                                         textColor: widget.product?.status == 0 ? AppPalette.white : AppPalette.black,
//                                       ),
//                                     ],
//                                   ),
//                                   15.heightBox,
//                                   InputTextFormField(
//                                     hintText: LocaleKeys.description.tr(),
//                                     textEditingController: descriptionController,
//                                     maxLength: 1000000,
//                                     validator: (val) {
//                                       if (val.isEmpty) {
//                                         return LocaleKeys.mustNotEmpty.tr();
//                                       }
//                                     },
//                                     maxLines: 7,
//                                   ),
//                                   15.heightBox,
//                                   Text(LocaleKeys.addToPhotos.tr(),
//                                       style: const TextStyle(
//                                           color: AppPalette.black,
//                                           fontWeight: FontWeight.w500)),
//                                   10.heightBox,
//                                 ],
//                               ),
//                             ),
//                           ),
//                           UpdateImagesSectionWidget(
//                             productModel: state.showDetailsProductResponseModel![0],
//                           ),
//                         ],
//                       ),
//                     ),
//                     15.heightBox,
//                     addProductController.loadingUpdate
//                         ? const Center(
//                       child: CircularProgressIndicator(),
//                     )
//                         : Container(
//                       padding: EdgeInsets.only(
//                         bottom: Dimensions.paddingSizeDefault,
//                         right: Dimensions.paddingSizeDefault,
//                         left: Dimensions.paddingSizeDefault,
//                       ),
//                     ),
//                     35.heightBox,
//                     Container(
//                       padding: EdgeInsets.only(
//                         bottom: Dimensions.paddingSizeDefault,
//                         right: Dimensions.paddingSizeDefault,
//                         left: Dimensions.paddingSizeDefault,
//                       ),
//                       child: CustomButton(
//                         buttonText: LocaleKeys.save.tr(),
//                         onPressed: () {
//
//                           statusProduct = widget.product?.status.toString();
//                           oldPrice = oldPriceController.text != '' ? oldPriceController.text : '';
//
//                           locationUser =
//                           '${widget.governmentName} ${widget.cityName} ${widget.areaName}';
//                           print('update product is ');
//                           print(widget.product?.id == null ? widget.productId : widget.product?.id);
//                           print(nameOfProductController.text);
//                           print(newPriceController.text);
//                           print(oldPriceController.text);
//                           print(descriptionController.text);
//                           print(widget.product?.status);
//                           print('update product government is ');
//                           print(widget.governmentId);
//                           print(widget.cityId);
//                           print(widget.areaId);
//                           print('update product government name is ');
//                           print(widget.governmentName);
//                           print(widget.cityName);
//                           print(widget.areaName);
//                           print(locationUser);
//                           if (_formKey.currentState!.validate()) {
//                             addProductController.updateProduct(context, '${widget.product?.id}', nameOfProductController.text,
//                                 newPriceController.text, oldPriceController.text,
//                                 '${widget.product?.status}',descriptionController.text,'${widget.governmentId}',
//                             '${widget.cityId}','${widget.areaId}',
//                                 '$locationUser','${addProductController.selectedBrand?.id}');
//                             //   clearItemProduct();
//                           }
//                         },
//                         height: 48.h,
//                         fontSize: Dimensions.fontSizeLarge,
//                       ),
//                     ),
//                   ],
//                 );
//               }
//               return const Center(
//                 child: CircularProgressIndicator(),
//               );
//             },
//           );
//
//
//         },
//       ),
//     );
//   }
// }
