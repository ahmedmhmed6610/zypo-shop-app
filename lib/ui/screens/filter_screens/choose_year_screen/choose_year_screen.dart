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

class ChooseYearScreen extends StatefulWidget {
  ChooseYearScreen(
      {Key? key, this.governmentId, this.governmentName, this.cityId, this.cityName,
        this.areaId, this.areaName, this.locationUser, this.fromPrice, this.toPrice,
        this.fromArea,this.toArea,this.bedroom,this.bathroom,this.intentData,
        this.fromkiloMetresType,this.tokiloMetresType,this.fromDownPayment,this.toDownPayment,
        this.fuelType, this.bodyType, this.amenitiesType, this.colorType, this.engineCapacityType, this.kiloMetresType,
        this.levelType,this.fromYear,this.intentYear,this.toYear}) : super(key: key);

  String? governmentId, governmentName;
  String? cityId, cityName,intentYear;
  String? areaId, areaName;
  String? locationUser,intentData;
  String? brandId,fromDownPayment,toDownPayment;
  String? status,fromYear,toYear,bedroom,bathroom;
  String? fromPrice, toPrice,fromArea,toArea;
  String? kiloMetresType,fuelType, amenitiesType, bodyType, colorType, engineCapacityType,
      fromkiloMetresType,tokiloMetresType, levelType;


  @override
  State<ChooseYearScreen> createState() => _ChooseYearScreenState();
}

class _ChooseYearScreenState extends State<ChooseYearScreen> {


  List<ColorModel> dummyYear = [
    ColorModel(id: 1, color: "1987"),
    ColorModel(id: 2, color: "1988"),
    ColorModel(id: 3, color: "1989"),
    ColorModel(id: 4, color: "1990"),
    ColorModel(id: 5, color: "1991"),
    ColorModel(id: 6, color: "1992"),
    ColorModel(id: 7, color: "1993"),
    ColorModel(id: 8, color: "1994"),
    ColorModel(id: 9, color: "1995"),
    ColorModel(id: 10, color: "1996"),
    ColorModel(id: 11, color: "1997"),
    ColorModel(id: 12, color: "1998"),
    ColorModel(id: 12, color: "1999"),
    ColorModel(id: 12, color: "2000"),
    ColorModel(id: 12, color: "2001"),
    ColorModel(id: 12, color: "2002"),
    ColorModel(id: 12, color: "2003"),
    ColorModel(id: 12, color: "2004"),
    ColorModel(id: 12, color: "2005"),
    ColorModel(id: 12, color: "2006"),
    ColorModel(id: 12, color: "2007"),
    ColorModel(id: 12, color: "2008"),
    ColorModel(id: 12, color: "2009"),
    ColorModel(id: 12, color: "2010"),
    ColorModel(id: 12, color: "2011"),
    ColorModel(id: 12, color: "2012"),
    ColorModel(id: 12, color: "2013"),
    ColorModel(id: 12, color: "2014"),
    ColorModel(id: 12, color: "2015"),
    ColorModel(id: 12, color: "2016"),
    ColorModel(id: 12, color: "2017"),
    ColorModel(id: 12, color: "2018"),
    ColorModel(id: 12, color: "2019"),
    ColorModel(id: 12, color: "2020"),
    ColorModel(id: 12, color: "2021"),
    ColorModel(id: 12, color: "2022"),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // print('initentData');
    // print(widget.intentYear);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: AppPalette.primary,
      //   title: Text(LocaleKeys.filter.tr(),style: TextStyle(color: AppPalette.white),),
      //   elevation: 0.0,
      //   leading: InkWell(
      //     onTap: () {
      //       Navigator.push(context, MaterialPageRoute
      //         (builder: (context) => FilterScreen(
      //           governmentId: widget
      //               .governmentId,
      //           governmentName: widget
      //               .governmentName,
      //           fromPrice: widget.fromPrice,
      //           toPrice: widget.toPrice,
      //           cityId: widget.cityId,
      //           fromYear: widget.fromYear,
      //           toYear: widget.toYear,
      //           bathroom: widget.bathroom,
      //           bedroom: widget.bedroom,
      //           fromArea: widget.fromArea,
      //           toArea: widget.toArea,
      //           fromDownPayment: widget.fromDownPayment,
      //           toDownPayment: widget.toDownPayment,
      //           fromkiloMetresType: widget.fromkiloMetresType,
      //           tokiloMetresType: widget.tokiloMetresType,
      //           cityName: widget.cityName,
      //           areaId: widget.areaId,
      //           amenitiesType: widget.amenitiesType,
      //           bodyType: widget.bodyType,
      //           colorType: widget.colorType,
      //           engineCapacityType: widget.engineCapacityType,
      //           fuelType: widget.fuelType,
      //           kiloMetresType: widget.kiloMetresType,
      //           levelType: widget.levelType,
      //           areaName: widget.areaName)));
      //
      //     },
      //     child: const Icon(Icons.arrow_back_ios,
      //         size: 20.0, color: AppPalette.white),
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
                            LocaleKeys.year.tr(),
                            style: AppTextStyles.poppinsMedium
                                .copyWith(color: AppPalette.black),
                          ),
                          10.heightBox,
                          ChooseColorSearchWidget(),
                          5.heightBox,
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: GestureDetector(
                              onTap: (){
                                Navigator.of(context).pushReplacement(MaterialPageRoute(
                                    builder: (context) => FilterScreen(
                                      governmentId: widget.governmentId,
                                      governmentName: widget.governmentName,
                                      fromPrice: widget.fromPrice,toPrice: widget.toPrice,
                                      levelType: widget.levelType,
                                      fromYear: widget.fromYear,
                                      toYear: widget.toYear,
                                      bathroom: widget.bathroom,
                                      bedroom: widget.bedroom,
                                      fromArea: widget.fromArea,
                                      toArea: widget.toArea,
                                      fromDownPayment: widget.fromDownPayment,
                                      toDownPayment: widget.toDownPayment,
                                      fromkiloMetresType: widget.fromkiloMetresType,
                                      tokiloMetresType: null,
                                      kiloMetresType: widget.kiloMetresType,
                                      amenitiesType: widget.amenitiesType,
                                      fuelType: widget.fuelType,
                                      engineCapacityType: widget.engineCapacityType,
                                      colorType: widget.colorType,
                                      bodyType: widget.bodyType,
                                      locationUser: widget.locationUser,areaId: null,areaName: null,
                                      cityId: widget.cityId,cityName: widget.cityName,)));
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    child: Center(
                                      child: Text(LocaleKeys.delete.tr(),
                                        style: AppTextStyles.poppinsRegular
                                            .copyWith(color: AppPalette.white),),
                                    ),
                                    width: 100,
                                    height: 35,
                                    decoration: BoxDecoration(
                                      color: AppPalette.primary,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: ListView(
                              children: [
                                7.heightBox,
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const ScrollPhysics(),
                                  itemCount: dummyYear.length,
                                  padding: EdgeInsets.zero,
                                  itemBuilder: (context, index) => InkWell(
                                    onTap: () {
                                      if(widget.intentYear!.contains('fromYear')){
                                        Navigator.push(context, MaterialPageRoute
                                          (builder: (context) => FilterScreen(
                                            governmentId: widget
                                                .governmentId,
                                            governmentName: widget
                                                .governmentName,
                                            fromPrice: widget.fromPrice,
                                            toPrice: widget.toPrice,
                                            cityId: widget.cityId,
                                            fromYear: dummyYear[index].color,
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
                                      }if(widget.intentYear!.contains('toYear')){
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
                                            toYear: dummyYear[index].color,
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
                                      } else {}
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
                                            dummyYear[index].color,
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
