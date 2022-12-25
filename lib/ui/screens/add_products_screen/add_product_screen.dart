import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:shop/business_logic/app_layout_cubit/app_layout_cubit.dart';
import 'package:shop/business_logic/my_products_cubit/my_products_cubit.dart';
import 'package:shop/business_logic/my_products_cubit/my_products_state.dart';
import 'package:shop/data/internet_connectivity/no_internet.dart';
import 'package:shop/translations/locale_keys.g.dart';
import 'package:shop/ui/base/custom_button.dart';
import 'package:shop/ui/base/custom_toast.dart';
import 'package:shop/ui/screens/add_products_screen/choose_amenities_screen/choose_amenities_screen.dart';
import 'package:shop/ui/screens/add_products_screen/choose_body_type_screen/choose_body_type_screen.dart';
import 'package:shop/ui/screens/add_products_screen/choose_categories_screens/choose_government_product_screen.dart';
import 'package:shop/ui/screens/add_products_screen/choose_categories_screens/choose_main_category_screen.dart';
import 'package:shop/ui/screens/add_products_screen/choose_categories_screens/choose_one_brand_screen.dart';
import 'package:shop/ui/screens/add_products_screen/choose_categories_screens/choose_sub_category_screen.dart';
import 'package:shop/ui/screens/add_products_screen/choose_color_screen/choose_color_screen.dart';
import 'package:shop/ui/screens/add_products_screen/choose_engine_capacity_screen/choose_engine_capacity_screen.dart';
import 'package:shop/ui/screens/add_products_screen/choose_fuel_type_screen/choose_fuel_type_screen.dart';
import 'package:shop/ui/screens/add_products_screen/choose_level_screen/choose_level_screen.dart';
import 'package:shop/ui/widgets/My_products_widgets/add_product_widgets/condition_widget.dart';
import 'package:shop/ui/widgets/My_products_widgets/add_product_widgets/custom_button_widget.dart';
import 'package:shop/ui/widgets/My_products_widgets/add_product_widgets/images_section_widget.dart';
import 'package:shop/ui/widgets/My_products_widgets/add_product_widgets/input_text_form_field.dart';
import 'package:shop/utils/app_palette.dart';
import 'package:shop/utils/app_size_boxes.dart';
import 'package:shop/utils/dimensions.dart';
import '../../../business_logic/locations_cubit/locations_cubit.dart';
import '../../../data/models/government_model.dart';
import '../../../helpers/components.dart';
import '../../../libraries/dialog_widget.dart';
import '../layout/app_layout.dart';
import 'choose_categories_screens/choose_area_product_screen.dart';
import 'choose_categories_screens/choose_city_product_screen.dart';


class AddProductScreen extends StatefulWidget {
  AddProductScreen(
      {Key? key, this.governmentId, this.governmentName, this.cityId, this.cityName,this.whatsAppNumber,
        this.areaId, this.areaName, this.locationUser, this.nameProduct, this.fromPrice, this.toPrice, this.description,
        this.fuelType,this.bodyType,this.amenitiesType,this.colorType,this.engineCapacityType,this.kiloMetresType,
        this.levelType,this.year,this.bedroom,this.bathroom,this.downPayment,this.area})
      : super(key: key);

  String? governmentId, governmentName;
  String? cityId, cityName,bedroom,bathroom,whatsAppNumber;
  String? areaId, areaName,year,area,downPayment;
  String? locationUser,fuelType,amenitiesType,bodyType,colorType,engineCapacityType,kiloMetresType,levelType;
  String? fromPrice, toPrice, nameProduct, description;

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}


class _AddProductScreenState extends State<AddProductScreen> {


  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController nameOfProductController = TextEditingController();
  TextEditingController locationUserController = TextEditingController();
  TextEditingController oldPriceController = TextEditingController();
  TextEditingController newPriceController = TextEditingController();
  TextEditingController whatsAppController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController downPaymentController = TextEditingController();
  TextEditingController areaPropertiesController = TextEditingController();
  TextEditingController yearOfProductController = TextEditingController();
  TextEditingController kiloMetresOfProductController = TextEditingController();
  TextEditingController bedroomOfProductController = TextEditingController();
  TextEditingController bathroomOfProductController = TextEditingController();


  String? lottie;
  late String locationUser;
  late String statusUser;
  late String warrantyType;
  late String warrantyTypeAr;
  late String optionValueList;
  late String optionValueListAr;
  late String categoryId;
  late String apartmentType;
  late String apartmentTypeAr;
  late String statusApartmentType;
  late String statusApartmentTypeAr;
  late String transmissionType;
  late String transmissionTypeAr;
  late String furnishedType;
  late String furnishedTypeAr;
  late String homeFurnitureType;
  late String homeFurnitureTypeAr;
  late String homeFashionType;
  late String homeFashionTypeAr;
  late String booksType;
  late String booksTypeAr;
  late String businessType;
  late String businessTypeAr;
  late String kidsType;
  late String kidsTypeAr;
  late String fuelTypeAr,fuelType,amenitiesTypeAr,amenitiesType,
      bodyTypeAr,bodyType,colorTypeAr,colorType,engineCapacityTypeAr,engineCapacityType;
  late String latLocation;
  late String lanLocation;
  var nameOfProductOptionLabel;
  var snackBar;

  //// Properties

  late FocusNode nmeProductFocusNode;
  late FocusNode locationUserFocusNode;
  late FocusNode priceFocusNode;
  late FocusNode descriptionFocusNode;

 // Position? _currentPosition;

  LocationPermission? permission;
  String lanAddress = "";
  String latAddress = "";

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
      setState(() {
        //Pass the lat and long to the function
        _getAddressFromLatLng(position.latitude, position.longitude);

      });
    }).catchError((e) {
      print(e);
    });
  }

  _getAddressFromLatLng(double latitude, double longitude) async {
    try {
      List<Placemark> p = await placemarkFromCoordinates(latitude, longitude);

      Placemark place = p[0];

      setState(() {
        latAddress = "$latitude";
        lanAddress = "$longitude";
        print('latAddress');
        print(latAddress);
        print(lanAddress);

      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    determinePosition();

    print('government id ${widget.governmentId}');
    print('government name ${widget.governmentName}');

    print('city id ${widget.cityId}');
    print('city name ${widget.cityName}');
    print('nameProduct dd ${widget.nameProduct}');
    //
    // print('area id ${widget.areaId}');
    // print('area name ${widget.areaName}');

    if(widget.governmentId != null){
      BlocProvider.of<LocationsCubit>(context)
          .getCityOfGovernment('${widget.governmentId}');
    }else {
      return;
    }


    BlocProvider.of<AppLayoutCubit>(context).checkConnectionInternet();
    BlocProvider.of<AppLayoutCubit>(context).checkUserConnection();

    nameOfProductController.text = widget.nameProduct == null ? '': '${widget.nameProduct}';
    oldPriceController.text = widget.fromPrice == null ? '': '${widget.fromPrice}';
    newPriceController.text = widget.toPrice == null ? '': '${widget.toPrice}';
    descriptionController.text = widget.description == null ? '': '${widget.description}';
    locationUserController.text = widget.locationUser == null ? '': '${widget.locationUser}';

    yearOfProductController.text = widget.year == null ? '': '${widget.year}';
    areaPropertiesController.text = widget.area  == null ? '': '${widget.area}';
    downPaymentController.text = widget.downPayment == null ? '': '${widget.downPayment}';
    bedroomOfProductController.text = widget.bedroom == null ? '': '${widget.bedroom}';
    bathroomOfProductController.text = widget.bathroom == null ? '': '${widget.bathroom}';
    kiloMetresOfProductController.text = widget.kiloMetresType == null ? '': '${widget.kiloMetresType}';
    whatsAppController.text = widget.whatsAppNumber == null ? '': '${widget.whatsAppNumber}';

    nmeProductFocusNode = FocusNode();
    locationUserFocusNode = FocusNode();
    priceFocusNode = FocusNode();
    descriptionFocusNode = FocusNode();

    _getCurrentLocation();

  }

  @override
  void dispose() {
    nameOfProductController.dispose();
    locationUserController.dispose();
    oldPriceController.dispose();
    newPriceController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  _submit(BuildContext context,
      {required AddProductCubit addProductCubit,
        required AppLayoutState appLayoutState}) async{
  //  print('add product is');
    if (appLayoutState is ConnectionSuccess) {
   //   print('add product is');
      if (_formKey.currentState!.validate()) {
     //   print('add product is');
        statusUser = addProductCubit.condition == Condition.used ? '0' : '1';
       // warrantyType = addProductCubit.warranty == Warranty.yes ? 'yes' : 'no';
       // transmissionType = addProductCubit.transmissionType == TransmissionType.automatic ? 'automatic' : 'manual';
       // furnishedType = addProductCubit.finished == Finished.yes ? 'yes' : 'no';
        locationUser = '${widget.governmentName},${widget.cityName},${widget.areaName}';

        //// Type Electronics
        if (addProductCubit.isVisibleWarrantyYes == true){
          warrantyType = 'yes';
          warrantyTypeAr = 'نعم';
        }else  if (addProductCubit.isVisibleWarrantyNo == true){
          warrantyType = 'no';
          warrantyTypeAr = 'لا';
        }else {
          warrantyType = 'null';
          warrantyTypeAr = 'null';
        }

        //// Type Properties
        if (addProductCubit.isVisibleFurnishedProperties == true){
          furnishedType = 'yes';
          furnishedTypeAr = 'نعم';
        }else  if (addProductCubit.isVisibleNotFurnishedProperties == true){
          furnishedType = 'no';
          furnishedTypeAr = 'لا';
        }else {
          furnishedType = 'null';
          furnishedTypeAr = 'null';
        }

        //// Type Vehicles
        if (addProductCubit.isVisibleManual == true){
          transmissionType = 'manual';
          transmissionTypeAr = 'يدوي';
        }else  if (addProductCubit.isVisibleAutomatic == true){
          transmissionType = 'automatic';
          transmissionTypeAr = 'اتوماتیک';
        }else {
          transmissionType = 'null';
          transmissionTypeAr = 'null';
        }

        //// Type Properties
        if (addProductCubit.isVisibleApartment == true){
          apartmentType = 'Apartment';
          apartmentTypeAr = 'شقة';
        }else  if (addProductCubit.isVisibleDuplex == true){
          apartmentType = 'Duplex';
          apartmentTypeAr = 'مزدوج';
        }else  if (addProductCubit.isVisiblePenthouse == true){
          apartmentType = 'Penthouse';
          apartmentTypeAr = 'كنة';
        }else  if (addProductCubit.isVisibleStudio == true){
          apartmentType = 'Studio';
          apartmentTypeAr = 'ستوديو';
        }else {
          apartmentType = 'null';
          apartmentTypeAr = 'null';
        }


        /// Type Properties
        if (addProductCubit.isVisibleFinished == true){
          statusApartmentType = 'Furnished';
          statusApartmentTypeAr = 'مفروش';
        }else  if (addProductCubit.isVisibleNotFinished == true){
          statusApartmentType = 'Not finished';
          statusApartmentTypeAr = 'لم ينتهي';
        }else  if (addProductCubit.isVisibleCoreShell == true){
          statusApartmentType = 'Core & shell';
          statusApartmentTypeAr = 'النواة والصدفة';
        }else  if (addProductCubit.isVisibleSemiFinished == true){
          statusApartmentType = 'Semi finished';
          statusApartmentTypeAr = 'نصف تشطيب';
        }else {
          statusApartmentType = 'null';
          statusApartmentTypeAr = 'null';
        }


        /// Type Home Furniture
        if (addProductCubit.isVisibleBedroom == true){
          homeFurnitureType = 'Full bathroom';
          homeFurnitureTypeAr = 'حمام كامل';
        }else  if (addProductCubit.isVisibleSink == true){
          homeFurnitureType = 'Sink';
          homeFurnitureTypeAr = 'مكتب المدير';
        }else  if (addProductCubit.isVisibleTowels == true){
          homeFurnitureType = 'Towels';
          homeFurnitureTypeAr = 'مناشف';
        }else  if (addProductCubit.isVisibleShower == true){
          homeFurnitureType = 'Shower Room Tube';
          homeFurnitureTypeAr = 'غرفة الاستحمام حوض';
        }else  if (addProductCubit.isVisibleToilet == true){
          homeFurnitureType = 'Toilet';
          homeFurnitureTypeAr = 'حمام';
        }else  if (addProductCubit.isVisibleWaterMix == true){
          homeFurnitureType = 'Water mixers - Shower heads';
          homeFurnitureTypeAr = 'خلاطات مياه - رؤوس دوش';
        }else  if (addProductCubit.isVisibleMirrors == true){
          homeFurnitureType = 'Mirrors - Shelves - Other Accessories';
          homeFurnitureTypeAr = 'مرايات - ارفف - اكسسوارات اخرى';
        }else {
          homeFurnitureType = 'null';
          homeFurnitureTypeAr = 'null';
        }


        /// Type Fashion
        if (addProductCubit.isVisibleNightwear == true){
          homeFashionType = 'Nightwear';
          homeFashionTypeAr = 'ملابس نوم';
        }else  if (addProductCubit.isVisibleSwimwear == true){
          homeFashionType = 'Swimwear';
          homeFashionTypeAr = 'ملابس سباحة';
        }else  if (addProductCubit.isVisibleDresses == true){
          homeFashionType = 'Dresses';
          homeFashionTypeAr = 'فساتين';
        }else  if (addProductCubit.isVisibleWeddingApparel == true){
          homeFashionType = 'Wedding Apparel';
          homeFashionTypeAr = 'ملابس الزفاف';
        }else  if (addProductCubit.isVisiblePulloverCoatsJackets == true){
          homeFashionType = 'Pullover - Coats - Jackets';
          homeFashionTypeAr = 'كنزة صوفية - معاطف - جاكيتات';
        }else  if (addProductCubit.isVisibleBlouseTShairt == true){
          homeFashionType = 'Blouse - T-shirts - Tops';
          homeFashionTypeAr = 'بلوزة - تى شيرت - بلايز';
        }else  if (addProductCubit.isVisibleTrousers == true){
          homeFashionType = 'Trousers - Leggings - Jeans';
          homeFashionTypeAr = 'بنطلون - ليقنز - جينز';
        }else {
          homeFashionType = 'null';
          homeFashionTypeAr = 'null';
        }

        ////// Business
        if (addProductCubit.isVisibleSeeds == true){
          businessType = 'Seeds';
          businessTypeAr = 'بذور';
        }else  if (addProductCubit.isVisibleCrops == true){
          businessType = 'Crops';
          businessTypeAr = 'المحاصيل';
        }else  if (addProductCubit.isVisibleFarmMachinery == true){
          businessType = 'agricultural machinery';
          businessTypeAr = 'الآلات الزراعية';
        }else  if (addProductCubit.isVisiblePesticides == true){
          businessType = 'Pesticides';
          businessTypeAr = 'مبيدات حشرية';
        }else  if (addProductCubit.isVisibleOtherBusiness == true){
          businessType = 'Other';
          businessTypeAr = 'اخري';
        }else {
          businessType = 'null';
          businessTypeAr = 'null';
        }

        ////// Books
        if (addProductCubit.isVisibleAntiques == true){
          booksType = 'Antiques';
          booksTypeAr = 'التحف';
        }else  if (addProductCubit.isVisibleArt == true){
          booksType = 'ART';
          booksTypeAr = 'فن';
        }else  if (addProductCubit.isVisibleCollectibles == true){
          booksType = 'Collectibles';
          booksTypeAr = 'المقتنيات';
        }else  if (addProductCubit.isVisibleOldCurrencies == true){
          booksType = 'Old Currencies';
          booksTypeAr = 'العملات القديمة';
        }else  if (addProductCubit.isVisiblePens == true){
          booksType = 'Pens & Writing instruments';
          booksTypeAr = 'أقلام وأدوات الكتابة';
        }else  if (addProductCubit.isVisibleOther == true){
          booksType = 'Other';
          booksTypeAr = 'اخري';
        }else {
          booksType = 'null';
          booksTypeAr = 'null';
        }

        ////// kids
        if (addProductCubit.isVisibleBathTub == true){
          kidsType = 'Bath Tub';
          kidsTypeAr = 'حوض أستحمام';
        }else  if (addProductCubit.isVisibleDiaper == true){
          kidsType = 'Diaper';
          kidsTypeAr = 'حفاضات';
        }else  if (addProductCubit.isVisibleShampoo == true){
          kidsType = 'Shampoo - Soaps';
          kidsTypeAr = 'شامبو - صابون"';
        }else  if (addProductCubit.isVisibleSkincare == true){
          kidsType = 'Skincare';
          kidsTypeAr = 'عناية بالجلد';
        }else  if (addProductCubit.isVisibleSilicone == true){
          kidsType = 'Silicone Nipple Protectors';
          kidsTypeAr = 'حماة حلمة سيليكون';
        }else  if (addProductCubit.isVisibleSterilizerTools == true){
          kidsType = 'Sterilizer Tools';
          kidsTypeAr = 'أدوات التعقيم';
        }else  if (addProductCubit.isVisibleToiletKids == true){
          kidsType = 'Toilet Training Seat';
          kidsTypeAr = 'مقعد تدريب على استعمال المرحاض';
        }else  if (addProductCubit.isVisibleOtherKids == true){
          kidsType = 'Other';
          kidsTypeAr = 'اخري';
        }else {
          kidsType = 'null';
          kidsTypeAr = 'null';
        }


        if(addProductCubit.selectedMainCat != null){

          if(widget.governmentId != null){
            if(widget.cityId != null){
              permission = await Geolocator.checkPermission();
              if (permission == LocationPermission.denied) {
                permission = await Geolocator.requestPermission();
                if (permission == LocationPermission.deniedForever) {
                  return Future.error('Location Not Available');
                }
              }else {

                await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
                    .then((Position position) {
                  setState(() {
                    //Pass the lat and long to the function

                    if (position.latitude != null){

                      print('latLocation');
                      print(position.latitude.toString());
                      print('lanLocation');
                      print(position.longitude.toString());


                      if(addProductCubit.selectedMainCat!.name!.en!.contains('Vehicles')){


                        print('add product Vehicles');
                        print('${addProductCubit.selectedMainCat?.id}');
                        print('${addProductCubit.selectedSubCat?.id}');
                        print('governmentId');
                        print(widget.governmentId);
                        print('areaId');
                        print(widget.areaId);
                        print('cityId');
                        print(widget.cityId);
                        print(nameOfProductController.text);
                        print(descriptionController.text);
                        print(newPriceController.text );
                        print(locationUserController.text);
                        print(yearOfProductController.text);
                        print(kiloMetresOfProductController.text);
                        print(widget.engineCapacityType);
                        print(statusUser);
                      //  print(addProductCubit.dropdownValueBrand);

                        if(widget.fuelType == 'بنزين' || widget.fuelType == 'Benzine'){
                          fuelType = 'Benzine';
                          fuelTypeAr = 'بنزين';
                          print('fuelType $fuelType');
                          print('fuelType $fuelTypeAr');
                        }else if(widget.fuelType == 'ديزل' || widget.fuelType == 'Diesel'){
                          fuelType = 'Diesel';
                          fuelTypeAr = 'ديزل';
                          print('fuelType $fuelType');
                          print('fuelType $fuelTypeAr');
                        }else if(widget.fuelType == 'Electricity meter' || widget.fuelType == 'عداد الكهرباء'){
                          fuelType = 'Electricity meter';
                          fuelTypeAr = 'عداد الكهرباء';
                          print('fuelType $fuelType');
                          print('fuelType $fuelTypeAr');
                        }else if(widget.fuelType == 'Hypride' || widget.fuelType == 'هايبرايد'){
                          fuelType = 'Hypride';
                          fuelTypeAr = 'هايبرايد';
                          print('fuelType $fuelType');
                          print('fuelType $fuelTypeAr');
                        }else if(widget.fuelType == 'Natural gas' || widget.fuelType == 'غاز طبيعي'){
                          fuelType = 'Natural gas';
                          fuelTypeAr = 'غاز طبيعي';
                          print('fuelType $fuelType');
                          print('fuelType $fuelTypeAr');
                        }else if(widget.fuelType == null){
                          fuelType = 'null';
                          fuelTypeAr = 'null';
                          print('fuelType $fuelType');
                          print('fuelType $fuelTypeAr');
                        }

                        if(widget.colorType == 'ابيض' || widget.colorType == 'White'){
                          colorType = 'White';
                          colorTypeAr = 'ابيض';
                          print('colorType $colorType');
                          print('colorType $colorTypeAr');
                        }else if(widget.colorType == 'احمر' || widget.colorType == 'Red'){
                          colorType = 'Red';
                          colorTypeAr = 'احمر';
                          print('colorType $colorType');
                          print('colorType $colorTypeAr');
                        }else if(widget.colorType == 'بني' || widget.colorType == 'Brown'){
                          colorType = 'Brown';
                          colorTypeAr = 'بني';
                          print('colorType $colorType');
                          print('colorType $colorTypeAr');
                        }else if(widget.colorType == 'ازرق' || widget.colorType == 'Blue'){
                          colorType = 'Blue';
                          colorTypeAr = 'ازرق';
                          print('colorType $colorType');
                          print('colorType $colorTypeAr');
                        }else if(widget.colorType == 'كحلي' || widget.colorType == 'Dark blue'){
                          colorType = 'Dark blue';
                          colorTypeAr = 'كحلي';
                          print('colorType $colorType');
                          print('colorType $colorTypeAr');
                        }else if(widget.colorType == 'اصفر' || widget.colorType == 'Yellow'){
                          colorType = 'Yellow';
                          colorTypeAr = 'اصفر';
                          print('colorType $colorType');
                          print('colorType $colorTypeAr');
                        }else if(widget.colorType == 'نبيتي' || widget.colorType == 'Burgundy'){
                          colorType = 'Burgundy';
                          colorTypeAr = 'نبيتي';
                          print('colorType $colorType');
                          print('colorType $colorTypeAr');
                        }else if(widget.colorType == 'رمادي' || widget.colorType == 'Gary'){
                          colorType = 'Gary';
                          colorTypeAr = 'رمادي';
                          print('colorType $colorType');
                          print('colorType $colorTypeAr');
                        } else if(widget.colorType == null){
                          colorType = 'null';
                          colorTypeAr = 'null';
                          print('colorType $colorType');
                          print('colorType $colorTypeAr');
                        }


                        if(widget.bodyType == '4*4' || widget.bodyType == '4*4'){
                          bodyTypeAr = '4*4';
                          bodyType = '4*4';
                          print('bodyType $bodyType');
                          print('bodyType $bodyTypeAr');
                        }else if(widget.bodyType == 'Cabriolet' || widget.bodyType == 'كابريوليه'){
                          bodyTypeAr = 'كابريوليه';
                          bodyType = 'cabriolet';
                          print('bodyType $bodyType');
                          print('bodyType $bodyTypeAr');
                        }else if(widget.bodyType == 'Coupe' || widget.bodyType == 'كوبيه'){
                          bodyTypeAr = 'كوبيه';
                          bodyType = 'coupe';
                          print('bodyType $bodyType');
                          print('bodyType $bodyTypeAr');
                        }else if(widget.bodyType == 'Hatchback' || widget.bodyType == 'هاتشباك'){
                          bodyTypeAr = 'هاتشباك';
                          bodyType = 'Hatchback';
                          print('bodyType $bodyType');
                          print('bodyType $bodyTypeAr');
                        }else if(widget.bodyType == 'Suv' || widget.bodyType == 'سيارات الدفع الرباعي'){
                          bodyTypeAr = 'سيارات الدفع الرباعي';
                          bodyType = 'Suv';
                          print('bodyType $bodyType');
                          print('bodyType $bodyTypeAr');
                        }else if(widget.bodyType == 'Sedan' || widget.bodyType == 'سيدان'){
                          bodyTypeAr = 'سيدان';
                          bodyType = 'Sedan';
                          print('bodyType $bodyType');
                          print('bodyType $bodyTypeAr');
                        }else if(widget.bodyType == 'VanBus' || widget.bodyType == 'شاحنة / حافلة'){
                          bodyTypeAr = 'شاحنة / حافلة';
                          bodyType = 'VanBus';
                          print('bodyType $bodyType');
                          print('bodyType $bodyTypeAr');
                        }else if(widget.bodyType == 'Other' || widget.bodyType == 'اخري'){
                          bodyType = 'Other';
                          bodyTypeAr = 'اخري';
                          print('bodyType $bodyType');
                          print('bodyType $bodyTypeAr');
                        } else if(widget.colorType == null){
                          bodyType = 'null';
                          bodyTypeAr = 'null';
                          print('bodyType $bodyType');
                          print('bodyType $bodyTypeAr');
                        }

                        addProductCubit.addProduct(
                            context,
                            nameOfProductController.text,
                            newPriceController.text,
                            newPriceController.text,
                            whatsAppController.text,
                            locationUserController.text,
                            descriptionController.text,
                            '${widget.governmentId}',
                            '${widget.cityId}',
                            '',
                            statusUser,
                            position.latitude.toString(),
                            position.longitude.toString(),
                            fuelTypeAr,
                            yearOfProductController.text,
                            kiloMetresOfProductController.text,
                            transmissionTypeAr,
                            colorTypeAr,
                            bodyTypeAr,
                            '${widget.engineCapacityType}',
                            '${addProductCubit.dropdownValueBrand}',
                            fuelType,
                            yearOfProductController.text,
                            kiloMetresOfProductController.text,
                            transmissionType,
                            colorType,
                            bodyType,
                            '${widget.engineCapacityType}', '${addProductCubit.dropdownValueBrand}',
                            '', '', '', '', '', '', '', '', '','', '', '', '', '', '', '', '', '','','','','','','','','','','','','');
                        //  CustomFlutterToast('${addProductCubit.selectedMainCat?.name?.en}');
                      }
                      else if(addProductCubit.selectedMainCat!.name!.en!.contains('Properties')){


                        if(widget.amenitiesType == 'Balcony' || widget.amenitiesType == 'بلكونة'){
                          amenitiesType = 'Balcony';
                          amenitiesTypeAr = 'بلكونة';
                          print('amenitiesType $amenitiesType');
                          print('amenitiesType $amenitiesTypeAr');
                        }else if(widget.amenitiesType == 'Built in kitchen appliances' ||
                            widget.amenitiesType == 'أجهزة المطبخ المدمجة'){
                          amenitiesType = 'Built in kitchen appliances';
                          amenitiesTypeAr = 'أجهزة المطبخ المدمجة';
                          print('amenitiesType $amenitiesType');
                          print('amenitiesType $amenitiesTypeAr');
                        }else if(widget.amenitiesType == 'Private garden' || widget.amenitiesType == 'حديقة خاصة'){
                          amenitiesType = 'Private garden';
                          amenitiesTypeAr = 'حديقة خاصة';
                          print('amenitiesType $amenitiesType');
                          print('amenitiesType $amenitiesTypeAr');
                        }else if(widget.amenitiesType == 'Central A/C & heating' || widget.amenitiesType == 'تدفئة وتكييف مركزي'){
                          amenitiesType = 'Central A/C & heating';
                          amenitiesTypeAr = 'تدفئة وتكييف مركزي';
                          print('amenitiesType $amenitiesType');
                          print('amenitiesType $amenitiesTypeAr');
                        }else if(widget.amenitiesType == 'Security' || widget.amenitiesType == 'حماية'){
                          amenitiesType = 'Security';
                          amenitiesTypeAr = 'حماية';
                          print('amenitiesType $amenitiesType');
                          print('amenitiesType $amenitiesTypeAr');
                        }else if(widget.amenitiesType == 'Covered parking' || widget.amenitiesType == 'مواقف مغطاة للسيارات'){
                          amenitiesType = 'Covered parking';
                          amenitiesTypeAr = 'مواقف مغطاة للسيارات';
                          print('amenitiesType $amenitiesType');
                          print('amenitiesType $amenitiesTypeAr');
                        }else if(widget.amenitiesType == 'Maids room' || widget.amenitiesType == 'غرفة للخادمة'){
                          amenitiesType = 'Maids room';
                          amenitiesTypeAr = 'غرفة للخادمة';
                          print('amenitiesType $amenitiesType');
                          print('amenitiesType $amenitiesTypeAr');
                        }else if(widget.amenitiesType == 'Pets allowed' ||
                            widget.amenitiesType == 'مسموح بدخول الحيوانات الأليفة'){
                          amenitiesType = 'Pets allowed';
                          amenitiesTypeAr = 'مسموح بدخول الحيوانات الأليفة';
                          print('amenitiesType $amenitiesType');
                          print('amenitiesType $amenitiesTypeAr');
                        }else if(widget.amenitiesType == 'Pool' || widget.amenitiesType == 'حمام سباحة'){
                          amenitiesType = 'Pool';
                          amenitiesTypeAr = 'حمام سباحة';
                          print('amenitiesType $amenitiesType');
                          print('amenitiesType $amenitiesTypeAr');
                        }else if(widget.amenitiesType == 'Electricity meter' || widget.amenitiesType == 'عداد الكهرباء'){
                          amenitiesType = 'Electricity meter';
                          amenitiesTypeAr = 'عداد الكهرباء';
                          print('amenitiesType $amenitiesType');
                          print('amenitiesType $amenitiesTypeAr');
                        } else if(widget.amenitiesType == null){
                          amenitiesType = 'null';
                          amenitiesTypeAr = 'null';
                          print('amenitiesType $amenitiesType');
                          print('amenitiesType $amenitiesTypeAr');
                        }

                        print('add product Vehicles');
                        print('${addProductCubit.selectedMainCat?.id}');
                        print('${addProductCubit.selectedSubCat?.id}');
                        print('governmentId');
                        print(widget.governmentId);
                        print('cityId');
                        print(widget.cityId);
                        print(nameOfProductController.text);
                        print(descriptionController.text);
                        print(newPriceController.text );
                        print(locationUserController.text);
                        print(whatsAppController.text);
                        print(downPaymentController.text);
                        print(apartmentType);
                        print(apartmentTypeAr);
                        print(widget.bedroom);
                        print(statusUser);
                        print(widget.bathroom);
                        print(widget.area);
                        print(widget.levelType);
                        print(furnishedType);
                        print(furnishedTypeAr);
                        print(statusApartmentType);
                        print(statusApartmentTypeAr);

                        addProductCubit.addProduct(
                            context,
                            nameOfProductController.text,
                            newPriceController.text,
                            newPriceController.text,
                            whatsAppController.text,
                            locationUserController.text,
                            descriptionController.text,
                            '${widget.governmentId}',
                            '${widget.cityId}',
                            '',
                            '',
                            position.latitude.toString(),
                            position.longitude.toString(),
                            '', '', '', '', '', '', '', '', '','', '', '', '','','','',
                            apartmentTypeAr,
                            '${widget.downPayment}',
                            amenitiesTypeAr,
                            '${widget.bedroom}',
                            '${widget.bathroom}',
                            '${widget.area}',
                            '${widget.levelType}',
                            furnishedTypeAr,
                            statusApartmentTypeAr,
                            apartmentType,
                            '${widget.downPayment}',
                            amenitiesType,
                            '${widget.bedroom}',
                            '${widget.bathroom}',
                            '${widget.area}',
                            '${widget.levelType}',
                            furnishedType,
                            statusApartmentType,'','','','','','','','','','','','');
                        //   CustomFlutterToast('${addProductCubit.selectedMainCat?.name?.en}');

                      }
                      else if(addProductCubit.selectedMainCat!.name!.en!.contains('Electronics')){

                        print('add product is');
                        print('${addProductCubit.selectedMainCat?.id}');
                        print('${addProductCubit.selectedSubCat?.id}');
                        print('governmentId');
                        print(widget.governmentId);
                        print('cityId');
                        print(widget.cityId);
                        print('whatsAppController');
                        print(whatsAppController.text);
                        print(nameOfProductController.text);
                        print(descriptionController.text);
                        print(newPriceController.text );
                        print(locationUser);
                        print(statusUser);
                        print('Location latitude');
                        print(position.latitude.toString());
                        print(position.longitude.toString());

                        addProductCubit.addProduct(
                            context,
                            nameOfProductController.text,
                            newPriceController.text,
                            newPriceController.text,
                            whatsAppController.text,
                            locationUserController.text,
                            descriptionController.text,
                            '${widget.governmentId}',
                            '${widget.cityId}',
                            '',
                            statusUser,
                            position.latitude.toString(),
                            position.longitude.toString(),
                            '', '', '', '', '', '', '', '', '','', '', '', '','', '','','',
                            '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '',
                            '',warrantyTypeAr,warrantyType,'','','','','','','','','','');

                        //  CustomFlutterToast('${addProductCubit.selectedMainCat?.name?.en}');

                      }
                      else if(addProductCubit.selectedMainCat!.name!.en!.contains('Fashion')){

                        print('add product is');
                        print('${addProductCubit.selectedMainCat?.id}');
                        print('${addProductCubit.selectedSubCat?.id}');
                        print('governmentId');
                        print(widget.governmentId);
                        print('whatsAppController');
                        print(whatsAppController.text);
                        print('areaId');
                        print(widget.areaId);
                        print('cityId');
                        print(widget.cityId);
                        print(nameOfProductController.text);
                        print(descriptionController.text);
                        print(newPriceController.text );
                        print(locationUserController.text);
                        print(statusUser);
                        print('Location latitude');
                        print(position.latitude.toString());
                        print(position.longitude.toString());
                        print('homeFashionType');
                        print(homeFashionType);
                        print(homeFashionTypeAr);

                        addProductCubit.addProduct(
                            context,
                            nameOfProductController.text,
                            newPriceController.text,
                            newPriceController.text,
                            whatsAppController.text,
                            locationUserController.text,
                            descriptionController.text,
                            '${widget.governmentId}',
                            '${widget.cityId}',
                            '',
                            statusUser,
                            position.latitude.toString(),
                            position.longitude.toString(),
                            '', '', '', '', '', '', '', '', '','', '', '', '','', '','','',
                            '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '',
                            '','','','','',homeFashionTypeAr,homeFashionType,'','','','','','');
                        //   CustomFlutterToast('${addProductCubit.selectedMainCat?.name?.en}');

                      }
                      else if(addProductCubit.selectedMainCat!.name!.en!.contains('Home Furniture')){

                        print('add product is');
                        print('${addProductCubit.selectedMainCat?.id}');
                        print('${addProductCubit.selectedSubCat?.id}');
                        print('governmentId');
                        print(widget.governmentId);
                        print('whatsAppController');
                        print(whatsAppController.text);
                        print('areaId');
                        print(widget.areaId);
                        print('cityId');
                        print(widget.cityId);
                        print(nameOfProductController.text);
                        print(descriptionController.text);
                        print(newPriceController.text );
                        print(locationUserController.text);
                        print(statusUser);
                        print('Location latitude');
                        print(position.latitude.toString());
                        print(position.longitude.toString());
                        print('homeFashionType');
                        print(homeFurnitureType);
                        print(homeFurnitureTypeAr);

                        addProductCubit.addProduct(
                            context,
                            nameOfProductController.text,
                            newPriceController.text,
                            newPriceController.text,
                            whatsAppController.text,
                            locationUserController.text,
                            descriptionController.text,
                            '${widget.governmentId}',
                            '${widget.cityId}',
                            '',
                            statusUser,
                            position.latitude.toString(),
                            position.longitude.toString(),
                            '', '', '', '', '', '', '', '', '','', '', '', '','', '','','',
                            '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '',
                            '','','',homeFurnitureTypeAr,homeFurnitureType,'','','','','','','','');
                        //   CustomFlutterToast('${addProductCubit.selectedMainCat?.name?.en}');

                      }
                      else if(addProductCubit.selectedMainCat!.name!.en!.contains('Books, Sports & Hobbies')) {

                        print('add product is');
                        print('${addProductCubit.selectedMainCat?.id}');
                        print('${addProductCubit.selectedSubCat?.id}');
                        print('governmentId');
                        print(widget.governmentId);
                        print('whatsAppController');
                        print(whatsAppController.text);
                        print(widget.cityId);
                        print(nameOfProductController.text);
                        print(descriptionController.text);
                        print(newPriceController.text );
                        print(locationUserController.text);
                        print(statusUser);
                        print('Location latitude');
                        print(position.latitude.toString());
                        print(position.longitude.toString());
                        print('homeFashionType');
                        print(booksType);
                        print(booksTypeAr);

                        addProductCubit.addProduct(
                            context,
                            nameOfProductController.text,
                            newPriceController.text,
                            newPriceController.text,
                            whatsAppController.text,
                            locationUserController.text,
                            descriptionController.text,
                            '${widget.governmentId}',
                            '${widget.cityId}',
                            '',
                            statusUser,
                            position.latitude.toString(),
                            position.longitude.toString(),
                            '', '', '', '', '', '', '', '', '','', '', '', '','', '','','',
                            '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '',
                            '','','','','','','',booksTypeAr,booksType,'','','','');
                        //   CustomFlutterToast('${addProductCubit.selectedMainCat?.name?.en}');

                      }
                      else if(addProductCubit.selectedMainCat!.name!.en!.contains('Kids & Babies')){

                        print('add product is');
                        print('${addProductCubit.selectedMainCat?.id}');
                        print('${addProductCubit.selectedSubCat?.id}');
                        print('governmentId');
                        print(widget.governmentId);
                        print('whatsAppController');
                        print(whatsAppController.text);
                        print('cityId');
                        print(widget.cityId);
                        print(nameOfProductController.text);
                        print(descriptionController.text);
                        print(newPriceController.text );
                        print(locationUserController.text);
                        print(statusUser);
                        print('Location latitude');
                        print(position.latitude.toString());
                        print(position.longitude.toString());
                        print('homeFashionType');
                        print(kidsType);
                        print(kidsTypeAr);

                        addProductCubit.addProduct(
                            context,
                            nameOfProductController.text,
                            newPriceController.text,
                            newPriceController.text,
                            whatsAppController.text,
                            locationUserController.text,
                            descriptionController.text,
                            '${widget.governmentId}',
                            '${widget.cityId}',
                            '',
                            statusUser,
                            position.latitude.toString(),
                            position.longitude.toString(),
                            '', '', '', '', '', '', '', '', '','', '', '', '','', '','','',
                            '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '',
                            '','','','','','','','','',kidsTypeAr,kidsType,'','');
                        //   CustomFlutterToast('${addProductCubit.selectedMainCat?.name?.en}');

                      }
                      else if(addProductCubit.selectedMainCat!.name!.en!.contains('Business - Industrial - Agriculture')){

                        print('add product is');
                        print('${addProductCubit.selectedMainCat?.id}');
                        print('${addProductCubit.selectedSubCat?.id}');
                        print('governmentId');
                        print(widget.governmentId);
                        print('whatsAppController');
                        print(whatsAppController.text);
                        print('cityId');
                        print(widget.cityId);
                        print(nameOfProductController.text);
                        print(descriptionController.text);
                        print(newPriceController.text );
                        print(locationUserController.text);
                        print(statusUser);
                        print('Location latitude');
                        print(position.latitude.toString());
                        print(position.longitude.toString());
                        print('homeFashionType');
                        print(businessTypeAr);
                        print(businessType);

                        addProductCubit.addProduct(
                          context,
                          nameOfProductController.text,
                          newPriceController.text,
                          newPriceController.text,
                          whatsAppController.text,
                          locationUserController.text,
                          descriptionController.text,
                          '${widget.governmentId}',
                          '${widget.cityId}',
                          '',
                          statusUser,
                          position.latitude.toString(),
                          position.longitude.toString(),
                          '', '', '', '', '', '', '', '', '','', '', '', '','', '','','',
                          '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '',
                          '','','','','','','','','', '', '',businessTypeAr, businessType,);
                        //   CustomFlutterToast('${addProductCubit.selectedMainCat?.name?.en}');

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
                }).catchError((e) {
                  print(e);
                });

              }
            }else {
              AwesomeDialog(
                context: context,
                dialogType: DialogType.warning,
                animType: AnimType.BOTTOMSLIDE,
                title: LocaleKeys.warning.tr(),
                btnOkText: LocaleKeys.ok.tr(),
                btnCancelText: LocaleKeys.cancel.tr(),
                desc: LocaleKeys.cityRequired.tr(),
                btnCancelOnPress: () {},
                btnOkOnPress: () {},
              ).show();

            }
          }else {
            AwesomeDialog(
              context: context,
              dialogType: DialogType.warning,
              animType: AnimType.RIGHSLIDE,
              title: LocaleKeys.warning.tr(),
              btnOkText: LocaleKeys.ok.tr(),
              btnCancelText: LocaleKeys.cancel.tr(),
              desc: LocaleKeys.governmentRequired.tr(),
              btnCancelOnPress: () {},
              btnOkOnPress: () {},
            ).show();
          }

        }else {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.warning,
            animType: AnimType.RIGHSLIDE,
            title: LocaleKeys.warning.tr(),
            btnOkText: LocaleKeys.ok.tr(),
            btnCancelText: LocaleKeys.cancel.tr(),
            desc: LocaleKeys.selectMainCategory.tr(),
            btnCancelOnPress: () {},
            btnOkOnPress: () {},
          ).show();
        }



        // addProductCubit.selectedMainCat = null;
        // addProductCubit.selectedSubCat = null;
        // addProductCubit.selectedBrand = null;
        // addProductCubit.images = [];

      }
    } else if (appLayoutState is ConnectionFailure) {
      customFlutterToast(LocaleKeys.internetConnection.tr());
    }
  }

  loadOptionOfCategory(String categoryId) {
    BlocProvider.of<AddProductCubit>(context).getOptionFromCategories(
        categoryId);
  }

  // addProductController.selectedMainCat != null ?
  // loadOptionOfCategory('${addProductController.selectedMainCat?.id.toString()}') : null;


  void rebuildAllChildren(BuildContext context) {
    void rebuild(Element el) {
      el.markNeedsBuild();
      el.visitChildren(rebuild);
    }
    (context as Element).visitChildren(rebuild);
  }

  @override
  Widget build(BuildContext context) {
    rebuildAllChildren(context);
   final stateConnectionInternet = context.watch<AppLayoutCubit>().state;
    return BlocBuilder<AddProductCubit,AddProductState>(
      builder: (context, state) {
        AddProductCubit addProductController = AddProductCubit.get(context);
        return WillPopScope(
          onWillPop: () async{
            addProductController.selectedMainCat = null;
            addProductController.selectedSubCat = null;
            addProductController.selectedBrand = null;
            print('back selected');
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => AppLayout()));
            return false;
          },
          child: Scaffold(
            backgroundColor: AppPalette.primary,
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    25.heightBox,
                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 15.h),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: ()=> navigateReplaceTo(context: context, widget: AppLayout()),
                            child: Icon(Icons.arrow_back_ios,color: AppPalette.white,size: 25.sp,),
                          ),
                          Expanded(
                            child: Center(
                              child: AutoSizeText(
                                LocaleKeys.addNewProduct.tr(),
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
                    Container(
                      decoration: const BoxDecoration(
                          color: AppPalette.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25),
                              topRight: Radius.circular(25))),
                      child: BlocConsumer<AddProductCubit, AddProductState>(
                        listener: (BuildContext context, addProductState) async {
                          //  _handleLoginListener(context, addProductState);
                        },
                        builder: (context, addProductState) {
                          return BlocConsumer<AppLayoutCubit, AppLayoutState>(
                            listener: (context, state) {},
                            builder: (context, state) {
                              return Column(
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
                                          CustomButtonWidget(
                                              title: context.locale.languageCode.contains(
                                                  'en')
                                                  ? addProductController
                                                  .selectedMainCat != null ?
                                              '${addProductController.selectedMainCat
                                                  ?.name?.en!}' : LocaleKeys.category.tr()
                                                  : context.locale.languageCode.contains(
                                                  'ar')
                                                  ? addProductController
                                                  .selectedMainCat != null ?
                                              '${addProductController.selectedMainCat
                                                  ?.name?.ar!}' : LocaleKeys.category.tr()
                                                  : context.locale.languageCode.contains(
                                                  'tr')
                                                  ? addProductController
                                                  .selectedMainCat != null ?
                                              '${addProductController.selectedMainCat
                                                  ?.name?.tr!}' : LocaleKeys.category.tr()
                                                  : context.locale.languageCode.contains(
                                                  'de')
                                                  ? addProductController
                                                  .selectedMainCat != null ?
                                              '${addProductController.selectedMainCat
                                                  ?.name?.de!}' : LocaleKeys.category.tr()
                                                  : ' ',
                                              onTap: (){
                                                addProductController.selectedBrand = null;
                                                Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
                                                    ChooseMainCategoryScreen(
                                                      governmentId: widget
                                                          .governmentId,
                                                      governmentName: widget
                                                          .governmentName,
                                                      cityId: widget.cityId,
                                                      whatsAppNumber: whatsAppController.text,
                                                      year: yearOfProductController.text,
                                                      downPayment: downPaymentController.text,
                                                      area: areaPropertiesController.text,
                                                      bathroom: bathroomOfProductController.text,
                                                      bedroom: bedroomOfProductController.text,
                                                      cityName: widget.cityName,
                                                      areaId: widget.areaId,
                                                      areaName: widget.areaName,
                                                      toPrice: newPriceController.text,
                                                      fromPrice: oldPriceController.text,
                                                      levelType: widget.levelType,
                                                      kiloMetresType: kiloMetresOfProductController.text,
                                                      amenitiesType: widget.amenitiesType,
                                                      fuelType: widget.fuelType,
                                                      engineCapacityType: widget.engineCapacityType,
                                                      colorType: widget.colorType,
                                                      bodyType: widget.bodyType,
                                                      nameProduct: nameOfProductController.text,
                                                      description: descriptionController
                                                          .text,
                                                      locationUser: '', data: '',)));
                                              }),
                                          if (addProductController.selectedMainCat != null)
                                            15.heightBox,
                                          if (addProductController.selectedMainCat != null)
                                            CustomButtonWidget(
                                                title: context.locale.languageCode
                                                    .contains('en')
                                                    ? addProductController
                                                    .selectedSubCat != null ?
                                                '${addProductController.selectedSubCat
                                                    ?.name?.en!}' : LocaleKeys.subCategory
                                                    .tr()
                                                    : context.locale.languageCode
                                                    .contains('ar')
                                                    ? addProductController
                                                    .selectedSubCat != null ?
                                                '${addProductController.selectedSubCat
                                                    ?.name?.ar!}' : LocaleKeys.subCategory
                                                    .tr()
                                                    : context.locale.languageCode
                                                    .contains('tr')
                                                    ? addProductController
                                                    .selectedSubCat != null ?
                                                '${addProductController.selectedSubCat
                                                    ?.name?.tr!}' : LocaleKeys.subCategory
                                                    .tr()
                                                    : context.locale.languageCode
                                                    .contains('de')
                                                    ? addProductController
                                                    .selectedSubCat != null ?
                                                '${addProductController.selectedSubCat
                                                    ?.name?.de!}' : LocaleKeys.subCategory
                                                    .tr()
                                                    : ' ',
                                                onTap: () =>
                                                    Navigator.of(context)
                                                        .push(MaterialPageRoute(
                                                      builder: (context) =>
                                                          ChooseSubCategoryScreen(
                                                            category: addProductController.selectedMainCat!,
                                                            governmentId: widget
                                                                .governmentId,
                                                            governmentName: widget
                                                                .governmentName,
                                                            cityId: widget.cityId,
                                                            whatsAppNumber: whatsAppController.text,
                                                            year: yearOfProductController.text,
                                                            downPayment: downPaymentController.text,
                                                            area: areaPropertiesController.text,
                                                            bathroom: bathroomOfProductController.text,
                                                            bedroom: bedroomOfProductController.text,
                                                            cityName: widget.cityName,
                                                            areaId: widget.areaId,
                                                            areaName: widget.areaName,
                                                            toPrice: newPriceController.text,
                                                            fromPrice: oldPriceController.text,
                                                            levelType: widget.levelType,
                                                            kiloMetresType: kiloMetresOfProductController.text,
                                                            amenitiesType: widget.amenitiesType,
                                                            fuelType: widget.fuelType,
                                                            engineCapacityType: widget.engineCapacityType,
                                                            colorType: widget.colorType,
                                                            bodyType: widget.bodyType,
                                                            nameProduct: nameOfProductController.text,
                                                            description: descriptionController
                                                                .text,
                                                            locationUser: '', data: '',),
                                                    ))),
                                          15.heightBox,
                                          InputTextFormField(
                                            hintText: LocaleKeys.nameOfProduct.tr(),
                                            textEditingController: nameOfProductController,
                                            validator: (val) {
                                              if (val.isEmpty) {
                                                return LocaleKeys.mustNotEmpty.tr();
                                              }
                                            },
                                          ),
                                          15.heightBox,
                                          Row(
                                            children: [
                                              // Expanded(
                                              //   child: InputTextFormField(
                                              //     hintText: LocaleKeys.oldPrice.tr(),
                                              //     textEditingController: oldPriceController,
                                              //     textInputType: TextInputType.number,
                                              //     suffixIcon: Container(
                                              //         padding: EdgeInsets.all(
                                              //           Dimensions.paddingSize,
                                              //         ),
                                              //         child: SvgPicture.asset(
                                              //           "assets/images/svg/doller.svg",
                                              //           color: AppPalette.black,
                                              //         )),
                                              //     validator: (val) {
                                              //       // if (val.isEmpty) {
                                              //       //   return "enter price";
                                              //       // }
                                              //     },
                                              //   ),
                                              // ),
                                              // 15.widthBox,
                                              Expanded(
                                                child: InputTextFormField(
                                                  hintText: LocaleKeys.newPrice.tr(),
                                                  textEditingController: newPriceController,
                                                  textInputType: TextInputType.number,
                                                  suffixIcon: Container(
                                                      padding: EdgeInsets.all(
                                                        Dimensions.paddingSize,
                                                      ),
                                                      child: Text(LocaleKeys.currencyPrice.tr())),
                                                  validator: (val) {
                                                    if (val.isEmpty) {
                                                      return LocaleKeys.mustNotEmpty.tr();
                                                    }
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                          15.heightBox,
                                          InputTextFormField(
                                            hintText: LocaleKeys.whatsAppNumber.tr(),
                                            textEditingController: whatsAppController,
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
                                                        ? LocaleKeys.government.tr()
                                                        : '${widget.governmentName}',
                                                    onTap: () {
                                                      Navigator.of(context).push(
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  ChooseGovernmentProductScreen(
                                                                      data: '',
                                                                      governmentId: widget
                                                                          .governmentId,
                                                                      governmentName: widget
                                                                          .governmentName,
                                                                      cityId: widget.cityId,
                                                                      whatsAppNumber: whatsAppController.text,
                                                                      year: yearOfProductController.text,
                                                                      downPayment: downPaymentController.text,
                                                                      area: areaPropertiesController.text,
                                                                      bathroom: bathroomOfProductController.text,
                                                                      bedroom: bedroomOfProductController.text,
                                                                      cityName: widget.cityName,
                                                                      areaId: widget.areaId,
                                                                      areaName: widget.areaName,
                                                                      toPrice: newPriceController.text,
                                                                      fromPrice: oldPriceController.text,
                                                                      levelType: widget.levelType,
                                                                      kiloMetresType: kiloMetresOfProductController.text,
                                                                      amenitiesType: widget.amenitiesType,
                                                                      fuelType: widget.fuelType,
                                                                      engineCapacityType: widget.engineCapacityType,
                                                                      colorType: widget.colorType,
                                                                      bodyType: widget.bodyType,
                                                                      nameProduct: nameOfProductController.text,
                                                                      description: descriptionController.text,
                                                                      locationUser: locationUserController.text)
                                                          ));
                                                    }),
                                              ),
                                              7.widthBox,
                                              Expanded(
                                                child: CustomButtonWidget(
                                                    title: widget.cityName == null
                                                        ? LocaleKeys.city.tr()
                                                        : '${widget.cityName}',
                                                    onTap: () {
                                                      if (widget.governmentId != null){
                                                        Navigator.of(context).push(
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                                  ChooseCityProductScreen(
                                                                    data: '',
                                                                    governmentId: widget
                                                                        .governmentId,
                                                                    governmentName: widget
                                                                        .governmentName,
                                                                    cityId: widget.cityId,
                                                                    whatsAppNumber: whatsAppController.text,
                                                                    year: yearOfProductController.text,
                                                                    downPayment: downPaymentController.text,
                                                                    area: areaPropertiesController.text,
                                                                    bathroom: bathroomOfProductController.text,
                                                                    bedroom: bedroomOfProductController.text,
                                                                    cityName: widget.cityName,
                                                                    areaId: widget.areaId,
                                                                    areaName: widget.areaName,
                                                                    toPrice: newPriceController
                                                                        .text,
                                                                    fromPrice: oldPriceController
                                                                        .text,
                                                                    levelType: widget.levelType,
                                                                    kiloMetresType: kiloMetresOfProductController.text,
                                                                    amenitiesType: widget.amenitiesType,
                                                                    fuelType: widget.fuelType,
                                                                    engineCapacityType: widget.engineCapacityType,
                                                                    colorType: widget.colorType,
                                                                    bodyType: widget.bodyType,
                                                                    nameProduct: nameOfProductController
                                                                        .text,
                                                                    description: descriptionController
                                                                        .text,
                                                                    locationUser: locationUserController.text,),
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
                                            textEditingController:
                                            locationUserController,
                                            validator: (val) {
                                              if (val.isEmpty) {
                                                return LocaleKeys.mustNotEmpty.tr();
                                              }
                                            },
                                          ),
                                          15.heightBox,
                                          //    addProductController.selectedMainCat != null ?
                                          //   handleOptionProductWidget(context,addProductState),
                                          ////// Properties Category
                                          addProductController.selectedMainCat != null ?
                                          addProductController.selectedMainCat!.name!.en!
                                              .contains('Properties') ?
                                          Column(
                                            children: [
                                              15.heightBox,
                                              Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(LocaleKeys.type.tr(),
                                                        style: const TextStyle(
                                                            color: AppPalette.black,
                                                            fontWeight: FontWeight.w500),),
                                                    ],
                                                  ),
                                                  10.heightBox,
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        flex: 1,
                                                        child: ConditionWidget(
                                                          title: LocaleKeys.apartment.tr(),
                                                          color: addProductController.isVisibleApartment
                                                              ? AppPalette.primary
                                                              : AppPalette.lightPrimary,
                                                          // onTap: filterCubit
                                                          //     .changeWarranty(),
                                                          textColor: addProductController.isVisibleApartment
                                                              ? AppPalette.white
                                                              : AppPalette.black, onTap: () {
                                                          setState(() {
                                                            addProductController.isVisibleApartment = !addProductController.isVisibleApartment;
                                                            addProductController.isVisibleDuplex = false;
                                                            addProductController.isVisiblePenthouse = false;
                                                            addProductController.isVisibleStudio = false;

                                                          });
                                                        },
                                                        ),
                                                      ),
                                                      5.widthBox,
                                                      Expanded(
                                                        flex: 1,
                                                        child: ConditionWidget(
                                                          title: LocaleKeys.duplex.tr(),
                                                          color: addProductController.isVisibleDuplex
                                                              ? AppPalette.primary
                                                              : AppPalette.lightPrimary,
                                                          // onTap: filterCubit
                                                          //     .changeWarranty(),
                                                          textColor: addProductController.isVisibleDuplex
                                                              ? AppPalette.white
                                                              : AppPalette.black, onTap: () {
                                                          setState(() {
                                                            addProductController.isVisibleApartment = false;
                                                            addProductController.isVisibleDuplex = !addProductController.isVisibleDuplex;
                                                            addProductController.isVisiblePenthouse = false;
                                                            addProductController.isVisibleStudio = false;

                                                          });
                                                        },
                                                        ),
                                                      ),
                                                      5.widthBox,
                                                      Expanded(
                                                        flex: 1,
                                                        child: ConditionWidget(
                                                          title: LocaleKeys.penthouse.tr(),
                                                          color: addProductController.isVisiblePenthouse
                                                              ? AppPalette.primary
                                                              : AppPalette.lightPrimary,
                                                          // onTap: filterCubit
                                                          //     .changeWarranty(),
                                                          textColor: addProductController.isVisiblePenthouse
                                                              ? AppPalette.white
                                                              : AppPalette.black, onTap: () {
                                                          setState(() {
                                                            addProductController.isVisibleApartment = false;
                                                            addProductController.isVisibleDuplex = false;
                                                            addProductController.isVisiblePenthouse = !addProductController.isVisiblePenthouse;
                                                            addProductController.isVisibleStudio = false;

                                                          });
                                                        },
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  10.heightBox,
                                                  Row(
                                                    children: [
                                                      ConditionWidget(
                                                        title: LocaleKeys.studio.tr(),
                                                        color: addProductController.isVisibleStudio
                                                            ? AppPalette.primary
                                                            : AppPalette.lightPrimary,
                                                        // onTap: filterCubit
                                                        //     .changeWarranty(),
                                                        textColor: addProductController.isVisibleStudio
                                                            ? AppPalette.white
                                                            : AppPalette.black, onTap: () {
                                                        setState(() {
                                                          addProductController.isVisibleApartment = false;
                                                          addProductController.isVisibleDuplex = false;
                                                          addProductController.isVisiblePenthouse = false;
                                                          addProductController.isVisibleStudio = !addProductController.isVisibleStudio;

                                                        });
                                                      },
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              15.heightBox,
                                              InputTextFormField(
                                                hintText: LocaleKeys.downPayment.tr(),
                                                textEditingController: downPaymentController,
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
                                              CustomButtonWidget(
                                                  title: widget.amenitiesType != null ?
                                                  widget.amenitiesType!
                                                      :LocaleKeys.amenities.tr(),
                                                  onTap: () {
                                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
                                                        ChooseAmenitiesAddProductScreen(
                                                          governmentId: widget
                                                              .governmentId,
                                                          governmentName: widget
                                                              .governmentName,
                                                          cityId: widget.cityId,
                                                          year: yearOfProductController.text,
                                                          downPayment: downPaymentController.text,
                                                          area: areaPropertiesController.text,
                                                          bathroom: bathroomOfProductController.text,
                                                          bedroom: bedroomOfProductController.text,
                                                          cityName: widget.cityName,
                                                          areaId: widget.areaId,
                                                          whatsAppNumber: whatsAppController.text,
                                                          areaName: widget.areaName,
                                                          toPrice: newPriceController.text,
                                                          data: '',
                                                          fromPrice: oldPriceController.text,
                                                          levelType: widget.levelType,
                                                          kiloMetresType: kiloMetresOfProductController.text,
                                                          amenitiesType: widget.amenitiesType,
                                                          fuelType: widget.fuelType,
                                                          engineCapacityType: widget.engineCapacityType,
                                                          colorType: widget.colorType,
                                                          bodyType: widget.bodyType,
                                                          nameProduct: nameOfProductController.text,
                                                          description: descriptionController.text,
                                                          locationUser: locationUserController.text,
                                                        )));
                                                  }),
                                              15.heightBox,
                                              InputTextFormField(
                                                hintText: LocaleKeys.bedroom.tr(),
                                                textEditingController:
                                                bedroomOfProductController,
                                                textInputType: TextInputType.number,
                                                validator: (val) {
                                                  // if (val.isEmpty) {
                                                  //   return LocaleKeys.mustNotEmpty.tr();
                                                  // }
                                                },),
                                              15.heightBox,
                                              InputTextFormField(
                                                hintText: LocaleKeys.bathroom.tr(),
                                                textEditingController:
                                                bathroomOfProductController,
                                                textInputType: TextInputType.number,
                                                validator: (val) {
                                                  // if (val.isEmpty) {
                                                  //   return LocaleKeys.mustNotEmpty.tr();
                                                  // }
                                                },
                                              ),
                                              15.heightBox,
                                              InputTextFormField(
                                                hintText: LocaleKeys.area.tr(),
                                                textEditingController: areaPropertiesController,
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
                                              CustomButtonWidget(
                                                  title: widget.levelType != null ?
                                                  widget.levelType! :
                                                  LocaleKeys.level.tr(),
                                                  onTap: () {
                                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
                                                        ChooseLevelAddProductScreen(
                                                          governmentId: widget
                                                              .governmentId,
                                                          governmentName: widget
                                                              .governmentName,
                                                          cityId: widget.cityId,
                                                          whatsAppNumber: whatsAppController.text,
                                                          year: yearOfProductController.text,
                                                          downPayment: downPaymentController.text,
                                                          area: areaPropertiesController.text,
                                                          bathroom: bathroomOfProductController.text,
                                                          bedroom: bedroomOfProductController.text,
                                                          cityName: widget.cityName,
                                                          areaId: widget.areaId,
                                                          data: '',
                                                          areaName: widget.areaName,
                                                          toPrice: newPriceController
                                                              .text,
                                                          fromPrice: oldPriceController
                                                              .text,
                                                          levelType: widget.levelType,
                                                          kiloMetresType: kiloMetresOfProductController.text,
                                                          amenitiesType: widget.amenitiesType,
                                                          fuelType: widget.fuelType,
                                                          engineCapacityType: widget.engineCapacityType,
                                                          colorType: widget.colorType,
                                                          bodyType: widget.bodyType,
                                                          nameProduct: nameOfProductController
                                                              .text,
                                                          description: descriptionController
                                                              .text,
                                                          locationUser: locationUserController.text,
                                                        )));
                                                  }),
                                              15.heightBox,
                                              Row(
                                                children: [
                                                  Text(LocaleKeys.furnished.tr(),
                                                    style: const TextStyle(
                                                        color: AppPalette.black,
                                                        fontWeight: FontWeight.w500),),
                                                ],
                                              ),
                                              10.heightBox,
                                              Row(
                                                children: [
                                                  ConditionWidget(
                                                    title: LocaleKeys.yes.tr(),
                                                    color: addProductController.isVisibleFurnishedProperties
                                                        ? AppPalette.primary
                                                        : AppPalette.lightPrimary,
                                                    // onTap: filterCubit
                                                    //     .changeWarranty(),
                                                    textColor: addProductController.isVisibleFurnishedProperties
                                                        ? AppPalette.white
                                                        : AppPalette.black,
                                                    onTap: () {
                                                      setState(() {
                                                        addProductController.isVisibleFurnishedProperties = !addProductController.isVisibleFurnishedProperties;
                                                        addProductController.isVisibleNotFurnishedProperties = false;
                                                      });
                                                    },
                                                  ),
                                                  8.widthBox,
                                                  ConditionWidget(
                                                    title: LocaleKeys.no.tr(),
                                                    color: addProductController.isVisibleNotFurnishedProperties
                                                        ? AppPalette.primary
                                                        : AppPalette.lightPrimary,
                                                    // onTap: filterCubit
                                                    //     .changeWarranty(),
                                                    textColor: addProductController.isVisibleNotFurnishedProperties
                                                        ? AppPalette.white
                                                        : AppPalette.black,
                                                    onTap: () {
                                                      setState(() {
                                                        addProductController.isVisibleNotFurnishedProperties = !addProductController.isVisibleNotFurnishedProperties;
                                                        addProductController.isVisibleFurnishedProperties = false;
                                                      });
                                                    },
                                                  ),
                                                ],
                                              ),
                                              15.heightBox
                                            ],
                                          )
                                              : Container() : Container(),
                                          ////// Home Furniture Category
                                          addProductController.selectedMainCat != null ?
                                          addProductController.selectedMainCat!.name!.en!
                                              .contains('Home Furniture') ?
                                          Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Text(LocaleKeys.type.tr(),
                                                    style: const TextStyle(
                                                        color: AppPalette.black,
                                                        fontWeight: FontWeight.w500),),
                                                ],
                                              ),
                                              10.heightBox,
                                              Row(
                                                children: [
                                                  Expanded(
                                                    flex: 1,
                                                    child: ConditionWidget(
                                                      title: LocaleKeys.fullBathroom.tr(),
                                                      color: addProductController.isVisibleBedroom
                                                          ? AppPalette.primary
                                                          : AppPalette.lightPrimary,
                                                      // onTap: filterCubit
                                                      //     .changeWarranty(),
                                                      textColor: addProductController.isVisibleBedroom
                                                          ? AppPalette.white
                                                          : AppPalette.black, onTap: () {
                                                      setState(() {
                                                        addProductController.isVisibleBedroom = !addProductController.isVisibleBedroom;
                                                        addProductController.isVisibleSink = false;
                                                        addProductController.isVisibleToilet = false;
                                                        addProductController.isVisibleShower = false;
                                                        addProductController.isVisibleTowels = false;
                                                        addProductController.isVisibleWaterMix = false;
                                                        addProductController.isVisibleMirrors = false;

                                                      });
                                                    },
                                                    ),
                                                  ),
                                                  5.widthBox,
                                                  Expanded(
                                                    flex: 1,
                                                    child: ConditionWidget(
                                                      title: LocaleKeys.sink.tr(),
                                                      color: addProductController.isVisibleSink
                                                          ? AppPalette.primary
                                                          : AppPalette.lightPrimary,
                                                      // onTap: filterCubit
                                                      //     .changeWarranty(),
                                                      textColor: addProductController.isVisibleSink
                                                          ? AppPalette.white
                                                          : AppPalette.black, onTap: () {
                                                      setState(() {
                                                        addProductController.isVisibleBedroom = false;
                                                        addProductController.isVisibleSink = !addProductController.isVisibleSink;
                                                        addProductController.isVisibleToilet = false;
                                                        addProductController.isVisibleShower = false;
                                                        addProductController.isVisibleTowels = false;
                                                        addProductController.isVisibleWaterMix = false;
                                                        addProductController.isVisibleMirrors = false;

                                                      });
                                                    },
                                                    ),
                                                  ),
                                                  5.widthBox,
                                                  Expanded(child: ConditionWidget(
                                                    title: LocaleKeys.towels.tr(),
                                                    color: addProductController.isVisibleTowels
                                                        ? AppPalette.primary
                                                        : AppPalette.lightPrimary,
                                                    // onTap: filterCubit
                                                    //     .changeWarranty(),
                                                    textColor: addProductController.isVisibleTowels
                                                        ? AppPalette.white
                                                        : AppPalette.black, onTap: () {
                                                    setState(() {
                                                      addProductController.isVisibleBedroom = false;
                                                      addProductController.isVisibleSink = false;
                                                      addProductController.isVisibleToilet = false;
                                                      addProductController.isVisibleShower = false;
                                                      addProductController.isVisibleTowels = !addProductController.isVisibleTowels;
                                                      addProductController.isVisibleWaterMix = false;
                                                      addProductController.isVisibleMirrors = false;

                                                    });
                                                  },
                                                  ),)
                                                ],
                                              ),
                                              10.heightBox,
                                              Row(
                                                children: [
                                                  ConditionWidget(
                                                    title: LocaleKeys.showerRoomTub.tr(),
                                                    color: addProductController.isVisibleShower
                                                        ? AppPalette.primary
                                                        : AppPalette.lightPrimary,
                                                    // onTap: filterCubit
                                                    //     .changeWarranty(),
                                                    textColor: addProductController.isVisibleShower
                                                        ? AppPalette.white
                                                        : AppPalette.black, onTap: () {
                                                    setState(() {
                                                      addProductController.isVisibleBedroom = false;
                                                      addProductController.isVisibleSink = false;
                                                      addProductController.isVisibleToilet = false;
                                                      addProductController.isVisibleShower = !addProductController.isVisibleShower;
                                                      addProductController.isVisibleTowels = false;
                                                      addProductController.isVisibleWaterMix = false;
                                                      addProductController.isVisibleMirrors = false;

                                                    });
                                                  },
                                                  ),
                                                  5.widthBox,
                                                  ConditionWidget(
                                                    title: LocaleKeys.toilet.tr(),
                                                    color: addProductController.isVisibleToilet
                                                        ? AppPalette.primary
                                                        : AppPalette.lightPrimary,
                                                    // onTap: filterCubit
                                                    //     .changeWarranty(),
                                                    textColor: addProductController.isVisibleToilet
                                                        ? AppPalette.white
                                                        : AppPalette.black, onTap: () {
                                                    setState(() {
                                                      addProductController.isVisibleBedroom = false;
                                                      addProductController.isVisibleSink = false;
                                                      addProductController.isVisibleToilet = !addProductController.isVisibleToilet;
                                                      addProductController.isVisibleShower = false;
                                                      addProductController.isVisibleTowels = false;
                                                      addProductController.isVisibleWaterMix = false;
                                                      addProductController.isVisibleMirrors = false;

                                                    });
                                                  },
                                                  ),
                                                ],
                                              ),
                                              10.heightBox,
                                              Row(
                                                children: [
                                                  ConditionWidget(
                                                    title: LocaleKeys.waterMixersShowerHeads.tr(),
                                                    color: addProductController.isVisibleWaterMix
                                                        ? AppPalette.primary
                                                        : AppPalette.lightPrimary,
                                                    // onTap: filterCubit
                                                    //     .changeWarranty(),
                                                    textColor: addProductController.isVisibleWaterMix
                                                        ? AppPalette.white
                                                        : AppPalette.black, onTap: () {
                                                    setState(() {
                                                      addProductController.isVisibleBedroom = false;
                                                      addProductController.isVisibleSink = false;
                                                      addProductController.isVisibleToilet = false;
                                                      addProductController.isVisibleShower = false;
                                                      addProductController.isVisibleTowels = false;
                                                      addProductController.isVisibleWaterMix = !addProductController.isVisibleWaterMix;
                                                      addProductController.isVisibleMirrors = false;

                                                    });
                                                  },
                                                  ),
                                                ],
                                              ),
                                              10.heightBox,
                                              Row(
                                                children: [
                                                  ConditionWidget(
                                                    title: LocaleKeys.mirrorsShelvesOtherAccessories.tr(),
                                                    color: addProductController.isVisibleMirrors
                                                        ? AppPalette.primary
                                                        : AppPalette.lightPrimary,
                                                    // onTap: filterCubit
                                                    //     .changeWarranty(),
                                                    textColor: addProductController.isVisibleMirrors
                                                        ? AppPalette.white
                                                        : AppPalette.black, onTap: () {
                                                    setState(() {
                                                      addProductController.isVisibleBedroom = false;
                                                      addProductController.isVisibleSink = false;
                                                      addProductController.isVisibleToilet = false;
                                                      addProductController.isVisibleShower = false;
                                                      addProductController.isVisibleTowels = false;
                                                      addProductController.isVisibleWaterMix = false;
                                                      addProductController.isVisibleMirrors = !addProductController.isVisibleMirrors;

                                                    });
                                                  },
                                                  ),
                                                ],
                                              ),
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
                                              Row(
                                                children: [
                                                  ConditionWidget(
                                                    title: LocaleKeys.newProd.tr(),
                                                    color: addProductController.condition ==
                                                        Condition.newProduct
                                                        ? AppPalette.primary
                                                        : AppPalette.lightPrimary,
                                                    onTap: addProductController
                                                        .changeCondition,
                                                    textColor: addProductController
                                                        .condition ==
                                                        Condition.newProduct
                                                        ? AppPalette.white
                                                        : AppPalette.black,
                                                  ),
                                                  8.widthBox,
                                                  ConditionWidget(
                                                    title: LocaleKeys.used.tr(),
                                                    color: addProductController.condition ==
                                                        Condition.used
                                                        ? AppPalette.primary
                                                        : AppPalette.lightPrimary,
                                                    onTap: addProductController
                                                        .changeCondition,
                                                    textColor: addProductController
                                                        .condition ==
                                                        Condition.used
                                                        ? AppPalette.white
                                                        : AppPalette.black,
                                                  ),
                                                ],
                                              ),
                                              10.heightBox,
                                            ],
                                          ) : Container() : Container(),
                                          ////// Home Fashion Category
                                          addProductController.selectedMainCat != null ?
                                          addProductController.selectedMainCat!.name!.en!
                                              .contains('Fashion') ?
                                          Column(
                                            children: [
                                              // CustomButtonWidget(
                                              //     title: addProductController.selectedBrand ==
                                              //         null ? LocaleKeys.brand.tr() :
                                              //     context.locale.languageCode.contains('en')
                                              //         ? addProductController.selectedBrand!
                                              //         .brandName != null ?
                                              //     '${addProductController.selectedBrand!
                                              //         .brandName?.en!}' : LocaleKeys.category
                                              //         .tr()
                                              //         : context.locale.languageCode.contains(
                                              //         'ar')
                                              //         ? addProductController.selectedBrand!
                                              //         .brandName != null ?
                                              //     '${addProductController.selectedBrand!
                                              //         .brandName?.ar!}' : LocaleKeys.category
                                              //         .tr()
                                              //         : context.locale.languageCode.contains(
                                              //         'tr')
                                              //         ? addProductController.selectedBrand!
                                              //         .brandName != null ?
                                              //     '${addProductController.selectedBrand!
                                              //         .brandName?.tr!}' : LocaleKeys.category
                                              //         .tr()
                                              //         : context.locale.languageCode.contains(
                                              //         'de')
                                              //         ? addProductController.selectedBrand!
                                              //         .brandName != null ?
                                              //     '${addProductController.selectedBrand!
                                              //         .brandName?.de!}' : LocaleKeys.category
                                              //         .tr()
                                              //         : ' ',
                                              //     onTap: () =>
                                              //     addProductController.selectedMainCat?.id !=
                                              //         null ?
                                              //     Navigator.of(context).push(
                                              //         MaterialPageRoute(
                                              //           builder: (context) =>
                                              //               ChooseOneBrandScreen(
                                              //                   governmentId: widget
                                              //                       .governmentId,
                                              //                   governmentName: widget
                                              //                       .governmentName,
                                              //                   cityId: widget.cityId,
                                              //                   whatsAppNumber: whatsAppController.text,
                                              //                   description: descriptionController
                                              //                       .text,
                                              //                   cityName: widget.cityName,
                                              //                   areaId: widget.areaId,
                                              //                   areaName: widget.areaName,
                                              //                   fromPrice: oldPriceController
                                              //                       .text,
                                              //                   toPrice: newPriceController
                                              //                       .text,
                                              //                   locationUser: '',
                                              //                   nameProduct: nameOfProductController
                                              //                       .text,
                                              //                   data: 'AddProduct'),
                                              //         )) : customFlutterToast(
                                              //         'Please select main category first')
                                              // ),
                                              // 15.heightBox,
                                              Row(
                                                children: [
                                                  Text(LocaleKeys.type.tr(),
                                                    style: const TextStyle(
                                                        color: AppPalette.black,
                                                        fontWeight: FontWeight.w500),),
                                                ],
                                              ),
                                              10.heightBox,

                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: ConditionWidget(
                                                      title: LocaleKeys.nightwear.tr(),
                                                      color: addProductController.isVisibleNightwear
                                                          ? AppPalette.primary
                                                          : AppPalette.lightPrimary,
                                                      // onTap: filterCubit
                                                      //     .changeWarranty(),
                                                      textColor: addProductController.isVisibleNightwear
                                                          ? AppPalette.white
                                                          : AppPalette.black,
                                                      onTap: () {
                                                        setState(() {
                                                          addProductController.isVisibleNightwear = !addProductController.isVisibleNightwear;
                                                          addProductController.isVisibleSwimwear = false;
                                                          addProductController.isVisibleDresses = false;
                                                          addProductController.isVisibleWeddingApparel = false;
                                                          addProductController.isVisibleBlouseTShairt = false;
                                                          addProductController.isVisiblePulloverCoatsJackets = false;
                                                          addProductController.isVisibleTrousers = false;
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                  5.widthBox,
                                                  Expanded(
                                                    child: ConditionWidget(
                                                      title: LocaleKeys.weddingApparel.tr(),
                                                      color: addProductController.isVisibleWeddingApparel
                                                          ? AppPalette.primary
                                                          : AppPalette.lightPrimary,
                                                      // onTap: filterCubit
                                                      //     .changeWarranty(),
                                                      textColor: addProductController.isVisibleWeddingApparel
                                                          ? AppPalette.white
                                                          : AppPalette.black, onTap: () {
                                                      setState(() {
                                                        addProductController.isVisibleNightwear = false;
                                                        addProductController.isVisibleSwimwear = false;
                                                        addProductController.isVisibleDresses = false;
                                                        addProductController.isVisibleWeddingApparel = !addProductController.isVisibleWeddingApparel;
                                                        addProductController.isVisibleBlouseTShairt = false;
                                                        addProductController.isVisiblePulloverCoatsJackets = false;
                                                        addProductController.isVisibleTrousers = false;
                                                      });
                                                    },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              10.heightBox,
                                              Row(
                                                children: [
                                                  Expanded(
                                                    flex: 2,
                                                    child: ConditionWidget(
                                                      title: LocaleKeys.blouseTshirtsTops.tr(),
                                                      color: addProductController.isVisibleBlouseTShairt
                                                          ? AppPalette.primary
                                                          : AppPalette.lightPrimary,
                                                      // onTap: filterCubit
                                                      //     .changeWarranty(),
                                                      textColor: addProductController.isVisibleBlouseTShairt
                                                          ? AppPalette.white
                                                          : AppPalette.black, onTap: () {
                                                      setState(() {
                                                        addProductController.isVisibleNightwear = false;
                                                        addProductController.isVisibleSwimwear = false;
                                                        addProductController.isVisibleDresses = false;
                                                        addProductController.isVisibleWeddingApparel = false;
                                                        addProductController.isVisibleBlouseTShairt = !addProductController.isVisibleBlouseTShairt;
                                                        addProductController.isVisiblePulloverCoatsJackets = false;
                                                        addProductController.isVisibleTrousers = false;
                                                      });
                                                    },
                                                    ),
                                                  ),
                                                  5.widthBox,
                                                  Expanded(
                                                    flex: 1,
                                                    child: ConditionWidget(
                                                      title: LocaleKeys.swimwear.tr(),
                                                      color: addProductController.isVisibleSwimwear
                                                          ? AppPalette.primary
                                                          : AppPalette.lightPrimary,
                                                      // onTap: filterCubit
                                                      //     .changeWarranty(),
                                                      textColor: addProductController.isVisibleSwimwear
                                                          ? AppPalette.white
                                                          : AppPalette.black, onTap: () {
                                                      setState(() {
                                                        addProductController.isVisibleNightwear = false;
                                                        addProductController.isVisibleSwimwear = !addProductController.isVisibleSwimwear;
                                                        addProductController.isVisibleDresses = false;
                                                        addProductController.isVisibleWeddingApparel = false;
                                                        addProductController.isVisibleBlouseTShairt = false;
                                                        addProductController.isVisiblePulloverCoatsJackets = false;
                                                        addProductController.isVisibleTrousers = false;
                                                      });
                                                    },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              10.heightBox,
                                              Row(
                                                children: [
                                                  Expanded(
                                                    flex: 2,
                                                    child: ConditionWidget(
                                                      title: LocaleKeys.pulloverCoatsJackets.tr(),
                                                      color: addProductController.isVisiblePulloverCoatsJackets
                                                          ? AppPalette.primary
                                                          : AppPalette.lightPrimary,
                                                      // onTap: filterCubit
                                                      //     .changeWarranty(),
                                                      textColor: addProductController.isVisiblePulloverCoatsJackets
                                                          ? AppPalette.white
                                                          : AppPalette.black, onTap: () {
                                                      setState(() {
                                                        addProductController.isVisibleNightwear = false;
                                                        addProductController.isVisibleSwimwear = false;
                                                        addProductController.isVisibleDresses = false;
                                                        addProductController.isVisibleWeddingApparel = false;
                                                        addProductController.isVisibleBlouseTShairt = false;
                                                        addProductController.isVisiblePulloverCoatsJackets = !addProductController.isVisiblePulloverCoatsJackets;
                                                        addProductController.isVisibleTrousers = false;
                                                      });
                                                    },
                                                    ),
                                                  ),
                                                  5.widthBox,
                                                  Expanded(
                                                    flex: 1,
                                                    child: ConditionWidget(
                                                      title: LocaleKeys.dresses.tr(),
                                                      color: addProductController.isVisibleDresses
                                                          ? AppPalette.primary
                                                          : AppPalette.lightPrimary,
                                                      // onTap: filterCubit
                                                      //     .changeWarranty(),
                                                      textColor: addProductController.isVisibleDresses
                                                          ? AppPalette.white
                                                          : AppPalette.black, onTap: () {
                                                      setState(() {
                                                        addProductController.isVisibleNightwear = false;
                                                        addProductController.isVisibleSwimwear = false;
                                                        addProductController.isVisibleDresses = !addProductController.isVisibleDresses;
                                                        addProductController.isVisibleWeddingApparel = false;
                                                        addProductController.isVisibleBlouseTShairt = false;
                                                        addProductController.isVisiblePulloverCoatsJackets = false;
                                                        addProductController.isVisibleTrousers = false;
                                                      });
                                                    },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              10.heightBox,
                                              Row(
                                                children: [
                                                  ConditionWidget(
                                                    title: LocaleKeys.trousersLeggingsJeans.tr(),
                                                    color: addProductController.isVisibleTrousers
                                                        ? AppPalette.primary
                                                        : AppPalette.lightPrimary,
                                                    // onTap: filterCubit
                                                    //     .changeWarranty(),
                                                    textColor: addProductController.isVisibleTrousers
                                                        ? AppPalette.white
                                                        : AppPalette.black, onTap: () {
                                                    setState(() {
                                                      addProductController.isVisibleNightwear = false;
                                                      addProductController.isVisibleSwimwear = false;
                                                      addProductController.isVisibleDresses = false;
                                                      addProductController.isVisibleWeddingApparel = false;
                                                      addProductController.isVisibleBlouseTShairt = false;
                                                      addProductController.isVisiblePulloverCoatsJackets = false;
                                                      addProductController.isVisibleTrousers = !addProductController.isVisibleTrousers;
                                                    });
                                                  },
                                                  ),
                                                ],
                                              ),
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
                                              Row(
                                                children: [
                                                  ConditionWidget(
                                                    title: LocaleKeys.newProd.tr(),
                                                    color: addProductController.condition ==
                                                        Condition.newProduct
                                                        ? AppPalette.primary
                                                        : AppPalette.lightPrimary,
                                                    onTap: addProductController
                                                        .changeCondition,
                                                    textColor: addProductController
                                                        .condition ==
                                                        Condition.newProduct
                                                        ? AppPalette.white
                                                        : AppPalette.black,
                                                  ),
                                                  8.widthBox,
                                                  ConditionWidget(
                                                    title: LocaleKeys.used.tr(),
                                                    color: addProductController.condition ==
                                                        Condition.used
                                                        ? AppPalette.primary
                                                        : AppPalette.lightPrimary,
                                                    onTap: addProductController
                                                        .changeCondition,
                                                    textColor: addProductController
                                                        .condition ==
                                                        Condition.used
                                                        ? AppPalette.white
                                                        : AppPalette.black,
                                                  ),
                                                ],
                                              ),
                                              10.heightBox,
                                            ],
                                          ) : Container() : Container(),
                                          ////// Kids & Babies Category
                                          addProductController.selectedMainCat != null ?
                                          addProductController.selectedMainCat!.name!.en!
                                              .contains('Kids & Babies') ?
                                          Column(
                                            children: [
                                              15.heightBox,
                                              Row(
                                                children: [
                                                  Text(LocaleKeys.type.tr(),
                                                    style: const TextStyle(
                                                        color: AppPalette.black,
                                                        fontWeight: FontWeight.w500),),
                                                ],
                                              ),
                                              10.heightBox,
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Expanded(
                                                    flex: 1,
                                                    child: ConditionWidget(
                                                      title: LocaleKeys.bathTub.tr(),
                                                      color: addProductController.isVisibleBathTub
                                                          ? AppPalette.primary
                                                          : AppPalette.lightPrimary,
                                                      // onTap: filterCubit
                                                      //     .changeWarranty(),
                                                      textColor: addProductController.isVisibleBathTub
                                                          ? AppPalette.white
                                                          : AppPalette.black, onTap: () {
                                                      setState(() {
                                                        addProductController.isVisibleBathTub = !addProductController.isVisibleBathTub;
                                                        addProductController.isVisibleDiaper = false;
                                                        addProductController.isVisibleShampoo = false;
                                                        addProductController.isVisibleSkincare = false;
                                                        addProductController.isVisibleSilicone = false;
                                                        addProductController.isVisibleSterilizerTools = false;
                                                        addProductController.isVisibleToiletKids = false;
                                                        addProductController.isVisibleOtherKids = false;
                                                      });
                                                    },
                                                    ),
                                                  ),
                                                  5.widthBox,
                                                  Expanded(
                                                    flex: 1,
                                                    child: ConditionWidget(
                                                      title: LocaleKeys.diaper.tr(),
                                                      color: addProductController.isVisibleDiaper
                                                          ? AppPalette.primary
                                                          : AppPalette.lightPrimary,
                                                      // onTap: filterCubit
                                                      //     .changeWarranty(),
                                                      textColor: addProductController.isVisibleDiaper
                                                          ? AppPalette.white
                                                          : AppPalette.black, onTap: () {
                                                      setState(() {
                                                        addProductController.isVisibleBathTub = false;
                                                        addProductController.isVisibleDiaper = !addProductController.isVisibleDiaper;
                                                        addProductController.isVisibleShampoo = false;
                                                        addProductController.isVisibleSkincare = false;
                                                        addProductController.isVisibleSilicone = false;
                                                        addProductController.isVisibleSterilizerTools = false;
                                                        addProductController.isVisibleToiletKids = false;
                                                        addProductController.isVisibleOtherKids = false;
                                                      });
                                                    },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              10.heightBox,
                                              Row(
                                                children: [
                                                  Expanded(
                                                    flex: 1,
                                                    child: ConditionWidget(
                                                      title: LocaleKeys.sterilizerTools.tr(),
                                                      color: addProductController.isVisibleSterilizerTools
                                                          ? AppPalette.primary
                                                          : AppPalette.lightPrimary,
                                                      // onTap: filterCubit
                                                      //     .changeWarranty(),
                                                      textColor: addProductController.isVisibleSterilizerTools
                                                          ? AppPalette.white
                                                          : AppPalette.black, onTap: () {
                                                      setState(() {
                                                        addProductController.isVisibleBathTub = false;
                                                        addProductController.isVisibleDiaper = false;
                                                        addProductController.isVisibleShampoo = false;
                                                        addProductController.isVisibleSkincare = false;
                                                        addProductController.isVisibleSilicone = false;
                                                        addProductController.isVisibleSterilizerTools = !addProductController.isVisibleSterilizerTools;
                                                        addProductController.isVisibleToiletKids = false;
                                                        addProductController.isVisibleOtherKids = false;
                                                      });
                                                    },
                                                    ),
                                                  ),
                                                  5.widthBox,
                                                  Expanded(
                                                    flex: 1,
                                                    child: ConditionWidget(
                                                      title: LocaleKeys.skincare.tr(),
                                                      color: addProductController.isVisibleSkincare
                                                          ? AppPalette.primary
                                                          : AppPalette.lightPrimary,
                                                      // onTap: filterCubit
                                                      //     .changeWarranty(),
                                                      textColor: addProductController.isVisibleSkincare?
                                                      AppPalette.white
                                                          : AppPalette.black, onTap: () {
                                                      setState(() {
                                                        addProductController.isVisibleBathTub = false;
                                                        addProductController.isVisibleDiaper = false;
                                                        addProductController.isVisibleShampoo = false;
                                                        addProductController.isVisibleSkincare = !addProductController.isVisibleSkincare;
                                                        addProductController.isVisibleSilicone = false;
                                                        addProductController.isVisibleSterilizerTools = false;
                                                        addProductController.isVisibleToiletKids = false;
                                                        addProductController.isVisibleOtherKids = false;
                                                      });
                                                    },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              10.heightBox,
                                              Row(
                                                children: [
                                                  Expanded(
                                                    flex: 1,
                                                    child: ConditionWidget(
                                                      title: LocaleKeys.toiletTrainingSeat.tr(),
                                                      color: addProductController.isVisibleToiletKids
                                                          ? AppPalette.primary
                                                          : AppPalette.lightPrimary,
                                                      // onTap: filterCubit
                                                      //     .changeWarranty(),
                                                      textColor: addProductController.isVisibleToiletKids
                                                          ? AppPalette.white
                                                          : AppPalette.black, onTap: () {
                                                      setState(() {
                                                        addProductController.isVisibleBathTub = false;
                                                        addProductController.isVisibleDiaper = false;
                                                        addProductController.isVisibleShampoo = false;
                                                        addProductController.isVisibleSkincare = false;
                                                        addProductController.isVisibleSilicone = false;
                                                        addProductController.isVisibleSterilizerTools = false;
                                                        addProductController.isVisibleToiletKids = !addProductController.isVisibleToiletKids;
                                                        addProductController.isVisibleOtherKids = false;
                                                      });
                                                    },
                                                    ),),
                                                  5.widthBox,
                                                  Expanded(
                                                    flex: 1,
                                                    child: ConditionWidget(
                                                      title: LocaleKeys.shampooSoaps.tr(),
                                                      color: addProductController.isVisibleShampoo
                                                          ? AppPalette.primary
                                                          : AppPalette.lightPrimary,
                                                      // onTap: filterCubit
                                                      //     .changeWarranty(),
                                                      textColor: addProductController.isVisibleShampoo
                                                          ? AppPalette.white
                                                          : AppPalette.black, onTap: () {
                                                      setState(() {
                                                        addProductController.isVisibleBathTub = false;
                                                        addProductController.isVisibleDiaper = false;
                                                        addProductController.isVisibleShampoo = !addProductController.isVisibleShampoo;
                                                        addProductController.isVisibleSkincare = false;
                                                        addProductController.isVisibleSilicone = false;
                                                        addProductController.isVisibleSterilizerTools = false;
                                                        addProductController.isVisibleToiletKids = false;
                                                        addProductController.isVisibleOtherKids = false;
                                                      });
                                                    },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              10.heightBox,
                                              Row(
                                                children: [
                                                  Expanded(
                                                    flex: 2,
                                                    child: ConditionWidget(
                                                      title: LocaleKeys.siliconeNippleProtectors.tr(),
                                                      color: addProductController.isVisibleSilicone
                                                          ? AppPalette.primary
                                                          : AppPalette.lightPrimary,
                                                      // onTap: filterCubit
                                                      //     .changeWarranty(),
                                                      textColor: addProductController.isVisibleSilicone
                                                          ? AppPalette.white
                                                          : AppPalette.black, onTap: () {
                                                      setState(() {
                                                        addProductController.isVisibleBathTub = false;
                                                        addProductController.isVisibleDiaper = false;
                                                        addProductController.isVisibleShampoo = false;
                                                        addProductController.isVisibleSkincare = false;
                                                        addProductController.isVisibleSilicone = !addProductController.isVisibleSilicone;
                                                        addProductController.isVisibleSterilizerTools = false;
                                                        addProductController.isVisibleToiletKids = false;
                                                        addProductController.isVisibleOtherKids = false;
                                                      });
                                                    },
                                                    ),
                                                  ),
                                                  5.widthBox,
                                                  Expanded(
                                                    child: ConditionWidget(
                                                      title: LocaleKeys.other.tr(),
                                                      color: addProductController.isVisibleOtherKids
                                                          ? AppPalette.primary
                                                          : AppPalette.lightPrimary,
                                                      // onTap: filterCubit
                                                      //     .changeWarranty(),
                                                      textColor: addProductController.isVisibleOtherKids
                                                          ? AppPalette.white
                                                          : AppPalette.black, onTap: () {
                                                      setState(() {
                                                        addProductController.isVisibleBathTub = false;
                                                        addProductController.isVisibleDiaper = false;
                                                        addProductController.isVisibleShampoo = false;
                                                        addProductController.isVisibleSkincare = false;
                                                        addProductController.isVisibleSilicone = false;
                                                        addProductController.isVisibleSterilizerTools = false;
                                                        addProductController.isVisibleToiletKids = false;
                                                        addProductController.isVisibleOtherKids = !addProductController.isVisibleOtherKids;
                                                      });
                                                    },
                                                    ),
                                                  ),
                                                ],
                                              ),
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
                                              Row(
                                                children: [
                                                  ConditionWidget(
                                                    title: LocaleKeys.newProd.tr(),
                                                    color: addProductController.condition ==
                                                        Condition.newProduct
                                                        ? AppPalette.primary
                                                        : AppPalette.lightPrimary,
                                                    onTap: addProductController
                                                        .changeCondition,
                                                    textColor: addProductController
                                                        .condition ==
                                                        Condition.newProduct
                                                        ? AppPalette.white
                                                        : AppPalette.black,
                                                  ),
                                                  8.widthBox,
                                                  ConditionWidget(
                                                    title: LocaleKeys.used.tr(),
                                                    color: addProductController.condition ==
                                                        Condition.used
                                                        ? AppPalette.primary
                                                        : AppPalette.lightPrimary,
                                                    onTap: addProductController
                                                        .changeCondition,
                                                    textColor: addProductController
                                                        .condition ==
                                                        Condition.used
                                                        ? AppPalette.white
                                                        : AppPalette.black,
                                                  ),
                                                ],
                                              ),
                                              10.heightBox,

                                            ],
                                          ) : Container() : Container(),
                                          ////// Books, Sports & Hobbies Category
                                          addProductController.selectedMainCat != null ?
                                          addProductController.selectedMainCat!.name!.en!
                                              .contains('Books, Sports & Hobbies') ?
                                          Column(
                                            children: [
                                              15.heightBox,
                                              Row(
                                                children: [
                                                  Text(LocaleKeys.type.tr(),
                                                    style: const TextStyle(
                                                        color: AppPalette.black,
                                                        fontWeight: FontWeight.w500),),
                                                ],
                                              ),
                                              10.heightBox,
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: ConditionWidget(
                                                      title: LocaleKeys.antiques.tr(),
                                                      color: addProductController.isVisibleAntiques
                                                          ? AppPalette.primary
                                                          : AppPalette.lightPrimary,
                                                      // onTap: filterCubit
                                                      //     .changeWarranty(),
                                                      textColor: addProductController.isVisibleAntiques
                                                          ? AppPalette.white
                                                          : AppPalette.black, onTap: () {
                                                      setState(() {
                                                        addProductController.isVisibleAntiques = !addProductController.isVisibleAntiques;
                                                        addProductController.isVisibleArt = false;
                                                        addProductController.isVisibleCollectibles = false;
                                                        addProductController.isVisibleOldCurrencies = false;
                                                        addProductController.isVisiblePens = false;
                                                        addProductController.isVisibleOther = false;
                                                      });
                                                    },
                                                    ),
                                                  ),
                                                  5.widthBox,
                                                  Expanded(
                                                    child: ConditionWidget(
                                                      title: LocaleKeys.collectibles.tr(),
                                                      color: addProductController.isVisibleCollectibles
                                                          ? AppPalette.primary
                                                          : AppPalette.lightPrimary,
                                                      // onTap: filterCubit
                                                      //     .changeWarranty(),
                                                      textColor: addProductController.isVisibleCollectibles
                                                          ? AppPalette.white
                                                          : AppPalette.black, onTap: () {
                                                      setState(() {
                                                        addProductController.isVisibleAntiques = false;
                                                        addProductController.isVisibleArt = false;
                                                        addProductController.isVisibleCollectibles = !addProductController.isVisibleCollectibles;
                                                        addProductController.isVisibleOldCurrencies = false;
                                                        addProductController.isVisiblePens = false;
                                                        addProductController.isVisibleOther = false;
                                                      });
                                                    },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              10.heightBox,
                                              Row(
                                                children: [
                                                  Expanded(
                                                    flex: 2,
                                                    child: ConditionWidget(
                                                      title: LocaleKeys.pensWritingInstruments.tr(),
                                                      color: addProductController.isVisiblePens
                                                          ? AppPalette.primary
                                                          : AppPalette.lightPrimary,
                                                      // onTap: filterCubit
                                                      //     .changeWarranty(),
                                                      textColor: addProductController.isVisiblePens
                                                          ? AppPalette.white
                                                          : AppPalette.black, onTap: () {
                                                      setState(() {
                                                        addProductController.isVisibleAntiques = false;
                                                        addProductController.isVisibleArt = false;
                                                        addProductController.isVisibleCollectibles = false;
                                                        addProductController.isVisibleOldCurrencies = false;
                                                        addProductController.isVisiblePens = !addProductController.isVisiblePens;
                                                        addProductController.isVisibleOther = false;
                                                      });
                                                    },
                                                    ),
                                                  ),
                                                  5.widthBox,
                                                  Expanded(
                                                    child: ConditionWidget(
                                                      title: LocaleKeys.aRT.tr(),
                                                      color: addProductController.isVisibleArt
                                                          ? AppPalette.primary
                                                          : AppPalette.lightPrimary,
                                                      // onTap: filterCubit
                                                      //     .changeWarranty(),
                                                      textColor: addProductController.isVisibleArt
                                                          ? AppPalette.white
                                                          : AppPalette.black, onTap: () {
                                                      setState(() {
                                                        addProductController.isVisibleAntiques = false;
                                                        addProductController.isVisibleArt = !addProductController.isVisibleArt;
                                                        addProductController.isVisibleCollectibles = false;
                                                        addProductController.isVisibleOldCurrencies = false;
                                                        addProductController.isVisiblePens = false;
                                                        addProductController.isVisibleOther = false;
                                                      });
                                                    },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              10.heightBox,
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: ConditionWidget(
                                                      title: LocaleKeys.oldCurrencies.tr(),
                                                      color: addProductController.isVisibleOldCurrencies
                                                          ? AppPalette.primary
                                                          : AppPalette.lightPrimary,
                                                      // onTap: filterCubit
                                                      //     .changeWarranty(),
                                                      textColor: addProductController.isVisibleOldCurrencies
                                                          ? AppPalette.white
                                                          : AppPalette.black, onTap: () {
                                                      setState(() {
                                                        addProductController.isVisibleAntiques = false;
                                                        addProductController.isVisibleArt = false;
                                                        addProductController.isVisibleCollectibles = false;
                                                        addProductController.isVisibleOldCurrencies = !addProductController.isVisibleOldCurrencies;
                                                        addProductController.isVisiblePens = false;
                                                        addProductController.isVisibleOther = false;
                                                      });
                                                    },
                                                    ),
                                                  ),
                                                  5.widthBox,
                                                  Expanded(
                                                    child: ConditionWidget(
                                                      title: LocaleKeys.other.tr(),
                                                      color: addProductController.isVisibleOther
                                                          ? AppPalette.primary
                                                          : AppPalette.lightPrimary,
                                                      // onTap: filterCubit
                                                      //     .changeWarranty(),
                                                      textColor: addProductController.isVisibleOther
                                                          ? AppPalette.white
                                                          : AppPalette.black, onTap: () {
                                                      setState(() {
                                                        addProductController.isVisibleAntiques = false;
                                                        addProductController.isVisibleArt = false;
                                                        addProductController.isVisibleCollectibles = false;
                                                        addProductController.isVisibleOldCurrencies = false;
                                                        addProductController.isVisiblePens = false;
                                                        addProductController.isVisibleOther = !addProductController.isVisibleOther;
                                                      });
                                                    },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              10.heightBox,
                                            ],
                                          ) : Container() : Container(),
                                          ////// Business - Industrial - Agriculture Category
                                          addProductController.selectedMainCat != null ?
                                          addProductController.selectedMainCat!.name!.en!
                                              .contains('Business - Industrial - Agriculture') ?
                                          Column(
                                            children: [
                                              15.heightBox,
                                              Row(
                                                children: [
                                                  Text(LocaleKeys.type.tr(),
                                                    style: const TextStyle(
                                                        color: AppPalette.black,
                                                        fontWeight: FontWeight.w500),),
                                                ],
                                              ),
                                              10.heightBox,
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Expanded(
                                                    flex: 1,
                                                    child: ConditionWidget(
                                                      title: LocaleKeys.seeds.tr(),
                                                      color: addProductController.isVisibleSeeds
                                                          ? AppPalette.primary
                                                          : AppPalette.lightPrimary,
                                                      // onTap: filterCubit
                                                      //     .changeWarranty(),
                                                      textColor: addProductController.isVisibleSeeds
                                                          ? AppPalette.white
                                                          : AppPalette.black, onTap: () {
                                                      setState(() {
                                                        addProductController.isVisibleSeeds = !addProductController.isVisibleSeeds;
                                                        addProductController.isVisibleCrops = false;
                                                        addProductController.isVisibleFarmMachinery = false;
                                                        addProductController.isVisiblePesticides = false;
                                                        addProductController.isVisibleOtherBusiness = false;
                                                      });
                                                    },
                                                    ),
                                                  ),
                                                  5.widthBox,
                                                  Expanded(
                                                    flex: 2,
                                                    child: ConditionWidget(
                                                      title: LocaleKeys.crops.tr(),
                                                      color: addProductController.isVisibleCrops
                                                          ? AppPalette.primary
                                                          : AppPalette.lightPrimary,
                                                      // onTap: filterCubit
                                                      //     .changeWarranty(),
                                                      textColor: addProductController.isVisibleCrops
                                                          ? AppPalette.white
                                                          : AppPalette.black, onTap: () {
                                                      setState(() {
                                                        addProductController.isVisibleSeeds = false;
                                                        addProductController.isVisibleCrops = !addProductController.isVisibleCrops;
                                                        addProductController.isVisibleFarmMachinery = false;
                                                        addProductController.isVisiblePesticides = false;
                                                        addProductController.isVisibleOtherBusiness = false;
                                                      });
                                                    },
                                                    ),
                                                  ),
                                                  5.widthBox,
                                                  Expanded(
                                                    flex: 2 ,
                                                    child: ConditionWidget(
                                                      title: LocaleKeys.farmMachinery.tr(),
                                                      color: addProductController.isVisibleFarmMachinery
                                                          ? AppPalette.primary
                                                          : AppPalette.lightPrimary,
                                                      // onTap: filterCubit
                                                      //     .changeWarranty(),
                                                      textColor: addProductController.isVisibleFarmMachinery
                                                          ? AppPalette.white
                                                          : AppPalette.black, onTap: () {
                                                      setState(() {
                                                        addProductController.isVisibleSeeds = false;
                                                        addProductController.isVisibleCrops = false;
                                                        addProductController.isVisibleFarmMachinery = !addProductController.isVisibleFarmMachinery;
                                                        addProductController.isVisiblePesticides = false;
                                                        addProductController.isVisibleOtherBusiness = false;
                                                      });
                                                    },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              10.heightBox,
                                              Row(
                                                children: [
                                                  ConditionWidget(
                                                    title: LocaleKeys.pesticides.tr(),
                                                    color: addProductController.isVisiblePesticides
                                                        ? AppPalette.primary
                                                        : AppPalette.lightPrimary,
                                                    // onTap: filterCubit
                                                    //     .changeWarranty(),
                                                    textColor: addProductController.isVisiblePesticides
                                                        ? AppPalette.white
                                                        : AppPalette.black, onTap: () {
                                                    setState(() {
                                                      addProductController.isVisibleSeeds = false;
                                                      addProductController.isVisibleCrops = false;
                                                      addProductController.isVisibleFarmMachinery = false;
                                                      addProductController.isVisiblePesticides = !addProductController.isVisiblePesticides;
                                                      addProductController.isVisibleOtherBusiness = false;
                                                    });
                                                  },
                                                  ),
                                                  5.widthBox,
                                                  ConditionWidget(
                                                    title: LocaleKeys.other.tr(),
                                                    color: addProductController.isVisibleOtherBusiness
                                                        ? AppPalette.primary
                                                        : AppPalette.lightPrimary,
                                                    // onTap: filterCubit
                                                    //     .changeWarranty(),
                                                    textColor: addProductController.isVisibleOtherBusiness
                                                        ? AppPalette.white
                                                        : AppPalette.black, onTap: () {
                                                    setState(() {
                                                      addProductController.isVisibleSeeds = false;
                                                      addProductController.isVisibleCrops = false;
                                                      addProductController.isVisibleFarmMachinery = false;
                                                      addProductController.isVisiblePesticides = false;
                                                      addProductController.isVisibleOtherBusiness = !addProductController.isVisibleOtherBusiness;
                                                    });
                                                  },
                                                  ),
                                                ],
                                              ),
                                              10.heightBox,
                                            ],
                                          ) : Container() : Container(),
                                          ////// Vehicles Category
                                          addProductController.selectedMainCat != null ?
                                          addProductController.selectedMainCat!.name!.en!
                                              .contains('Vehicles') ?
                                          Column(
                                            children: [
                                              15.heightBox,
                                              CustomButtonWidget(
                                                  title: widget.fuelType == null ?
                                                  LocaleKeys.fuelType.tr() :
                                                  widget.fuelType!,
                                                  onTap: () {
                                                    // Navigator.push(context, MaterialPageRoute(
                                                    //     builder: (context) => ChooseFuelTypeAddProductScreen()));
                                                    Navigator.push(context,  MaterialPageRoute(
                                                        builder: (context) => ChooseFuelTypeAddProductScreen(
                                                          governmentId: widget
                                                              .governmentId,
                                                          governmentName: widget
                                                              .governmentName,
                                                          cityId: widget.cityId,
                                                          year: yearOfProductController.text,
                                                          downPayment: downPaymentController.text,
                                                          area: areaPropertiesController.text,
                                                          bathroom: bathroomOfProductController.text,
                                                          bedroom: bedroomOfProductController.text,
                                                          cityName: widget.cityName,
                                                          whatsAppNumber: whatsAppController.text,                                                    areaId: widget.areaId,
                                                          areaName: widget.areaName,
                                                          toPrice: newPriceController
                                                              .text,
                                                          fromPrice: oldPriceController
                                                              .text,
                                                          data: '',
                                                          levelType: widget.levelType,
                                                          kiloMetresType: kiloMetresOfProductController.text,
                                                          amenitiesType: widget.amenitiesType,
                                                          fuelType: widget.fuelType,
                                                          engineCapacityType: widget.engineCapacityType,
                                                          colorType: widget.colorType,
                                                          bodyType: widget.bodyType,
                                                          nameProduct: nameOfProductController
                                                              .text,
                                                          description: descriptionController
                                                              .text,
                                                          locationUser: locationUserController.text,
                                                        )));
                                                  }),
                                              15.heightBox,
                                              CustomButtonWidget(
                                                  title: addProductController.selectedBrand ==
                                                      null ? LocaleKeys.brand.tr() :
                                                  context.locale.languageCode.contains('en')
                                                      ? addProductController.selectedBrand!
                                                      .brandName != null ?
                                                  '${addProductController.selectedBrand!
                                                      .brandName?.en!}' : LocaleKeys.category
                                                      .tr()
                                                      : context.locale.languageCode.contains(
                                                      'ar')
                                                      ? addProductController.selectedBrand!
                                                      .brandName != null ?
                                                  '${addProductController.selectedBrand!
                                                      .brandName?.ar!}' : LocaleKeys.category
                                                      .tr()
                                                      : context.locale.languageCode.contains(
                                                      'tr')
                                                      ? addProductController.selectedBrand!
                                                      .brandName != null ?
                                                  '${addProductController.selectedBrand!
                                                      .brandName?.tr!}' : LocaleKeys.category
                                                      .tr()
                                                      : context.locale.languageCode.contains(
                                                      'de')
                                                      ? addProductController.selectedBrand!
                                                      .brandName != null ?
                                                  '${addProductController.selectedBrand!
                                                      .brandName?.de!}' : LocaleKeys.category
                                                      .tr()
                                                      : ' ',
                                                  onTap: () =>
                                                  addProductController.selectedMainCat?.id !=
                                                      null ?
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            ChooseOneBrandScreen(
                                                                governmentId: widget
                                                                    .governmentId,
                                                                governmentName: widget
                                                                    .governmentName,
                                                                cityId: widget.cityId,
                                                                fromYear: yearOfProductController.text,
                                                                fromDownPayment: downPaymentController.text,
                                                                fromArea: areaPropertiesController.text,
                                                                bathroom: bathroomOfProductController.text,
                                                                bedroom: bedroomOfProductController.text,
                                                                cityName: widget.cityName,
                                                                areaId: widget.areaId,
                                                                areaName: widget.areaName,
                                                                locationUser: locationUserController.text,
                                                                toPrice: newPriceController.text,
                                                                whatsAppNumber: whatsAppController.text,                                                          fromPrice: oldPriceController.text,
                                                                levelType: widget.levelType,
                                                                fromkiloMetresType: kiloMetresOfProductController.text,
                                                                amenitiesType: widget.amenitiesType,
                                                                fuelType: widget.fuelType,
                                                                engineCapacityType: widget.engineCapacityType,
                                                                colorType: widget.colorType,
                                                                bodyType: widget.bodyType,
                                                                nameProduct: nameOfProductController
                                                                    .text,
                                                                description: descriptionController
                                                                    .text,
                                                                data: 'AddProduct'),
                                                      )) : customFlutterToast(
                                                      'Please select main category first')
                                              ),
                                              if (addProductController.selectedBrand != null)
                                                15.heightBox,
                                              addProductState is GetOptionLoadingState ?
                                              const CircularProgressIndicator() :
                                              addProductState is GetOptionSuccessState ?
                                              addProductState.brandModelCarModel!.data!.isNotEmpty ?
                                              Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(LocaleKeys.modelName.tr(),
                                                        style: const TextStyle(
                                                            color: AppPalette.black,
                                                            fontWeight: FontWeight.w500),),
                                                    ],
                                                  ),
                                                  10.heightBox,
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(15),
                                                        border: Border.all(color: AppPalette.primary,width: 1)
                                                    ),
                                                    child: DropdownButton(
                                                      isExpanded: true,
                                                      onTap: () {
                                                        setState(() {
                                                          //  print(dropdownValueAddresses!.address);
                                                        });
                                                      },
                                                      value: addProductController.dropdownValueBrand,
                                                      icon: const Icon(Icons.arrow_drop_down),
                                                      iconSize: 24,
                                                      elevation: 16,
                                                      hint:  Center(
                                                        child:  Text(LocaleKeys.modelbrandName.tr(),
                                                          style: const TextStyle(
                                                              fontSize: 15,
                                                              color: AppPalette.black,
                                                              fontWeight: FontWeight.w500),),
                                                      ),
                                                      style: const TextStyle(
                                                          color: AppPalette.black,
                                                          fontSize: 18),
                                                      underline: Container(
                                                        height: 0,
                                                        color: Colors.deepPurpleAccent,
                                                      ),
                                                      onChanged: (String? data) {
                                                        setState(() {
                                                          addProductController.dropdownValueBrand = data;
                                                          // print("selected $data");
                                                          // print("selected ${addProductController.dropdownValueBrand}");


                                                        });
                                                      },
                                                      items: addProductState.brandModelCarModel!.data![0].optionsLabel!.map((item) {
                                                        return DropdownMenuItem<String>(
                                                            value: item,
                                                            child: SizedBox(
                                                              width: double.infinity,
                                                              child: Center(
                                                                child: Text(
                                                                    item,
                                                                    overflow: TextOverflow
                                                                        .ellipsis,
                                                                    maxLines: 1,
                                                                    style: const TextStyle(
                                                                        fontSize: 15,
                                                                        color: AppPalette.black,
                                                                        fontWeight: FontWeight.w500)
                                                                ),
                                                              ),
                                                            ));
                                                      }).toList(),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                ],
                                              ) : Container() :   Container(),
                                              15.heightBox,
                                              InputTextFormField(
                                                hintText: LocaleKeys.year.tr(),
                                                textEditingController:
                                                yearOfProductController,
                                                textInputType: TextInputType.number,
                                                validator: (val) {
                                                  // if (val.isEmpty) {
                                                  //   return LocaleKeys.mustNotEmpty.tr();
                                                  // }
                                                },
                                              ),
                                              15.heightBox,
                                              InputTextFormField(
                                                hintText: LocaleKeys.kilometers.tr(),
                                                textEditingController:
                                                kiloMetresOfProductController,
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
                                              Row(
                                                children: [
                                                  ConditionWidget(
                                                    title: LocaleKeys.manual.tr(),
                                                    color: addProductController
                                                        .isVisibleManual
                                                        ? AppPalette.primary
                                                        : AppPalette.lightPrimary,
                                                    // onTap: filterCubit
                                                    //     .changeWarranty(),
                                                    textColor: addProductController
                                                        .isVisibleManual
                                                        ? AppPalette.white
                                                        : AppPalette.black,
                                                    onTap:(){
                                                      setState(() {
                                                        addProductController.isVisibleManual = ! addProductController.isVisibleManual;
                                                        addProductController.isVisibleAutomatic = false;
                                                      });
                                                    },
                                                  ),
                                                  8.widthBox,
                                                  ConditionWidget(
                                                    title: LocaleKeys.automatic.tr(),
                                                    color: addProductController.isVisibleAutomatic
                                                        ? AppPalette.primary
                                                        : AppPalette.lightPrimary,
                                                    // onTap: filterCubit
                                                    //     .changeWarranty(),
                                                    textColor: addProductController.isVisibleAutomatic
                                                        ? AppPalette.white
                                                        : AppPalette.black,
                                                    onTap: () {
                                                      setState(() {
                                                        addProductController.isVisibleAutomatic = ! addProductController.isVisibleAutomatic;
                                                        addProductController.isVisibleManual = false;
                                                      });
                                                    },
                                                  ),
                                                ],
                                              ),
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
                                              Row(
                                                children: [
                                                  ConditionWidget(
                                                    title: LocaleKeys.newProd.tr(),
                                                    color: addProductController.condition ==
                                                        Condition.newProduct
                                                        ? AppPalette.primary
                                                        : AppPalette.lightPrimary,
                                                    onTap: addProductController
                                                        .changeCondition,
                                                    textColor: addProductController
                                                        .condition ==
                                                        Condition.newProduct
                                                        ? AppPalette.white
                                                        : AppPalette.black,
                                                  ),
                                                  8.widthBox,
                                                  ConditionWidget(
                                                    title: LocaleKeys.used.tr(),
                                                    color: addProductController.condition ==
                                                        Condition.used
                                                        ? AppPalette.primary
                                                        : AppPalette.lightPrimary,
                                                    onTap: addProductController
                                                        .changeCondition,
                                                    textColor: addProductController
                                                        .condition ==
                                                        Condition.used
                                                        ? AppPalette.white
                                                        : AppPalette.black,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          )
                                              : Container() : Container(),
                                          ////// Electronics Category
                                          addProductController.selectedMainCat != null ?
                                          addProductController.selectedMainCat!.name!.en!
                                              .contains('Electronics') ?
                                          Column(
                                            children: [
                                              CustomButtonWidget(
                                                  title: addProductController.selectedBrand ==
                                                      null ? LocaleKeys.brand.tr() :
                                                  context.locale.languageCode.contains('en')
                                                      ? addProductController.selectedBrand!
                                                      .brandName != null ?
                                                  '${addProductController.selectedBrand!
                                                      .brandName?.en!}' : LocaleKeys.category
                                                      .tr()
                                                      : context.locale.languageCode.contains(
                                                      'ar')
                                                      ? addProductController.selectedBrand!
                                                      .brandName != null ?
                                                  '${addProductController.selectedBrand!
                                                      .brandName?.ar!}' : LocaleKeys.category
                                                      .tr()
                                                      : context.locale.languageCode.contains(
                                                      'tr')
                                                      ? addProductController.selectedBrand!
                                                      .brandName != null ?
                                                  '${addProductController.selectedBrand!
                                                      .brandName?.tr!}' : LocaleKeys.category
                                                      .tr()
                                                      : context.locale.languageCode.contains(
                                                      'de')
                                                      ? addProductController.selectedBrand!
                                                      .brandName != null ?
                                                  '${addProductController.selectedBrand!
                                                      .brandName?.de!}' : LocaleKeys.category
                                                      .tr()
                                                      : ' ',
                                                  onTap: () =>
                                                  addProductController.selectedMainCat?.id !=
                                                      null ?
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            ChooseOneBrandScreen(
                                                                governmentId: widget
                                                                    .governmentId,
                                                                governmentName: widget
                                                                    .governmentName,
                                                                cityId: widget.cityId,
                                                                description: descriptionController.text,
                                                                whatsAppNumber: whatsAppController.text,
                                                                cityName: widget.cityName,
                                                                areaId: widget.areaId,
                                                                areaName: widget.areaName,
                                                                fromPrice: oldPriceController.text,
                                                                toPrice: newPriceController.text,
                                                                locationUser: locationUserController.text,
                                                                nameProduct: nameOfProductController.text,
                                                                data: 'AddProduct'),
                                                      )) : customFlutterToast(
                                                      'Please select main category first')
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
                                              Row(
                                                children: [
                                                  ConditionWidget(
                                                    title: LocaleKeys.yes.tr(),
                                                    color: addProductController.isVisibleWarrantyYes
                                                        ? AppPalette.primary
                                                        : AppPalette.lightPrimary,
                                                    // onTap: filterCubit
                                                    //     .changeWarranty(),
                                                    textColor: addProductController.isVisibleWarrantyYes
                                                        ? AppPalette.white
                                                        : AppPalette.black, onTap: () {
                                                    setState(() {
                                                      addProductController.isVisibleWarrantyYes = ! addProductController.isVisibleWarrantyYes;
                                                      addProductController.isVisibleWarrantyNo = false;
                                                    });
                                                  },
                                                  ),
                                                  8.widthBox,
                                                  ConditionWidget(
                                                    title: LocaleKeys.no.tr(),
                                                    color: addProductController.isVisibleWarrantyNo
                                                        ? AppPalette.primary
                                                        : AppPalette.lightPrimary,
                                                    // onTap: filterCubit
                                                    //     .changeWarranty(),
                                                    textColor: addProductController.isVisibleWarrantyNo
                                                        ? AppPalette.white
                                                        : AppPalette.black, onTap: () {
                                                    setState(() {
                                                      addProductController.isVisibleWarrantyNo = ! addProductController.isVisibleWarrantyNo;
                                                      addProductController.isVisibleWarrantyYes = false;
                                                    });
                                                  },
                                                  ),
                                                ],
                                              ),
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
                                              Row(
                                                children: [
                                                  ConditionWidget(
                                                    title: LocaleKeys.newProd.tr(),
                                                    color: addProductController.condition ==
                                                        Condition.newProduct
                                                        ? AppPalette.primary
                                                        : AppPalette.lightPrimary,
                                                    onTap: addProductController
                                                        .changeCondition,
                                                    textColor: addProductController
                                                        .condition ==
                                                        Condition.newProduct
                                                        ? AppPalette.white
                                                        : AppPalette.black,
                                                  ),
                                                  8.widthBox,
                                                  ConditionWidget(
                                                    title: LocaleKeys.used.tr(),
                                                    color: addProductController.condition ==
                                                        Condition.used
                                                        ? AppPalette.primary
                                                        : AppPalette.lightPrimary,
                                                    onTap: addProductController
                                                        .changeCondition,
                                                    textColor: addProductController
                                                        .condition ==
                                                        Condition.used
                                                        ? AppPalette.white
                                                        : AppPalette.black,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ) : Container() : Container(),
                                          15.heightBox,
                                          addProductController.selectedMainCat != null ?
                                          addProductController.selectedMainCat!.name!.en!
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
                                              Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      ConditionWidget(
                                                        title: LocaleKeys.finished.tr(),
                                                        color: addProductController.isVisibleFinished
                                                            ? AppPalette.primary
                                                            : AppPalette.lightPrimary,
                                                        onTap: (){
                                                          setState(() {
                                                            addProductController.isVisibleFinished = ! addProductController.isVisibleFinished;
                                                            addProductController.isVisibleNotFinished = false;
                                                            addProductController.isVisibleCoreShell = false;
                                                            addProductController.isVisibleSemiFinished = false;
                                                          });
                                                        },
                                                        textColor: addProductController.isVisibleFinished
                                                            ? AppPalette.white
                                                            : AppPalette.black,
                                                      ),
                                                      5.widthBox,
                                                      ConditionWidget(
                                                        title: LocaleKeys.notFinished.tr(),
                                                        color: addProductController.isVisibleNotFinished
                                                            ? AppPalette.primary
                                                            : AppPalette.lightPrimary,
                                                        onTap: (){
                                                          setState(() {
                                                            addProductController.isVisibleFinished = false;
                                                            addProductController.isVisibleNotFinished = !addProductController.isVisibleNotFinished;
                                                            addProductController.isVisibleCoreShell = false;
                                                            addProductController.isVisibleSemiFinished = false;
                                                          });
                                                        },
                                                        textColor: addProductController.isVisibleNotFinished
                                                            ? AppPalette.white
                                                            : AppPalette.black,
                                                      ),
                                                    ],
                                                  ),
                                                  10.heightBox,
                                                  Row(
                                                    children: [
                                                      ConditionWidget(
                                                        title: LocaleKeys.coreShell.tr(),
                                                        color: addProductController.isVisibleCoreShell
                                                            ? AppPalette.primary
                                                            : AppPalette.lightPrimary,
                                                        onTap: (){
                                                          setState(() {
                                                            addProductController.isVisibleFinished = false;
                                                            addProductController.isVisibleNotFinished = false;
                                                            addProductController.isVisibleCoreShell = !addProductController.isVisibleCoreShell;
                                                            addProductController.isVisibleSemiFinished = false;
                                                          });
                                                        },
                                                        textColor: addProductController.isVisibleCoreShell
                                                            ? AppPalette.white
                                                            : AppPalette.black,
                                                      ),
                                                      5.widthBox,
                                                      ConditionWidget(
                                                        title: LocaleKeys.semiFinished.tr(),
                                                        color: addProductController.isVisibleSemiFinished
                                                            ? AppPalette.primary
                                                            : AppPalette.lightPrimary,
                                                        onTap: (){
                                                          setState(() {
                                                            addProductController.isVisibleFinished = false;
                                                            addProductController.isVisibleNotFinished = false;
                                                            addProductController.isVisibleCoreShell = false;
                                                            addProductController.isVisibleSemiFinished = !addProductController.isVisibleSemiFinished;
                                                          });
                                                        },
                                                        textColor: addProductController.isVisibleSemiFinished
                                                            ? AppPalette.white
                                                            : AppPalette.black,
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          )
                                              :  Container() : Container(),
                                          15.heightBox,
                                          ////// Vehicles Category
                                          addProductController.selectedMainCat != null ?
                                          addProductController.selectedMainCat!.name!.en!
                                              .contains('Vehicles') ?
                                          Column(
                                            children: [
                                              CustomButtonWidget(
                                                  title: widget.colorType != null ?
                                                  widget.colorType!
                                                      :LocaleKeys.color.tr(),
                                                  onTap: () {
                                                    Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                                        ChooseColorAddProductScreen(
                                                          governmentId: widget
                                                              .governmentId,
                                                          governmentName: widget
                                                              .governmentName,
                                                          cityId: widget.cityId,
                                                          year: yearOfProductController.text,
                                                          downPayment: downPaymentController.text,
                                                          area: areaPropertiesController.text,
                                                          bathroom: bathroomOfProductController.text,
                                                          bedroom: bedroomOfProductController.text,
                                                          cityName: widget.cityName,
                                                          areaId: widget.areaId,
                                                          areaName: widget.areaName,
                                                          toPrice: newPriceController.text,
                                                          whatsAppNumber: whatsAppController.text,                                                    data: '',
                                                          fromPrice: oldPriceController.text,
                                                          levelType: widget.levelType,
                                                          kiloMetresType: kiloMetresOfProductController.text,
                                                          amenitiesType: widget.amenitiesType,
                                                          fuelType: widget.fuelType,
                                                          engineCapacityType: widget.engineCapacityType,
                                                          colorType: widget.colorType,
                                                          bodyType: widget.bodyType,
                                                          nameProduct: nameOfProductController.text,
                                                          description: descriptionController.text,
                                                          locationUser: locationUserController.text,
                                                        )));
                                                  }),
                                              15.heightBox,
                                              CustomButtonWidget(
                                                  title: widget.bodyType != null ?
                                                  widget.bodyType!
                                                      :LocaleKeys.bodyType.tr(),
                                                  onTap: () {
                                                    Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                                        ChooseBodyTypeAddProductScreen(
                                                          governmentId: widget
                                                              .governmentId,
                                                          governmentName: widget
                                                              .governmentName,
                                                          cityId: widget.cityId,
                                                          year: yearOfProductController.text,
                                                          downPayment: downPaymentController.text,
                                                          area: areaPropertiesController.text,
                                                          bathroom: bathroomOfProductController.text,
                                                          bedroom: bedroomOfProductController.text,
                                                          cityName: widget.cityName,
                                                          areaId: widget.areaId,
                                                          areaName: widget.areaName,
                                                          toPrice: newPriceController.text,
                                                          data: '',
                                                          whatsAppNumber: whatsAppController.text,                                                    fromPrice: oldPriceController.text,
                                                          levelType: widget.levelType,
                                                          kiloMetresType: kiloMetresOfProductController.text,
                                                          amenitiesType: widget.amenitiesType,
                                                          fuelType: widget.fuelType,
                                                          engineCapacityType: widget.engineCapacityType,
                                                          colorType: widget.colorType,
                                                          bodyType: widget.bodyType,
                                                          nameProduct: nameOfProductController.text,
                                                          description: descriptionController.text,
                                                          locationUser: locationUserController.text,)));
                                                  }),
                                              15.heightBox,
                                              CustomButtonWidget(
                                                  title: widget.engineCapacityType != null ?
                                                  widget.engineCapacityType!
                                                      :LocaleKeys.engineCapacity.tr(),
                                                  onTap: () {
                                                    Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                                        ChooseEngineCapacityAddProductScreen(
                                                          governmentId: widget
                                                              .governmentId,
                                                          governmentName: widget
                                                              .governmentName,
                                                          cityId: widget.cityId,
                                                          year: yearOfProductController.text,
                                                          downPayment: downPaymentController.text,
                                                          area: areaPropertiesController.text,
                                                          bathroom: bathroomOfProductController.text,
                                                          bedroom: bedroomOfProductController.text,
                                                          cityName: widget.cityName,
                                                          areaId: widget.areaId,
                                                          areaName: widget.areaName,
                                                          toPrice: newPriceController.text,
                                                          data: '',
                                                          fromPrice: oldPriceController.text,
                                                          levelType: widget.levelType,
                                                          kiloMetresType: kiloMetresOfProductController.text,
                                                          amenitiesType: widget.amenitiesType,
                                                          fuelType: widget.fuelType,
                                                          engineCapacityType: widget.engineCapacityType,
                                                          colorType: widget.colorType,
                                                          bodyType: widget.bodyType,
                                                          whatsAppNumber: whatsAppController.text,                                                    nameProduct: nameOfProductController.text,
                                                          description: descriptionController.text,
                                                          locationUser: locationUserController.text,
                                                        )));
                                                  }),
                                              15.heightBox
                                            ],
                                          )
                                              : Container() : Container(),
                                          InputTextFormField(
                                            hintText: LocaleKeys.description.tr(),
                                            maxLength: 1000000,
                                            textEditingController: descriptionController,
                                            validator: (val) {
                                              if (val.isEmpty) {
                                                return LocaleKeys.mustNotEmpty.tr();
                                              }
                                            },
                                            maxLines: 10,
                                          ),
                                          15.heightBox,
                                          Text(LocaleKeys.addToPhotos.tr(),
                                              style: const TextStyle(
                                                  color: AppPalette.black,
                                                  fontWeight: FontWeight.w500)),
                                          10.heightBox,
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    height: 125.h,
                                    child: ListView(
                                      shrinkWrap: true,
                                      physics: const BouncingScrollPhysics(),
                                      scrollDirection: Axis.horizontal,
                                      children: [
                                        // 15.widthBox,
                                        // Center(
                                        //   child: AddButtonWidget(
                                        //     child: IconButton(
                                        //       onPressed: addProductCubit.pickProductImage,
                                        //       icon: const Icon(
                                        //         Icons.add,
                                        //         color: AppPalette.white,
                                        //       ),
                                        //     ),
                                        //   ),
                                        // ),
                                        10.widthBox,
                                        ListView(
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          children: [
                                            Stack(
                                              children: <Widget>[
                                                InkWell(
                                                  onTap: () async{
                                                    // PickImage1(addProductCubit.images);
                                                    showDialog(
                                                        context: context,
                                                        builder: (context) =>
                                                            Dialog(
                                                              backgroundColor: Colors.white,
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius: BorderRadius.circular(Dimensions.radiusDefault)),
                                                              alignment: Alignment.bottomCenter,
                                                              insetPadding: EdgeInsets.symmetric(
                                                                  vertical: Dimensions.paddingSize, horizontal: Dimensions.paddingSize),
                                                              child: CustomDialogWidget(
                                                                msgStyle: const TextStyle(height: 2),
                                                                //   title: LocaleKeys.chosePhotoWith.tr(),
                                                                titleStyle: const TextStyle(
                                                                  color: Colors.blueGrey,
                                                                  overflow: TextOverflow.ellipsis,
                                                                ),
                                                                actions: [
                                                                  Padding(
                                                                    padding:
                                                                    EdgeInsets.symmetric(horizontal: Dimensions.paddingSmall),
                                                                    child: IconsButton(
                                                                      onPressed: () async {
                                                                        try {
                                                                          final image = await ImagePicker()
                                                                              .pickImage(
                                                                              source:
                                                                              ImageSource.gallery);
                                                                          if (image ==
                                                                              null)
                                                                            return;
                                                                          final iamgeTempoary =
                                                                          File(image
                                                                              .path);
                                                                          setState(() =>
                                                                          addProductController.image1 =
                                                                              iamgeTempoary);
                                                                          addProductController.images.add(File(image.path));
                                                                          // addProductCubit.updateImageProduct(context, stateProductDetails.showDetailsProductResponseModel![0].id.toString(), image1!);
                                                                        } on PlatformException catch (e) {
                                                                          if (kDebugMode) {
                                                                            print(e);
                                                                          }
                                                                        }
                                                                        Navigator.pop(context);
                                                                      },
                                                                      text: LocaleKeys.gallery.tr(),
                                                                      // color: Colors.transparent,
                                                                      shape: OutlineInputBorder(
                                                                          borderSide: const BorderSide(color: AppPalette.black),
                                                                          borderRadius:
                                                                          BorderRadius.circular(Dimensions.radiusDefault)),
                                                                      textStyle: const TextStyle(color: Colors.black),
                                                                      padding: EdgeInsets.symmetric(
                                                                          horizontal: Dimensions.paddingSizeExtraSmall,
                                                                          vertical: Dimensions.paddingSizeDefault),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding:
                                                                    EdgeInsets.symmetric(horizontal: Dimensions.paddingSmall),
                                                                    child: IconsButton(
                                                                      onPressed: () async {
                                                                        try {
                                                                          final image = await ImagePicker()
                                                                              .pickImage(
                                                                              source:
                                                                              ImageSource.camera);
                                                                          if (image ==
                                                                              null)
                                                                            return;
                                                                          final iamgeTempoary =
                                                                          File(image
                                                                              .path);
                                                                          setState(() =>
                                                                          addProductController.image1 =
                                                                              iamgeTempoary);
                                                                          addProductController.images.add(File(image.path));
                                                                          // addProductCubit.updateImageProduct(context, stateProductDetails.showDetailsProductResponseModel![0].id.toString(), image1!);
                                                                        } on PlatformException catch (e) {
                                                                          if (kDebugMode) {
                                                                            print(e);
                                                                          }
                                                                        }
                                                                        Navigator.pop(context);
                                                                      },
                                                                      text: LocaleKeys.camera.tr(),
                                                                      // iconData: Icons.done,
                                                                      color: AppPalette.primary,
                                                                      textStyle: const TextStyle(color: Colors.white),
                                                                      shape: OutlineInputBorder(
                                                                          borderSide: BorderSide.none,
                                                                          borderRadius:
                                                                          BorderRadius.circular(Dimensions.radiusDefault)),
                                                                      padding: EdgeInsets.symmetric(
                                                                          horizontal: Dimensions.paddingSizeExtraSmall,
                                                                          vertical: Dimensions.paddingSizeDefault),
                                                                      // iconColor: Colors.white,
                                                                    ),
                                                                  ),
                                                                ],
                                                                animationBuilder: lottie != null
                                                                    ? LottieBuilder.asset(
                                                                  lottie.toString(),
                                                                )
                                                                    : null,
                                                                customView: Dialogs.holder,
                                                                color: Colors.white,
                                                              ),
                                                            )
                                                    );
                                                  },
                                                  child: Container(
                                                    margin: EdgeInsets.symmetric(
                                                        horizontal: Dimensions.paddingSizeExtraSmall),
                                                    height: 125.h,
                                                    width: 125.w,
                                                    decoration: BoxDecoration(
                                                      color: AppPalette.lightPrimary,
                                                      borderRadius: BorderRadius.circular(
                                                          Dimensions.radiusDefault),
                                                    ),
                                                    child: addProductController.image1 != null ? Image.file(addProductController.image1!,fit: BoxFit.cover) :
                                                    SvgPicture.asset('assets/images/svg/camera_photo.svg',width: 75,height: 75,
                                                        fit: BoxFit.scaleDown,color: AppPalette.primary),
                                                  ),
                                                ),
                                                addProductController.image1 != null ?
                                                Padding(
                                                  padding: const EdgeInsets.all(5.0),
                                                  child: Align(
                                                    alignment: Alignment.topRight,
                                                    child: SizedBox(
                                                      width: 35,
                                                      height: 35,
                                                      child: IconButton(onPressed: (){
                                                        addProductController.image1 = null;
                                                        addProductController.images.removeAt(1);
                                                      }, icon: const Icon(
                                                        Icons.cancel_outlined,color: AppPalette.error,
                                                      )),
                                                    ),
                                                  ),
                                                ) :
                                                Container()
                                              ],
                                            ),
                                            5.widthBox,
                                            Stack(
                                              children: <Widget>[
                                                InkWell(
                                                  onTap: () async{
                                                    //  PickImage2(addProductCubit.images);
                                                    showDialog(
                                                        context: context,
                                                        builder: (context) =>
                                                            Dialog(
                                                              backgroundColor: Colors.white,
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius: BorderRadius.circular(Dimensions.radiusDefault)),
                                                              alignment: Alignment.bottomCenter,
                                                              insetPadding: EdgeInsets.symmetric(
                                                                  vertical: Dimensions.paddingSize, horizontal: Dimensions.paddingSize),
                                                              child: CustomDialogWidget(
                                                                msgStyle: const TextStyle(height: 2),
                                                                //   title: LocaleKeys.chosePhotoWith.tr(),
                                                                titleStyle: const TextStyle(
                                                                  color: Colors.blueGrey,
                                                                  overflow: TextOverflow.ellipsis,
                                                                ),
                                                                actions: [
                                                                  Padding(
                                                                    padding:
                                                                    EdgeInsets.symmetric(horizontal: Dimensions.paddingSmall),
                                                                    child: IconsButton(
                                                                      onPressed: () async {
                                                                        try {
                                                                          final image = await ImagePicker()
                                                                              .pickImage(
                                                                              source:
                                                                              ImageSource.gallery);
                                                                          if (image ==
                                                                              null)
                                                                            return;
                                                                          final iamgeTempoary =
                                                                          File(image
                                                                              .path);
                                                                          setState(() =>
                                                                          addProductController.image2 =
                                                                              iamgeTempoary);
                                                                          addProductController.images.add(File(image.path));
                                                                          // addProductCubit.updateImageProduct(context, stateProductDetails.showDetailsProductResponseModel![0].id.toString(), image1!);
                                                                        } on PlatformException catch (e) {
                                                                          if (kDebugMode) {
                                                                            print(e);
                                                                          }
                                                                        }
                                                                        Navigator.pop(context);
                                                                      },
                                                                      text: LocaleKeys.gallery.tr(),
                                                                      // color: Colors.transparent,
                                                                      shape: OutlineInputBorder(
                                                                          borderSide: const BorderSide(color: AppPalette.black),
                                                                          borderRadius:
                                                                          BorderRadius.circular(Dimensions.radiusDefault)),
                                                                      textStyle: const TextStyle(color: Colors.black),
                                                                      padding: EdgeInsets.symmetric(
                                                                          horizontal: Dimensions.paddingSizeExtraSmall,
                                                                          vertical: Dimensions.paddingSizeDefault),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding:
                                                                    EdgeInsets.symmetric(horizontal: Dimensions.paddingSmall),
                                                                    child: IconsButton(
                                                                      onPressed: () async {
                                                                        try {
                                                                          final image = await ImagePicker()
                                                                              .pickImage(
                                                                              source:
                                                                              ImageSource.camera);
                                                                          if (image ==
                                                                              null)
                                                                            return;
                                                                          final iamgeTempoary =
                                                                          File(image
                                                                              .path);
                                                                          setState(() =>
                                                                          addProductController.image2 =
                                                                              iamgeTempoary);
                                                                          addProductController.images.add(File(image.path));
                                                                          // addProductCubit.updateImageProduct(context, stateProductDetails.showDetailsProductResponseModel![0].id.toString(), image1!);
                                                                        } on PlatformException catch (e) {
                                                                          if (kDebugMode) {
                                                                            print(e);
                                                                          }
                                                                        }
                                                                        Navigator.pop(context);
                                                                      },
                                                                      text: LocaleKeys.camera.tr(),
                                                                      // iconData: Icons.done,
                                                                      color: AppPalette.primary,
                                                                      textStyle: const TextStyle(color: Colors.white),
                                                                      shape: OutlineInputBorder(
                                                                          borderSide: BorderSide.none,
                                                                          borderRadius:
                                                                          BorderRadius.circular(Dimensions.radiusDefault)),
                                                                      padding: EdgeInsets.symmetric(
                                                                          horizontal: Dimensions.paddingSizeExtraSmall,
                                                                          vertical: Dimensions.paddingSizeDefault),
                                                                      // iconColor: Colors.white,
                                                                    ),
                                                                  ),
                                                                ],
                                                                animationBuilder: lottie != null
                                                                    ? LottieBuilder.asset(
                                                                  lottie.toString(),
                                                                )
                                                                    : null,
                                                                customView: Dialogs.holder,
                                                                color: Colors.white,
                                                              ),
                                                            )
                                                    );
                                                  },
                                                  child: Container(
                                                    margin: EdgeInsets.symmetric(
                                                        horizontal: Dimensions.paddingSizeExtraSmall),
                                                    height: 125.h,
                                                    width: 125.w,
                                                    decoration: BoxDecoration(
                                                      color: AppPalette.lightPrimary,
                                                      borderRadius: BorderRadius.circular(
                                                          Dimensions.radiusDefault),
                                                    ),
                                                    child: addProductController.image2 != null ? Image.file(addProductController.image2!,fit: BoxFit.cover) :
                                                    SvgPicture.asset('assets/images/svg/camera_photo.svg',width: 75,height: 75,
                                                        fit: BoxFit.scaleDown,color: AppPalette.primary),
                                                  ),
                                                ),
                                                addProductController.image2 != null ?
                                                Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 0),
                                                  child: Align(
                                                    alignment: Alignment.topRight,
                                                    child: SizedBox(
                                                      width: 35,
                                                      height: 35,
                                                      child: IconButton(onPressed: (){
                                                        addProductController.image2 = null;
                                                        addProductController.images.removeAt(2);
                                                      }, icon: const Icon(
                                                        Icons.cancel_outlined,color: AppPalette.error,
                                                      )),
                                                    ),
                                                  ),
                                                ) :
                                                Container()
                                              ],
                                            ),
                                            5.widthBox,
                                            Stack(
                                              children: <Widget>[
                                                InkWell(
                                                  onTap: () async{
                                                    //  PickImage2(addProductCubit.images);
                                                    showDialog(
                                                        context: context,
                                                        builder: (context) =>
                                                            Dialog(
                                                              backgroundColor: Colors.white,
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius: BorderRadius.circular(Dimensions.radiusDefault)),
                                                              alignment: Alignment.bottomCenter,
                                                              insetPadding: EdgeInsets.symmetric(
                                                                  vertical: Dimensions.paddingSize, horizontal: Dimensions.paddingSize),
                                                              child: CustomDialogWidget(
                                                                msgStyle: const TextStyle(height: 2),
                                                                //   title: LocaleKeys.chosePhotoWith.tr(),
                                                                titleStyle: const TextStyle(
                                                                  color: Colors.blueGrey,
                                                                  overflow: TextOverflow.ellipsis,
                                                                ),
                                                                actions: [
                                                                  Padding(
                                                                    padding:
                                                                    EdgeInsets.symmetric(horizontal: Dimensions.paddingSmall),
                                                                    child: IconsButton(
                                                                      onPressed: () async {
                                                                        try {
                                                                          final image = await ImagePicker()
                                                                              .pickImage(
                                                                              source:
                                                                              ImageSource.gallery);
                                                                          if (image ==
                                                                              null)
                                                                            return;
                                                                          final iamgeTempoary =
                                                                          File(image
                                                                              .path);
                                                                          setState(() =>
                                                                          addProductController.image3 =
                                                                              iamgeTempoary);
                                                                          addProductController.images.add(File(image.path));
                                                                          // addProductCubit.updateImageProduct(context, stateProductDetails.showDetailsProductResponseModel![0].id.toString(), image1!);
                                                                        } on PlatformException catch (e) {
                                                                          if (kDebugMode) {
                                                                            print(e);
                                                                          }
                                                                        }
                                                                        Navigator.pop(context);
                                                                      },
                                                                      text: LocaleKeys.gallery.tr(),
                                                                      // color: Colors.transparent,
                                                                      shape: OutlineInputBorder(
                                                                          borderSide: const BorderSide(color: AppPalette.black),
                                                                          borderRadius:
                                                                          BorderRadius.circular(Dimensions.radiusDefault)),
                                                                      textStyle: const TextStyle(color: Colors.black),
                                                                      padding: EdgeInsets.symmetric(
                                                                          horizontal: Dimensions.paddingSizeExtraSmall,
                                                                          vertical: Dimensions.paddingSizeDefault),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding:
                                                                    EdgeInsets.symmetric(horizontal: Dimensions.paddingSmall),
                                                                    child: IconsButton(
                                                                      onPressed: () async {
                                                                        try {
                                                                          final image = await ImagePicker()
                                                                              .pickImage(
                                                                              source:
                                                                              ImageSource.camera);
                                                                          if (image ==
                                                                              null)
                                                                            return;
                                                                          final iamgeTempoary =
                                                                          File(image
                                                                              .path);
                                                                          setState(() =>
                                                                          addProductController.image3 =
                                                                              iamgeTempoary);
                                                                          addProductController.images.add(File(image.path));
                                                                          // addProductCubit.updateImageProduct(context, stateProductDetails.showDetailsProductResponseModel![0].id.toString(), image1!);
                                                                        } on PlatformException catch (e) {
                                                                          if (kDebugMode) {
                                                                            print(e);
                                                                          }
                                                                        }
                                                                        Navigator.pop(context);
                                                                      },
                                                                      text: LocaleKeys.camera.tr(),
                                                                      // iconData: Icons.done,
                                                                      color: AppPalette.primary,
                                                                      textStyle: const TextStyle(color: Colors.white),
                                                                      shape: OutlineInputBorder(
                                                                          borderSide: BorderSide.none,
                                                                          borderRadius:
                                                                          BorderRadius.circular(Dimensions.radiusDefault)),
                                                                      padding: EdgeInsets.symmetric(
                                                                          horizontal: Dimensions.paddingSizeExtraSmall,
                                                                          vertical: Dimensions.paddingSizeDefault),
                                                                      // iconColor: Colors.white,
                                                                    ),
                                                                  ),
                                                                ],
                                                                animationBuilder: lottie != null
                                                                    ? LottieBuilder.asset(
                                                                  lottie.toString(),
                                                                )
                                                                    : null,
                                                                customView: Dialogs.holder,
                                                                color: Colors.white,
                                                              ),
                                                            )
                                                    );
                                                  },
                                                  child: Container(
                                                    margin: EdgeInsets.symmetric(
                                                        horizontal: Dimensions.paddingSizeExtraSmall),
                                                    height: 125.h,
                                                    width: 125.w,
                                                    decoration: BoxDecoration(
                                                      color: AppPalette.lightPrimary,
                                                      borderRadius: BorderRadius.circular(
                                                          Dimensions.radiusDefault),
                                                    ),
                                                    child: addProductController.image3 != null ? Image.file(addProductController.image3!,fit: BoxFit.cover) :
                                                    SvgPicture.asset('assets/images/svg/camera_photo.svg',width: 75,height: 75,
                                                        fit: BoxFit.scaleDown,color: AppPalette.primary),
                                                  ),
                                                ),
                                                addProductController.image3 != null ?
                                                Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 0),
                                                  child: Align(
                                                    alignment: Alignment.topRight,
                                                    child: SizedBox(
                                                      width: 35,
                                                      height: 35,
                                                      child: IconButton(onPressed: (){
                                                        addProductController.image3 = null;
                                                        addProductController.images.removeAt(3);
                                                      }, icon: const Icon(
                                                        Icons.cancel_outlined,color: AppPalette.error,
                                                      )),
                                                    ),
                                                  ),
                                                ) :
                                                Container()
                                              ],
                                            ),
                                            5.widthBox,
                                            Stack(
                                              children: <Widget>[
                                                InkWell(
                                                  onTap: () async{
                                                    //  PickImage2(addProductCubit.images);
                                                    showDialog(
                                                        context: context,
                                                        builder: (context) =>
                                                            Dialog(
                                                              backgroundColor: Colors.white,
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius: BorderRadius.circular(Dimensions.radiusDefault)),
                                                              alignment: Alignment.bottomCenter,
                                                              insetPadding: EdgeInsets.symmetric(
                                                                  vertical: Dimensions.paddingSize, horizontal: Dimensions.paddingSize),
                                                              child: CustomDialogWidget(
                                                                msgStyle: const TextStyle(height: 2),
                                                                //   title: LocaleKeys.chosePhotoWith.tr(),
                                                                titleStyle: const TextStyle(
                                                                  color: Colors.blueGrey,
                                                                  overflow: TextOverflow.ellipsis,
                                                                ),
                                                                actions: [
                                                                  Padding(
                                                                    padding:
                                                                    EdgeInsets.symmetric(horizontal: Dimensions.paddingSmall),
                                                                    child: IconsButton(
                                                                      onPressed: () async {
                                                                        try {
                                                                          final image = await ImagePicker()
                                                                              .pickImage(
                                                                              source:
                                                                              ImageSource.gallery);
                                                                          if (image ==
                                                                              null)
                                                                            return;
                                                                          final iamgeTempoary =
                                                                          File(image
                                                                              .path);
                                                                          setState(() =>
                                                                          addProductController.image4 =
                                                                              iamgeTempoary);
                                                                          addProductController.images.add(File(image.path));
                                                                          // addProductCubit.updateImageProduct(context, stateProductDetails.showDetailsProductResponseModel![0].id.toString(), image1!);
                                                                        } on PlatformException catch (e) {
                                                                          if (kDebugMode) {
                                                                            print(e);
                                                                          }
                                                                        }
                                                                        Navigator.pop(context);
                                                                      },
                                                                      text: LocaleKeys.gallery.tr(),
                                                                      // color: Colors.transparent,
                                                                      shape: OutlineInputBorder(
                                                                          borderSide: const BorderSide(color: AppPalette.black),
                                                                          borderRadius:
                                                                          BorderRadius.circular(Dimensions.radiusDefault)),
                                                                      textStyle: const TextStyle(color: Colors.black),
                                                                      padding: EdgeInsets.symmetric(
                                                                          horizontal: Dimensions.paddingSizeExtraSmall,
                                                                          vertical: Dimensions.paddingSizeDefault),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding:
                                                                    EdgeInsets.symmetric(horizontal: Dimensions.paddingSmall),
                                                                    child: IconsButton(
                                                                      onPressed: () async {
                                                                        try {
                                                                          final image = await ImagePicker()
                                                                              .pickImage(
                                                                              source:
                                                                              ImageSource.camera);
                                                                          if (image ==
                                                                              null)
                                                                            return;
                                                                          final iamgeTempoary =
                                                                          File(image
                                                                              .path);
                                                                          setState(() =>
                                                                          addProductController.image4 =
                                                                              iamgeTempoary);
                                                                          addProductController.images.add(File(image.path));
                                                                          // addProductCubit.updateImageProduct(context, stateProductDetails.showDetailsProductResponseModel![0].id.toString(), image1!);
                                                                        } on PlatformException catch (e) {
                                                                          if (kDebugMode) {
                                                                            print(e);
                                                                          }
                                                                        }
                                                                        Navigator.pop(context);
                                                                      },
                                                                      text: LocaleKeys.camera.tr(),
                                                                      // iconData: Icons.done,
                                                                      color: AppPalette.primary,
                                                                      textStyle: const TextStyle(color: Colors.white),
                                                                      shape: OutlineInputBorder(
                                                                          borderSide: BorderSide.none,
                                                                          borderRadius:
                                                                          BorderRadius.circular(Dimensions.radiusDefault)),
                                                                      padding: EdgeInsets.symmetric(
                                                                          horizontal: Dimensions.paddingSizeExtraSmall,
                                                                          vertical: Dimensions.paddingSizeDefault),
                                                                      // iconColor: Colors.white,
                                                                    ),
                                                                  ),
                                                                ],
                                                                animationBuilder: lottie != null
                                                                    ? LottieBuilder.asset(
                                                                  lottie.toString(),
                                                                )
                                                                    : null,
                                                                customView: Dialogs.holder,
                                                                color: Colors.white,
                                                              ),
                                                            ));
                                                  },
                                                  child: Container(
                                                    margin: EdgeInsets.symmetric(
                                                        horizontal: Dimensions.paddingSizeExtraSmall),
                                                    height: 125.h,
                                                    width: 125.w,
                                                    decoration: BoxDecoration(
                                                      color: AppPalette.lightPrimary,
                                                      borderRadius: BorderRadius.circular(
                                                          Dimensions.radiusDefault),
                                                    ),
                                                    child: addProductController.image4 != null ? Image.file(addProductController.image4!,fit: BoxFit.cover) :
                                                    SvgPicture.asset('assets/images/svg/camera_photo.svg',width: 75,height: 75,
                                                        fit: BoxFit.scaleDown,color: AppPalette.primary),
                                                  ),
                                                ),
                                                addProductController.image4 != null ?
                                                Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 0),
                                                  child: Align(
                                                    alignment: Alignment.topRight,
                                                    child: SizedBox(
                                                      width: 35,
                                                      height: 35,
                                                      child: IconButton(onPressed: (){
                                                        addProductController.image4 = null;
                                                        addProductController.images.removeAt(4);
                                                      }, icon: const Icon(
                                                        Icons.cancel_outlined,color: AppPalette.error,
                                                      )),
                                                    ),
                                                  ),
                                                ) :
                                                Container()
                                              ],
                                            ),
                                            5.widthBox,
                                            Stack(
                                              children: <Widget>[
                                                InkWell(
                                                  onTap: () async{
                                                    //  PickImage2(addProductCubit.images);
                                                    showDialog(
                                                        context: context,
                                                        builder: (context) =>
                                                            Dialog(
                                                              backgroundColor: Colors.white,
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius: BorderRadius.circular(Dimensions.radiusDefault)),
                                                              alignment: Alignment.bottomCenter,
                                                              insetPadding: EdgeInsets.symmetric(
                                                                  vertical: Dimensions.paddingSize, horizontal: Dimensions.paddingSize),
                                                              child: CustomDialogWidget(
                                                                msgStyle: const TextStyle(height: 2),
                                                                //   title: LocaleKeys.chosePhotoWith.tr(),
                                                                titleStyle: const TextStyle(
                                                                  color: Colors.blueGrey,
                                                                  overflow: TextOverflow.ellipsis,
                                                                ),
                                                                actions: [
                                                                  Padding(
                                                                    padding:
                                                                    EdgeInsets.symmetric(horizontal: Dimensions.paddingSmall),
                                                                    child: IconsButton(
                                                                      onPressed: () async {
                                                                        try {
                                                                          final image = await ImagePicker()
                                                                              .pickImage(
                                                                              source:
                                                                              ImageSource.gallery);
                                                                          if (image ==
                                                                              null)
                                                                            return;
                                                                          final iamgeTempoary =
                                                                          File(image
                                                                              .path);
                                                                          setState(() =>
                                                                          addProductController.image5 =
                                                                              iamgeTempoary);
                                                                          addProductController.images.add(File(image.path));
                                                                          // addProductCubit.updateImageProduct(context, stateProductDetails.showDetailsProductResponseModel![0].id.toString(), image1!);
                                                                        } on PlatformException catch (e) {
                                                                          if (kDebugMode) {
                                                                            print(e);
                                                                          }
                                                                        }
                                                                        Navigator.pop(context);
                                                                      },
                                                                      text: LocaleKeys.gallery.tr(),
                                                                      // color: Colors.transparent,
                                                                      shape: OutlineInputBorder(
                                                                          borderSide: const BorderSide(color: AppPalette.black),
                                                                          borderRadius:
                                                                          BorderRadius.circular(Dimensions.radiusDefault)),
                                                                      textStyle: const TextStyle(color: Colors.black),
                                                                      padding: EdgeInsets.symmetric(
                                                                          horizontal: Dimensions.paddingSizeExtraSmall,
                                                                          vertical: Dimensions.paddingSizeDefault),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding:
                                                                    EdgeInsets.symmetric(horizontal: Dimensions.paddingSmall),
                                                                    child: IconsButton(
                                                                      onPressed: () async {
                                                                        try {
                                                                          final image = await ImagePicker()
                                                                              .pickImage(
                                                                              source:
                                                                              ImageSource.camera);
                                                                          if (image ==
                                                                              null)
                                                                            return;
                                                                          final iamgeTempoary =
                                                                          File(image
                                                                              .path);
                                                                          setState(() =>
                                                                          addProductController.image5 =
                                                                              iamgeTempoary);
                                                                          addProductController.images.add(File(image.path));
                                                                          // addProductCubit.updateImageProduct(context, stateProductDetails.showDetailsProductResponseModel![0].id.toString(), image1!);
                                                                        } on PlatformException catch (e) {
                                                                          if (kDebugMode) {
                                                                            print(e);
                                                                          }
                                                                        }
                                                                        Navigator.pop(context);
                                                                      },
                                                                      text: LocaleKeys.camera.tr(),
                                                                      // iconData: Icons.done,
                                                                      color: AppPalette.primary,
                                                                      textStyle: const TextStyle(color: Colors.white),
                                                                      shape: OutlineInputBorder(
                                                                          borderSide: BorderSide.none,
                                                                          borderRadius:
                                                                          BorderRadius.circular(Dimensions.radiusDefault)),
                                                                      padding: EdgeInsets.symmetric(
                                                                          horizontal: Dimensions.paddingSizeExtraSmall,
                                                                          vertical: Dimensions.paddingSizeDefault),
                                                                      // iconColor: Colors.white,
                                                                    ),
                                                                  ),
                                                                ],
                                                                animationBuilder: lottie != null
                                                                    ? LottieBuilder.asset(
                                                                  lottie.toString(),
                                                                )
                                                                    : null,
                                                                customView: Dialogs.holder,
                                                                color: Colors.white,
                                                              ),
                                                            ));
                                                  },
                                                  child: Container(
                                                    margin: EdgeInsets.symmetric(
                                                        horizontal: Dimensions.paddingSizeExtraSmall),
                                                    height: 125.h,
                                                    width: 125.w,
                                                    decoration: BoxDecoration(
                                                      color: AppPalette.lightPrimary,
                                                      borderRadius: BorderRadius.circular(
                                                          Dimensions.radiusDefault),
                                                    ),
                                                    child: addProductController.image5 != null ? Image.file(addProductController.image5!,fit: BoxFit.cover) :
                                                    SvgPicture.asset('assets/images/svg/camera_photo.svg',width: 75,height: 75,
                                                        fit: BoxFit.scaleDown,color: AppPalette.primary),
                                                  ),
                                                ),
                                                addProductController.image5 != null ?
                                                Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 0),
                                                  child: Align(
                                                    alignment: Alignment.topRight,
                                                    child: SizedBox(
                                                      width: 35,
                                                      height: 35,
                                                      child: IconButton(onPressed: (){
                                                        addProductController.image5 = null;
                                                        addProductController.images.removeAt(5);
                                                      }, icon: const Icon(
                                                        Icons.cancel_outlined,color: AppPalette.error,
                                                      )),
                                                    ),
                                                  ),
                                                ) :
                                                Container(),

                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  15.heightBox,
                                  addProductController.loading
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
                                  15.heightBox,
                                  Container(
                                    padding: EdgeInsets.only(
                                      bottom: Dimensions.paddingSizeDefault,
                                      right: Dimensions.paddingSizeDefault,
                                      left: Dimensions.paddingSizeDefault,
                                    ),
                                    child: CustomButton(
                                      buttonText: LocaleKeys.add.tr(),
                                      onPressed: () {
                                        //  print('option list is $nameOfProduct');
                                        if(stateConnectionInternet is ConnectionFailure){
                                          AwesomeDialog(
                                            context: context,
                                            dialogType: DialogType.warning,
                                            animType: AnimType.RIGHSLIDE,
                                            title: LocaleKeys.warning.tr(),
                                            btnOkText: LocaleKeys.ok.tr(),
                                            btnCancelText: LocaleKeys.cancel.tr(),
                                            body: Text(LocaleKeys.internetConnection.tr()),
                                            desc: LocaleKeys.internetConnection2.tr(),
                                            btnCancelOnPress: () {
                                              _submit(context,
                                                  addProductCubit: addProductController,
                                                  appLayoutState: state);
                                            },
                                            btnOkOnPress: () {
                                              _submit(context,
                                                  addProductCubit: addProductController,
                                                  appLayoutState: state);
                                            },
                                          ).show();

                                        } else if(stateConnectionInternet is ConnectionSuccess){
                                          _submit(context,
                                              addProductCubit: addProductController,
                                              appLayoutState: state);
                                        }


                                      },
                                      height: 48.h,
                                      fontSize: Dimensions.fontSizeLarge,
                                    ),
                                  ),
                                  15.heightBox,
                                  //  ImagesSectionWidget(),
                                ],
                              );
                            },);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void selectImageByCameraOrGallery(BuildContext context,File? image1,String? lottie){
    showDialog(
        context: context,
        builder: (context) =>
        Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Dimensions.radiusDefault)),
          alignment: Alignment.bottomCenter,
          insetPadding: EdgeInsets.symmetric(
              vertical: Dimensions.paddingSize, horizontal: Dimensions.paddingSize),
          child: CustomDialogWidget(
            msgStyle: const TextStyle(height: 2),
            //   title: LocaleKeys.chosePhotoWith.tr(),
            titleStyle: const TextStyle(
              color: Colors.blueGrey,
              overflow: TextOverflow.ellipsis,
            ),
            actions: [
              Padding(
                padding:
                EdgeInsets.symmetric(horizontal: Dimensions.paddingSmall),
                child: IconsButton(
                  onPressed: () async {
                    try {
                      final image = await ImagePicker()
                          .pickImage(
                          source:
                          ImageSource.gallery);
                      if (image ==
                          null)
                        return;
                      final iamgeTempoary =
                      File(image
                          .path);
                      setState(() =>
                      image1 =
                          iamgeTempoary);
                      // addProductCubit.updateImageProduct(context, stateProductDetails.showDetailsProductResponseModel![0].id.toString(), image1!);
                    } on PlatformException catch (e) {
                      if (kDebugMode) {
                        print(e);
                      }
                    }
                    Navigator.pop(context);
                  },
                  text: LocaleKeys.gallery.tr(),
                  // color: Colors.transparent,
                  shape: OutlineInputBorder(
                      borderSide: const BorderSide(color: AppPalette.black),
                      borderRadius:
                      BorderRadius.circular(Dimensions.radiusDefault)),
                  textStyle: const TextStyle(color: Colors.black),
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.paddingSizeExtraSmall,
                      vertical: Dimensions.paddingSizeDefault),
                ),
              ),
              Padding(
                padding:
                EdgeInsets.symmetric(horizontal: Dimensions.paddingSmall),
                child: IconsButton(
                  onPressed: () async {
                    try {
                      final image = await ImagePicker()
                          .pickImage(
                          source:
                          ImageSource.camera);
                      if (image ==
                          null)
                        return;
                      final iamgeTempoary =
                      File(image
                          .path);
                      setState(() =>
                      image1 =
                          iamgeTempoary);
                      // addProductCubit.updateImageProduct(context, stateProductDetails.showDetailsProductResponseModel![0].id.toString(), image1!);
                    } on PlatformException catch (e) {
                      if (kDebugMode) {
                        print(e);
                      }
                    }
                    Navigator.pop(context);
                  },
                  text: LocaleKeys.camera.tr(),
                  // iconData: Icons.done,
                  color: AppPalette.primary,
                  textStyle: const TextStyle(color: Colors.white),
                  shape: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius:
                      BorderRadius.circular(Dimensions.radiusDefault)),
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.paddingSizeExtraSmall,
                      vertical: Dimensions.paddingSizeDefault),
                  // iconColor: Colors.white,
                ),
              ),
            ],
            animationBuilder: lottie != null
                ? LottieBuilder.asset(
              lottie.toString(),
            )
                : null,
            customView: Dialogs.holder,
            color: Colors.white,
          ),
        )
    );}

  void _handleLoginListener(BuildContext context, AddProductState state) {
    if (state is AddProductErrorState) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.warning,
        animType: AnimType.RIGHSLIDE,
        title: LocaleKeys.warning.tr(),
        btnOkText: LocaleKeys.ok.tr(),
        btnCancelText: LocaleKeys.cancel.tr(),
        desc: LocaleKeys.internetConnection.tr(),
        btnCancelOnPress: () {},
        btnOkOnPress: () {},
      ).show();
    } else if (state is AddProductSuccessState) {
      // Navigator.pushNamedAndRemoveUntil(
      //     context, AppConstants.appLayout, (_) => false);
      // _clearFormData();
    }
  }

  // void _clearFormData() {
  //   nameOfProductController.clear();
  //   oldPriceController.clear();
  //   newPriceController.clear();
  //   descriptionController.clear();
  //   widget.governmentName == null;
  //   widget.cityName == null;
  //   widget.areaName == null;
  // }

// void handleOptionProduct(BuildContext context,
//     AddProductCubit addProductController) {
//   addProductController.selectedMainCat != null ?
//   BlocProvider.of<AddProductCubit>(context).getOptionFromCategories(
//       '${addProductController.selectedMainCat?.id.toString()}') :
//   Container();
// }

// handleOptionProductWidget(BuildContext context, AddProductState state) {
//   if(state is GetOptionErrorState){
//
//   }else if(state is GetOptionSuccessState){
//     if(state.optionModel !=null){
//       state.optionModel?.data!.length != 0 ?
//       ListView.builder(
//         shrinkWrap: true,
//         scrollDirection: Axis.vertical,
//         itemCount: state.optionModel?.data!.length,
//         itemBuilder: (context, index) {
//           return  state.optionModel!.data![index].inputType!.contains('text') ?
//           CustomButtonWidget(
//               title: widget.cityName == null
//                   ? LocaleKeys.city.tr()
//                   : widget.cityName!,
//               onTap: () {
//                 if(widget.governmentId == null){
//                   CustomFlutterToast('من فضلك اختر المحافظة');
//                 }else {
//                   Navigator.of(context).push(
//                       MaterialPageRoute(builder: (context) =>  ChooseCityProductScreen(governmentId: widget.governmentId,
//                         governmentName: widget.governmentName,),
//                       ));
//                 }
//               }) : state.optionModel!.data![index].inputType!.contains('number') ?
//           CustomButtonWidget(
//               title: widget.areaName == null
//                   ? LocaleKeys.area.tr()
//                   : widget.areaName!,
//               onTap: (){
//                 if(widget.cityId == null){
//                   CustomFlutterToast('من فضلك اختر المحافظة');
//                 }else {
//                   Navigator.of(context).push(
//                       MaterialPageRoute(builder: (context) =>  ChooseAreaProductScreen(cityId: widget.cityId,
//                         cityName: widget.cityName, locationUser: '', areaId: widget.areaId,
//                         governmentName: widget.governmentName, governmentId: widget.governmentId,),
//                       ));
//                 }
//               }) : Container();
//
//         },) : Container();
//     }else {
//       return Container();
//     }
//   }

}

