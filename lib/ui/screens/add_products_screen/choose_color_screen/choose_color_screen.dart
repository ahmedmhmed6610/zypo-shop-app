// ignore_for_file: must_be_immutable

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/data/color_model.dart';
import 'package:shop/translations/locale_keys.g.dart';
import 'package:shop/ui/widgets/filter_widgets/choose_color_screen/choose_color_search_widget.dart';
import 'package:shop/utils/app_palette.dart';
import 'package:shop/utils/app_size_boxes.dart';
import 'package:shop/utils/dimensions.dart';
import 'package:shop/utils/styles.dart';

import '../../../../business_logic/my_products_cubit/my_products_cubit.dart';
import '../../../../business_logic/my_products_cubit/my_products_state.dart';
import '../../filter_screens/widget_custom.dart';
import '../add_product_screen.dart';
import '../change_product_screen2.dart';

class ChooseColorAddProductScreen extends StatefulWidget {
  ChooseColorAddProductScreen(
      {Key? key, this.governmentId, this.governmentName, this.cityId, this.cityName,this.whatsAppNumber,
        this.fuelTypeAr,this.bodyTypeAr,this.engineCapacityTypeAr,this.amenitiesTypeAr,this.colorTypeAr,
        this.areaId, this.areaName, this.locationUser, this.nameProduct, this.fromPrice, this.toPrice, this.description,
        this.fuelType,this.bodyType,this.amenitiesType,this.colorType,this.engineCapacityType,this.kiloMetresType,
        this.levelType,this.year,this.typeCondtion,this.typeApartment,this.statusApartment,this.typeTransmission,this.bedroom,this.bathroom,this.downPayment,this.area,this.data,this.productId})
      : super(key: key);

  String? governmentId, governmentName,typeApartment;
  String? data,productId,typeCondtion,typeTransmission;
  String? cityId,cityName,bedroom,bathroom,statusApartment;
  String? areaId, areaName,year,area,downPayment,whatsAppNumber;
  String? locationUser,fuelTypeAr,fuelType,amenitiesTypeAr,amenitiesType,
      bodyTypeAr,bodyType,colorTypeAr,colorType,engineCapacityTypeAr,engineCapacityType,kiloMetresType,levelType;
  String? fromPrice, toPrice, nameProduct, description;

  @override
  State<ChooseColorAddProductScreen> createState() => _ChooseColorAddProductScreenState();
}

class _ChooseColorAddProductScreenState extends State<ChooseColorAddProductScreen> {

  ColorModel? selectedColor;
  List<ColorModel> dummyColors = [
    ColorModel(id: 1, color: LocaleKeys.green.tr()),
    ColorModel(id: 2, color: LocaleKeys.red.tr()),
    ColorModel(id: 2, color: LocaleKeys.brown.tr()),
    ColorModel(id: 3, color: LocaleKeys.blue.tr()),
    ColorModel(id: 4, color: LocaleKeys.yellow.tr()),
    ColorModel(id: 5, color: LocaleKeys.white.tr()),
    ColorModel(id: 6, color: LocaleKeys.cohly.tr()),
    ColorModel(id: 7, color: LocaleKeys.nebety.tr()),
    ColorModel(id: 8, color: LocaleKeys.gary.tr()),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   // CustomFlutterToast(widget.kiloMetresType);
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
                bathroom: widget.bathroom,
                area: widget.area,
                locationUser: widget.locationUser,
                whatsAppNumber: widget.whatsAppNumber,
                downPayment: widget.downPayment,
                year: widget.year,
                typeCondtion: widget.typeCondtion,
                statusApartment: widget.statusApartment,
                transmissionVehicles: widget.typeTransmission,
                description: widget.description,
                cityId: widget.cityId,
                cityName: widget.cityName,
                typeApartment: widget.typeApartment,
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
                area: widget.area,
                locationUser: widget.locationUser,
                downPayment: widget.downPayment,
                year: widget.year,
                description: widget.description,
                cityId: widget.cityId,
                whatsAppNumber: widget.whatsAppNumber,
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
        title: LocaleKeys.color.tr(),
        widgetCustom:  BlocBuilder<AddProductCubit, AddProductState>(
          builder: (context, state) {
            return Container(
              padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    LocaleKeys.chooseColor.tr(),
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
                          itemCount: dummyColors.length,
                          padding: EdgeInsets.zero,
                          itemBuilder: (context, index) => InkWell(
                            onTap: (){
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
                                    whatsAppNumber: widget.whatsAppNumber,
                                    bedroom: widget.bedroom,
                                    bathroom: widget.bathroom,
                                    area: widget.area,
                                    downPayment: widget.downPayment,
                                    year: widget.year,
                                    locationUser: widget.locationUser,
                                    typeCondtion: widget.typeCondtion,
                                    statusApartment: widget.statusApartment,
                                    transmissionVehicles: widget.typeTransmission,
                                    typeApartment: widget.typeApartment,
                                    description: widget.description,
                                    cityId: widget.cityId,
                                    cityName: widget.cityName,
                                    areaId: widget.areaId,
                                    amenitiesType: widget.amenitiesType,
                                    bodyType: widget.bodyType,
                                    colorType: dummyColors[index].color,
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
                                    area: widget.area,
                                    locationUser: widget.locationUser,
                                    whatsAppNumber: widget.whatsAppNumber,
                                    downPayment: widget.downPayment,
                                    year: widget.year,
                                    description: widget.description,
                                    cityId: widget.cityId,
                                    cityName: widget.cityName,
                                    areaId: widget.areaId,
                                    amenitiesType: widget.amenitiesType,
                                    bodyType: widget.bodyType,
                                    colorType: dummyColors[index].color,
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
                                  //     value: dummyColors[index],
                                  //     groupValue: selectedColor,
                                  //     activeColor: AppPalette.primary,
                                  //     onChanged: (ColorModel? colorModel) =>
                                  //         filterCubit.selectColorModel(
                                  //              colorModel: colorModel!),
                                  //     visualDensity: const VisualDensity(
                                  //       horizontal:
                                  //       VisualDensity.minimumDensity,
                                  //     ),
                                  //     materialTapTargetSize:
                                  //     MaterialTapTargetSize
                                  //         .shrinkWrap),
                                  // Checkbox(
                                  //     value: filterCubit.isColorSelected(
                                  //         color: filterCubit.addProductCubitColors[index]),
                                  //     // groupValue: filterCubit.selectedBrandModel,
                                  //     activeColor: AppPalette.primary,
                                  //     onChanged: (val) =>
                                  //         filterCubit.selectColorToFilter(
                                  //             color:
                                  //             filterCubit.addProductCubitColors[index]),
                                  //     visualDensity: const VisualDensity(
                                  //       horizontal: VisualDensity.minimumDensity,
                                  //     ),
                                  //     materialTapTargetSize:
                                  //     MaterialTapTargetSize.shrinkWrap),
                                  12.widthBox,
                                  Text(
                                    dummyColors[index].color,
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
