

// ignore_for_file: must_be_immutable

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_translator/google_translator.dart';
import 'package:shop/ui/screens/add_products_screen/add_product_screen.dart';
import 'package:shop/ui/screens/add_products_screen/choose_categories_screens/choose_government_product_screen.dart';
import 'package:shop/ui/screens/filter_screens/filter_screen.dart';
import 'package:shop/utils/LoadingWidget.dart';
import 'package:shop/utils/Themes.dart';
import 'package:shop/utils/app_palette.dart';
import 'package:shop/utils/app_size_boxes.dart';

import '../../../../business_logic/filter_cubit/filter_cubit.dart';
import '../../../../business_logic/locations_cubit/locations_cubit.dart';
import '../../../../translations/locale_keys.g.dart';
import '../../../../utils/styles.dart';
import '../../../widgets/filter_widgets/choose_location_widgets/choose_location_search_widget.dart';
import '../../../widgets/filter_widgets/choose_location_widgets/my_location_widget.dart';
import '../change_product_screen2.dart';
import 'choose_city_product_screen.dart';

class ChooseAreaProductScreen extends StatefulWidget {
  ChooseAreaProductScreen({Key? key,required this.data,required this.governmentId,required this.governmentName,
    required this.cityId,required this.cityName,required this.areaId,required this.areaName,required this.locationUser,
    required this.fromPrice,required this.toPrice,required this.nameProduct,required this.description,
    required this.bodyType,required this.engineCapacityType,required this.colorType,required this.fuelType,
    required this.levelType,required this.kiloMetresType,required this.amenitiesType,this.whatsAppNumber,
    this.typeApartment,this.statusApartment,this.typeFashion,this.typeCondtion,this.typeWarrannt,this.transmissionVehicles,
    this.typeHomeFurniture,this.typeBooks,this.typeKids,this.typeBusiness,this.warrantyElectronic,
    this.fromYear,this.toYear,this.bathroom,this.bedroom,this.fromArea,this.toArea,this.fromDownPayment,
    this.toDownPayment,this.fromkiloMetresType,this.tokiloMetresType,this.brandId,this.status,
    this.area,this.downPayment,this.year,this.productId}) : super(key: key);

  final String? data;
  final String? governmentId,governmentName,productId,typeCondtion,typeWarrannt,transmissionVehicles;
  final String? cityId,cityName,year,area,downPayment,typeApartment,statusApartment,typeFashion,typeHomeFurniture,
      typeBooks,typeKids,typeBusiness,warrantyElectronic,whatsAppNumber;
  final String? areaId,areaName,fuelType,amenitiesType,bodyType,colorType,engineCapacityType,kiloMetresType,levelType;
  final String? locationUser,fromPrice,toPrice,nameProduct,description;
  String? brandId,fromDownPayment,toDownPayment;
  String? status,fromYear,toYear,bedroom,bathroom;
  String? fromArea,toArea,fromkiloMetresType,tokiloMetresType;

  @override
  _ChooseAreaProductScreenState createState() => _ChooseAreaProductScreenState();
}

class _ChooseAreaProductScreenState extends State<ChooseAreaProductScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // print('government id ${widget.governmentId}');
    // print('government name ${widget.governmentName}');
    //
    // print('city id ${widget.cityId}');
    // print('city name ${widget.cityName}');

    //
    // print('area id ${widget.areaId}');
    // print('area name ${widget.areaName}');
    //
    // print('location User ${widget.locationUser}');

    setState(() {
      BlocProvider.of<LocationsCubit>(context).getAreaOfCity('${widget.cityId}');
    });
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        if (widget.data!.contains('filterScreen')){
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
                tokiloMetresType: widget.tokiloMetresType,
                kiloMetresType: widget.kiloMetresType,
                amenitiesType: widget.amenitiesType,
                fuelType: widget.fuelType,
                engineCapacityType: widget.engineCapacityType,
                colorType: widget.colorType,
                bodyType: widget.bodyType,
                locationUser: '',areaId: widget.areaId,areaName: widget.areaName,
                cityId: widget.cityId,cityName: widget.cityName,)));
        }else if(widget.data!.contains('changeProductScreen')){
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => ChooseCityProductScreen(
                description: widget.description,
                cityId: widget.cityId,
                cityName: widget.cityName,
                levelType: widget.levelType,
                transmissionVehicles: widget.transmissionVehicles,
                typeCondtion: widget.typeCondtion,
                typeWarrannt: widget.typeWarrannt,
                kiloMetresType: widget.kiloMetresType,
                typeApartment: widget.typeApartment,
                statusApartment: widget.statusApartment,
                typeBooks: widget.typeBooks,
                whatsAppNumber: widget.whatsAppNumber,
                typeKids: widget.typeKids,
                typeHomeFurniture: widget.typeHomeFurniture,
                typeFashion: widget.typeFashion,
                typeBusiness: widget.typeBusiness,
                amenitiesType: widget.amenitiesType,
                fuelType: widget.fuelType,
                engineCapacityType: widget.engineCapacityType,
                colorType: widget.colorType,
                bodyType: widget.bodyType,
                locationUser: '',fromPrice: widget.fromPrice,toPrice: widget.toPrice,
                nameProduct: widget.nameProduct,areaName: widget.areaName,areaId: widget.areaId,
                governmentId: widget.governmentId,
                governmentName: widget.governmentName, data: 'changeProductScreen',)));
        }else {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => ChooseCityProductScreen(
                description: widget.description,
                cityId: widget.cityId,
                cityName: widget.cityName,
                levelType: widget.levelType,
                bedroom: widget.bedroom,
                bathroom: widget.bathroom,
                area: widget.area,
                downPayment: widget.downPayment,
                year: widget.year,
                whatsAppNumber: widget.whatsAppNumber,
                kiloMetresType: widget.kiloMetresType,
                amenitiesType: widget.amenitiesType,
                fuelType: widget.fuelType,
                engineCapacityType: widget.engineCapacityType,
                colorType: widget.colorType,
                bodyType: widget.bodyType,
                locationUser: '',fromPrice: widget.fromPrice,toPrice: widget.toPrice,
                nameProduct: widget.nameProduct,areaName: widget.areaName,areaId: widget.areaId,
                governmentId: widget.governmentId,
                governmentName: widget.governmentName, data: '',)));
        }
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(LocaleKeys.locations.tr()),
          elevation: 0.0,
          leading: InkWell(
            onTap: (){
              if (widget.data!.contains('filterScreen')){
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
                        tokiloMetresType: widget.tokiloMetresType,
                        kiloMetresType: widget.kiloMetresType,
                        amenitiesType: widget.amenitiesType,
                        fuelType: widget.fuelType,
                        engineCapacityType: widget.engineCapacityType,
                        colorType: widget.colorType,
                        bodyType: widget.bodyType,
                        locationUser: '',areaId: widget.areaId,areaName: widget.areaName,
                        cityId: widget.cityId,cityName: widget.cityName,)));
              }else if(widget.data!.contains('changeProductScreen')){
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => ChooseCityProductScreen(
                      description: widget.description,
                      cityId: widget.cityId,
                      cityName: widget.cityName,
                      levelType: widget.levelType,
                      transmissionVehicles: widget.transmissionVehicles,
                      typeCondtion: widget.typeCondtion,
                      typeWarrannt: widget.typeWarrannt,
                      kiloMetresType: widget.kiloMetresType,
                      typeApartment: widget.typeApartment,
                      statusApartment: widget.statusApartment,
                      typeBooks: widget.typeBooks,
                      whatsAppNumber: widget.whatsAppNumber,
                      typeKids: widget.typeKids,
                      typeHomeFurniture: widget.typeHomeFurniture,
                      typeFashion: widget.typeFashion,
                      typeBusiness: widget.typeBusiness,
                      amenitiesType: widget.amenitiesType,
                      fuelType: widget.fuelType,
                      engineCapacityType: widget.engineCapacityType,
                      colorType: widget.colorType,
                      bodyType: widget.bodyType,
                      locationUser: '',fromPrice: widget.fromPrice,toPrice: widget.toPrice,
                      nameProduct: widget.nameProduct,areaName: widget.areaName,areaId: widget.areaId,
                      governmentId: widget.governmentId,
                      governmentName: widget.governmentName, data: 'changeProductScreen',)));
              }else {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => ChooseCityProductScreen(
                      description: widget.description,
                      cityId: widget.cityId,
                      cityName: widget.cityName,
                      levelType: widget.levelType,
                      bedroom: widget.bedroom,
                      bathroom: widget.bathroom,
                      area: widget.area,
                      downPayment: widget.downPayment,
                      year: widget.year,
                      whatsAppNumber: widget.whatsAppNumber,
                      kiloMetresType: widget.kiloMetresType,
                      amenitiesType: widget.amenitiesType,
                      fuelType: widget.fuelType,
                      engineCapacityType: widget.engineCapacityType,
                      colorType: widget.colorType,
                      bodyType: widget.bodyType,
                      locationUser: '',fromPrice: widget.fromPrice,toPrice: widget.toPrice,
                      nameProduct: widget.nameProduct,areaName: widget.areaName,areaId: widget.areaId,
                      governmentId: widget.governmentId,
                      governmentName: widget.governmentName, data: '',)));
              }

            },
            child: const Icon(Icons.arrow_back_ios,
                size: 20.0, color: AppPalette.black),
          ),
        ),
        body: BlocConsumer<LocationsCubit, LocationsState>(
            listener: (context, state) {},
          builder: (context, state) {
              LocationsCubit locationsCubit = LocationsCubit.get(context);
              if(state is AreaErrorState){
                LoadingWidget(data: state.error.toString());
              }else if(state is AreaSuccessState){
                return Column(
                  children: [
                    Text(
                      LocaleKeys.chooseLocation.tr(),
                      style: AppTextStyles.poppinsMedium
                          .copyWith(color: AppPalette.black),
                    ),
                    10.heightBox,
                    ChooseLocationSearchWidget(),
                    5.heightBox,
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          children: [
                            5.heightBox,
                            MyLocationWidget(),
                            7.heightBox,
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: const ScrollPhysics(),
                                itemCount: locationsCubit.areaModel?.data?.areas!.length,
                                padding: EdgeInsets.zero,
                                itemBuilder: (context, index) => InkWell(
                                  onTap: (){
                                    // print('government id ${widget.governmentId}');
                                    // print('government name ${widget.governmentName}');

                                    // print('City id ${widget.cityId}');
                                    // print('City name ${widget.cityName}');
                                    //
                                    // print('area name ${locationsCubit.areaModel?.data?.areas![index].name}');
                                    // print('area id ${locationsCubit.areaModel?.data?.areas![index].id}');


                                    // widget.locationUser = '${widget.governmentName} ${widget.cityName}'
                                    //     ' ${locationsCubit.areaModel?.data?.areas![index].name}';
                                    //
                                    // print('location User ${widget.locationUser}');
                                    if (widget.data!.contains('filterScreen')){
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
                                            tokiloMetresType: widget.tokiloMetresType,
                                            kiloMetresType: widget.kiloMetresType,
                                            amenitiesType: widget.amenitiesType,
                                            fuelType: widget.fuelType,
                                            engineCapacityType: widget.engineCapacityType,
                                            colorType: widget.colorType,
                                            bodyType: widget.bodyType,
                                            locationUser: '',
                                            cityId: widget.cityId,cityName: widget.cityName,
                                            areaId: locationsCubit.areaModel?.data?.areas![index].id.toString(),
                                            areaName: locationsCubit.areaModel?.data?.areas![index].name,)));
                                    }else if(widget.data!.contains('changeProductScreen')){
                                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                                          builder: (context) => ChangeProductScreen2(
                                            description: widget.description,
                                            cityId: widget.cityId,
                                            cityName: widget.cityName,
                                            levelType: widget.levelType,
                                            kiloMetresType: widget.kiloMetresType,
                                            amenitiesType: widget.amenitiesType,
                                            fuelType: widget.fuelType,
                                            typeApartment: widget.typeApartment,
                                            statusApartment: widget.statusApartment,
                                            transmissionVehicles: widget.transmissionVehicles,
                                            typeCondtion: widget.typeCondtion,
                                            typeBooks: widget.typeBooks,
                                            whatsAppNumber: widget.whatsAppNumber,
                                            typeKids: widget.typeKids,
                                            typeHomeFurniture: widget.typeHomeFurniture,
                                            typeFashion: widget.typeFashion,
                                            typeBusiness: widget.typeBusiness,
                                            typeWarrannt: widget.typeWarrannt,
                                            engineCapacityType: widget.engineCapacityType,
                                            colorType: widget.colorType,
                                            bodyType: widget.bodyType,
                                            locationUser: '',fromPrice: widget.fromPrice,toPrice: widget.toPrice,
                                            nameProduct: widget.nameProduct,
                                            areaName: '${locationsCubit.areaModel?.data?.areas![index].name}',
                                            areaId: '${locationsCubit.areaModel?.data?.areas![index].id}',
                                            governmentId: widget.governmentId,
                                            governmentName: widget.governmentName,)));
                                    }else {
                                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                                          builder: (context) => AddProductScreen(
                                            description: widget.description,
                                            cityId: widget.cityId,
                                            cityName: widget.cityName,
                                            levelType: widget.levelType,
                                            bedroom: widget.bedroom,
                                            bathroom: widget.bathroom,
                                            area: widget.area,
                                            downPayment: widget.downPayment,
                                            year: widget.year,
                                            whatsAppNumber: widget.whatsAppNumber,
                                            kiloMetresType: widget.kiloMetresType,
                                            amenitiesType: widget.amenitiesType,
                                            fuelType: widget.fuelType,
                                            engineCapacityType: widget.engineCapacityType,
                                            colorType: widget.colorType,
                                            bodyType: widget.bodyType,
                                            locationUser: '',fromPrice: widget.fromPrice,toPrice: widget.toPrice,
                                            nameProduct: widget.nameProduct,
                                            governmentId: widget.governmentId,
                                            governmentName: widget.governmentName,
                                            areaId: locationsCubit.areaModel?.data?.areas![index].id.toString(),
                                            areaName: locationsCubit.areaModel?.data?.areas![index].name,)));
                                    }

                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      7.heightBox,
                                      Text(
                                        '${locationsCubit.areaModel?.data?.areas![index].name}',
                                        style: AppTextStyles.poppinsRegular
                                            .copyWith(color: AppPalette.black),
                                      ),
                                      7.heightBox
                                    ],
                                  ),
                                ),
                                // value: filterCubit.locations[index],
                                // title: Text(filterCubit.locations[index].location),
                                // contentPadding: EdgeInsets.zero,
                                // activeColor: AppPalette.primary,
                                // groupValue: filterCubit.selectedLocation,
                                // onChanged: (LocationModel? location) =>
                                //     filterCubit.selectLocation(location: location!))
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }
              return const Center(
                child: CircularProgressIndicator(
                  color: Themes.colorApp1,
                ),
              );
          }),
      ),
    );
  }
}
