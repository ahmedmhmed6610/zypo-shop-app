// ignore_for_file: must_be_immutable

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop/business_logic/categories_cubit/categories_cubit.dart';
import 'package:shop/business_logic/my_products_cubit/my_products_cubit.dart';
import 'package:shop/business_logic/my_products_cubit/my_products_state.dart';
import 'package:shop/translations/locale_keys.g.dart';
import 'package:shop/ui/base/custom_button.dart';
import 'package:shop/ui/screens/add_products_screen/change_product_screen2.dart';
import 'package:shop/ui/widgets/filter_widgets/choose_brand_widgets/choose_brand_search_widget.dart';
import 'package:shop/utils/app_palette.dart';
import 'package:shop/utils/app_size_boxes.dart';
import 'package:shop/utils/dimensions.dart';
import 'package:shop/utils/styles.dart';

import '../../../../data/models/show_details_product_model.dart';
import '../../filter_screens/filter_screen.dart';
import '../../filter_screens/widget_custom.dart';
import '../add_product_screen.dart';

class ChooseOneBrandChangeScreen extends StatefulWidget {
  ChooseOneBrandChangeScreen({Key? key, this.governmentId, this.governmentName, this.cityId, this.cityName,
    this.areaId, this.areaName, this.locationUser, this.nameProduct, this.fromPrice, this.toPrice, this.description,
    this.fuelType,this.bodyType,this.amenitiesType,this.colorType,this.engineCapacityType,this.kiloMetresType,
    this.levelType,this.year,this.bedroom,this.data,this.typeApartment,this.statusApartment,this.typeFashion,this.whatsAppNumber,
    this.typeHomeFurniture,this.typeBooks,this.typeKids,this.typeBusiness,this.warrantyElectronic,this.transmissionVehicles,
    this.bathroom,this.downPayment,this.area,this.product,this.typeCondtion,this.typeWarrannt}) : super(key: key);

  String? governmentId,governmentName;
  String? cityId,cityName,fuelType,amenitiesType,bodyType,colorType,engineCapacityType,kiloMetresType,levelType;
  String? areaId,areaName,nameProduct,description;
  String? locationUser,fromPrice,toPrice;
  String? data;

  String? brandId,fromDownPayment,toDownPayment,whatsAppNumber;
  String? status,fromYear,toYear,bedroom,bathroom;
  String? fromArea,toArea;
  String? fromkiloMetresType,tokiloMetresType;

  String? typeCondtion,typeWarrannt;
  String? typeApartment,statusApartment,typeFashion,typeHomeFurniture,
      typeBooks,typeKids,typeBusiness,warrantyElectronic,transmissionVehicles;
  String? year,area,downPayment;

  final ShowDetailsProductResponseModel? product;
  @override
  State<ChooseOneBrandChangeScreen> createState() => _ChooseOneBrandChangeScreenState();
}

class _ChooseOneBrandChangeScreenState extends State<ChooseOneBrandChangeScreen> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  //  print('data is ${widget.data}');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPalette.primary,
      body: CustomAppBar(
        onTap: () {
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
                  bathroom: widget.bathroom,
                  bedroom: widget.bedroom,
                  area: widget.fromArea,
                  whatsAppNumber: widget.whatsAppNumber,
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
        },
        title: LocaleKeys.brand.tr(),
        widgetCustom:  BlocBuilder<CategoriesCubit, CategoriesState>(
          builder: (context, state) {
            CategoriesCubit categoriesCubit = CategoriesCubit.get(context);
            return BlocBuilder<AddProductCubit, AddProductState>(
              builder: (context, state) {
                AddProductCubit addProductCubit = AddProductCubit.get(context);
                // print('addProductCubit.selectedMainCat');
                // print(addProductCubit.selectedMainCat);
                // print(widget.product?.category?.id);
                return Container(
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
                                  : widget.product?.category?.id]!
                                  .brands
                                  .length,
                              padding: EdgeInsets.zero,

                              itemBuilder: (context, index) => InkWell(
                                onTap: (){
                                  // BlocProvider.of<AddProductCubit>(context, listen: false)
                                  //     .getModelFromVehicle('${categoriesCubit.brandsByCategory[
                                  // addProductCubit.selectedMainCat != null ? addProductCubit.selectedMainCat!.id :
                                  // widget.product?.category?.id]!.brands[index].id}',);
                                  addProductCubit.selectBrand(
                                      brandModel: categoriesCubit
                                          .brandsByCategory[addProductCubit
                                          .selectedMainCat !=
                                          null
                                          ? addProductCubit
                                          .selectedMainCat!.id
                                          : widget.product?.category?.id]!
                                          .brands[index]);

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
                                        widget.product?.category?.id]!.brands[index].brandName!.en}',
                                        style: AppTextStyles.poppinsRegular
                                            .copyWith(
                                            color: AppPalette.black),
                                      ): context.locale.languageCode.contains("ar") ?
                                      Text(
                                          '${categoriesCubit.brandsByCategory[
                                          addProductCubit.selectedMainCat != null ? addProductCubit.selectedMainCat!.id :
                                          widget.product?.category?.id]!.brands[index].brandName!.ar}',
                                          style: AppTextStyles.poppinsRegular
                                              .copyWith(
                                              color: AppPalette.black)) :
                                      context.locale.languageCode.contains("tr") ?
                                      Text(
                                          '${categoriesCubit.brandsByCategory[
                                          addProductCubit.selectedMainCat != null ? addProductCubit.selectedMainCat!.id :
                                          widget.product?.category?.id]!.brands[index].brandName!.tr}',
                                          style: AppTextStyles.poppinsRegular
                                              .copyWith(
                                              color: AppPalette.black)) :
                                      context.locale.languageCode.contains("de") ?
                                      Text(
                                          '${categoriesCubit.brandsByCategory[
                                          addProductCubit.selectedMainCat != null ? addProductCubit.selectedMainCat!.id :
                                          widget.product?.category?.id]!.brands[index].brandName!.de}',
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
                      CustomButton(
                        buttonText: LocaleKeys.apply.tr(),
                        onPressed: (){
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
                            // Navigator.of(context).pushReplacement(MaterialPageRoute(
                            //     builder: (context) => ChangeProductScreen(product: widget.product,)));
                          }else {

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
                        height: 48.h,
                        fontSize: Dimensions.fontSizeLarge,
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),),
    );
  }
}
