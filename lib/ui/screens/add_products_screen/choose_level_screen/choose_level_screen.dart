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

class ChooseLevelAddProductScreen extends StatefulWidget {
  ChooseLevelAddProductScreen(
      {Key? key, this.governmentId, this.governmentName, this.cityId, this.cityName,this.whatsAppNumber,
        this.fuelTypeAr,this.bodyTypeAr,this.engineCapacityTypeAr,this.amenitiesTypeAr,this.colorTypeAr,
        this.areaId, this.areaName, this.locationUser, this.nameProduct, this.fromPrice, this.toPrice, this.description,
        this.fuelType,this.bodyType,this.amenitiesType,this.colorType,this.engineCapacityType,this.kiloMetresType,
        this.levelType,this.year,this.bedroom,this.bathroom,this.typeApartment,this.downPayment,this.data,this.area,
        this.statusApartment,this.productId,this.furnishedType})
      : super(key: key);


  String? governmentId, governmentName;
  String? cityId, cityName,bedroom,bathroom,year,area,downPayment,furnishedType;
  String? areaId, areaName,typeApartment,statusApartment;
  String? data,productId,whatsAppNumber;
  String? locationUser,fuelTypeAr,fuelType,amenitiesTypeAr,amenitiesType,
      bodyTypeAr,bodyType,colorTypeAr,colorType,engineCapacityTypeAr,engineCapacityType,kiloMetresType,levelType;
  String? fromPrice, toPrice, nameProduct, description;

  @override
  State<ChooseLevelAddProductScreen> createState() => _ChooseLevelAddProductScreenState();
}

class _ChooseLevelAddProductScreenState extends State<ChooseLevelAddProductScreen> {

  ColorModel? selectedLevel;

  List<ColorModel> dummyLevel = [
    ColorModel(id: 1, color: "0 "),
    ColorModel(id: 2, color: "1"),
    ColorModel(id: 3, color: "2"),
    ColorModel(id: 4, color: "3"),
    ColorModel(id: 5, color: "4"),
    ColorModel(id: 6, color: "5"),
    ColorModel(id: 7, color: "6"),
    ColorModel(id: 8, color: "7"),
    ColorModel(id: 9, color: "8"),
    ColorModel(id: 10, color: "9"),
    ColorModel(id: 11, color: "10"),
    ColorModel(id: 12, color: "+10"),
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
                furnishedType: widget.furnishedType,
                area: widget.area,
                locationUser: widget.locationUser,
                whatsAppNumber: widget.whatsAppNumber,
                typeApartment: widget.typeApartment,
                statusApartment: widget.typeApartment,
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
                whatsAppNumber: widget.whatsAppNumber,
                area: widget.area,
                locationUser: widget.locationUser,
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
        title: LocaleKeys.level.tr(),
        widgetCustom: BlocBuilder<AddProductCubit, AddProductState>(
          builder: (context, state) {
            return Container(
              padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    LocaleKeys.level.tr(),
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
                          itemCount: dummyLevel.length,
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
                                    whatsAppNumber: widget.whatsAppNumber,
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
                                    cityName: widget.cityName,
                                    areaId: widget.areaId,
                                    levelType: dummyLevel[index].color,
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
                                    colorType: widget.colorType,
                                    engineCapacityType: widget.engineCapacityType,
                                    fuelType: widget.fuelType,
                                    kiloMetresType: widget.kiloMetresType,
                                    levelType: dummyLevel[index].color,
                                    areaName: widget.areaName)));
                              }
                            },

                            child: Padding(
                              padding: const EdgeInsets.all(7.0),
                              child: Row(
                                children: [
                                  // Radio(
                                  //     value: filterCubit.addProductLevel[index],
                                  //     groupValue: filterCubit.selectedLevel,
                                  //     activeColor: AppPalette.primary,
                                  //     onChanged: (ColorModel? colorModel) =>
                                  //         filterCubit.selectLevelModel(
                                  //             colorModel: colorModel!),
                                  //     visualDensity: const VisualDensity(
                                  //       horizontal:
                                  //       VisualDensity.minimumDensity,
                                  //     ),
                                  //     materialTapTargetSize:
                                  //     MaterialTapTargetSize
                                  //         .shrinkWrap),
                                  12.widthBox,
                                  Text(
                                    dummyLevel[index].color,
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
        )),
    );
  }
}
