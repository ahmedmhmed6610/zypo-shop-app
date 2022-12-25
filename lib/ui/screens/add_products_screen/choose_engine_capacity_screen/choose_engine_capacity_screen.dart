// ignore_for_file: must_be_immutable

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/business_logic/my_products_cubit/my_products_cubit.dart';
import 'package:shop/business_logic/my_products_cubit/my_products_state.dart';
import 'package:shop/translations/locale_keys.g.dart';
import 'package:shop/ui/screens/add_products_screen/add_product_screen.dart';
import 'package:shop/ui/widgets/filter_widgets/choose_color_screen/choose_color_search_widget.dart';
import 'package:shop/utils/app_palette.dart';
import 'package:shop/utils/app_size_boxes.dart';
import 'package:shop/utils/dimensions.dart';
import 'package:shop/utils/styles.dart';

import '../../../../data/color_model.dart';
import '../../filter_screens/widget_custom.dart';
import '../change_product_screen2.dart';

class ChooseEngineCapacityAddProductScreen extends StatefulWidget {
  ChooseEngineCapacityAddProductScreen(
      {Key? key, this.governmentId, this.governmentName, this.cityId, this.cityName,this.whatsAppNumber,
        this.fuelTypeAr,this.bodyTypeAr,this.engineCapacityTypeAr,this.amenitiesTypeAr,this.colorTypeAr,
        this.areaId, this.areaName, this.locationUser, this.nameProduct, this.fromPrice, this.toPrice, this.description,
        this.fuelType,this.bodyType,this.amenitiesType,this.colorType,this.engineCapacityType,this.kiloMetresType,
        this.levelType,this.year,this.typeCondtion,this.typeApartment,this.statusApartment,this.typeTransmission,this.bedroom,this.bathroom,this.downPayment,this.area,this.data,this.productId})
      : super(key: key);





  String? governmentId, governmentName,typeApartment;
  String? data,productId,typeCondtion,typeTransmission,whatsAppNumber;
  String? cityId,cityName,bedroom,bathroom,statusApartment;
  String? areaId, areaName,year,area,downPayment;
  String? locationUser,fuelTypeAr,fuelType,amenitiesTypeAr,amenitiesType,
      bodyTypeAr,bodyType,colorTypeAr,colorType,engineCapacityTypeAr,engineCapacityType,kiloMetresType,levelType;
  String? fromPrice, toPrice, nameProduct, description;

  @override
  State<ChooseEngineCapacityAddProductScreen> createState() => _ChooseEngineCapacityAddProductScreenState();
}

class _ChooseEngineCapacityAddProductScreenState extends State<ChooseEngineCapacityAddProductScreen> {

  ColorModel? selectedEngineCapacity;

  List<ColorModel> dummyEngineCapacity = [
    ColorModel(id: 1, color: "0 - 800"),
    ColorModel(id: 2, color: "1000 - 1300"),
    ColorModel(id: 3, color: "1400 - 1500"),
    ColorModel(id: 4, color: "1600"),
    ColorModel(id: 5, color: "1800 - 2000"),
    ColorModel(id: 6, color: "2200 - 2800"),
    ColorModel(id: 7, color: "30000 - 35000"),
    ColorModel(id: 8, color: "+35000"),

  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
                whatsAppNumber: widget.whatsAppNumber,
                area: widget.area,
                downPayment: widget.downPayment,
                year: widget.year,
                typeCondtion: widget.typeCondtion,
                statusApartment: widget.statusApartment,
                transmissionVehicles: widget.typeTransmission,
                description: widget.description,
                cityId: widget.cityId,
                cityName: widget.cityName,
                locationUser: widget.locationUser,
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
        title: LocaleKeys.engineCapacity.tr(),
        widgetCustom:  BlocBuilder<AddProductCubit, AddProductState>(
          builder: (context, state) {
            return Container(
              padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    LocaleKeys.engineCapacity.tr(),
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
                          itemCount: dummyEngineCapacity.length,
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
                                    locationUser: widget.locationUser,
                                    downPayment: widget.downPayment,
                                    year: widget.year,
                                    whatsAppNumber: widget.whatsAppNumber,
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
                                    engineCapacityType: dummyEngineCapacity[index].color,
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
                                    whatsAppNumber: widget.whatsAppNumber,
                                    description: widget.description,
                                    cityId: widget.cityId,
                                    cityName: widget.cityName,
                                    areaId: widget.areaId,
                                    amenitiesType: widget.amenitiesType,
                                    bodyType: widget.bodyType,
                                    colorType: widget.colorType,
                                    engineCapacityType: dummyEngineCapacity[index].color,
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
                                  //     value: dummyEngineCapacity[index],
                                  //     groupValue: selectedEngineCapacity,
                                  //     activeColor: AppPalette.primary,
                                  //     onChanged: (ColorModel? colorModel) =>
                                  //         filterCubit.selectEngineCapacityModel(
                                  //             colorModel: colorModel!),
                                  //     visualDensity: const VisualDensity(
                                  //       horizontal: VisualDensity.minimumDensity,
                                  //     ),
                                  //     materialTapTargetSize:
                                  //     MaterialTapTargetSize.shrinkWrap),
                                  12.widthBox,
                                  Text(
                                    dummyEngineCapacity[index].color,
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
