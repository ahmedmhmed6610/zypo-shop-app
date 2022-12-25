// ignore_for_file: must_be_immutable

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop/business_logic/filter_cubit/filter_cubit.dart';
import 'package:shop/translations/locale_keys.g.dart';
import 'package:shop/ui/base/custom_button.dart';
import 'package:shop/ui/screens/filter_screens/filter_screen.dart';
import 'package:shop/ui/widgets/filter_widgets/choose_color_screen/choose_color_search_widget.dart';
import 'package:shop/utils/app_palette.dart';
import 'package:shop/utils/app_size_boxes.dart';
import 'package:shop/utils/dimensions.dart';
import 'package:shop/utils/styles.dart';

import '../../../../data/color_model.dart';
import '../../../../data/color_model2.dart';

class ChooseBodyTypeScreen extends StatefulWidget {
  ChooseBodyTypeScreen(
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
  State<ChooseBodyTypeScreen> createState() => _ChooseBodyTypeScreenState();
}

class _ChooseBodyTypeScreenState extends State<ChooseBodyTypeScreen> {

  ColorModel2? selectedBodyType;
  bool? isSelected = false;
  List<ColorModel> dummyBodyType = [
    ColorModel(id: 1, color: LocaleKeys.all.tr()),
    ColorModel(id: 2, color: "4*4"),
    ColorModel(id: 3, color: LocaleKeys.cabriolet.tr()),
    ColorModel(id: 4, color: LocaleKeys.coupe.tr()),
    ColorModel(id: 5, color: LocaleKeys.hatchback.tr()),
    ColorModel(id: 6, color: LocaleKeys.pickup.tr()),
    ColorModel(id: 7, color: LocaleKeys.suv.tr()),
    ColorModel(id: 8, color: LocaleKeys.sedan.tr()),
    ColorModel(id: 9, color: LocaleKeys.vanBus.tr()),
    ColorModel(id: 10, color: LocaleKeys.other.tr()),
  ];



  String? bodyTypeString ='';
  String? bodyTypeListOfString ='';
  String? bodyTypeListOfString2 ='';
  List<String>? bodyTypeList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.bodyType.tr()),
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
              locationUser: widget.locationUser,
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
              areaName: widget.areaName))),
          child: const Icon(Icons.arrow_back_ios,
              size: 20.0, color: AppPalette.black),
        ),
      ),
      body: BlocBuilder<FilterCubit, FilterState>(
        builder: (context, state) {
          return Container(
            padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  LocaleKeys.bodyType.tr(),
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
                        itemCount:
                        dummyBodyType.length,
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index) => InkWell(
                          onTap: () {
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
                                bodyType: dummyBodyType[index].color,
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
                                //     value: addProductCubit.addProductCubitBodyType[index],
                                //     groupValue: addProductCubit.selectedBodyType,
                                //     activeColor: AppPalette.primary,
                                //     onChanged: (ColorModel? colorModel) =>
                                //         addProductCubit.selectBodyTypeModel(
                                //             colorModel: colorModel!),
                                //     visualDensity: const VisualDensity(
                                //       horizontal: VisualDensity.minimumDensity,
                                //     ),
                                //     materialTapTargetSize:
                                //         MaterialTapTargetSize.shrinkWrap),
                                12.widthBox,
                                Text(
                                  dummyBodyType[index].color,
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
                CustomButton(
                  buttonText: LocaleKeys.apply.tr(),
                  onPressed: (){
                    // print('bodyTypeListOfString22');
                    // print(bodyTypeListOfString);
                    // print('bodyTypeListOfString');
                  },
                  height: 48.h,
                  fontSize: Dimensions.fontSizeLarge,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
