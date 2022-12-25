import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/business_logic/my_products_cubit/my_products_state.dart';
import 'package:shop/translations/locale_keys.g.dart';
import 'package:shop/ui/screens/filter_screens/filter_screen.dart';
import 'package:shop/ui/widgets/filter_widgets/choose_color_screen/choose_color_search_widget.dart';
import 'package:shop/utils/app_palette.dart';
import 'package:shop/utils/app_size_boxes.dart';
import 'package:shop/utils/dimensions.dart';
import 'package:shop/utils/styles.dart';

import '../../../../business_logic/my_products_cubit/my_products_cubit.dart';
import '../../../../data/color_model.dart';

class ChooseFuelTypeScreen extends StatefulWidget {
  ChooseFuelTypeScreen(
      {Key? key, this.governmentId, this.governmentName, this.cityId, this.cityName,
        this.areaId, this.areaName, this.locationUser, this.fromPrice, this.toPrice,
        this.fromArea,this.toArea,this.bedroom,this.bathroom,
        this.fromkiloMetresType,this.tokiloMetresType,this.fromDownPayment,this.toDownPayment,
        this.fuelType, this.bodyType, this.amenitiesType, this.colorType, this.engineCapacityType, this.kiloMetresType,
        this.levelType,this.fromYear,this.toYear}) : super(key: key);

  String? governmentId, governmentName;
  String? cityId, cityName;
  String? areaId, areaName;
  String? locationUser;
  String? brandId,fromDownPayment,toDownPayment;
  String? status,fromYear,toYear,bedroom,bathroom;
  String? fromPrice, toPrice,fromArea,toArea;
  String? kiloMetresType,fuelType, amenitiesType, bodyType, colorType, engineCapacityType,
      fromkiloMetresType,tokiloMetresType, levelType;

  @override
  State<ChooseFuelTypeScreen> createState() => _ChooseFuelTypeScreenState();
}

class _ChooseFuelTypeScreenState extends State<ChooseFuelTypeScreen> {

  List<ColorModel> dummyFuelType = [
    ColorModel(id: 1, color: LocaleKeys.benzine.tr()),
    ColorModel(id: 2, color: LocaleKeys.diesel.tr()),
    ColorModel(id: 3, color: LocaleKeys.electricity.tr()),
    ColorModel(id: 4, color: LocaleKeys.hypride.tr()),
    ColorModel(id: 5, color: LocaleKeys.naturalGas.tr()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.filter.tr()),
        elevation: 0.0,
        leading: InkWell(
          onTap: () =>  Navigator.push(context, MaterialPageRoute
            (builder: (context) => FilterScreen(
              governmentId: widget
                  .governmentId,
              governmentName: widget
                  .governmentName,
              fromPrice: widget.fromPrice,
              toPrice: widget.toPrice,
              cityId: widget.cityId,
              fromYear: widget.fromYear,
              toYear: widget.toYear,
              bathroom: widget.bathroom,
              bedroom: widget.bedroom,
              fromArea: widget.fromArea,
              toArea: widget.toArea,
              locationUser: widget.locationUser,
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
              areaName: widget.areaName))),
          child: const Icon(Icons.arrow_back_ios,
              size: 20.0, color: AppPalette.black),
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
                            Navigator.push(context, MaterialPageRoute
                              (builder: (context) => FilterScreen(
                                governmentId: widget.governmentId,
                                governmentName: widget.governmentName,
                                fromPrice: widget.fromPrice,
                                toPrice: widget.toPrice,
                                cityId: widget.cityId,
                                fromYear: widget.fromYear,
                                toYear: widget.toYear,
                                bathroom: widget.bathroom,
                                bedroom: widget.bedroom,
                                fromArea: widget.fromArea,
                                toArea: widget.toArea,
                                locationUser: widget.locationUser,
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
                                fuelType: dummyFuelType[index].color,
                                kiloMetresType: widget.kiloMetresType,
                                levelType: widget.levelType,
                                areaName: widget.areaName)));
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
      ),
    );
  }
}
