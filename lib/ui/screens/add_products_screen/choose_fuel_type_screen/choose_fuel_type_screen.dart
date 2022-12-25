// ignore_for_file: must_be_immutable

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/business_logic/my_products_cubit/my_products_state.dart';
import 'package:shop/translations/locale_keys.g.dart';
import 'package:shop/ui/screens/add_products_screen/add_product_screen.dart';
import 'package:shop/ui/screens/add_products_screen/change_product_screen2.dart';
import 'package:shop/ui/widgets/filter_widgets/choose_color_screen/choose_color_search_widget.dart';
import 'package:shop/utils/app_palette.dart';
import 'package:shop/utils/app_size_boxes.dart';
import 'package:shop/utils/dimensions.dart';
import 'package:shop/utils/styles.dart';

import '../../../../business_logic/my_products_cubit/my_products_cubit.dart';
import '../../../../data/color_model.dart';
import '../../filter_screens/widget_custom.dart';

class ChooseFuelTypeAddProductScreen extends StatefulWidget {
  ChooseFuelTypeAddProductScreen(
      {Key? key, this.governmentId, this.governmentName, this.cityId, this.cityName,this.whatsAppNumber,
        this.areaId, this.areaName, this.locationUser, this.nameProduct, this.fromPrice, this.toPrice, this.description,
        this.fuelType,this.bodyType,this.amenitiesType,this.colorType,this.engineCapacityType,this.kiloMetresType,
        this.fuelTypeAr,this.bodyTypeAr,this.engineCapacityTypeAr,this.amenitiesTypeAr,this.colorTypeAr,
        this.levelType,this.year,this.statusApartment,this.typeCondtion,this.typeTransmission,this.bedroom,this.bathroom,this.data,this.productId,this.downPayment,this.area})
      : super(key: key);

  String? governmentId, governmentName,data,productId,whatsAppNumber;
  String? cityId, cityName,bedroom,bathroom,typeCondtion,typeTransmission;
  String? areaId, areaName,year,area,downPayment,statusApartment;
  String? locationUser,fuelTypeAr,fuelType,amenitiesTypeAr,amenitiesType,
      bodyTypeAr,bodyType,colorTypeAr,colorType,engineCapacityTypeAr,engineCapacityType,kiloMetresType,levelType;
  String? fromPrice, toPrice, nameProduct, description;

  @override
  State<ChooseFuelTypeAddProductScreen> createState() => _ChooseFuelTypeAddProductScreenState();
}

class _ChooseFuelTypeAddProductScreenState extends State<ChooseFuelTypeAddProductScreen> {


  List<ColorModel> dummyFuelType = [
    ColorModel(id: 1, color: LocaleKeys.benzine.tr()),
    ColorModel(id: 2, color: LocaleKeys.diesel.tr()),
    ColorModel(id: 3, color: LocaleKeys.electricity.tr()),
    ColorModel(id: 4, color: LocaleKeys.hypride.tr()),
    ColorModel(id: 5, color: LocaleKeys.naturalGas.tr()),
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
                whatsAppNumber: widget.whatsAppNumber,
                bathroom: widget.bathroom,
                area: widget.area,
                locationUser: widget.locationUser,
                typeCondtion: widget.typeCondtion,
                transmissionVehicles: widget.typeTransmission,
                statusApartment: widget.statusApartment,
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
                downPayment: widget.downPayment,
                year: widget.year,
                locationUser: widget.locationUser,
                description: widget.description,
                whatsAppNumber: widget.whatsAppNumber,
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
        title: LocaleKeys.fuelType.tr(),
        widgetCustom: BlocBuilder<AddProductCubit, AddProductState>(
          builder: (context, state) {
            return Container(
              padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    LocaleKeys.fuelType.tr(),
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
                          itemCount: dummyFuelType.length,
                          padding: EdgeInsets.zero,
                          itemBuilder: (context, index) => InkWell(
                            onTap: (){
                              // filterCubit.selectFuelTypeModel(
                              //     colorModel: filterCubit.addProductCubitFuelType[index]);
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
                                    transmissionVehicles: widget.typeTransmission,
                                    statusApartment: widget.statusApartment,
                                    description: widget.description,
                                    cityId: widget.cityId,
                                    cityName: widget.cityName,
                                    areaId: widget.areaId,
                                    amenitiesType: widget.amenitiesType,
                                    bodyType: widget.bodyType,
                                    colorType: widget.colorType,
                                    engineCapacityType: widget.engineCapacityType,
                                    fuelType: dummyFuelType[index].color,
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
                                    fuelType: dummyFuelType[index].color,
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
                                  //     value: filterCubit.addProductCubitFuelType[index],
                                  //     groupValue: filterCubit.selectedFuelType,
                                  //     activeColor: AppPalette.primary,
                                  //     onChanged: (value){
                                  //       setState(() {
                                  //
                                  //       });
                                  //     },
                                  //     visualDensity: const VisualDensity(
                                  //       horizontal:
                                  //       VisualDensity.minimumDensity,
                                  //     ),
                                  //     materialTapTargetSize:
                                  //     MaterialTapTargetSize
                                  //         .shrinkWrap),
                                  12.widthBox,
                                  Text(
                                    dummyFuelType[index].color,
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
