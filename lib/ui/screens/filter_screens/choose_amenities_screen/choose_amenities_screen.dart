import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop/business_logic/my_products_cubit/my_products_cubit.dart';
import 'package:shop/business_logic/my_products_cubit/my_products_state.dart';
import 'package:shop/translations/locale_keys.g.dart';
import 'package:shop/ui/screens/filter_screens/filter_screen.dart';
import 'package:shop/ui/widgets/filter_widgets/choose_color_screen/choose_color_search_widget.dart';
import 'package:shop/utils/app_palette.dart';
import 'package:shop/utils/app_size_boxes.dart';
import 'package:shop/utils/dimensions.dart';
import 'package:shop/utils/styles.dart';

import '../../../../data/color_model.dart';

// ignore: must_be_immutable
class ChooseAmenitiesScreen extends StatefulWidget {

  ChooseAmenitiesScreen(
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
  State<ChooseAmenitiesScreen> createState() => _ChooseAmenitiesScreenState();
}

class _ChooseAmenitiesScreenState extends State<ChooseAmenitiesScreen> {

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
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(LocaleKeys.filter.tr()),
      //   elevation: 0.0,
      //   leading: InkWell(
      //     onTap: () =>  Navigator.push(context, MaterialPageRoute
      //       (builder: (context) => FilterScreen(
      //         governmentId: widget
      //             .governmentId,
      //         governmentName: widget
      //             .governmentName,
      //         fromPrice: widget.fromPrice,
      //         toPrice: widget.toPrice,
      //         cityId: widget.cityId,
      //         fromYear: widget.fromYear,
      //         toYear: widget.toYear,
      //         bathroom: widget.bathroom,
      //         bedroom: widget.bedroom,
      //         fromArea: widget.fromArea,
      //         toArea: widget.toArea,
      //         locationUser: widget.locationUser,
      //         fromDownPayment: widget.fromDownPayment,
      //         toDownPayment: widget.toDownPayment,
      //         fromkiloMetresType: widget.fromkiloMetresType,
      //         tokiloMetresType: widget.tokiloMetresType,
      //         cityName: widget.cityName,
      //         areaId: widget.areaId,
      //         amenitiesType: widget.amenitiesType,
      //         bodyType: widget.bodyType,
      //         colorType: widget.colorType,
      //         engineCapacityType: widget.engineCapacityType,
      //         fuelType: widget.fuelType,
      //         kiloMetresType: widget.kiloMetresType,
      //         levelType: widget.levelType,
      //         areaName: widget.areaName))),
      //     child: const Icon(Icons.arrow_back_ios,
      //         size: 20.0, color: AppPalette.black),
      //   ),
      // ),
      backgroundColor: AppPalette.primary,
      body: SafeArea(
        child: Column(
          children: [
            22.heightBox,
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 15.h),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute
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
                          areaName: widget.areaName)));
                    },
                    child: Icon(Icons.arrow_back_ios,color: AppPalette.white,size: 25.sp,),
                  ),
                  Expanded(
                    child: Center(
                      child: AutoSizeText(
                        LocaleKeys.filter.tr(),
                        style: Theme.of(context).textTheme.headline2!.copyWith(
                            color: AppPalette.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 15.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            22.heightBox,
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                    color: AppPalette.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25))),
                child: BlocBuilder<AddProductCubit, AddProductState>(
                  builder: (context, state) {
                    return Container(
                      padding: EdgeInsets.only(
                        top: Dimensions.paddingSizeDefault,
                        right: Dimensions.paddingSizeDefault,
                        left: Dimensions.paddingSizeDefault,
                      ),
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
                                      Navigator.push(context, MaterialPageRoute
                                        (builder: (context) => FilterScreen(
                                          governmentId: widget
                                              .governmentId,
                                          governmentName: widget
                                              .governmentName,
                                          fromPrice: widget.fromPrice,
                                          toPrice: widget.toPrice,
                                          cityId: widget.cityId,
                                          fromYear: widget.fromYear,
                                          locationUser: widget.locationUser,
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
                                          amenitiesType: dummyAmenities[index].color,
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
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
