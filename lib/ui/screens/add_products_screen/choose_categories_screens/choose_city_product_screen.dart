// ignore_for_file: must_be_immutable

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_translator/google_translator.dart';
import 'package:shop/ui/screens/add_products_screen/add_product_screen.dart';
import 'package:shop/ui/screens/filter_screens/filter_screen.dart';
import 'package:shop/utils/LoadingWidget.dart';
import 'package:shop/utils/Themes.dart';
import 'package:shop/utils/app_palette.dart';
import 'package:shop/utils/app_size_boxes.dart';

import '../../../../business_logic/app_layout_cubit/app_layout_cubit.dart';
import '../../../../business_logic/filter_cubit/filter_cubit.dart';
import '../../../../business_logic/locations_cubit/locations_cubit.dart';
import '../../../../data/internet_connectivity/error_screens_connection.dart';
import '../../../../data/internet_connectivity/no_internet.dart';
import '../../../../translations/locale_keys.g.dart';
import '../../../../utils/styles.dart';
import '../../../widgets/filter_widgets/choose_location_widgets/choose_location_search_widget.dart';
import '../../../widgets/filter_widgets/choose_location_widgets/my_location_widget.dart';
import '../../filter_screens/widget_custom.dart';
import '../change_product_screen2.dart';
import 'choose_area_product_screen.dart';
import 'choose_government_product_screen.dart';

class ChooseCityProductScreen extends StatefulWidget {
  ChooseCityProductScreen({Key? key,required this.data,required this.governmentId,required this.governmentName,
    required this.cityId,required this.cityName,required this.areaId,required this.areaName,required this.locationUser,
    required this.fromPrice,required this.toPrice,required this.nameProduct,required this.description,
    required this.bodyType,required this.engineCapacityType,required this.colorType,required this.fuelType,
    required this.levelType,required this.kiloMetresType,required this.amenitiesType,this.whatsAppNumber,
    this.fromYear,this.toYear,this.bathroom,this.bedroom,this.fromArea,this.toArea,this.fromDownPayment,
    this.toDownPayment,this.fromkiloMetresType,this.tokiloMetresType,this.brandId,this.status,
    this.typeApartment,this.statusApartment,this.typeFashion,this.typeCondtion,this.typeWarrannt,
    this.typeHomeFurniture,this.typeBooks,this.typeKids,this.typeBusiness,this.warrantyElectronic,this.transmissionVehicles,
    this.year,this.downPayment,this.area,this.productId}) : super(key: key);

  final String? data;
  final String? governmentId,governmentName,productId,typeCondtion,typeWarrannt,whatsAppNumber;
  final String? cityId,cityName,year,area,downPayment,typeApartment,statusApartment,typeFashion,typeHomeFurniture,
      typeBooks,typeKids,typeBusiness,warrantyElectronic,transmissionVehicles;
  final String? areaId,areaName,fuelType,amenitiesType,bodyType,colorType,engineCapacityType,kiloMetresType,levelType;
  final String? locationUser,fromPrice,toPrice,nameProduct,description;
  String? brandId,fromDownPayment,toDownPayment;
  String? status,fromYear,toYear,bedroom,bathroom;
  String? fromArea,toArea,fromkiloMetresType,tokiloMetresType;

  @override
  _ChooseCityProductScreenState createState() =>
      _ChooseCityProductScreenState();
}

class _ChooseCityProductScreenState extends State<ChooseCityProductScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {
      BlocProvider.of<AppLayoutCubit>(context).checkUserConnection();
      BlocProvider.of<AppLayoutCubit>(context).checkConnectionInternet();
      BlocProvider.of<LocationsCubit>(context)
          .getCityOfGovernment('${widget.governmentId}');
    });

    //print('government id ${widget.governmentId}');
  }

  @override
  Widget build(BuildContext context) {
    final stateConnectionInternet = context.watch<AppLayoutCubit>().state;
    return stateConnectionInternet is ConnectionFailure ?
    NoInternetConnectionScreen(appLayoutState: stateConnectionInternet) :
     WillPopScope(
      onWillPop: () async{
        if (widget.data!.contains('filterScreen'))
        {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                  builder: (context) =>
                      FilterScreen(
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
                        cityId: widget.cityId,cityName: widget.cityName,
                      )));

        }else if(widget.data!.contains('changeProductScreen')){
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => ChooseGovernmentProductScreen(
                description: widget.description,
                cityId: widget.cityId,
                cityName: widget.cityName,
                levelType: widget.levelType,
                kiloMetresType: widget.kiloMetresType,
                amenitiesType: widget.amenitiesType,
                fuelType: widget.fuelType,
                engineCapacityType: widget.engineCapacityType,
                colorType: widget.colorType,
                whatsAppNumber: widget.whatsAppNumber,
                bodyType: widget.bodyType,
                typeApartment: widget.typeApartment,
                statusApartment: widget.statusApartment,
                transmissionVehicles: widget.transmissionVehicles,
                typeCondtion: widget.typeCondtion,
                typeBooks: widget.typeBooks,
                typeKids: widget.typeKids,
                typeHomeFurniture: widget.typeHomeFurniture,
                typeFashion: widget.typeFashion,
                typeBusiness: widget.typeBusiness,
                typeWarrannt: widget.typeWarrannt,
                locationUser: widget.locationUser,fromPrice: widget.fromPrice,toPrice: widget.toPrice,
                nameProduct: widget.nameProduct,areaName: widget.areaName,areaId: widget.areaId,
                governmentId: widget.governmentId,
                governmentName: widget.governmentName, data: 'changeProductScreen',)));
        }else {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                  builder: (context) =>
                      AddProductScreen(
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
                        locationUser: widget.locationUser,fromPrice: widget.fromPrice,toPrice: widget.toPrice,
                        nameProduct: widget.nameProduct,areaName: widget.areaName,areaId: widget.areaId,
                        governmentId: widget.governmentId,
                        governmentName: widget.governmentName,
                      )));
        }
        return false;
      },
      child: Scaffold(
        backgroundColor: AppPalette.primary,
        body: CustomAppBar(
            onTap: () {
              if (widget.data!.contains('filterScreen')) {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                        builder: (context) =>
                            FilterScreen(
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
                              locationUser: widget.locationUser,areaId: widget.areaId,areaName: widget.areaName,
                              cityId: widget.cityId,cityName: widget.cityName,
                            )));

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
                      engineCapacityType: widget.engineCapacityType,
                      colorType: widget.colorType,
                      whatsAppNumber: widget.whatsAppNumber,
                      bodyType: widget.bodyType,
                      typeApartment: widget.typeApartment,
                      statusApartment: widget.statusApartment,
                      transmissionVehicles: widget.transmissionVehicles,
                      typeCondtion: widget.typeCondtion,
                      typeBooks: widget.typeBooks,
                      typeKids: widget.typeKids,
                      typeHomeFurniture: widget.typeHomeFurniture,
                      typeFashion: widget.typeFashion,
                      typeBusiness: widget.typeBusiness,
                      typeWarrannt: widget.typeWarrannt,
                      locationUser: widget.locationUser,fromPrice: widget.fromPrice,toPrice: widget.toPrice,
                      nameProduct: widget.nameProduct,areaName: widget.areaName,areaId: widget.areaId,
                      governmentId: widget.governmentId,
                      governmentName: widget.governmentName, data: 'changeProductScreen',)));
              }else {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                        builder: (context) =>
                            AddProductScreen(
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
                              locationUser: widget.locationUser,fromPrice: widget.fromPrice,toPrice: widget.toPrice,
                              nameProduct: widget.nameProduct,areaName: widget.areaName,areaId: widget.areaId,
                              governmentId: widget.governmentId,
                              governmentName: widget.governmentName,
                            )));
              }
            },
            title: LocaleKeys.city.tr(),
            widgetCustom: BlocConsumer<LocationsCubit, LocationsState>(
                listener: (context, state) {},
                builder: (context, state) {
                  LocationsCubit locationsCubit = LocationsCubit.get(context);
                  if (state is CityErrorState) {
                    ErrorScreenConnection(onPressed:(){
                      setState(() {
                        BlocProvider.of<AppLayoutCubit>(context).checkUserConnection();
                        BlocProvider.of<AppLayoutCubit>(context).checkConnectionInternet();
                        BlocProvider.of<LocationsCubit>(context).getCityOfGovernment('${widget.governmentId}');
                      });
                    },);
                  } else if (state is CitySuccessState) {
                    if(state.citiesModel?.message == null){
                      return ErrorScreenConnection(onPressed:(){
                        setState(() {
                          BlocProvider.of<AppLayoutCubit>(context).checkUserConnection();
                          BlocProvider.of<AppLayoutCubit>(context).checkConnectionInternet();
                          BlocProvider.of<LocationsCubit>(context).getCityOfGovernment('${widget.governmentId}');
                        });
                      },);
                    }else if (state.citiesModel?.message != null){
                      return Column(
                        children: [
                          // Text(
                          //   LocaleKeys.chooseLocation.tr(),
                          //   style: AppTextStyles.poppinsMedium
                          //       .copyWith(color: AppPalette.black),
                          // ),
                          10.heightBox,
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: ChooseLocationSearchWidget(),
                          ),
                          5.heightBox,
                          widget.data!.contains('filterScreen') ?
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
                                      tokiloMetresType: widget.tokiloMetresType,
                                      kiloMetresType: widget.kiloMetresType,
                                      amenitiesType: widget.amenitiesType,
                                      fuelType: widget.fuelType,
                                      engineCapacityType: widget.engineCapacityType,
                                      colorType: widget.colorType,
                                      bodyType: widget.bodyType,
                                      locationUser: widget.locationUser,areaId: null,areaName: null,
                                      cityId: null,cityName: null,)));
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
                          ) :
                          Container(),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15),
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    5.heightBox,
                                    // MyLocationWidget(),
                                    // 7.heightBox,
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        physics: const ScrollPhysics(),
                                        itemCount: locationsCubit.citiesModel?.message!.length,
                                        padding: EdgeInsets.zero,
                                        itemBuilder: (context, index) => InkWell(
                                          onTap: () {
                                            // print(locationsCubit
                                            //     .citiesModel?.data!.cities!.length);
                                            // print(locationsCubit
                                            //     .citiesModel?.data!.cities![index].name);
                                            if (widget.data!.contains('filterScreen')) {
                                              Navigator.of(context).pushReplacement(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          FilterScreen(
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
                                                            locationUser: widget.locationUser,areaId: widget.areaId,areaName: widget.areaName,
                                                            cityId: locationsCubit.citiesModel?.message![index].id.toString(),
                                                            cityName: locationsCubit.citiesModel?.message![index].name,)));
                                            }else if(widget.data!.contains('changeProductScreen')){
                                              Navigator.of(context).pushReplacement(MaterialPageRoute(
                                                  builder: (context) => ChangeProductScreen2(
                                                    description: widget.description,
                                                    cityId:  '${locationsCubit.citiesModel?.message![index].id}',
                                                    cityName: '${locationsCubit.citiesModel?.message![index].name}',
                                                    levelType: widget.levelType,
                                                    kiloMetresType: widget.kiloMetresType,
                                                    amenitiesType: widget.amenitiesType,
                                                    fuelType: widget.fuelType,
                                                    typeApartment: widget.typeApartment,
                                                    statusApartment: widget.statusApartment,
                                                    transmissionVehicles: widget.transmissionVehicles,
                                                    typeCondtion: widget.typeCondtion,
                                                    typeBooks: widget.typeBooks,
                                                    typeKids: widget.typeKids,
                                                    whatsAppNumber: widget.whatsAppNumber,
                                                    typeHomeFurniture: widget.typeHomeFurniture,
                                                    typeFashion: widget.typeFashion,
                                                    typeBusiness: widget.typeBusiness,
                                                    typeWarrannt: widget.typeWarrannt,
                                                    engineCapacityType: widget.engineCapacityType,
                                                    colorType: widget.colorType,
                                                    bodyType: widget.bodyType,
                                                    locationUser: widget.locationUser,fromPrice: widget.fromPrice,toPrice: widget.toPrice,
                                                    nameProduct: widget.nameProduct,areaName: widget.areaName,areaId: widget.areaId,
                                                    governmentId: widget.governmentId,
                                                    governmentName: widget.governmentName,)));
                                            }else {
                                              Navigator.of(context).pushReplacement(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          AddProductScreen(
                                                            description: widget.description,
                                                            levelType: widget.levelType,
                                                            bedroom: widget.bedroom,
                                                            bathroom: widget.bathroom,
                                                            area: widget.area,
                                                            downPayment: widget.downPayment,
                                                            year: widget.year,
                                                            kiloMetresType: widget.kiloMetresType,
                                                            amenitiesType: widget.amenitiesType,
                                                            fuelType: widget.fuelType,
                                                            whatsAppNumber: widget.whatsAppNumber,
                                                            engineCapacityType: widget.engineCapacityType,
                                                            colorType: widget.colorType,
                                                            bodyType: widget.bodyType,
                                                            locationUser: widget.locationUser,fromPrice: widget.fromPrice,toPrice: widget.toPrice,
                                                            nameProduct: widget.nameProduct,areaName: widget.areaName,areaId: widget.areaId,
                                                            governmentId: widget.governmentId,
                                                            governmentName: widget.governmentName,
                                                            cityId: locationsCubit.citiesModel?.message![index].id.toString(),
                                                            cityName: locationsCubit.citiesModel?.message![index].name,
                                                          )));
                                            }

                                          },
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              7.heightBox,
                                              Text(
                                                '${locationsCubit.citiesModel?.message![index].name}',
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
                          ),
                        ],
                      );
                    }

                  }
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Themes.colorApp1,
                    ),
                  );
                }),)
      ),
    );
  }
}
