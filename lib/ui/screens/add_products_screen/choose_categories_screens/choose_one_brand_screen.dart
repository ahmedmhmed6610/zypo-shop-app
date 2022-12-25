// ignore_for_file: must_be_immutable

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/business_logic/categories_cubit/categories_cubit.dart';
import 'package:shop/business_logic/my_products_cubit/my_products_cubit.dart';
import 'package:shop/business_logic/my_products_cubit/my_products_state.dart';
import 'package:shop/translations/locale_keys.g.dart';
import 'package:shop/ui/screens/add_products_screen/change_product_screen2.dart';
import 'package:shop/ui/widgets/filter_widgets/choose_brand_widgets/choose_brand_search_widget.dart';
import 'package:shop/utils/app_palette.dart';
import 'package:shop/utils/app_size_boxes.dart';
import 'package:shop/utils/dimensions.dart';
import 'package:shop/utils/styles.dart';

import '../../../../data/models/MyProductUserModel.dart';
import '../../filter_screens/filter_screen.dart';
import '../../filter_screens/widget_custom.dart';
import '../add_product_screen.dart';

class ChooseOneBrandScreen extends StatefulWidget {
  ChooseOneBrandScreen({Key? key, this.governmentId, this.governmentName, this.cityId, this.cityName,
    this.areaId, this.areaName, this.locationUser, this.fromPrice, this.toPrice,
    this.fromArea,this.toArea,this.bedroom,this.bathroom,this.nameProduct,this.whatsAppNumber,
    this.fromkiloMetresType,this.tokiloMetresType,this.fromDownPayment,this.toDownPayment,
    this.fuelType, this.bodyType, this.amenitiesType, this.colorType, this.engineCapacityType, this.kiloMetresType,
    this.levelType,this.fromYear,this.toYear,this.typeFashion,
    this.typeHomeFurniture,this.typeBooks,this.typeKids,this.typeBusiness,
    this.data,this.product,this.typeApartment,this.typeCondtion,this.statusApartment,this.typeTransmission,this.description,this.productId}) : super(key: key);

  String? governmentId,governmentName,typeCondtion,typeTransmission,statusApartment;
  String? cityId,cityName,fuelType,amenitiesType,bodyType,colorType,engineCapacityType,kiloMetresType,levelType;
  String? areaId,areaName,nameProduct,description,whatsAppNumber;
  String? locationUser,fromPrice,toPrice,typeApartment;
  String? data,productId,typeFashion,typeHomeFurniture,
      typeBooks,typeKids,typeBusiness;

  String? brandId,fromDownPayment,toDownPayment;
  String? status,fromYear,toYear,bedroom,bathroom;
  String? fromArea,toArea;
  String? fromkiloMetresType,tokiloMetresType;

  final MyProductUserResponseModel? product;
  @override
  State<ChooseOneBrandScreen> createState() => _ChooseOneBrandScreenState();
}

class _ChooseOneBrandScreenState extends State<ChooseOneBrandScreen> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   // print('data is ${widget.data}');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPalette.primary,
      body: CustomAppBar(
        onTap: () {
          if(widget.data!.contains('filterScreen')){
            Navigator.push(context, MaterialPageRoute
              (builder: (context) => FilterScreen(
                governmentId: widget
                    .governmentId,
                governmentName: widget
                    .governmentName,
                fromPrice: widget.fromPrice,
                toPrice: widget.toPrice,
                cityId: widget.cityId,
                locationUser: widget.locationUser,
                fromYear: widget.fromYear,
                toYear: widget.toYear,
                bathroom: widget.bathroom,
                bedroom: widget.bedroom,
                fromArea: widget.fromArea,
                toArea: widget.toArea,
                fromDownPayment: widget.fromDownPayment,
                toDownPayment: widget.toDownPayment,
                fromkiloMetresType: widget.fromkiloMetresType,
                tokiloMetresType: widget.tokiloMetresType,
                cityName: widget.cityName,
                areaId: widget.areaId,
                amenitiesType: widget.amenitiesType,
                bodyType: widget.bodyType,
                colorType: widget.colorType,
                engineCapacityType: widget.engineCapacityType,
                fuelType: widget.fuelType,
                kiloMetresType: widget.kiloMetresType,
                levelType: widget.levelType,
                areaName: widget.areaName)));
          }else if(widget.data!.contains('changeProduct')){
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => ChangeProductScreen2(
                    governmentId: widget
                        .governmentId,
                    governmentName: widget
                        .governmentName,
                    fromPrice: widget.fromPrice,
                    toPrice: widget.toPrice,
                    cityId: widget.cityId,
                    locationUser: widget.locationUser,
                    year: widget.fromYear,
                    whatsAppNumber: widget.whatsAppNumber,
                    statusApartment: widget.statusApartment,
                    typeCondtion: widget.typeCondtion,
                    typeApartment: widget.typeApartment,
                    transmissionVehicles: widget.typeTransmission,
                    typeBooks: widget.typeBooks,
                    typeBusiness: widget.typeBusiness,
                    typeHomeFurniture: widget.typeHomeFurniture,
                    typeKids: widget.typeKids,
                    description: widget.description,
                    typeFashion: widget.typeFashion,
                    nameProduct: widget.nameProduct,
                    bathroom: widget.bathroom,
                    bedroom: widget.bedroom,
                    area: widget.fromArea,
                    downPayment: widget.fromDownPayment,
                    kiloMetresType: widget.fromkiloMetresType,
                    cityName: widget.cityName,
                    areaId: widget.areaId,
                    amenitiesType: widget.amenitiesType,
                    bodyType: widget.bodyType,
                    colorType: widget.colorType,
                    engineCapacityType: widget.engineCapacityType,
                    fuelType: widget.fuelType,
                    levelType: widget.levelType,
                    areaName: widget.areaName)));
          }else if(widget.data!.contains('AddProduct')){
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => AddProductScreen(
                    governmentId: widget
                        .governmentId,
                    governmentName: widget
                        .governmentName,
                    fromPrice: widget.fromPrice,
                    toPrice: widget.toPrice,
                    cityId: widget.cityId,
                    locationUser: widget.locationUser,
                    year: widget.fromYear,
                    whatsAppNumber: widget.whatsAppNumber,
                    nameProduct: widget.nameProduct,
                    description: widget.description,
                    bathroom: widget.bathroom,
                    bedroom: widget.bedroom,
                    area: widget.fromArea,
                    downPayment: widget.fromDownPayment,
                    kiloMetresType: widget.fromkiloMetresType,
                    cityName: widget.cityName,
                    areaId: widget.areaId,
                    amenitiesType: widget.amenitiesType,
                    bodyType: widget.bodyType,
                    colorType: widget.colorType,
                    engineCapacityType: widget.engineCapacityType,
                    fuelType: widget.fuelType,
                    levelType: widget.levelType,
                    areaName: widget.areaName)));
          }
        },
        title: LocaleKeys.brand.tr(),
        widgetCustom:  RefreshIndicator(
          onRefresh: () async{
            CategoriesCubit categoriesCubit = CategoriesCubit.get(context);
            AddProductCubit addProductCubit = AddProductCubit.get(context);

          },
          child: BlocBuilder<CategoriesCubit, CategoriesState>(
            builder: (context, state) {
              CategoriesCubit categoriesCubit = CategoriesCubit.get(context);
              return BlocBuilder<AddProductCubit, AddProductState>(
                builder: (context, state) {
                  AddProductCubit addProductCubit = AddProductCubit.get(context);
                  return RefreshIndicator(
                    onRefresh: ()async {
                      categoriesCubit.getBrandsByCategory(categoryID: addProductCubit.selectedMainCat != null
                          ? addProductCubit
                          .selectedMainCat!.id!
                          : categoriesCubit.selectedParent);
                      print('refresh');
                    },
                    child: Container(
                      padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            LocaleKeys.chooseBrand.tr(),
                            style: AppTextStyles.poppinsMedium
                                .copyWith(color: AppPalette.black),
                          ),
                          10.heightBox,
                          ChooseBrandSearchWidget(),
                          5.heightBox,
                          Expanded(
                            child: ListView(
                              children: [
                                7.heightBox,
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const ScrollPhysics(),
                                  itemCount: categoriesCubit
                                      .brandsByCategory[
                                  addProductCubit.selectedMainCat != null
                                      ? addProductCubit
                                      .selectedMainCat!.id
                                      : categoriesCubit.selectedParent]!
                                      .brands
                                      .length,
                                  padding: EdgeInsets.zero,

                                  itemBuilder: (context, index) => InkWell(
                                    onTap: (){
                                      BlocProvider.of<AddProductCubit>(context, listen: false)
                                          .getModelFromVehicle('${categoriesCubit.brandsByCategory[
                                      addProductCubit.selectedMainCat != null ? addProductCubit.selectedMainCat!.id :
                                      categoriesCubit.selectedParent]!.brands[index].id}',);
                                      addProductCubit.selectBrand(
                                          brandModel: categoriesCubit
                                              .brandsByCategory[addProductCubit
                                              .selectedMainCat !=
                                              null
                                              ? addProductCubit
                                              .selectedMainCat!.id
                                              : categoriesCubit
                                              .selectedParent]!
                                              .brands[index]);
                                      if(widget.data!.contains('filterScreen')){
                                        Navigator.push(context, MaterialPageRoute
                                          (builder: (context) => FilterScreen(
                                            governmentId: widget
                                                .governmentId,
                                            governmentName: widget
                                                .governmentName,
                                            fromPrice: widget.fromPrice,
                                            toPrice: widget.toPrice,
                                            cityId: widget.cityId,
                                            locationUser: widget.locationUser,
                                            fromYear: widget.fromYear,
                                            toYear: widget.toYear,
                                            bathroom: widget.bathroom,
                                            bedroom: widget.bedroom,
                                            fromArea: widget.fromArea,
                                            toArea: widget.toArea,
                                            fromDownPayment: widget.fromDownPayment,
                                            toDownPayment: widget.toDownPayment,
                                            fromkiloMetresType: widget.fromkiloMetresType,
                                            tokiloMetresType: widget.tokiloMetresType,
                                            cityName: widget.cityName,
                                            areaId: widget.areaId,
                                            amenitiesType: widget.amenitiesType,
                                            bodyType: widget.bodyType,
                                            colorType: widget.colorType,
                                            engineCapacityType: widget.engineCapacityType,
                                            fuelType: widget.fuelType,
                                            kiloMetresType: widget.kiloMetresType,
                                            levelType: widget.levelType,
                                            areaName: widget.areaName)));
                                      }else if(widget.data!.contains('changeProduct')){
                                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                                            builder: (context) => ChangeProductScreen2(
                                                governmentId: widget
                                                    .governmentId,
                                                governmentName: widget
                                                    .governmentName,
                                                fromPrice: widget.fromPrice,
                                                toPrice: widget.toPrice,
                                                cityId: widget.cityId,
                                                whatsAppNumber: widget.whatsAppNumber,
                                                statusApartment: widget.statusApartment,
                                                typeCondtion: widget.typeCondtion,
                                                typeApartment: widget.typeApartment,
                                                transmissionVehicles: widget.typeTransmission,
                                                description: widget.description,
                                                nameProduct: widget.nameProduct,
                                                locationUser: widget.locationUser,
                                                typeFashion: widget.typeFashion,
                                                year: widget.fromYear,
                                                bathroom: widget.bathroom,
                                                bedroom: widget.bedroom,
                                                typeBooks: widget.typeBooks,
                                                typeBusiness: widget.typeBusiness,
                                                typeHomeFurniture: widget.typeHomeFurniture,
                                                typeKids: widget.typeKids,
                                                area: widget.fromArea,
                                                downPayment: widget.fromDownPayment,
                                                kiloMetresType: widget.fromkiloMetresType,
                                                cityName: widget.cityName,
                                                areaId: widget.areaId,
                                                amenitiesType: widget.amenitiesType,
                                                bodyType: widget.bodyType,
                                                colorType: widget.colorType,
                                                engineCapacityType: widget.engineCapacityType,
                                                fuelType: widget.fuelType,
                                                levelType: widget.levelType,
                                                areaName: widget.areaName)));
                                      }else if(widget.data!.contains('AddProduct')){
                                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                                            builder: (context) => AddProductScreen(
                                                governmentId: widget
                                                    .governmentId,
                                                governmentName: widget
                                                    .governmentName,
                                                fromPrice: widget.fromPrice,
                                                toPrice: widget.toPrice,
                                                cityId: widget.cityId,
                                                locationUser: widget.locationUser,
                                                whatsAppNumber: widget.whatsAppNumber,
                                                year: widget.fromYear,
                                                nameProduct: widget.nameProduct,
                                                description: widget.description,
                                                bathroom: widget.bathroom,
                                                bedroom: widget.bedroom,
                                                area: widget.fromArea,
                                                downPayment: widget.fromDownPayment,
                                                kiloMetresType: widget.fromkiloMetresType,
                                                cityName: widget.cityName,
                                                areaId: widget.areaId,
                                                amenitiesType: widget.amenitiesType,
                                                bodyType: widget.bodyType,
                                                colorType: widget.colorType,
                                                engineCapacityType: widget.engineCapacityType,
                                                fuelType: widget.fuelType,
                                                levelType: widget.levelType,
                                                areaName: widget.areaName)));
                                      }
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(7.0),
                                      child: Row(
                                        children: [
                                          // Radio(
                                          //     value: categoriesCubit
                                          //         .brandsByCategory[addProductCubit.selectedMainCat != null
                                          //             ? addProductCubit
                                          //                 .selectedMainCat!.id
                                          //             : categoriesCubit
                                          //                 .selectedParent]!
                                          //         .brands[index],
                                          //     groupValue:
                                          //         addProductCubit.selectedBrand,
                                          //     activeColor: AppPalette.primary,
                                          //     onChanged: (BrandModel? brand) =>
                                          //         addProductCubit.selectBrand(
                                          //             brandModel: brand!),
                                          //     visualDensity: const VisualDensity(
                                          //       horizontal:
                                          //           VisualDensity.minimumDensity,
                                          //     ),
                                          //     materialTapTargetSize:
                                          //         MaterialTapTargetSize
                                          //             .shrinkWrap),
                                          12.widthBox,
                                          context.locale.languageCode.contains("en") ?
                                          Text(
                                            '${categoriesCubit.brandsByCategory[
                                            addProductCubit.selectedMainCat != null ? addProductCubit.selectedMainCat!.id :
                                            categoriesCubit.selectedParent]!.brands[index].brandName!.en}',
                                            style: AppTextStyles.poppinsRegular
                                                .copyWith(
                                                color: AppPalette.black),
                                          ) : context.locale.languageCode.contains("ar") ?
                                          Text(
                                              '${categoriesCubit.brandsByCategory[
                                              addProductCubit.selectedMainCat != null ? addProductCubit.selectedMainCat!.id :
                                              categoriesCubit.selectedParent]!.brands[index].brandName!.ar}',
                                              style: AppTextStyles.poppinsRegular
                                                  .copyWith(
                                                  color: AppPalette.black)) :
                                          context.locale.languageCode.contains("tr") ?
                                          Text(
                                              '${categoriesCubit.brandsByCategory[
                                              addProductCubit.selectedMainCat != null ? addProductCubit.selectedMainCat!.id :
                                              categoriesCubit.selectedParent]!.brands[index].brandName!.tr}',
                                              style: AppTextStyles.poppinsRegular
                                                  .copyWith(
                                                  color: AppPalette.black)) :
                                          context.locale.languageCode.contains("de") ?
                                          Text(
                                              '${categoriesCubit.brandsByCategory[
                                              addProductCubit.selectedMainCat != null ? addProductCubit.selectedMainCat!.id :
                                              categoriesCubit.selectedParent]!.brands[index].brandName!.de}',
                                              style: AppTextStyles.poppinsRegular
                                                  .copyWith(
                                                  color: AppPalette.black)) : const Text('') ,
                                        ],
                                      ),
                                    ),
                                  ),
                                  // value: filterCubit.locations[index],
                                  // title: Text(filterCubit.locations[index].location),
                                  // contentPadding: EdgeInsets.zero,
                                  // activeColor: AppPalette.primary,
                                  // groupValue: filterCubit.selectedLocation,
                                  // onChanged: (LocationModel? location) =>
                                  //     filterCubit.selectLocation(location: location!))
                                ),
                              ],
                            ),
                          ),
                          5.heightBox,
                          // CustomButton(
                          //   buttonText: LocaleKeys.apply.tr(),
                          //   onPressed: (){
                          //     if(widget.data!.contains('filterScreen')){
                          //       Navigator.push(context, MaterialPageRoute
                          //         (builder: (context) => FilterScreen(
                          //           governmentId: widget
                          //               .governmentId,
                          //           governmentName: widget
                          //               .governmentName,
                          //           fromPrice: widget.fromPrice,
                          //           toPrice: widget.toPrice,
                          //           cityId: widget.cityId,
                          //           locationUser: '',
                          //           fromYear: widget.fromYear,
                          //           toYear: widget.toYear,
                          //           bathroom: widget.bathroom,
                          //           bedroom: widget.bedroom,
                          //           fromArea: widget.fromArea,
                          //           toArea: widget.toArea,
                          //           fromDownPayment: widget.fromDownPayment,
                          //           toDownPayment: widget.toDownPayment,
                          //           fromkiloMetresType: widget.fromkiloMetresType,
                          //           tokiloMetresType: widget.tokiloMetresType,
                          //           cityName: widget.cityName,
                          //           areaId: widget.areaId,
                          //           amenitiesType: widget.amenitiesType,
                          //           bodyType: widget.bodyType,
                          //           colorType: widget.colorType,
                          //           engineCapacityType: widget.engineCapacityType,
                          //           fuelType: widget.fuelType,
                          //           kiloMetresType: widget.kiloMetresType,
                          //           levelType: widget.levelType,
                          //           areaName: widget.areaName)));
                          //     }else if(widget.data!.contains('changeProduct')){
                          //       // Navigator.of(context).pushReplacement(MaterialPageRoute(
                          //       //     builder: (context) => ChangeProductScreen(product: widget.product,)));
                          //     }else {
                          //
                          //       Navigator.of(context).pushReplacement(MaterialPageRoute(
                          //           builder: (context) => AddProductScreen(
                          //               governmentId: widget
                          //                   .governmentId,
                          //               governmentName: widget
                          //                   .governmentName,
                          //               fromPrice: widget.fromPrice,
                          //               toPrice: widget.toPrice,
                          //               cityId: widget.cityId,
                          //               locationUser: '',
                          //               year: widget.fromYear,
                          //               bathroom: widget.bathroom,
                          //               bedroom: widget.bedroom,
                          //               area: widget.fromArea,
                          //               downPayment: widget.fromDownPayment,
                          //               kiloMetresType: widget.fromkiloMetresType,
                          //               cityName: widget.cityName,
                          //               areaId: widget.areaId,
                          //               amenitiesType: widget.amenitiesType,
                          //               bodyType: widget.bodyType,
                          //               colorType: widget.colorType,
                          //               engineCapacityType: widget.engineCapacityType,
                          //               fuelType: widget.fuelType,
                          //               levelType: widget.levelType,
                          //               areaName: widget.areaName)));
                          //     }
                          //   },
                          //   height: 48.h,
                          //   fontSize: Dimensions.fontSizeLarge,
                          // ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),),
    );
  }
}
