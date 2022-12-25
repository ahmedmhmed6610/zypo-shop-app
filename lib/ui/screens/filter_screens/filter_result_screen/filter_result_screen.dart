import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shop/data/internet_connectivity/no_internet.dart';
import 'package:shop/data/models/brand_model.dart';
import 'package:shop/utils/app_size_boxes.dart';
import 'package:translator/translator.dart';
import '../../../../business_logic/app_ui_cubit/app_ui_cubit.dart';
import '../../../../business_logic/filter_cubit/filter_cubit.dart';
import '../../../../business_logic/my_products_cubit/my_products_cubit.dart';
import '../../../../business_logic/my_products_cubit/my_products_state.dart';
import '../../../../data/internet_connectivity/error_screens_connection.dart';
import '../../../../helpers/cache_helper.dart';
import '../../../../helpers/components.dart';
import '../../../../translations/locale_keys.g.dart';
import '../../../../utils/app_palette.dart';
import '../../../../utils/dimensions.dart';
import '../../../../utils/styles.dart';
import '../../../widgets/filter_widgets/filter_result_widgets/filter_and_search_appbar_widget.dart';
import '../../../widgets/filter_widgets/filter_result_widgets/filter_and_search_appbar_widget2.dart';
import '../../../widgets/product_widgets/filter_product_item.dart';
import '../../../widgets/product_widgets/filter_product_list_item.dart';
import '../../layout/app_layout.dart';
import '../filter_screen.dart';

class FilterResultScreen extends StatefulWidget{
  FilterResultScreen({Key? key, this.data, this.governmentId,this.governmentName,this.furnishedProperties,
    this.cityId, this.cityName, this.areaId, this.areaName, this.locationUser,this.latitude,this.colorVehicles,
    this.fromPrice, this.toPrice, this.nameProduct, this.description,this.categoryName,this.longitude,
    this.bodyType, this.engineCapacityType,this.fuelType,this.categoryId,this.distance,
    this.levelType, this.amenitiesType,this.subCategory,this.typeProperties,
    this.fromYear,this.toYear,this.bathroom,this.bedroom,this.fromArea,this.toArea,this.fromDownPayment,this.kidsTranslate,
    this.toDownPayment,this.fromKilometersType,this.toKilometersType,this.brandId,this.status,this.brandName,
    this.typeApartment,this.statusApartment,this.typeFashion,this.brandModel,
    this.typeHomeFurniture,this.typeBooks,this.typeKids,this.typeBusiness,
    this.typeKidsTranslate,this.typeFashionTranslate,this.typeHomeFurnitureTranslate,
    this.typeBooksTranslate,this.typeBusinessTranslate,this.furnishedPropertiesTranslate,this.bodyTypeTranslate,
    this.colorVehiclesTranslate,this.transmissionVehiclesTranslate,this.engineCapacityTypeTranslate,
    this.amenitiesTypeTranslate,this.typePropertiesTranslate,this.typeApartmentTranslate,this.fuelTypeTranslate,
    this.warrantyElectronic,this.transmissionVehicles}) : super(key: key);

  String? categoryId,categoryName,subCategory,governmentId,governmentName,cityId,cityName,areaId,areaName;
  String? locationUser,fromPrice,toPrice,nameProduct,description,brandName,latitude,longitude;
  String? brandId,distance,status,data;
  BrandModel? brandModel;

  //// All Category
  String? warrantyElectronic,typeFashion,typeHomeFurniture,typeBooks,typeKids,typeBusiness;
  String? kidsTranslate,warrantyElectronicTranslate,typeFashionTranslate,
      typeHomeFurnitureTranslate,typeBooksTranslate,typeKidsTranslate,typeBusinessTranslate;

  ////// Vehicles Category
  String? fuelType,bodyType,colorVehicles,transmissionVehicles,engineCapacityType,
      fromYear,toYear,fromArea,toArea,fromKilometersType,toKilometersType;
  String? fuelTypeTranslate,bodyTypeTranslate,colorVehiclesTranslate,
      transmissionVehiclesTranslate,engineCapacityTypeTranslate;

  ///// Properties Category
  String? amenitiesType,levelType,fromDownPayment,toDownPayment,typeApartment,
      statusApartment,bedroom,bathroom,typeProperties,furnishedProperties;
  String? amenitiesTypeTranslate,typeApartmentTranslate,
      typePropertiesTranslate,furnishedPropertiesTranslate;

  @override
  State<FilterResultScreen> createState() => _FilterResultScreenState();

}

class _FilterResultScreenState extends State<FilterResultScreen> {

  String? statusProductNamed,statusProduct,statusWarranty,valueFurnishedProperties,valueStatusProperties,
      fashionType,homeFurniture,kidsType,businessType,booksType;

  final translator = GoogleTranslator();
  String? inputTranslate;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // statusProductNamed =  CacheHelper.getData(key: 'statusUser');


    if(widget.status == 'جديد' || widget.status == 'New'){
      statusProduct = '1';
      print('warrantyElectronics ${widget.status}');
      print('warrantyElectronics $statusProduct');
    }else if(widget.status == 'مستعمل' || widget.status == 'Used'){
      statusProduct = '0';
      print('warrantyElectronics ${widget.status}');
      print('warrantyElectronics $statusProduct');
    }else if(widget.status == 'جديد,مستعمل' || widget.status == 'New,Used'){
      statusProduct = '1,0';
      print('warrantyElectronics ${widget.status}');
      print('warrantyElectronics $statusProduct');
    }else if(widget.status == 'مستعمل,جديد' || widget.status == 'Used,New'){
      statusProduct = '0,1';
      print('warrantyElectronics ${widget.status}');
      print('warrantyElectronics $statusProduct');
    }else if(widget.status == null){
      statusProduct = '';
      print('warrantyElectronics ${widget.status}');
      print('warrantyElectronics $statusProduct');
    }else {
      statusProduct = '';
      print('warrantyElectronics ${widget.status}');
      print('warrantyElectronics $statusProduct');
    }

    if (kDebugMode) {
      print('filter search product');
      print('categoryId ${widget.categoryId}');
      print('categoryName ${widget.categoryName}');
      print('subCategoryId ${widget.subCategory}');
      print('brandId ${widget.brandModel?.id}');
      print('brandName ${widget.brandModel?.brandName?.en}');
      print('governmentId ${widget.governmentId}');
      print('governmentName ${widget.governmentName}');
      print('cityId ${widget.cityId}');
      print('cityName ${widget.cityName}');
      print('areaId ${widget.areaId}');
      print('areaName ${widget.areaName}');
      print('latitude ${widget.latitude}');
      print('longitude ${widget.longitude}');
      print('fromPrice ${widget.fromPrice}');
      print('toPrice ${widget.toPrice}');
      print('status user ${widget.status}');
      print('statusUser $statusProduct');
      print('distanceKilometres ${widget.distance}');
    }

    if(widget.categoryName == 'Electronics'){

      if(widget.warrantyElectronic == 'نعم' || widget.warrantyElectronic == 'Yes'){
        statusWarranty = 'yes';
        print('warrantyElectronics ${widget.warrantyElectronic}');
        print('warrantyElectronics $statusWarranty');
      }else if(widget.warrantyElectronic == 'لا' || widget.warrantyElectronic == 'No'){
        statusWarranty = 'no';
        print('warrantyElectronics ${widget.warrantyElectronic}');
        print('warrantyElectronicssss $statusWarranty');
      }else if(widget.warrantyElectronic == 'لا,نعم' || widget.warrantyElectronic == 'Yes,No'){
        statusWarranty = 'yes,no';
        print('warrantyElectronicsss ${widget.warrantyElectronic}');
        print('warrantyElectronicsss $statusWarranty');
      }else if(widget.warrantyElectronic == 'نعم,لا' || widget.warrantyElectronic == 'No,Yes'){
        statusWarranty = 'yes,no';
        print('warrantyElectronicsss ${widget.warrantyElectronic}');
        print('warrantyElectronicsss $statusWarranty');
      }else if(widget.warrantyElectronic == ''){
        statusWarranty = '';
        print('warrantyElectronics ${widget.warrantyElectronic}');
        print('warrantyElectronics $statusWarranty');
      }

      if (kDebugMode) {
        print('filter Electronics product');
        print('warrantyElectronicsNamed ${widget.warrantyElectronic}');
        print('warrantyElectronicsNamed $statusWarranty');
        print('status Named ${widget.status}');
        print('warrantyElectronicsNamed $statusProduct');
      }

      BlocProvider.of<FilterCubit>(context).getFilterProducts(
          '${widget.categoryId}',
          '${widget.categoryName}',
          '${widget.subCategory}',
          '${widget.brandModel?.id == null ? '' : widget.brandModel?.id}',
          '${widget.governmentId == null ? '' : widget.governmentId}',
          '${widget.cityId == null ? '' : widget.cityId}',
          '',
          '${widget.fromPrice}',
          '${widget.toPrice}',
          '$statusProduct',
          '${widget.latitude}',
          '${widget.longitude}',
          '${widget.distance}',
          '', '', '', '', '', '', '', '', '', '', '', '', '', '',
          '', '', '', '$statusWarranty', '', '', '', '', '');


    }
    else if(widget.categoryName == 'Vehicles') {

      if (kDebugMode) {
        print('filter Vehicles product');
        print('fuelTypeVehicles ${widget.categoryName}');
        print('fuelTypeVehicles ${widget.fuelType}');
        print('transmissionTypeVehicles ${widget.transmissionVehicles}');
        print('valueColorVehicles ${widget.colorVehicles}');
        print('valueBodyTypeVehicles ${widget.bodyType}');
        print('valueEngineCapacityVehicles ${widget..engineCapacityType}');
        print('valueBrandVehicles ${widget.brandName}');
        print('fuelTypeVehicles ${widget.fromYear},${widget.toYear}');
        print('fuelTypeVehicles ${widget.fromKilometersType},${widget.toKilometersType}');
      }

      BlocProvider.of<FilterCubit>(context).getFilterProducts(
          '${widget.categoryId}',
          '${widget.categoryName}',
          '${widget.subCategory}',
          '${widget.brandModel?.id == null ? '' : widget.brandModel?.id}',
          '${widget.governmentId == null ? '' : widget.governmentId}',
          '${widget.cityId == null ? '' : widget.cityId}',
          '',
          '${widget.fromPrice}',
          '${widget.toPrice}',
          '$statusProduct',
          '${widget.latitude}',
          '${widget.longitude}',
          '${widget.distance}',
          '${widget.fuelType}',
          '${widget.fromYear},${widget.toYear}',
          '${widget.fromKilometersType},${widget.toKilometersType}',
          '${widget.transmissionVehicles}',
          '${widget.colorVehicles}',
          '${widget.bodyType}',
          '${widget.engineCapacityType}',
          '', '', '', '', '', '', '', '',
          '', '', '', '', '', '', '', '');

    }
    else if(widget.categoryName == 'Properties'){


      if (kDebugMode) {
        print('filter Properties product');
        print('widget.typeProperties ${widget.typeProperties}');
        print('valueAmenitiesProperties ${widget.furnishedProperties}');
        print('valueBedroomProperties ${widget.amenitiesType}');
        print('valueBathRoomProperties ${widget.bathroom}');
        print('valueLevelProperties ${widget.levelType}');
        print('valueFurnishedProperties $valueFurnishedProperties');
        print('widget.typeApartment ${widget.typeApartment}');
        print('areaProperties ${widget.fromArea} - ${widget.toArea}');
        print('typeApartment ${widget.typeApartment}');
        print('valueStatusProperties $valueStatusProperties');
        print('downPaymentProperties ${widget.fromDownPayment}');

      }

      BlocProvider.of<FilterCubit>(context).getFilterProducts(
          '${widget.categoryId}',
          '${widget.categoryName}',
          '${widget.subCategory}',
          '${widget.brandModel?.id == null ? '' : widget.brandModel?.id}',
          '${widget.governmentId == null ? '' : widget.governmentId}',
          '${widget.cityId == null ? '' : widget.cityId}',
          '',
          '${widget.fromPrice}',
          '${widget.toPrice}',
          '$statusProduct',
          '${widget.latitude}',
          '${widget.longitude}',
          '${widget.distance}',
          '', '', '', '', '', '', '', '',
          '${widget.typeProperties}',
          '${widget.amenitiesType}',
          '${widget.bedroom}',
          '${widget.bathroom}',
          '${widget.levelType}',
          '${widget.furnishedProperties}',
          '${widget.typeApartment}',
          '${widget.fromArea},${widget.toArea}',
          '${widget.fromDownPayment}', '', '', '', '', '', '');


    }
    else if(widget.categoryName == 'Business - Industrial - Agriculture'){

      if (kDebugMode) {
        print('filter Business product');
        print('widget.typeBusiness ${widget.typeBusiness}');
        print('widget.typeBusiness $businessType');
      }

      BlocProvider.of<FilterCubit>(context).getFilterProducts(
          '${widget.categoryId}',
          '${widget.categoryName}',
          '${widget.subCategory}',
          '${widget.brandModel?.id == null ? '' : widget.brandModel?.id}',
          '${widget.governmentId == null ? '' : widget.governmentId}',
          '${widget.cityId == null ? '' : widget.cityId}',
          '',
          '${widget.fromPrice}',
          '${widget.toPrice}',
          '$statusProduct',
          '${widget.latitude == null ? '' : widget.latitude}',
          '${widget.longitude == null ? '' : widget.longitude}',
          '${widget.distance}',
          '', '', '', '', '', '', '', '', '', '', '', '', '', '',
          '', '', '', '', '', '', '', '', '${widget.typeBusiness}');




    }
    else if(widget.categoryName == 'Home Furniture'){

      if (kDebugMode) {
        print('filter Home Furniture product');
        print('widget.typeBusiness ${widget.typeHomeFurniture}');
      }

      BlocProvider.of<FilterCubit>(context).getFilterProducts(
          '${widget.categoryId}',
          '${widget.categoryName}',
          '${widget.subCategory}',
          '${widget.brandModel?.id == null ? '' : widget.brandModel?.id}',
          '${widget.governmentId == null ? '' : widget.governmentId}',
          '${widget.cityId == null ? '' : widget.cityId}',
          '',
          '${widget.fromPrice}',
          '${widget.toPrice}',
          '$statusProduct',
          '${widget.latitude}',
          '${widget.longitude}',
          '${widget.distance}',
          '', '', '', '', '', '', '', '', '', '', '', '', '', '',
          '', '', '', '', '${widget.typeHomeFurniture}', '', '', '', '');


    }
    else if(widget.categoryName == 'Fashion'){

      if (kDebugMode) {
        print('filter Fashion product');
        print('widget.typeBusiness ${widget.typeFashion}');
      }

      BlocProvider.of<FilterCubit>(context).getFilterProducts(
          '${widget.categoryId}',
          '${widget.categoryName}',
          '${widget.subCategory}',
          '${widget.brandModel?.id == null ? '' : widget.brandModel?.id}',
          '${widget.governmentId == null ? '' : widget.governmentId}',
          '${widget.cityId == null ? '' : widget.cityId}',
          '',
          '${widget.fromPrice}',
          '${widget.toPrice}',
          '$statusProduct',
          '${widget.latitude}',
          '${widget.longitude}',
          '${widget.distance}',
          '', '', '', '', '', '',
          '', '', '', '', '', '',
          '', '', '', '', '', '', '',
          '${widget.typeFashion}', '', '', '');

    }
    else if(widget.categoryName == 'Kids & Babies'){

      if (kDebugMode) {
        print('filter Kids & Babies product');
        print('widget.typeBusiness ${widget.typeKids}');
      }

      BlocProvider.of<FilterCubit>(context).getFilterProducts(
          '${widget.categoryId}',
          '${widget.categoryName}',
          '${widget.subCategory}',
          '${widget.brandModel?.id == null ? '' : widget.brandModel?.id}',
          '${widget.governmentId == null ? '' : widget.governmentId}',
          '${widget.cityId == null ? '' : widget.cityId}',
          '',
          '${widget.fromPrice}',
          '${widget.toPrice}',
          '$statusProduct',
          '${widget.latitude}',
          '${widget.longitude}',
          '${widget.distance}',
          '', '', '', '', '', '', '', '', '', '', '', '', '', '',
          '', '', '', '', '', '', '', '${widget.typeKids}', '');
    }
    else if(widget.categoryName == 'Books, Sports & Hobbies'){

      if (kDebugMode) {
        print('filter Books, Sports & Hobbies product');
        print('widget.typeBusiness ${widget.typeBooks}');
      }

      BlocProvider.of<FilterCubit>(context).getFilterProducts(
          '${widget.categoryId}',
          '${widget.categoryName}',
          '${widget.subCategory}',
          '${widget.brandModel?.id == null ? '' : widget.brandModel?.id}',
          '${widget.governmentId == null ? '' : widget.governmentId}',
          '${widget.cityId == null ? '' : widget.cityId}',
          '',
          '${widget.fromPrice}',
          '${widget.toPrice}',
          '$statusProduct',
          '${widget.latitude}',
          '${widget.longitude}',
          '${widget.distance}',
          '', '', '', '', '', '', '', '', '', '', '', '', '', '',
          '', '', '', '', '', '', '${widget.typeBooks}', '', '');

    }


  }

  @override
  build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        print('back screen');
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) =>  FilterScreen(
              governmentId: widget.governmentId,
              governmentName: widget.governmentName,
              cityId: widget.cityId,
              cityName: widget.cityName,
              areaId: widget.areaId,
              toPrice: widget.toPrice,
              locationUser: widget.locationUser,
              fromPrice: widget.fromPrice,
              areaName: widget.areaName,
              fromYear: widget.fromYear,
              toYear: widget.toYear,
              fromkiloMetresType: widget.fromKilometersType,
              tokiloMetresType: widget.toKilometersType,
              fromArea: widget.fromArea,
              toArea: widget.toArea,
              fromDownPayment: widget.fromDownPayment,
              toDownPayment: widget.toDownPayment,
            ),
          ),);
        return false;
      },
      child: BlocBuilder<FilterCubit, FilterState>(
        builder: (context, filterState) {
          FilterCubit filterCubit  = FilterCubit.get(context);
          return Scaffold(
            // appBar: AppBar(
            //   title: Text(
            //       context.locale.languageCode.contains('en') ?
            //       filterCubit.selectedMainCategory!.name!.en! :
            //       context.locale.languageCode.contains('ar') ?
            //       filterCubit.selectedMainCategory!.name!.ar! :
            //       context.locale.languageCode.contains('tr') ?
            //       filterCubit.selectedMainCategory!.name!.tr! :
            //       context.locale.languageCode.contains('de') ?
            //       filterCubit.selectedMainCategory!.name!.de! : '',
            //     style: TextStyle(color: AppPalette.black),),
            //   elevation: 0.0,
            //   leading: InkWell(
            //      onTap: () => Navigator.of(context).pop(),
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
                          onTap: ()=> Navigator.of(context).pop(),
                          child: Icon(Icons.arrow_back_ios,color: AppPalette.white,size: 25.sp,),
                        ),
                        Expanded(
                          child: Center(
                            child: AutoSizeText(
                              context.locale.languageCode.contains('en') ?
                              filterCubit.selectedMainCategory!.name!.en! :
                              context.locale.languageCode.contains('ar') ?
                              filterCubit.selectedMainCategory!.name!.ar! :
                              context.locale.languageCode.contains('tr') ?
                              filterCubit.selectedMainCategory!.name!.tr! :
                              context.locale.languageCode.contains('de') ?
                              filterCubit.selectedMainCategory!.name!.de! : '',
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
                      child: BlocBuilder<AppUiCubit, AppUiState>(
                        builder: (context, state) {
                          AppUiCubit appUICubit = AppUiCubit.get(context);
                          return Container(
                            padding: EdgeInsets.only(
                              top: Dimensions.paddingSizeDefault,
                              right: Dimensions.paddingSizeDefault,
                              left: Dimensions.paddingSizeDefault,
                            ),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  FilterAndSearchAppBarWidget(myProductUserResponseModel: filterCubit.myProductUserResponseModel,),
                                  10.heightBox,
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      GestureDetector(
                                        onTap: () => Navigator.of(context).pop(),
                                        child: Container(
                                          height: 50,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10.0),
                                              color: AppPalette.primary),
                                          padding: EdgeInsets.symmetric(
                                            vertical: Dimensions.paddingSize,
                                            horizontal: Dimensions.paddingSizeDefault,
                                          ),
                                          child: SvgPicture.asset("assets/images/svg/filter.svg",color: AppPalette.white,),
                                        ),
                                      ),
                                      5.widthBox,
                                      Expanded(
                                        child: SizedBox(
                                          height: 50,
                                          child: ListView(
                                            scrollDirection: Axis.horizontal,
                                            children: [
                                              widget.governmentName == null ?
                                              Container() :
                                              Row(
                                                children: [
                                                  GestureDetector(
                                                    onTap: (){
                                                      Navigator.pushReplacement(context, MaterialPageRoute(
                                                          builder: (context) => FilterScreen(
                                                            governmentId: widget.governmentId,
                                                            governmentName: widget.governmentName,
                                                            locationUser: widget.locationUser,
                                                            cityId: widget.cityId,
                                                            cityName: widget.cityName,
                                                            areaId: widget.areaId,
                                                            toPrice: widget.toPrice,
                                                            fromPrice: widget.fromPrice,
                                                            areaName: widget.areaName,
                                                            fromYear: widget.fromYear,
                                                            toYear: widget.toYear,
                                                            fromkiloMetresType: widget.fromKilometersType,
                                                            tokiloMetresType: widget.toKilometersType,
                                                            fromArea: widget.fromArea,
                                                            toArea: widget.toArea,
                                                            fromDownPayment: widget.fromDownPayment,
                                                            toDownPayment: widget.toDownPayment,
                                                          )));
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(10.0),
                                                          color: AppPalette.lightPrimary),
                                                      padding: EdgeInsets.symmetric(
                                                        vertical: Dimensions.paddingSize,
                                                        horizontal: Dimensions.paddingSizeDefault,
                                                      ),
                                                      // width: 100,
                                                      child: Row(
                                                        children: [
                                                          Text('${widget.governmentName}',
                                                            overflow: TextOverflow.ellipsis,
                                                            style: AppTextStyles.poppinsLight.copyWith(color: AppPalette.black),),
                                                          5.widthBox,
                                                          widget.cityName == null ?
                                                          Text('', style: AppTextStyles.poppinsLight.copyWith(color: AppPalette.black)) :
                                                          Text(' - ${widget.cityName}',
                                                              style: AppTextStyles.poppinsLight.copyWith(color: AppPalette.black)),
                                                          5.widthBox,
                                                          widget.locationUser == null ?
                                                          Text('', style: AppTextStyles.poppinsLight.copyWith(color: AppPalette.black)) :
                                                          Text(' - ${widget.locationUser}',
                                                              style: AppTextStyles.poppinsLight.copyWith(color: AppPalette.black)),
                                                          GestureDetector(
                                                              onTap: (){
                                                                Navigator.pushReplacement(context, MaterialPageRoute(
                                                                    builder: (context) =>  FilterResultScreen(
                                                                      categoryId: filterCubit.selectedMainCategory?.id.toString(),
                                                                      categoryName: filterCubit.selectedMainCategory?.name?.en,
                                                                      subCategory: filterCubit.selectedSubCategory?.id.toString(),
                                                                      brandId: widget.brandId,
                                                                      brandName: widget.brandName ,
                                                                      latitude: widget.latitude,
                                                                      longitude: widget.longitude,
                                                                      status: widget.status,
                                                                      brandModel: widget.brandModel,
                                                                      toPrice: widget.toPrice,
                                                                      fromPrice: widget.fromPrice,
                                                                      bedroom: widget.bedroom,
                                                                      fromArea: widget.fromArea,
                                                                      fromDownPayment: widget.fromDownPayment,
                                                                      toArea: widget.toArea,
                                                                      typeHomeFurniture: widget.typeHomeFurniture,
                                                                      typeBooks: widget.typeBooks,
                                                                      typeKids: widget.typeKids,
                                                                      typeFashion: widget.typeFashion,
                                                                      typeBusiness: widget.typeBusiness,
                                                                      warrantyElectronic: widget.warrantyElectronic,
                                                                      distance: widget.distance,
                                                                      governmentId: null,
                                                                      governmentName: null,
                                                                      cityId: null,
                                                                      cityName: null,
                                                                      areaId: null,
                                                                      areaName: null,
                                                                      locationUser: null,
                                                                      nameProduct: '',
                                                                      description: '',
                                                                    )));
                                                              },
                                                              child: const Icon(Icons.close_outlined,color: AppPalette.black,size: 25,)),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  5.widthBox,
                                                ],
                                              ) ,
                                              Builder(builder: (context) {
                                                AddProductCubit addProductCubit = AddProductCubit.get(context);
                                                return widget.brandModel?.id == null ? Container() :
                                                Row(
                                                  children: [
                                                    GestureDetector(
                                                      onTap: (){
                                                        Navigator.pushReplacement(context, MaterialPageRoute(
                                                            builder: (context) => FilterScreen(
                                                              governmentId: widget.governmentId,
                                                              governmentName: widget.governmentName,
                                                              cityId: widget.cityId,
                                                              locationUser: widget.locationUser,
                                                              cityName: widget.cityName,
                                                              areaId: widget.areaId,
                                                              status: widget.status,
                                                              bodyType: widget.bodyType,
                                                              engineCapacityType: widget.engineCapacityType,
                                                              fuelType: widget.fuelType,
                                                              toPrice: widget.toPrice,
                                                              fromPrice: widget.fromPrice,
                                                              areaName: widget.areaName,
                                                              fromYear: widget.fromYear,
                                                              toYear: widget.toYear,
                                                              fromkiloMetresType: widget.fromKilometersType,
                                                              tokiloMetresType: widget.toKilometersType,
                                                              fromArea: widget.fromArea,
                                                              toArea: widget.toArea,
                                                              fromDownPayment: widget.fromDownPayment,
                                                              toDownPayment: widget.toDownPayment,
                                                            )));
                                                      },
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(10.0),
                                                            color: AppPalette.lightPrimary),
                                                        padding: EdgeInsets.symmetric(
                                                          vertical: Dimensions.paddingSize,
                                                          horizontal: Dimensions.paddingSizeDefault,
                                                        ),
                                                        child: Padding(
                                                          padding: const EdgeInsets.all(3.0),
                                                          child: Row(
                                                            children: [
                                                              context.locale.languageCode.contains('ar') ?
                                                              Text('${widget.brandModel?.brandName?.ar}',
                                                                  style: AppTextStyles.poppinsLight.copyWith(color: AppPalette.black)) :
                                                              Text('${widget.brandModel?.brandName?.en}',
                                                                  style: AppTextStyles.poppinsLight.copyWith(color: AppPalette.black)),
                                                              5.widthBox,
                                                              GestureDetector(
                                                                  onTap: (){
                                                                    widget.brandModel?.id = null;
                                                                    addProductCubit.selectedBrand = null;
                                                                    Navigator.pushReplacement(context, MaterialPageRoute(
                                                                        builder: (context) =>   FilterResultScreen(
                                                                          categoryId: filterCubit.selectedMainCategory?.id.toString(),
                                                                          categoryName: filterCubit.selectedMainCategory?.name?.en,
                                                                          subCategory: filterCubit.selectedSubCategory?.id.toString(),
                                                                          brandId: null,
                                                                          brandName: null,
                                                                          locationUser: widget.locationUser,
                                                                          latitude: widget.latitude,
                                                                          longitude: widget.longitude,
                                                                          brandModel: widget.brandModel,
                                                                          status: widget.status,
                                                                          bodyType: widget.bodyType,
                                                                          engineCapacityType: widget.engineCapacityType,
                                                                          fuelType: widget.fuelType,
                                                                          distance: widget.distance,
                                                                          warrantyElectronic: filterCubit.selectedOptionsValueConditionElectronics,
                                                                          governmentId: widget.governmentId,
                                                                          governmentName: widget.governmentName,
                                                                          fromPrice: widget.fromPrice,
                                                                          toPrice: widget.toPrice,
                                                                          cityId: widget.cityId,
                                                                          cityName: widget.cityName,
                                                                          areaId: widget.areaId,
                                                                          areaName: widget.areaName,
                                                                          nameProduct: '',
                                                                          description: '',
                                                                        )));
                                                                  },
                                                                  child: const Icon(Icons.close_outlined,color: AppPalette.black,size: 25,)),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    5.widthBox,
                                                  ],
                                                );
                                              },),
                                              widget.status == null || widget.status == '' ?
                                              Container() :
                                              Row(
                                                children: [
                                                  GestureDetector(
                                                    onTap: (){
                                                      Navigator.pushReplacement(context, MaterialPageRoute(
                                                          builder: (context) => FilterScreen(
                                                            governmentId: widget.governmentId,
                                                            governmentName: widget.governmentName,
                                                            cityId: widget.cityId,
                                                            cityName: widget.cityName,
                                                            locationUser: widget.locationUser,
                                                            areaId: widget.areaId,
                                                            bodyType: widget.bodyType,
                                                            engineCapacityType: widget.engineCapacityType,
                                                            fuelType: widget.fuelType,
                                                            toPrice: widget.toPrice,
                                                            fromPrice: widget.fromPrice,
                                                            areaName: widget.areaName,
                                                            fromYear: widget.fromYear,
                                                            toYear: widget.toYear,
                                                            fromkiloMetresType: widget.fromKilometersType,
                                                            tokiloMetresType: widget.toKilometersType,
                                                            fromArea: widget.fromArea,
                                                            toArea: widget.toArea,
                                                            fromDownPayment: widget.fromDownPayment,
                                                            toDownPayment: widget.toDownPayment,
                                                          )));
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(10.0),
                                                          color: AppPalette.lightPrimary),
                                                      padding: EdgeInsets.symmetric(
                                                        vertical: Dimensions.paddingSize,
                                                        horizontal: Dimensions.paddingSizeDefault,
                                                      ),
                                                      // width: 100,
                                                      child: Row(
                                                        children: [
                                                          Text('${widget.status}',
                                                            overflow: TextOverflow.ellipsis,
                                                            style: AppTextStyles.poppinsLight.copyWith(color: AppPalette.black),),
                                                          GestureDetector(
                                                              onTap: (){
                                                                filterCubit.selectedOptionsValueConditionElectronics = '';
                                                                filterCubit.selectedOptionConditionElectronics = [];                                                      Navigator.pushReplacement(context, MaterialPageRoute(
                                                                    builder: (context) =>  FilterResultScreen(
                                                                      categoryId: filterCubit.selectedMainCategory?.id.toString(),
                                                                      categoryName: filterCubit.selectedMainCategory?.name?.en,
                                                                      subCategory: filterCubit.selectedSubCategory?.id.toString(),
                                                                      brandId: widget.brandId,
                                                                      locationUser: widget.locationUser,
                                                                      brandName: widget.brandName ,
                                                                      latitude: widget.latitude,
                                                                      bodyType: widget.bodyType,
                                                                      engineCapacityType: widget.engineCapacityType,
                                                                      fuelType: widget.fuelType,
                                                                      longitude: widget.longitude,
                                                                      brandModel: widget.brandModel,
                                                                      toPrice: widget.toPrice,
                                                                      fromPrice: widget.fromPrice,
                                                                      bedroom: widget.bedroom,
                                                                      fromArea: widget.fromArea,
                                                                      typeBusiness: widget.typeBusiness,
                                                                      fromDownPayment: widget.fromDownPayment,
                                                                      toArea: widget.toArea,
                                                                      status: '',
                                                                      distance: widget.distance,
                                                                      warrantyElectronic: widget.warrantyElectronic,
                                                                      governmentId: widget.governmentId,
                                                                      governmentName: widget.governmentName,
                                                                      cityId: widget.cityId,
                                                                      cityName: widget.cityName,
                                                                      areaId: widget.areaId,
                                                                      areaName: widget.areaName,
                                                                      nameProduct: '',
                                                                      description: '',
                                                                    )));
                                                              },
                                                              child: const Icon(Icons.close_outlined,color: AppPalette.black,size: 25,)),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  5.widthBox,
                                                ],
                                              ),
                                              widget.distance == null || widget.distance == '0' ?
                                              Container() :
                                              Row(
                                                children: [
                                                  GestureDetector(
                                                    onTap: (){
                                                      Navigator.pushReplacement(context, MaterialPageRoute(
                                                          builder: (context) => FilterScreen(
                                                            governmentId: widget.governmentId,
                                                            governmentName: widget.governmentName,
                                                            cityId: widget.cityId,
                                                            locationUser: widget.locationUser,
                                                            cityName: widget.cityName,
                                                            areaId: widget.areaId,
                                                            toPrice: widget.toPrice,
                                                            status: widget.status,
                                                            bodyType: widget.bodyType,
                                                            engineCapacityType: widget.engineCapacityType,
                                                            fuelType: widget.fuelType,
                                                            fromPrice: widget.fromPrice,
                                                            areaName: widget.areaName,
                                                            fromYear: widget.fromYear,
                                                            toYear: widget.toYear,
                                                            fromkiloMetresType: widget.fromKilometersType,
                                                            tokiloMetresType: widget.toKilometersType,
                                                            fromArea: widget.fromArea,
                                                            toArea: widget.toArea,
                                                            fromDownPayment: widget.fromDownPayment,
                                                            toDownPayment: widget.toDownPayment,
                                                          )));
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(10.0),
                                                          color: AppPalette.lightPrimary),
                                                      padding: EdgeInsets.symmetric(
                                                        vertical: Dimensions.paddingSize,
                                                        horizontal: Dimensions.paddingSizeDefault,
                                                      ),
                                                      child: Padding(
                                                        padding: const EdgeInsets.all(3.0),
                                                        child: Row(
                                                          children: [
                                                            Text('${widget.distance}',
                                                                style: AppTextStyles.poppinsLight.copyWith(color: AppPalette.black)),
                                                            2.widthBox,
                                                            Text(LocaleKeys.kilometers.tr(),
                                                                style: AppTextStyles.poppinsLight.copyWith(color: AppPalette.black)),
                                                            5.widthBox,
                                                            GestureDetector(
                                                                onTap: (){
                                                                  Navigator.pushReplacement(context, MaterialPageRoute(
                                                                      builder: (context) =>   FilterResultScreen(
                                                                        categoryId: filterCubit.selectedMainCategory?.id.toString(),
                                                                        categoryName: filterCubit.selectedMainCategory?.name?.en,
                                                                        subCategory: filterCubit.selectedSubCategory?.id.toString(),
                                                                        brandId: widget.brandId,
                                                                        locationUser: widget.locationUser,
                                                                        brandName: widget.brandName,
                                                                        brandModel: widget.brandModel,
                                                                        latitude: widget.latitude,
                                                                        longitude: widget.longitude,
                                                                        status: widget.status,
                                                                        distance: '0',
                                                                        bodyType: widget.bodyType,
                                                                        engineCapacityType: widget.engineCapacityType,
                                                                        fuelType: widget.fuelType,
                                                                        warrantyElectronic: filterCubit.selectedOptionsValueWarrantyElectronics,
                                                                        governmentId: widget.governmentId,
                                                                        governmentName: widget.governmentName,
                                                                        fromPrice: widget.fromPrice,
                                                                        toPrice: widget.toPrice,
                                                                        cityId: widget.cityId,
                                                                        cityName: widget.cityName,
                                                                        areaId: widget.areaId,
                                                                        areaName: widget.areaName,
                                                                        nameProduct: '',
                                                                        description: '',
                                                                      )));
                                                                },
                                                                child: const Icon(Icons.close_outlined,color: AppPalette.black,size: 25,)),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  5.widthBox,
                                                ],
                                              ),
                                              widget.warrantyElectronic == null || widget.warrantyElectronic == '' ?
                                              Container() :
                                              Row(
                                                children: [
                                                  GestureDetector(
                                                    onTap: (){
                                                      Navigator.pushReplacement(context, MaterialPageRoute(
                                                          builder: (context) => FilterScreen(
                                                            governmentId: widget.governmentId,
                                                            governmentName: widget.governmentName,
                                                            cityId: widget.cityId,
                                                            locationUser: widget.locationUser,
                                                            cityName: widget.cityName,
                                                            areaId: widget.areaId,
                                                            status: widget.status,
                                                            toPrice: widget.toPrice,
                                                            fromPrice: widget.fromPrice,
                                                            areaName: widget.areaName,
                                                          )));
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(10.0),
                                                          color: AppPalette.lightPrimary),
                                                      padding: EdgeInsets.symmetric(
                                                        vertical: Dimensions.paddingSize,
                                                        horizontal: Dimensions.paddingSizeDefault,
                                                      ),
                                                      // width: 100,
                                                      child: Row(
                                                        children: [
                                                          Text('${widget.warrantyElectronic}',
                                                            overflow: TextOverflow.ellipsis,
                                                            style: AppTextStyles.poppinsLight.copyWith(color: AppPalette.black),),
                                                          GestureDetector(
                                                              onTap: (){
                                                                filterCubit.selectedOptionsValueWarrantyElectronics = '';
                                                                filterCubit.selectedOptionWarrantyElectronics = [];
                                                                // filterCubit.selectedOptionsValueConditionAllCategory = '';
                                                                // filterCubit.selectedOptionConditionAllCategory = [];
                                                                Navigator.pushReplacement(context, MaterialPageRoute(
                                                                    builder: (context) =>  FilterResultScreen(
                                                                      categoryId: filterCubit.selectedMainCategory?.id.toString(),
                                                                      categoryName: filterCubit.selectedMainCategory?.name?.en,
                                                                      subCategory: filterCubit.selectedSubCategory?.id.toString(),
                                                                      brandId: widget.brandId,
                                                                      locationUser: widget.locationUser,
                                                                      brandName: widget.brandName ,
                                                                      latitude: widget.latitude,
                                                                      longitude: widget.longitude,
                                                                      brandModel: widget.brandModel,
                                                                      toPrice: widget.toPrice,
                                                                      fromPrice: widget.fromPrice,
                                                                      warrantyElectronic: '',
                                                                      status: widget.status,
                                                                      distance: widget.distance,
                                                                      governmentId: widget.governmentId,
                                                                      governmentName: widget.governmentName,
                                                                      cityId: widget.cityId,
                                                                      cityName: widget.cityName,
                                                                      areaId: widget.areaId,
                                                                      areaName: widget.areaName,
                                                                      nameProduct: '',
                                                                      description: '',
                                                                    )));
                                                              },
                                                              child: const Icon(Icons.close_outlined,color: AppPalette.black,size: 25,)),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  5.widthBox,
                                                ],
                                              ),
                                              widget.typeBusiness == null || widget.typeBusiness == '' ?
                                              Container() :
                                              Row(
                                                children: [
                                                  GestureDetector(
                                                    onTap: (){
                                                      Navigator.pushReplacement(context, MaterialPageRoute(
                                                          builder: (context) => FilterScreen(
                                                            governmentId: widget.governmentId,
                                                            governmentName: widget.governmentName,
                                                            cityId: widget.cityId,
                                                            locationUser: widget.locationUser,
                                                            cityName: widget.cityName,
                                                            status: widget.status,
                                                            areaId: widget.areaId,
                                                            toPrice: widget.toPrice,
                                                            fromPrice: widget.fromPrice,
                                                            areaName: widget.areaName,
                                                          )));
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(10.0),
                                                          color: AppPalette.lightPrimary),
                                                      padding: EdgeInsets.symmetric(
                                                        vertical: Dimensions.paddingSize,
                                                        horizontal: Dimensions.paddingSizeDefault,
                                                      ),
                                                      // width: 100,
                                                      child: Row(
                                                        children: [
                                                          Text('${widget.typeBusiness}',
                                                            overflow: TextOverflow.ellipsis,
                                                            style: AppTextStyles.poppinsLight.copyWith(color: AppPalette.black),),
                                                          GestureDetector(
                                                              onTap: (){
                                                                filterCubit.selectedOptionsValueBusiness = '';
                                                                filterCubit.selectedOptionBusiness = [];
                                                                Navigator.pushReplacement(context, MaterialPageRoute(
                                                                    builder: (context) =>  FilterResultScreen(
                                                                      categoryId: filterCubit.selectedMainCategory?.id.toString(),
                                                                      categoryName: filterCubit.selectedMainCategory?.name?.en,
                                                                      subCategory: filterCubit.selectedSubCategory?.id.toString(),
                                                                      brandId: widget.brandId,
                                                                      locationUser: widget.locationUser,
                                                                      brandName: widget.brandName ,
                                                                      latitude: widget.latitude,
                                                                      status: widget.status,
                                                                      longitude: widget.longitude,
                                                                      toPrice: widget.toPrice,
                                                                      fromPrice: widget.fromPrice,
                                                                      typeBusiness: '',
                                                                      distance: widget.distance,
                                                                      governmentId: widget.governmentId,
                                                                      governmentName: widget.governmentName,
                                                                      cityId: widget.cityId,
                                                                      cityName: widget.cityName,
                                                                      areaId: widget.areaId,
                                                                      areaName: widget.areaName,
                                                                      nameProduct: '',
                                                                      description: '',
                                                                    )));
                                                              },
                                                              child: const Icon(Icons.close_outlined,color: AppPalette.black,size: 25,)),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  5.widthBox,
                                                ],
                                              ),
                                              widget.typeFashion == null || widget.typeFashion == '' ?
                                              Container() :
                                              Row(
                                                children: [
                                                  GestureDetector(
                                                    onTap: (){
                                                      Navigator.pushReplacement(context, MaterialPageRoute(
                                                          builder: (context) => FilterScreen(
                                                            governmentId: widget.governmentId,
                                                            governmentName: widget.governmentName,
                                                            cityId: widget.cityId,
                                                            locationUser: widget.locationUser,
                                                            cityName: widget.cityName,
                                                            areaId: widget.areaId,
                                                            status: widget.status,
                                                            toPrice: widget.toPrice,
                                                            fromPrice: widget.fromPrice,
                                                            areaName: widget.areaName,
                                                          )));
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(10.0),
                                                          color: AppPalette.lightPrimary),
                                                      padding: EdgeInsets.symmetric(
                                                        vertical: Dimensions.paddingSize,
                                                        horizontal: Dimensions.paddingSizeDefault,
                                                      ),
                                                      // width: 100,
                                                      child: Row(
                                                        children: [
                                                          Text('${widget.typeFashion}',
                                                            overflow: TextOverflow.ellipsis,
                                                            style: AppTextStyles.poppinsLight.copyWith(color: AppPalette.black),),
                                                          GestureDetector(
                                                              onTap: (){
                                                                filterCubit.selectedOptionsValueFashion = '';
                                                                filterCubit.selectedOptionFashion = [];
                                                                Navigator.pushReplacement(context, MaterialPageRoute(
                                                                    builder: (context) =>  FilterResultScreen(
                                                                      categoryId: filterCubit.selectedMainCategory?.id.toString(),
                                                                      categoryName: filterCubit.selectedMainCategory?.name?.en,
                                                                      subCategory: filterCubit.selectedSubCategory?.id.toString(),
                                                                      brandId: widget.brandId,
                                                                      locationUser: widget.locationUser,
                                                                      brandName: widget.brandName ,
                                                                      latitude: widget.latitude,
                                                                      longitude: widget.longitude,
                                                                      toPrice: widget.toPrice,
                                                                      fromPrice: widget.fromPrice,
                                                                      typeFashion: '',
                                                                      status: widget.status,
                                                                      distance: widget.distance,
                                                                      governmentId: widget.governmentId,
                                                                      governmentName: widget.governmentName,
                                                                      cityId: widget.cityId,
                                                                      cityName: widget.cityName,
                                                                      areaId: widget.areaId,
                                                                      areaName: widget.areaName,
                                                                      nameProduct: '',
                                                                      description: '',
                                                                    )));
                                                              },
                                                              child: const Icon(Icons.close_outlined,color: AppPalette.black,size: 25,)),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  5.widthBox,
                                                ],
                                              ) ,
                                              widget.typeHomeFurniture == null || widget.typeHomeFurniture == '' ?
                                              Container() :
                                              Row(
                                                children: [
                                                  GestureDetector(
                                                    onTap: (){
                                                      Navigator.pushReplacement(context, MaterialPageRoute(
                                                          builder: (context) => FilterScreen(
                                                            governmentId: widget.governmentId,
                                                            governmentName: widget.governmentName,
                                                            cityId: widget.cityId,
                                                            locationUser: widget.locationUser,
                                                            cityName: widget.cityName,
                                                            areaId: widget.areaId,
                                                            status: widget.status,
                                                            toPrice: widget.toPrice,
                                                            fromPrice: widget.fromPrice,
                                                            areaName: widget.areaName,
                                                          )));
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(10.0),
                                                          color: AppPalette.lightPrimary),
                                                      padding: EdgeInsets.symmetric(
                                                        vertical: Dimensions.paddingSize,
                                                        horizontal: Dimensions.paddingSizeDefault,
                                                      ),
                                                      // width: 100,
                                                      child: Row(
                                                        children: [
                                                          Text('${widget.typeHomeFurniture}',
                                                            overflow: TextOverflow.ellipsis,
                                                            style: AppTextStyles.poppinsLight.copyWith(color: AppPalette.black),),
                                                          GestureDetector(
                                                              onTap: (){
                                                                filterCubit.selectedOptionsValueHomeFurniture = '';
                                                                filterCubit.selectedOptionHomeFurniture = [];
                                                                Navigator.pushReplacement(context, MaterialPageRoute(
                                                                    builder: (context) =>  FilterResultScreen(
                                                                      categoryId: filterCubit.selectedMainCategory?.id.toString(),
                                                                      categoryName: filterCubit.selectedMainCategory?.name?.en,
                                                                      subCategory: filterCubit.selectedSubCategory?.id.toString(),
                                                                      brandId: widget.brandId,
                                                                      locationUser: widget.locationUser,
                                                                      brandName: widget.brandName ,
                                                                      latitude: widget.latitude,
                                                                      longitude: widget.longitude,
                                                                      typeHomeFurniture: '',
                                                                      status: widget.status,
                                                                      toPrice: widget.toPrice,
                                                                      fromPrice: widget.fromPrice,
                                                                      distance: widget.distance,
                                                                      governmentId: widget.governmentId,
                                                                      governmentName: widget.governmentName,
                                                                      cityId: widget.cityId,
                                                                      cityName: widget.cityName,
                                                                      areaId: widget.areaId,
                                                                      areaName: widget.areaName,
                                                                      nameProduct: '',
                                                                      description: '',
                                                                    )));
                                                              },
                                                              child: const Icon(Icons.close_outlined,color: AppPalette.black,size: 25,)),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  5.widthBox,
                                                ],
                                              ),
                                              widget.typeKids == null || widget.typeKids == '' ?
                                              Container() :
                                              Row(
                                                children: [
                                                  GestureDetector(
                                                    onTap: (){
                                                      Navigator.pushReplacement(context, MaterialPageRoute(
                                                          builder: (context) => FilterScreen(
                                                            governmentId: widget.governmentId,
                                                            governmentName: widget.governmentName,
                                                            cityId: widget.cityId,
                                                            locationUser: widget.locationUser,
                                                            cityName: widget.cityName,
                                                            areaId: widget.areaId,
                                                            toPrice: widget.toPrice,
                                                            status: widget.status,
                                                            fromPrice: widget.fromPrice,
                                                            areaName: widget.areaName,
                                                          )));
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(10.0),
                                                          color: AppPalette.lightPrimary),
                                                      padding: EdgeInsets.symmetric(
                                                        vertical: Dimensions.paddingSize,
                                                        horizontal: Dimensions.paddingSizeDefault,
                                                      ),
                                                      // width: 100,
                                                      child: Row(
                                                        children: [
                                                          Text('${widget.typeKids}',
                                                            overflow: TextOverflow.ellipsis,
                                                            style: AppTextStyles.poppinsLight.copyWith(color: AppPalette.black),),
                                                          GestureDetector(
                                                              onTap: (){
                                                                filterCubit.selectedOptionsValueKids = '';
                                                                filterCubit.selectedOptionKids = [];
                                                                Navigator.pushReplacement(context, MaterialPageRoute(
                                                                    builder: (context) =>  FilterResultScreen(
                                                                      categoryId: filterCubit.selectedMainCategory?.id.toString(),
                                                                      categoryName: filterCubit.selectedMainCategory?.name?.en,
                                                                      subCategory: filterCubit.selectedSubCategory?.id.toString(),
                                                                      brandId: widget.brandId,
                                                                      locationUser: widget.locationUser,
                                                                      brandName: widget.brandName ,
                                                                      latitude: widget.latitude,
                                                                      longitude: widget.longitude,
                                                                      toPrice: widget.toPrice,
                                                                      fromPrice: widget.fromPrice,
                                                                      distance: widget.distance,
                                                                      status: widget.status,
                                                                      typeKids: '',
                                                                      governmentId: widget.governmentId,
                                                                      governmentName: widget.governmentName,
                                                                      cityId: widget.cityId,
                                                                      cityName: widget.cityName,
                                                                      areaId: widget.areaId,
                                                                      areaName: widget.areaName,
                                                                      nameProduct: '',
                                                                      description: '',
                                                                    )));
                                                              },
                                                              child: const Icon(Icons.close_outlined,color: AppPalette.black,size: 25,)),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  5.widthBox,
                                                ],
                                              ),
                                              widget.typeBooks == null || widget.typeBooks == '' ?
                                              Container() :
                                              Row(
                                                children: [
                                                  GestureDetector(
                                                    onTap: (){
                                                      Navigator.pushReplacement(context, MaterialPageRoute(
                                                          builder: (context) => FilterScreen(
                                                            governmentId: widget.governmentId,
                                                            governmentName: widget.governmentName,
                                                            cityId: widget.cityId,
                                                            locationUser: widget.locationUser,
                                                            cityName: widget.cityName,
                                                            areaId: widget.areaId,
                                                            status: widget.status,
                                                            toPrice: widget.toPrice,
                                                            fromPrice: widget.fromPrice,
                                                            areaName: widget.areaName,
                                                          )));
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(10.0),
                                                          color: AppPalette.lightPrimary),
                                                      padding: EdgeInsets.symmetric(
                                                        vertical: Dimensions.paddingSize,
                                                        horizontal: Dimensions.paddingSizeDefault,
                                                      ),
                                                      // width: 100,
                                                      child: Row(
                                                        children: [
                                                          Text('${widget.typeBooks}',
                                                            overflow: TextOverflow.ellipsis,
                                                            style: AppTextStyles.poppinsLight.copyWith(color: AppPalette.black),),
                                                          GestureDetector(
                                                              onTap: (){
                                                                filterCubit.selectedOptionsValueBooks = '';
                                                                filterCubit.selectedOptionBooks = [];
                                                                Navigator.pushReplacement(context, MaterialPageRoute(
                                                                    builder: (context) =>  FilterResultScreen(
                                                                      categoryId: filterCubit.selectedMainCategory?.id.toString(),
                                                                      categoryName: filterCubit.selectedMainCategory?.name?.en,
                                                                      subCategory: filterCubit.selectedSubCategory?.id.toString(),
                                                                      latitude: widget.latitude,
                                                                      locationUser: widget.locationUser,
                                                                      longitude: widget.longitude,
                                                                      toPrice: widget.toPrice,
                                                                      fromPrice: widget.fromPrice,
                                                                      typeBooks: '',
                                                                      status: widget.status,
                                                                      distance: widget.distance,
                                                                      governmentId: widget.governmentId,
                                                                      governmentName: widget.governmentName,
                                                                      cityId: widget.cityId,
                                                                      cityName: widget.cityName,
                                                                      areaId: widget.areaId,
                                                                      areaName: widget.areaName,
                                                                      nameProduct: '',
                                                                      description: '',
                                                                    )));
                                                              },
                                                              child: const Icon(Icons.close_outlined,color: AppPalette.black,size: 25,)),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  5.widthBox,
                                                ],
                                              ),
                                              widget.fuelType == null || widget.fuelType == '' ?
                                              Container() :
                                              Row(
                                                children: [
                                                  GestureDetector(
                                                    onTap: (){
                                                      Navigator.pushReplacement(context, MaterialPageRoute(
                                                          builder: (context) => FilterScreen(
                                                            governmentId: widget.governmentId,
                                                            governmentName: widget.governmentName,
                                                            cityId: widget.cityId,
                                                            locationUser: widget.locationUser,
                                                            cityName: widget.cityName,
                                                            areaId: widget.areaId,
                                                            toPrice: widget.toPrice,
                                                            status: widget.status,
                                                            fromPrice: widget.fromPrice,
                                                            areaName: widget.areaName,
                                                            fromYear: widget.fromYear,
                                                            toYear: widget.toYear,
                                                            fromkiloMetresType: widget.fromKilometersType,
                                                            tokiloMetresType: widget.toKilometersType,
                                                          )));
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(10.0),
                                                          color: AppPalette.lightPrimary),
                                                      padding: EdgeInsets.symmetric(
                                                        vertical: Dimensions.paddingSize,
                                                        horizontal: Dimensions.paddingSizeDefault,
                                                      ),
                                                      // width: 100,
                                                      child: Row(
                                                        children: [
                                                          Text('${widget.fuelType}',
                                                            overflow: TextOverflow.ellipsis,
                                                            style: AppTextStyles.poppinsLight.copyWith(color: AppPalette.black),),
                                                          GestureDetector(
                                                              onTap: (){
                                                                filterCubit.selectedOptionsValueFuelTypeVehicles = '';
                                                                filterCubit.selectedOptionFuelTypeVehicles = [];
                                                                Navigator.pushReplacement(context, MaterialPageRoute(
                                                                    builder: (context) =>  FilterResultScreen(
                                                                      categoryId: filterCubit.selectedMainCategory?.id.toString(),
                                                                      categoryName: filterCubit.selectedMainCategory?.name?.en,
                                                                      subCategory: filterCubit.selectedSubCategory?.id.toString(),
                                                                      latitude: widget.latitude,
                                                                      locationUser: widget.locationUser,
                                                                      longitude: widget.longitude,
                                                                      toPrice: widget.toPrice,
                                                                      fromPrice: widget.fromPrice,
                                                                      distance: widget.distance,
                                                                      fuelType: '',
                                                                      status: widget.status,
                                                                      brandModel: widget.brandModel,
                                                                      fromYear: widget.fromYear,
                                                                      toYear: widget.toYear,
                                                                      engineCapacityType: widget.engineCapacityType,
                                                                      transmissionVehicles: widget.transmissionVehicles,
                                                                      toKilometersType: widget.toKilometersType,
                                                                      bodyType: widget.bodyType,
                                                                      colorVehicles: widget.colorVehicles,
                                                                      fromKilometersType: widget.fromKilometersType,
                                                                      governmentId: widget.governmentId,
                                                                      governmentName: widget.governmentName,
                                                                      cityId: widget.cityId,
                                                                      cityName: widget.cityName,
                                                                      areaId: widget.areaId,
                                                                      areaName: widget.areaName,
                                                                      nameProduct: '',
                                                                      description: '',
                                                                    )));
                                                              },
                                                              child: const Icon(Icons.close_outlined,color: AppPalette.black,size: 25,)),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  5.widthBox,
                                                ],
                                              ),
                                              widget.fromYear == null || widget.fromYear == '' ?
                                              Container() :
                                              Row(
                                                children: [
                                                  GestureDetector(
                                                    onTap: (){
                                                      Navigator.pushReplacement(context, MaterialPageRoute(
                                                          builder: (context) => FilterScreen(
                                                            governmentId: widget.governmentId,
                                                            governmentName: widget.governmentName,
                                                            cityId: widget.cityId,
                                                            locationUser: widget.locationUser,
                                                            cityName: widget.cityName,
                                                            areaId: widget.areaId,
                                                            status: widget.status,
                                                            toPrice: widget.toPrice,
                                                            fromPrice: widget.fromPrice,
                                                            areaName: widget.areaName,
                                                            fromYear: widget.fromYear,
                                                            toYear: widget.toYear,
                                                            fromkiloMetresType: widget.fromKilometersType,
                                                            tokiloMetresType: widget.toKilometersType,
                                                          )));
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(10.0),
                                                          color: AppPalette.lightPrimary),
                                                      padding: EdgeInsets.symmetric(
                                                        vertical: Dimensions.paddingSize,
                                                        horizontal: Dimensions.paddingSizeDefault,
                                                      ),
                                                      // width: 100,
                                                      child: Row(
                                                        children: [
                                                          Text(widget.toYear == null ? '${LocaleKeys.year.tr()} ${widget.fromYear} ' :
                                                          '${LocaleKeys.year.tr()} ${widget.fromYear} - ${LocaleKeys.year.tr()} ${widget.toYear  }  ' ,
                                                            overflow: TextOverflow.ellipsis,
                                                            style: AppTextStyles.poppinsLight.copyWith(color: AppPalette.black),),
                                                          GestureDetector(
                                                              onTap: (){
                                                                Navigator.pushReplacement(context, MaterialPageRoute(
                                                                    builder: (context) =>  FilterResultScreen(
                                                                      categoryId: filterCubit.selectedMainCategory?.id.toString(),
                                                                      categoryName: filterCubit.selectedMainCategory?.name?.en,
                                                                      subCategory: filterCubit.selectedSubCategory?.id.toString(),
                                                                      latitude: widget.latitude,
                                                                      locationUser: widget.locationUser,
                                                                      longitude: widget.longitude,
                                                                      toPrice: widget.toPrice,
                                                                      fromPrice: widget.fromPrice,
                                                                      distance: widget.distance,
                                                                      fuelType: widget.fuelType,
                                                                      brandModel: widget.brandModel,
                                                                      status: widget.status,
                                                                      fromYear: null,
                                                                      toYear: null,
                                                                      engineCapacityType: widget.engineCapacityType,
                                                                      transmissionVehicles: widget.transmissionVehicles,
                                                                      toKilometersType: widget.toKilometersType,
                                                                      bodyType: widget.bodyType,
                                                                      colorVehicles: widget.colorVehicles,
                                                                      fromKilometersType: widget.fromKilometersType,
                                                                      governmentId: widget.governmentId,
                                                                      governmentName: widget.governmentName,
                                                                      cityId: widget.cityId,
                                                                      cityName: widget.cityName,
                                                                      areaId: widget.areaId,
                                                                      areaName: widget.areaName,
                                                                      nameProduct: '',
                                                                      description: '',
                                                                    )));
                                                              },
                                                              child: const Icon(Icons.close_outlined,color: AppPalette.black,size: 25,)),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  5.widthBox,
                                                ],
                                              ),
                                              widget.colorVehicles == null || widget.colorVehicles == '' ?
                                              Container() :
                                              Row(
                                                children: [
                                                  GestureDetector(
                                                    onTap: (){
                                                      Navigator.pushReplacement(context, MaterialPageRoute(
                                                          builder: (context) => FilterScreen(
                                                            governmentId: widget.governmentId,
                                                            governmentName: widget.governmentName,
                                                            cityId: widget.cityId,
                                                            locationUser: widget.locationUser,
                                                            cityName: widget.cityName,
                                                            areaId: widget.areaId,
                                                            status: widget.status,
                                                            toPrice: widget.toPrice,
                                                            fromPrice: widget.fromPrice,
                                                            areaName: widget.areaName,
                                                            fromYear: widget.fromYear,
                                                            toYear: widget.toYear,
                                                            fromkiloMetresType: widget.fromKilometersType,
                                                            tokiloMetresType: widget.toKilometersType,
                                                          )));
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(10.0),
                                                          color: AppPalette.lightPrimary),
                                                      padding: EdgeInsets.symmetric(
                                                        vertical: Dimensions.paddingSize,
                                                        horizontal: Dimensions.paddingSizeDefault,
                                                      ),
                                                      // width: 100,
                                                      child: Row(
                                                        children: [
                                                          Text('${widget.colorVehicles}',
                                                            overflow: TextOverflow.ellipsis,
                                                            style: AppTextStyles.poppinsLight.copyWith(color: AppPalette.black),),
                                                          GestureDetector(
                                                              onTap: (){
                                                                filterCubit.selectedOptionColorVehicles = [];
                                                                filterCubit.selectedOptionsValueColorVehicles = '';
                                                                Navigator.pushReplacement(context, MaterialPageRoute(
                                                                    builder: (context) =>  FilterResultScreen(
                                                                      categoryId: filterCubit.selectedMainCategory?.id.toString(),
                                                                      categoryName: filterCubit.selectedMainCategory?.name?.en,
                                                                      subCategory: filterCubit.selectedSubCategory?.id.toString(),
                                                                      latitude: widget.latitude,
                                                                      locationUser: widget.locationUser,
                                                                      longitude: widget.longitude,
                                                                      toPrice: widget.toPrice,
                                                                      fromPrice: widget.fromPrice,
                                                                      distance: widget.distance,
                                                                      fuelType: widget.fuelType,
                                                                      brandModel: widget.brandModel,
                                                                      status: widget.status,
                                                                      fromYear: widget.fromYear,
                                                                      toYear: widget.toYear,
                                                                      engineCapacityType: widget.engineCapacityType,
                                                                      transmissionVehicles: widget.transmissionVehicles,
                                                                      toKilometersType: widget.toKilometersType,
                                                                      bodyType: widget.bodyType,
                                                                      colorVehicles: '',
                                                                      fromKilometersType: widget.fromKilometersType,
                                                                      governmentId: widget.governmentId,
                                                                      governmentName: widget.governmentName,
                                                                      cityId: widget.cityId,
                                                                      cityName: widget.cityName,
                                                                      areaId: widget.areaId,
                                                                      areaName: widget.areaName,
                                                                      nameProduct: '',
                                                                      description: '',
                                                                    )));
                                                              },
                                                              child: const Icon(Icons.close_outlined,color: AppPalette.black,size: 25,)),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  5.widthBox,
                                                ],
                                              ),
                                              widget.fromKilometersType == null || widget.fromKilometersType == '' ?
                                              Container() :
                                              Row(
                                                children: [
                                                  GestureDetector(
                                                    onTap: (){
                                                      Navigator.pushReplacement(context, MaterialPageRoute(
                                                          builder: (context) => FilterScreen(
                                                            governmentId: widget.governmentId,
                                                            governmentName: widget.governmentName,
                                                            cityId: widget.cityId,
                                                            locationUser: widget.locationUser,
                                                            cityName: widget.cityName,
                                                            areaId: widget.areaId,
                                                            toPrice: widget.toPrice,
                                                            status: widget.status,
                                                            fromPrice: widget.fromPrice,
                                                            areaName: widget.areaName,
                                                            fromYear: widget.fromYear,
                                                            toYear: widget.toYear,
                                                            fromkiloMetresType: widget.fromKilometersType,
                                                            tokiloMetresType: widget.toKilometersType,
                                                          )));
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(10.0),
                                                          color: AppPalette.lightPrimary),
                                                      padding: EdgeInsets.symmetric(
                                                        vertical: Dimensions.paddingSize,
                                                        horizontal: Dimensions.paddingSizeDefault,
                                                      ),
                                                      // width: 100,
                                                      child: Row(
                                                        children: [
                                                          Text(widget.toKilometersType == null ? '${widget.fromKilometersType} ${LocaleKeys.kilometers.tr()} ' :
                                                          '${widget.fromKilometersType} ${LocaleKeys.kilometers.tr()} - ${widget.toKilometersType} ${LocaleKeys.kilometers.tr()} ',
                                                            overflow: TextOverflow.ellipsis,
                                                            style: AppTextStyles.poppinsLight.copyWith(color: AppPalette.black),),
                                                          GestureDetector(
                                                              onTap: (){
                                                                Navigator.pushReplacement(context, MaterialPageRoute(
                                                                    builder: (context) =>  FilterResultScreen(
                                                                      categoryId: filterCubit.selectedMainCategory?.id.toString(),
                                                                      categoryName: filterCubit.selectedMainCategory?.name?.en,
                                                                      subCategory: filterCubit.selectedSubCategory?.id.toString(),
                                                                      latitude: widget.latitude,
                                                                      locationUser: widget.locationUser,
                                                                      longitude: widget.longitude,
                                                                      toPrice: widget.toPrice,
                                                                      fromPrice: widget.fromPrice,
                                                                      distance: widget.distance,
                                                                      fuelType: widget.fuelType,
                                                                      status: widget.status,
                                                                      brandModel: widget.brandModel,
                                                                      fromYear: widget.fromYear,
                                                                      toYear: widget.toYear,
                                                                      engineCapacityType: widget.engineCapacityType,
                                                                      transmissionVehicles: widget.transmissionVehicles,
                                                                      toKilometersType: null,
                                                                      bodyType: widget.bodyType,
                                                                      colorVehicles: '',
                                                                      fromKilometersType: null,
                                                                      governmentId: widget.governmentId,
                                                                      governmentName: widget.governmentName,
                                                                      cityId: widget.cityId,
                                                                      cityName: widget.cityName,
                                                                      areaId: widget.areaId,
                                                                      areaName: widget.areaName,
                                                                      nameProduct: '',
                                                                      description: '',
                                                                    )));
                                                              },
                                                              child: const Icon(Icons.close_outlined,color: AppPalette.black,size: 25,)),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  5.widthBox,
                                                ],
                                              ),
                                              widget.transmissionVehicles == null || widget.transmissionVehicles == '' ?
                                              Container() :
                                              Row(
                                                children: [
                                                  GestureDetector(
                                                    onTap: (){
                                                      Navigator.pushReplacement(context, MaterialPageRoute(
                                                          builder: (context) => FilterScreen(
                                                            governmentId: widget.governmentId,
                                                            governmentName: widget.governmentName,
                                                            cityId: widget.cityId,
                                                            locationUser: widget.locationUser,
                                                            cityName: widget.cityName,
                                                            areaId: widget.areaId,
                                                            status: widget.status,
                                                            toPrice: widget.toPrice,
                                                            fromPrice: widget.fromPrice,
                                                            areaName: widget.areaName,
                                                            fromYear: widget.fromYear,
                                                            toYear: widget.toYear,
                                                            fromkiloMetresType: widget.fromKilometersType,
                                                            tokiloMetresType: widget.toKilometersType,
                                                          )));
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(10.0),
                                                          color: AppPalette.lightPrimary),
                                                      padding: EdgeInsets.symmetric(
                                                        vertical: Dimensions.paddingSize,
                                                        horizontal: Dimensions.paddingSizeDefault,
                                                      ),
                                                      // width: 100,
                                                      child: Row(
                                                        children: [
                                                          Text('${widget.transmissionVehicles}',
                                                            overflow: TextOverflow.ellipsis,
                                                            style: AppTextStyles.poppinsLight.copyWith(color: AppPalette.black),),
                                                          GestureDetector(
                                                              onTap: (){
                                                                filterCubit.selectedOptionTransmissionTypeVehicles = [];
                                                                filterCubit.selectedOptionsValueTransmissionTypeVehicles = '';
                                                                Navigator.pushReplacement(context, MaterialPageRoute(
                                                                    builder: (context) =>  FilterResultScreen(
                                                                      categoryId: filterCubit.selectedMainCategory?.id.toString(),
                                                                      categoryName: filterCubit.selectedMainCategory?.name?.en,
                                                                      subCategory: filterCubit.selectedSubCategory?.id.toString(),
                                                                      latitude: widget.latitude,
                                                                      locationUser: widget.locationUser,
                                                                      longitude: widget.longitude,
                                                                      toPrice: widget.toPrice,
                                                                      fromPrice: widget.fromPrice,
                                                                      status: widget.status,
                                                                      distance: widget.distance,
                                                                      fuelType: widget.fuelType,
                                                                      brandModel: widget.brandModel,
                                                                      fromYear: widget.fromYear,
                                                                      toYear: widget.toYear,
                                                                      engineCapacityType: widget.engineCapacityType,
                                                                      transmissionVehicles: '',
                                                                      toKilometersType: widget.toKilometersType,
                                                                      bodyType: widget.bodyType,
                                                                      colorVehicles: widget.colorVehicles,
                                                                      fromKilometersType: widget.fromKilometersType,
                                                                      governmentId: widget.governmentId,
                                                                      governmentName: widget.governmentName,
                                                                      cityId: widget.cityId,
                                                                      cityName: widget.cityName,
                                                                      areaId: widget.areaId,
                                                                      areaName: widget.areaName,
                                                                      nameProduct: '',
                                                                      description: '',
                                                                    )));
                                                              },
                                                              child: const Icon(Icons.close_outlined,color: AppPalette.black,size: 25,)),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  5.widthBox,
                                                ],
                                              ),
                                              widget.bodyType == null || widget.bodyType == '' ?
                                              Container() :
                                              Row(
                                                children: [
                                                  GestureDetector(
                                                    onTap: (){
                                                      Navigator.pushReplacement(context, MaterialPageRoute(
                                                          builder: (context) => FilterScreen(
                                                            governmentId: widget.governmentId,
                                                            governmentName: widget.governmentName,
                                                            cityId: widget.cityId,
                                                            locationUser: widget.locationUser,
                                                            cityName: widget.cityName,
                                                            areaId: widget.areaId,
                                                            toPrice: widget.toPrice,
                                                            status: widget.status,
                                                            fromPrice: widget.fromPrice,
                                                            areaName: widget.areaName,
                                                            fromYear: widget.fromYear,
                                                            toYear: widget.toYear,
                                                            fromkiloMetresType: widget.fromKilometersType,
                                                            tokiloMetresType: widget.toKilometersType,
                                                          )));
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(10.0),
                                                          color: AppPalette.lightPrimary),
                                                      padding: EdgeInsets.symmetric(
                                                        vertical: Dimensions.paddingSize,
                                                        horizontal: Dimensions.paddingSizeDefault,
                                                      ),
                                                      // width: 100,
                                                      child: Row(
                                                        children: [
                                                          Text('${widget.bodyType}',
                                                            overflow: TextOverflow.ellipsis,
                                                            style: AppTextStyles.poppinsLight.copyWith(color: AppPalette.black),),
                                                          GestureDetector(
                                                              onTap: (){
                                                                filterCubit.selectedOptionBodyTypeVehicles = [];
                                                                filterCubit.selectedOptionsValueBodyTypeVehicles = '';
                                                                Navigator.pushReplacement(context, MaterialPageRoute(
                                                                    builder: (context) =>  FilterResultScreen(
                                                                      categoryId: filterCubit.selectedMainCategory?.id.toString(),
                                                                      categoryName: filterCubit.selectedMainCategory?.name?.en,
                                                                      subCategory: filterCubit.selectedSubCategory?.id.toString(),
                                                                      latitude: widget.latitude,
                                                                      locationUser: widget.locationUser,
                                                                      longitude: widget.longitude,
                                                                      toPrice: widget.toPrice,
                                                                      fromPrice: widget.fromPrice,
                                                                      status: widget.status,
                                                                      distance: widget.distance,
                                                                      fuelType: widget.fuelType,
                                                                      brandModel: widget.brandModel,
                                                                      fromYear: widget.fromYear,
                                                                      toYear: widget.toYear,
                                                                      engineCapacityType: widget.engineCapacityType,
                                                                      transmissionVehicles: widget.transmissionVehicles,
                                                                      toKilometersType: widget.toKilometersType,
                                                                      bodyType: '',
                                                                      colorVehicles: widget.colorVehicles,
                                                                      fromKilometersType: widget.fromKilometersType,
                                                                      governmentId: widget.governmentId,
                                                                      governmentName: widget.governmentName,
                                                                      cityId: widget.cityId,
                                                                      cityName: widget.cityName,
                                                                      areaId: widget.areaId,
                                                                      areaName: widget.areaName,
                                                                      nameProduct: '',
                                                                      description: '',
                                                                    )));
                                                              },
                                                              child: const Icon(Icons.close_outlined,color: AppPalette.black,size: 25,)),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  5.widthBox,
                                                ],
                                              ),
                                              widget.engineCapacityType == null || widget.engineCapacityType == '' ?
                                              Container() :
                                              Row(
                                                children: [
                                                  GestureDetector(
                                                    onTap: (){
                                                      Navigator.pushReplacement(context, MaterialPageRoute(
                                                          builder: (context) => FilterScreen(
                                                            governmentId: widget.governmentId,
                                                            governmentName: widget.governmentName,
                                                            cityId: widget.cityId,
                                                            cityName: widget.cityName,
                                                            locationUser: widget.locationUser,
                                                            areaId: widget.areaId,
                                                            toPrice: widget.toPrice,
                                                            fromPrice: widget.fromPrice,
                                                            areaName: widget.areaName,
                                                            fromYear: widget.fromYear,
                                                            toYear: widget.toYear,
                                                            fromkiloMetresType: widget.fromKilometersType,
                                                            tokiloMetresType: widget.toKilometersType,
                                                          )));
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(10.0),
                                                          color: AppPalette.lightPrimary),
                                                      padding: EdgeInsets.symmetric(
                                                        vertical: Dimensions.paddingSize,
                                                        horizontal: Dimensions.paddingSizeDefault,
                                                      ),
                                                      // width: 100,
                                                      child: Row(
                                                        children: [
                                                          Text('${widget.engineCapacityType}',
                                                            overflow: TextOverflow.ellipsis,
                                                            style: AppTextStyles.poppinsLight.copyWith(color: AppPalette.black),),
                                                          GestureDetector(
                                                              onTap: (){
                                                                filterCubit.selectedOptionEngineCapacityVehicles = [];
                                                                filterCubit.selectedOptionsValueEngineCapacityVehicles = '';
                                                                Navigator.pushReplacement(context, MaterialPageRoute(
                                                                    builder: (context) =>  FilterResultScreen(
                                                                      categoryId: filterCubit.selectedMainCategory?.id.toString(),
                                                                      categoryName: filterCubit.selectedMainCategory?.name?.en,
                                                                      subCategory: filterCubit.selectedSubCategory?.id.toString(),
                                                                      latitude: widget.latitude,
                                                                      locationUser: widget.locationUser,
                                                                      longitude: widget.longitude,
                                                                      toPrice: widget.toPrice,
                                                                      fromPrice: widget.fromPrice,
                                                                      status: widget.status,
                                                                      distance: widget.distance,
                                                                      fuelType: widget.fuelType,
                                                                      brandModel: widget.brandModel,
                                                                      fromYear: widget.fromYear,
                                                                      toYear: widget.toYear,
                                                                      engineCapacityType: '',
                                                                      transmissionVehicles: widget.transmissionVehicles,
                                                                      toKilometersType: widget.toKilometersType,
                                                                      bodyType: widget.bodyType,
                                                                      colorVehicles: widget.colorVehicles,
                                                                      fromKilometersType: widget.fromKilometersType,
                                                                      governmentId: widget.governmentId,
                                                                      governmentName: widget.governmentName,
                                                                      cityId: widget.cityId,
                                                                      cityName: widget.cityName,
                                                                      areaId: widget.areaId,
                                                                      areaName: widget.areaName,
                                                                      nameProduct: '',
                                                                      description: '',
                                                                    )));
                                                              },
                                                              child: const Icon(Icons.close_outlined,color: AppPalette.black,size: 25,)),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  5.widthBox,
                                                ],
                                              ),
                                              ///
                                              widget.typeProperties == null || widget.typeProperties == '' ?
                                              Container() :
                                              Row(
                                                children: [
                                                  GestureDetector(
                                                    onTap: (){
                                                      Navigator.pushReplacement(context, MaterialPageRoute(
                                                          builder: (context) => FilterScreen(
                                                            governmentId: widget.governmentId,
                                                            governmentName: widget.governmentName,
                                                            cityId: widget.cityId,
                                                            cityName: widget.cityName,
                                                            areaId: widget.areaId,
                                                            locationUser: widget.locationUser,
                                                            toPrice: widget.toPrice,
                                                            fromPrice: widget.fromPrice,
                                                            areaName: widget.areaName,
                                                            fromArea: widget.fromArea,
                                                            toArea: widget.toArea,
                                                            fromDownPayment: widget.fromDownPayment,
                                                            toDownPayment: widget.toDownPayment,
                                                          )));
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(10.0),
                                                          color: AppPalette.lightPrimary),
                                                      padding: EdgeInsets.symmetric(
                                                        vertical: Dimensions.paddingSize,
                                                        horizontal: Dimensions.paddingSizeDefault,
                                                      ),
                                                      // width: 100,
                                                      child: Row(
                                                        children: [
                                                          Text('${widget.typeProperties}',
                                                            overflow: TextOverflow.ellipsis,
                                                            style: AppTextStyles.poppinsLight.copyWith(color: AppPalette.black),),
                                                          GestureDetector(
                                                              onTap: (){
                                                                filterCubit.selectedOptionTypeProperties = [];
                                                                filterCubit.selectedOptionsValueTypeProperties = '';
                                                                Navigator.pushReplacement(context, MaterialPageRoute(
                                                                    builder: (context) =>  FilterResultScreen(
                                                                      categoryId: filterCubit.selectedMainCategory?.id.toString(),
                                                                      categoryName: filterCubit.selectedMainCategory?.name?.en,
                                                                      subCategory: filterCubit.selectedSubCategory?.id.toString(),
                                                                      latitude: widget.latitude,
                                                                      locationUser: widget.locationUser,
                                                                      longitude: widget.longitude,
                                                                      toPrice: widget.toPrice,
                                                                      fromPrice: widget.fromPrice,
                                                                      distance: widget.distance,
                                                                      typeProperties: '',
                                                                      fromDownPayment: widget.fromDownPayment,
                                                                      toDownPayment: widget.toDownPayment,
                                                                      levelType: widget.levelType,
                                                                      amenitiesType: widget.amenitiesType,
                                                                      bedroom: widget.bedroom,
                                                                      bathroom: widget.bathroom,
                                                                      fromArea: widget.fromArea,
                                                                      toArea: widget.toArea,
                                                                      furnishedProperties: widget.furnishedProperties,
                                                                      governmentId: widget.governmentId,
                                                                      governmentName: widget.governmentName,
                                                                      cityId: widget.cityId,
                                                                      cityName: widget.cityName,
                                                                      areaId: widget.areaId,
                                                                      areaName: widget.areaName,
                                                                      nameProduct: '',
                                                                      description: '',
                                                                    )));
                                                              },
                                                              child: const Icon(Icons.close_outlined,color: AppPalette.black,size: 25,)),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  5.widthBox,
                                                ],
                                              ),
                                              widget.fromDownPayment == null || widget.fromDownPayment == '' ?
                                              Container() :
                                              Row(
                                                children: [
                                                  GestureDetector(
                                                    onTap: (){
                                                      Navigator.pushReplacement(context, MaterialPageRoute(
                                                          builder: (context) => FilterScreen(
                                                            governmentId: widget.governmentId,
                                                            governmentName: widget.governmentName,
                                                            cityId: widget.cityId,
                                                            cityName: widget.cityName,
                                                            areaId: widget.areaId,
                                                            toPrice: widget.toPrice,
                                                            locationUser: widget.locationUser,
                                                            fromPrice: widget.fromPrice,
                                                            areaName: widget.areaName,
                                                            fromArea: widget.fromArea,
                                                            toArea: widget.toArea,
                                                            fromDownPayment: widget.fromDownPayment,
                                                            toDownPayment: widget.toDownPayment,
                                                          )));
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(10.0),
                                                          color: AppPalette.lightPrimary),
                                                      padding: EdgeInsets.symmetric(
                                                        vertical: Dimensions.paddingSize,
                                                        horizontal: Dimensions.paddingSizeDefault,
                                                      ),
                                                      // width: 100,
                                                      child: Row(
                                                        children: [
                                                          Text('${widget.fromDownPayment}',
                                                            overflow: TextOverflow.ellipsis,
                                                            style: AppTextStyles.poppinsLight.copyWith(color: AppPalette.black),),
                                                          GestureDetector(
                                                              onTap: (){
                                                                Navigator.pushReplacement(context, MaterialPageRoute(
                                                                    builder: (context) =>  FilterResultScreen(
                                                                      categoryId: filterCubit.selectedMainCategory?.id.toString(),
                                                                      categoryName: filterCubit.selectedMainCategory?.name?.en,
                                                                      subCategory: filterCubit.selectedSubCategory?.id.toString(),
                                                                      latitude: widget.latitude,
                                                                      locationUser: widget.locationUser,
                                                                      longitude: widget.longitude,
                                                                      toPrice: widget.toPrice,
                                                                      fromPrice: widget.fromPrice,
                                                                      distance: widget.distance,
                                                                      typeProperties: widget.typeProperties,
                                                                      fromDownPayment: null,
                                                                      toDownPayment: null,
                                                                      levelType: widget.levelType,
                                                                      amenitiesType: widget.amenitiesType,
                                                                      bedroom: widget.bedroom,
                                                                      bathroom: widget.bathroom,
                                                                      fromArea: widget.fromArea,
                                                                      toArea: widget.toArea,
                                                                      furnishedProperties: widget.furnishedProperties,
                                                                      governmentId: widget.governmentId,
                                                                      governmentName: widget.governmentName,
                                                                      cityId: widget.cityId,
                                                                      cityName: widget.cityName,
                                                                      areaId: widget.areaId,
                                                                      areaName: widget.areaName,
                                                                      nameProduct: '',
                                                                      description: '',
                                                                    )));
                                                              },
                                                              child: const Icon(Icons.close_outlined,color: AppPalette.black,size: 25,)),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  5.widthBox,
                                                ],
                                              ),
                                              widget.amenitiesType == null || widget.amenitiesType == '' ?
                                              Container() :
                                              Row(
                                                children: [
                                                  GestureDetector(
                                                    onTap: (){
                                                      Navigator.pushReplacement(context, MaterialPageRoute(
                                                          builder: (context) => FilterScreen(
                                                            governmentId: widget.governmentId,
                                                            governmentName: widget.governmentName,
                                                            cityId: widget.cityId,
                                                            cityName: widget.cityName,
                                                            areaId: widget.areaId,
                                                            locationUser: widget.locationUser,
                                                            toPrice: widget.toPrice,
                                                            fromPrice: widget.fromPrice,
                                                            areaName: widget.areaName,
                                                            fromArea: widget.fromArea,
                                                            toArea: widget.toArea,
                                                            fromDownPayment: widget.fromDownPayment,
                                                            toDownPayment: widget.toDownPayment,
                                                          )));
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(10.0),
                                                          color: AppPalette.lightPrimary),
                                                      padding: EdgeInsets.symmetric(
                                                        vertical: Dimensions.paddingSize,
                                                        horizontal: Dimensions.paddingSizeDefault,
                                                      ),
                                                      // width: 100,
                                                      child: Row(
                                                        children: [
                                                          Text('${widget.amenitiesType}',
                                                            overflow: TextOverflow.ellipsis,
                                                            style: AppTextStyles.poppinsLight.copyWith(color: AppPalette.black),),
                                                          GestureDetector(
                                                              onTap: (){
                                                                filterCubit.selectedOptionAmenitiesProperties = [];
                                                                filterCubit.selectedOptionsValueAmenitiesProperties = '';
                                                                Navigator.pushReplacement(context, MaterialPageRoute(
                                                                    builder: (context) =>  FilterResultScreen(
                                                                      categoryId: filterCubit.selectedMainCategory?.id.toString(),
                                                                      categoryName: filterCubit.selectedMainCategory?.name?.en,
                                                                      subCategory: filterCubit.selectedSubCategory?.id.toString(),
                                                                      latitude: widget.latitude,
                                                                      locationUser: widget.locationUser,
                                                                      longitude: widget.longitude,
                                                                      toPrice: widget.toPrice,
                                                                      fromPrice: widget.fromPrice,
                                                                      distance: widget.distance,
                                                                      typeProperties: widget.typeProperties,
                                                                      fromDownPayment: widget.fromDownPayment,
                                                                      toDownPayment: widget.toDownPayment,
                                                                      levelType: widget.levelType,
                                                                      amenitiesType: '',
                                                                      bedroom: widget.bedroom,
                                                                      bathroom: widget.bathroom,
                                                                      fromArea: widget.fromArea,
                                                                      toArea: widget.toArea,
                                                                      furnishedProperties: widget.furnishedProperties,
                                                                      governmentId: widget.governmentId,
                                                                      governmentName: widget.governmentName,
                                                                      cityId: widget.cityId,
                                                                      cityName: widget.cityName,
                                                                      areaId: widget.areaId,
                                                                      areaName: widget.areaName,
                                                                      nameProduct: '',
                                                                      description: '',
                                                                    )));
                                                              },
                                                              child: const Icon(Icons.close_outlined,color: AppPalette.black,size: 25,)),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  5.widthBox,
                                                ],
                                              ),
                                              widget.bedroom == null || widget.bedroom == '' ?
                                              Container() :
                                              Row(
                                                children: [
                                                  GestureDetector(
                                                    onTap: (){
                                                      Navigator.pushReplacement(context, MaterialPageRoute(
                                                          builder: (context) => FilterScreen(
                                                            governmentId: widget.governmentId,
                                                            governmentName: widget.governmentName,
                                                            cityId: widget.cityId,
                                                            cityName: widget.cityName,
                                                            areaId: widget.areaId,
                                                            locationUser: widget.locationUser,
                                                            toPrice: widget.toPrice,
                                                            fromPrice: widget.fromPrice,
                                                            areaName: widget.areaName,
                                                            fromArea: widget.fromArea,
                                                            toArea: widget.toArea,
                                                            fromDownPayment: widget.fromDownPayment,
                                                            toDownPayment: widget.toDownPayment,
                                                          )));
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(10.0),
                                                          color: AppPalette.lightPrimary),
                                                      padding: EdgeInsets.symmetric(
                                                        vertical: Dimensions.paddingSize,
                                                        horizontal: Dimensions.paddingSizeDefault,
                                                      ),
                                                      // width: 100,
                                                      child: Row(
                                                        children: [
                                                          Text('${widget.bedroom} ${LocaleKeys.bedroom.tr()}',
                                                            overflow: TextOverflow.ellipsis,
                                                            style: AppTextStyles.poppinsLight.copyWith(color: AppPalette.black),),
                                                          GestureDetector(
                                                              onTap: (){
                                                                filterCubit.selectedOptionBedroomProperties = [];
                                                                filterCubit.selectedOptionsValueBedroomProperties = '';
                                                                Navigator.pushReplacement(context, MaterialPageRoute(
                                                                    builder: (context) =>  FilterResultScreen(
                                                                      categoryId: filterCubit.selectedMainCategory?.id.toString(),
                                                                      categoryName: filterCubit.selectedMainCategory?.name?.en,
                                                                      subCategory: filterCubit.selectedSubCategory?.id.toString(),
                                                                      latitude: widget.latitude,
                                                                      locationUser: widget.locationUser,
                                                                      longitude: widget.longitude,
                                                                      toPrice: widget.toPrice,
                                                                      fromPrice: widget.fromPrice,
                                                                      distance: widget.distance,
                                                                      statusApartment: widget.statusApartment,
                                                                      typeProperties: widget.typeProperties,
                                                                      fromDownPayment: widget.fromDownPayment,
                                                                      toDownPayment: widget.toDownPayment,
                                                                      amenitiesType: widget.amenitiesType,
                                                                      levelType: widget.levelType,
                                                                      bedroom: '',
                                                                      bathroom: widget.bathroom,
                                                                      fromArea: widget.fromArea,
                                                                      toArea: widget.toArea,
                                                                      furnishedProperties: widget.furnishedProperties,
                                                                      governmentId: widget.governmentId,
                                                                      governmentName: widget.governmentName,
                                                                      cityId: widget.cityId,
                                                                      cityName: widget.cityName,
                                                                      areaId: widget.areaId,
                                                                      areaName: widget.areaName,
                                                                      nameProduct: '',
                                                                      description: '',
                                                                    )));
                                                              },
                                                              child: const Icon(Icons.close_outlined,color: AppPalette.black,size: 25,)),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  5.widthBox,
                                                ],
                                              ),
                                              widget.bathroom == null || widget.bathroom == '' ?
                                              Container() :
                                              Row(
                                                children: [
                                                  GestureDetector(
                                                    onTap: (){
                                                      Navigator.pushReplacement(context, MaterialPageRoute(
                                                          builder: (context) => FilterScreen(
                                                            governmentId: widget.governmentId,
                                                            governmentName: widget.governmentName,
                                                            cityId: widget.cityId,
                                                            cityName: widget.cityName,
                                                            locationUser: widget.locationUser,
                                                            areaId: widget.areaId,
                                                            toPrice: widget.toPrice,
                                                            fromPrice: widget.fromPrice,
                                                            areaName: widget.areaName,
                                                            fromArea: widget.fromArea,
                                                            toArea: widget.toArea,
                                                            fromDownPayment: widget.fromDownPayment,
                                                            toDownPayment: widget.toDownPayment,
                                                          )));
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(10.0),
                                                          color: AppPalette.lightPrimary),
                                                      padding: EdgeInsets.symmetric(
                                                        vertical: Dimensions.paddingSize,
                                                        horizontal: Dimensions.paddingSizeDefault,
                                                      ),
                                                      // width: 100,
                                                      child: Row(
                                                        children: [
                                                          Text('${widget.bathroom} ${LocaleKeys.bathroom.tr()}',
                                                            overflow: TextOverflow.ellipsis,
                                                            style: AppTextStyles.poppinsLight.copyWith(color: AppPalette.black),),
                                                          GestureDetector(
                                                              onTap: (){
                                                                filterCubit.selectedOptionBathRoomProperties = [];
                                                                filterCubit.selectedOptionsValueBathRoomProperties = '';
                                                                Navigator.pushReplacement(context, MaterialPageRoute(
                                                                    builder: (context) =>  FilterResultScreen(
                                                                      categoryId: filterCubit.selectedMainCategory?.id.toString(),
                                                                      categoryName: filterCubit.selectedMainCategory?.name?.en,
                                                                      subCategory: filterCubit.selectedSubCategory?.id.toString(),
                                                                      latitude: widget.latitude,
                                                                      locationUser: widget.locationUser,
                                                                      longitude: widget.longitude,
                                                                      toPrice: widget.toPrice,
                                                                      fromPrice: widget.fromPrice,
                                                                      distance: widget.distance,
                                                                      statusApartment: widget.statusApartment,
                                                                      typeProperties: widget.typeProperties,
                                                                      fromDownPayment: widget.fromDownPayment,
                                                                      toDownPayment: widget.toDownPayment,
                                                                      levelType: widget.levelType,
                                                                      amenitiesType: widget.amenitiesType,
                                                                      bedroom: widget.bedroom,
                                                                      bathroom: '',
                                                                      fromArea: widget.fromArea,
                                                                      toArea: widget.toArea,
                                                                      furnishedProperties: widget.furnishedProperties,
                                                                      governmentId: widget.governmentId,
                                                                      governmentName: widget.governmentName,
                                                                      cityId: widget.cityId,
                                                                      cityName: widget.cityName,
                                                                      areaId: widget.areaId,
                                                                      areaName: widget.areaName,
                                                                      nameProduct: '',
                                                                      description: '',
                                                                    )));
                                                              },
                                                              child: const Icon(Icons.close_outlined,color: AppPalette.black,size: 25,)),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  5.widthBox,
                                                ],
                                              ),
                                              widget.fromArea == null || widget.fromArea == '' ?
                                              Container() :
                                              Row(
                                                children: [
                                                  GestureDetector(
                                                    onTap: (){
                                                      Navigator.pushReplacement(context, MaterialPageRoute(
                                                          builder: (context) => FilterScreen(
                                                            governmentId: widget.governmentId,
                                                            governmentName: widget.governmentName,
                                                            cityId: widget.cityId,
                                                            cityName: widget.cityName,
                                                            areaId: widget.areaId,
                                                            locationUser: widget.locationUser,
                                                            toPrice: widget.toPrice,
                                                            fromPrice: widget.fromPrice,
                                                            areaName: widget.areaName,
                                                            fromArea: widget.fromArea,
                                                            toArea: widget.toArea,
                                                            fromDownPayment: widget.fromDownPayment,
                                                            toDownPayment: widget.toDownPayment,
                                                          )));
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(10.0),
                                                          color: AppPalette.lightPrimary),
                                                      padding: EdgeInsets.symmetric(
                                                        vertical: Dimensions.paddingSize,
                                                        horizontal: Dimensions.paddingSizeDefault,
                                                      ),
                                                      // width: 100,
                                                      child: Row(
                                                        children: [
                                                          Text(widget.toArea == null ? '${widget.fromArea}' :
                                                          '${widget.fromArea} - ${widget.toArea}',
                                                            overflow: TextOverflow.ellipsis,
                                                            style: AppTextStyles.poppinsLight.copyWith(color: AppPalette.black),),
                                                          GestureDetector(
                                                              onTap: (){
                                                                Navigator.pushReplacement(context, MaterialPageRoute(
                                                                    builder: (context) =>  FilterResultScreen(
                                                                      categoryId: filterCubit.selectedMainCategory?.id.toString(),
                                                                      categoryName: filterCubit.selectedMainCategory?.name?.en,
                                                                      subCategory: filterCubit.selectedSubCategory?.id.toString(),
                                                                      latitude: widget.latitude,
                                                                      locationUser: widget.locationUser,
                                                                      longitude: widget.longitude,
                                                                      toPrice: widget.toPrice,
                                                                      fromPrice: widget.fromPrice,
                                                                      levelType: widget.levelType,
                                                                      distance: widget.distance,
                                                                      statusApartment: widget.statusApartment,
                                                                      typeProperties: widget.typeProperties,
                                                                      fromDownPayment: widget.fromDownPayment,
                                                                      toDownPayment: widget.toDownPayment,
                                                                      amenitiesType: widget.amenitiesType,
                                                                      bedroom: widget.bedroom,
                                                                      bathroom: widget.bathroom,
                                                                      fromArea: null,
                                                                      toArea: null,
                                                                      furnishedProperties: widget.furnishedProperties,
                                                                      governmentId: widget.governmentId,
                                                                      governmentName: widget.governmentName,
                                                                      cityId: widget.cityId,
                                                                      cityName: widget.cityName,
                                                                      areaId: widget.areaId,
                                                                      areaName: widget.areaName,
                                                                      nameProduct: '',
                                                                      description: '',
                                                                    )));
                                                              },
                                                              child: const Icon(Icons.close_outlined,color: AppPalette.black,size: 25,)),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  5.widthBox,
                                                ],
                                              ),
                                              widget.levelType == null || widget.levelType == '' ?
                                              Container() :
                                              Row(
                                                children: [
                                                  GestureDetector(
                                                    onTap: (){
                                                      Navigator.pushReplacement(context, MaterialPageRoute(
                                                          builder: (context) => FilterScreen(
                                                            governmentId: widget.governmentId,
                                                            governmentName: widget.governmentName,
                                                            cityId: widget.cityId,
                                                            cityName: widget.cityName,
                                                            areaId: widget.areaId,
                                                            locationUser: widget.locationUser,
                                                            toPrice: widget.toPrice,
                                                            fromPrice: widget.fromPrice,
                                                            areaName: widget.areaName,
                                                            fromArea: widget.fromArea,
                                                            toArea: widget.toArea,
                                                            fromDownPayment: widget.fromDownPayment,
                                                            toDownPayment: widget.toDownPayment,
                                                          )));
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(10.0),
                                                          color: AppPalette.lightPrimary),
                                                      padding: EdgeInsets.symmetric(
                                                        vertical: Dimensions.paddingSize,
                                                        horizontal: Dimensions.paddingSizeDefault,
                                                      ),
                                                      // width: 100,
                                                      child: Row(
                                                        children: [
                                                          Text('${LocaleKeys.level.tr()} ${widget.levelType} ',
                                                            overflow: TextOverflow.ellipsis,
                                                            style: AppTextStyles.poppinsLight.copyWith(color: AppPalette.black),),
                                                          GestureDetector(
                                                              onTap: (){
                                                                filterCubit.selectedOptionLevelProperties = [];
                                                                filterCubit.selectedOptionsValueLevelProperties = '';
                                                                Navigator.pushReplacement(context, MaterialPageRoute(
                                                                    builder: (context) =>  FilterResultScreen(
                                                                      categoryId: filterCubit.selectedMainCategory?.id.toString(),
                                                                      categoryName: filterCubit.selectedMainCategory?.name?.en,
                                                                      subCategory: filterCubit.selectedSubCategory?.id.toString(),
                                                                      latitude: widget.latitude,
                                                                      longitude: widget.longitude,
                                                                      locationUser: widget.locationUser,
                                                                      toPrice: widget.toPrice,
                                                                      fromPrice: widget.fromPrice,
                                                                      distance: widget.distance,
                                                                      statusApartment: widget.statusApartment,
                                                                      typeProperties: widget.typeProperties,
                                                                      fromDownPayment: widget.fromDownPayment,
                                                                      toDownPayment: widget.toDownPayment,
                                                                      amenitiesType: widget.amenitiesType,
                                                                      bedroom: widget.bedroom,
                                                                      levelType: '',
                                                                      bathroom: widget.bathroom,
                                                                      fromArea: widget.fromArea,
                                                                      toArea: widget.toArea,
                                                                      furnishedProperties: widget.furnishedProperties,
                                                                      governmentId: widget.governmentId,
                                                                      governmentName: widget.governmentName,
                                                                      cityId: widget.cityId,
                                                                      cityName: widget.cityName,
                                                                      areaId: widget.areaId,
                                                                      areaName: widget.areaName,
                                                                      nameProduct: '',
                                                                      description: '',
                                                                    )));
                                                              },
                                                              child: const Icon(Icons.close_outlined,color: AppPalette.black,size: 25,)),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  5.widthBox,
                                                ],
                                              ),
                                              widget.furnishedProperties == null || widget.furnishedProperties == '' ?
                                              Container() :
                                              Row(
                                                children: [
                                                  GestureDetector(
                                                    onTap: (){
                                                      Navigator.pushReplacement(context, MaterialPageRoute(
                                                          builder: (context) => FilterScreen(
                                                            governmentId: widget.governmentId,
                                                            governmentName: widget.governmentName,
                                                            cityId: widget.cityId,
                                                            cityName: widget.cityName,
                                                            locationUser: widget.locationUser,
                                                            areaId: widget.areaId,
                                                            toPrice: widget.toPrice,
                                                            fromPrice: widget.fromPrice,
                                                            areaName: widget.areaName,
                                                            fromArea: widget.fromArea,
                                                            toArea: widget.toArea,
                                                            fromDownPayment: widget.fromDownPayment,
                                                            toDownPayment: widget.toDownPayment,
                                                          )));
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(10.0),
                                                          color: AppPalette.lightPrimary),
                                                      padding: EdgeInsets.symmetric(
                                                        vertical: Dimensions.paddingSize,
                                                        horizontal: Dimensions.paddingSizeDefault,
                                                      ),
                                                      // width: 100,
                                                      child: Row(
                                                        children: [
                                                          Text('${widget.furnishedProperties}',
                                                            overflow: TextOverflow.ellipsis,
                                                            style: AppTextStyles.poppinsLight.copyWith(color: AppPalette.black),),
                                                          GestureDetector(
                                                              onTap: (){
                                                                filterCubit.selectedOptionFurnishedProperties = [];
                                                                filterCubit.selectedOptionsValueFurnishedProperties = '';
                                                                Navigator.pushReplacement(context, MaterialPageRoute(
                                                                    builder: (context) =>  FilterResultScreen(
                                                                      categoryId: filterCubit.selectedMainCategory?.id.toString(),
                                                                      categoryName: filterCubit.selectedMainCategory?.name?.en,
                                                                      subCategory: filterCubit.selectedSubCategory?.id.toString(),
                                                                      latitude: widget.latitude,
                                                                      locationUser: widget.locationUser,
                                                                      longitude: widget.longitude,
                                                                      toPrice: widget.toPrice,
                                                                      fromPrice: widget.fromPrice,
                                                                      distance: widget.distance,
                                                                      statusApartment: widget.statusApartment,
                                                                      typeProperties: widget.typeProperties,
                                                                      fromDownPayment: widget.fromDownPayment,
                                                                      toDownPayment: widget.toDownPayment,
                                                                      amenitiesType: widget.amenitiesType,
                                                                      bedroom: widget.bedroom,
                                                                      levelType: widget.levelType,
                                                                      bathroom: widget.bathroom,
                                                                      fromArea: widget.fromArea,
                                                                      toArea: widget.toArea,
                                                                      furnishedProperties: '',
                                                                      governmentId: widget.governmentId,
                                                                      governmentName: widget.governmentName,
                                                                      cityId: widget.cityId,
                                                                      cityName: widget.cityName,
                                                                      areaId: widget.areaId,
                                                                      areaName: widget.areaName,
                                                                      nameProduct: '',
                                                                      description: '',
                                                                    )));
                                                              },
                                                              child: const Icon(Icons.close_outlined,color: AppPalette.black,size: 25,)),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  5.widthBox,
                                                ],
                                              ),
                                              widget.typeApartment == null || widget.typeApartment == '' ?
                                              Container() :
                                              Row(
                                                children: [
                                                  GestureDetector(
                                                    onTap: (){
                                                      Navigator.pushReplacement(context, MaterialPageRoute(
                                                          builder: (context) => FilterScreen(
                                                            governmentId: widget.governmentId,
                                                            governmentName: widget.governmentName,
                                                            cityId: widget.cityId,
                                                            cityName: widget.cityName,
                                                            areaId: widget.areaId,
                                                            locationUser: widget.locationUser,
                                                            toPrice: widget.toPrice,
                                                            fromPrice: widget.fromPrice,
                                                            areaName: widget.areaName,
                                                            fromArea: widget.fromArea,
                                                            toArea: widget.toArea,
                                                            fromDownPayment: widget.fromDownPayment,
                                                            toDownPayment: widget.toDownPayment,
                                                          )));
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(10.0),
                                                          color: AppPalette.lightPrimary),
                                                      padding: EdgeInsets.symmetric(
                                                        vertical: Dimensions.paddingSize,
                                                        horizontal: Dimensions.paddingSizeDefault,
                                                      ),
                                                      // width: 100,
                                                      child: Row(
                                                        children: [
                                                          Text('${widget.typeApartment}',
                                                            overflow: TextOverflow.ellipsis,
                                                            style: AppTextStyles.poppinsLight.copyWith(color: AppPalette.black),),
                                                          GestureDetector(
                                                              onTap: (){
                                                                filterCubit.selectedOptionTypeApartmentProperties = [];
                                                                filterCubit.selectedOptionsValueTypeApartmentProperties = '';
                                                                Navigator.pushReplacement(context, MaterialPageRoute(
                                                                    builder: (context) =>  FilterResultScreen(
                                                                      categoryId: filterCubit.selectedMainCategory?.id.toString(),
                                                                      categoryName: filterCubit.selectedMainCategory?.name?.en,
                                                                      subCategory: filterCubit.selectedSubCategory?.id.toString(),
                                                                      latitude: widget.latitude,
                                                                      locationUser: widget.locationUser,
                                                                      longitude: widget.longitude,
                                                                      toPrice: widget.toPrice,
                                                                      fromPrice: widget.fromPrice,
                                                                      distance: widget.distance,
                                                                      typeApartment: '',
                                                                      typeProperties: widget.typeProperties,
                                                                      fromDownPayment: widget.fromDownPayment,
                                                                      toDownPayment: widget.toDownPayment,
                                                                      amenitiesType: widget.amenitiesType,
                                                                      bedroom: widget.bedroom,
                                                                      levelType: widget.levelType,
                                                                      bathroom: widget.bathroom,
                                                                      fromArea: widget.fromArea,
                                                                      toArea: widget.toArea,
                                                                      furnishedProperties: widget.furnishedProperties,
                                                                      governmentId: widget.governmentId,
                                                                      governmentName: widget.governmentName,
                                                                      cityId: widget.cityId,
                                                                      cityName: widget.cityName,
                                                                      areaId: widget.areaId,
                                                                      areaName: widget.areaName,
                                                                      nameProduct: '',
                                                                      description: '',
                                                                    )));
                                                              },
                                                              child: const Icon(Icons.close_outlined,color: AppPalette.black,size: 25,)),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  5.widthBox,
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  10.heightBox,
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(LocaleKeys.showingResults.tr(),
                                          style: AppTextStyles.poppinsRegular
                                              .copyWith(color: AppPalette.black)),
                                      Text(" ${filterCubit.myProductUserResponseModel?.length == null ? '' :
                                      filterCubit.myProductUserResponseModel?.length} ",
                                          style: AppTextStyles.poppinsRegular),
                                      Expanded(
                                        child: Text( context.locale.languageCode.contains('en') ?
                                        filterCubit.selectedMainCategory!.name!.en! :
                                        context.locale.languageCode.contains('ar') ?
                                        filterCubit.selectedMainCategory!.name!.ar! :
                                        context.locale.languageCode.contains('tr') ?
                                        filterCubit.selectedMainCategory!.name!.tr! :
                                        context.locale.languageCode.contains('de') ?
                                        filterCubit.selectedMainCategory!.name!.de! : '',
                                            overflow: TextOverflow.ellipsis,
                                            style: AppTextStyles.poppinsRegular
                                                .copyWith(color: AppPalette.black)),
                                      ),
                                      const Spacer(),
                                      InkWell(
                                        onTap: appUICubit.toggleView,
                                        child: Icon(
                                            appUICubit.isGrid
                                                ? Icons.list_sharp
                                                : Icons.grid_view_sharp,
                                            color: AppPalette.black),
                                      ),
                                    ],
                                  ),
                                  10.heightBox,
                                  filterState is FilterSuccessState?
                                  filterCubit.myProductUserResponseModel != null ?
                                  filterCubit.myProductUserResponseModel!.isNotEmpty ?
                                  appUICubit.isGrid
                                      ? GridView.builder(
                                      shrinkWrap: true,
                                      physics: const BouncingScrollPhysics(),
                                      padding: EdgeInsets.symmetric(vertical: 20.h),
                                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                                        maxCrossAxisExtent: 200.0,
                                        mainAxisSpacing: 5.0.h,
                                        crossAxisSpacing: 15.0.w,
                                        childAspectRatio: 1 / 1.69,
                                      ),
                                      itemCount: filterCubit.myProductUserResponseModel!.length,
                                      // itemBuilder: (context, index) => Container(
                                      //   color: Colors.red,
                                      // ),
                                      itemBuilder: (context, index){
                                        return FilterProductItem(
                                          product: filterCubit.myProductUserResponseModel![index],
                                        );
                                      }
                                  )
                                      : ListView.separated(
                                    shrinkWrap: true,
                                    physics: const BouncingScrollPhysics(),
                                    padding: EdgeInsets.symmetric(vertical: 20.h),
                                    itemCount: filterCubit.myProductUserResponseModel!.length,
                                    // itemExtent: 200.0,
                                    itemBuilder: (context, index) =>
                                        FilterProductListItem(product: filterCubit.myProductUserResponseModel![index]),
                                    separatorBuilder: (context, index) => 10.0.heightBox,
                                  ) :
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      // Padding(
                                      //   padding: EdgeInsets.symmetric(
                                      //     horizontal: Dimensions.paddingSizeDefault,
                                      //   ),
                                      //   child: Row(
                                      //     mainAxisAlignment:
                                      //     MainAxisAlignment.spaceBetween,
                                      //     crossAxisAlignment: CrossAxisAlignment.start,
                                      //     children: [
                                      //       Text(
                                      //         LocaleKeys.newRecommendations.tr(),
                                      //         style:
                                      //         Theme.of(context).textTheme.headline3,
                                      //       ),
                                      //     ],
                                      //   ),
                                      // ),
                                      35.heightBox,
                                      Center(
                                        child: SvgPicture.asset(
                                            "assets/images/svg/addProduct.svg",
                                            height: 150,
                                            width: 150,
                                            fit: BoxFit.contain),
                                      ),
                                    ],
                                  ) :
                                  filterState is FilterErrorState ?
                                 ErrorScreenConnection(
                                   onPressed: () {
                                   //  print('selected');
                                     Navigator.of(context).pop();
                                   },
                                 ) :
                                  ErrorScreenConnection(
                                     onPressed: () {
                                     //  print('selecteddd');
                                       Navigator.of(context).pop();
                                     },
                                  ) :   const Center(
                                      child: CircularProgressIndicator(color: AppPalette.primary,)),

                                ],
                              ),
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
        },
      ),
    );
  }
}
