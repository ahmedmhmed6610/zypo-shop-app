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
import '../change_product_screen2.dart';

class ChooseHomeFurnitureProductScreen extends StatefulWidget {

  ChooseHomeFurnitureProductScreen(
      {Key? key, this.governmentId, this.governmentName, this.cityId, this.cityName,this.whatsAppNumber,
        this.fuelTypeAr,this.bodyTypeAr,this.engineCapacityTypeAr,this.amenitiesTypeAr,this.colorTypeAr,
        this.areaId, this.areaName, this.locationUser, this.nameProduct, this.fromPrice, this.toPrice, this.description,
        this.fuelType,this.bodyType,this.amenitiesType,this.colorType,this.engineCapacityType,this.kiloMetresType,
        this.levelType,this.year,this.typeCondtion,this.typeHomeFurniture,this.bedroom,this.bathroom,this.downPayment,this.area,this.data,this.productId})
      : super(key: key);

  String? governmentId, governmentName,whatsAppNumber;
  String? cityId, cityName,bedroom,bathroom,year,area,downPayment;
  String? areaId, areaName,typeHomeFurniture;
  String? data,productId,typeCondtion;
  String? locationUser,fuelTypeAr,fuelType,amenitiesTypeAr,amenitiesType,
      bodyTypeAr,bodyType,colorTypeAr,colorType,engineCapacityTypeAr,engineCapacityType,kiloMetresType,levelType;
  String? fromPrice, toPrice, nameProduct, description;

  @override
  State<ChooseHomeFurnitureProductScreen> createState() => _ChooseHomeFurnitureProductScreenState();
}

class _ChooseHomeFurnitureProductScreenState extends State<ChooseHomeFurnitureProductScreen> {


  List<ColorModel> dummyHomeFurniture = [
    ColorModel(id: 1, color: LocaleKeys.fullBathroom.tr()),
    ColorModel(id: 2, color: LocaleKeys.sink.tr()),
    ColorModel(id: 3, color: LocaleKeys.towels.tr()),
    ColorModel(id: 4, color: LocaleKeys.showerRoomTub.tr()),
    ColorModel(id: 4, color: LocaleKeys.toilet.tr()),
    ColorModel(id: 4, color: LocaleKeys.waterMixersShowerHeads.tr()),
    ColorModel(id: 4, color: LocaleKeys.mirrorsShelvesOtherAccessories.tr()),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppPalette.primary,
        title: Text(LocaleKeys.apartment.tr(),style: TextStyle(color: AppPalette.white),),
        elevation: 0.0,
        leading: InkWell(
          onTap: () {
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
          },

          child: const Icon(Icons.arrow_back_ios,
              size: 20.0, color: AppPalette.white),
        ),
      ),
      body: BlocBuilder<AddProductCubit, AddProductState>(
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
                        itemCount: dummyHomeFurniture.length,
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index) => InkWell(
                          onTap: () {
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
                                locationUser: widget.locationUser,
                                area: widget.area,
                                typeCondtion: widget.typeCondtion,
                                downPayment: widget.downPayment,
                                whatsAppNumber: widget.whatsAppNumber,
                                year: widget.year,
                                description: widget.description,
                                cityId: widget.cityId,
                                cityName: widget.cityName,
                                areaId: widget.areaId,
                                typeHomeFurniture: dummyHomeFurniture[index].color,
                                amenitiesType: widget.amenitiesType,
                                bodyType: widget.bodyType,
                                colorType: widget.colorType,
                                engineCapacityType: widget.engineCapacityType,
                                fuelType: widget.fuelType,
                                kiloMetresType: widget.kiloMetresType,
                                levelType: widget.levelType,
                                areaName: widget.areaName)));
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
                                  dummyHomeFurniture[index].color,
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
      ),
    );
  }
}
