// ignore_for_file: must_be_immutable

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/business_logic/my_products_cubit/my_products_cubit.dart';
import 'package:shop/business_logic/my_products_cubit/my_products_state.dart';
import 'package:shop/translations/locale_keys.g.dart';
import 'package:shop/ui/widgets/filter_widgets/choose_color_screen/choose_color_search_widget.dart';
import 'package:shop/utils/app_palette.dart';
import 'package:shop/utils/app_size_boxes.dart';
import 'package:shop/utils/dimensions.dart';
import 'package:shop/utils/styles.dart';

import '../../../../data/color_model.dart';
import '../../filter_screens/widget_custom.dart';
import '../add_product_screen.dart';
import '../change_product_screen2.dart';

class ChooseAmenitiesAddProductScreen extends StatefulWidget {

  ChooseAmenitiesAddProductScreen(
      {Key? key, this.governmentId, this.governmentName, this.cityId, this.cityName,this.whatsAppNumber,
        this.fuelTypeAr,this.bodyTypeAr,this.engineCapacityTypeAr,this.amenitiesTypeAr,this.colorTypeAr,
        this.areaId, this.areaName, this.locationUser, this.nameProduct, this.fromPrice, this.toPrice, this.description,
        this.fuelType,this.bodyType,this.amenitiesType,this.colorType,this.engineCapacityType,this.kiloMetresType,
        this.levelType,this.year,this.bedroom,this.bathroom,this.typeApartment,this.downPayment,this.data,this.area,
        this.statusApartment,this.productId,this.furnishedType})
      : super(key: key);

  String? governmentId, governmentName,whatsAppNumber,furnishedType;
  String? cityId, cityName,bedroom,bathroom,year,area,downPayment;
  String? areaId, areaName,typeApartment,statusApartment;
  String? data,productId;
  String? locationUser,fuelTypeAr,fuelType,amenitiesTypeAr,amenitiesType,
      bodyTypeAr,bodyType,colorTypeAr,colorType,engineCapacityTypeAr,engineCapacityType,kiloMetresType,levelType;
  String? fromPrice, toPrice, nameProduct, description;

  @override
  State<ChooseAmenitiesAddProductScreen> createState() => _ChooseAmenitiesAddProductScreenState();
}

class _ChooseAmenitiesAddProductScreenState extends State<ChooseAmenitiesAddProductScreen> {

  ColorModel? selectedAmenities;


  List<ColorModel> dummyAmenities = [
    ColorModel(id: 1, color: LocaleKeys.balcony.tr()),
    ColorModel(id: 2, color: LocaleKeys.builtkitchen.tr()),
    ColorModel(id: 3, color: LocaleKeys.privateGarden.tr()),
    ColorModel(id: 4, color: LocaleKeys.central.tr()),
    ColorModel(id: 5, color:LocaleKeys.security.tr()),
    ColorModel(id: 6, color: LocaleKeys.coveredParking.tr()),
    ColorModel(id: 7, color: LocaleKeys.maidsRoom.tr()),
    ColorModel(id: 8, color:LocaleKeys.petsAllowed.tr()),
    ColorModel(id: 9, color: LocaleKeys.pool.tr()),
    ColorModel(id: 10, color: LocaleKeys.electricity.tr()),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   // CustomFlutterToast(widget.downPayment);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPalette.primary,
      body: CustomAppBar(
        onTap: () {
          if(widget.data!.contains('changeProduct')){
            Navigator.pushReplacement(context, MaterialPageRoute
              (builder: (context) => ChangeProductScreen2(
                governmentId: widget
                    .governmentId,
                governmentName: widget
                    .governmentName,
                nameProduct: widget.nameProduct,
                fromPrice: widget.fromPrice,
                toPrice: widget.toPrice,
                bedroom: widget.bedroom,
                furnishedType: widget.furnishedType,
                whatsAppNumber: widget.whatsAppNumber,
                bathroom: widget.bathroom,
                area: widget.area,
                locationUser: widget.locationUser,
                downPayment: widget.downPayment,
                year: widget.year,
                typeApartment: widget.typeApartment,
                statusApartment: widget.statusApartment,
                description: widget.description,
                cityId: widget.cityId,
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

          }else {
            Navigator.pushReplacement(context, MaterialPageRoute
              (builder: (context) => AddProductScreen(
                governmentId: widget
                    .governmentId,
                governmentName: widget
                    .governmentName,
                nameProduct: widget.nameProduct,
                fromPrice: widget.fromPrice,
                toPrice: widget.toPrice,
                bedroom: widget.bedroom,
                bathroom: widget.bathroom,
                locationUser: widget.locationUser,
                whatsAppNumber: widget.whatsAppNumber,
                area: widget.area,
                downPayment: widget.downPayment,
                year: widget.year,
                description: widget.description,
                cityId: widget.cityId,
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
          }
        },
        title: LocaleKeys.amenities.tr(),
        widgetCustom: BlocBuilder<AddProductCubit, AddProductState>(
          builder: (context, state) {
            return Container(
              padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    LocaleKeys.amenities.tr(),
                    style: AppTextStyles.poppinsMedium
                        .copyWith(color: AppPalette.black),
                  ),
                  10.heightBox,
                  ChooseColorSearchWidget(),
                  5.heightBox,
                  Expanded(
                    child: ListView(
                      children: [
                        7.heightBox,
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          itemCount: dummyAmenities.length,
                          padding: EdgeInsets.zero,
                          itemBuilder: (context, index) => InkWell(
                            onTap: () {
                              if(widget.data!.contains('changeProduct')){
                                Navigator.pushReplacement(context, MaterialPageRoute
                                  (builder: (context) => ChangeProductScreen2(
                                    governmentId: widget
                                        .governmentId,
                                    governmentName: widget
                                        .governmentName,
                                    nameProduct: widget.nameProduct,
                                    fromPrice: widget.fromPrice,
                                    toPrice: widget.toPrice,
                                    bedroom: widget.bedroom,
                                    bathroom: widget.bathroom,
                                    area: widget.area,
                                    furnishedType: widget.furnishedType,
                                    locationUser: widget.locationUser,
                                    downPayment: widget.downPayment,
                                    year: widget.year,
                                    typeApartment: widget.typeApartment,
                                    statusApartment: widget.statusApartment,
                                    description: widget.description,
                                    cityId: widget.cityId,
                                    whatsAppNumber: widget.whatsAppNumber,
                                    cityName: widget.cityName,
                                    areaId: widget.areaId,
                                    amenitiesType: dummyAmenities[index].color,
                                    bodyType: widget.bodyType,
                                    colorType: widget.colorType,
                                    engineCapacityType: widget.engineCapacityType,
                                    fuelType: widget.fuelType,
                                    kiloMetresType: widget.kiloMetresType,
                                    levelType: widget.levelType,
                                    areaName: widget.areaName)));

                              }else {
                                Navigator.pushReplacement(context, MaterialPageRoute
                                  (builder: (context) => AddProductScreen(
                                    governmentId: widget
                                        .governmentId,
                                    governmentName: widget
                                        .governmentName,
                                    nameProduct: widget.nameProduct,
                                    fromPrice: widget.fromPrice,
                                    toPrice: widget.toPrice,
                                    bedroom: widget.bedroom,
                                    locationUser: widget.locationUser,
                                    bathroom: widget.bathroom,
                                    area: widget.area,
                                    whatsAppNumber: widget.whatsAppNumber,
                                    downPayment: widget.downPayment,
                                    year: widget.year,
                                    description: widget.description,
                                    cityId: widget.cityId,
                                    cityName: widget.cityName,
                                    areaId: widget.areaId,
                                    amenitiesType: dummyAmenities[index].color,
                                    bodyType: widget.bodyType,
                                    colorType: widget.colorType,
                                    engineCapacityType: widget.engineCapacityType,
                                    fuelType: widget.fuelType,
                                    kiloMetresType: widget.kiloMetresType,
                                    levelType: widget.levelType,
                                    areaName: widget.areaName)));
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(7.0),
                              child: Row(
                                children: [
                                  // Radio(
                                  //     value: filterCubit.addProductAmenities[index],
                                  //     groupValue: filterCubit.selectedAmenities,
                                  //     activeColor: AppPalette.primary,
                                  //     onChanged: (ColorModel? colorModel) =>
                                  //         filterCubit.selectAmenitiesModel(
                                  //             colorModel: colorModel!),
                                  //     visualDensity: const VisualDensity(
                                  //       horizontal:
                                  //       VisualDensity.minimumDensity,
                                  //     ),
                                  //     materialTapTargetSize: MaterialTapTargetSize.shrinkWrap),
                                  12.widthBox,
                                  Text(
                                    dummyAmenities[index].color,
                                    style: AppTextStyles.poppinsRegular
                                        .copyWith(color: AppPalette.black),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  5.heightBox,
                  // CustomButton(
                  //   buttonText: LocaleKeys.apply.tr(),
                  //   onPressed: () => Navigator.of(context).pop(),
                  //   height: 48.h,
                  //   fontSize: Dimensions.fontSizeLarge,
                  // ),
                ],
              ),
            );
          },
        ),),
    );
  }
}
