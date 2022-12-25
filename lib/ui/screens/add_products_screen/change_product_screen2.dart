// ignore_for_file: prefer_typing_uninitialized_variables, prefer_if_null_operators, must_be_immutable, deprecated_member_use

import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shop/business_logic/my_products_cubit/my_products_cubit.dart';
import 'package:shop/business_logic/my_products_cubit/my_products_state.dart';
import 'package:shop/data/internet_connectivity/error_screens_connection.dart';
import 'package:shop/data/internet_connectivity/no_internet.dart';
import 'package:shop/data/models/MyProductUserModel.dart';
import 'package:shop/helpers/app_local_storage.dart';
import 'package:shop/translations/locale_keys.g.dart';
import 'package:shop/ui/base/custom_button.dart';
import 'package:shop/ui/base/custom_toast.dart';
import 'package:shop/ui/screens/add_products_screen/changes_product_all_category_screens/choose_status_books_screen.dart';
import 'package:shop/ui/screens/add_products_screen/changes_product_all_category_screens/choose_transmission_screen.dart';
import 'package:shop/ui/screens/add_products_screen/changes_product_all_category_screens/choose_warranty_screen.dart';
import 'package:shop/ui/screens/add_products_screen/changes_product_properties_screens/choose_status_apartment_type_screen.dart';
import 'package:shop/ui/screens/edit_images_product_screen/edit_images_product_screen.dart';
import 'package:shop/ui/widgets/My_products_widgets/add_product_widgets/custom_button_widget.dart';
import 'package:shop/ui/widgets/My_products_widgets/add_product_widgets/input_text_form_field.dart';
import 'package:shop/ui/widgets/My_products_widgets/add_product_widgets/update_images_section_widget.dart';
import 'package:shop/utils/app_palette.dart';
import 'package:shop/utils/app_size_boxes.dart';
import 'package:shop/utils/dimensions.dart';
import 'package:translator/translator.dart';

import '../../../business_logic/app_layout_cubit/app_layout_cubit.dart';
import '../../../business_logic/categories_cubit/categories_cubit.dart';
import '../../../business_logic/locations_cubit/locations_cubit.dart';
import '../../../business_logic/product_details_cubit/product_details_cubit.dart';
import '../../../data/models/product_model.dart';
import '../../../data/models/show_details_product_model.dart';
import '../../../helpers/components.dart';
import '../../../utils/LoadingWidget.dart';
import '../../../utils/styles.dart';
import '../layout/app_layout.dart';
import 'changes_product_all_category_screens/choose_condition_screen.dart';
import 'changes_product_all_category_screens/choose_fashions_screen.dart';
import 'changes_product_all_category_screens/choose_furnished_screen.dart';
import 'changes_product_all_category_screens/choose_status_bussniess_screen.dart';
import 'changes_product_all_category_screens/choose_status_home_furnature_screen.dart';
import 'changes_product_all_category_screens/choose_status_kids_screen.dart';
import 'changes_product_properties_screens/choose_apertment_type_screen.dart';
import 'choose_amenities_screen/choose_amenities_screen.dart';
import 'choose_body_type_screen/choose_body_type_screen.dart';
import 'choose_categories_screens/choose_area_product_screen.dart';
import 'choose_categories_screens/choose_city_product_screen.dart';
import 'choose_categories_screens/choose_government_product_screen.dart';
import 'choose_categories_screens/choose_one_brand_change_screen.dart';
import 'choose_color_screen/choose_color_screen.dart';
import 'choose_engine_capacity_screen/choose_engine_capacity_screen.dart';
import 'choose_fuel_type_screen/choose_fuel_type_screen.dart';
import 'choose_level_screen/choose_level_screen.dart';

class ChangeProductScreen2 extends StatefulWidget {
  final ProductModel? product;
  final int? productId;
  ChangeProductScreen2(
      {Key? key, this.governmentId, this.governmentName, this.cityId, this.cityName,this.whatsAppNumber,this.furnishedType,
        this.fuelTypeAr,this.bodyTypeAr,this.engineCapacityTypeAr,this.amenitiesTypeAr,this.colorTypeAr,
        this.areaId, this.areaName, this.locationUser, this.nameProduct, this.fromPrice, this.toPrice, this.description,
        this.fuelType,this.bodyType,this.amenitiesType,this.colorType,this.engineCapacityType,this.kiloMetresType,
        this.levelType,this.year,this.bedroom,this.data,this.typeApartment,this.statusApartment,this.typeFashion,
        this.typeHomeFurniture,this.typeBooks,this.typeKids,this.typeBusiness,this.warrantyElectronic,this.transmissionVehicles,
        this.bathroom,this.downPayment,this.area,this.product,this.typeCondtion,this.typeWarrannt,this.productId})
      : super(key: key);

  String? governmentId, governmentName,data,typeCondtion,typeWarrannt,furnishedType;
  String? cityId, cityName,bedroom,bathroom,typeApartment,statusApartment,typeFashion,typeHomeFurniture,
      typeBooks,typeKids,typeBusiness,warrantyElectronic,transmissionVehicles;
  String? areaId, areaName,year,area,downPayment,whatsAppNumber;
  String? locationUser,fuelTypeAr,fuelType,amenitiesTypeAr,amenitiesType,
      bodyTypeAr,bodyType,colorTypeAr,colorType,engineCapacityTypeAr,engineCapacityType,kiloMetresType,levelType;
  String? fromPrice, toPrice, nameProduct, description;

  @override
  State<ChangeProductScreen2> createState() => _ChangeProductScreen2State();
}

class _ChangeProductScreen2State extends State<ChangeProductScreen2> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController nameOfProductController = TextEditingController();
  TextEditingController oldPriceController = TextEditingController();
  TextEditingController locationUserController = TextEditingController();
  TextEditingController newPriceController = TextEditingController();
  TextEditingController whatsAppController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController downPaymentController = TextEditingController();
  TextEditingController areaPropertiesController = TextEditingController();
  TextEditingController yearOfProductController = TextEditingController();
  TextEditingController kiloMetresOfProductController = TextEditingController();
  TextEditingController bedroomOfProductController = TextEditingController();
  TextEditingController bathroomOfProductController = TextEditingController();

  late String locationUser;
  late String locationUserNew;
  late String statusUser;
  late String statusUser2;
  late String warrantyTypeProduct;
  late String warrantyType;
  late String warrantyTypeAr;
  late String optionValueList;

  late String categoryId;
  late String apartmentTypeProduct;
  late String apartmentType;
  late String apartmentTypeAr;
  late String statusApartmentTypeProduct;
  late String statusApartmentType;
  late String statusApartmentTypeAr;
  late String furnishedTypeProduct;
  late String furnishedType;
  late String furnishedTypeAr;
  late String homeFurnitureTypeProduct;
  late String homeFurnitureType;
  late String homeFurnitureTypeAr;
  late String homeFashionTypeProduct;
  late String homeFashionType;
  late String homeFashionTypeAr;
  late String kidsTypeProduct;
  late String kidsType;
  late String kidsTypeAr;
  late String businessTypeProduct;
  late String businessType;
  late String businessTypeAr;
  late String booksTypeProduct;
  late String booksType;
  late String booksTypeAr;
  String? statusProduct;
  String? governmentId;
  String? cityId;
  String? areaId;
  String? oldPrice;
  var areaNameProduct, cityNameProduct,governmentNameProduct,locationProduct,locationList;
  bool? statusProductChoose = false;

  // vehicles
  late String transmissionTypeProduct;
  late String transmissionType;
  late String transmissionTypeAr;
  late String optionValueFuelTypeProduct;
  late String optionValueFuelType;
  late String optionValueFuelTypeAr;
  late String optionValueYear;
  late String optionValueKiloMeter;
  late String optionValueTransmissionTypeProduct;
  late String optionValueTransmissionType;
  late String optionValueTransmissionTypeAr;
  late String optionConditionStatus;
  late String optionValueColorProduct;
  late String optionValueColor;
  late String optionValueColorAr;
  late String optionValueBodyTypeProduct;
  late String optionValueBodyType;
  late String optionValueBodyTypeAr;
  late String optionValueEngineCapacityProduct;
  late String optionValueEngineCapacity;
  late String optionValueEngineCapacityAr;
  late String optionValueNameModel;

  // properties
  late String optionValueAmenitiesProduct;
  late String optionValueAmenities;
  late String optionValueAmenitiesAr;
  late String optionValueLevel;

  List<String>? conditionItems;
  String? selectedConditionItems;

  List<String>? warrantyItems;
  String? selectedWarrantyItems;

  LocationPermission? permission;
  String lanAddress = "";
  String latAddress = "";

  // final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  //
  // void showInSnackBar(String value) {
  //   _scaffoldKey.currentState!.showSnackBar(new SnackBar(content: new Text(value)));
  // }
  //
  Future<Position?> determinePosition() async {

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        return Future.error('Location Not Available');
      }
    }
    return _getCurrentLocation();
  }

  Future<Position?> _getCurrentLocation() async {

    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      _getAddressFromLatLng(position.latitude, position.longitude);
    }).catchError((e) {
      print(e);
    });
  }

  _getAddressFromLatLng(double latitude, double longitude) async {
    try {
      List<Placemark> p = await placemarkFromCoordinates(latitude, longitude);

      Placemark place = p[0];

      latAddress = "$latitude";
      lanAddress = "$longitude";
      print('latAddress');
      print(latAddress);
      print(lanAddress);
    } catch (e) {
      print(e);
    }
  }

  // clearItemProduct(){
  //   nameOfProductController.clear();
  //   productDetailsCubit.oldPriceController.clear();
  //   productDetailsCubit.newPriceController.clear();
  //   productDetailsCubit.descriptionController.clear();
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // BlocProvider.of<AppLayoutCubit>(context).checkConnectionInternet();
    // BlocProvider.of<AppLayoutCubit>(context).checkUserConnection();

    // if(widget.governmentId != null){
    //   print('governmentId equal null');
    //   BlocProvider.of<LocationsCubit>(context).getCityOfGovernment('${widget.governmentId}');
    // }else {
    //   print('governmentId equal null');
    //   null;
    // }
    //
    //
    // if(widget.cityId != null){
    //   print('cityId equal null');
    //   BlocProvider.of<LocationsCubit>(context).getAreaOfCity('${widget.cityId}');
    // }else {
    //   print('governmentId equal null');
    //   null;
    // }



    //   CustomFlutterToast(widget.downPayment);
    //  print('product id sss ${widget.productId}');
    //  if(widget.productId != null){
    //    BlocProvider.of<ProductDetailsCubit>(context).getProductDetailsUser('${widget.productId}');
    //  }else {
    //    null;
    //  }


    conditionItems = [];
    if(AppLocalStorage.language!.contains('en')){
      conditionItems = [
        'new',
        'used',
      ];
    }else if (AppLocalStorage.language!.contains('ar')){
      conditionItems = [
        'جديد',
        'مستعمل',
      ];
    }

    warrantyItems = [];
    if(AppLocalStorage.language!.contains('en')){
      warrantyItems = [
        'yes',
        'no',
      ];
    }else if (AppLocalStorage.language!.contains('ar')){
      warrantyItems = [
        'نعم',
        'لا',
      ];
    }

  }

  final FocusNode _firstNameFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    final stateLocation = context.watch<LocationsCubit>().state;
    //final stateConnectionInternet = context.watch<AppLayoutCubit>().state;
    return WillPopScope(
      onWillPop: () async {
        AddProductCubit addProductController = AddProductCubit.get(context);
        // addProductController.selectedBrand!.brandName = null;
        if(context.locale.languageCode.contains('en')){
          addProductController.selectedBrand?.brandName = null ;
        }else if(context.locale.languageCode.contains('ar')){
          addProductController.selectedBrand?.brandName?.ar = '';
        }
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => AppLayout()));
        return false;
      },
      child:
      BlocConsumer<AddProductCubit, AddProductState>(
        listener: (context, AddProductState) {},
        builder: (context, addProductState) {
          AddProductCubit addProductController = AddProductCubit.get(context);
          return  BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
            builder: (context, state) {
              ProductDetailsCubit productDetailsCubit = ProductDetailsCubit.get(context);
              if (state is SuccessProductDetailsState) {

                print('reBuild screen');
                if(state.showDetailsProductResponseModel![0].status == 0){
                  selectedConditionItems = LocaleKeys.used.tr();

                }else  if(state.showDetailsProductResponseModel![0].status == 1){
                  selectedConditionItems = LocaleKeys.newProd.tr();
                }

                // if(widget.typeCondtion == null){
                //   if(state.showDetailsProductResponseModel![0].status == 0){
                //     selectedConditionItems = '0';
                //   }else if(state.showDetailsProductResponseModel![0].status == 1){
                //     selectedConditionItems = '1';
                //   }
                //
                // }else{
                //   if(widget.typeCondtion == 'جديد' || widget.typeCondtion == 'New'){
                //     selectedConditionItems = '1';
                //   }else if(widget.typeCondtion == 'مستعمل' || widget.typeCondtion == 'Used'){
                //     selectedConditionItems = '0';
                //   }
                // }

                productDetailsCubit.nameOfProductController.text =
                widget.nameProduct == null ?
                '${state.showDetailsProductResponseModel![0].name}' : '${widget.nameProduct}';

                productDetailsCubit.locationUserController.text =
                widget.locationUser == null ?
                '${state.showDetailsProductResponseModel![0].location}' : '${widget.locationUser}';


                productDetailsCubit.whatsAppController.text =
                widget.whatsAppNumber == null ?
                '${state.showDetailsProductResponseModel![0].whatsNumber == null ? '' :
                state.showDetailsProductResponseModel![0].whatsNumber}' : '${widget.whatsAppNumber}';

                productDetailsCubit.oldPriceController.text =
                widget.fromPrice == null ?
                '${state.showDetailsProductResponseModel![0].oldPrice}' :  '${widget.fromPrice}';

                productDetailsCubit.newPriceController.text =
                widget.toPrice == null ?
                '${state.showDetailsProductResponseModel![0].price}' :  '${widget.toPrice}';

                productDetailsCubit.descriptionController.text =
                widget.description == null ?
                '${state.showDetailsProductResponseModel![0].description}' :'${widget.description}';


                // productDetailsCubit.nameOfProductController.text = state.showDetailsProductResponseModel![0].name ?? '';
                // productDetailsCubit.locationUserController.text = '${state.showDetailsProductResponseModel![0].location}';
                // productDetailsCubit.oldPriceController.text =  '${state.showDetailsProductResponseModel![0].oldPrice}' ;
                // productDetailsCubit.newPriceController.text = '${state.showDetailsProductResponseModel![0].price}';
                // productDetailsCubit.descriptionController.text = '${state.showDetailsProductResponseModel![0].description}';


                if(state.showDetailsProductResponseModel![0].category!.name!.en!.contains('Vehicles')){

                  if(widget.year == null){
                    if(state.showDetailsProductResponseModel![0].options!.length > 1){
                      if(state.showDetailsProductResponseModel![0].options![1].value!.contains('null')){
                        productDetailsCubit.yearOfProductController.text = '';
                      }else {
                        productDetailsCubit.yearOfProductController.text =
                        '${state.showDetailsProductResponseModel![0].options![1].value}';
                      }

                    }else {
                      productDetailsCubit.yearOfProductController.text = '';
                    }

                  }else {
                    productDetailsCubit.yearOfProductController.text = '${widget.year}';
                  }

                  if(widget.kiloMetresType == null){
                    if(state.showDetailsProductResponseModel![0].options!.length > 1){
                      if(state.showDetailsProductResponseModel![0].options![2].value!.contains('null')){
                        productDetailsCubit.kiloMetresOfProductController.text = '';
                      }else {
                        productDetailsCubit.kiloMetresOfProductController.text =
                        '${state.showDetailsProductResponseModel![0].options![2].value}';
                      }

                    }else {
                      productDetailsCubit.kiloMetresOfProductController.text = '';
                    }

                  }else {
                    productDetailsCubit.kiloMetresOfProductController.text = '${widget.kiloMetresType}';
                  }


                }

                if(state.showDetailsProductResponseModel![0].category!.name!.en!.contains('Properties')){

                  // if(state.showDetailsProductResponseModel![0].options!.isNotEmpty){
                  //   yearOfProductController.text =
                  //   state.showDetailsProductResponseModel![0].options![1].value != ' null' ?
                  //   '${state.showDetailsProductResponseModel![0].options![1].value}' :
                  //   LocaleKeys.year.tr();
                  //
                  //   optionValueAmenities =  widget.amenitiesType == null ?
                  //   '${state.showDetailsProductResponseModel![0].options![2].value}' :
                  //   '${widget.amenitiesType}';
                  //
                  //   optionValueLevel =  widget.levelType == null ?
                  //   '${state.showDetailsProductResponseModel![0].options![6].value!.contains('null') ?
                  //   '' : state.showDetailsProductResponseModel![0].options![6].value}' :
                  //   '${widget.levelType}';
                  //
                  // }


                  //// downPaymentController
                  if(widget.downPayment == null){
                    if(state.showDetailsProductResponseModel![0].options!.length > 2){
                      if(state.showDetailsProductResponseModel![0].options![1].value!.contains('null')){
                        productDetailsCubit.downPaymentController.text = '';
                      }else {
                        productDetailsCubit.downPaymentController.text =
                        '${state.showDetailsProductResponseModel![0].options![3].value}';
                      }

                    }else {
                      productDetailsCubit.downPaymentController.text = '';
                    }
                  }else if(widget.downPayment != null){
                    productDetailsCubit.downPaymentController.text = '${widget.downPayment}';
                  }

                  //// bedroomOfProductController
                  if(widget.bedroom == null){
                    if(state.showDetailsProductResponseModel![0].options!.length > 4){
                      if(state.showDetailsProductResponseModel![0].options![3].value!.contains('null')){
                        productDetailsCubit.bedroomOfProductController.text = '';
                      }else {
                        productDetailsCubit.bedroomOfProductController.text =
                        '${state.showDetailsProductResponseModel![0].options![3].value}';
                      }

                    }else {
                      productDetailsCubit.bedroomOfProductController.text = '';
                    }
                  }else  if(widget.bedroom != null){
                    productDetailsCubit.bedroomOfProductController.text = '${widget.bedroom}';
                  }

                  //// bathroomOfProductController
                  if(widget.bathroom == null){
                    if(state.showDetailsProductResponseModel![0].options!.length > 5){
                      if(state.showDetailsProductResponseModel![0].options![4].value!.contains('null')){
                        productDetailsCubit.bathroomOfProductController.text = '';
                      }else {
                        productDetailsCubit.bathroomOfProductController.text =
                        '${state.showDetailsProductResponseModel![0].options![4].value}';
                      }

                    }else {
                      productDetailsCubit.bathroomOfProductController.text = '';
                    }
                  }else  if(widget.bathroom != null){
                    productDetailsCubit.bathroomOfProductController.text = '${widget.bathroom}';
                  }

                  //// areaPropertiesController
                  if(widget.area == null){
                    if(state.showDetailsProductResponseModel![0].options!.length > 6){
                      if(state.showDetailsProductResponseModel![0].options![5].value!.contains('null')){
                        productDetailsCubit.areaPropertiesController.text = '';
                      }else {
                        productDetailsCubit.areaPropertiesController.text =
                        '${state.showDetailsProductResponseModel![0].options![5].value}';
                      }

                    }else {
                      productDetailsCubit.areaPropertiesController.text = '';
                    }

                  }
                }else  if(widget.area != null){
                  productDetailsCubit.areaPropertiesController.text = '${widget.area}';
                }

                return Scaffold(
                  backgroundColor: AppPalette.primary,
                  // appBar: AppBar(
                  //   title: Text('${productDetailsCubit.showDetailsProductResponseModel![0].name}'),
                  //   elevation: 0.0,
                  //   leading: InkWell(
                  //     onTap: () {
                  //       AddProductCubit addProductController = AddProductCubit.get(context);
                  //       // addProductController.selectedBrand!.brandName = null;
                  //       if(context.locale.languageCode.contains('en')){
                  //         addProductController.selectedBrand?.brandName = null ;
                  //       }else if(context.locale.languageCode.contains('ar')){
                  //         addProductController.selectedBrand?.brandName?.ar = '';
                  //       }
                  //       Navigator.of(context).push(MaterialPageRoute(builder: (context) => AppLayout()));
                  //     },
                  //
                  //     child: const Icon(Icons.arrow_back_ios,
                  //         size: 20.0, color: AppPalette.black),
                  //   ),
                  // ),
                  body: SafeArea(
                    child: Column(
                      children: [
                        25.heightBox,
                        Padding(
                          padding:  EdgeInsets.symmetric(horizontal: 15.h),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                        AddProductCubit addProductController = AddProductCubit.get(context);
                                        // addProductController.selectedBrand!.brandName = null;
                                        if(context.locale.languageCode.contains('en')){
                                          addProductController.selectedBrand?.brandName = null ;
                                        }else if(context.locale.languageCode.contains('ar')){
                                          addProductController.selectedBrand?.brandName?.ar = '';
                                        }
                                        navigateReplaceTo(context: context, widget: AppLayout());

                                },
                                child: Icon(Icons.arrow_back_ios,color: AppPalette.white,size: 25.sp,),
                              ),
                              Expanded(
                                child: Center(
                                  child: AutoSizeText(
                                    '${productDetailsCubit.showDetailsProductResponseModel![0].name}',
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
                        25.heightBox,
                        Expanded(
                          child: Container(
                              decoration: const BoxDecoration(
                                color: AppPalette.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(25),
                                    topRight: Radius.circular(25))),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: ListView(
                                    shrinkWrap: true,
                                    physics: const BouncingScrollPhysics(),
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(
                                          top: Dimensions.paddingSizeDefault,
                                          right: Dimensions.paddingSizeDefault,
                                          left: Dimensions.paddingSizeDefault,
                                        ),
                                        child: Form(
                                          key: _formKey,
                                          child: ListView(
                                            shrinkWrap: true,
                                            physics: const ScrollPhysics(),
                                            children: [
                                              heightSeperator(10.h),
                                              Padding(
                                                padding:  EdgeInsets.symmetric(horizontal: 15.w),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    CustomButton(
                                                      height: 60,
                                                      width: 60,
                                                      icon: Icons.add_a_photo_rounded,
                                                      onPressed: () async{
                                                        Navigator.of(context).push(MaterialPageRoute(
                                                            builder: (context) => EditImagesProductScreen(
                                                              productId: widget.product?.id,
                                                              productModel: state.showDetailsProductResponseModel![0],
                                                              productName: widget.product?.name, product: widget.product,)));
                                                      },
                                                      buttonText: '',
                                                    ),
                                                    widthSeparator(10.w),
                                                    Text(
                                                      LocaleKeys.editImageAds.tr(),
                                                      style: TextStyle(
                                                        color: AppPalette.black,
                                                        fontFamily: Fonts.poppins,
                                                        fontWeight: FontWeight.w300,
                                                        fontSize: Dimensions.fontSizeLarge,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              heightSeperator(10.h),
                                              Divider(
                                                height: 5,
                                                color: AppPalette.black,
                                              ),
                                              heightSeperator(15.h),
                                              CustomButtonWidget(
                                                title: '${state.showDetailsProductResponseModel![0].category?.name != null ?
                                                context.locale.languageCode.contains('en') ?
                                                state.showDetailsProductResponseModel![0].category?.name?.en :
                                                context.locale.languageCode.contains('ar') ?
                                                state.showDetailsProductResponseModel![0].category?.name?.ar! :
                                                context.locale.languageCode.contains('tr') ?
                                                state.showDetailsProductResponseModel![0].category?.name?.tr! :
                                                context.locale.languageCode.contains('de') ?
                                                state.showDetailsProductResponseModel![0].category?.name?.de! :
                                                LocaleKeys.category.tr() : LocaleKeys.category.tr()}',
                                                onTap: () {},
                                              ),
                                              15.heightBox,
                                              CustomButtonWidget(
                                                  title: '${state.showDetailsProductResponseModel![0].subcategory?.name != null ?
                                                  context.locale.languageCode.contains('en') ?
                                                  state.showDetailsProductResponseModel![0].subcategory?.name?.en :
                                                  context.locale.languageCode.contains('ar') ?
                                                  state.showDetailsProductResponseModel![0].subcategory?.name?.ar! :
                                                  context.locale.languageCode.contains('tr') ?
                                                  state.showDetailsProductResponseModel![0].subcategory?.name?.tr! :
                                                  context.locale.languageCode.contains('de') ?
                                                  state.showDetailsProductResponseModel![0].subcategory?.name?.de! :
                                                  LocaleKeys.subCategory.tr() : LocaleKeys.subCategory.tr()}',
                                                  onTap: () {}),
                                              15.heightBox,
                                              InputTextFormField(
                                                hintText: LocaleKeys.nameOfProduct.tr(),
                                                textEditingController: productDetailsCubit.nameOfProductController,
                                                focusNode: _firstNameFocus,
                                                validator: (val) {
                                                  if (val.isEmpty) {
                                                    return LocaleKeys.mustNotEmpty.tr();
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                              ),
                                              15.heightBox,
                                              InputTextFormField(
                                                hintText: LocaleKeys.oldPrice.tr(),
                                                textEditingController: productDetailsCubit.oldPriceController,
                                                textInputType: TextInputType.number,
                                                suffixIcon: Container(
                                                  width: 100,
                                                  padding: EdgeInsets.all(
                                                    Dimensions.paddingSize,
                                                  ),
                                                  child:  Row(
                                                    children: [
                                                      Text('(${LocaleKeys.oldPriceText.tr()} ) ',
                                                          style: const TextStyle(
                                                              color: AppPalette.black,
                                                              fontWeight: FontWeight.w500)),
                                                      Text(LocaleKeys.currencyPrice.tr())
                                                    ],
                                                  ),),
                                                validator: (val) {
                                                  // if (val.isEmpty) {
                                                  //   return "enter price";
                                                  // }
                                                },
                                              ),
                                              15.heightBox,
                                              InputTextFormField(
                                                hintText: LocaleKeys.newPrice.tr(),
                                                textEditingController: productDetailsCubit.newPriceController,
                                                textInputType: TextInputType.number,
                                                suffixIcon: Container(
                                                  width: 100,
                                                  padding: EdgeInsets.all(
                                                    Dimensions.paddingSize,
                                                  ),
                                                  child:  Row(
                                                    children: [
                                                      Text('(${LocaleKeys.newPriceText.tr()} ) ',
                                                          style: const TextStyle(
                                                              color: AppPalette.black,
                                                              fontWeight: FontWeight.w500)),
                                                      Text(LocaleKeys.currencyPrice.tr())
                                                    ],
                                                  ),),
                                                validator: (val) {
                                                  if (val.isEmpty) {
                                                    return LocaleKeys.mustNotEmpty.tr();
                                                  }
                                                },
                                              ),
                                              15.heightBox,
                                              InputTextFormField(
                                                hintText: LocaleKeys.whatsAppNumber.tr(),
                                                textEditingController: productDetailsCubit.whatsAppController,
                                                textInputType: TextInputType.number,
                                                maxLength: 15,
                                                // suffixIcon: Container(
                                                //     padding: EdgeInsets.all(
                                                //       Dimensions.paddingSize,
                                                //     ),
                                                //     child: Text(LocaleKeys.currencyPrice.tr())),
                                                validator: (val) {
                                                  // if (val.length < 7) {
                                                  //   return LocaleKeys.enter_a_valid_phone.tr();
                                                  // } else {
                                                  //   return null;
                                                  // }
                                                },
                                              ),
                                              15.heightBox,
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child:  CustomButtonWidget(
                                                        title: widget.governmentName == null
                                                            ? '${state.showDetailsProductResponseModel![0].countryModel?.name}'
                                                            : '${widget.governmentName}',
                                                        onTap: () {
                                                          Navigator.of(context).push(
                                                              MaterialPageRoute(
                                                                  builder: (context) =>
                                                                      ChooseGovernmentProductScreen(
                                                                        data: 'changeProductScreen',
                                                                        governmentId: widget
                                                                            .governmentId,
                                                                        governmentName: widget
                                                                            .governmentName,
                                                                        cityId: widget.cityId,
                                                                        whatsAppNumber: productDetailsCubit.whatsAppController.text,
                                                                        year: productDetailsCubit.yearOfProductController.text,
                                                                        downPayment: productDetailsCubit.downPaymentController.text,
                                                                        area: productDetailsCubit.areaPropertiesController.text,
                                                                        bathroom: productDetailsCubit.bathroomOfProductController.text,
                                                                        bedroom: productDetailsCubit.bedroomOfProductController.text,
                                                                        cityName: widget.cityName,
                                                                        areaId: widget.areaId,
                                                                        typeApartment: widget.typeApartment,
                                                                        transmissionVehicles: widget.transmissionVehicles,
                                                                        statusApartment: widget.statusApartment,
                                                                        typeBooks: widget.typeBooks,
                                                                        typeWarrannt: widget.typeWarrannt,
                                                                        typeBusiness: widget.typeBusiness,
                                                                        warrantyElectronic: widget.typeWarrannt,
                                                                        typeCondtion: widget.typeCondtion,
                                                                        typeKids: widget.typeKids,
                                                                        typeFashion: widget.typeFashion,
                                                                        typeHomeFurniture: widget.typeHomeFurniture,
                                                                        areaName: widget.areaName,
                                                                        toPrice: productDetailsCubit.newPriceController.text,
                                                                        fromPrice: productDetailsCubit.oldPriceController.text,
                                                                        levelType: widget.levelType,
                                                                        kiloMetresType: productDetailsCubit.kiloMetresOfProductController.text,
                                                                        amenitiesType: widget.amenitiesType,
                                                                        fuelType: widget.fuelType,
                                                                        engineCapacityType: widget.engineCapacityType,
                                                                        colorType: widget.colorType,
                                                                        bodyType: widget.bodyType,
                                                                        nameProduct: productDetailsCubit.nameOfProductController.text,
                                                                        description: productDetailsCubit.descriptionController.text,
                                                                        locationUser: productDetailsCubit.locationUserController.text,)
                                                              ));
                                                        }),
                                                  ),
                                                  7.widthBox,
                                                  Expanded(
                                                    child: CustomButtonWidget(
                                                        title: widget.cityName == null
                                                            ? '${state.showDetailsProductResponseModel![0].stateModel?.name}'
                                                            : '${widget.cityName}',
                                                        onTap: () {
                                                          if(widget.governmentId != null){
                                                            print('governmentId is null');
                                                            Navigator.of(context).push(
                                                                MaterialPageRoute(
                                                                  builder: (context) =>
                                                                      ChooseCityProductScreen(
                                                                        data: 'changeProductScreen',
                                                                        governmentId: widget
                                                                            .governmentId,
                                                                        governmentName: widget
                                                                            .governmentName,
                                                                        cityId: widget.cityId,
                                                                        typeApartment: widget.typeApartment,
                                                                        transmissionVehicles: widget.transmissionVehicles,
                                                                        statusApartment: widget.statusApartment,
                                                                        typeBooks: widget.typeBooks,
                                                                        typeWarrannt: widget.typeWarrannt,
                                                                        typeBusiness: widget.typeBusiness,
                                                                        warrantyElectronic: widget.typeWarrannt,
                                                                        typeCondtion: widget.typeCondtion,
                                                                        typeKids: widget.typeKids,
                                                                        typeFashion: widget.typeFashion,
                                                                        typeHomeFurniture: widget.typeHomeFurniture,
                                                                        whatsAppNumber: productDetailsCubit.whatsAppController.text,
                                                                        year: productDetailsCubit.yearOfProductController.text,
                                                                        downPayment: productDetailsCubit.downPaymentController.text,
                                                                        area: productDetailsCubit.areaPropertiesController.text,
                                                                        bathroom: productDetailsCubit.bathroomOfProductController.text,
                                                                        bedroom: productDetailsCubit.bedroomOfProductController.text,
                                                                        cityName: widget.cityName,
                                                                        areaId: widget.areaId,
                                                                        areaName: widget.areaName,
                                                                        toPrice: productDetailsCubit.newPriceController.text,
                                                                        fromPrice: productDetailsCubit.oldPriceController.text,
                                                                        levelType: widget.levelType,
                                                                        kiloMetresType: productDetailsCubit.kiloMetresOfProductController.text,
                                                                        amenitiesType: widget.amenitiesType,
                                                                        fuelType: widget.fuelType,
                                                                        engineCapacityType: widget.engineCapacityType,
                                                                        colorType: widget.colorType,
                                                                        bodyType: widget.bodyType,
                                                                        nameProduct: productDetailsCubit.nameOfProductController.text,
                                                                        description: productDetailsCubit.descriptionController.text,
                                                                        locationUser: productDetailsCubit.locationUserController.text,),
                                                                ));
                                                          }else if (state.showDetailsProductResponseModel![0].countryModel?.id != null){
                                                            print('governmentId is data');
                                                            Navigator.of(context).push(
                                                                MaterialPageRoute(
                                                                  builder: (context) =>
                                                                      ChooseCityProductScreen(
                                                                          data: 'changeProductScreen',
                                                                          governmentId: widget
                                                                              .governmentId,
                                                                          governmentName: widget
                                                                              .governmentName,
                                                                          cityId: widget.cityId,
                                                                          typeApartment: widget.typeApartment,
                                                                          transmissionVehicles: widget.transmissionVehicles,
                                                                          statusApartment: widget.statusApartment,
                                                                          typeBooks: widget.typeBooks,
                                                                          typeWarrannt: widget.typeWarrannt,
                                                                          typeBusiness: widget.typeBusiness,
                                                                          warrantyElectronic: widget.typeWarrannt,
                                                                          typeCondtion: widget.typeCondtion,
                                                                          typeKids: widget.typeKids,
                                                                          typeFashion: widget.typeFashion,
                                                                          typeHomeFurniture: widget.typeHomeFurniture,
                                                                          whatsAppNumber: productDetailsCubit.whatsAppController.text,
                                                                          year: productDetailsCubit.yearOfProductController.text,
                                                                          downPayment: productDetailsCubit.downPaymentController.text,
                                                                          area: productDetailsCubit.areaPropertiesController.text,
                                                                          bathroom: productDetailsCubit.bathroomOfProductController.text,
                                                                          bedroom: productDetailsCubit.bedroomOfProductController.text,
                                                                          cityName: widget.cityName,
                                                                          areaId: widget.areaId,
                                                                          areaName: widget.areaName,
                                                                          toPrice: productDetailsCubit.newPriceController.text,
                                                                          fromPrice: productDetailsCubit.oldPriceController.text,
                                                                          levelType: widget.levelType,
                                                                          kiloMetresType: productDetailsCubit.kiloMetresOfProductController.text,
                                                                          amenitiesType: widget.amenitiesType,
                                                                          fuelType: widget.fuelType,
                                                                          engineCapacityType: widget.engineCapacityType,
                                                                          colorType: widget.colorType,
                                                                          bodyType: widget.bodyType,
                                                                          nameProduct: productDetailsCubit.nameOfProductController.text,
                                                                          description: productDetailsCubit.descriptionController.text,
                                                                          locationUser: productDetailsCubit.locationUserController.text,),
                                                                ));
                                                          }else {
                                                            AwesomeDialog(
                                                              context: context,
                                                              dialogType: DialogType.warning,
                                                              animType: AnimType.BOTTOMSLIDE,
                                                              title: LocaleKeys.warning.tr(),
                                                              btnOkText: LocaleKeys.ok.tr(),
                                                              btnCancelText: LocaleKeys.cancel.tr(),
                                                              desc: LocaleKeys.pleaseSelectGovernorate.tr(),
                                                              btnCancelOnPress: () {},
                                                              btnOkOnPress: () {},
                                                            ).show();

                                                          }
                                                        }),
                                                  ),
                                                ],
                                              ),
                                              15.heightBox,
                                              InputTextFormField(
                                                hintText: LocaleKeys.location.tr(),
                                                textEditingController: productDetailsCubit.locationUserController,
                                                validator: (val) {
                                                  if (val.isEmpty) {
                                                    return LocaleKeys.mustNotEmpty.tr();
                                                  }
                                                },
                                              ),
                                              //   13.heightBox,
                                              // stateLocation is CityLoadingState ?
                                              // const Center(child: CircularProgressIndicator(color: AppPalette.primary,)) : Container(),
                                              // stateLocation is AreaLoadingState ?
                                              // const Center(child: CircularProgressIndicator(color: AppPalette.primary,)) : Container(),
                                              // 13.heightBox,
                                              // Row(
                                              //   children: [
                                              //     stateLocation is CitySuccessState ?
                                              //     Expanded(
                                              //       child: CustomButtonWidget(
                                              //           title: '${stateLocation.citiesModel?.data?.cities![0].name}',
                                              //           onTap: () {
                                              //             print('governmentId');
                                              //             if (state.showDetailsProductResponseModel![0].governorateId == null) {
                                              //               AwesomeDialog(
                                              //                 context: context,
                                              //                 dialogType: DialogType.ERROR,
                                              //                 animType: AnimType.RIGHSLIDE,
                                              //                 btnOkText: LocaleKeys.ok.tr(),
                                              //                 btnCancelText: LocaleKeys.cancel.tr(),
                                              //                 title: LocaleKeys.error.tr(),
                                              //                 desc: LocaleKeys.governmentRequired.tr(),
                                              //                 btnCancelOnPress: () {},
                                              //                 btnOkOnPress: () {},
                                              //               ).show();
                                              //             } else {
                                              //               BlocProvider.of<
                                              //                   LocationsCubit>(
                                              //                   context)
                                              //                   .getCityOfGovernment(
                                              //                   '${widget.governmentId == null ? state.showDetailsProductResponseModel![0].governorateId
                                              //                   : widget.governmentId}');
                                              //               Navigator.of(context)
                                              //                   .push(
                                              //                   MaterialPageRoute(
                                              //                     builder: (
                                              //                         context) =>
                                              //                         ChooseCityProductScreen(
                                              //                           governmentId: widget
                                              //                               .governmentId,
                                              //                           governmentName: widget
                                              //                               .governmentName,
                                              //                           cityId: widget.cityId,
                                              //                           typeApartment: widget.typeApartment,
                                              //                           statusApartment: widget.statusApartment,
                                              //                           transmissionVehicles: widget.transmissionVehicles,
                                              //                           typeCondtion: widget.typeCondtion,
                                              //                           typeBooks: widget.typeBooks,
                                              //                           typeKids: widget.typeKids,
                                              //                           whatsAppNumber:productDetailsCubit.whatsAppController.text ,
                                              //                           typeHomeFurniture: widget.typeHomeFurniture,
                                              //                           typeFashion: widget.typeFashion,
                                              //                           typeBusiness: widget.typeBusiness,
                                              //                           typeWarrannt: widget.typeWarrannt,
                                              //                           productId: widget.product?.id.toString(),
                                              //                           year: productDetailsCubit.yearOfProductController.text,
                                              //                           downPayment: productDetailsCubit.downPaymentController.text,
                                              //                           area: productDetailsCubit.areaPropertiesController.text,
                                              //                           bathroom: productDetailsCubit.bathroomOfProductController.text,
                                              //                           bedroom: productDetailsCubit.bedroomOfProductController.text,
                                              //                           cityName: widget.cityName,
                                              //                           areaId: widget.areaId,
                                              //                           areaName: widget.areaName,
                                              //                           toPrice: productDetailsCubit.newPriceController
                                              //                               .text,
                                              //                           fromPrice: productDetailsCubit.oldPriceController
                                              //                               .text,
                                              //                           levelType: widget.levelType,
                                              //                           kiloMetresType: productDetailsCubit.kiloMetresOfProductController.text,
                                              //                           amenitiesType: widget.amenitiesType,
                                              //                           fuelType: widget.fuelType,
                                              //                           engineCapacityType: widget.engineCapacityType,
                                              //                           colorType: widget.colorType,
                                              //                           bodyType: widget.bodyType,
                                              //                           nameProduct: productDetailsCubit.nameOfProductController
                                              //                               .text,
                                              //                           description: productDetailsCubit.descriptionController
                                              //                               .text,
                                              //                           locationUser: '',
                                              //                           data: 'changeProductScreen',),
                                              //                   ));
                                              //             }
                                              //           }),
                                              //     ) :
                                              //     Expanded(
                                              //       child: CustomButtonWidget(
                                              //           title: LocaleKeys.city.tr(),
                                              //           onTap: () {
                                              //             print('governmentId');
                                              //             print('${widget.governmentId}');
                                              //             if (state.showDetailsProductResponseModel![0].governorateId == null) {
                                              //               AwesomeDialog(
                                              //                 context: context,
                                              //                 dialogType: DialogType.ERROR,
                                              //                 animType: AnimType.RIGHSLIDE,
                                              //                 btnOkText: LocaleKeys.ok.tr(),
                                              //                 btnCancelText: LocaleKeys.cancel.tr(),
                                              //                 title: LocaleKeys.error.tr(),
                                              //                 desc: LocaleKeys.governmentRequired.tr(),
                                              //                 btnCancelOnPress: () {},
                                              //                 btnOkOnPress: () {},
                                              //               ).show();
                                              //             } else {
                                              //               BlocProvider.of<
                                              //                   LocationsCubit>(
                                              //                   context)
                                              //                   .getCityOfGovernment(
                                              //                   '${widget.governmentId == null ? state.showDetailsProductResponseModel![0].governorateId
                                              //                       : widget.governmentId}');
                                              //               Navigator.of(context)
                                              //                   .push(
                                              //                   MaterialPageRoute(
                                              //                     builder: (
                                              //                         context) =>
                                              //                         ChooseCityProductScreen(
                                              //                           governmentId: widget
                                              //                               .governmentId,
                                              //                           governmentName: widget
                                              //                               .governmentName,
                                              //                           cityId: widget.cityId,
                                              //                           typeApartment: widget.typeApartment,
                                              //                           statusApartment: widget.statusApartment,
                                              //                           transmissionVehicles: widget.transmissionVehicles,
                                              //                           typeCondtion: widget.typeCondtion,
                                              //                           typeBooks: widget.typeBooks,
                                              //                           typeKids: widget.typeKids,
                                              //                           whatsAppNumber:productDetailsCubit.whatsAppController.text ,
                                              //                           typeHomeFurniture: widget.typeHomeFurniture,
                                              //                           typeFashion: widget.typeFashion,
                                              //                           typeBusiness: widget.typeBusiness,
                                              //                           typeWarrannt: widget.typeWarrannt,
                                              //                           productId: widget.product?.id.toString(),
                                              //                           year: productDetailsCubit.yearOfProductController.text,
                                              //                           downPayment: productDetailsCubit.downPaymentController.text,
                                              //                           area: productDetailsCubit.areaPropertiesController.text,
                                              //                           bathroom: productDetailsCubit.bathroomOfProductController.text,
                                              //                           bedroom: productDetailsCubit.bedroomOfProductController.text,
                                              //                           cityName: widget.cityName,
                                              //                           areaId: widget.areaId,
                                              //                           areaName: widget.areaName,
                                              //                           toPrice: productDetailsCubit.newPriceController
                                              //                               .text,
                                              //                           fromPrice: productDetailsCubit.oldPriceController
                                              //                               .text,
                                              //                           levelType: widget.levelType,
                                              //                           kiloMetresType: productDetailsCubit.kiloMetresOfProductController.text,
                                              //                           amenitiesType: widget.amenitiesType,
                                              //                           fuelType: widget.fuelType,
                                              //                           engineCapacityType: widget.engineCapacityType,
                                              //                           colorType: widget.colorType,
                                              //                           bodyType: widget.bodyType,
                                              //                           nameProduct: productDetailsCubit.nameOfProductController
                                              //                               .text,
                                              //                           description: productDetailsCubit.descriptionController
                                              //                               .text,
                                              //                           locationUser: '',
                                              //                           data: 'changeProductScreen',),
                                              //                   ));
                                              //             }
                                              //           }),
                                              //     ),
                                              //     15.widthBox,
                                              //     stateLocation is AreaSuccessState ?
                                              //     Expanded(
                                              //       child: CustomButtonWidget(
                                              //           title: '${stateLocation.areaModel?.data?.areas![0].name}',
                                              //           onTap: () {
                                              //             if (state.showDetailsProductResponseModel![0].cityId == null) {
                                              //               AwesomeDialog(
                                              //                 context: context,
                                              //                 dialogType: DialogType.ERROR,
                                              //                 animType: AnimType.RIGHSLIDE,
                                              //                 btnOkText: LocaleKeys.ok.tr(),
                                              //                 btnCancelText: LocaleKeys.cancel.tr(),
                                              //                 title: LocaleKeys.error.tr(),
                                              //                 desc: LocaleKeys.cityRequired.tr(),
                                              //                 btnCancelOnPress: () {},
                                              //                 btnOkOnPress: () {},
                                              //               ).show();
                                              //             } else {
                                              //               BlocProvider.of<
                                              //                   LocationsCubit>(context).getAreaOfCity(
                                              //                   '${widget.cityId == null ? state.showDetailsProductResponseModel![0].cityId
                                              //                       : widget.cityId}');
                                              //               Navigator.of(context)
                                              //                   .push(
                                              //                   MaterialPageRoute(
                                              //                     builder: (
                                              //                         context) =>
                                              //                         ChooseAreaProductScreen(
                                              //                           governmentId: widget
                                              //                               .governmentId,
                                              //                           governmentName: widget
                                              //                               .governmentName,
                                              //                           cityId: widget.cityId,
                                              //                           typeApartment: widget.typeApartment,
                                              //                           statusApartment: widget.statusApartment,
                                              //                           transmissionVehicles: widget.transmissionVehicles,
                                              //                           typeCondtion: widget.typeCondtion,
                                              //                           typeBooks: widget.typeBooks,
                                              //                           typeKids: widget.typeKids,
                                              //                           whatsAppNumber:productDetailsCubit.whatsAppController.text ,
                                              //                           typeHomeFurniture: widget.typeHomeFurniture,
                                              //                           typeFashion: widget.typeFashion,
                                              //                           typeBusiness: widget.typeBusiness,
                                              //                           typeWarrannt: widget.typeWarrannt,
                                              //                           productId: widget.product?.id.toString(),
                                              //                           year: productDetailsCubit.yearOfProductController.text,
                                              //                           downPayment: productDetailsCubit.downPaymentController.text,
                                              //                           area: productDetailsCubit.areaPropertiesController.text,
                                              //                           bathroom: productDetailsCubit.bathroomOfProductController.text,
                                              //                           bedroom: productDetailsCubit.bedroomOfProductController.text,
                                              //                           cityName: widget.cityName,
                                              //                           areaId: widget.areaId,
                                              //                           areaName: widget.areaName,
                                              //                           toPrice: productDetailsCubit.newPriceController
                                              //                               .text,
                                              //                           fromPrice: productDetailsCubit.oldPriceController
                                              //                               .text,
                                              //                           levelType: widget.levelType,
                                              //                           kiloMetresType: productDetailsCubit.kiloMetresOfProductController.text,
                                              //                           amenitiesType: widget.amenitiesType,
                                              //                           fuelType: widget.fuelType,
                                              //                           engineCapacityType: widget.engineCapacityType,
                                              //                           colorType: widget.colorType,
                                              //                           bodyType: widget.bodyType,
                                              //                           nameProduct: productDetailsCubit.nameOfProductController
                                              //                               .text,
                                              //                           description: productDetailsCubit.descriptionController
                                              //                               .text,
                                              //                           locationUser: '',
                                              //                           data: 'changeProductScreen',),
                                              //                   ));
                                              //             }
                                              //           }),
                                              //     ) :
                                              //     Expanded(
                                              //       child: CustomButtonWidget(
                                              //           title: LocaleKeys.area.tr(),
                                              //           onTap: () {
                                              //             if (state.showDetailsProductResponseModel![0].cityId == null) {
                                              //               AwesomeDialog(
                                              //                 context: context,
                                              //                 dialogType: DialogType.ERROR,
                                              //                 animType: AnimType.RIGHSLIDE,
                                              //                 btnOkText: LocaleKeys.ok.tr(),
                                              //                 btnCancelText: LocaleKeys.cancel.tr(),
                                              //                 title: LocaleKeys.error.tr(),
                                              //                 desc: LocaleKeys.cityRequired.tr(),
                                              //                 btnCancelOnPress: () {},
                                              //                 btnOkOnPress: () {},
                                              //               ).show();
                                              //             } else {
                                              //               BlocProvider.of<
                                              //                   LocationsCubit>(context).getAreaOfCity(
                                              //                   '${widget.cityId == null ? state.showDetailsProductResponseModel![0].cityId
                                              //                       : widget.cityId}');
                                              //               Navigator.of(context)
                                              //                   .push(
                                              //                   MaterialPageRoute(
                                              //                     builder: (
                                              //                         context) =>
                                              //                         ChooseAreaProductScreen(
                                              //                           governmentId: widget
                                              //                               .governmentId,
                                              //                           governmentName: widget
                                              //                               .governmentName,
                                              //                           cityId: widget.cityId,
                                              //                           typeApartment: widget.typeApartment,
                                              //                           statusApartment: widget.statusApartment,
                                              //                           transmissionVehicles: widget.transmissionVehicles,
                                              //                           typeCondtion: widget.typeCondtion,
                                              //                           typeBooks: widget.typeBooks,
                                              //                           typeKids: widget.typeKids,
                                              //                           whatsAppNumber:productDetailsCubit.whatsAppController.text ,
                                              //                           typeHomeFurniture: widget.typeHomeFurniture,
                                              //                           typeFashion: widget.typeFashion,
                                              //                           typeBusiness: widget.typeBusiness,
                                              //                           typeWarrannt: widget.typeWarrannt,
                                              //                           productId: widget.product?.id.toString(),
                                              //                           year: productDetailsCubit.yearOfProductController.text,
                                              //                           downPayment: productDetailsCubit.downPaymentController.text,
                                              //                           area: productDetailsCubit.areaPropertiesController.text,
                                              //                           bathroom: productDetailsCubit.bathroomOfProductController.text,
                                              //                           bedroom: productDetailsCubit.bedroomOfProductController.text,
                                              //                           cityName: widget.cityName,
                                              //                           areaId: widget.areaId,
                                              //                           areaName: widget.areaName,
                                              //                           toPrice: productDetailsCubit.newPriceController
                                              //                               .text,
                                              //                           fromPrice: productDetailsCubit.oldPriceController
                                              //                               .text,
                                              //                           levelType: widget.levelType,
                                              //                           kiloMetresType: productDetailsCubit.kiloMetresOfProductController.text,
                                              //                           amenitiesType: widget.amenitiesType,
                                              //                           fuelType: widget.fuelType,
                                              //                           engineCapacityType: widget.engineCapacityType,
                                              //                           colorType: widget.colorType,
                                              //                           bodyType: widget.bodyType,
                                              //                           nameProduct: productDetailsCubit.nameOfProductController
                                              //                               .text,
                                              //                           description: productDetailsCubit.descriptionController
                                              //                               .text,
                                              //                           locationUser: '',
                                              //                           data: 'changeProductScreen',),
                                              //                   ));
                                              //             }
                                              //           }),
                                              //     ),
                                              //   ],
                                              // ),
                                              15.heightBox,
                                              state.showDetailsProductResponseModel![0].category != null ?
                                              state.showDetailsProductResponseModel![0].category!.name!.en!
                                                  .contains('Properties') ?
                                              Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(LocaleKeys.type.tr(),
                                                          style: const TextStyle(
                                                              color: AppPalette.black,
                                                              fontWeight: FontWeight.w500)),
                                                    ],
                                                  ),
                                                  10.heightBox,
                                                  CustomButtonWidget(
                                                      title:
                                                      context.locale.languageCode.contains('en') ?
                                                      widget.typeApartment == null ?
                                                      state.showDetailsProductResponseModel![0].options![0].value!.contains('null') ?
                                                      LocaleKeys.type.tr()  :
                                                      state.showDetailsProductResponseModel![0].options![0].value!  : '${widget.typeApartment}' :
                                                      context.locale.languageCode.contains('ar') ?
                                                      widget.typeApartment == null ?
                                                      state.showDetailsProductResponseModel![0].options![0].valueAr!.contains('null') ?
                                                      LocaleKeys.type.tr()  :
                                                      state.showDetailsProductResponseModel![0].options![0].valueAr!  : '${widget.typeApartment}' : '',
                                                      onTap: () {
                                                        Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
                                                            ChooseTypeApartmentProductScreen(
                                                              governmentId: widget.governmentId,
                                                              governmentName: widget.governmentName,
                                                              cityId: widget.cityId,
                                                              furnishedType: widget.furnishedType,
                                                              downPayment: productDetailsCubit.downPaymentController.text,
                                                              area: productDetailsCubit.areaPropertiesController.text,
                                                              bathroom: productDetailsCubit.bathroomOfProductController.text,
                                                              bedroom: productDetailsCubit.bedroomOfProductController.text,
                                                              cityName: widget.cityName,
                                                              areaId: widget.areaId,
                                                              areaName: widget.areaName,
                                                              typeApartment: widget.typeApartment,
                                                              statusApartment: widget.statusApartment,
                                                              toPrice: productDetailsCubit.newPriceController.text,
                                                              fromPrice: productDetailsCubit.oldPriceController.text,
                                                              whatsAppNumber: productDetailsCubit.whatsAppController.text,
                                                              levelType: widget.levelType,
                                                              amenitiesType: widget.amenitiesType,
                                                              nameProduct: productDetailsCubit.nameOfProductController.text,
                                                              description: productDetailsCubit.descriptionController.text,
                                                              locationUser: productDetailsCubit.locationUserController.text,
                                                            )));
                                                      }),
                                                  15.heightBox,
                                                  Row(
                                                    children: [
                                                      Text(LocaleKeys.downPayment.tr(),
                                                          style: const TextStyle(
                                                              color: AppPalette.black,
                                                              fontWeight: FontWeight.w500)),
                                                    ],
                                                  ),
                                                  10.heightBox,
                                                  InputTextFormField(
                                                    hintText: LocaleKeys.downPayment.tr(),
                                                    textEditingController: productDetailsCubit.downPaymentController,
                                                    textInputType: TextInputType.number,
                                                    suffixIcon: Container(
                                                        padding: EdgeInsets.all(
                                                          Dimensions.paddingSize,
                                                        ),
                                                        child: Text(LocaleKeys.currencyPrice.tr())),
                                                    validator: (val) {
                                                      // if (val.isEmpty) {
                                                      //   return "enter price";
                                                      // }
                                                    },
                                                  ),
                                                  15.heightBox,
                                                  Row(
                                                    children: [
                                                      Text(LocaleKeys.amenities.tr(),
                                                          style: const TextStyle(
                                                              color: AppPalette.black,
                                                              fontWeight: FontWeight.w500)),
                                                    ],
                                                  ),
                                                  10.heightBox,
                                                  CustomButtonWidget(
                                                      title:
                                                      context.locale.languageCode.contains('en') ?
                                                      widget.amenitiesType == null ?
                                                      state.showDetailsProductResponseModel![0].options![2].value!.contains('null') ?
                                                      LocaleKeys.amenities.tr()  :
                                                      state.showDetailsProductResponseModel![0].options![2].value!  : '${widget.amenitiesType}' :
                                                      context.locale.languageCode.contains('ar') ?
                                                      widget.amenitiesType == null ?
                                                      state.showDetailsProductResponseModel![0].options![2].valueAr!.contains('null') ?
                                                      LocaleKeys.amenities.tr()  :
                                                      state.showDetailsProductResponseModel![0].options![2].valueAr!  : '${widget.amenitiesType}' : '',
                                                      onTap: () {
                                                        Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
                                                            ChooseAmenitiesAddProductScreen(
                                                              governmentId: widget
                                                                  .governmentId,
                                                              governmentName: widget
                                                                  .governmentName,
                                                              cityId: widget.cityId,
                                                              data: 'changeProduct',
                                                              furnishedType: widget.furnishedType,
                                                              typeApartment: widget.typeApartment,
                                                              statusApartment: widget.statusApartment,
                                                              productId: widget.product?.id.toString(),
                                                              whatsAppNumber: productDetailsCubit.whatsAppController.text,
                                                              year: productDetailsCubit.yearOfProductController.text,
                                                              downPayment: productDetailsCubit.downPaymentController.text,
                                                              area: productDetailsCubit.areaPropertiesController.text,
                                                              bathroom: productDetailsCubit.bathroomOfProductController.text,
                                                              bedroom: productDetailsCubit.bedroomOfProductController.text,
                                                              cityName: widget.cityName,
                                                              areaId: widget.areaId,
                                                              areaName: widget.areaName,
                                                              toPrice: productDetailsCubit.newPriceController
                                                                  .text,
                                                              fromPrice: productDetailsCubit.oldPriceController
                                                                  .text,
                                                              levelType: widget.levelType,
                                                              kiloMetresType: productDetailsCubit.kiloMetresOfProductController.text,
                                                              amenitiesType: widget.amenitiesType,
                                                              fuelType: widget.fuelType,
                                                              engineCapacityType: widget.engineCapacityType,
                                                              colorType: widget.colorType,
                                                              bodyType: widget.bodyType,
                                                              nameProduct: productDetailsCubit.nameOfProductController
                                                                  .text,
                                                              description: productDetailsCubit.descriptionController
                                                                  .text,
                                                              locationUser: productDetailsCubit.locationUserController.text,
                                                            )));
                                                      }),
                                                  15.heightBox,
                                                  Row(
                                                    children: [
                                                      Text(LocaleKeys.bedroom.tr(),
                                                          style: const TextStyle(
                                                              color: AppPalette.black,
                                                              fontWeight: FontWeight.w500)),
                                                    ],
                                                  ),
                                                  10.heightBox,
                                                  InputTextFormField(
                                                    hintText: LocaleKeys.bedroom.tr(),
                                                    textEditingController:
                                                    productDetailsCubit.bedroomOfProductController,
                                                    textInputType: TextInputType.number,
                                                    validator: (val) {
                                                      // if (val.isEmpty) {
                                                      //   return LocaleKeys.mustNotEmpty.tr();
                                                      // }
                                                    },),
                                                  15.heightBox,
                                                  Row(
                                                    children: [
                                                      Text(LocaleKeys.bathroom.tr(),
                                                          style: const TextStyle(
                                                              color: AppPalette.black,
                                                              fontWeight: FontWeight.w500)),
                                                    ],
                                                  ),
                                                  10.heightBox,
                                                  InputTextFormField(
                                                    hintText: LocaleKeys.bathroom.tr(),
                                                    textEditingController:
                                                    productDetailsCubit.bathroomOfProductController,
                                                    textInputType: TextInputType.number,
                                                    validator: (val) {
                                                      // if (val.isEmpty) {
                                                      //   return LocaleKeys.mustNotEmpty.tr();
                                                      // }
                                                    },
                                                  ),
                                                  15.heightBox,
                                                  Row(
                                                    children: [
                                                      Text(LocaleKeys.area.tr(),
                                                          style: const TextStyle(
                                                              color: AppPalette.black,
                                                              fontWeight: FontWeight.w500)),
                                                    ],
                                                  ),
                                                  10.heightBox,
                                                  InputTextFormField(
                                                    hintText: LocaleKeys.area.tr(),
                                                    textEditingController: productDetailsCubit.areaPropertiesController,
                                                    textInputType: TextInputType.number,
                                                    suffixIcon: Container(
                                                      padding: EdgeInsets.all(
                                                        Dimensions.paddingSize,
                                                      ),
                                                      child:  const Text('(m²)',
                                                          style: TextStyle(
                                                              color: AppPalette.black,
                                                              fontWeight: FontWeight.w500)),),
                                                    validator: (val) {
                                                      // if (val.isEmpty) {
                                                      //   return "enter price";
                                                      // }
                                                    },
                                                  ),
                                                  15.heightBox,
                                                  Row(
                                                    children: [
                                                      Text(LocaleKeys.level.tr(),
                                                          style: const TextStyle(
                                                              color: AppPalette.black,
                                                              fontWeight: FontWeight.w500)),
                                                    ],
                                                  ),
                                                  10.heightBox,
                                                  CustomButtonWidget(
                                                      title: widget.levelType == null ?
                                                      '${state.showDetailsProductResponseModel![0].options![6].value!.contains('null') ?
                                                      LocaleKeys.level.tr() : state.showDetailsProductResponseModel![0].options![6].value}' :
                                                      '${widget.levelType}',
                                                      onTap: () {
                                                        Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
                                                            ChooseLevelAddProductScreen(
                                                              governmentId: widget
                                                                  .governmentId,
                                                              governmentName: widget
                                                                  .governmentName,
                                                              cityId: widget.cityId,
                                                              data: 'changeProduct',
                                                              whatsAppNumber: productDetailsCubit.whatsAppController.text,
                                                              furnishedType: widget.furnishedType,
                                                              typeApartment: widget.typeApartment,
                                                              statusApartment: widget.statusApartment,
                                                              productId: widget.product?.id.toString(),
                                                              year: productDetailsCubit.yearOfProductController.text,
                                                              downPayment: productDetailsCubit.downPaymentController.text,
                                                              area: productDetailsCubit.areaPropertiesController.text,
                                                              bathroom: productDetailsCubit.bathroomOfProductController.text,
                                                              bedroom: productDetailsCubit.bedroomOfProductController.text,
                                                              cityName: widget.cityName,
                                                              areaId: widget.areaId,
                                                              areaName: widget.areaName,
                                                              toPrice: productDetailsCubit.newPriceController.text,
                                                              fromPrice: productDetailsCubit.oldPriceController.text,
                                                              levelType: widget.levelType,
                                                              kiloMetresType: productDetailsCubit.kiloMetresOfProductController.text,
                                                              amenitiesType: widget.amenitiesType,
                                                              fuelType: widget.fuelType,
                                                              engineCapacityType: widget.engineCapacityType,
                                                              colorType: widget.colorType,
                                                              bodyType: widget.bodyType,
                                                              nameProduct: productDetailsCubit.nameOfProductController
                                                                  .text,
                                                              description: productDetailsCubit.descriptionController
                                                                  .text,
                                                              locationUser: productDetailsCubit.locationUserController.text,
                                                            )));
                                                      }),
                                                  15.heightBox,
                                                  Row(
                                                    children: [
                                                      Text(LocaleKeys.finished.tr(),
                                                        style: const TextStyle(
                                                            color: AppPalette.black,
                                                            fontWeight: FontWeight.w500),),
                                                    ],
                                                  ),
                                                  10.heightBox,
                                                  CustomButtonWidget(
                                                      title: context.locale.languageCode.contains('en') ?
                                                      widget.furnishedType == null ?
                                                      state.showDetailsProductResponseModel![0].options![7].value!.contains('null') ?
                                                      LocaleKeys.finished.tr()  :
                                                      state.showDetailsProductResponseModel![0].options![7].value!  : '${widget.furnishedType}' :
                                                      context.locale.languageCode.contains('ar') ?
                                                      widget.furnishedType == null ?
                                                      state.showDetailsProductResponseModel![0].options![7].valueAr!.contains('null') ?
                                                      LocaleKeys.finished.tr()  :
                                                      state.showDetailsProductResponseModel![0].options![7].valueAr!  : '${widget.furnishedType}' : '',
                                                      onTap: () {
                                                        Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
                                                            ChooseFurnishedProductScreen(
                                                              governmentId: widget
                                                                  .governmentId,
                                                              governmentName: widget
                                                                  .governmentName,
                                                              cityId: widget.cityId,
                                                              data: 'changeProduct',
                                                              furnishedType: widget.furnishedType,
                                                              typeCondtion: widget.typeCondtion,
                                                              typeApartment: widget.typeApartment,
                                                              whatsAppNumber: productDetailsCubit.whatsAppController.text,
                                                              statusApartment: widget.statusApartment,
                                                              productId: widget.product?.id.toString(),
                                                              year: productDetailsCubit.yearOfProductController.text,
                                                              downPayment: productDetailsCubit.downPaymentController.text,
                                                              area: productDetailsCubit.areaPropertiesController.text,
                                                              bathroom: productDetailsCubit.bathroomOfProductController.text,
                                                              bedroom: productDetailsCubit.bedroomOfProductController.text,
                                                              cityName: widget.cityName,
                                                              areaId: widget.areaId,
                                                              areaName: widget.areaName,
                                                              toPrice: productDetailsCubit.newPriceController.text,
                                                              fromPrice: productDetailsCubit.oldPriceController.text,
                                                              levelType: widget.levelType,
                                                              amenitiesType: widget.amenitiesType,
                                                              nameProduct: productDetailsCubit.nameOfProductController
                                                                  .text,
                                                              description: productDetailsCubit.descriptionController
                                                                  .text,
                                                              locationUser: productDetailsCubit.locationUserController.text,
                                                            )));
                                                      }),
                                                  15.heightBox
                                                ],
                                              )
                                                  : Container() : Container(),
                                              ////// Home Furniture Category
                                              state.showDetailsProductResponseModel![0].category != null ?
                                              state.showDetailsProductResponseModel![0].category!.name!.en!
                                                  .contains('Home Furniture') ?
                                              Column(
                                                children: [
                                                  // CustomButtonWidget(
                                                  //     title: state.showDetailsProductResponseModel![0].brand ==
                                                  //         null ? LocaleKeys.brand.tr() :
                                                  //     context.locale.languageCode.contains('en')
                                                  //         ? addProductController.selectedBrand?.brandName == null ?
                                                  //     '${state.showDetailsProductResponseModel![0].brand!.name?.en!}' :
                                                  //     '${addProductController.selectedBrand!.brandName?.en!}' :
                                                  //     context.locale.languageCode.contains('ar')
                                                  //         ? addProductController.selectedBrand?.brandName == null ?
                                                  //     '${state.showDetailsProductResponseModel![0].brand!.name?.ar!}' :
                                                  //     '${addProductController.selectedBrand?.brandName?.ar!}' :
                                                  //     context.locale.languageCode.contains('tr')
                                                  //         ? addProductController.selectedBrand!.brandName == null ?
                                                  //     '${state.showDetailsProductResponseModel![0].brand!.name?.tr!}' :
                                                  //     '${addProductController.selectedBrand?.brandName?.tr!}' :
                                                  //     context.locale.languageCode.contains('de')
                                                  //         ? addProductController.selectedBrand!.brandName == null ?
                                                  //     '${state.showDetailsProductResponseModel![0].brand!.name?.de!}' :
                                                  //     '${addProductController.selectedBrand!.brandName?.de!}'
                                                  //         : ' ',
                                                  //     onTap: () {
                                                  //
                                                  //     //  CustomFlutterToast(state.showDetailsProductResponseModel![0].category?.id.toString());
                                                  //
                                                  //       if(state.showDetailsProductResponseModel![0].category?.id  != null){
                                                  //         Navigator.of(context).push(
                                                  //             MaterialPageRoute(
                                                  //               builder: (context) =>
                                                  //                   ChooseOneBrandChangeScreen(
                                                  //                       typeFashion: widget.typeFashion,
                                                  //                       governmentId: widget
                                                  //                           .governmentId,
                                                  //                       governmentName: widget
                                                  //                           .governmentName,
                                                  //                       cityId: widget.cityId,
                                                  //                       product: state.showDetailsProductResponseModel![0],
                                                  //                       year: productDetailsCubit.yearOfProductController.text,
                                                  //                       downPayment: productDetailsCubit.downPaymentController.text,
                                                  //                       area: productDetailsCubit.areaPropertiesController.text,
                                                  //                       bathroom: productDetailsCubit.bathroomOfProductController.text,
                                                  //                       bedroom: productDetailsCubit.bedroomOfProductController.text,
                                                  //                       cityName: widget.cityName,
                                                  //                       areaId: widget.areaId,
                                                  //                       areaName: widget.areaName,
                                                  //                       toPrice: productDetailsCubit.newPriceController.text,
                                                  //                       fromPrice: productDetailsCubit.oldPriceController
                                                  //                           .text,
                                                  //                       levelType: widget.levelType,
                                                  //                       kiloMetresType: productDetailsCubit.kiloMetresOfProductController.text,
                                                  //                       amenitiesType: widget.amenitiesType,
                                                  //                       fuelType: widget.fuelType,
                                                  //                       engineCapacityType: widget.engineCapacityType,
                                                  //                       colorType: widget.colorType,
                                                  //                       bodyType: widget.bodyType,
                                                  //                       nameProduct: productDetailsCubit.nameOfProductController
                                                  //                           .text,
                                                  //                       description: productDetailsCubit.descriptionController
                                                  //                           .text,
                                                  //                       data: ''),
                                                  //             ));
                                                  //       }else {
                                                  //         customFlutterToast(
                                                  //             LocaleKeys.pleaseSelectMainCategoryFirst.tr());
                                                  //       }
                                                  //     }
                                                  // ),
                                                  // 15.heightBox,
                                                  Row(
                                                    children: [
                                                      Text(LocaleKeys.type.tr(),
                                                          style: const TextStyle(
                                                              color: AppPalette.black,
                                                              fontWeight: FontWeight.w500)),
                                                    ],
                                                  ),
                                                  10.heightBox,
                                                  CustomButtonWidget(
                                                      title:
                                                      context.locale.languageCode.contains('en') ?
                                                      widget.typeHomeFurniture == null ?
                                                      state.showDetailsProductResponseModel![0].options![0].value!.contains('null') ?
                                                      LocaleKeys.type.tr()  :
                                                      state.showDetailsProductResponseModel![0].options![0].value!  : '${widget.typeHomeFurniture}' :
                                                      context.locale.languageCode.contains('ar') ?
                                                      widget.typeHomeFurniture == null ?
                                                      state.showDetailsProductResponseModel![0].options![0].valueAr!.contains('null') ?
                                                      LocaleKeys.type.tr()  :
                                                      state.showDetailsProductResponseModel![0].options![0].valueAr!  : '${widget.typeHomeFurniture}' : '',
                                                      onTap: () {
                                                        Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
                                                            ChooseHomeFurnitureProductScreen(
                                                              governmentId: widget.governmentId,
                                                              governmentName: widget.governmentName,
                                                              cityId: widget.cityId,
                                                              typeCondtion: widget.typeCondtion,
                                                              typeHomeFurniture: widget.typeHomeFurniture,
                                                              downPayment: productDetailsCubit.downPaymentController.text,
                                                              area: productDetailsCubit.areaPropertiesController.text,
                                                              bathroom: productDetailsCubit.bathroomOfProductController.text,
                                                              bedroom: productDetailsCubit.bedroomOfProductController.text,
                                                              cityName: widget.cityName,
                                                              areaId: widget.areaId,
                                                              areaName: widget.areaName,
                                                              toPrice: productDetailsCubit.newPriceController
                                                                  .text,
                                                              fromPrice: productDetailsCubit.oldPriceController
                                                                  .text,
                                                              levelType: widget.levelType,
                                                              amenitiesType: widget.amenitiesType,
                                                              whatsAppNumber: productDetailsCubit.whatsAppController.text,
                                                              nameProduct: productDetailsCubit.nameOfProductController.text,
                                                              description: productDetailsCubit.descriptionController.text,
                                                              locationUser: productDetailsCubit.locationUserController.text,
                                                            )));
                                                      }),
                                                  15.heightBox,
                                                  Row(
                                                    children: [
                                                      Text(LocaleKeys.condition.tr(),
                                                          style: const TextStyle(
                                                              color: AppPalette.black,
                                                              fontWeight: FontWeight.w500)),
                                                    ],
                                                  ),
                                                  10.heightBox,
                                                  CustomButtonWidget(
                                                      title: widget.typeCondtion == null ?
                                                      '$selectedConditionItems'
                                                          : '${widget.typeCondtion}',
                                                      onTap: () {
                                                        Navigator.of(context).push(MaterialPageRoute(
                                                            builder: (context) => ChooseConditionProductScreen(
                                                              governmentId: widget.governmentId,
                                                              governmentName: widget.governmentName,
                                                              cityId: widget.cityId,
                                                              typeCondtion: widget.typeCondtion,
                                                              typeBusiness: widget.typeBusiness,
                                                              typeHomeFurniture: widget.typeHomeFurniture,
                                                              downPayment: productDetailsCubit.downPaymentController.text,
                                                              area: productDetailsCubit.areaPropertiesController.text,
                                                              bathroom: productDetailsCubit.bathroomOfProductController.text,
                                                              bedroom: productDetailsCubit.bedroomOfProductController.text,
                                                              cityName: widget.cityName,
                                                              areaId: widget.areaId,
                                                              areaName: widget.areaName,
                                                              toPrice: productDetailsCubit.newPriceController.text,
                                                              fromPrice: productDetailsCubit.oldPriceController.text,
                                                              levelType: widget.levelType,
                                                              amenitiesType: widget.amenitiesType,
                                                              whatsAppNumber: productDetailsCubit.whatsAppController.text,
                                                              nameProduct: productDetailsCubit.nameOfProductController.text,
                                                              description: productDetailsCubit.descriptionController.text,
                                                              locationUser: productDetailsCubit.locationUserController.text,
                                                            )));
                                                      }),
                                                  10.heightBox,
                                                ],
                                              ) : Container() : Container(),
                                              ////// Home Fashion Category
                                              state.showDetailsProductResponseModel![0].category != null ?
                                              state.showDetailsProductResponseModel![0].category!.name!.en!
                                                  .contains('Fashion') ?
                                              Column(
                                                children: [
                                                  // CustomButtonWidget(
                                                  //     title: state.showDetailsProductResponseModel![0].brandId ==
                                                  //         null ? LocaleKeys.brand.tr() :
                                                  //     context.locale.languageCode.contains('en')
                                                  //         ? addProductController.selectedBrand?.brandName == null ?
                                                  //     '${state.showDetailsProductResponseModel![0].brand!.name?.en!}' :
                                                  //     '${addProductController.selectedBrand!.brandName?.en!}' :
                                                  //     context.locale.languageCode.contains('ar')
                                                  //         ? addProductController.selectedBrand?.brandName == null ?
                                                  //     '${state.showDetailsProductResponseModel![0].brand!.name?.ar!}' :
                                                  //     '${addProductController.selectedBrand?.brandName?.ar!}' :
                                                  //     context.locale.languageCode.contains('tr')
                                                  //         ? addProductController.selectedBrand!.brandName == null ?
                                                  //     '${state.showDetailsProductResponseModel![0].brand!.name?.tr!}' :
                                                  //     '${addProductController.selectedBrand?.brandName?.tr!}' :
                                                  //     context.locale.languageCode.contains('de')
                                                  //         ? addProductController.selectedBrand!.brandName == null ?
                                                  //     '${state.showDetailsProductResponseModel![0].brand!.name?.de!}' :
                                                  //     '${addProductController.selectedBrand!.brandName?.de!}'
                                                  //         : ' ',
                                                  //     onTap: (){
                                                  //       if(state.showDetailsProductResponseModel![0].category?.id != null){
                                                  //         BlocProvider.of<CategoriesCubit>(context).getBrandsByCategory(
                                                  //             categoryID: state.showDetailsProductResponseModel![0].category!.id!);
                                                  //         Navigator.of(context).push(
                                                  //             MaterialPageRoute(
                                                  //               builder: (context) =>
                                                  //                   ChooseOneBrandChangeScreen(
                                                  //                     typeFashion: widget.typeFashion,
                                                  //                       governmentId: widget
                                                  //                           .governmentId,
                                                  //                       governmentName: widget
                                                  //                           .governmentName,
                                                  //                       cityId: widget.cityId,
                                                  //                       product: state.showDetailsProductResponseModel![0],
                                                  //                       year: productDetailsCubit.yearOfProductController.text,
                                                  //                       downPayment: productDetailsCubit.downPaymentController.text,
                                                  //                       area: productDetailsCubit.areaPropertiesController.text,
                                                  //                       bathroom: productDetailsCubit.bathroomOfProductController.text,
                                                  //                       bedroom: productDetailsCubit.bedroomOfProductController.text,
                                                  //                       cityName: widget.cityName,
                                                  //                       areaId: widget.areaId,
                                                  //                       areaName: widget.areaName,
                                                  //                       toPrice: productDetailsCubit.newPriceController.text,
                                                  //                       fromPrice: productDetailsCubit.oldPriceController
                                                  //                           .text,
                                                  //                       levelType: widget.levelType,
                                                  //                       kiloMetresType: productDetailsCubit.kiloMetresOfProductController.text,
                                                  //                       amenitiesType: widget.amenitiesType,
                                                  //                       fuelType: widget.fuelType,
                                                  //                       engineCapacityType: widget.engineCapacityType,
                                                  //                       colorType: widget.colorType,
                                                  //                       bodyType: widget.bodyType,
                                                  //                       nameProduct: productDetailsCubit.nameOfProductController
                                                  //                           .text,
                                                  //                       description: productDetailsCubit.descriptionController
                                                  //                           .text,
                                                  //                       data: ''),
                                                  //             ));
                                                  //       }else {
                                                  //         customFlutterToast(
                                                  //             LocaleKeys.pleaseSelectMainCategoryFirst.tr());
                                                  //       }
                                                  //     }
                                                  // ),
                                                  // 15.heightBox,
                                                  Row(
                                                    children: [
                                                      Text(LocaleKeys.type.tr(),
                                                          style: const TextStyle(
                                                              color: AppPalette.black,
                                                              fontWeight: FontWeight.w500)),
                                                    ],
                                                  ),
                                                  10.heightBox,
                                                  CustomButtonWidget(
                                                      title:
                                                      context.locale.languageCode.contains('en') ?
                                                      widget.typeFashion == null ?
                                                      state.showDetailsProductResponseModel![0].options![0].value!.contains('null') ?
                                                      LocaleKeys.type.tr()  :
                                                      state.showDetailsProductResponseModel![0].options![0].value!  : '${widget.typeFashion}':
                                                      context.locale.languageCode.contains('ar') ?
                                                      widget.typeFashion == null ?
                                                      state.showDetailsProductResponseModel![0].options![0].valueAr!.contains('null') ?
                                                      LocaleKeys.type.tr()  :
                                                      state.showDetailsProductResponseModel![0].options![0].valueAr!  : '${widget.typeFashion}' : '',
                                                      onTap: () {
                                                        Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
                                                            ChooseFashionsProductScreen(
                                                              governmentId: widget
                                                                  .governmentId,
                                                              governmentName: widget
                                                                  .governmentName,
                                                              typeFashions: widget.typeFashion,
                                                              cityId: widget.cityId,
                                                              typeCondtion: widget.typeCondtion,
                                                              cityName: widget.cityName,
                                                              areaId: widget.areaId,
                                                              areaName: widget.areaName,
                                                              toPrice: productDetailsCubit.newPriceController
                                                                  .text,
                                                              fromPrice: productDetailsCubit.oldPriceController
                                                                  .text,
                                                              whatsAppNumber: productDetailsCubit.whatsAppController.text,
                                                              nameProduct: productDetailsCubit.nameOfProductController.text,
                                                              description: productDetailsCubit.descriptionController.text,
                                                              locationUser: productDetailsCubit.locationUserController.text,
                                                            )));
                                                      }),
                                                  15.heightBox,
                                                  Row(
                                                    children: [
                                                      Text(LocaleKeys.condition.tr(),
                                                          style: const TextStyle(
                                                              color: AppPalette.black,
                                                              fontWeight: FontWeight.w500)),
                                                    ],
                                                  ),
                                                  10.heightBox,
                                                  CustomButtonWidget(
                                                      title: widget.typeCondtion == null ?
                                                      '$selectedConditionItems'
                                                          : '${widget.typeCondtion}',
                                                      onTap: () {
                                                        Navigator.of(context).push(MaterialPageRoute(
                                                            builder: (context) => ChooseConditionProductScreen(
                                                              governmentId: widget.governmentId,
                                                              governmentName: widget.governmentName,
                                                              cityId: widget.cityId,
                                                              typeFashions: widget.typeFashion,
                                                              typeCondtion: widget.typeCondtion,
                                                              typeBusiness: widget.typeBusiness,
                                                              downPayment: productDetailsCubit.downPaymentController.text,
                                                              area: productDetailsCubit.areaPropertiesController.text,
                                                              bathroom: productDetailsCubit.bathroomOfProductController.text,
                                                              bedroom: productDetailsCubit.bedroomOfProductController.text,
                                                              cityName: widget.cityName,
                                                              areaId: widget.areaId,
                                                              areaName: widget.areaName,
                                                              toPrice: productDetailsCubit.newPriceController.text,
                                                              fromPrice: productDetailsCubit.oldPriceController.text,
                                                              levelType: widget.levelType,
                                                              amenitiesType: widget.amenitiesType,
                                                              whatsAppNumber: productDetailsCubit.whatsAppController.text,
                                                              nameProduct: productDetailsCubit.nameOfProductController.text,
                                                              description: productDetailsCubit.descriptionController.text,
                                                              locationUser: productDetailsCubit.locationUserController.text,
                                                            )));
                                                      }),
                                                  10.heightBox,
                                                ],
                                              ) : Container() : Container(),
                                              ////// Kids & Babies Category
                                              state.showDetailsProductResponseModel![0].category != null ?
                                              state.showDetailsProductResponseModel![0].category!.name!.en!
                                                  .contains('Kids & Babies') ?
                                              Column(
                                                children: [
                                                  15.heightBox,
                                                  Row(
                                                    children: [
                                                      Text(LocaleKeys.type.tr(),
                                                          style: const TextStyle(
                                                              color: AppPalette.black,
                                                              fontWeight: FontWeight.w500)),
                                                    ],
                                                  ),
                                                  10.heightBox,
                                                  CustomButtonWidget(
                                                      title:
                                                      context.locale.languageCode.contains('en') ?
                                                      widget.typeKids == null ?
                                                      state.showDetailsProductResponseModel![0].options![0].value!.contains('null') ?
                                                      LocaleKeys.type.tr()  :
                                                      state.showDetailsProductResponseModel![0].options![0].value!  : '${widget.typeKids}':
                                                      context.locale.languageCode.contains('ar') ?
                                                      widget.typeKids == null ?
                                                      state.showDetailsProductResponseModel![0].options![0].valueAr!.contains('null') ?
                                                      LocaleKeys.type.tr()  :
                                                      state.showDetailsProductResponseModel![0].options![0].valueAr!  : '${widget.typeKids}' : '',
                                                      onTap: () {
                                                        Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
                                                            ChooseKidsProductScreen(
                                                              governmentId: widget
                                                                  .governmentId,
                                                              governmentName: widget
                                                                  .governmentName,
                                                              cityId: widget.cityId,
                                                              typeKids: widget.typeKids,
                                                              cityName: widget.cityName,
                                                              areaId: widget.areaId,
                                                              areaName: widget.areaName,
                                                              typeCondtion: widget.typeCondtion,
                                                              toPrice: productDetailsCubit.newPriceController
                                                                  .text,
                                                              fromPrice: productDetailsCubit.oldPriceController
                                                                  .text,
                                                              whatsAppNumber: productDetailsCubit.whatsAppController.text,
                                                              nameProduct: productDetailsCubit.nameOfProductController.text,
                                                              description: productDetailsCubit.descriptionController.text,
                                                              locationUser: productDetailsCubit.locationUserController.text,
                                                            )));
                                                      }),
                                                  15.heightBox,
                                                  Row(
                                                    children: [
                                                      Text(LocaleKeys.condition.tr(),
                                                          style: const TextStyle(
                                                              color: AppPalette.black,
                                                              fontWeight: FontWeight.w500)),
                                                    ],
                                                  ),
                                                  10.heightBox,
                                                  CustomButtonWidget(
                                                      title: widget.typeCondtion == null ?
                                                      '$selectedConditionItems'
                                                          : '${widget.typeCondtion}',
                                                      onTap: () {
                                                        Navigator.of(context).push(MaterialPageRoute(
                                                            builder: (context) => ChooseConditionProductScreen(
                                                              governmentId: widget.governmentId,
                                                              governmentName: widget.governmentName,
                                                              cityId: widget.cityId,
                                                              typeCondtion: widget.typeCondtion,
                                                              typeBusiness: widget.typeBusiness,
                                                              typeWarrannt: widget.typeWarrannt,
                                                              downPayment: productDetailsCubit.downPaymentController.text,
                                                              area: productDetailsCubit.areaPropertiesController.text,
                                                              bathroom: productDetailsCubit.bathroomOfProductController.text,
                                                              bedroom: productDetailsCubit.bedroomOfProductController.text,
                                                              cityName: widget.cityName,
                                                              areaId: widget.areaId,
                                                              areaName: widget.areaName,
                                                              toPrice: productDetailsCubit.newPriceController.text,
                                                              fromPrice: productDetailsCubit.oldPriceController.text,
                                                              levelType: widget.levelType,
                                                              amenitiesType: widget.amenitiesType,
                                                              whatsAppNumber: productDetailsCubit.whatsAppController.text,
                                                              nameProduct: productDetailsCubit.nameOfProductController.text,
                                                              description: productDetailsCubit.descriptionController.text,
                                                              locationUser: productDetailsCubit.locationUserController.text,
                                                            )));
                                                      }),
                                                  10.heightBox,
                                                ],
                                              ) : Container() : Container(),
                                              ////// Books, Sports & Hobbies Category
                                              state.showDetailsProductResponseModel![0].category != null ?
                                              state.showDetailsProductResponseModel![0].category!.name!.en!
                                                  .contains('Books, Sports & Hobbies') ?
                                              Column(
                                                children: [
                                                  15.heightBox,
                                                  Row(
                                                    children: [
                                                      Text(LocaleKeys.type.tr(),
                                                          style: const TextStyle(
                                                              color: AppPalette.black,
                                                              fontWeight: FontWeight.w500)),
                                                    ],
                                                  ),
                                                  10.heightBox,
                                                  CustomButtonWidget(
                                                      title:
                                                      context.locale.languageCode.contains('en') ?
                                                      widget.typeBooks == null ?
                                                      state.showDetailsProductResponseModel![0].options![0].value!.contains('null') ?
                                                      LocaleKeys.type.tr()  :
                                                      state.showDetailsProductResponseModel![0].options![0].value!  : '${widget.typeBooks}':
                                                      context.locale.languageCode.contains('ar') ?
                                                      widget.typeBooks == null ?
                                                      state.showDetailsProductResponseModel![0].options![0].valueAr!.contains('null') ?
                                                      LocaleKeys.type.tr()  :
                                                      state.showDetailsProductResponseModel![0].options![0].valueAr!  : '${widget.typeBooks}' : '',
                                                      onTap: () {
                                                        Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
                                                            ChooseBooksProductScreen(
                                                              governmentId: widget.governmentId,
                                                              governmentName: widget.governmentName,
                                                              cityId: widget.cityId,
                                                              typeCondtion: selectedConditionItems,
                                                              typeBooks: widget.typeBooks,
                                                              downPayment: productDetailsCubit.downPaymentController.text,
                                                              area: productDetailsCubit.areaPropertiesController.text,
                                                              bathroom: productDetailsCubit.bathroomOfProductController.text,
                                                              bedroom: productDetailsCubit.bedroomOfProductController.text,
                                                              cityName: widget.cityName,
                                                              areaId: widget.areaId,
                                                              areaName: widget.areaName,
                                                              toPrice: productDetailsCubit.newPriceController
                                                                  .text,
                                                              fromPrice: productDetailsCubit.oldPriceController
                                                                  .text,
                                                              levelType: widget.levelType,
                                                              amenitiesType: widget.amenitiesType,
                                                              whatsAppNumber: productDetailsCubit.whatsAppController.text,
                                                              nameProduct: productDetailsCubit.nameOfProductController.text,
                                                              description: productDetailsCubit.descriptionController.text,
                                                              locationUser: productDetailsCubit.locationUserController.text,
                                                            )));
                                                      }),
                                                  15.heightBox,
                                                  Row(
                                                    children: [
                                                      Text(LocaleKeys.condition.tr(),
                                                          style: const TextStyle(
                                                              color: AppPalette.black,
                                                              fontWeight: FontWeight.w500)),
                                                    ],
                                                  ),
                                                  10.heightBox,
                                                  CustomButtonWidget(
                                                      title: widget.typeCondtion == null ?
                                                      '$selectedConditionItems'
                                                          : '${widget.typeCondtion}',
                                                      onTap: () {
                                                        Navigator.of(context).push(MaterialPageRoute(
                                                            builder: (context) => ChooseConditionProductScreen(
                                                              governmentId: widget.governmentId,
                                                              governmentName: widget.governmentName,
                                                              cityId: widget.cityId,
                                                              typeCondtion: selectedConditionItems,
                                                              cityName: widget.cityName,
                                                              areaId: widget.areaId,
                                                              areaName: widget.areaName,
                                                              typeBooks: widget.typeBooks,
                                                              toPrice: productDetailsCubit.newPriceController.text,
                                                              fromPrice: productDetailsCubit.oldPriceController.text,
                                                              whatsAppNumber: productDetailsCubit.whatsAppController.text,
                                                              nameProduct: productDetailsCubit.nameOfProductController.text,
                                                              description: productDetailsCubit.descriptionController.text,
                                                              locationUser: productDetailsCubit.locationUserController.text,
                                                            )));
                                                      }),
                                                  10.heightBox,
                                                ],
                                              ) : Container() : Container(),
                                              ////// Business - Industrial - Agriculture Category
                                              state.showDetailsProductResponseModel![0].category != null ?
                                              state.showDetailsProductResponseModel![0].category!.name!.en!
                                                  .contains('Business - Industrial - Agriculture') ?
                                              Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(LocaleKeys.type.tr(),
                                                          style: const TextStyle(
                                                              color: AppPalette.black,
                                                              fontWeight: FontWeight.w500)),
                                                    ],
                                                  ),
                                                  10.heightBox,
                                                  CustomButtonWidget(
                                                      title:
                                                      context.locale.languageCode.contains('en') ?
                                                      widget.typeBusiness == null ?
                                                      state.showDetailsProductResponseModel![0].options![0].value!.contains('null') ?
                                                      LocaleKeys.type.tr()  :
                                                      state.showDetailsProductResponseModel![0].options![0].value!  : '${widget.typeBusiness}':
                                                      context.locale.languageCode.contains('ar') ?
                                                      widget.typeBusiness == null ?
                                                      state.showDetailsProductResponseModel![0].options![0].valueAr!.contains('null') ?
                                                      LocaleKeys.type.tr()  :
                                                      state.showDetailsProductResponseModel![0].options![0].valueAr!  : '${widget.typeBusiness}' : '',
                                                      onTap: () {
                                                        Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
                                                            ChooseBusinessProductScreen(
                                                              governmentId: widget
                                                                  .governmentId,
                                                              governmentName: widget
                                                                  .governmentName,
                                                              cityId: widget.cityId,
                                                              typeBusiness: widget.typeBusiness,
                                                              typeCondtion: widget.typeCondtion,
                                                              downPayment: productDetailsCubit.downPaymentController.text,
                                                              area: productDetailsCubit.areaPropertiesController.text,
                                                              bathroom: productDetailsCubit.bathroomOfProductController.text,
                                                              bedroom: productDetailsCubit.bedroomOfProductController.text,
                                                              cityName: widget.cityName,
                                                              areaId: widget.areaId,
                                                              areaName: widget.areaName,
                                                              toPrice: productDetailsCubit.newPriceController
                                                                  .text,
                                                              fromPrice: productDetailsCubit.oldPriceController
                                                                  .text,
                                                              levelType: widget.levelType,
                                                              amenitiesType: widget.amenitiesType,
                                                              whatsAppNumber: productDetailsCubit.whatsAppController.text,
                                                              nameProduct: productDetailsCubit.nameOfProductController.text,
                                                              description: productDetailsCubit.descriptionController.text,
                                                              locationUser: productDetailsCubit.locationUserController.text,
                                                            )));
                                                      }),
                                                  15.heightBox,
                                                  Row(
                                                    children: [
                                                      Text(LocaleKeys.condition.tr(),
                                                          style: const TextStyle(
                                                              color: AppPalette.black,
                                                              fontWeight: FontWeight.w500)),
                                                    ],
                                                  ),
                                                  10.heightBox,
                                                  CustomButtonWidget(
                                                      title: widget.typeCondtion == null ?
                                                      '$selectedConditionItems'
                                                          : '${widget.typeCondtion}',
                                                      onTap: () {
                                                        Navigator.of(context).push(MaterialPageRoute(
                                                            builder: (context) => ChooseConditionProductScreen(
                                                              governmentId: widget.governmentId,
                                                              governmentName: widget.governmentName,
                                                              cityId: widget.cityId,
                                                              typeCondtion: widget.typeCondtion,
                                                              typeBusiness: widget.typeBusiness,
                                                              downPayment: productDetailsCubit.downPaymentController.text,
                                                              area: productDetailsCubit.areaPropertiesController.text,
                                                              bathroom: productDetailsCubit.bathroomOfProductController.text,
                                                              bedroom: productDetailsCubit.bedroomOfProductController.text,
                                                              cityName: widget.cityName,
                                                              areaId: widget.areaId,
                                                              areaName: widget.areaName,
                                                              toPrice: productDetailsCubit.newPriceController.text,
                                                              fromPrice: productDetailsCubit.oldPriceController.text,
                                                              levelType: widget.levelType,
                                                              amenitiesType: widget.amenitiesType,
                                                              whatsAppNumber: productDetailsCubit.whatsAppController.text,
                                                              nameProduct: productDetailsCubit.nameOfProductController.text,
                                                              description: productDetailsCubit.descriptionController.text,
                                                              locationUser: productDetailsCubit.locationUserController.text,
                                                            )));
                                                      }),
                                                  10.heightBox,
                                                ],
                                              ) : Container() : Container(),
                                              ////// Vehicles Category
                                              state.showDetailsProductResponseModel![0].category != null ?
                                              state.showDetailsProductResponseModel![0].category!.name!.en!
                                                  .contains('Vehicles') ?
                                              Column(
                                                children: [
                                                  15.heightBox,
                                                  Row(
                                                    children: [
                                                      Text(LocaleKeys.fuelType.tr(),
                                                          style: const TextStyle(
                                                              color: AppPalette.black,
                                                              fontWeight: FontWeight.w500)),
                                                    ],
                                                  ),
                                                  10.heightBox,
                                                  CustomButtonWidget(
                                                      title:
                                                      context.locale.languageCode.contains('en') ?
                                                      widget.fuelType == null ?
                                                      state.showDetailsProductResponseModel![0].options![0].value!.contains('null') ?
                                                      LocaleKeys.fuelType.tr()  :
                                                      state.showDetailsProductResponseModel![0].options![0].value!  : '${widget.fuelType}':
                                                      context.locale.languageCode.contains('ar') ?
                                                      widget.fuelType == null ?
                                                      state.showDetailsProductResponseModel![0].options![0].valueAr!.contains('null') ?
                                                      LocaleKeys.fuelType.tr()  :
                                                      state.showDetailsProductResponseModel![0].options![0].valueAr!  : '${widget.fuelType}' : '',
                                                      onTap: () {
                                                        Navigator.push(context,  MaterialPageRoute(
                                                            builder: (context) => ChooseFuelTypeAddProductScreen(
                                                              governmentId: widget
                                                                  .governmentId,
                                                              governmentName: widget
                                                                  .governmentName,
                                                              cityId: widget.cityId,
                                                              data: 'changeProduct',
                                                              productId: widget.product?.id.toString(),
                                                              year: productDetailsCubit.yearOfProductController.text,
                                                              cityName: widget.cityName,
                                                              areaId: widget.areaId,
                                                              areaName: widget.areaName,
                                                              toPrice: productDetailsCubit.newPriceController
                                                                  .text,
                                                              fromPrice: productDetailsCubit.oldPriceController
                                                                  .text,
                                                              typeCondtion: widget.typeCondtion,
                                                              whatsAppNumber: productDetailsCubit.whatsAppController.text,
                                                              typeTransmission: widget.transmissionVehicles,
                                                              kiloMetresType: productDetailsCubit.kiloMetresOfProductController.text,
                                                              fuelType: widget.fuelType,
                                                              engineCapacityType: widget.engineCapacityType,
                                                              colorType: widget.colorType,
                                                              bodyType: widget.bodyType,
                                                              nameProduct: productDetailsCubit.nameOfProductController
                                                                  .text,
                                                              description: productDetailsCubit.descriptionController
                                                                  .text,
                                                              locationUser: productDetailsCubit.locationUserController.text,
                                                            )));
                                                      }),
                                                  15.heightBox,
                                                  Row(
                                                    children: [
                                                      Text(LocaleKeys.brand.tr(),
                                                          style: const TextStyle(
                                                              color: AppPalette.black,
                                                              fontWeight: FontWeight.w500)),
                                                    ],
                                                  ),
                                                  10.heightBox,
                                                  CustomButtonWidget(
                                                      title: state.showDetailsProductResponseModel![0].brand?.name ==
                                                          null ? LocaleKeys.brand.tr() :
                                                      context.locale.languageCode.contains('en')
                                                          ? addProductController.selectedBrand?.brandName == null ?
                                                      '${state.showDetailsProductResponseModel![0].brand!.name?.en!}' :
                                                      '${addProductController.selectedBrand!.brandName?.en!}' :
                                                      context.locale.languageCode.contains('ar')
                                                          ? addProductController.selectedBrand?.brandName == null ?
                                                      '${state.showDetailsProductResponseModel![0].brand!.name?.ar!}' :
                                                      '${addProductController.selectedBrand?.brandName?.ar!}' :
                                                      context.locale.languageCode.contains('tr')
                                                          ? addProductController.selectedBrand!.brandName == null ?
                                                      '${state.showDetailsProductResponseModel![0].brand!.name?.tr!}' :
                                                      '${addProductController.selectedBrand?.brandName?.tr!}' :
                                                      context.locale.languageCode.contains('de')
                                                          ? addProductController.selectedBrand!.brandName == null ?
                                                      '${state.showDetailsProductResponseModel![0].brand!.name?.de!}' :
                                                      '${addProductController.selectedBrand!.brandName?.de!}'
                                                          : LocaleKeys.brand.tr(),
                                                      onTap: (){
                                                        if(state.showDetailsProductResponseModel![0].category?.id != null){
                                                          BlocProvider.of<CategoriesCubit>(context).getBrandsByCategory(
                                                              categoryID: state.showDetailsProductResponseModel![0].category!.id!);
                                                          Navigator.of(context).push(
                                                              MaterialPageRoute(
                                                                builder: (context) =>
                                                                    ChooseOneBrandChangeScreen(
                                                                        typeWarrannt: widget.typeWarrannt,
                                                                        governmentId: widget
                                                                            .governmentId,
                                                                        governmentName: widget
                                                                            .governmentName,
                                                                        product: state.showDetailsProductResponseModel![0],
                                                                        cityId: widget.cityId,
                                                                        typeCondtion: widget.typeCondtion,
                                                                        transmissionVehicles: widget.transmissionVehicles,
                                                                        year: productDetailsCubit.yearOfProductController.text,
                                                                        cityName: widget.cityName,
                                                                        areaId: widget.areaId,
                                                                        areaName: widget.areaName,
                                                                        toPrice: productDetailsCubit.newPriceController.text,
                                                                        fromPrice: productDetailsCubit.oldPriceController
                                                                            .text,
                                                                        kiloMetresType: productDetailsCubit.kiloMetresOfProductController.text,
                                                                        fuelType: widget.fuelType,
                                                                        engineCapacityType: widget.engineCapacityType,
                                                                        colorType: widget.colorType,
                                                                        bodyType: widget.bodyType,
                                                                        nameProduct: productDetailsCubit.nameOfProductController
                                                                            .text,
                                                                        description: productDetailsCubit.descriptionController
                                                                            .text,
                                                                        data: ''),
                                                              ));
                                                        }else {
                                                          customFlutterToast(
                                                              LocaleKeys.pleaseSelectMainCategoryFirst.tr());
                                                        }
                                                      }
                                                  ),
                                                  15.heightBox,
                                                  // if (addProductController.selectedBrand != null)
                                                  //   15.heightBox,
                                                  // addProductState is GetOptionLoadingState ?
                                                  // const CircularProgressIndicator() :
                                                  // addProductState is GetOptionSuccessState ?
                                                  // addProductState.brandModelCarModel!.data != null ?
                                                  // Column(
                                                  //   children: [
                                                  //     Row(
                                                  //       children: [
                                                  //         Text(LocaleKeys.modelName.tr(),
                                                  //           style: const TextStyle(
                                                  //               color: AppPalette.black,
                                                  //               fontWeight: FontWeight.w500),),
                                                  //       ],
                                                  //     ),
                                                  //     10.heightBox,
                                                  //     Container(
                                                  //       decoration: BoxDecoration(
                                                  //           borderRadius: BorderRadius.circular(15),
                                                  //           border: Border.all(color: AppPalette.primary,width: 1)
                                                  //       ),
                                                  //       child: DropdownButton(
                                                  //         isExpanded: true,
                                                  //         onTap: () {
                                                  //           setState(() {
                                                  //             //  print(dropdownValueAddresses!.address);
                                                  //           });
                                                  //         },
                                                  //         value: addProductController.dropdownValueBrand,
                                                  //         icon: const Icon(Icons.arrow_drop_down),
                                                  //         iconSize: 24,
                                                  //         elevation: 16,
                                                  //         hint:  Center(
                                                  //           child:  Text(state.showDetailsProductResponseModel![0].options![7].value != 'null' ?
                                                  //           '${state.showDetailsProductResponseModel![0].options![7].value}' :
                                                  //           LocaleKeys.modelbrandName.tr(),
                                                  //             style: const TextStyle(
                                                  //                 fontSize: 15,
                                                  //                 color: AppPalette.black,
                                                  //                 fontWeight: FontWeight.w500),),
                                                  //         ),
                                                  //         style: const TextStyle(
                                                  //             color: AppPalette.black,
                                                  //             fontSize: 18),
                                                  //         underline: Container(
                                                  //           height: 0,
                                                  //           color: Colors.deepPurpleAccent,
                                                  //         ),
                                                  //         onChanged: (String? data) {
                                                  //           setState(() {
                                                  //             addProductController.dropdownValueBrand = data;
                                                  //             print("selected $data");
                                                  //             print("selected ${addProductController.dropdownValueBrand}");
                                                  //
                                                  //
                                                  //           });
                                                  //         },
                                                  //         items: addProductState.brandModelCarModel!.data![0].optionsLabel!.map((item) {
                                                  //           return DropdownMenuItem<String>(
                                                  //               value: state.showDetailsProductResponseModel![0].options![7].value == 'null' ?
                                                  //               item : '${state.showDetailsProductResponseModel![0].options![7].value}',
                                                  //               child: Container(
                                                  //                 width: double.infinity,
                                                  //                 child: Center(
                                                  //                   child: Text(
                                                  //                       item,
                                                  //                       overflow: TextOverflow
                                                  //                           .ellipsis,
                                                  //                       maxLines: 1,
                                                  //                       style: const TextStyle(
                                                  //                           fontSize: 15,
                                                  //                           color: AppPalette.black,
                                                  //                           fontWeight: FontWeight.w500)
                                                  //                   ),
                                                  //                 ),
                                                  //               ));
                                                  //         }).toList(),
                                                  //       ),
                                                  //     ),
                                                  //     const SizedBox(
                                                  //       height: 5,
                                                  //     ),
                                                  //   ],
                                                  // ) : const CircularProgressIndicator() : Container(),
                                                  Row(
                                                    children: [
                                                      Text(LocaleKeys.year.tr(),
                                                          style: const TextStyle(
                                                              color: AppPalette.black,
                                                              fontWeight: FontWeight.w500)),
                                                    ],
                                                  ),
                                                  10.heightBox,
                                                  InputTextFormField(
                                                    hintText: LocaleKeys.year.tr(),
                                                    textEditingController:
                                                    productDetailsCubit.yearOfProductController,
                                                    textInputType: TextInputType.number,
                                                    validator: (val) {
                                                      // if (val.isEmpty) {
                                                      //   return LocaleKeys.mustNotEmpty.tr();
                                                      // }
                                                    },
                                                  ),
                                                  15.heightBox,
                                                  Row(
                                                    children: [
                                                      Text(LocaleKeys.kilometers.tr(),
                                                          style: const TextStyle(
                                                              color: AppPalette.black,
                                                              fontWeight: FontWeight.w500)),
                                                    ],
                                                  ),
                                                  10.heightBox,
                                                  InputTextFormField(
                                                    hintText: LocaleKeys.kilometers.tr(),
                                                    textEditingController:
                                                    productDetailsCubit.kiloMetresOfProductController,
                                                    textInputType: TextInputType.number,
                                                    validator: (val) {
                                                      // if (val.isEmpty) {
                                                      //   return LocaleKeys.mustNotEmpty.tr();
                                                      // }
                                                    },
                                                  ),
                                                  15.heightBox,
                                                  Row(
                                                    children: [
                                                      Text(LocaleKeys.transmissionType.tr(),
                                                        style: const TextStyle(
                                                            color: AppPalette.black,
                                                            fontWeight: FontWeight.w500),),
                                                    ],
                                                  ),
                                                  10.heightBox,
                                                  CustomButtonWidget(
                                                      title:
                                                      context.locale.languageCode.contains('en') ?
                                                      widget.transmissionVehicles == null ?
                                                      state.showDetailsProductResponseModel![0].options![3].value!.contains('null') ?
                                                      LocaleKeys.transmissionType.tr()  :
                                                      state.showDetailsProductResponseModel![0].options![3].value!  : '${widget.transmissionVehicles}':
                                                      context.locale.languageCode.contains('ar') ?
                                                      widget.transmissionVehicles == null ?
                                                      state.showDetailsProductResponseModel![0].options![3].valueAr!.contains('null') ?
                                                      LocaleKeys.transmissionType.tr()  :
                                                      state.showDetailsProductResponseModel![0].options![3].valueAr!  : '${widget.transmissionVehicles}' : '',
                                                      onTap: () {
                                                        Navigator.of(context).push(MaterialPageRoute(
                                                            builder: (context) => ChooseTransmissionProductScreen(
                                                              governmentId: widget.governmentId,
                                                              governmentName: widget.governmentName,
                                                              cityId: widget.cityId,
                                                              typeCondtion: widget.typeCondtion,
                                                              typeTransmission: widget.transmissionVehicles,
                                                              productId: widget.product?.id.toString(),
                                                              year: productDetailsCubit.yearOfProductController.text,
                                                              cityName: widget.cityName,
                                                              areaId: widget.areaId,
                                                              areaName: widget.areaName,
                                                              toPrice: productDetailsCubit.newPriceController.text,
                                                              fromPrice: productDetailsCubit.oldPriceController.text,
                                                              kiloMetresType: productDetailsCubit.kiloMetresOfProductController.text,
                                                              fuelType: widget.fuelType,
                                                              engineCapacityType: widget.engineCapacityType,
                                                              colorType: widget.colorType,
                                                              bodyType: widget.bodyType,
                                                              whatsAppNumber: productDetailsCubit.whatsAppController.text,
                                                              nameProduct: productDetailsCubit.nameOfProductController.text,
                                                              description: productDetailsCubit.descriptionController.text,
                                                              locationUser: productDetailsCubit.locationUserController.text,
                                                            )));
                                                      }),
                                                  15.heightBox,
                                                  Row(
                                                    children: [
                                                      Text(LocaleKeys.condition.tr(),
                                                          style: const TextStyle(
                                                              color: AppPalette.black,
                                                              fontWeight: FontWeight.w500)),
                                                    ],
                                                  ),
                                                  10.heightBox,
                                                  CustomButtonWidget(
                                                      title: widget.typeCondtion == null ?
                                                      '$selectedConditionItems'
                                                          : '${widget.typeCondtion}',
                                                      onTap: () {
                                                        Navigator.of(context).push(MaterialPageRoute(
                                                            builder: (context) => ChooseConditionProductScreen(
                                                              governmentId: widget.governmentId,
                                                              governmentName: widget.governmentName,
                                                              cityId: widget.cityId,
                                                              typeCondtion: widget.typeCondtion,
                                                              typeTransmission: widget.transmissionVehicles,
                                                              productId: widget.product?.id.toString(),
                                                              year: productDetailsCubit.yearOfProductController.text,
                                                              cityName: widget.cityName,
                                                              areaId: widget.areaId,
                                                              areaName: widget.areaName,
                                                              toPrice: productDetailsCubit.newPriceController.text,
                                                              fromPrice: productDetailsCubit.oldPriceController.text,
                                                              kiloMetresType: productDetailsCubit.kiloMetresOfProductController.text,
                                                              fuelType: widget.fuelType,
                                                              engineCapacityType: widget.engineCapacityType,
                                                              colorType: widget.colorType,
                                                              bodyType: widget.bodyType,
                                                              whatsAppNumber: productDetailsCubit.whatsAppController.text,
                                                              nameProduct: productDetailsCubit.nameOfProductController.text,
                                                              description: productDetailsCubit.descriptionController.text,
                                                              locationUser: productDetailsCubit.locationUserController.text,
                                                            )));
                                                      }),
                                                ],
                                              )
                                                  : Container() : Container(),
                                              ////// Electronics Category
                                              state.showDetailsProductResponseModel![0].category != null ?
                                              state.showDetailsProductResponseModel![0].category!.name!.en!
                                                  .contains('Electronics') ?
                                              Column(
                                                children: [
                                                  CustomButtonWidget(
                                                      title: state.showDetailsProductResponseModel![0].brandId ==
                                                          null ? LocaleKeys.brand.tr() :
                                                      context.locale.languageCode.contains('en')
                                                          ? addProductController.selectedBrand?.brandName == null ?
                                                      '${state.showDetailsProductResponseModel![0].brand!.name?.en!}' :
                                                      '${addProductController.selectedBrand!.brandName?.en!}' :
                                                      context.locale.languageCode.contains('ar')
                                                          ? addProductController.selectedBrand?.brandName == null ?
                                                      '${state.showDetailsProductResponseModel![0].brand!.name?.ar!}' :
                                                      '${addProductController.selectedBrand?.brandName?.ar!}' :
                                                      context.locale.languageCode.contains('tr')
                                                          ? addProductController.selectedBrand!.brandName == null ?
                                                      '${state.showDetailsProductResponseModel![0].brand!.name?.tr!}' :
                                                      '${addProductController.selectedBrand?.brandName?.tr!}' :
                                                      context.locale.languageCode.contains('de')
                                                          ? addProductController.selectedBrand!.brandName == null ?
                                                      '${state.showDetailsProductResponseModel![0].brand!.name?.de!}' :
                                                      '${addProductController.selectedBrand!.brandName?.de!}'
                                                          : ' ',
                                                      onTap: (){

                                                        //   CustomFlutterToast('dsaddsa ${state.showDetailsProductResponseModel![0].id.toString()}');

                                                        if(state.showDetailsProductResponseModel![0].category?.id != null){
                                                          BlocProvider.of<CategoriesCubit>(context).getBrandsByCategory(
                                                              categoryID: state.showDetailsProductResponseModel![0].category!.id!);
                                                          Navigator.of(context).push(
                                                              MaterialPageRoute(
                                                                builder: (context) =>
                                                                    ChooseOneBrandChangeScreen(
                                                                        typeWarrannt: widget.typeWarrannt,
                                                                        governmentId: widget.governmentId,
                                                                        governmentName: widget.governmentName,
                                                                        product: state.showDetailsProductResponseModel![0],
                                                                        cityId: widget.cityId,
                                                                        cityName: widget.cityName,
                                                                        typeCondtion: widget.typeCondtion,
                                                                        whatsAppNumber: productDetailsCubit.whatsAppController.text,
                                                                        locationUser: productDetailsCubit.locationUserController.text,
                                                                        toPrice: productDetailsCubit.newPriceController.text,
                                                                        fromPrice: productDetailsCubit.oldPriceController.text,
                                                                        nameProduct: productDetailsCubit.nameOfProductController.text,
                                                                        description: productDetailsCubit.descriptionController.text,
                                                                        data: ''),
                                                              ));
                                                        }else {
                                                          customFlutterToast(
                                                              LocaleKeys.pleaseSelectMainCategoryFirst.tr());
                                                        }

                                                      }
                                                  ),
                                                  15.heightBox,
                                                  Row(
                                                    children: [
                                                      Text(LocaleKeys.warranty.tr(),
                                                        style: const TextStyle(
                                                            color: AppPalette.black,
                                                            fontWeight: FontWeight.w500),),
                                                    ],
                                                  ),
                                                  10.heightBox,
                                                  CustomButtonWidget(
                                                      title:
                                                      context.locale.languageCode.contains('en') ?
                                                      widget.typeWarrannt == null ?
                                                      '${state.showDetailsProductResponseModel![0].options![0].value!.contains('null') ?
                                                      LocaleKeys.warranty.tr() :
                                                      state.showDetailsProductResponseModel![0].options![0].value}'
                                                          : '${widget.typeWarrannt}':
                                                      context.locale.languageCode.contains('ar') ?
                                                      widget.typeWarrannt == null ?
                                                      '${state.showDetailsProductResponseModel![0].options![0].valueAr!.contains('null') ?
                                                      LocaleKeys.warranty.tr() :
                                                      state.showDetailsProductResponseModel![0].options![0].valueAr}'
                                                          : '${widget.typeWarrannt}': '',
                                                      onTap: () {
                                                        Navigator.of(context).push(MaterialPageRoute(
                                                            builder: (context) => ChooseWarrantyProductScreen(
                                                              governmentId: widget.governmentId,
                                                              governmentName: widget.governmentName,
                                                              cityId: widget.cityId,
                                                              typeCondtion: widget.typeCondtion,
                                                              typeWarranty: widget.typeWarrannt,
                                                              cityName: widget.cityName,
                                                              toPrice: productDetailsCubit.newPriceController.text,
                                                              fromPrice: productDetailsCubit.oldPriceController.text,
                                                              whatsAppNumber: productDetailsCubit.whatsAppController.text,
                                                              nameProduct: productDetailsCubit.nameOfProductController.text,
                                                              description: productDetailsCubit.descriptionController.text,
                                                              locationUser: productDetailsCubit.locationUserController.text,
                                                            )));
                                                      }),
                                                  15.heightBox,
                                                  Row(
                                                    children: [
                                                      Text(LocaleKeys.condition.tr(),
                                                          style: const TextStyle(
                                                              color: AppPalette.black,
                                                              fontWeight: FontWeight.w500)),
                                                    ],
                                                  ),
                                                  10.heightBox,
                                                  CustomButtonWidget(
                                                      title: widget.typeCondtion == null ?
                                                      '$selectedConditionItems'
                                                          : '${widget.typeCondtion}',
                                                      onTap: () {
                                                        Navigator.of(context).push(MaterialPageRoute(
                                                            builder: (context) => ChooseConditionProductScreen(
                                                              governmentId: widget.governmentId,
                                                              governmentName: widget.governmentName,
                                                              cityId: widget.cityId,
                                                              typeCondtion: widget.typeCondtion,
                                                              typeWarrannt: widget.typeWarrannt,
                                                              cityName: widget.cityName,
                                                              toPrice: productDetailsCubit.newPriceController.text,
                                                              fromPrice: productDetailsCubit.oldPriceController.text,
                                                              whatsAppNumber: productDetailsCubit.whatsAppController.text,
                                                              nameProduct: productDetailsCubit.nameOfProductController.text,
                                                              description: productDetailsCubit.descriptionController.text,
                                                              locationUser: productDetailsCubit.locationUserController.text,
                                                            )));
                                                      }),
                                                ],
                                              ) : Container() : Container(),
                                              15.heightBox,
                                              state.showDetailsProductResponseModel![0].category != null ?
                                              state.showDetailsProductResponseModel![0].category!.name!.en!
                                                  .contains('Properties') ?
                                              Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(LocaleKeys.status.tr(),
                                                          style: const TextStyle(
                                                              color: AppPalette.black,
                                                              fontWeight: FontWeight.w500)),
                                                    ],
                                                  ),
                                                  10.heightBox,
                                                  CustomButtonWidget(
                                                      title:
                                                      context.locale.languageCode.contains('en') ?
                                                      widget.statusApartment == null ?
                                                      state.showDetailsProductResponseModel![0].options![8].value!.contains('null') ?
                                                      LocaleKeys.status.tr()  :
                                                      state.showDetailsProductResponseModel![0].options![8].value!  : '${widget.statusApartment}':
                                                      context.locale.languageCode.contains('ar') ?
                                                      widget.statusApartment == null ?
                                                      state.showDetailsProductResponseModel![0].options![8].valueAr!.contains('null') ?
                                                      LocaleKeys.status.tr()  :
                                                      state.showDetailsProductResponseModel![0].options![8].valueAr!  : '${widget.statusApartment}': '',
                                                      onTap: () {
                                                        Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
                                                            ChooseStatusApartmentProductScreen(
                                                              governmentId: widget
                                                                  .governmentId,
                                                              governmentName: widget
                                                                  .governmentName,
                                                              cityId: widget.cityId,
                                                              furnishedType: widget.furnishedType,
                                                              downPayment: productDetailsCubit.downPaymentController.text,
                                                              area: productDetailsCubit.areaPropertiesController.text,
                                                              bathroom: productDetailsCubit.bathroomOfProductController.text,
                                                              bedroom: productDetailsCubit.bedroomOfProductController.text,
                                                              cityName: widget.cityName,
                                                              areaId: widget.areaId,
                                                              areaName: widget.areaName,
                                                              typeApartment: widget.typeApartment,
                                                              statusApartment: widget.statusApartment,
                                                              toPrice: productDetailsCubit.newPriceController
                                                                  .text,
                                                              fromPrice: productDetailsCubit.oldPriceController
                                                                  .text,
                                                              levelType: widget.levelType,
                                                              amenitiesType: widget.amenitiesType,
                                                              whatsAppNumber: productDetailsCubit.whatsAppController.text,
                                                              nameProduct: productDetailsCubit.nameOfProductController.text,
                                                              description: productDetailsCubit.descriptionController.text,
                                                              locationUser: productDetailsCubit.locationUserController.text,
                                                            )));
                                                      }),
                                                ],
                                              )
                                                  :  Container() : Container(),
                                              15.heightBox,
                                              ////// Vehicles Category
                                              state.showDetailsProductResponseModel![0].category != null ?
                                              state.showDetailsProductResponseModel![0].category!.name!.en!
                                                  .contains('Vehicles') ?
                                              Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(LocaleKeys.color.tr(),
                                                          style: const TextStyle(
                                                              color: AppPalette.black,
                                                              fontWeight: FontWeight.w500)),
                                                    ],
                                                  ),
                                                  10.heightBox,
                                                  CustomButtonWidget(
                                                      title:
                                                      context.locale.languageCode.contains('en') ?
                                                      widget.colorType == null ?
                                                      '${state.showDetailsProductResponseModel![0].options![4].value!.contains('null') ?
                                                      LocaleKeys.color.tr() :
                                                      state.showDetailsProductResponseModel![0].options![4].value}'
                                                          : '${widget.colorType}':
                                                      context.locale.languageCode.contains('ar') ?
                                                      widget.colorType == null ?
                                                      '${state.showDetailsProductResponseModel![0].options![4].valueAr!.contains('null') ?
                                                      LocaleKeys.color.tr() :
                                                      state.showDetailsProductResponseModel![0].options![4].valueAr}'
                                                          : '${widget.colorType}': '',
                                                      onTap: () {
                                                        Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                                            ChooseColorAddProductScreen(
                                                              governmentId: widget
                                                                  .governmentId,
                                                              governmentName: widget
                                                                  .governmentName,
                                                              cityId: widget.cityId,
                                                              data: 'changeProduct',
                                                              productId: widget.product?.id.toString(),
                                                              year: productDetailsCubit.yearOfProductController.text,
                                                              cityName: widget.cityName,
                                                              areaId: widget.areaId,
                                                              areaName: widget.areaName,
                                                              toPrice: productDetailsCubit.newPriceController
                                                                  .text,
                                                              fromPrice: productDetailsCubit.oldPriceController
                                                                  .text,
                                                              typeCondtion: widget.typeCondtion,
                                                              whatsAppNumber: productDetailsCubit.whatsAppController.text,
                                                              typeTransmission: widget.transmissionVehicles,
                                                              kiloMetresType: productDetailsCubit.kiloMetresOfProductController.text,
                                                              fuelType: widget.fuelType,
                                                              engineCapacityType: widget.engineCapacityType,
                                                              colorType: widget.colorType,
                                                              bodyType: widget.bodyType,
                                                              nameProduct: productDetailsCubit.nameOfProductController
                                                                  .text,
                                                              description: productDetailsCubit.descriptionController
                                                                  .text,
                                                              locationUser: productDetailsCubit.locationUserController.text,
                                                            )));
                                                      }),
                                                  15.heightBox,
                                                  Row(
                                                    children: [
                                                      Text(LocaleKeys.bodyType.tr(),
                                                          style: const TextStyle(
                                                              color: AppPalette.black,
                                                              fontWeight: FontWeight.w500)),
                                                    ],
                                                  ),
                                                  10.heightBox,
                                                  CustomButtonWidget(
                                                      title: context.locale.languageCode.contains('en') ?
                                                      widget.bodyType == null ?
                                                      state.showDetailsProductResponseModel![0].options![5].value!.contains('null') ?
                                                      LocaleKeys.bodyType.tr()  :
                                                      state.showDetailsProductResponseModel![0].options![5].value!: '${widget.bodyType}':
                                                      context.locale.languageCode.contains('ar') ?
                                                      widget.bodyType == null ?
                                                      state.showDetailsProductResponseModel![0].options![5].valueAr!.contains('null') ?
                                                      LocaleKeys.bodyType.tr()  :
                                                      state.showDetailsProductResponseModel![0].options![5].valueAr!: '${widget.bodyType}': '',
                                                      onTap: () {
                                                        Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                                            ChooseBodyTypeAddProductScreen(
                                                              governmentId: widget
                                                                  .governmentId,
                                                              governmentName: widget
                                                                  .governmentName,
                                                              cityId: widget.cityId,
                                                              data: 'changeProduct',
                                                              productId: widget.product?.id.toString(),
                                                              year: productDetailsCubit.yearOfProductController.text,
                                                              cityName: widget.cityName,
                                                              areaId: widget.areaId,
                                                              areaName: widget.areaName,
                                                              toPrice: productDetailsCubit.newPriceController.text,
                                                              fromPrice: productDetailsCubit.oldPriceController.text,
                                                              typeCondtion: widget.typeCondtion,
                                                              whatsAppNumber: productDetailsCubit.whatsAppController.text,
                                                              typeTransmission: widget.transmissionVehicles,
                                                              kiloMetresType: productDetailsCubit.kiloMetresOfProductController.text,
                                                              fuelType: widget.fuelType,
                                                              engineCapacityType: widget.engineCapacityType,
                                                              colorType: widget.colorType,
                                                              bodyType: widget.bodyType,
                                                              nameProduct: productDetailsCubit.nameOfProductController.text,
                                                              description: productDetailsCubit.descriptionController
                                                                  .text,
                                                              locationUser: productDetailsCubit.locationUserController.text,)));
                                                      }),
                                                  15.heightBox,
                                                  Row(
                                                    children: [
                                                      Text(LocaleKeys.engineCapacity.tr(),
                                                          style: const TextStyle(
                                                              color: AppPalette.black,
                                                              fontWeight: FontWeight.w500)),
                                                    ],
                                                  ),
                                                  10.heightBox,
                                                  CustomButtonWidget(
                                                      title:
                                                      context.locale.languageCode.contains('en') ?
                                                      widget.engineCapacityType == null ?
                                                      state.showDetailsProductResponseModel![0].options![6].value!.contains('null') ?
                                                      LocaleKeys.engineCapacity.tr()  :
                                                      state.showDetailsProductResponseModel![0].options![6].value!  : '${widget.engineCapacityType}':
                                                      context.locale.languageCode.contains('ar') ?
                                                      widget.engineCapacityType == null ?
                                                      state.showDetailsProductResponseModel![0].options![6].valueAr!.contains('null') ?
                                                      LocaleKeys.engineCapacity.tr()  :
                                                      state.showDetailsProductResponseModel![0].options![6].valueAr!  : '${widget.engineCapacityType}': '',
                                                      onTap: () {
                                                        Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                                            ChooseEngineCapacityAddProductScreen(
                                                              governmentId: widget
                                                                  .governmentId,
                                                              governmentName: widget
                                                                  .governmentName,
                                                              cityId: widget.cityId,
                                                              data: 'changeProduct',
                                                              productId: widget.product?.id.toString(),
                                                              year: productDetailsCubit.yearOfProductController.text,
                                                              cityName: widget.cityName,
                                                              areaId: widget.areaId,
                                                              areaName: widget.areaName,
                                                              toPrice: productDetailsCubit.newPriceController
                                                                  .text,
                                                              fromPrice: productDetailsCubit.oldPriceController
                                                                  .text,
                                                              typeCondtion: widget.typeCondtion,
                                                              whatsAppNumber: productDetailsCubit.whatsAppController.text,
                                                              typeTransmission: widget.transmissionVehicles,
                                                              kiloMetresType: productDetailsCubit.kiloMetresOfProductController.text,
                                                              fuelType: widget.fuelType,
                                                              engineCapacityType: widget.engineCapacityType,
                                                              colorType: widget.colorType,
                                                              bodyType: widget.bodyType,
                                                              nameProduct: productDetailsCubit.nameOfProductController
                                                                  .text,
                                                              description: productDetailsCubit.descriptionController
                                                                  .text,
                                                              locationUser: productDetailsCubit.locationUserController.text,
                                                            )));
                                                      }),
                                                  15.heightBox
                                                ],
                                              )
                                                  : Container() : Container(),
                                              InputTextFormField(
                                                hintText: LocaleKeys.description.tr(),
                                                maxLength: 1000000,
                                                textEditingController: productDetailsCubit.descriptionController,
                                                validator: (val) {
                                                  if (val.isEmpty) {
                                                    return LocaleKeys.mustNotEmpty.tr();
                                                  }
                                                },
                                                maxLines: 10,
                                              ),
                                              15.heightBox,
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                15.heightBox,
                                addProductController.loadingUpdate
                                    ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                                    : Container(
                                  padding: EdgeInsets.only(
                                    bottom: Dimensions.paddingSizeDefault,
                                    right: Dimensions.paddingSizeDefault,
                                    left: Dimensions.paddingSizeDefault,
                                  ),
                                ),
                                35.heightBox,
                                Container(
                                  padding: EdgeInsets.only(
                                    bottom: Dimensions.paddingSizeDefault,
                                    right: Dimensions.paddingSizeDefault,
                                    left: Dimensions.paddingSizeDefault,
                                  ),
                                  child: CustomButton(
                                    buttonText: LocaleKeys.save.tr(),
                                    onPressed: () async{
                                      final translator = GoogleTranslator();

                                      // locationUser = '${widget.governmentName} ${widget.cityName} ${widget.areaName}';

                                      // if(widget.governmentName == null){
                                      //   locationUserNew = '${state.showDetailsProductResponseModel![0].location}';
                                      // }else if(widget.cityId == null){
                                      //   locationUserNew = '${state.showDetailsProductResponseModel![0].location}';
                                      // }else if(widget.areaId == null){
                                      //   locationUserNew = '${state.showDetailsProductResponseModel![0].location}';
                                      // }else {
                                      //   locationUserNew = '${widget.governmentName},${widget.cityName},${widget.areaName}';
                                      // }

                                      if (_formKey.currentState!.validate()) {

                                        governmentId = '${state.showDetailsProductResponseModel![0].countryModel?.id.toString()}';
                                        cityId = '${state.showDetailsProductResponseModel![0].stateModel?.id.toString()}';

                                        if(widget.governmentId == null && widget.cityId == null){

                                          addProductController.loadingUpdate = true;

                                          if(addProductController.selectedBrand == null){
                                            statusProduct = state.showDetailsProductResponseModel![0].brandId.toString();
                                          }else if(addProductController.selectedBrand != null){
                                            statusProduct = addProductController.selectedBrand!.id.toString();
                                          }

                                          permission = await Geolocator.checkPermission();
                                          if (permission == LocationPermission.denied) {
                                            permission = await Geolocator.requestPermission();
                                            if (permission == LocationPermission.deniedForever) {
                                              return Future.error('Location Not Available');
                                            }
                                          }else {

                                            await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
                                                .then((Position position) {
                                              if(position.latitude != null){



                                                print('latLocation');
                                                print(position.latitude.toString());
                                                print('lanLocation');
                                                print(position.longitude.toString());
                                                print(widget.governmentId == null ? governmentId : widget.governmentId);
                                                print(widget.cityId == null ? governmentId : widget.cityId);
                                                print(governmentId);
                                                print(cityId);


                                                if (state.showDetailsProductResponseModel![0].category!.name!.en!.contains('Vehicles')) {


                                                  if(widget.typeCondtion == null){
                                                    statusUser = state.showDetailsProductResponseModel![0].status == 0 ? '0' : '1';
                                                  }else  if(widget.typeCondtion != null){
                                                    if(widget.typeCondtion!.contains('Used') || widget.typeCondtion!.contains('مستعمل')){
                                                      statusUser = '0';
                                                    }if(widget.typeCondtion!.contains('New') || widget.typeCondtion!.contains('جديد')){
                                                      statusUser = '1';
                                                    }
                                                  }

                                                  if(addProductController.selectedBrand == null){
                                                    statusProduct = state.showDetailsProductResponseModel![0].brandId.toString();
                                                  }else if(addProductController.selectedBrand != null){
                                                    statusProduct = addProductController.selectedBrand!.id.toString();
                                                  }

                                                  optionValueFuelTypeProduct =  widget.fuelType == null ?
                                                  '${state.showDetailsProductResponseModel![0].options![0].value}' :
                                                  '${widget.fuelType}';

                                                  if(optionValueFuelTypeProduct == 'بنزين' || optionValueFuelTypeProduct == 'benzine'){
                                                    optionValueFuelType = 'benzine';
                                                    optionValueFuelTypeAr = 'بنزين';
                                                    print('fuelType $optionValueFuelType');
                                                    print('fuelType $optionValueFuelTypeAr');
                                                  }else if(optionValueFuelTypeProduct == 'ديزل' || optionValueFuelTypeProduct == 'Diesel'){
                                                    optionValueFuelType = 'Diesel';
                                                    optionValueFuelTypeAr = 'ديزل';
                                                    print('fuelType $optionValueFuelType');
                                                    print('fuelType $optionValueFuelTypeAr');
                                                  }else if(optionValueFuelTypeProduct == 'Electricity meter' || optionValueFuelTypeProduct == 'عداد الكهرباء'){
                                                    optionValueFuelType = 'Electricity meter';
                                                    optionValueFuelTypeAr = 'عداد الكهرباء';
                                                    print('fuelType $optionValueFuelType');
                                                    print('fuelType $optionValueFuelTypeAr');
                                                  }else if(optionValueFuelTypeProduct == 'Hypride' || optionValueFuelTypeProduct == 'هايبرايد'){
                                                    optionValueFuelType = 'Hypride';
                                                    optionValueFuelTypeAr = 'هايبرايد';
                                                    print('fuelType $optionValueFuelType');
                                                    print('fuelType $optionValueFuelTypeAr');
                                                  }else if(optionValueFuelTypeProduct == 'Natural gas' || optionValueFuelTypeProduct == 'غاز طبيعي'){
                                                    optionValueFuelType = 'Natural gas';
                                                    optionValueFuelTypeAr = 'غاز طبيعي';
                                                    print('fuelType $optionValueFuelType');
                                                    print('fuelType $optionValueFuelTypeAr');
                                                  }else if(optionValueFuelTypeProduct == null){
                                                    optionValueFuelType = 'null';
                                                    optionValueFuelTypeAr = 'null';
                                                    print('fuelType $optionValueFuelType');
                                                    print('fuelType $optionValueFuelTypeAr');
                                                  }

                                                  optionValueColorProduct =  widget.colorType == null ?
                                                  '${state.showDetailsProductResponseModel![0].options![4].value}' :
                                                  '${widget.colorType}';

                                                  if(optionValueColorProduct == 'ابيض' || optionValueColorProduct == 'white'){
                                                    optionValueColor = 'white';
                                                    optionValueColorAr = 'ابيض';
                                                    print('colorType $optionValueColor');
                                                    print('colorType $optionValueColorAr');
                                                  }else if(optionValueColorProduct == 'احمر' || optionValueColorProduct == 'red'){
                                                    optionValueColor = 'red';
                                                    optionValueColorAr = 'احمر';
                                                    print('colorType $optionValueColor');
                                                    print('colorType $optionValueColorAr');
                                                  }else if(optionValueColorProduct == 'بني' || optionValueColorProduct == 'brown'){
                                                    optionValueColor = 'brown';
                                                    optionValueColorAr = 'بني';
                                                    print('colorType $optionValueColor');
                                                    print('colorType $optionValueColorAr');
                                                  }else if(optionValueColorProduct == 'ازرق' || optionValueColorProduct == 'blue'){
                                                    optionValueColor = 'blue';
                                                    optionValueColorAr = 'ازرق';
                                                    print('colorType $optionValueColor');
                                                    print('colorType $optionValueColorAr');
                                                  }else if(optionValueColorProduct == 'كحلي' || optionValueColorProduct == 'cohly'){
                                                    optionValueColor = 'cohly';
                                                    optionValueColorAr = 'كحلي';
                                                    print('colorType $optionValueColor');
                                                    print('colorType $optionValueColorAr');
                                                  }else if(optionValueColorProduct == 'اصفر' || optionValueColorProduct == 'yellow'){
                                                    optionValueColor = 'yellow';
                                                    optionValueColorAr = 'اصفر';
                                                    print('colorType $optionValueColor');
                                                    print('colorType $optionValueColorAr');
                                                  }else if(optionValueColorProduct == 'نبيتي' || optionValueColorProduct == 'nebety'){
                                                    optionValueColor = 'nebety';
                                                    optionValueColorAr = 'نبيتي';
                                                    print('colorType $optionValueColor');
                                                    print('colorType $optionValueColorAr');
                                                  }else if(optionValueColorProduct == 'رمادي' || optionValueColorProduct == 'gary'){
                                                    optionValueColor = 'gary';
                                                    optionValueColorAr = 'رمادي';
                                                    print('colorType $optionValueColor');
                                                    print('colorType $optionValueColorAr');
                                                  } else if(widget.colorType == null){
                                                    optionValueColor = 'null';
                                                    optionValueColorAr = 'null';
                                                    print('colorType $optionValueColor');
                                                    print('colorType $optionValueColorAr');
                                                  }


                                                  optionValueBodyTypeProduct =  widget.bodyType == null ?
                                                  '${state.showDetailsProductResponseModel![0].options![5].value}' :
                                                  '${widget.bodyType}';

                                                  if(optionValueBodyTypeProduct == '4*4' || optionValueBodyTypeProduct == '4*4'){
                                                    optionValueBodyTypeAr = '4*4';
                                                    optionValueBodyType = '4*4';
                                                    print('bodyType $optionValueBodyType');
                                                    print('bodyType $optionValueBodyTypeAr');
                                                  }else if(optionValueBodyTypeProduct == 'cabriolet' || optionValueColorProduct == 'كابريوليه'){
                                                    optionValueBodyTypeAr = 'كابريوليه';
                                                    optionValueBodyType = 'cabriolet';
                                                    print('bodyType $optionValueBodyType');
                                                    print('bodyType $optionValueBodyTypeAr');
                                                  }else if(optionValueBodyTypeProduct == 'coupe' || optionValueBodyTypeProduct == 'كوبيه'){
                                                    optionValueBodyTypeAr = 'كوبيه';
                                                    optionValueBodyType = 'coupe';
                                                    print('bodyType $optionValueBodyType');
                                                    print('bodyType $optionValueBodyTypeAr');
                                                  }else if(optionValueBodyTypeProduct == 'hatchback' || optionValueBodyTypeProduct == 'هاتشباك'){
                                                    optionValueBodyTypeAr = 'هاتشباك';
                                                    optionValueBodyType = 'hatchback';
                                                    print('bodyType $optionValueBodyType');
                                                    print('bodyType $optionValueBodyTypeAr');
                                                  }else if(optionValueBodyTypeProduct == 'pickup' || optionValueBodyTypeProduct == 'يلتقط'){
                                                    optionValueBodyTypeAr = 'يلتقط';
                                                    optionValueBodyType = 'pickup';
                                                    print('bodyType $optionValueBodyType');
                                                    print('bodyType $optionValueBodyTypeAr');
                                                  }else if(optionValueBodyTypeProduct == 'suv' || optionValueBodyTypeProduct == 'سيارات الدفع الرباعي'){
                                                    optionValueBodyTypeAr = 'سيارات الدفع الرباعي';
                                                    optionValueBodyType = 'suv';
                                                    print('bodyType $optionValueBodyType');
                                                    print('bodyType $optionValueBodyTypeAr');
                                                  }else if(optionValueBodyTypeProduct == 'sedan' || optionValueBodyTypeProduct == 'سيدان'){
                                                    optionValueBodyTypeAr = 'سيدان';
                                                    optionValueBodyType = 'sedan';
                                                    print('bodyType $optionValueBodyType');
                                                    print('bodyType $optionValueBodyTypeAr');
                                                  }else if(optionValueBodyTypeProduct == 'vanBus' || optionValueBodyTypeProduct == 'شاحنة / حافلة'){
                                                    optionValueBodyTypeAr = 'شاحنة / حافلة';
                                                    optionValueBodyType = 'vanBus';
                                                    print('bodyType $optionValueBodyType');
                                                    print('bodyType $optionValueBodyTypeAr');
                                                  }else if(optionValueBodyTypeProduct == 'other' || optionValueBodyTypeProduct == 'اخري'){
                                                    optionValueBodyType = 'other';
                                                    optionValueBodyTypeAr = 'اخري';
                                                    print('bodyType $optionValueBodyType');
                                                    print('bodyType $optionValueBodyTypeAr');
                                                  } else if(widget.colorType == null){
                                                    optionValueBodyType = 'null';
                                                    optionValueBodyTypeAr = 'null';
                                                    print('bodyType $optionValueBodyType');
                                                    print('bodyType $optionValueBodyTypeAr');
                                                  }

                                                  optionValueEngineCapacityProduct =  widget.engineCapacityType == null ?
                                                  '${state.showDetailsProductResponseModel![0].options![6].value}' :
                                                  '${widget.engineCapacityType}';

                                                  optionValueNameModel =  addProductController.dropdownValueBrand == null ?
                                                  '${state.showDetailsProductResponseModel![0].options![7].value}' :
                                                  '${addProductController.dropdownValueBrand}';

                                                  optionValueTransmissionTypeProduct =  widget.transmissionVehicles == null ?
                                                  '${state.showDetailsProductResponseModel![0].options![3].value}' :
                                                  '${widget.transmissionVehicles}';

                                                  if (optionValueTransmissionTypeProduct == 'manual' ||
                                                      optionValueTransmissionTypeProduct == 'يدوي'){
                                                    transmissionType = 'manual';
                                                    transmissionTypeAr = 'يدوي';
                                                    print('transmissionType');
                                                    print(transmissionType);
                                                    print(transmissionTypeAr);
                                                  }else  if (optionValueTransmissionTypeProduct == 'automatic' ||
                                                      optionValueTransmissionTypeProduct == 'اتوماتیک'){
                                                    transmissionType = 'automatic';
                                                    transmissionTypeAr = 'اتوماتیک';
                                                    print('transmissionType');
                                                    print(transmissionType);
                                                    print(transmissionTypeAr);
                                                  }else {
                                                    optionValueTransmissionType = 'no';
                                                    optionValueTransmissionTypeAr = 'لا';
                                                    print('transmissionType');
                                                    print(transmissionType);
                                                    print(transmissionTypeAr);
                                                  }

                                                  addProductController.updateProductVehicles(
                                                    context,
                                                    state.showDetailsProductResponseModel![0].id.toString(),
                                                    state.showDetailsProductResponseModel![0].category!.name!.en!,
                                                    productDetailsCubit.nameOfProductController.text,
                                                    productDetailsCubit.newPriceController.text,
                                                    productDetailsCubit.oldPriceController.text,
                                                    productDetailsCubit.whatsAppController.text,
                                                    statusUser,
                                                    '${widget.governmentId == null ? '${state.showDetailsProductResponseModel![0].countryModel?.id.toString()}' : widget.governmentId}',
                                                    '${widget.cityId == null ? '${state.showDetailsProductResponseModel![0].stateModel?.id.toString()}' : widget.cityId}',
                                                    '',
                                                    productDetailsCubit.locationUserController.text,
                                                    '$statusProduct',
                                                    position.latitude.toString(),
                                                    position.longitude.toString(),
                                                    productDetailsCubit.descriptionController.text,
                                                    optionValueFuelTypeAr,
                                                    productDetailsCubit.yearOfProductController.text,
                                                    productDetailsCubit.kiloMetresOfProductController.text,
                                                    transmissionTypeAr,
                                                    optionValueColorAr,
                                                    optionValueBodyTypeAr,
                                                    optionValueEngineCapacityProduct,
                                                    optionValueNameModel,

                                                    optionValueFuelType,
                                                    productDetailsCubit.yearOfProductController.text,
                                                    productDetailsCubit.kiloMetresOfProductController.text,
                                                    transmissionType,
                                                    optionValueColor,
                                                    optionValueBodyType,
                                                    optionValueEngineCapacityProduct,
                                                    optionValueNameModel,);


                                                }
                                                else if (state.showDetailsProductResponseModel![0].category!.name!.en!.contains('Properties')) {


                                                  // statusUser = state.showDetailsProductResponseModel![0].status == 0 ? '0' : '1';

                                                  if(widget.typeCondtion == null){
                                                    statusUser = state.showDetailsProductResponseModel![0].status == 0 ? '0' : '1';
                                                  }else  if(widget.typeCondtion != null){
                                                    if(widget.typeCondtion!.contains('Used') || widget.typeCondtion!.contains('مستعمل')){
                                                      statusUser = '0';
                                                    }if(widget.typeCondtion!.contains('New') || widget.typeCondtion!.contains('جديد')){
                                                      statusUser = '1';
                                                    }
                                                  }

                                                  if(addProductController.selectedBrand == null){
                                                    statusProduct = state.showDetailsProductResponseModel![0].brandId.toString();
                                                  }else if(addProductController.selectedBrand != null){
                                                    statusProduct = addProductController.selectedBrand!.id.toString();
                                                  }

                                                  furnishedTypeProduct =  widget.furnishedType == null ?
                                                  '${state.showDetailsProductResponseModel![0].options![7].value}' :
                                                  '${widget.furnishedType}';

                                                  optionValueAmenitiesProduct =  widget.amenitiesType == null ?
                                                  '${state.showDetailsProductResponseModel![0].options![2].value}' :
                                                  '${widget.amenitiesType}';

                                                  statusApartmentTypeProduct =  widget.statusApartment == null ?
                                                  '${state.showDetailsProductResponseModel![0].options![8].value}' :
                                                  '${widget.statusApartment}';

                                                  optionValueLevel =  widget.levelType == null ?
                                                  '${state.showDetailsProductResponseModel![0].options![6].value}' :
                                                  '${widget.levelType}';

                                                  apartmentTypeProduct =  widget.typeApartment == null ?
                                                  '${state.showDetailsProductResponseModel![0].options![0].value}' :
                                                  '${widget.typeApartment}';

                                                  if (statusApartmentTypeProduct == 'Furnished' ||
                                                      statusApartmentTypeProduct == 'مفروش'){
                                                    statusApartmentType = 'Furnished';
                                                    statusApartmentTypeAr = 'مفروش';
                                                    print('statusApartmentType');
                                                    print(statusApartmentType);
                                                    print(statusApartmentTypeAr);
                                                  }else  if (statusApartmentTypeProduct == 'Not finished' ||
                                                      statusApartmentTypeProduct == 'لم ينتهي'){
                                                    statusApartmentType = 'Not finished';
                                                    statusApartmentTypeAr = 'لم ينتهي';
                                                    print('statusApartmentType');
                                                    print(statusApartmentType);
                                                    print(statusApartmentTypeAr);
                                                  }else  if (statusApartmentTypeProduct == 'Core & shell' ||
                                                      statusApartmentTypeProduct == 'النواة والصدفة'){
                                                    statusApartmentType = 'Core & shell';
                                                    statusApartmentTypeAr = 'النواة والصدفة';
                                                    print('statusApartmentType');
                                                    print(statusApartmentType);
                                                    print(statusApartmentTypeAr);
                                                  }else  if (statusApartmentTypeProduct == 'Semi finished' ||
                                                      statusApartmentTypeProduct == 'نصف تشطيب'){
                                                    statusApartmentType = 'Semi finished';
                                                    statusApartmentTypeAr = 'نصف تشطيب';
                                                    print('statusApartmentType');
                                                    print(statusApartmentType);
                                                    print(statusApartmentTypeAr);
                                                  }else {
                                                    statusApartmentType = 'null';
                                                    statusApartmentTypeAr = 'null';
                                                    print('statusApartmentType');
                                                    print(statusApartmentType);
                                                    print(statusApartmentTypeAr);
                                                  }

                                                  if (apartmentTypeProduct == 'Apartment' ||
                                                      apartmentTypeProduct == 'شقة'){
                                                    apartmentType = 'Apartment';
                                                    apartmentTypeAr = 'شقة';
                                                  }else  if (apartmentTypeProduct == 'Duplex' ||
                                                      apartmentTypeProduct == 'مزدوج'){
                                                    apartmentType = 'Duplex';
                                                    apartmentTypeAr = 'مزدوج';
                                                    print('apartmentType');
                                                    print(apartmentType);
                                                    print(apartmentTypeAr);
                                                  }else  if (apartmentTypeProduct == 'Penthouse' ||
                                                      apartmentTypeProduct == 'كنة'){
                                                    apartmentType = 'Penthouse';
                                                    apartmentTypeAr = 'كنة';
                                                    print('apartmentType');
                                                    print(apartmentType);
                                                    print(apartmentTypeAr);
                                                  }else  if (apartmentTypeProduct == 'Studio' ||
                                                      apartmentTypeProduct == 'ستوديو'){
                                                    apartmentType = 'Studio';
                                                    apartmentTypeAr = 'ستوديو';
                                                    print('apartmentType');
                                                    print(apartmentType);
                                                    print(apartmentTypeAr);
                                                  }else {
                                                    apartmentType = 'null';
                                                    apartmentTypeAr = 'null';
                                                    print('apartmentType');
                                                    print(apartmentType);
                                                    print(apartmentTypeAr);
                                                  }

                                                  if (furnishedTypeProduct == 'yes' ||
                                                      furnishedTypeProduct == 'نعم'){
                                                    furnishedType = 'yes';
                                                    furnishedTypeAr = 'نعم';
                                                    print('furnishedType');
                                                    print(furnishedType);
                                                    print(furnishedTypeAr);
                                                  }else  if (furnishedTypeProduct == 'no' ||
                                                      furnishedTypeProduct == 'لا'){
                                                    furnishedType = 'no';
                                                    furnishedTypeAr = 'لا';
                                                    print('furnishedType');
                                                    print(furnishedType);
                                                    print(furnishedTypeAr);
                                                  }else {
                                                    furnishedType = 'null';
                                                    furnishedTypeAr = 'null';
                                                    print('furnishedType');
                                                    print(furnishedType);
                                                    print(furnishedTypeAr);
                                                  }

                                                  if(optionValueAmenitiesProduct == 'balcony' || optionValueAmenitiesProduct == 'بلكونة'){
                                                    optionValueAmenities = 'balcony';
                                                    optionValueAmenitiesAr = 'بلكونة';
                                                    print('amenitiesType $optionValueAmenities');
                                                    print('amenitiesType $optionValueAmenitiesAr');
                                                  }else if(optionValueAmenitiesProduct == 'Built in kitchen appliances' ||
                                                      optionValueAmenitiesProduct == 'أجهزة المطبخ المدمجة'){
                                                    optionValueAmenities = 'Built in kitchen appliances';
                                                    optionValueAmenitiesAr = 'أجهزة المطبخ المدمجة';
                                                    print('optionValueAmenities $optionValueAmenities');
                                                    print('optionValueAmenities $optionValueAmenitiesAr');
                                                  }else if(optionValueAmenitiesProduct == 'Private garden' || optionValueAmenitiesProduct == 'حديقة خاصة'){
                                                    optionValueAmenities = 'Private garden';
                                                    optionValueAmenitiesAr = 'حديقة خاصة';
                                                    print('optionValueAmenities $optionValueAmenities');
                                                    print('optionValueAmenities $optionValueAmenitiesAr');
                                                  }else if(optionValueAmenitiesProduct == 'Central A/C & heating' || optionValueAmenitiesProduct == 'تدفئة وتكييف مركزي'){
                                                    optionValueAmenities = 'Central A/C & heating';
                                                    optionValueAmenitiesAr = 'تدفئة وتكييف مركزي';
                                                    print('optionValueAmenities $optionValueAmenities');
                                                    print('optionValueAmenities $optionValueAmenitiesAr');
                                                  }else if(optionValueAmenitiesProduct == 'Security' || optionValueAmenitiesProduct == 'حماية'){
                                                    optionValueAmenities = 'Security';
                                                    optionValueAmenitiesAr = 'حماية';
                                                    print('optionValueAmenities $optionValueAmenities');
                                                    print('optionValueAmenities $optionValueAmenitiesAr');
                                                  }else if(optionValueAmenitiesProduct == 'Covered parking' || optionValueAmenitiesProduct == 'مواقف مغطاة للسيارات'){
                                                    optionValueAmenities = 'Covered parking';
                                                    optionValueAmenitiesAr = 'مواقف مغطاة للسيارات';
                                                    print('optionValueAmenities $optionValueAmenities');
                                                    print('optionValueAmenities $optionValueAmenitiesAr');
                                                  }else if(optionValueAmenitiesProduct == 'Maids room' || optionValueAmenitiesProduct == 'غرفة للخادمة'){
                                                    optionValueAmenities = 'Maids room';
                                                    optionValueAmenitiesAr = 'غرفة للخادمة';
                                                    print('optionValueAmenities $optionValueAmenities');
                                                    print('optionValueAmenities $optionValueAmenitiesAr');
                                                  }else if(optionValueAmenitiesProduct == 'Pets allowed' ||
                                                      optionValueAmenitiesProduct == 'مسموح بدخول الحيوانات الأليفة'){
                                                    optionValueAmenities = 'Pets allowed';
                                                    optionValueAmenitiesAr = 'مسموح بدخول الحيوانات الأليفة';
                                                    print('optionValueAmenities $optionValueAmenities');
                                                    print('optionValueAmenities $optionValueAmenitiesAr');
                                                  }else if(optionValueAmenitiesProduct == 'Pool' || optionValueAmenitiesProduct == 'حمام سباحة'){
                                                    optionValueAmenities = 'Pool';
                                                    optionValueAmenitiesAr = 'حمام سباحة';
                                                    print('optionValueAmenities $optionValueAmenities');
                                                    print('optionValueAmenities $optionValueAmenitiesAr');
                                                  }else if(optionValueAmenitiesProduct == 'Electricity meter' || optionValueAmenitiesProduct == 'عداد الكهرباء'){
                                                    optionValueAmenities = 'Electricity meter';
                                                    optionValueAmenitiesAr = 'عداد الكهرباء';
                                                    print('optionValueAmenities $optionValueAmenities');
                                                    print('optionValueAmenities $optionValueAmenitiesAr');
                                                  } else if(optionValueAmenitiesProduct == null){
                                                    optionValueAmenities = 'null';
                                                    optionValueAmenitiesAr = 'null';
                                                    print('optionValueAmenities $optionValueAmenities');
                                                    print('optionValueAmenities $optionValueAmenitiesAr');
                                                  }


                                                  addProductController.updateProductProperties(
                                                      context,
                                                      state.showDetailsProductResponseModel![0].id.toString(),
                                                      state.showDetailsProductResponseModel![0].category!.name!.en!,
                                                      productDetailsCubit.nameOfProductController.text,
                                                      productDetailsCubit.newPriceController.text,
                                                      productDetailsCubit.oldPriceController.text,
                                                      productDetailsCubit.whatsAppController.text,
                                                      statusUser,
                                                      '${widget.governmentId == null ? '${state.showDetailsProductResponseModel![0].countryModel?.id.toString()}' : widget.governmentId}',
                                                      '${widget.cityId == null ? '${state.showDetailsProductResponseModel![0].stateModel?.id.toString()}' : widget.cityId}',
                                                      '',
                                                      productDetailsCubit.locationUserController.text,
                                                      '',
                                                      position.latitude.toString(),
                                                      position.longitude.toString(),
                                                      productDetailsCubit.descriptionController.text,
                                                      apartmentTypeAr,
                                                      productDetailsCubit.downPaymentController.text,
                                                      optionValueAmenitiesAr,
                                                      productDetailsCubit.bedroomOfProductController.text,
                                                      productDetailsCubit.bathroomOfProductController.text,
                                                      productDetailsCubit.areaPropertiesController.text,
                                                      optionValueLevel,
                                                      furnishedTypeAr,
                                                      statusApartmentTypeAr,

                                                      apartmentType,
                                                      productDetailsCubit.downPaymentController.text,
                                                      optionValueAmenities,
                                                      productDetailsCubit.bedroomOfProductController.text,
                                                      productDetailsCubit.bathroomOfProductController.text,
                                                      productDetailsCubit.areaPropertiesController.text,
                                                      optionValueLevel,
                                                      furnishedType,
                                                      statusApartmentType);

                                                }
                                                else if (state.showDetailsProductResponseModel![0].category!.name!.en!.contains('Electronics')) {


                                                  if(widget.typeCondtion == null){
                                                    statusUser = state.showDetailsProductResponseModel![0].status == 0 ? '0' : '1';
                                                  }else  if(widget.typeCondtion != null){
                                                    if(widget.typeCondtion!.contains('Used') || widget.typeCondtion!.contains('مستعمل')){
                                                      statusUser = '0';
                                                    }if(widget.typeCondtion!.contains('New') || widget.typeCondtion!.contains('جديد')){
                                                      statusUser = '1';
                                                    }
                                                  }

                                                  if(addProductController.selectedBrand == null){
                                                    statusProduct = state.showDetailsProductResponseModel![0].brandId.toString();
                                                  }else if(addProductController.selectedBrand != null){
                                                    statusProduct = addProductController.selectedBrand!.id.toString();
                                                  }


                                                  if(widget.typeWarrannt == null){
                                                    warrantyTypeProduct = '${state.showDetailsProductResponseModel![0].options![0].value!.contains('null') ?
                                                    'null' : state.showDetailsProductResponseModel![0].options![0].value}';
                                                  }else  if(widget.typeWarrannt != null){
                                                    warrantyTypeProduct = '${widget.typeWarrannt}';
                                                  }

                                                  if (warrantyTypeProduct == 'yes' ||
                                                      warrantyTypeProduct == 'نعم'){
                                                    warrantyType = 'yes';
                                                    warrantyTypeAr = 'نعم';
                                                    print('warrantyType');
                                                    print(warrantyType);
                                                    print(warrantyTypeAr);
                                                  }else  if (warrantyTypeProduct == 'no' ||
                                                      warrantyTypeProduct == 'لا'){
                                                    warrantyType = 'no';
                                                    warrantyTypeAr = 'لا';
                                                    print('warrantyType');
                                                    print(warrantyType);
                                                    print(warrantyTypeAr);
                                                  }else {
                                                    warrantyType = 'null';
                                                    warrantyTypeAr = 'null';
                                                    print('warrantyType');
                                                    print(warrantyType);
                                                    print(warrantyTypeAr);
                                                  }

                                                  print('details product');
                                                  print(state.showDetailsProductResponseModel![0].id.toString());
                                                  print(state.showDetailsProductResponseModel![0].category!.name!.en!);
                                                  print(productDetailsCubit.nameOfProductController.text);
                                                  print(productDetailsCubit.newPriceController.text);
                                                  print(productDetailsCubit.oldPriceController.text);
                                                  print(productDetailsCubit.whatsAppController.text);
                                                  print(statusUser);
                                                  print(widget.governmentId == null ?
                                                  governmentId : widget.governmentId);
                                                  print(widget.cityId == null ?
                                                  cityId : widget.cityId);
                                                  print(widget.areaId == null ?
                                                  areaId : widget.areaId);
                                                  // print(locationUserNew);
                                                  print(statusProduct);
                                                  print(productDetailsCubit.descriptionController.text);
                                                  print(warrantyType);
                                                  print(position.latitude.toString());
                                                  print('lanLocation');
                                                  print(position.longitude.toString());

                                                  // CustomFlutterToast('sss ${widget.typeCondtion}');
                                                  // CustomFlutterToast('sss ${statusUser}');
                                                  // CustomFlutterToast('sss ${warrantyType}');

                                                  print('whatsApp number ${productDetailsCubit.whatsAppController.text}');



                                                  addProductController.updateProductElectronics(
                                                      context,
                                                      state.showDetailsProductResponseModel![0].id.toString(),
                                                      state.showDetailsProductResponseModel![0].category!.name!.en!,
                                                      productDetailsCubit.nameOfProductController.text,
                                                      productDetailsCubit.newPriceController.text,
                                                      productDetailsCubit.oldPriceController.text,
                                                      productDetailsCubit.whatsAppController.text,
                                                      statusUser,
                                                      '${widget.governmentId == null ? '${state.showDetailsProductResponseModel![0].countryModel?.id.toString()}' : widget.governmentId}',
                                                      '${widget.cityId == null ? '${state.showDetailsProductResponseModel![0].stateModel?.id.toString()}' : widget.cityId}',
                                                      '',
                                                      productDetailsCubit.locationUserController.text,
                                                      '$statusProduct',
                                                      position.latitude.toString(),
                                                      position.longitude.toString(),
                                                      productDetailsCubit.descriptionController.text,
                                                      warrantyTypeAr,
                                                      warrantyType);

                                                }
                                                else if (state.showDetailsProductResponseModel![0].category!.name!.en!.contains('Fashion')) {


                                                  if(widget.typeCondtion == null){
                                                    statusUser = state.showDetailsProductResponseModel![0].status == 0 ? '0' : '1';
                                                  }else  if(widget.typeCondtion != null){
                                                    if(widget.typeCondtion!.contains('Used') || widget.typeCondtion!.contains('مستعمل')){
                                                      statusUser = '0';
                                                    }if(widget.typeCondtion!.contains('New') || widget.typeCondtion!.contains('جديد')){
                                                      statusUser = '1';
                                                    }
                                                  }


                                                  if(addProductController.selectedBrand == null){
                                                    statusProduct = state.showDetailsProductResponseModel![0].brandId.toString();
                                                  }else if(addProductController.selectedBrand != null){
                                                    statusProduct = addProductController.selectedBrand!.id.toString();
                                                  }

                                                  if(widget.typeFashion == null){
                                                    homeFashionTypeProduct = '${state.showDetailsProductResponseModel![0].options![0].value!.contains('null') ?
                                                    'null' : state.showDetailsProductResponseModel![0].options![0].value}' ;
                                                    print('homeFashionTypeProduct');
                                                    print(homeFashionTypeProduct);
                                                  }else  if(widget.typeFashion != null){
                                                    homeFashionTypeProduct = '${widget.typeFashion}';
                                                    print('homeFashionTypeProduct');
                                                    print(homeFashionTypeProduct);
                                                  }

                                                  if (homeFashionTypeProduct == 'Nightwear' ||
                                                      homeFashionTypeProduct == 'ملابس نوم'){
                                                    homeFashionType = 'Nightwear';
                                                    homeFashionTypeAr = 'ملابس نوم';
                                                    print('homeFashionType');
                                                    print(homeFashionType);
                                                    print(homeFashionTypeAr);
                                                  }else  if (homeFashionTypeProduct == 'Swimwear' ||
                                                      homeFashionTypeProduct == 'ملابس سباحة'){
                                                    homeFashionType = 'Swimwear';
                                                    homeFashionTypeAr = 'ملابس سباحة';
                                                    print('homeFashionType');
                                                    print(homeFashionType);
                                                    print(homeFashionTypeAr);
                                                  }else  if (homeFashionTypeProduct == 'Dresses' ||
                                                      homeFashionTypeProduct == 'فساتين'){
                                                    homeFashionType = 'Dresses';
                                                    homeFashionTypeAr = 'فساتين';
                                                    print('homeFashionType');
                                                    print(homeFashionType);
                                                    print(homeFashionTypeAr);
                                                  }else  if (homeFashionTypeProduct == 'Wedding Apparel' ||
                                                      homeFashionTypeProduct == 'ملابس الزفاف'){
                                                    homeFashionType = 'Wedding Apparel';
                                                    homeFashionTypeAr = 'ملابس الزفاف';
                                                    print('homeFashionType');
                                                    print(homeFashionType);
                                                    print(homeFashionTypeAr);
                                                  }else  if (homeFashionTypeProduct == 'Pullover - Coats - Jackets' ||
                                                      homeFashionTypeProduct == 'كنزة صوفية - معاطف - جاكيتات'){
                                                    homeFashionType = 'Pullover - Coats - Jackets';
                                                    homeFashionTypeAr = 'كنزة صوفية - معاطف - جاكيتات';
                                                    print('homeFashionType');
                                                    print(homeFashionType);
                                                    print(homeFashionTypeAr);
                                                  }else  if (homeFashionTypeProduct == 'Blouse - T-shirts - Tops' ||
                                                      homeFashionTypeProduct == 'بلوزة - تى شيرت - بلايز'){
                                                    homeFashionType = 'Blouse - T-shirts - Tops';
                                                    homeFashionTypeAr = 'بلوزة - تى شيرت - بلايز';
                                                    print('homeFashionType');
                                                    print(homeFashionType);
                                                    print(homeFashionTypeAr);
                                                  }else  if (homeFashionTypeProduct == 'Trousers - Leggings - Jeans' ||
                                                      homeFashionTypeProduct == 'بنطلون - ليقنز - جينز'){
                                                    homeFashionType = 'Trousers - Leggings - Jeans';
                                                    homeFashionTypeAr = 'بنطلون - ليقنز - جينز';
                                                    print('homeFashionType');
                                                    print(homeFashionType);
                                                    print(homeFashionTypeAr);
                                                  }else {
                                                    homeFashionType = 'null';
                                                    homeFashionTypeAr = 'null';
                                                    print('homeFashionType');
                                                    print(homeFashionType);
                                                    print(homeFashionTypeAr);
                                                  }


                                                  print('details product');
                                                  print(state.showDetailsProductResponseModel![0].id.toString());
                                                  print(state.showDetailsProductResponseModel![0].category!.name!.en!);
                                                  print(productDetailsCubit.nameOfProductController.text);
                                                  print(productDetailsCubit.newPriceController.text);
                                                  print(productDetailsCubit.oldPriceController.text);
                                                  print(productDetailsCubit.whatsAppController.text);
                                                  print(statusUser);
                                                  print(widget.governmentId == null ? governmentId : widget.governmentId);
                                                  print(widget.cityId == null ? cityId : widget.cityId);
                                                  print(widget.areaId == null ? areaId : widget.areaId);
                                                  //  print(locationUserNew);
                                                  print(statusProduct);
                                                  print(productDetailsCubit.descriptionController.text);
                                                  // print(warrantyType);
                                                  print(position.latitude.toString());
                                                  print('lanLocation');
                                                  print(position.longitude.toString());
                                                  print(homeFashionType);
                                                  print(homeFashionTypeAr);

                                                  addProductController.updateProductHomeFashion(
                                                      context,
                                                      state.showDetailsProductResponseModel![0].id.toString(),
                                                      state.showDetailsProductResponseModel![0].category!.name!.en!,
                                                      productDetailsCubit.nameOfProductController.text,
                                                      productDetailsCubit.newPriceController.text,
                                                      productDetailsCubit.oldPriceController.text,
                                                      productDetailsCubit.whatsAppController.text,
                                                      statusUser,
                                                      '${widget.governmentId == null ? '${state.showDetailsProductResponseModel![0].countryModel?.id.toString()}' : widget.governmentId}',
                                                      '${widget.cityId == null ? '${state.showDetailsProductResponseModel![0].stateModel?.id.toString()}' : widget.cityId}',
                                                      '',
                                                      productDetailsCubit.locationUserController.text,
                                                      '$statusProduct',
                                                      position.latitude.toString(),
                                                      position.longitude.toString(),
                                                      productDetailsCubit.descriptionController.text,
                                                      homeFashionTypeAr,
                                                      homeFashionType);

                                                }
                                                else if (state.showDetailsProductResponseModel![0].category!.name!.en!.contains('Home Furniture')) {


                                                  if(widget.typeCondtion == null){
                                                    statusUser = state.showDetailsProductResponseModel![0].status == 0 ? '0' : '1';
                                                  }else  if(widget.typeCondtion != null){
                                                    if(widget.typeCondtion!.contains('Used') || widget.typeCondtion!.contains('مستعمل')){
                                                      statusUser = '0';
                                                    }if(widget.typeCondtion!.contains('New') || widget.typeCondtion!.contains('جديد')){
                                                      statusUser = '1';
                                                    }
                                                  }

                                                  print('statusUser');
                                                  print(statusUser);

                                                  //statusUser = state.showDetailsProductResponseModel![0].status == 0 ? '0' : '1';


                                                  if(addProductController.selectedBrand == null){
                                                    statusProduct = state.showDetailsProductResponseModel![0].brandId.toString();
                                                  }else if(addProductController.selectedBrand != null){
                                                    statusProduct = addProductController.selectedBrand!.id.toString();
                                                  }


                                                  if(widget.typeHomeFurniture == null){
                                                    homeFurnitureTypeProduct = '${state.showDetailsProductResponseModel![0].options![0].value!.contains('null') ?
                                                    'null' : state.showDetailsProductResponseModel![0].options![0].value}';
                                                    print('homeFurnitureTypeProduct');
                                                    print(homeFurnitureTypeProduct);
                                                  }else  if(widget.typeHomeFurniture != null){
                                                    homeFurnitureTypeProduct = '${widget.typeHomeFurniture}';
                                                    print('homeFurnitureTypeProduct');
                                                    print(homeFurnitureTypeProduct);
                                                  }



                                                  if (homeFurnitureTypeProduct == 'Full bathroom' ||
                                                      homeFurnitureTypeProduct == 'حمام كامل'){
                                                    homeFurnitureType = 'Full bathroom';
                                                    homeFurnitureTypeAr = 'حمام كامل';
                                                    print('homeFurnitureType');
                                                    print(homeFurnitureType);
                                                    print(homeFurnitureTypeAr);
                                                  }else  if (homeFurnitureTypeProduct == 'Sink' ||
                                                      homeFurnitureTypeProduct == 'مكتب المدير'){
                                                    homeFurnitureType = 'Sink';
                                                    homeFurnitureTypeAr = 'مكتب المدير';
                                                    print('homeFurnitureType');
                                                    print(homeFurnitureType);
                                                    print(homeFurnitureTypeAr);
                                                  }else  if (homeFurnitureTypeProduct == 'Towels' ||
                                                      homeFurnitureTypeProduct == 'مناشف'){
                                                    homeFurnitureType = 'Towels';
                                                    homeFurnitureTypeAr = 'مناشف';
                                                    print('homeFurnitureType');
                                                    print(homeFurnitureType);
                                                    print(homeFurnitureTypeAr);
                                                  }else  if (homeFurnitureTypeProduct == 'Shower Room Tube' ||
                                                      homeFurnitureTypeProduct == 'غرفة الاستحمام حوض'){
                                                    homeFurnitureType = 'Shower Room Tube';
                                                    homeFurnitureTypeAr = 'غرفة الاستحمام حوض';
                                                    print('homeFurnitureType');
                                                    print(homeFurnitureType);
                                                    print(homeFurnitureTypeAr);
                                                  }else  if (homeFurnitureTypeProduct == 'Toilet' ||
                                                      homeFurnitureTypeProduct == 'حمام'){
                                                    homeFurnitureType = 'Toilet';
                                                    homeFurnitureTypeAr = 'حمام';
                                                    print('homeFurnitureType');
                                                    print(homeFurnitureType);
                                                    print(homeFurnitureTypeAr);
                                                  }else  if (homeFurnitureTypeProduct == 'Water mixers - Shower heads' ||
                                                      homeFurnitureTypeProduct == 'خلاطات مياه - رؤوس دوش'){
                                                    homeFurnitureType = 'Water mixers - Shower heads';
                                                    homeFurnitureTypeAr = 'خلاطات مياه - رؤوس دوش';
                                                    print('homeFurnitureType');
                                                    print(homeFurnitureType);
                                                    print(homeFurnitureTypeAr);
                                                  }else  if (homeFurnitureTypeProduct == 'Mirrors - Shelves - Other Accessories' ||
                                                      homeFurnitureTypeProduct == 'مرايات - ارفف - اكسسوارات اخرى'){
                                                    homeFurnitureType = 'Mirrors - Shelves - Other Accessories';
                                                    homeFurnitureTypeAr = 'مرايات - ارفف - اكسسوارات اخرى';
                                                    print('homeFurnitureType');
                                                    print(homeFurnitureType);
                                                    print(homeFurnitureTypeAr);
                                                  }else {
                                                    homeFurnitureType = 'null';
                                                    homeFurnitureTypeAr = 'null';
                                                    print('homeFurnitureType');
                                                    print(homeFurnitureType);
                                                    print(homeFurnitureTypeAr);
                                                  }


                                                  addProductController.updateProductHomeFurniture(
                                                      context,
                                                      state.showDetailsProductResponseModel![0].id.toString(),
                                                      state.showDetailsProductResponseModel![0].category!.name!.en!,
                                                      productDetailsCubit.nameOfProductController.text,
                                                      productDetailsCubit.newPriceController.text,
                                                      productDetailsCubit.oldPriceController.text,
                                                      productDetailsCubit.whatsAppController.text,
                                                      statusUser,
                                                      '${widget.governmentId == null ? '${state.showDetailsProductResponseModel![0].countryModel?.id.toString()}' : widget.governmentId}',
                                                      '${widget.cityId == null ? '${state.showDetailsProductResponseModel![0].stateModel?.id.toString()}' : widget.cityId}',
                                                      '',
                                                      productDetailsCubit.locationUserController.text,
                                                      '$statusProduct',
                                                      position.latitude.toString(),
                                                      position.longitude.toString(),
                                                      productDetailsCubit.descriptionController.text,
                                                      homeFurnitureTypeAr,
                                                      homeFurnitureType);

                                                }
                                                else if (state.showDetailsProductResponseModel![0].category!.name!.en!.contains('Books, Sports & Hobbies')) {


                                                  //  statusUser = state.showDetailsProductResponseModel![0].status == 0 ? '0' : '1';

                                                  if(addProductController.selectedBrand == null){
                                                    statusProduct = state.showDetailsProductResponseModel![0].brandId.toString();
                                                  }else if(addProductController.selectedBrand != null){
                                                    statusProduct = addProductController.selectedBrand!.id.toString();
                                                  }

                                                  if(widget.typeCondtion == null){
                                                    statusUser = state.showDetailsProductResponseModel![0].status == 0 ? '0' : '1';
                                                  }else  if(widget.typeCondtion != null){
                                                    if(widget.typeCondtion!.contains('Used') || widget.typeCondtion!.contains('مستعمل')){
                                                      statusUser = '0';
                                                    }if(widget.typeCondtion!.contains('New') || widget.typeCondtion!.contains('جديد')){
                                                      statusUser = '1';
                                                    }
                                                  }

                                                  if(widget.typeBooks == null){
                                                    booksTypeProduct = '${state.showDetailsProductResponseModel![0].options![0].value!.contains('null') ?
                                                    'null' : state.showDetailsProductResponseModel![0].options![0].value}';
                                                  }else  if(widget.typeBooks != null){
                                                    booksTypeProduct = '${widget.typeBooks}';
                                                  }




                                                  if (booksTypeProduct == 'Antiques' ||
                                                      booksTypeProduct == 'التحف'){
                                                    booksType = 'Antiques';
                                                    booksTypeAr = 'التحف';
                                                    print('booksType');
                                                    print(booksType);
                                                    print(booksTypeAr);
                                                  }else  if (booksTypeProduct == 'ART' ||
                                                      booksTypeProduct == 'فن'){
                                                    booksType = 'ART';
                                                    booksTypeAr = 'فن';
                                                    print('booksType');
                                                    print(booksType);
                                                    print(booksTypeAr);
                                                  }else  if (booksTypeProduct == 'Collectibles' ||
                                                      booksTypeProduct == 'المقتنيات'){
                                                    booksType = 'Collectibles';
                                                    booksTypeAr = 'المقتنيات';
                                                    print('booksType');
                                                    print(booksType);
                                                    print(booksTypeAr);
                                                  }else  if (booksTypeProduct == 'Old Currencies' ||
                                                      booksTypeProduct == 'العملات القديمة'){
                                                    booksType = 'Old Currencies';
                                                    booksTypeAr = 'العملات القديمة';
                                                    print('booksType');
                                                    print(booksType);
                                                    print(booksTypeAr);
                                                  }else  if (booksTypeProduct == 'Pens & Writing instruments' ||
                                                      booksTypeProduct == 'أقلام وأدوات الكتابة'){
                                                    booksType = 'Pens & Writing instruments';
                                                    booksTypeAr = 'أقلام وأدوات الكتابة';
                                                    print('booksType');
                                                    print(booksType);
                                                    print(booksTypeAr);
                                                  }else  if (booksTypeProduct == 'Other' ||
                                                      booksTypeProduct == 'اخري'){
                                                    booksType = 'Other';
                                                    booksTypeAr = 'اخري';
                                                    print('booksType');
                                                    print(booksType);
                                                    print(booksTypeAr);
                                                  }else {
                                                    booksType = 'null';
                                                    booksTypeAr = 'null';
                                                    print('booksType');
                                                    print(booksType);
                                                    print(booksTypeAr);
                                                  }

                                                  addProductController.updateProductBooks(
                                                      context,
                                                      state.showDetailsProductResponseModel![0].id.toString(),
                                                      state.showDetailsProductResponseModel![0].category!.name!.en!,
                                                      productDetailsCubit.nameOfProductController.text,
                                                      productDetailsCubit.newPriceController.text,
                                                      productDetailsCubit.oldPriceController.text,
                                                      productDetailsCubit.whatsAppController.text,
                                                      statusUser,
                                                      '${widget.governmentId == null ? '${state.showDetailsProductResponseModel![0].countryModel?.id.toString()}' : widget.governmentId}',
                                                      '${widget.cityId == null ? '${state.showDetailsProductResponseModel![0].stateModel?.id.toString()}' : widget.cityId}',
                                                      '',
                                                      productDetailsCubit.locationUserController.text,
                                                      '$statusProduct',
                                                      position.latitude.toString(),
                                                      position.longitude.toString(),
                                                      productDetailsCubit.descriptionController.text,
                                                      booksTypeAr,
                                                      booksType);

                                                }
                                                else if (state.showDetailsProductResponseModel![0].category!.name!.en!.contains('Kids & Babies')) {

                                                  //    statusUser = state.showDetailsProductResponseModel![0].status == 0 ? '0' : '1';
                                                  // kidsType = widget.typeKids == null ?
                                                  // '${state.showDetailsProductResponseModel![0].options![0].value}' :
                                                  // '${widget.typeKids}';

                                                  if(addProductController.selectedBrand == null){
                                                    statusProduct = state.showDetailsProductResponseModel![0].brandId.toString();
                                                  }else if(addProductController.selectedBrand != null){
                                                    statusProduct = addProductController.selectedBrand!.id.toString();
                                                  }

                                                  if(widget.typeKids == null){
                                                    kidsTypeProduct = '${state.showDetailsProductResponseModel![0].options![0].value!.contains('null') ?
                                                    'null' : state.showDetailsProductResponseModel![0].options![0].value}';
                                                  }else  if(widget.typeKids != null){
                                                    kidsTypeProduct = '${widget.typeKids}';
                                                  }



                                                  if(widget.typeCondtion == null){
                                                    statusUser = state.showDetailsProductResponseModel![0].status == 0 ? '0' : '1';
                                                  }else  if(widget.typeCondtion != null){
                                                    if(widget.typeCondtion!.contains('Used') || widget.typeCondtion!.contains('مستعمل')){
                                                      statusUser = '0';
                                                    }if(widget.typeCondtion!.contains('New') || widget.typeCondtion!.contains('جديد')){
                                                      statusUser = '1';
                                                    }
                                                  }


                                                  if (kidsTypeProduct == 'Bath Tub' ||
                                                      kidsTypeProduct == 'حوض أستحمام'){
                                                    kidsType = 'Bath Tub';
                                                    kidsTypeAr = 'حوض أستحمام';
                                                    print('kidsType');
                                                    print(kidsTypeAr);
                                                    print(kidsType);
                                                  }else  if (kidsTypeProduct == 'Diaper' ||
                                                      kidsTypeProduct == 'حفاضات'){
                                                    kidsType = 'Diaper';
                                                    kidsTypeAr = 'حفاضات';
                                                    print('kidsType');
                                                    print(kidsTypeAr);
                                                    print(kidsType);
                                                  }else  if (kidsTypeProduct == 'Shampoo - Soaps' ||
                                                      kidsTypeProduct == 'شامبو - صابون'){
                                                    kidsType = 'Shampoo - Soaps';
                                                    kidsTypeAr = 'شامبو - صابون';
                                                    print('kidsType');
                                                    print(kidsTypeAr);
                                                    print(kidsType);
                                                  }else  if (kidsTypeProduct == 'Skincare' ||
                                                      kidsTypeProduct == 'عناية بالجلد'){
                                                    kidsType = 'Skincare';
                                                    kidsTypeAr = 'عناية بالجلد';
                                                    print('kidsType');
                                                    print(kidsTypeAr);
                                                    print(kidsType);
                                                  }else  if (kidsTypeProduct == 'Silicone Nipple Protectors' ||
                                                      kidsTypeProduct == 'حماة حلمة سيليكون'){
                                                    kidsType = 'Silicone Nipple Protectors';
                                                    kidsTypeAr = 'حماة حلمة سيليكون';
                                                    print('kidsType');
                                                    print(kidsTypeAr);
                                                    print(kidsType);
                                                  }else  if (kidsTypeProduct == 'Sterilizer Tools' ||
                                                      kidsTypeProduct == 'أدوات التعقيم'){
                                                    kidsType = 'Sterilizer Tools';
                                                    kidsTypeAr = 'أدوات التعقيم';
                                                    print('kidsType');
                                                    print(kidsTypeAr);
                                                    print(kidsType);
                                                  }else  if (kidsTypeProduct == 'Toilet Training Seat' ||
                                                      kidsTypeProduct == 'مقعد تدريب على استعمال المرحاض'){
                                                    kidsType = 'Toilet Training Seat';
                                                    kidsTypeAr = 'مقعد تدريب على استعمال المرحاض';
                                                    print('kidsType');
                                                    print(kidsTypeAr);
                                                    print(kidsType);
                                                  }else  if (kidsTypeProduct == 'Sterilizer Tools' ||
                                                      kidsTypeProduct == 'أدوات التعقيم'){
                                                    kidsType = 'Sterilizer Tools';
                                                    kidsTypeAr = 'أدوات التعقيم';
                                                    print('kidsType');
                                                    print(kidsTypeAr);
                                                    print(kidsType);
                                                  }else  if (kidsTypeProduct == 'Other' ||
                                                      kidsTypeProduct == 'اخري'){
                                                    kidsType = 'Other';
                                                    kidsTypeAr = 'اخري';
                                                    print('kidsType');
                                                    print(kidsTypeAr);
                                                    print(kidsType);
                                                  }else {
                                                    kidsType = 'null';
                                                    kidsTypeAr = 'null';
                                                    print('kidsType');
                                                    print(kidsTypeAr);
                                                    print(kidsType);
                                                  }

                                                  addProductController.updateProductKids(
                                                      context,
                                                      state.showDetailsProductResponseModel![0].id.toString(),
                                                      state.showDetailsProductResponseModel![0].category!.name!.en!,
                                                      productDetailsCubit.nameOfProductController.text,
                                                      productDetailsCubit.newPriceController.text,
                                                      productDetailsCubit.oldPriceController.text,
                                                      productDetailsCubit.whatsAppController.text,
                                                      statusUser,
                                                      '${widget.governmentId == null ? '${state.showDetailsProductResponseModel![0].countryModel?.id.toString()}' : widget.governmentId}',
                                                      '${widget.cityId == null ? '${state.showDetailsProductResponseModel![0].stateModel?.id.toString()}' : widget.cityId}',
                                                      '',
                                                      productDetailsCubit.locationUserController.text,
                                                      '$statusProduct',
                                                      position.latitude.toString(),
                                                      position.longitude.toString(),
                                                      productDetailsCubit.descriptionController.text,
                                                      kidsTypeAr,
                                                      kidsType);

                                                }
                                                else if (state.showDetailsProductResponseModel![0].category!.name!.en!.contains('Business - Industrial - Agriculture')) {

                                                  //  statusUser = state.showDetailsProductResponseModel![0].status == 0 ? '0' : '1';

                                                  if(widget.typeCondtion == null){
                                                    statusUser = state.showDetailsProductResponseModel![0].status == 0 ? '0' : '1';
                                                  }else  if(widget.typeCondtion != null){
                                                    if(widget.typeCondtion!.contains('Used') || widget.typeCondtion!.contains('مستعمل')){
                                                      statusUser = '0';
                                                    }if(widget.typeCondtion!.contains('New') || widget.typeCondtion!.contains('جديد')){
                                                      statusUser = '1';
                                                    }
                                                  }


                                                  if(addProductController.selectedBrand == null){
                                                    statusProduct = state.showDetailsProductResponseModel![0].brandId.toString();
                                                  }else if(addProductController.selectedBrand != null){
                                                    statusProduct = addProductController.selectedBrand!.id.toString();
                                                  }

                                                  if(widget.typeBusiness == null){
                                                    businessTypeProduct = '${state.showDetailsProductResponseModel![0].options![0].value!.contains('null') ?
                                                    'null' : state.showDetailsProductResponseModel![0].options![0].value}';
                                                  }else  if(widget.typeBusiness != null){
                                                    businessTypeProduct = '${widget.typeBusiness}';
                                                  }


                                                  // if(widget.typeCondtion == null){
                                                  //   statusUser = state.showDetailsProductResponseModel![0].status == 0 ? '0' : '1';
                                                  // }else  if(widget.typeCondtion != null){
                                                  //   statusUser = widget.typeCondtion!.contains('Used')  ? '0' : '1';
                                                  // }

                                                  if (businessTypeProduct == 'Seeds' ||
                                                      businessTypeProduct == 'بذور'){
                                                    businessType = 'Seeds';
                                                    businessTypeAr = 'بذور';
                                                  }else  if (businessTypeProduct == 'Crops' ||
                                                      businessTypeProduct == 'المحاصيل'){
                                                    businessType = 'Crops';
                                                    businessTypeAr = 'المحاصيل';
                                                    print('businessType');
                                                    print(businessType);
                                                    print(businessTypeAr);
                                                  }else  if (businessTypeProduct == 'agricultural machinery' ||
                                                      businessTypeProduct == 'الآلات الزراعية'){
                                                    businessType = 'agricultural machinery';
                                                    businessTypeAr = 'الآلات الزراعية';
                                                    print('businessType');
                                                    print(businessType);
                                                    print(businessTypeAr);
                                                  }else  if (businessTypeProduct == 'Pesticides' ||
                                                      businessTypeProduct == 'مبيدات حشرية'){
                                                    businessType = 'Pesticides';
                                                    businessTypeAr = 'مبيدات حشرية';
                                                    print('businessType');
                                                    print(businessType);
                                                    print(businessTypeAr);
                                                  }else  if (businessTypeProduct == 'Other' ||
                                                      businessTypeProduct == 'اخري'){
                                                    businessType = 'Other';
                                                    businessTypeAr = 'اخري';
                                                    print('businessType');
                                                    print(businessType);
                                                    print(businessTypeAr);
                                                  }else {
                                                    businessType = 'null';
                                                    businessTypeAr = 'null';
                                                    print('businessType');
                                                    print(businessType);
                                                    print(businessTypeAr);
                                                  }

                                                  addProductController.updateProductBusiness(
                                                      context,
                                                      state.showDetailsProductResponseModel![0].id.toString(),
                                                      state.showDetailsProductResponseModel![0].category!.name!.en!,
                                                      productDetailsCubit.nameOfProductController.text,
                                                      productDetailsCubit.newPriceController.text,
                                                      productDetailsCubit.oldPriceController.text,
                                                      productDetailsCubit.whatsAppController.text,
                                                      statusUser,
                                                      '${widget.governmentId == null ? '${state.showDetailsProductResponseModel![0].countryModel?.id.toString()}' : widget.governmentId}',
                                                      '${widget.cityId == null ? '${state.showDetailsProductResponseModel![0].stateModel?.id.toString()}' : widget.cityId}',
                                                      '',
                                                      productDetailsCubit.locationUserController.text,
                                                      '$statusProduct',
                                                      position.latitude.toString(),
                                                      position.longitude.toString(),
                                                      productDetailsCubit.descriptionController.text,
                                                      businessTypeAr,
                                                      businessType);


                                                }


                                                // if(productDetailsCubit.newPriceController.text.compareTo(productDetailsCubit.oldPriceController.text) <= 0){
                                                //
                                                //
                                                // }else {
                                                //   addProductController.loadingUpdate = false;
                                                //   var snackBar = SnackBar(content: Text(LocaleKeys.newPriceAndOldPrice.tr(),
                                                //   style: const TextStyle(color: AppPalette.white),),
                                                //   backgroundColor: AppPalette.error,);
                                                //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                                //
                                                // }
                                              }else {

                                                _getCurrentLocation();
                                                print('latLocation');
                                                print('location denie' + LocaleKeys.warning.tr());
                                                print(LocaleKeys.openGps.tr());

                                                AwesomeDialog(
                                                  context: context,
                                                  dialogType: DialogType.warning,
                                                  animType: AnimType.RIGHSLIDE,
                                                  btnOkText: LocaleKeys.ok.tr(),
                                                  btnCancelText: LocaleKeys.cancel.tr(),
                                                  title: LocaleKeys.warning.tr(),
                                                  desc: LocaleKeys.openGps.tr(),
                                                  autoDismiss: false,
                                                  btnCancelOnPress: () {
                                                    _getCurrentLocation();
                                                  },
                                                  btnOkOnPress: () {
                                                    _getCurrentLocation();
                                                  },
                                                ).show();
                                              }
                                            });

                                          }

                                        }else if(widget.governmentId != null && widget.cityId == null){
                                          AwesomeDialog(
                                            context: context,
                                            dialogType: DialogType.warning,
                                            animType: AnimType.RIGHSLIDE,
                                            title: LocaleKeys.warning.tr(),
                                            btnOkText: LocaleKeys.ok.tr(),
                                            btnCancelText: LocaleKeys.cancel.tr(),
                                            desc: LocaleKeys.pleaseSelectCity.tr(),
                                            btnCancelOnPress: () {},
                                            btnOkOnPress: () {},
                                          ).show();

                                        }else if(widget.governmentId != null && widget.cityId != null){

                                          if(addProductController.selectedBrand == null){
                                            statusProduct = state.showDetailsProductResponseModel![0].brandId.toString();
                                          }else if(addProductController.selectedBrand != null){
                                            statusProduct = addProductController.selectedBrand!.id.toString();
                                          }

                                          permission = await Geolocator.checkPermission();
                                          if (permission == LocationPermission.denied) {
                                            permission = await Geolocator.requestPermission();
                                            if (permission == LocationPermission.deniedForever) {
                                              return Future.error('Location Not Available');
                                            }
                                          }else {

                                            await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
                                                .then((Position position) {
                                              if(position.latitude != null){



                                                print('latLocation');
                                                print(position.latitude.toString());
                                                print('lanLocation');
                                                print(position.longitude.toString());
                                                print(widget.governmentId == null ? governmentId : widget.governmentId);
                                                print(widget.cityId == null ? governmentId : widget.cityId);
                                                print(governmentId);
                                                print(cityId);


                                                if (state.showDetailsProductResponseModel![0].category!.name!.en!.contains('Vehicles')) {


                                                  if(widget.typeCondtion == null){
                                                    statusUser = state.showDetailsProductResponseModel![0].status == 0 ? '0' : '1';
                                                  }else  if(widget.typeCondtion != null){
                                                    if(widget.typeCondtion!.contains('Used') || widget.typeCondtion!.contains('مستعمل')){
                                                      statusUser = '0';
                                                    }if(widget.typeCondtion!.contains('New') || widget.typeCondtion!.contains('جديد')){
                                                      statusUser = '1';
                                                    }
                                                  }

                                                  if(addProductController.selectedBrand == null){
                                                    statusProduct = state.showDetailsProductResponseModel![0].brandId.toString();
                                                  }else if(addProductController.selectedBrand != null){
                                                    statusProduct = addProductController.selectedBrand!.id.toString();
                                                  }

                                                  optionValueFuelTypeProduct =  widget.fuelType == null ?
                                                  '${state.showDetailsProductResponseModel![0].options![0].value}' :
                                                  '${widget.fuelType}';

                                                  if(optionValueFuelTypeProduct == 'بنزين' || optionValueFuelTypeProduct == 'benzine'){
                                                    optionValueFuelType = 'benzine';
                                                    optionValueFuelTypeAr = 'بنزين';
                                                    print('fuelType $optionValueFuelType');
                                                    print('fuelType $optionValueFuelTypeAr');
                                                  }else if(optionValueFuelTypeProduct == 'ديزل' || optionValueFuelTypeProduct == 'Diesel'){
                                                    optionValueFuelType = 'Diesel';
                                                    optionValueFuelTypeAr = 'ديزل';
                                                    print('fuelType $optionValueFuelType');
                                                    print('fuelType $optionValueFuelTypeAr');
                                                  }else if(optionValueFuelTypeProduct == 'Electricity meter' || optionValueFuelTypeProduct == 'عداد الكهرباء'){
                                                    optionValueFuelType = 'Electricity meter';
                                                    optionValueFuelTypeAr = 'عداد الكهرباء';
                                                    print('fuelType $optionValueFuelType');
                                                    print('fuelType $optionValueFuelTypeAr');
                                                  }else if(optionValueFuelTypeProduct == 'Hypride' || optionValueFuelTypeProduct == 'هايبرايد'){
                                                    optionValueFuelType = 'Hypride';
                                                    optionValueFuelTypeAr = 'هايبرايد';
                                                    print('fuelType $optionValueFuelType');
                                                    print('fuelType $optionValueFuelTypeAr');
                                                  }else if(optionValueFuelTypeProduct == 'Natural gas' || optionValueFuelTypeProduct == 'غاز طبيعي'){
                                                    optionValueFuelType = 'Natural gas';
                                                    optionValueFuelTypeAr = 'غاز طبيعي';
                                                    print('fuelType $optionValueFuelType');
                                                    print('fuelType $optionValueFuelTypeAr');
                                                  }else if(optionValueFuelTypeProduct == null){
                                                    optionValueFuelType = 'null';
                                                    optionValueFuelTypeAr = 'null';
                                                    print('fuelType $optionValueFuelType');
                                                    print('fuelType $optionValueFuelTypeAr');
                                                  }

                                                  optionValueColorProduct =  widget.colorType == null ?
                                                  '${state.showDetailsProductResponseModel![0].options![4].value}' :
                                                  '${widget.colorType}';

                                                  if(optionValueColorProduct == 'ابيض' || optionValueColorProduct == 'white'){
                                                    optionValueColor = 'white';
                                                    optionValueColorAr = 'ابيض';
                                                    print('colorType $optionValueColor');
                                                    print('colorType $optionValueColorAr');
                                                  }else if(optionValueColorProduct == 'احمر' || optionValueColorProduct == 'red'){
                                                    optionValueColor = 'red';
                                                    optionValueColorAr = 'احمر';
                                                    print('colorType $optionValueColor');
                                                    print('colorType $optionValueColorAr');
                                                  }else if(optionValueColorProduct == 'بني' || optionValueColorProduct == 'brown'){
                                                    optionValueColor = 'brown';
                                                    optionValueColorAr = 'بني';
                                                    print('colorType $optionValueColor');
                                                    print('colorType $optionValueColorAr');
                                                  }else if(optionValueColorProduct == 'ازرق' || optionValueColorProduct == 'blue'){
                                                    optionValueColor = 'blue';
                                                    optionValueColorAr = 'ازرق';
                                                    print('colorType $optionValueColor');
                                                    print('colorType $optionValueColorAr');
                                                  }else if(optionValueColorProduct == 'كحلي' || optionValueColorProduct == 'cohly'){
                                                    optionValueColor = 'cohly';
                                                    optionValueColorAr = 'كحلي';
                                                    print('colorType $optionValueColor');
                                                    print('colorType $optionValueColorAr');
                                                  }else if(optionValueColorProduct == 'اصفر' || optionValueColorProduct == 'yellow'){
                                                    optionValueColor = 'yellow';
                                                    optionValueColorAr = 'اصفر';
                                                    print('colorType $optionValueColor');
                                                    print('colorType $optionValueColorAr');
                                                  }else if(optionValueColorProduct == 'نبيتي' || optionValueColorProduct == 'nebety'){
                                                    optionValueColor = 'nebety';
                                                    optionValueColorAr = 'نبيتي';
                                                    print('colorType $optionValueColor');
                                                    print('colorType $optionValueColorAr');
                                                  }else if(optionValueColorProduct == 'رمادي' || optionValueColorProduct == 'gary'){
                                                    optionValueColor = 'gary';
                                                    optionValueColorAr = 'رمادي';
                                                    print('colorType $optionValueColor');
                                                    print('colorType $optionValueColorAr');
                                                  } else if(widget.colorType == null){
                                                    optionValueColor = 'null';
                                                    optionValueColorAr = 'null';
                                                    print('colorType $optionValueColor');
                                                    print('colorType $optionValueColorAr');
                                                  }


                                                  optionValueBodyTypeProduct =  widget.bodyType == null ?
                                                  '${state.showDetailsProductResponseModel![0].options![5].value}' :
                                                  '${widget.bodyType}';

                                                  if(optionValueBodyTypeProduct == '4*4' || optionValueBodyTypeProduct == '4*4'){
                                                    optionValueBodyTypeAr = '4*4';
                                                    optionValueBodyType = '4*4';
                                                    print('bodyType $optionValueBodyType');
                                                    print('bodyType $optionValueBodyTypeAr');
                                                  }else if(optionValueBodyTypeProduct == 'cabriolet' || optionValueColorProduct == 'كابريوليه'){
                                                    optionValueBodyTypeAr = 'كابريوليه';
                                                    optionValueBodyType = 'cabriolet';
                                                    print('bodyType $optionValueBodyType');
                                                    print('bodyType $optionValueBodyTypeAr');
                                                  }else if(optionValueBodyTypeProduct == 'coupe' || optionValueBodyTypeProduct == 'كوبيه'){
                                                    optionValueBodyTypeAr = 'كوبيه';
                                                    optionValueBodyType = 'coupe';
                                                    print('bodyType $optionValueBodyType');
                                                    print('bodyType $optionValueBodyTypeAr');
                                                  }else if(optionValueBodyTypeProduct == 'hatchback' || optionValueBodyTypeProduct == 'هاتشباك'){
                                                    optionValueBodyTypeAr = 'هاتشباك';
                                                    optionValueBodyType = 'hatchback';
                                                    print('bodyType $optionValueBodyType');
                                                    print('bodyType $optionValueBodyTypeAr');
                                                  }else if(optionValueBodyTypeProduct == 'pickup' || optionValueBodyTypeProduct == 'يلتقط'){
                                                    optionValueBodyTypeAr = 'يلتقط';
                                                    optionValueBodyType = 'pickup';
                                                    print('bodyType $optionValueBodyType');
                                                    print('bodyType $optionValueBodyTypeAr');
                                                  }else if(optionValueBodyTypeProduct == 'suv' || optionValueBodyTypeProduct == 'سيارات الدفع الرباعي'){
                                                    optionValueBodyTypeAr = 'سيارات الدفع الرباعي';
                                                    optionValueBodyType = 'suv';
                                                    print('bodyType $optionValueBodyType');
                                                    print('bodyType $optionValueBodyTypeAr');
                                                  }else if(optionValueBodyTypeProduct == 'sedan' || optionValueBodyTypeProduct == 'سيدان'){
                                                    optionValueBodyTypeAr = 'سيدان';
                                                    optionValueBodyType = 'sedan';
                                                    print('bodyType $optionValueBodyType');
                                                    print('bodyType $optionValueBodyTypeAr');
                                                  }else if(optionValueBodyTypeProduct == 'vanBus' || optionValueBodyTypeProduct == 'شاحنة / حافلة'){
                                                    optionValueBodyTypeAr = 'شاحنة / حافلة';
                                                    optionValueBodyType = 'vanBus';
                                                    print('bodyType $optionValueBodyType');
                                                    print('bodyType $optionValueBodyTypeAr');
                                                  }else if(optionValueBodyTypeProduct == 'other' || optionValueBodyTypeProduct == 'اخري'){
                                                    optionValueBodyType = 'other';
                                                    optionValueBodyTypeAr = 'اخري';
                                                    print('bodyType $optionValueBodyType');
                                                    print('bodyType $optionValueBodyTypeAr');
                                                  } else if(widget.colorType == null){
                                                    optionValueBodyType = 'null';
                                                    optionValueBodyTypeAr = 'null';
                                                    print('bodyType $optionValueBodyType');
                                                    print('bodyType $optionValueBodyTypeAr');
                                                  }

                                                  optionValueEngineCapacityProduct =  widget.engineCapacityType == null ?
                                                  '${state.showDetailsProductResponseModel![0].options![6].value}' :
                                                  '${widget.engineCapacityType}';

                                                  optionValueNameModel =  addProductController.dropdownValueBrand == null ?
                                                  '${state.showDetailsProductResponseModel![0].options![7].value}' :
                                                  '${addProductController.dropdownValueBrand}';

                                                  optionValueTransmissionTypeProduct =  widget.transmissionVehicles == null ?
                                                  '${state.showDetailsProductResponseModel![0].options![3].value}' :
                                                  '${widget.transmissionVehicles}';

                                                  if (optionValueTransmissionTypeProduct == 'manual' ||
                                                      optionValueTransmissionTypeProduct == 'يدوي'){
                                                    transmissionType = 'manual';
                                                    transmissionTypeAr = 'يدوي';
                                                    print('transmissionType');
                                                    print(transmissionType);
                                                    print(transmissionTypeAr);
                                                  }else  if (optionValueTransmissionTypeProduct == 'automatic' ||
                                                      optionValueTransmissionTypeProduct == 'اتوماتیک'){
                                                    transmissionType = 'automatic';
                                                    transmissionTypeAr = 'اتوماتیک';
                                                    print('transmissionType');
                                                    print(transmissionType);
                                                    print(transmissionTypeAr);
                                                  }else {
                                                    optionValueTransmissionType = 'no';
                                                    optionValueTransmissionTypeAr = 'لا';
                                                    print('transmissionType');
                                                    print(transmissionType);
                                                    print(transmissionTypeAr);
                                                  }

                                                  addProductController.updateProductVehicles(
                                                    context,
                                                    state.showDetailsProductResponseModel![0].id.toString(),
                                                    state.showDetailsProductResponseModel![0].category!.name!.en!,
                                                    productDetailsCubit.nameOfProductController.text,
                                                    productDetailsCubit.newPriceController.text,
                                                    productDetailsCubit.oldPriceController.text,
                                                    productDetailsCubit.whatsAppController.text,
                                                    statusUser,
                                                    '${widget.governmentId == null ? '${state.showDetailsProductResponseModel![0].countryModel?.id.toString()}' : widget.governmentId}',
                                                    '${widget.cityId == null ? '${state.showDetailsProductResponseModel![0].stateModel?.id.toString()}' : widget.cityId}',
                                                    '',
                                                    productDetailsCubit.locationUserController.text,
                                                    '$statusProduct',
                                                    position.latitude.toString(),
                                                    position.longitude.toString(),
                                                    productDetailsCubit.descriptionController.text,
                                                    optionValueFuelTypeAr,
                                                    productDetailsCubit.yearOfProductController.text,
                                                    productDetailsCubit.kiloMetresOfProductController.text,
                                                    transmissionTypeAr,
                                                    optionValueColorAr,
                                                    optionValueBodyTypeAr,
                                                    optionValueEngineCapacityProduct,
                                                    optionValueNameModel,

                                                    optionValueFuelType,
                                                    productDetailsCubit.yearOfProductController.text,
                                                    productDetailsCubit.kiloMetresOfProductController.text,
                                                    transmissionType,
                                                    optionValueColor,
                                                    optionValueBodyType,
                                                    optionValueEngineCapacityProduct,
                                                    optionValueNameModel,);


                                                }
                                                else if (state.showDetailsProductResponseModel![0].category!.name!.en!.contains('Properties')) {


                                                  // statusUser = state.showDetailsProductResponseModel![0].status == 0 ? '0' : '1';

                                                  if(addProductController.selectedBrand == null){
                                                    statusProduct = state.showDetailsProductResponseModel![0].brandId.toString();
                                                  }else if(addProductController.selectedBrand != null){
                                                    statusProduct = addProductController.selectedBrand!.id.toString();
                                                  }

                                                  furnishedTypeProduct =  widget.furnishedType == null ?
                                                  '${state.showDetailsProductResponseModel![0].options![7].value}' :
                                                  '${widget.furnishedType}';

                                                  statusApartmentTypeProduct =  widget.statusApartment == null ?
                                                  '${state.showDetailsProductResponseModel![0].options![8].value}' :
                                                  '${widget.statusApartment}';

                                                  apartmentTypeProduct =  widget.typeApartment == null ?
                                                  '${state.showDetailsProductResponseModel![0].options![0].value}' :
                                                  '${widget.typeApartment}';

                                                  if (statusApartmentTypeProduct == 'Furnished' ||
                                                      statusApartmentTypeProduct == 'مفروش'){
                                                    statusApartmentType = 'Furnished';
                                                    statusApartmentTypeAr = 'مفروش';
                                                    print('statusApartmentType');
                                                    print(statusApartmentType);
                                                    print(statusApartmentTypeAr);
                                                  }else  if (statusApartmentTypeProduct == 'Not finished' ||
                                                      statusApartmentTypeProduct == 'لم ينتهي'){
                                                    statusApartmentType = 'Not finished';
                                                    statusApartmentTypeAr = 'لم ينتهي';
                                                    print('statusApartmentType');
                                                    print(statusApartmentType);
                                                    print(statusApartmentTypeAr);
                                                  }else  if (statusApartmentTypeProduct == 'Core & shell' ||
                                                      statusApartmentTypeProduct == 'النواة والصدفة'){
                                                    statusApartmentType = 'Core & shell';
                                                    statusApartmentTypeAr = 'النواة والصدفة';
                                                    print('statusApartmentType');
                                                    print(statusApartmentType);
                                                    print(statusApartmentTypeAr);
                                                  }else  if (statusApartmentTypeProduct == 'Semi finished' ||
                                                      statusApartmentTypeProduct == 'نصف تشطيب'){
                                                    statusApartmentType = 'Semi finished';
                                                    statusApartmentTypeAr = 'نصف تشطيب';
                                                    print('statusApartmentType');
                                                    print(statusApartmentType);
                                                    print(statusApartmentTypeAr);
                                                  }else {
                                                    statusApartmentType = 'null';
                                                    statusApartmentTypeAr = 'null';
                                                    print('statusApartmentType');
                                                    print(statusApartmentType);
                                                    print(statusApartmentTypeAr);
                                                  }

                                                  if (apartmentTypeProduct == 'Apartment' ||
                                                      apartmentTypeProduct == 'شقة'){
                                                    apartmentType = 'Apartment';
                                                    apartmentTypeAr = 'شقة';
                                                  }else  if (apartmentTypeProduct == 'Duplex' ||
                                                      apartmentTypeProduct == 'مزدوج'){
                                                    apartmentType = 'Duplex';
                                                    apartmentTypeAr = 'مزدوج';
                                                    print('apartmentType');
                                                    print(apartmentType);
                                                    print(apartmentTypeAr);
                                                  }else  if (apartmentTypeProduct == 'Penthouse' ||
                                                      apartmentTypeProduct == 'كنة'){
                                                    apartmentType = 'Penthouse';
                                                    apartmentTypeAr = 'كنة';
                                                    print('apartmentType');
                                                    print(apartmentType);
                                                    print(apartmentTypeAr);
                                                  }else  if (apartmentTypeProduct == 'Studio' ||
                                                      apartmentTypeProduct == 'ستوديو'){
                                                    apartmentType = 'Studio';
                                                    apartmentTypeAr = 'ستوديو';
                                                    print('apartmentType');
                                                    print(apartmentType);
                                                    print(apartmentTypeAr);
                                                  }else {
                                                    apartmentType = 'null';
                                                    apartmentTypeAr = 'null';
                                                    print('apartmentType');
                                                    print(apartmentType);
                                                    print(apartmentTypeAr);
                                                  }

                                                  if (furnishedTypeProduct == 'yes' ||
                                                      furnishedTypeProduct == 'نعم'){
                                                    furnishedType = 'yes';
                                                    furnishedTypeAr = 'نعم';
                                                    print('furnishedType');
                                                    print(furnishedType);
                                                    print(furnishedTypeAr);
                                                  }else  if (furnishedTypeProduct == 'no' ||
                                                      furnishedTypeProduct == 'لا'){
                                                    furnishedType = 'no';
                                                    furnishedTypeAr = 'لا';
                                                    print('furnishedType');
                                                    print(furnishedType);
                                                    print(furnishedTypeAr);
                                                  }else {
                                                    furnishedType = 'null';
                                                    furnishedTypeAr = 'null';
                                                    print('furnishedType');
                                                    print(furnishedType);
                                                    print(furnishedTypeAr);
                                                  }

                                                  if(optionValueAmenitiesProduct == 'balcony' || optionValueAmenitiesProduct == 'بلكونة'){
                                                    optionValueAmenities = 'balcony';
                                                    optionValueAmenitiesAr = 'بلكونة';
                                                    print('amenitiesType $optionValueAmenities');
                                                    print('amenitiesType $optionValueAmenitiesAr');
                                                  }else if(optionValueAmenitiesProduct == 'Built in kitchen appliances' ||
                                                      optionValueAmenitiesProduct == 'أجهزة المطبخ المدمجة'){
                                                    optionValueAmenities = 'Built in kitchen appliances';
                                                    optionValueAmenitiesAr = 'أجهزة المطبخ المدمجة';
                                                    print('optionValueAmenities $optionValueAmenities');
                                                    print('optionValueAmenities $optionValueAmenitiesAr');
                                                  }else if(optionValueAmenitiesProduct == 'Private garden' || optionValueAmenitiesProduct == 'حديقة خاصة'){
                                                    optionValueAmenities = 'Private garden';
                                                    optionValueAmenitiesAr = 'حديقة خاصة';
                                                    print('optionValueAmenities $optionValueAmenities');
                                                    print('optionValueAmenities $optionValueAmenitiesAr');
                                                  }else if(optionValueAmenitiesProduct == 'Central A/C & heating' || optionValueAmenitiesProduct == 'تدفئة وتكييف مركزي'){
                                                    optionValueAmenities = 'Central A/C & heating';
                                                    optionValueAmenitiesAr = 'تدفئة وتكييف مركزي';
                                                    print('optionValueAmenities $optionValueAmenities');
                                                    print('optionValueAmenities $optionValueAmenitiesAr');
                                                  }else if(optionValueAmenitiesProduct == 'Security' || optionValueAmenitiesProduct == 'حماية'){
                                                    optionValueAmenities = 'Security';
                                                    optionValueAmenitiesAr = 'حماية';
                                                    print('optionValueAmenities $optionValueAmenities');
                                                    print('optionValueAmenities $optionValueAmenitiesAr');
                                                  }else if(optionValueAmenitiesProduct == 'Covered parking' || optionValueAmenitiesProduct == 'مواقف مغطاة للسيارات'){
                                                    optionValueAmenities = 'Covered parking';
                                                    optionValueAmenitiesAr = 'مواقف مغطاة للسيارات';
                                                    print('optionValueAmenities $optionValueAmenities');
                                                    print('optionValueAmenities $optionValueAmenitiesAr');
                                                  }else if(optionValueAmenitiesProduct == 'Maids room' || optionValueAmenitiesProduct == 'غرفة للخادمة'){
                                                    optionValueAmenities = 'Maids room';
                                                    optionValueAmenitiesAr = 'غرفة للخادمة';
                                                    print('optionValueAmenities $optionValueAmenities');
                                                    print('optionValueAmenities $optionValueAmenitiesAr');
                                                  }else if(optionValueAmenitiesProduct == 'Pets allowed' ||
                                                      optionValueAmenitiesProduct == 'مسموح بدخول الحيوانات الأليفة'){
                                                    optionValueAmenities = 'Pets allowed';
                                                    optionValueAmenitiesAr = 'مسموح بدخول الحيوانات الأليفة';
                                                    print('optionValueAmenities $optionValueAmenities');
                                                    print('optionValueAmenities $optionValueAmenitiesAr');
                                                  }else if(optionValueAmenitiesProduct == 'Pool' || optionValueAmenitiesProduct == 'حمام سباحة'){
                                                    optionValueAmenities = 'Pool';
                                                    optionValueAmenitiesAr = 'حمام سباحة';
                                                    print('optionValueAmenities $optionValueAmenities');
                                                    print('optionValueAmenities $optionValueAmenitiesAr');
                                                  }else if(optionValueAmenitiesProduct == 'Electricity meter' || optionValueAmenitiesProduct == 'عداد الكهرباء'){
                                                    optionValueAmenities = 'Electricity meter';
                                                    optionValueAmenitiesAr = 'عداد الكهرباء';
                                                    print('optionValueAmenities $optionValueAmenities');
                                                    print('optionValueAmenities $optionValueAmenitiesAr');
                                                  } else if(optionValueAmenitiesProduct == null){
                                                    optionValueAmenities = 'null';
                                                    optionValueAmenitiesAr = 'null';
                                                    print('optionValueAmenities $optionValueAmenities');
                                                    print('optionValueAmenities $optionValueAmenitiesAr');
                                                  }


                                                  addProductController.updateProductProperties(
                                                      context,
                                                      state.showDetailsProductResponseModel![0].id.toString(),
                                                      state.showDetailsProductResponseModel![0].category!.name!.en!,
                                                      productDetailsCubit.nameOfProductController.text,
                                                      productDetailsCubit.newPriceController.text,
                                                      productDetailsCubit.oldPriceController.text,
                                                      productDetailsCubit.whatsAppController.text,
                                                      statusUser,
                                                      '${widget.governmentId == null ? '${state.showDetailsProductResponseModel![0].countryModel?.id.toString()}' : widget.governmentId}',
                                                      '${widget.cityId == null ? '${state.showDetailsProductResponseModel![0].stateModel?.id.toString()}' : widget.cityId}',
                                                      '',
                                                      productDetailsCubit.locationUserController.text,
                                                      '',
                                                      position.latitude.toString(),
                                                      position.longitude.toString(),
                                                      productDetailsCubit.descriptionController.text,
                                                      apartmentTypeAr,
                                                      productDetailsCubit.downPaymentController.text,
                                                      optionValueAmenitiesAr,
                                                      productDetailsCubit.bedroomOfProductController.text,
                                                      productDetailsCubit.bathroomOfProductController.text,
                                                      productDetailsCubit.areaPropertiesController.text,
                                                      optionValueLevel,
                                                      furnishedTypeAr,
                                                      statusApartmentTypeAr,

                                                      apartmentType,
                                                      productDetailsCubit.downPaymentController.text,
                                                      optionValueAmenities,
                                                      productDetailsCubit.bedroomOfProductController.text,
                                                      productDetailsCubit.bathroomOfProductController.text,
                                                      productDetailsCubit.areaPropertiesController.text,
                                                      optionValueLevel,
                                                      furnishedType,
                                                      statusApartmentType);

                                                }
                                                else if (state.showDetailsProductResponseModel![0].category!.name!.en!.contains('Electronics')) {


                                                  if(widget.typeCondtion == null){
                                                    statusUser = state.showDetailsProductResponseModel![0].status == 0 ? '0' : '1';
                                                  }else  if(widget.typeCondtion != null){
                                                    if(widget.typeCondtion!.contains('Used') || widget.typeCondtion!.contains('مستعمل')){
                                                      statusUser = '0';
                                                    }if(widget.typeCondtion!.contains('New') || widget.typeCondtion!.contains('جديد')){
                                                      statusUser = '1';
                                                    }
                                                  }

                                                  if(addProductController.selectedBrand == null){
                                                    statusProduct = state.showDetailsProductResponseModel![0].brandId.toString();
                                                  }else if(addProductController.selectedBrand != null){
                                                    statusProduct = addProductController.selectedBrand!.id.toString();
                                                  }


                                                  if(widget.typeWarrannt == null){
                                                    warrantyTypeProduct = '${state.showDetailsProductResponseModel![0].options![0].value!.contains('null') ?
                                                    'null' : state.showDetailsProductResponseModel![0].options![0].value}';
                                                  }else  if(widget.typeWarrannt != null){
                                                    warrantyTypeProduct = '${widget.typeWarrannt}';
                                                  }

                                                  if (warrantyTypeProduct == 'yes' ||
                                                      warrantyTypeProduct == 'نعم'){
                                                    warrantyType = 'yes';
                                                    warrantyTypeAr = 'نعم';
                                                    print('warrantyType');
                                                    print(warrantyType);
                                                    print(warrantyTypeAr);
                                                  }else  if (warrantyTypeProduct == 'no' ||
                                                      warrantyTypeProduct == 'لا'){
                                                    warrantyType = 'no';
                                                    warrantyTypeAr = 'لا';
                                                    print('warrantyType');
                                                    print(warrantyType);
                                                    print(warrantyTypeAr);
                                                  }else {
                                                    warrantyType = 'null';
                                                    warrantyTypeAr = 'null';
                                                    print('warrantyType');
                                                    print(warrantyType);
                                                    print(warrantyTypeAr);
                                                  }

                                                  print('details product');
                                                  print(state.showDetailsProductResponseModel![0].id.toString());
                                                  print(state.showDetailsProductResponseModel![0].category!.name!.en!);
                                                  print(productDetailsCubit.nameOfProductController.text);
                                                  print(productDetailsCubit.newPriceController.text);
                                                  print(productDetailsCubit.oldPriceController.text);
                                                  print(productDetailsCubit.whatsAppController.text);
                                                  print(statusUser);
                                                  print(widget.governmentId == null ?
                                                  governmentId : widget.governmentId);
                                                  print(widget.cityId == null ?
                                                  cityId : widget.cityId);
                                                  print(widget.areaId == null ?
                                                  areaId : widget.areaId);
                                                  // print(locationUserNew);
                                                  print(statusProduct);
                                                  print(productDetailsCubit.descriptionController.text);
                                                  print(warrantyType);
                                                  print(position.latitude.toString());
                                                  print('lanLocation');
                                                  print(position.longitude.toString());

                                                  // CustomFlutterToast('sss ${widget.typeCondtion}');
                                                  // CustomFlutterToast('sss ${statusUser}');
                                                  // CustomFlutterToast('sss ${warrantyType}');

                                                  print('whatsApp number ${productDetailsCubit.whatsAppController.text}');



                                                  addProductController.updateProductElectronics(
                                                      context,
                                                      state.showDetailsProductResponseModel![0].id.toString(),
                                                      state.showDetailsProductResponseModel![0].category!.name!.en!,
                                                      productDetailsCubit.nameOfProductController.text,
                                                      productDetailsCubit.newPriceController.text,
                                                      productDetailsCubit.oldPriceController.text,
                                                      productDetailsCubit.whatsAppController.text,
                                                      statusUser,
                                                      '${widget.governmentId == null ? '${state.showDetailsProductResponseModel![0].countryModel?.id.toString()}' : widget.governmentId}',
                                                      '${widget.cityId == null ? '${state.showDetailsProductResponseModel![0].stateModel?.id.toString()}' : widget.cityId}',
                                                      '',
                                                      productDetailsCubit.locationUserController.text,
                                                      '$statusProduct',
                                                      position.latitude.toString(),
                                                      position.longitude.toString(),
                                                      productDetailsCubit.descriptionController.text,
                                                      warrantyTypeAr,
                                                      warrantyType);

                                                }
                                                else if (state.showDetailsProductResponseModel![0].category!.name!.en!.contains('Fashion')) {


                                                  if(widget.typeCondtion == null){
                                                    statusUser = state.showDetailsProductResponseModel![0].status == 0 ? '0' : '1';
                                                  }else  if(widget.typeCondtion != null){
                                                    if(widget.typeCondtion!.contains('Used') || widget.typeCondtion!.contains('مستعمل')){
                                                      statusUser = '0';
                                                    }if(widget.typeCondtion!.contains('New') || widget.typeCondtion!.contains('جديد')){
                                                      statusUser = '1';
                                                    }
                                                  }


                                                  if(addProductController.selectedBrand == null){
                                                    statusProduct = state.showDetailsProductResponseModel![0].brandId.toString();
                                                  }else if(addProductController.selectedBrand != null){
                                                    statusProduct = addProductController.selectedBrand!.id.toString();
                                                  }

                                                  if(widget.typeFashion == null){
                                                    homeFashionTypeProduct = '${state.showDetailsProductResponseModel![0].options![0].value!.contains('null') ?
                                                    'null' : state.showDetailsProductResponseModel![0].options![0].value}' ;
                                                    print('homeFashionTypeProduct');
                                                    print(homeFashionTypeProduct);
                                                  }else  if(widget.typeFashion != null){
                                                    homeFashionTypeProduct = '${widget.typeFashion}';
                                                    print('homeFashionTypeProduct');
                                                    print(homeFashionTypeProduct);
                                                  }

                                                  if (homeFashionTypeProduct == 'Nightwear' ||
                                                      homeFashionTypeProduct == 'ملابس نوم'){
                                                    homeFashionType = 'Nightwear';
                                                    homeFashionTypeAr = 'ملابس نوم';
                                                    print('homeFashionType');
                                                    print(homeFashionType);
                                                    print(homeFashionTypeAr);
                                                  }else  if (homeFashionTypeProduct == 'Swimwear' ||
                                                      homeFashionTypeProduct == 'ملابس سباحة'){
                                                    homeFashionType = 'Swimwear';
                                                    homeFashionTypeAr = 'ملابس سباحة';
                                                    print('homeFashionType');
                                                    print(homeFashionType);
                                                    print(homeFashionTypeAr);
                                                  }else  if (homeFashionTypeProduct == 'Dresses' ||
                                                      homeFashionTypeProduct == 'فساتين'){
                                                    homeFashionType = 'Dresses';
                                                    homeFashionTypeAr = 'فساتين';
                                                    print('homeFashionType');
                                                    print(homeFashionType);
                                                    print(homeFashionTypeAr);
                                                  }else  if (homeFashionTypeProduct == 'Wedding Apparel' ||
                                                      homeFashionTypeProduct == 'ملابس الزفاف'){
                                                    homeFashionType = 'Wedding Apparel';
                                                    homeFashionTypeAr = 'ملابس الزفاف';
                                                    print('homeFashionType');
                                                    print(homeFashionType);
                                                    print(homeFashionTypeAr);
                                                  }else  if (homeFashionTypeProduct == 'Pullover - Coats - Jackets' ||
                                                      homeFashionTypeProduct == 'كنزة صوفية - معاطف - جاكيتات'){
                                                    homeFashionType = 'Pullover - Coats - Jackets';
                                                    homeFashionTypeAr = 'كنزة صوفية - معاطف - جاكيتات';
                                                    print('homeFashionType');
                                                    print(homeFashionType);
                                                    print(homeFashionTypeAr);
                                                  }else  if (homeFashionTypeProduct == 'Blouse - T-shirts - Tops' ||
                                                      homeFashionTypeProduct == 'بلوزة - تى شيرت - بلايز'){
                                                    homeFashionType = 'Blouse - T-shirts - Tops';
                                                    homeFashionTypeAr = 'بلوزة - تى شيرت - بلايز';
                                                    print('homeFashionType');
                                                    print(homeFashionType);
                                                    print(homeFashionTypeAr);
                                                  }else  if (homeFashionTypeProduct == 'Trousers - Leggings - Jeans' ||
                                                      homeFashionTypeProduct == 'بنطلون - ليقنز - جينز'){
                                                    homeFashionType = 'Trousers - Leggings - Jeans';
                                                    homeFashionTypeAr = 'بنطلون - ليقنز - جينز';
                                                    print('homeFashionType');
                                                    print(homeFashionType);
                                                    print(homeFashionTypeAr);
                                                  }else {
                                                    homeFashionType = 'null';
                                                    homeFashionTypeAr = 'null';
                                                    print('homeFashionType');
                                                    print(homeFashionType);
                                                    print(homeFashionTypeAr);
                                                  }


                                                  print('details product');
                                                  print(state.showDetailsProductResponseModel![0].id.toString());
                                                  print(state.showDetailsProductResponseModel![0].category!.name!.en!);
                                                  print(productDetailsCubit.nameOfProductController.text);
                                                  print(productDetailsCubit.newPriceController.text);
                                                  print(productDetailsCubit.oldPriceController.text);
                                                  print(productDetailsCubit.whatsAppController.text);
                                                  print(statusUser);
                                                  print(widget.governmentId == null ? governmentId : widget.governmentId);
                                                  print(widget.cityId == null ? cityId : widget.cityId);
                                                  print(widget.areaId == null ? areaId : widget.areaId);
                                                  //  print(locationUserNew);
                                                  print(statusProduct);
                                                  print(productDetailsCubit.descriptionController.text);
                                                  // print(warrantyType);
                                                  print(position.latitude.toString());
                                                  print('lanLocation');
                                                  print(position.longitude.toString());
                                                  print(homeFashionType);
                                                  print(homeFashionTypeAr);

                                                  addProductController.updateProductHomeFashion(
                                                      context,
                                                      state.showDetailsProductResponseModel![0].id.toString(),
                                                      state.showDetailsProductResponseModel![0].category!.name!.en!,
                                                      productDetailsCubit.nameOfProductController.text,
                                                      productDetailsCubit.newPriceController.text,
                                                      productDetailsCubit.oldPriceController.text,
                                                      productDetailsCubit.whatsAppController.text,
                                                      statusUser,
                                                      '${widget.governmentId == null ? '${state.showDetailsProductResponseModel![0].countryModel?.id.toString()}' : widget.governmentId}',
                                                      '${widget.cityId == null ? '${state.showDetailsProductResponseModel![0].stateModel?.id.toString()}' : widget.cityId}',
                                                      '',
                                                      productDetailsCubit.locationUserController.text,
                                                      '$statusProduct',
                                                      position.latitude.toString(),
                                                      position.longitude.toString(),
                                                      productDetailsCubit.descriptionController.text,
                                                      homeFashionTypeAr,
                                                      homeFashionType);

                                                }
                                                else if (state.showDetailsProductResponseModel![0].category!.name!.en!.contains('Home Furniture')) {


                                                  if(widget.typeCondtion == null){
                                                    statusUser = state.showDetailsProductResponseModel![0].status == 0 ? '0' : '1';
                                                  }else  if(widget.typeCondtion != null){
                                                    if(widget.typeCondtion!.contains('Used') || widget.typeCondtion!.contains('مستعمل')){
                                                      statusUser = '0';
                                                    }if(widget.typeCondtion!.contains('New') || widget.typeCondtion!.contains('جديد')){
                                                      statusUser = '1';
                                                    }
                                                  }

                                                  print('statusUser');
                                                  print(statusUser);

                                                  //statusUser = state.showDetailsProductResponseModel![0].status == 0 ? '0' : '1';


                                                  if(addProductController.selectedBrand == null){
                                                    statusProduct = state.showDetailsProductResponseModel![0].brandId.toString();
                                                  }else if(addProductController.selectedBrand != null){
                                                    statusProduct = addProductController.selectedBrand!.id.toString();
                                                  }


                                                  if(widget.typeHomeFurniture == null){
                                                    homeFurnitureTypeProduct = '${state.showDetailsProductResponseModel![0].options![0].value!.contains('null') ?
                                                    'null' : state.showDetailsProductResponseModel![0].options![0].value}';
                                                    print('homeFurnitureTypeProduct');
                                                    print(homeFurnitureTypeProduct);
                                                  }else  if(widget.typeHomeFurniture != null){
                                                    homeFurnitureTypeProduct = '${widget.typeHomeFurniture}';
                                                    print('homeFurnitureTypeProduct');
                                                    print(homeFurnitureTypeProduct);
                                                  }



                                                  if (homeFurnitureTypeProduct == 'Full bathroom' ||
                                                      homeFurnitureTypeProduct == 'حمام كامل'){
                                                    homeFurnitureType = 'Full bathroom';
                                                    homeFurnitureTypeAr = 'حمام كامل';
                                                    print('homeFurnitureType');
                                                    print(homeFurnitureType);
                                                    print(homeFurnitureTypeAr);
                                                  }else  if (homeFurnitureTypeProduct == 'Sink' ||
                                                      homeFurnitureTypeProduct == 'مكتب المدير'){
                                                    homeFurnitureType = 'Sink';
                                                    homeFurnitureTypeAr = 'مكتب المدير';
                                                    print('homeFurnitureType');
                                                    print(homeFurnitureType);
                                                    print(homeFurnitureTypeAr);
                                                  }else  if (homeFurnitureTypeProduct == 'Towels' ||
                                                      homeFurnitureTypeProduct == 'مناشف'){
                                                    homeFurnitureType = 'Towels';
                                                    homeFurnitureTypeAr = 'مناشف';
                                                    print('homeFurnitureType');
                                                    print(homeFurnitureType);
                                                    print(homeFurnitureTypeAr);
                                                  }else  if (homeFurnitureTypeProduct == 'Shower Room Tube' ||
                                                      homeFurnitureTypeProduct == 'غرفة الاستحمام حوض'){
                                                    homeFurnitureType = 'Shower Room Tube';
                                                    homeFurnitureTypeAr = 'غرفة الاستحمام حوض';
                                                    print('homeFurnitureType');
                                                    print(homeFurnitureType);
                                                    print(homeFurnitureTypeAr);
                                                  }else  if (homeFurnitureTypeProduct == 'Toilet' ||
                                                      homeFurnitureTypeProduct == 'حمام'){
                                                    homeFurnitureType = 'Toilet';
                                                    homeFurnitureTypeAr = 'حمام';
                                                    print('homeFurnitureType');
                                                    print(homeFurnitureType);
                                                    print(homeFurnitureTypeAr);
                                                  }else  if (homeFurnitureTypeProduct == 'Water mixers - Shower heads' ||
                                                      homeFurnitureTypeProduct == 'خلاطات مياه - رؤوس دوش'){
                                                    homeFurnitureType = 'Water mixers - Shower heads';
                                                    homeFurnitureTypeAr = 'خلاطات مياه - رؤوس دوش';
                                                    print('homeFurnitureType');
                                                    print(homeFurnitureType);
                                                    print(homeFurnitureTypeAr);
                                                  }else  if (homeFurnitureTypeProduct == 'Mirrors - Shelves - Other Accessories' ||
                                                      homeFurnitureTypeProduct == 'مرايات - ارفف - اكسسوارات اخرى'){
                                                    homeFurnitureType = 'Mirrors - Shelves - Other Accessories';
                                                    homeFurnitureTypeAr = 'مرايات - ارفف - اكسسوارات اخرى';
                                                    print('homeFurnitureType');
                                                    print(homeFurnitureType);
                                                    print(homeFurnitureTypeAr);
                                                  }else {
                                                    homeFurnitureType = 'null';
                                                    homeFurnitureTypeAr = 'null';
                                                    print('homeFurnitureType');
                                                    print(homeFurnitureType);
                                                    print(homeFurnitureTypeAr);
                                                  }


                                                  addProductController.updateProductHomeFurniture(
                                                      context,
                                                      state.showDetailsProductResponseModel![0].id.toString(),
                                                      state.showDetailsProductResponseModel![0].category!.name!.en!,
                                                      productDetailsCubit.nameOfProductController.text,
                                                      productDetailsCubit.newPriceController.text,
                                                      productDetailsCubit.oldPriceController.text,
                                                      productDetailsCubit.whatsAppController.text,
                                                      statusUser,
                                                      '${widget.governmentId == null ? '${state.showDetailsProductResponseModel![0].countryModel?.id.toString()}' : widget.governmentId}',
                                                      '${widget.cityId == null ? '${state.showDetailsProductResponseModel![0].stateModel?.id.toString()}' : widget.cityId}',
                                                      '',
                                                      productDetailsCubit.locationUserController.text,
                                                      '$statusProduct',
                                                      position.latitude.toString(),
                                                      position.longitude.toString(),
                                                      productDetailsCubit.descriptionController.text,
                                                      homeFurnitureTypeAr,
                                                      homeFurnitureType);

                                                }
                                                else if (state.showDetailsProductResponseModel![0].category!.name!.en!.contains('Books, Sports & Hobbies')) {


                                                  //  statusUser = state.showDetailsProductResponseModel![0].status == 0 ? '0' : '1';

                                                  if(addProductController.selectedBrand == null){
                                                    statusProduct = state.showDetailsProductResponseModel![0].brandId.toString();
                                                  }else if(addProductController.selectedBrand != null){
                                                    statusProduct = addProductController.selectedBrand!.id.toString();
                                                  }

                                                  if(widget.typeCondtion == null){
                                                    statusUser = state.showDetailsProductResponseModel![0].status == 0 ? '0' : '1';
                                                  }else  if(widget.typeCondtion != null){
                                                    if(widget.typeCondtion!.contains('Used') || widget.typeCondtion!.contains('مستعمل')){
                                                      statusUser = '0';
                                                    }if(widget.typeCondtion!.contains('New') || widget.typeCondtion!.contains('جديد')){
                                                      statusUser = '1';
                                                    }
                                                  }

                                                  if(widget.typeBooks == null){
                                                    booksTypeProduct = '${state.showDetailsProductResponseModel![0].options![0].value!.contains('null') ?
                                                    'null' : state.showDetailsProductResponseModel![0].options![0].value}';
                                                  }else  if(widget.typeBooks != null){
                                                    booksTypeProduct = '${widget.typeBooks}';
                                                  }




                                                  if (booksTypeProduct == 'Antiques' ||
                                                      booksTypeProduct == 'التحف'){
                                                    booksType = 'Antiques';
                                                    booksTypeAr = 'التحف';
                                                    print('booksType');
                                                    print(booksType);
                                                    print(booksTypeAr);
                                                  }else  if (booksTypeProduct == 'ART' ||
                                                      booksTypeProduct == 'فن'){
                                                    booksType = 'ART';
                                                    booksTypeAr = 'فن';
                                                    print('booksType');
                                                    print(booksType);
                                                    print(booksTypeAr);
                                                  }else  if (booksTypeProduct == 'Collectibles' ||
                                                      booksTypeProduct == 'المقتنيات'){
                                                    booksType = 'Collectibles';
                                                    booksTypeAr = 'المقتنيات';
                                                    print('booksType');
                                                    print(booksType);
                                                    print(booksTypeAr);
                                                  }else  if (booksTypeProduct == 'Old Currencies' ||
                                                      booksTypeProduct == 'العملات القديمة'){
                                                    booksType = 'Old Currencies';
                                                    booksTypeAr = 'العملات القديمة';
                                                    print('booksType');
                                                    print(booksType);
                                                    print(booksTypeAr);
                                                  }else  if (booksTypeProduct == 'Pens & Writing instruments' ||
                                                      booksTypeProduct == 'أقلام وأدوات الكتابة'){
                                                    booksType = 'Pens & Writing instruments';
                                                    booksTypeAr = 'أقلام وأدوات الكتابة';
                                                    print('booksType');
                                                    print(booksType);
                                                    print(booksTypeAr);
                                                  }else  if (booksTypeProduct == 'Other' ||
                                                      booksTypeProduct == 'اخري'){
                                                    booksType = 'Other';
                                                    booksTypeAr = 'اخري';
                                                    print('booksType');
                                                    print(booksType);
                                                    print(booksTypeAr);
                                                  }else {
                                                    booksType = 'null';
                                                    booksTypeAr = 'null';
                                                    print('booksType');
                                                    print(booksType);
                                                    print(booksTypeAr);
                                                  }

                                                  addProductController.updateProductBooks(
                                                      context,
                                                      state.showDetailsProductResponseModel![0].id.toString(),
                                                      state.showDetailsProductResponseModel![0].category!.name!.en!,
                                                      productDetailsCubit.nameOfProductController.text,
                                                      productDetailsCubit.newPriceController.text,
                                                      productDetailsCubit.oldPriceController.text,
                                                      productDetailsCubit.whatsAppController.text,
                                                      statusUser,
                                                      '${widget.governmentId == null ? '${state.showDetailsProductResponseModel![0].countryModel?.id.toString()}' : widget.governmentId}',
                                                      '${widget.cityId == null ? '${state.showDetailsProductResponseModel![0].stateModel?.id.toString()}' : widget.cityId}',
                                                      '',
                                                      productDetailsCubit.locationUserController.text,
                                                      '$statusProduct',
                                                      position.latitude.toString(),
                                                      position.longitude.toString(),
                                                      productDetailsCubit.descriptionController.text,
                                                      booksTypeAr,
                                                      booksType);

                                                }
                                                else if (state.showDetailsProductResponseModel![0].category!.name!.en!.contains('Kids & Babies')) {

                                                  //    statusUser = state.showDetailsProductResponseModel![0].status == 0 ? '0' : '1';
                                                  // kidsType = widget.typeKids == null ?
                                                  // '${state.showDetailsProductResponseModel![0].options![0].value}' :
                                                  // '${widget.typeKids}';

                                                  if(addProductController.selectedBrand == null){
                                                    statusProduct = state.showDetailsProductResponseModel![0].brandId.toString();
                                                  }else if(addProductController.selectedBrand != null){
                                                    statusProduct = addProductController.selectedBrand!.id.toString();
                                                  }

                                                  if(widget.typeKids == null){
                                                    kidsTypeProduct = '${state.showDetailsProductResponseModel![0].options![0].value!.contains('null') ?
                                                    'null' : state.showDetailsProductResponseModel![0].options![0].value}';
                                                  }else  if(widget.typeKids != null){
                                                    kidsTypeProduct = '${widget.typeKids}';
                                                  }



                                                  if(widget.typeCondtion == null){
                                                    statusUser = state.showDetailsProductResponseModel![0].status == 0 ? '0' : '1';
                                                  }else  if(widget.typeCondtion != null){
                                                    if(widget.typeCondtion!.contains('Used') || widget.typeCondtion!.contains('مستعمل')){
                                                      statusUser = '0';
                                                    }if(widget.typeCondtion!.contains('New') || widget.typeCondtion!.contains('جديد')){
                                                      statusUser = '1';
                                                    }
                                                  }


                                                  if (kidsTypeProduct == 'Bath Tub' ||
                                                      kidsTypeProduct == 'حوض أستحمام'){
                                                    kidsType = 'Bath Tub';
                                                    kidsTypeAr = 'حوض أستحمام';
                                                    print('kidsType');
                                                    print(booksType);
                                                    print(booksTypeAr);
                                                  }else  if (kidsTypeProduct == 'Diaper' ||
                                                      kidsTypeProduct == 'حفاضات'){
                                                    kidsType = 'Diaper';
                                                    kidsTypeAr = 'حفاضات';
                                                    print('kidsType');
                                                    print(booksType);
                                                    print(booksTypeAr);
                                                  }else  if (kidsTypeProduct == 'Shampoo - Soaps' ||
                                                      kidsTypeProduct == 'شامبو - صابون'){
                                                    kidsType = 'Shampoo - Soaps';
                                                    kidsTypeAr = 'شامبو - صابون';
                                                    print('kidsType');
                                                    print(booksType);
                                                    print(booksTypeAr);
                                                  }else  if (kidsTypeProduct == 'Skincare' ||
                                                      kidsTypeProduct == 'عناية بالجلد'){
                                                    kidsType = 'Skincare';
                                                    kidsTypeAr = 'عناية بالجلد';
                                                    print('kidsType');
                                                    print(booksType);
                                                    print(booksTypeAr);
                                                  }else  if (kidsTypeProduct == 'Silicone Nipple Protectors' ||
                                                      kidsTypeProduct == 'حماة حلمة سيليكون'){
                                                    kidsType = 'Silicone Nipple Protectors';
                                                    kidsTypeAr = 'حماة حلمة سيليكون';
                                                    print('kidsType');
                                                    print(booksType);
                                                    print(booksTypeAr);
                                                  }else  if (kidsTypeProduct == 'Sterilizer Tools' ||
                                                      kidsTypeProduct == 'أدوات التعقيم'){
                                                    kidsType = 'Sterilizer Tools';
                                                    kidsTypeAr = 'أدوات التعقيم';
                                                    print('kidsType');
                                                    print(booksType);
                                                    print(booksTypeAr);
                                                  }else  if (kidsTypeProduct == 'Toilet Training Seat' ||
                                                      kidsTypeProduct == 'مقعد تدريب على استعمال المرحاض'){
                                                    kidsType = 'Toilet Training Seat';
                                                    kidsTypeAr = 'مقعد تدريب على استعمال المرحاض';
                                                    print('kidsType');
                                                    print(booksType);
                                                    print(booksTypeAr);
                                                  }else  if (kidsTypeProduct == 'Sterilizer Tools' ||
                                                      kidsTypeProduct == 'أدوات التعقيم'){
                                                    kidsType = 'Sterilizer Tools';
                                                    kidsTypeAr = 'أدوات التعقيم';
                                                    print('kidsType');
                                                    print(booksType);
                                                    print(booksTypeAr);
                                                  }else  if (kidsTypeProduct == 'Other' ||
                                                      kidsTypeProduct == 'اخري'){
                                                    kidsType = 'Other';
                                                    kidsTypeAr = 'اخري';
                                                    print('kidsType');
                                                    print(booksType);
                                                    print(booksTypeAr);
                                                  }else {
                                                    kidsType = 'null';
                                                    kidsTypeAr = 'null';
                                                    print('kidsType');
                                                    print(booksType);
                                                    print(booksTypeAr);
                                                  }

                                                  addProductController.updateProductKids(
                                                      context,
                                                      state.showDetailsProductResponseModel![0].id.toString(),
                                                      state.showDetailsProductResponseModel![0].category!.name!.en!,
                                                      productDetailsCubit.nameOfProductController.text,
                                                      productDetailsCubit.newPriceController.text,
                                                      productDetailsCubit.oldPriceController.text,
                                                      productDetailsCubit.whatsAppController.text,
                                                      statusUser,
                                                      '${widget.governmentId == null ? '${state.showDetailsProductResponseModel![0].countryModel?.id.toString()}' : widget.governmentId}',
                                                      '${widget.cityId == null ? '${state.showDetailsProductResponseModel![0].stateModel?.id.toString()}' : widget.cityId}',
                                                      '',
                                                      productDetailsCubit.locationUserController.text,
                                                      '$statusProduct',
                                                      position.latitude.toString(),
                                                      position.longitude.toString(),
                                                      productDetailsCubit.descriptionController.text,
                                                      kidsTypeAr,
                                                      kidsType);

                                                }
                                                else if (state.showDetailsProductResponseModel![0].category!.name!.en!.contains('Business - Industrial - Agriculture')) {

                                                  //  statusUser = state.showDetailsProductResponseModel![0].status == 0 ? '0' : '1';

                                                  if(widget.typeCondtion == null){
                                                    statusUser = state.showDetailsProductResponseModel![0].status == 0 ? '0' : '1';
                                                  }else  if(widget.typeCondtion != null){
                                                    if(widget.typeCondtion!.contains('Used') || widget.typeCondtion!.contains('مستعمل')){
                                                      statusUser = '0';
                                                    }if(widget.typeCondtion!.contains('New') || widget.typeCondtion!.contains('جديد')){
                                                      statusUser = '1';
                                                    }
                                                  }


                                                  if(addProductController.selectedBrand == null){
                                                    statusProduct = state.showDetailsProductResponseModel![0].brandId.toString();
                                                  }else if(addProductController.selectedBrand != null){
                                                    statusProduct = addProductController.selectedBrand!.id.toString();
                                                  }

                                                  if(widget.typeBusiness == null){
                                                    businessTypeProduct = '${state.showDetailsProductResponseModel![0].options![0].value!.contains('null') ?
                                                    'null' : state.showDetailsProductResponseModel![0].options![0].value}';
                                                  }else  if(widget.typeBusiness != null){
                                                    businessTypeProduct = '${widget.typeBusiness}';
                                                  }


                                                  if(widget.typeCondtion == null){
                                                    statusUser = state.showDetailsProductResponseModel![0].status == 0 ? '0' : '1';
                                                  }else  if(widget.typeCondtion != null){
                                                    statusUser = widget.typeCondtion!.contains('Used')  ? '0' : '1';
                                                  }

                                                  if (businessTypeProduct == 'Seeds' ||
                                                      businessTypeProduct == 'بذور'){
                                                    businessType = 'Seeds';
                                                    businessTypeAr = 'بذور';
                                                  }else  if (businessTypeProduct == 'Crops' ||
                                                      businessTypeProduct == 'المحاصيل'){
                                                    businessType = 'Crops';
                                                    businessTypeAr = 'المحاصيل';
                                                    print('businessType');
                                                    print(businessType);
                                                    print(businessTypeAr);
                                                  }else  if (businessTypeProduct == 'agricultural machinery' ||
                                                      businessTypeProduct == 'الآلات الزراعية'){
                                                    businessType = 'agricultural machinery';
                                                    businessTypeAr = 'الآلات الزراعية';
                                                    print('businessType');
                                                    print(businessType);
                                                    print(businessTypeAr);
                                                  }else  if (businessTypeProduct == 'Pesticides' ||
                                                      businessTypeProduct == 'مبيدات حشرية'){
                                                    businessType = 'Pesticides';
                                                    businessTypeAr = 'مبيدات حشرية';
                                                    print('businessType');
                                                    print(businessType);
                                                    print(businessTypeAr);
                                                  }else  if (businessTypeProduct == 'Other' ||
                                                      businessTypeProduct == 'اخري'){
                                                    businessType = 'Other';
                                                    businessTypeAr = 'اخري';
                                                    print('businessType');
                                                    print(businessType);
                                                    print(businessTypeAr);
                                                  }else {
                                                    businessType = 'null';
                                                    businessTypeAr = 'null';
                                                    print('businessType');
                                                    print(businessType);
                                                    print(businessTypeAr);
                                                  }

                                                  addProductController.updateProductBusiness(
                                                      context,
                                                      state.showDetailsProductResponseModel![0].id.toString(),
                                                      state.showDetailsProductResponseModel![0].category!.name!.en!,
                                                      productDetailsCubit.nameOfProductController.text,
                                                      productDetailsCubit.newPriceController.text,
                                                      productDetailsCubit.oldPriceController.text,
                                                      productDetailsCubit.whatsAppController.text,
                                                      statusUser,
                                                      '${widget.governmentId == null ? '${state.showDetailsProductResponseModel![0].countryModel?.id.toString()}' : widget.governmentId}',
                                                      '${widget.cityId == null ? '${state.showDetailsProductResponseModel![0].stateModel?.id.toString()}' : widget.cityId}',
                                                      '',
                                                      productDetailsCubit.locationUserController.text,
                                                      '$statusProduct',
                                                      position.latitude.toString(),
                                                      position.longitude.toString(),
                                                      productDetailsCubit.descriptionController.text,
                                                      businessTypeAr,
                                                      businessType);


                                                }


                                              }else {

                                                _getCurrentLocation();
                                                print('latLocation');
                                                print('location denie' + LocaleKeys.warning.tr());
                                                print(LocaleKeys.openGps.tr());

                                                AwesomeDialog(
                                                  context: context,
                                                  dialogType: DialogType.warning,
                                                  animType: AnimType.RIGHSLIDE,
                                                  btnOkText: LocaleKeys.ok.tr(),
                                                  btnCancelText: LocaleKeys.cancel.tr(),
                                                  title: LocaleKeys.warning.tr(),
                                                  desc: LocaleKeys.openGps.tr(),
                                                  autoDismiss: false,
                                                  btnCancelOnPress: () {
                                                    _getCurrentLocation();
                                                  },
                                                  btnOkOnPress: () {
                                                    _getCurrentLocation();
                                                  },
                                                ).show();
                                              }
                                            });

                                          }

                                        }

                                      }

                                    },
                                    height: 48.h,
                                    fontSize: Dimensions.fontSizeLarge,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
              else if (state is ErrorProductDetailsState){
                return ErrorScreenConnection(
                  onPressed: (){
                    BlocProvider.of<ProductDetailsCubit>(context).getProductDetailsUser('${widget.product?.id}');
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => ChangeProductScreen2(product: widget.product,)));
                  },
                );
              }
              return  LoadingWidget(data: '');
            },
          );
        },
      )
    );
  }
}
