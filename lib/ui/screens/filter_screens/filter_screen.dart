// ignore_for_file: avoid_print, prefer_if_null_operators, deprecated_member_use

import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:multiselect/multiselect.dart';
import 'package:shop/business_logic/filter_cubit/filter_cubit.dart';
import 'package:shop/business_logic/locations_cubit/locations_cubit.dart';
import 'package:shop/business_logic/my_products_cubit/my_products_cubit.dart';
import 'package:shop/business_logic/my_products_cubit/my_products_state.dart';
import 'package:shop/translations/locale_keys.g.dart';
import 'package:shop/ui/base/custom_button.dart';
import 'package:shop/ui/screens/filter_screens/choose_categories_screens/main_category_screen.dart';
import 'package:shop/ui/screens/filter_screens/choose_categories_screens/sub_category_screen.dart';
import 'package:shop/ui/screens/filter_screens/choose_kilometers_screen/choose_kilometers_screen.dart';
import 'package:shop/ui/screens/filter_screens/choose_kilometers_screen/choose_to_kilometers_screen.dart';
import 'package:shop/ui/screens/filter_screens/choose_year_screen/choose_year_screen.dart';
import 'package:shop/ui/screens/filter_screens/filter_result_screen/filter_result_screen.dart';
import 'package:shop/ui/screens/layout/app_layout.dart';
import 'package:shop/ui/widgets/My_products_widgets/add_product_widgets/custom_button_widget.dart';
import 'package:shop/ui/widgets/My_products_widgets/add_product_widgets/input_text_form_field.dart';
import 'package:shop/utils/app_palette.dart';
import 'package:shop/utils/app_size_boxes.dart';
import 'package:shop/utils/dimensions.dart';
import 'package:translator/translator.dart';

import '../../../helpers/cache_helper.dart';
import '../../../helpers/components.dart';
import '../../base/custom_toast.dart';
import '../add_products_screen/choose_categories_screens/choose_area_product_screen.dart';
import '../add_products_screen/choose_categories_screens/choose_city_product_screen.dart';
import '../add_products_screen/choose_categories_screens/choose_government_product_screen.dart';
import '../add_products_screen/choose_categories_screens/choose_one_brand_screen.dart';

class FilterScreen extends StatefulWidget {
  FilterScreen({Key? key,
    this.governmentId,
    this.governmentName,
    this.cityId,
    this.cityName,
    this.areaId,
    this.areaName,
    this.locationUser,
    this.fromPrice,
    this.toPrice,
    this.fromArea,
    this.toArea,
    this.bedroom,
    this.bathroom,
    this.status,
    this.fromkiloMetresType,
    this.tokiloMetresType,
    this.fromDownPayment,
    this.toDownPayment,
    this.fuelType,
    this.bodyType,
    this.amenitiesType,
    this.colorType,
    this.engineCapacityType,
    this.kiloMetresType,
    this.levelType,
    this.fromYear,
    this.toYear})
      : super(key: key);

  String? governmentId, governmentName;
  String? cityId, cityName;
  String? areaId, areaName;
  String? locationUser;
  String? brandId, fromDownPayment, toDownPayment;
  String? status, fromYear, toYear, bedroom, bathroom;
  String? fromPrice, toPrice, fromArea, toArea;
  String? kiloMetresType,
      fuelType,
      amenitiesType,
      bodyType,
      colorType,
      engineCapacityType,
      fromkiloMetresType,
      tokiloMetresType,
      levelType;

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  final translator = GoogleTranslator();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController nameOfProductController = TextEditingController();
  TextEditingController locationUserController = TextEditingController();
  TextEditingController fromPriceController = TextEditingController();
  TextEditingController toPriceController = TextEditingController();
  TextEditingController fromYearController = TextEditingController();
  TextEditingController toYearController = TextEditingController();
  TextEditingController fromDownPaymentController = TextEditingController();
  TextEditingController toDownPaymentController = TextEditingController();
  TextEditingController fromAreaPropertiesController = TextEditingController();
  TextEditingController toAreaPropertiesController = TextEditingController();
  TextEditingController bedroomPropertiesController = TextEditingController();
  TextEditingController bathroomPropertiesController = TextEditingController();
  late String locationUser;
  late String statusUser;
  late String categoryId;
  late String subCategoryId;
  late String brandId, brandName;
  String? nameOfProduct;
  Timer? timer;

  /// ConditionOptionAllCategory
  late List<String> optionsConditionElectronics;

  /// Books
  late List<String> optionsTypeBooks;
  late List<String> optionsConditionBooks;

  /// Electronics
  late List<String> optionsWarrantyElectronics;

  // // location
  // late List<String> optionsDistanceLocation;

  /// Fashion
  late List<String> optionsTypeFashion;
  late List<String> optionsConditionFashion;

  /// Home Furniture
  late List<String> optionsTypeHomeFurniture;
  late List<String> optionsConditionFurniture;


  /// Kids
  late List<String> optionsTypeKids;
  late List<String> optionsConditionTypeKids;

  /// Business
  late List<String> optionsTypeBusiness;
  late List<String> optionsConditionTypeBusiness;

  /// Vehicles
  late List<String> optionsFuelTypeVehicles;
  late List<String> optionsTransmissionTypeVehicles;
  late List<String> optionsColorVehicles;
  late List<String> optionsBodyTypeVehicles;
  late List<String> optionsEngineCapacityVehicles;
  late List<String> optionsConditionVehicles;

  /// Properties
  late List<String> optionsTypeProperties;
  late List<String> optionsTypeApartmentProperties;
  late List<String> optionsTypeApartmentFurnishedProperties;
  late List<String> optionsTypeAmenitiesProperties;
  late List<String> optionsBedroomProperties;
  late List<String> optionsBathRoomProperties;
  late List<String> optionsLevelProperties;



  bool isSelectedDistanceLocation = false;
  String dropdownValue = '0';

  /// location
  late List<String> optionsDistanceLocation = [
    '0',
    '5',
    '10',
    '15',
    '20',
    '25',
    '30',
    '35',
    '40',
    '45',
    '50',
    '55',
    '60',
  ];

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

  // String? kidsTranslate,warrantyElectronicTranslate,typeFashionTranslate,
  //     typeHomeFurnitureTranslate,typeBooksTranslate,typeBusinessTranslate;
  //
  // String? fuelTypeTranslate,bodyTypeTranslate,colorVehiclesTranslate,
  //     transmissionVehiclesTranslate,engineCapacityTypeTranslate;
  //
  // String? amenitiesTypeTranslate,typeApartmentTranslate,
  //     typePropertiesTranslate,furnishedPropertiesTranslate;


  String?  dropdownValues,
      brandNameFilter,
      governmentNameFilter,
      governmentId,
      cityNameFilter,
      cityId,
      areaNameFilter,
      areaId,
      statusUserFilter,
      distanceKilometresFilter,
      warrantyElectronicsFilter;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    print('government id widget ${widget.governmentId}');
    print('government name widget ${widget.governmentName}');

    print('city id ${widget.cityId}');
    print('city name widget ${widget.cityName}');

    print('area id ${widget.areaId}');
    print('area name widget ${widget.areaName}');
    print('status widget ${widget.status}');
    print('status widget ${widget.status}');
    print('dropdownValues is $dropdownValues');




    // brandNameFilter = CacheHelper.getData(key: 'brandName');
    // governmentId = CacheHelper.getData(key: 'governmentId');
    // governmentNameFilter = CacheHelper.getData(key: 'governmentName');
    // cityId = CacheHelper.getData(key: 'cityId');
    // cityNameFilter = CacheHelper.getData(key: 'cityName');
    // areaId = CacheHelper.getData(key: 'areaId');
    // areaNameFilter = CacheHelper.getData(key: 'areaName');
    // statusUserFilter = CacheHelper.getData(key: 'statusUser');
    // distanceKilometresFilter = CacheHelper.getData(key: 'distanceKilometres');
    //
    // // warrantyElectronicsFilter = CacheHelper.getData(key: 'warrantyElectronics');
    //
    // print('filter result');
    // print('government id is $governmentId');
    // print('government name is $governmentNameFilter');
    //
    // print('city id $cityId');
    // print('city name $cityNameFilter');
    //
    // print('area id $areaId');
    // print('area name $areaNameFilter');
    //
    // print('statusUserFilter $statusUserFilter');
    // print('distanceKilometresFilter $distanceKilometresFilter');

    fromPriceController.text =
    widget.fromPrice == null ? '' : '${widget.fromPrice}';
    toPriceController.text = widget.toPrice == null ? '' : '${widget.toPrice}';

    fromAreaPropertiesController.text =
    widget.fromArea == null ? '' : '${widget.fromArea}';

    locationUserController.text =
    widget.locationUser == null ? '' : '${widget.locationUser}';
    toAreaPropertiesController.text =
    widget.toArea == null ? '' : '${widget.toArea}';

    fromDownPaymentController.text =
    widget.fromDownPayment == null ? '' : '${widget.fromDownPayment}';
    toDownPaymentController.text =
    widget.toDownPayment == null ? '' : '${widget.toDownPayment}';

    // widget.governmentName = governmentNameFilter == null ? widget.governmentName == null ? LocaleKeys.government.tr(): widget.governmentName : governmentNameFilter ;
    // widget.cityName = cityNameFilter == null ? widget.cityName == null ? LocaleKeys.city.tr(): widget.cityName : cityNameFilter ;
    // widget.areaName = areaNameFilter == null ? widget.areaName == null ? LocaleKeys.area.tr(): widget.areaName : areaNameFilter ;

    /// ConditionOptionAllCategory   // done
    optionsConditionElectronics = [
      LocaleKeys.newProd.tr(),
      LocaleKeys.used.tr()
    ];

    /// ConditionOptionFashion   // done
    optionsConditionFashion = [
      LocaleKeys.newProd.tr(),
      LocaleKeys.used.tr()
    ];

    /// ConditionOptionHomeFurniture   // done
    optionsConditionFurniture = [
      LocaleKeys.newProd.tr(),
      LocaleKeys.used.tr()
    ];

    /// ConditionOptionBusiness   // done
    optionsConditionTypeBusiness = [
      LocaleKeys.newProd.tr(),
      LocaleKeys.used.tr()
    ];

    /// ConditionOptionKids   // done
    optionsConditionTypeKids = [
      LocaleKeys.newProd.tr(),
      LocaleKeys.used.tr()
    ];

    /// ConditionOptionVehicles   // done
    optionsConditionVehicles = [
      LocaleKeys.newProd.tr(),
      LocaleKeys.used.tr()
    ];

    /// ConditionOptionBooks   // done
    optionsConditionBooks = [
      LocaleKeys.newProd.tr(),
      LocaleKeys.used.tr()
    ];
    // if (AppLocalStorage.language!.contains('en')) {
    //   optionsConditionAllCategory = ['New', 'Used'];
    //   print('language is ${AppLocalStorage.language}');
    // } else if (AppLocalStorage.language!.contains('ar')) {
    //   optionsConditionAllCategory = ['جديد', 'مستعمل'];
    //   print('language is ${AppLocalStorage.language}');
    // }

    ///////////////////////////////////////////////////////////////////////////////////


    /// Electronics  // done
    optionsWarrantyElectronics = [
      LocaleKeys.yes.tr(),
      LocaleKeys.no.tr()
    ];
    // if (AppLocalStorage.language!.contains('en')) {
    //   optionsWarrantyElectronics = ['yes', 'no'];
    //   print('language is ${AppLocalStorage.language}');
    // } else if (AppLocalStorage.language!.contains('ar')) {
    //   optionsWarrantyElectronics = ['نعم', 'لا'];
    //   print('language is ${AppLocalStorage.language}');
    // }
///////////////////////////////////////////////////////////////////////////////////
    /// Fashion     //  done
    optionsTypeFashion = [
      LocaleKeys.nightwear.tr(),
      LocaleKeys.weddingApparel.tr(),
      LocaleKeys.blouseTshirtsTops.tr(),
      LocaleKeys.swimwear.tr(),
      LocaleKeys.pulloverCoatsJackets.tr(),
      LocaleKeys.dresses.tr(),
      LocaleKeys.trousersLeggingsJeans.tr(),
    ];

    // if (AppLocalStorage.language!.contains('en')) {
    //   optionsTypeFashion = [
    //     'Nightwear',
    //     'Wedding Apparel',
    //     'Blouse - T-shirts - Tops',
    //     'Swimwear',
    //     'Pullover - Coats - Jackets',
    //     'Dresses',
    //     'Trousers - Leggings - Jeans'
    //   ];
    //   print('language is ${AppLocalStorage.language}');
    // } else if (AppLocalStorage.language!.contains('ar')) {
    //   optionsTypeFashion = [
    //     'ملابس نوم',
    //     'ملابس الزفاف',
    //     'بلوزة - تى شيرت - بلايز',
    //     'ملابس سباحة',
    //     'كنزة صوفية - معاطف - جاكيتات',
    //     'فساتين',
    //     'بنطلون - ليقنز - جينز'
    //   ];
    //   print('language is ${AppLocalStorage.language}');
    // }
///////////////////////////////////////////////////////////////////////////////////
    /// Home Furniture    // not done
    // optionsTypeHomeFurniture = [];
    optionsTypeHomeFurniture = [
      LocaleKeys.fullBathroom.tr(),
      LocaleKeys.sink.tr(),
      LocaleKeys.showerRoomTub.tr(),
      LocaleKeys.towels.tr(),
      LocaleKeys.toilet.tr(),
      LocaleKeys.waterMixersShowerHeads.tr(),
      LocaleKeys.mirrorsShelvesOtherAccessories.tr(),
    ];
    // if (AppLocalStorage.language!.contains('en')) {
    //   optionsTypeHomeFurniture = [
    //     LocaleKeys.fullBathroom.tr(),
    //     LocaleKeys.sink.tr(),
    //     LocaleKeys.showerRoomTub.tr(),
    //     LocaleKeys.towels.tr(),
    //     LocaleKeys.toilet.tr(),
    //     LocaleKeys.waterMixersShowerHeads.tr(),
    //     LocaleKeys.mirrorsShelvesOtherAccessories.tr(),
    //   ];
    //   print('language is ${AppLocalStorage.language}');
    // } else if (AppLocalStorage.language!.contains('ar')) {
    //   optionsTypeHomeFurniture = [
    //     'حمام كامل',
    //     'مكتب المدير',
    //     'غرفة الاستحمام حوض',
    //     'مناشف',
    //     'دوره المياه',
    //     'خلاطات مياه - رؤوس دوش',
    //     'مرايات - ارفف - اكسسوارات اخرى'
    //   ];
    //   print('language is ${AppLocalStorage.language}');
    // }
///////////////////////////////////////////////////////////////////////////////////

    /// Books   // done
    optionsTypeBooks = [
      LocaleKeys.antiques.tr(),
      LocaleKeys.oldCurrencies.tr(),
      LocaleKeys.pensWritingInstruments.tr(),
      LocaleKeys.collectibles.tr(),
      LocaleKeys.other.tr(),
    ];
    // if (AppLocalStorage.language!.contains('en')) {
    //   optionsTypeBooks = [
    //     'Antiques',
    //     'Art',
    //     'Old Currencies',
    //     'Pens & Writing instruments',
    //     'Collectibles',
    //     'Other'
    //   ];
    //   print('language is ${AppLocalStorage.language}');
    // } else if (AppLocalStorage.language!.contains('ar')) {
    //   optionsTypeBooks = [
    //     'التحف',
    //     'فن',
    //     'العملات القديمة',
    //     'أقلام وأدوات الكتابة',
    //     'المقتنيات',
    //     'اخري'
    //   ];
    //   print('language is ${AppLocalStorage.language}');
    // }
///////////////////////////////////////////////////////////////////////////////////
    /// Kids   //  done
    optionsTypeKids = [
      LocaleKeys.bathTub.tr(),
      LocaleKeys.diaper.tr(),
      LocaleKeys.siliconeNippleProtectors.tr(),
      LocaleKeys.sterilizerTools.tr(),
      LocaleKeys.toiletTrainingSeat.tr(),
      LocaleKeys.shampooSoaps.tr(),
      LocaleKeys.skincare.tr(),
      LocaleKeys.other.tr(),
    ];
    // if (AppLocalStorage.language!.contains('en')) {
    //   optionsTypeKids = [
    //     'Bath Tub',
    //     'Diaper',
    //     'Silicone Nipple Protectors',
    //     'Sterilizer Tools',
    //     'Toilet Training Seat',
    //     'Shampoo - Soaps',
    //     'Skincare',
    //     'Other'
    //   ];
    //   print('language is ${AppLocalStorage.language}');
    // } else if (AppLocalStorage.language!.contains('ar')) {
    //   optionsTypeKids = [
    //     'حوض الاستحمام',
    //     'حفاظات',
    //     'حماة حلمة سيليكون',
    //     'أدوات التعقيم',
    //     'مقعد تدريب على استعمال المرحاض',
    //     'شامبو - صابون',
    //     'عناية بالجلد',
    //     'اخري'
    //   ];
    //   print('language is ${AppLocalStorage.language}');
    // }
///////////////////////////////////////////////////////////////////////////////////
    /// Business  // done
    optionsTypeBusiness = [
      LocaleKeys.seeds.tr(),
      LocaleKeys.crops.tr(),
      LocaleKeys.farmMachinery.tr(),
      LocaleKeys.pesticides.tr(),
      LocaleKeys.other.tr(),
    ];
    // if (AppLocalStorage.language!.contains('en')) {
    //   optionsTypeBusiness = [
    //     'Seeds',
    //     'Crops',
    //     'Farm Machinery',
    //     'Pesticides',
    //     'Other'
    //   ];
    //   print('language is ${AppLocalStorage.language}');
    // } else if (AppLocalStorage.language!.contains('ar')) {
    //   optionsTypeBusiness = [
    //     'بذور',
    //     'المحاصيل',
    //     'الآلات الزراعية',
    //     'مبيدات حشرية',
    //     'اخري'
    //   ];
    //   print('language is ${AppLocalStorage.language}');
    // }
///////////////////////////////////////////////////////////////////////////////////
    /// Type Properties  // done
    optionsTypeProperties = [
      LocaleKeys.apartment.tr(),
      LocaleKeys.duplex.tr(),
      LocaleKeys.penthouse.tr(),
      LocaleKeys.studio.tr(),
    ];
    // if (AppLocalStorage.language!.contains('en')) {
    //   optionsTypeProperties = ['Apartment', 'Duplex', 'Penthouse', 'Studio'];
    //   print('language is ${AppLocalStorage.language}');
    // } else if (AppLocalStorage.language!.contains('ar')) {
    //   optionsTypeProperties = ['شقة', 'مزدوج', 'كنة', 'ستوديو'];
    //   print('language is ${AppLocalStorage.language}');
    // }

    /// Type Apartment Properties  /// done
    optionsTypeApartmentProperties = [
      LocaleKeys.finished.tr(),
      LocaleKeys.notFinished.tr(),
      LocaleKeys.coreShell.tr(),
      LocaleKeys.semiFinished.tr(),
    ];
    // if (AppLocalStorage.language!.contains('en')) {
    //   optionsTypeApartmentProperties = [
    //     'Finished',
    //     'Not finished',
    //     'Core & shell',
    //     'Semi finished'
    //   ];
    //   print('language is ${AppLocalStorage.language}');
    // } else if (AppLocalStorage.language!.contains('ar')) {
    //   optionsTypeApartmentProperties = [
    //     'تم الانتهاء',
    //     'لم ينتهي',
    //     'النواة والصدفة',
    //     'نصف تشطيب'
    //   ];
    //   print('language is ${AppLocalStorage.language}');
    // }

    /// Type Apartment Furnished Properties // done
    optionsTypeApartmentFurnishedProperties = [
      LocaleKeys.yes.tr(),
      LocaleKeys.no.tr(),
    ];
    // if (AppLocalStorage.language!.contains('en')) {
    //   optionsTypeApartmentFurnishedProperties = [
    //     'yes',
    //     'no',
    //   ];
    //   print('language is ${AppLocalStorage.language}');
    // } else if (AppLocalStorage.language!.contains('ar')) {
    //   optionsTypeApartmentFurnishedProperties = [
    //     'نعم',
    //     'لا',
    //   ];
    //   print('language is ${AppLocalStorage.language}');
    // }

    /// Type Amenities Properties
    optionsTypeAmenitiesProperties = [
      LocaleKeys.balcony.tr(),
      LocaleKeys.electricity.tr(),
      LocaleKeys.pool.tr(),
      LocaleKeys.petsAllowed.tr(),
      LocaleKeys.maidsRoom.tr(),
      LocaleKeys.coveredParking.tr(),
      LocaleKeys.security.tr(),
      LocaleKeys.central.tr(),
      LocaleKeys.privateGarden.tr(),
      LocaleKeys.builtkitchen.tr(),
    ];
    // if (AppLocalStorage.language!.contains('en')) {
    //   optionsTypeAmenitiesProperties = [
    //     'Balcony',
    //     'Electricity meter',
    //     'Pool',
    //     'Pets allowed',
    //     'Maids room',
    //     'Covered parking',
    //     'Security',
    //     'Central A/C & heating',
    //     'Private garden',
    //     'Built in kitchen appliances'
    //   ];
    //   print('language is ${AppLocalStorage.language}');
    // } else if (AppLocalStorage.language!.contains('ar')) {
    //   optionsTypeAmenitiesProperties = [
    //     'بلكونة',
    //     'عداد الكهرباء',
    //     'حمام سباحة',
    //     'مسموح بدخول الحيوانات الأليفة',
    //     'غرفة للخادمة',
    //     'مواقف مغطاة للسيارات',
    //     'حماية',
    //     'تدفئة وتكييف مركزي',
    //     'حديقة خاصة',
    //     'أجهزة المطبخ المدمجة'
    //   ];
    //   print('language is ${AppLocalStorage.language}');
    // }

    /// Type Bedroom Properties
    optionsBedroomProperties = [
      '1',
      '2',
      '3',
      '4',
      '5',
      '6',
      '7',
      '8',
      '9',
      '10',
      '+10',
    ];
    // if (AppLocalStorage.language!.contains('en')) {
    //   optionsBedroomProperties = [
    //     '1',
    //     '2',
    //     '3',
    //     '4',
    //     '5',
    //     '6',
    //     '7',
    //     '8',
    //     '9',
    //     '10',
    //     '+10'
    //   ];
    //   print('language is ${AppLocalStorage.language}');
    // } else if (AppLocalStorage.language!.contains('ar')) {
    //   optionsBedroomProperties = [
    //     '1',
    //     '2',
    //     '3',
    //     '4',
    //     '5',
    //     '6',
    //     '7',
    //     '8',
    //     '9',
    //     '10',
    //     '+10'
    //   ];
    //   print('language is ${AppLocalStorage.language}');
    // }

    /// Type bathRoom Properties
    optionsBathRoomProperties = [
      '1',
      '2',
      '3',
      '4',
      '5',
      '6',
      '7',
      '8',
      '9',
      '10',
      '+10',
    ];
    // if (AppLocalStorage.language!.contains('en')) {
    //   optionsBathRoomProperties = [
    //     '1',
    //     '2',
    //     '3',
    //     '4',
    //     '5',
    //     '6',
    //     '7',
    //     '8',
    //     '9',
    //     '10',
    //     '+10'
    //   ];
    //   print('language is ${AppLocalStorage.language}');
    // } else if (AppLocalStorage.language!.contains('ar')) {
    //   optionsBathRoomProperties = [
    //     '1',
    //     '2',
    //     '3',
    //     '4',
    //     '5',
    //     '6',
    //     '7',
    //     '8',
    //     '9',
    //     '10',
    //     '+10'
    //   ];
    //   print('language is ${AppLocalStorage.language}');
    // }

    /// Type Level Properties
    optionsLevelProperties = [
      '1',
      '2',
      '3',
      '4',
      '5',
      '6',
      '7',
      '8',
      '9',
      '10',
      '+10',
    ];
    // if (AppLocalStorage.language!.contains('en')) {
    //   optionsLevelProperties = [
    //     '1',
    //     '2',
    //     '3',
    //     '4',
    //     '5',
    //     '6',
    //     '7',
    //     '8',
    //     '9',
    //     '10',
    //     '+10'
    //   ];
    //   print('language is ${AppLocalStorage.language}');
    // } else if (AppLocalStorage.language!.contains('ar')) {
    //   optionsLevelProperties = [
    //     '1',
    //     '2',
    //     '3',
    //     '4',
    //     '5',
    //     '6',
    //     '7',
    //     '8',
    //     '9',
    //     '10',
    //     '+10'
    //   ];
    //   print('language is ${AppLocalStorage.language}');
    // }
    ///////////////////////////////////////////////////////////////////////////////////
    /// Fuel Type Vehicles
    optionsFuelTypeVehicles = [
      LocaleKeys.benzine.tr(),
      LocaleKeys.diesel.tr(),
      LocaleKeys.electricity.tr(),
      LocaleKeys.hypride.tr(),
      LocaleKeys.naturalGas.tr(),
    ];
    // if (AppLocalStorage.language!.contains('en')) {
    //   optionsFuelTypeVehicles = [
    //     'Benzine',
    //     'diesel',
    //     'Electricity meter',
    //     'Hypride',
    //     'Natural gas'
    //   ];
    //   print('language is ${AppLocalStorage.language}');
    // } else if (AppLocalStorage.language!.contains('ar')) {
    //   optionsFuelTypeVehicles = [
    //     'بنزين',
    //     'ديزل',
    //     'عداد الكهرباء',
    //     'هايبرايد',
    //     'غاز طبيعي'
    //   ];
    //   print('language is ${AppLocalStorage.language}');
    // }

    /// Transmission Type Vehicles
    optionsTransmissionTypeVehicles = [
      LocaleKeys.manual.tr(),
      LocaleKeys.automatic.tr(),
    ];
    // if (AppLocalStorage.language!.contains('en')) {
    //   optionsTransmissionTypeVehicles = ['Manual', 'Automatic'];
    //   print('language is ${AppLocalStorage.language}');
    // } else if (AppLocalStorage.language!.contains('ar')) {
    //   optionsTransmissionTypeVehicles = ['يدوي', 'تلقائي'];
    //   print('language is ${AppLocalStorage.language}');
    // }

    /// Color Vehicles
    optionsColorVehicles = [
      LocaleKeys.green.tr(),
      LocaleKeys.brown.tr(),
      LocaleKeys.blue.tr(),
      LocaleKeys.yellow.tr(),
      LocaleKeys.white.tr(),
      LocaleKeys.cohly.tr(),
      LocaleKeys.nebety.tr(),
      LocaleKeys.gary.tr(),
    ];
    // if (AppLocalStorage.language!.contains('en')) {
    //   optionsColorVehicles = [
    //     'Green',
    //     'Brown',
    //     'Blue',
    //     'Yellow',
    //     'White',
    //     'Dark blue',
    //     'burgundy',
    //     'Gary'
    //   ];
    //   print('language is ${AppLocalStorage.language}');
    // } else if (AppLocalStorage.language!.contains('ar')) {
    //   optionsColorVehicles = [
    //     'اخضر',
    //     'بني',
    //     'ازرق',
    //     'اصفر',
    //     'ابيض',
    //     'كحلي',
    //     'نبيتي',
    //     'رمادي'
    //   ];
    //   print('language is ${AppLocalStorage.language}');
    // }

    /// Body Type Vehicles
    optionsBodyTypeVehicles = [
      '4*4',
      LocaleKeys.cabriolet.tr(),
      LocaleKeys.coupe.tr(),
      LocaleKeys.hatchback.tr(),
      LocaleKeys.suv.tr(),
      LocaleKeys.sedan.tr(),
      LocaleKeys.vanBus.tr(),
      LocaleKeys.other.tr(),
    ];

    // if (AppLocalStorage.language!.contains('en')) {
    //   optionsBodyTypeVehicles = [
    //     '4*4',
    //     'Cabriolet',
    //     'Coupe',
    //     'Hatchback',
    //     'Pickup',
    //     'suv',
    //     'Sedan',
    //     'Van/bus',
    //     'Other',
    //   ];
    //   print('language is ${AppLocalStorage.language}');
    // } else if (AppLocalStorage.language!.contains('ar')) {
    //   optionsBodyTypeVehicles = [
    //     '4*4',
    //     'كابريوليه',
    //     'كوبيه',
    //     'هاتشباك',
    //     'يلتقط',
    //     'سيارات الدفع الرباعي',
    //     'سيدان',
    //     'شاحنة / حافلة',
    //     'اخري',
    //   ];
    //   print('language is ${AppLocalStorage.language}');
    // }

    /// Engine Capacity Vehicles
    optionsEngineCapacityVehicles = [
      '0 - 800',
      '1000 - 1300',
      '1400 - 1500',
      '1600',
      '1800 - 2000',
      '2200 - 2800',
      '30000 - 35000',
      '+35000'
    ];
    //   if (AppLocalStorage.language!.contains('en')) {
    //     optionsEngineCapacityVehicles = [
    //       '0 - 800',
    //       '1000 - 1300',
    //       '1400 - 1500',
    //       '1600',
    //       '1800 - 2000',
    //       '2200 - 2800',
    //       '30000 - 35000',
    //       '+35000'
    //     ];
    //     print('language is ${AppLocalStorage.language}');
    //   } else if (AppLocalStorage.language!.contains('ar')) {
    //     optionsEngineCapacityVehicles = [
    //       '0 - 800',
    //       '1000 - 1300',
    //       '1400 - 1500',
    //       '1600',
    //       '1800 - 2000',
    //       '2200 - 2800',
    //       '30000 - 35000',
    //       '+35000'
    //     ];
    //   }
    //   print('language is ${AppLocalStorage.language}');
    // }

  }

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
    return WillPopScope(

      onWillPop: () async{
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(
                builder: (context) =>  AppLayout()));
        return false;
      },
      child: Scaffold(
        // appBar: AppBar(
        //   backgroundColor: AppPalette.primary,
        //   title: Text(LocaleKeys.filter.tr(),style: TextStyle(color: AppPalette.white),),
        //   elevation: 0.0,
        //   leading: InkWell(
        //     onTap: () =>
        //         Navigator.of(context).pushAndRemoveUntil(
        //             MaterialPageRoute(
        //               builder: (context) => AppLayout(),
        //             ),
        //                 (route) => false),
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
                      onTap: ()=> navigateTo(context: context, widget: AppLayout()),
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
                  child: BlocBuilder<FilterCubit, FilterState>(
                    builder: (context, state) {
                      FilterCubit filterCubit = FilterCubit.get(context);
                      return Container(
                          padding: EdgeInsets.only(
                            top: Dimensions.paddingSizeDefault,
                            right: Dimensions.paddingSizeDefault,
                            left: Dimensions.paddingSizeDefault,
                          ),
                          child: Form(
                              key: _formKey,
                              child: BlocBuilder<AddProductCubit, AddProductState>(
                                  builder: ((context, addProductState) {
                                    AddProductCubit addProductController =
                                    AddProductCubit.get(context);
                                    return Column(
                                      children: [
                                        Expanded(
                                          child: ListView(
                                              shrinkWrap: true,
                                              physics: const ScrollPhysics(),
                                              children: [
                                                CustomButtonWidget(
                                                    title: filterCubit
                                                        .selectedMainCategory !=
                                                        null
                                                        ? context.locale.languageCode
                                                        .contains('en')
                                                        ? filterCubit
                                                        .selectedMainCategory!.name!.en!
                                                        : context.locale.languageCode
                                                        .contains('ar')
                                                        ? filterCubit
                                                        .selectedMainCategory!
                                                        .name!
                                                        .ar!
                                                        : context.locale.languageCode
                                                        .contains('tr')
                                                        ? filterCubit
                                                        .selectedMainCategory!
                                                        .name!
                                                        .tr!
                                                        : context
                                                        .locale.languageCode
                                                        .contains('de')
                                                        ? filterCubit
                                                        .selectedMainCategory!
                                                        .name!
                                                        .de!
                                                        : ''
                                                        : LocaleKeys.category.tr(),
                                                    onTap: () {
                                                      addProductController
                                                          .selectedBrand =
                                                      null;
                                                      Navigator.of(context)
                                                          .push(MaterialPageRoute(
                                                        builder: (context) =>
                                                            MainCategoryScreen(
                                                                governmentId: widget
                                                                    .governmentId,
                                                                governmentName: widget
                                                                    .governmentName,
                                                                cityId: widget.cityId,
                                                                cityName: widget.cityName,
                                                                areaId: widget.areaId,
                                                                areaName: widget.areaName,
                                                                nameProduct: '',
                                                                fromPrice: fromPriceController
                                                                    .text,
                                                                toPrice: toPriceController
                                                                    .text,
                                                              locationUser: locationUserController.text,),
                                                      ));
                                                    }),
                                                13.heightBox,
                                                // if (filterCubit.selectedMainCategory != null)
                                                CustomButtonWidget(
                                                    title: filterCubit
                                                        .selectedSubCategory !=
                                                        null
                                                        ? context.locale.languageCode
                                                        .contains('en')
                                                        ? filterCubit
                                                        .selectedSubCategory!.name!.en!
                                                        : context.locale.languageCode
                                                        .contains('ar')
                                                        ? filterCubit
                                                        .selectedSubCategory!
                                                        .name!
                                                        .ar!
                                                        : context.locale.languageCode
                                                        .contains('tr')
                                                        ? filterCubit
                                                        .selectedSubCategory!
                                                        .name!
                                                        .tr!
                                                        : context
                                                        .locale.languageCode
                                                        .contains('de')
                                                        ? filterCubit
                                                        .selectedSubCategory!
                                                        .name!
                                                        .de!
                                                        : ''
                                                        : LocaleKeys.subCategory.tr(),
                                                    onTap: () {
                                                      if (filterCubit.selectedMainCategory == null) {
                                                        AwesomeDialog(
                                                          context: context,
                                                          btnOkText: LocaleKeys.ok.tr(),
                                                          btnCancelText: LocaleKeys.cancel
                                                              .tr(),
                                                          dialogType: DialogType.ERROR,
                                                          animType: AnimType.RIGHSLIDE,
                                                          title: 'Error',
                                                          desc: LocaleKeys
                                                              .pleaseSelectMainCategoryFirst
                                                              .tr(),
                                                          btnCancelOnPress: () {},
                                                          btnOkOnPress: () {},
                                                        ).show();
                                                      }
                                                      else {
                                                        Navigator.of(context)
                                                            .push(MaterialPageRoute(
                                                          builder: (context) =>
                                                              SubCategoryScreen(
                                                                  governmentId: widget
                                                                      .governmentId,
                                                                  governmentName:
                                                                  widget.governmentName,
                                                                  fromPrice:
                                                                  fromPriceController
                                                                      .text,
                                                                  toPrice: toPriceController
                                                                      .text,
                                                                  cityId: widget.cityId,
                                                                  cityName: widget
                                                                      .cityName,
                                                                  areaId: widget.areaId,
                                                                  tokiloMetresType:
                                                                  widget
                                                                      .tokiloMetresType,
                                                                  fromkiloMetresType:
                                                                  widget
                                                                      .fromkiloMetresType,
                                                                  toDownPayment:
                                                                  toDownPaymentController
                                                                      .text,
                                                                  fromDownPayment:
                                                                  fromDownPaymentController
                                                                      .text,
                                                                  toArea: toAreaPropertiesController
                                                                      .text,
                                                                  fromArea:
                                                                  fromAreaPropertiesController
                                                                      .text,
                                                                  bedroom: widget
                                                                      .bedroom,
                                                                  bathroom: widget
                                                                      .bathroom,
                                                                  toYear: widget.toYear,
                                                                  fromYear: widget
                                                                      .fromYear,
                                                                  locationUser: locationUserController.text,
                                                                  amenitiesType:
                                                                  widget.amenitiesType,
                                                                  bodyType: widget
                                                                      .bodyType,
                                                                  colorType: widget
                                                                      .colorType,
                                                                  engineCapacityType:
                                                                  widget
                                                                      .engineCapacityType,
                                                                  fuelType: widget
                                                                      .fuelType,
                                                                  kiloMetresType:
                                                                  widget
                                                                      .fromkiloMetresType,
                                                                  levelType: widget
                                                                      .levelType,
                                                                  areaName: widget
                                                                      .areaName,
                                                                  nameProduct: '',
                                                                  category: filterCubit
                                                                      .selectedMainCategory!),
                                                        ));
                                                      }
                                                    }),
                                                // filterCubit.selectedSubCategory != null
                                                //  ? filterCubit.selectedSubCategory!.name!.contains('') ? Container() : Container()
                                                //  : LocaleKeys.subCategory.tr(),
                                                13.heightBox,
                                                // filterCubit.selectedMainCategory != null || filterCubit.selectedSubCategory != null ?
                                                Column(
                                                  children: [
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
                                                                              governmentId: widget
                                                                                  .governmentId,
                                                                              governmentName: widget
                                                                                  .governmentName,
                                                                              fromPrice:
                                                                              fromPriceController
                                                                                  .text,
                                                                              toPrice:
                                                                              toPriceController
                                                                                  .text,
                                                                              cityId:
                                                                              widget
                                                                                  .cityId,
                                                                              cityName: widget
                                                                                  .cityName,
                                                                              areaId:
                                                                              widget
                                                                                  .areaId,
                                                                              tokiloMetresType:
                                                                              widget
                                                                                  .tokiloMetresType,
                                                                              fromkiloMetresType:
                                                                              widget
                                                                                  .fromkiloMetresType,
                                                                              toDownPayment:
                                                                              toDownPaymentController
                                                                                  .text,
                                                                              fromDownPayment:
                                                                              fromDownPaymentController
                                                                                  .text,
                                                                              toArea:
                                                                              toAreaPropertiesController
                                                                                  .text,
                                                                              fromArea:
                                                                              fromAreaPropertiesController
                                                                                  .text,
                                                                              bedroom: widget
                                                                                  .bedroom,
                                                                              bathroom: widget
                                                                                  .bathroom,
                                                                              toYear:
                                                                              widget
                                                                                  .toYear,
                                                                              fromYear: widget
                                                                                  .fromYear,
                                                                              locationUser: locationUserController.text,
                                                                              amenitiesType: widget
                                                                                  .amenitiesType,
                                                                              bodyType: widget
                                                                                  .bodyType,
                                                                              colorType: widget
                                                                                  .colorType,
                                                                              engineCapacityType:
                                                                              widget
                                                                                  .engineCapacityType,
                                                                              fuelType: widget
                                                                                  .fuelType,
                                                                              kiloMetresType: widget
                                                                                  .fromkiloMetresType,
                                                                              levelType: widget
                                                                                  .levelType,
                                                                              data:
                                                                              'filterScreen',
                                                                              areaName: widget
                                                                                  .areaName,
                                                                              nameProduct: '',
                                                                              description: '',)
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
                                                                              governmentId: widget
                                                                                  .governmentId,
                                                                              governmentName: widget
                                                                                  .governmentName,
                                                                              fromPrice:
                                                                              fromPriceController
                                                                                  .text,
                                                                              toPrice:
                                                                              toPriceController
                                                                                  .text,
                                                                              cityId:
                                                                              widget
                                                                                  .cityId,
                                                                              cityName: widget
                                                                                  .cityName,
                                                                              areaId:
                                                                              widget
                                                                                  .areaId,
                                                                              tokiloMetresType:
                                                                              widget
                                                                                  .tokiloMetresType,
                                                                              fromkiloMetresType:
                                                                              widget
                                                                                  .fromkiloMetresType,
                                                                              toDownPayment:
                                                                              toDownPaymentController
                                                                                  .text,
                                                                              fromDownPayment:
                                                                              fromDownPaymentController
                                                                                  .text,
                                                                              toArea:
                                                                              toAreaPropertiesController
                                                                                  .text,
                                                                              fromArea:
                                                                              fromAreaPropertiesController
                                                                                  .text,
                                                                              bedroom: widget
                                                                                  .bedroom,
                                                                              bathroom: widget
                                                                                  .bathroom,
                                                                              toYear:
                                                                              widget
                                                                                  .toYear,
                                                                              fromYear: widget
                                                                                  .fromYear,
                                                                              locationUser: locationUserController.text,
                                                                              amenitiesType: widget
                                                                                  .amenitiesType,
                                                                              bodyType: widget
                                                                                  .bodyType,
                                                                              colorType: widget
                                                                                  .colorType,
                                                                              engineCapacityType:
                                                                              widget
                                                                                  .engineCapacityType,
                                                                              fuelType: widget
                                                                                  .fuelType,
                                                                              kiloMetresType: widget
                                                                                  .fromkiloMetresType,
                                                                              levelType: widget
                                                                                  .levelType,
                                                                              data:
                                                                              'filterScreen',
                                                                              areaName: widget
                                                                                  .areaName,
                                                                              nameProduct: '',
                                                                              description: '',),
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
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          child: InputTextFormField(
                                                            hintText: LocaleKeys
                                                                .fromPrice
                                                                .tr(),
                                                            textEditingController:
                                                            fromPriceController,
                                                            textInputType: TextInputType
                                                                .number,
                                                            // onChanged: (String? value){
                                                            //   setState(() {
                                                            //     widget.fromPrice = value;
                                                            //   });
                                                            // },
                                                            suffixIcon: Container(
                                                              padding: EdgeInsets.all(
                                                                Dimensions.paddingSize,
                                                              ),
                                                              child: Text(LocaleKeys
                                                                  .currencyPrice
                                                                  .tr()),
                                                            ),
                                                            validator: (val) {
                                                              if (val.isEmpty) {
                                                                return LocaleKeys
                                                                    .mustNotEmpty
                                                                    .tr();
                                                              }
                                                            },
                                                          ),
                                                        ),
                                                        5.widthBox,
                                                        Expanded(
                                                          child: InputTextFormField(
                                                            hintText: LocaleKeys.toPrice
                                                                .tr(),
                                                            textEditingController:
                                                            toPriceController,
                                                            textInputType: TextInputType
                                                                .number,
                                                            // onChanged: (String? value){
                                                            //   setState(() {
                                                            //     widget.toPrice = value;
                                                            //   });
                                                            // },
                                                            suffixIcon: Container(
                                                              padding: EdgeInsets.all(
                                                                Dimensions.paddingSize,
                                                              ),
                                                              child: Text(LocaleKeys
                                                                  .currencyPrice
                                                                  .tr()),
                                                            ),
                                                            validator: (val) {
                                                              if (val.isEmpty) {
                                                                return LocaleKeys
                                                                    .mustNotEmpty
                                                                    .tr();
                                                              }
                                                            },
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    15.heightBox,
                                                    Row(
                                                      children: [
                                                        Text(
                                                          LocaleKeys.distance
                                                              .tr(),
                                                          style: const TextStyle(
                                                              color: AppPalette
                                                                  .black,
                                                              fontWeight:
                                                              FontWeight
                                                                  .w500),
                                                        ),
                                                      ],
                                                    ),
                                                    10.heightBox,
                                                    Row(
                                                      children: [
                                                        Container(
                                                          decoration: BoxDecoration(
                                                            color: AppPalette.lightPrimary,
                                                            borderRadius: BorderRadius
                                                                .circular(
                                                                Dimensions.radiusDefault),
                                                          ),
                                                          child: DropdownButton<String>(
                                                            // Step 3.
                                                            value: dropdownValue,
                                                            // Step 4.
                                                            items: optionsDistanceLocation.
                                                            map<DropdownMenuItem<String>>((String value) {
                                                              return DropdownMenuItem<String>(
                                                                value: value,
                                                                child: Padding(
                                                                  padding: const EdgeInsets
                                                                      .all(10.0),
                                                                  child: Row(
                                                                    children: [
                                                                      Text(value,
                                                                        style: const TextStyle(
                                                                          fontSize: 15,),
                                                                      ),
                                                                      SizedBox(width: 5,),
                                                                      Text(LocaleKeys.kilometers.tr(),
                                                                        style: const TextStyle(
                                                                          fontSize: 15,),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              );
                                                            }).toList(),
                                                            // Step 5.
                                                            onChanged: (String? newValue) {
                                                              setState(() {
                                                                dropdownValue = newValue!;
                                                                print('dropdownValue');
                                                                print(dropdownValue);
                                                                print(newValue);
                                                                CacheHelper.saveData(key: 'dropdownValue',value: dropdownValue);
                                                                // if(dropdownValue != '0'){
                                                                //   if(widget.governmentName != null){
                                                                //     BlocProvider.of<FilterCubit>(context).getLocationWithMap(
                                                                //         '${widget.governmentName == null ? '' : widget.governmentName}',
                                                                //         '${widget.cityName == null ? '' : widget.cityName}',
                                                                //         '${widget.areaName == null ? '' : widget.areaName}');
                                                                //   }else {
                                                                //     return;
                                                                //   }
                                                                //
                                                                // }else {
                                                                //   return;
                                                                // }
                                                              });

                                                            },
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    15.heightBox,
                                                    ////// Properties
                                                    filterCubit.selectedMainCategory != null
                                                        ? filterCubit.selectedMainCategory!
                                                        .name!.en!.contains('Properties')
                                                        ? Column(
                                                      children: [
                                                        15.heightBox,
                                                        Column(
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  LocaleKeys.type
                                                                      .tr(),
                                                                  style: const TextStyle(
                                                                      color:
                                                                      AppPalette
                                                                          .black,
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                                ),
                                                              ],
                                                            ),
                                                            10.heightBox,
                                                            Container(
                                                              decoration:
                                                              BoxDecoration(
                                                                color: AppPalette
                                                                    .lightPrimary,
                                                                borderRadius: BorderRadius
                                                                    .circular(Dimensions
                                                                    .radiusDefault),
                                                              ),
                                                              child:
                                                              DropDownMultiSelect(
                                                                  options:
                                                                  optionsTypeProperties,
                                                                  whenEmpty: '',
                                                                  selectedValues:
                                                                  filterCubit
                                                                      .selectedOptionTypeProperties,
                                                                  onChanged:
                                                                      (value) {
                                                                    setState(() {
                                                                      filterCubit.selectedOptionTypeProperties = value;
                                                                      filterCubit.selectedOptionsValueTypeProperties = '';
                                                                      for (var element in filterCubit
                                                                          .selectedOptionTypeProperties) {
                                                                        if (filterCubit
                                                                            .selectedOptionsValueTypeProperties == '') {
                                                                          filterCubit.selectedOptionsValueTypeProperties =
                                                                              filterCubit.selectedOptionsValueTypeProperties +
                                                                                  '' + element;
                                                                        } else if (filterCubit.selectedOptionsValueTypeProperties != '') {
                                                                          filterCubit.selectedOptionsValueTypeProperties =
                                                                              filterCubit.selectedOptionsValueTypeProperties +
                                                                                  ',' + element;
                                                                        }
                                                                      }
                                                                    });
                                                                    // translator.translate('${filterCubit.selectedOptionsValueTypeProperties}', to: 'en')
                                                                    //     .then((result){
                                                                    //   print("Source: typeBusiness ${filterCubit.selectedOptionsValueTypeProperties}\nTranslated: $result");
                                                                    //   typePropertiesTranslate  = result.toString();
                                                                    //   print('Translated: kids $typePropertiesTranslate');
                                                                    //
                                                                    // });
                                                                  }),
                                                            ),
                                                            10.heightBox,
                                                          ],
                                                        ),
                                                        15.heightBox,
                                                        Row(
                                                          children: [
                                                            Text(
                                                                LocaleKeys.downPayment
                                                                    .tr(),
                                                                style: const TextStyle(
                                                                    fontSize: 13,
                                                                    color: AppPalette
                                                                        .black,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w500)),
                                                          ],
                                                        ),
                                                        10.heightBox,
                                                        InputTextFormField(
                                                          hintText: LocaleKeys.downPayment.tr(),
                                                          textEditingController: fromDownPaymentController,
                                                          textInputType: TextInputType.number,
                                                          suffixIcon: Container(
                                                            padding:
                                                            EdgeInsets.all(
                                                              Dimensions
                                                                  .paddingSize,
                                                            ),
                                                            child: Text(LocaleKeys
                                                                .currencyPrice
                                                                .tr()),
                                                          ),
                                                          validator: (val) {
                                                            // if (val.isEmpty) {
                                                            //   return "enter price";
                                                            // }
                                                          },
                                                        ),
                                                        15.heightBox,
                                                        Row(
                                                          children: [
                                                            Text(
                                                              LocaleKeys.amenities
                                                                  .tr(),
                                                              style: const TextStyle(
                                                                  color: AppPalette
                                                                      .black,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                            ),
                                                          ],
                                                        ),
                                                        10.heightBox,
                                                        Container(
                                                          decoration: BoxDecoration(
                                                            color: AppPalette
                                                                .lightPrimary,
                                                            borderRadius: BorderRadius
                                                                .circular(Dimensions
                                                                .radiusDefault),
                                                          ),
                                                          child: DropDownMultiSelect(
                                                              options:
                                                              optionsTypeAmenitiesProperties,
                                                              whenEmpty: '',
                                                              decoration: const InputDecoration(
                                                                  fillColor:
                                                                  AppPalette
                                                                      .primary,
                                                                  counterStyle: TextStyle(
                                                                      color: AppPalette
                                                                          .primary)),
                                                              selectedValues: filterCubit
                                                                  .selectedOptionAmenitiesProperties,
                                                              onChanged: (value) {
                                                                filterCubit
                                                                    .selectedOptionAmenitiesProperties =
                                                                    value;
                                                                filterCubit
                                                                    .selectedOptionsValueAmenitiesProperties =
                                                                '';
                                                                for (var element in filterCubit
                                                                    .selectedOptionAmenitiesProperties) {
                                                                  if (filterCubit
                                                                      .selectedOptionsValueAmenitiesProperties ==
                                                                      '') {
                                                                    filterCubit
                                                                        .selectedOptionsValueAmenitiesProperties =
                                                                        filterCubit
                                                                            .selectedOptionsValueAmenitiesProperties +
                                                                            '' + element;
                                                                  } else if (filterCubit
                                                                      .selectedOptionsValueAmenitiesProperties !=
                                                                      '') {
                                                                    filterCubit
                                                                        .selectedOptionsValueAmenitiesProperties =
                                                                        filterCubit
                                                                            .selectedOptionsValueAmenitiesProperties +
                                                                            ',' + element;
                                                                  }
                                                                }
                                                                // translator.translate('${filterCubit.selectedOptionsValueAmenitiesProperties}', to: 'en')
                                                                //     .then((result){
                                                                //   print("Source: typeBusiness ${filterCubit.selectedOptionsValueAmenitiesProperties}\nTranslated: $result");
                                                                //   amenitiesTypeTranslate  = result.toString();
                                                                //   print('Translated: kids $amenitiesTypeTranslate');
                                                                //
                                                                // });
                                                              }),
                                                        ),
                                                        15.heightBox,
                                                        Row(
                                                          children: [
                                                            Text(
                                                              LocaleKeys.bedroom.tr(),
                                                              style: const TextStyle(
                                                                  color: AppPalette
                                                                      .black,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                            ),
                                                          ],
                                                        ),
                                                        10.heightBox,
                                                        Container(
                                                          decoration: BoxDecoration(
                                                            color: AppPalette
                                                                .lightPrimary,
                                                            borderRadius: BorderRadius
                                                                .circular(Dimensions
                                                                .radiusDefault),
                                                          ),
                                                          child: DropDownMultiSelect(
                                                              options:
                                                              optionsBedroomProperties,
                                                              whenEmpty: '',
                                                              decoration: const InputDecoration(
                                                                  fillColor:
                                                                  AppPalette
                                                                      .primary,
                                                                  counterStyle: TextStyle(
                                                                      color: AppPalette
                                                                          .primary)),
                                                              selectedValues: filterCubit
                                                                  .selectedOptionBedroomProperties,
                                                              onChanged: (value) {
                                                                setState(() {
                                                                  filterCubit
                                                                      .selectedOptionBedroomProperties =
                                                                      value;
                                                                  filterCubit
                                                                      .selectedOptionsValueBedroomProperties =
                                                                  '';
                                                                  for (var element in filterCubit
                                                                      .selectedOptionBedroomProperties) {
                                                                    if (filterCubit
                                                                        .selectedOptionsValueBedroomProperties ==
                                                                        '') {
                                                                      filterCubit
                                                                          .selectedOptionsValueBedroomProperties =
                                                                          filterCubit
                                                                              .selectedOptionsValueBedroomProperties +
                                                                              '' +
                                                                              element;
                                                                    } else if (filterCubit
                                                                        .selectedOptionsValueBedroomProperties !=
                                                                        '') {
                                                                      filterCubit
                                                                          .selectedOptionsValueBedroomProperties =
                                                                          filterCubit
                                                                              .selectedOptionsValueBedroomProperties +
                                                                              ',' +
                                                                              element;
                                                                    }
                                                                  }
                                                                });
                                                              }),
                                                        ),
                                                        15.heightBox,
                                                        Row(
                                                          children: [
                                                            Text(
                                                              LocaleKeys.bathroom
                                                                  .tr(),
                                                              style: const TextStyle(
                                                                  color: AppPalette
                                                                      .black,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                            ),
                                                          ],
                                                        ),
                                                        10.heightBox,
                                                        Container(
                                                          decoration: BoxDecoration(
                                                            color: AppPalette
                                                                .lightPrimary,
                                                            borderRadius: BorderRadius
                                                                .circular(Dimensions
                                                                .radiusDefault),
                                                          ),
                                                          child: DropDownMultiSelect(
                                                              options:
                                                              optionsBathRoomProperties,
                                                              whenEmpty: '',
                                                              decoration: const InputDecoration(
                                                                  fillColor:
                                                                  AppPalette
                                                                      .primary,
                                                                  counterStyle: TextStyle(
                                                                      color: AppPalette
                                                                          .primary)),
                                                              selectedValues: filterCubit
                                                                  .selectedOptionBathRoomProperties,
                                                              onChanged: (value) {
                                                                setState(() {
                                                                  filterCubit
                                                                      .selectedOptionBathRoomProperties =
                                                                      value;
                                                                  filterCubit
                                                                      .selectedOptionsValueBathRoomProperties =
                                                                  '';
                                                                  for (var element in filterCubit
                                                                      .selectedOptionBathRoomProperties) {
                                                                    if (filterCubit
                                                                        .selectedOptionsValueBathRoomProperties ==
                                                                        '') {
                                                                      filterCubit
                                                                          .selectedOptionsValueBathRoomProperties =
                                                                          filterCubit
                                                                              .selectedOptionsValueBathRoomProperties +
                                                                              '' +
                                                                              element;
                                                                    } else if (filterCubit
                                                                        .selectedOptionsValueBathRoomProperties !=
                                                                        '') {
                                                                      filterCubit
                                                                          .selectedOptionsValueBathRoomProperties =
                                                                          filterCubit
                                                                              .selectedOptionsValueBathRoomProperties +
                                                                              ',' +
                                                                              element;
                                                                    }
                                                                  }
                                                                });
                                                              }),
                                                        ),
                                                        15.heightBox,
                                                        Row(
                                                          children: [
                                                            Text(LocaleKeys.area.tr(),
                                                                style: const TextStyle(
                                                                    fontSize: 13,
                                                                    color: AppPalette
                                                                        .black,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w500)),
                                                          ],
                                                        ),
                                                        10.heightBox,
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                              child:
                                                              InputTextFormField(
                                                                hintText: LocaleKeys
                                                                    .from
                                                                    .tr(),
                                                                textEditingController:
                                                                fromAreaPropertiesController,
                                                                textInputType:
                                                                TextInputType
                                                                    .number,
                                                                suffixIcon: Container(
                                                                  padding:
                                                                  EdgeInsets.all(
                                                                    Dimensions
                                                                        .paddingSize,
                                                                  ),
                                                                  child: const Text(
                                                                      '(m²)',
                                                                      style: TextStyle(
                                                                          color: AppPalette
                                                                              .black,
                                                                          fontWeight:
                                                                          FontWeight
                                                                              .w500)),
                                                                ),
                                                                validator: (val) {
                                                                  // if (val.isEmpty) {
                                                                  //   return "enter price";
                                                                  // }
                                                                },
                                                              ),
                                                            ),
                                                            5.widthBox,
                                                            Expanded(
                                                              child:
                                                              InputTextFormField(
                                                                hintText: LocaleKeys
                                                                    .to
                                                                    .tr(),
                                                                textEditingController:
                                                                toAreaPropertiesController,
                                                                textInputType:
                                                                TextInputType
                                                                    .number,
                                                                suffixIcon: Container(
                                                                  padding:
                                                                  EdgeInsets.all(
                                                                    Dimensions
                                                                        .paddingSize,
                                                                  ),
                                                                  child: const Text(
                                                                      '(m²)',
                                                                      style: TextStyle(
                                                                          color: AppPalette
                                                                              .black,
                                                                          fontWeight:
                                                                          FontWeight
                                                                              .w500)),
                                                                ),
                                                                validator: (val) {
                                                                  // if (val.isEmpty) {
                                                                  //   return "enter price";
                                                                  // }
                                                                },
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        15.heightBox,
                                                        Row(
                                                          children: [
                                                            Text(
                                                              LocaleKeys.level.tr(),
                                                              style: const TextStyle(
                                                                  color: AppPalette
                                                                      .black,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                            ),
                                                          ],
                                                        ),
                                                        10.heightBox,
                                                        Container(
                                                          decoration: BoxDecoration(
                                                            color: AppPalette
                                                                .lightPrimary,
                                                            borderRadius: BorderRadius
                                                                .circular(Dimensions
                                                                .radiusDefault),
                                                          ),
                                                          child: DropDownMultiSelect(
                                                              options:
                                                              optionsLevelProperties,
                                                              whenEmpty: '',
                                                              decoration: const InputDecoration(
                                                                  fillColor: AppPalette
                                                                      .primary,
                                                                  counterStyle: TextStyle(
                                                                      color: AppPalette
                                                                          .primary)),
                                                              selectedValues: filterCubit
                                                                  .selectedOptionLevelProperties,
                                                              onChanged: (value) {
                                                                setState(() {
                                                                  filterCubit
                                                                      .selectedOptionLevelProperties =
                                                                      value;
                                                                  filterCubit
                                                                      .selectedOptionsValueLevelProperties =
                                                                  '';
                                                                  for (var element in filterCubit
                                                                      .selectedOptionLevelProperties) {
                                                                    if (filterCubit
                                                                        .selectedOptionsValueLevelProperties ==
                                                                        '') {
                                                                      filterCubit
                                                                          .selectedOptionsValueLevelProperties =
                                                                          filterCubit
                                                                              .selectedOptionsValueLevelProperties +
                                                                              '' +
                                                                              element;
                                                                    } else if (filterCubit
                                                                        .selectedOptionsValueLevelProperties !=
                                                                        '') {
                                                                      filterCubit
                                                                          .selectedOptionsValueLevelProperties =
                                                                          filterCubit
                                                                              .selectedOptionsValueLevelProperties +
                                                                              ',' +
                                                                              element;
                                                                    }
                                                                  }
                                                                });
                                                              }),
                                                        ),
                                                        15.heightBox,
                                                        Column(
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Text(
                                                                    LocaleKeys.furnished
                                                                        .tr(),
                                                                    style: const TextStyle(
                                                                        color:
                                                                        AppPalette
                                                                            .black,
                                                                        fontWeight:
                                                                        FontWeight
                                                                            .w500)),
                                                              ],
                                                            ),
                                                            10.heightBox,
                                                            Container(
                                                              decoration:
                                                              BoxDecoration(
                                                                color: AppPalette
                                                                    .lightPrimary,
                                                                borderRadius: BorderRadius
                                                                    .circular(Dimensions
                                                                    .radiusDefault),
                                                              ),
                                                              child:
                                                              DropDownMultiSelect(
                                                                  options:
                                                                  optionsTypeApartmentFurnishedProperties,
                                                                  whenEmpty: '',
                                                                  decoration: const InputDecoration(
                                                                      fillColor:
                                                                      AppPalette
                                                                          .primary,
                                                                      counterStyle:
                                                                      TextStyle(
                                                                          color: AppPalette
                                                                              .primary)),
                                                                  selectedValues:
                                                                  filterCubit
                                                                      .selectedOptionFurnishedProperties,
                                                                  onChanged:
                                                                      (value) {
                                                                    filterCubit
                                                                        .selectedOptionFurnishedProperties =
                                                                        value;
                                                                    filterCubit
                                                                        .selectedOptionsValueFurnishedProperties =
                                                                    '';
                                                                    for (var element in filterCubit
                                                                        .selectedOptionFurnishedProperties) {
                                                                      if (filterCubit
                                                                          .selectedOptionsValueFurnishedProperties ==
                                                                          '') {
                                                                        filterCubit
                                                                            .selectedOptionsValueFurnishedProperties =
                                                                            filterCubit
                                                                                .selectedOptionsValueFurnishedProperties +
                                                                                '' +
                                                                                element;
                                                                      } else
                                                                      if (filterCubit
                                                                          .selectedOptionsValueFurnishedProperties !=
                                                                          '') {
                                                                        filterCubit
                                                                            .selectedOptionsValueFurnishedProperties =
                                                                            filterCubit
                                                                                .selectedOptionsValueFurnishedProperties +
                                                                                ',' +
                                                                                element;
                                                                      }
                                                                    }
                                                                    // translator.translate('${filterCubit.selectedOptionsValueFurnishedProperties}', to: 'en')
                                                                    //     .then((result){
                                                                    //   print("Source: typeBusiness ${filterCubit.selectedOptionsValueFurnishedProperties}\nTranslated: $result");
                                                                    //   furnishedPropertiesTranslate  = result.toString();
                                                                    //   print('Translated: kids $furnishedPropertiesTranslate');
                                                                    //
                                                                    // });
                                                                  }),
                                                            ),
                                                            10.heightBox,
                                                          ],
                                                        ),
                                                        15.heightBox,
                                                        Column(
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Text(
                                                                    LocaleKeys.status
                                                                        .tr(),
                                                                    style: const TextStyle(
                                                                        color:
                                                                        AppPalette
                                                                            .black,
                                                                        fontWeight:
                                                                        FontWeight
                                                                            .w500)),
                                                              ],
                                                            ),
                                                            10.heightBox,
                                                            Container(
                                                              decoration:
                                                              BoxDecoration(
                                                                color: AppPalette
                                                                    .lightPrimary,
                                                                borderRadius: BorderRadius
                                                                    .circular(Dimensions
                                                                    .radiusDefault),
                                                              ),
                                                              child:
                                                              DropDownMultiSelect(
                                                                  options:
                                                                  optionsTypeApartmentProperties,
                                                                  whenEmpty: '',
                                                                  decoration: const InputDecoration(
                                                                      fillColor:
                                                                      AppPalette
                                                                          .primary,
                                                                      counterStyle:
                                                                      TextStyle(
                                                                          color: AppPalette
                                                                              .primary)),
                                                                  selectedValues:
                                                                  filterCubit
                                                                      .selectedOptionTypeApartmentProperties,
                                                                  onChanged:
                                                                      (value) {
                                                                    filterCubit
                                                                        .selectedOptionTypeApartmentProperties =
                                                                        value;
                                                                    filterCubit
                                                                        .selectedOptionsValueTypeApartmentProperties =
                                                                    '';
                                                                    for (var element in filterCubit
                                                                        .selectedOptionTypeApartmentProperties) {
                                                                      if (filterCubit
                                                                          .selectedOptionsValueTypeApartmentProperties ==
                                                                          '') {
                                                                        filterCubit
                                                                            .selectedOptionsValueTypeApartmentProperties =
                                                                            filterCubit
                                                                                .selectedOptionsValueTypeApartmentProperties +
                                                                                '' +
                                                                                element;
                                                                      } else
                                                                      if (filterCubit
                                                                          .selectedOptionsValueTypeApartmentProperties !=
                                                                          '') {
                                                                        filterCubit
                                                                            .selectedOptionsValueTypeApartmentProperties =
                                                                            filterCubit
                                                                                .selectedOptionsValueTypeApartmentProperties +
                                                                                ',' +
                                                                                element;
                                                                      }
                                                                    }
                                                                    // translator.translate('${filterCubit.selectedOptionsValueTypeApartmentProperties}', to: 'en')
                                                                    //     .then((result){
                                                                    //   print("Source: typeBusiness ${filterCubit.selectedOptionsValueTypeApartmentProperties}\nTranslated: $result");
                                                                    //   typeApartmentTranslate  = result.toString();
                                                                    //   print('Translated: kids $typeApartmentTranslate');
                                                                    //
                                                                    // });
                                                                  }),
                                                            ),
                                                            10.heightBox,
                                                          ],
                                                        )
                                                      ],
                                                    )
                                                        : Container()
                                                        : Container(),
                                                    ////// Home Furniture
                                                    filterCubit.selectedMainCategory != null ?
                                                    filterCubit.selectedMainCategory!.name!.en!.contains('Home Furniture')
                                                        ? Column(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Text(
                                                                LocaleKeys.condition
                                                                    .tr(),
                                                                style: const TextStyle(
                                                                    color: AppPalette
                                                                        .black,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w500)),
                                                          ],
                                                        ),
                                                        10.heightBox,
                                                        Container(
                                                          decoration: BoxDecoration(
                                                            color: AppPalette
                                                                .lightPrimary,
                                                            borderRadius: BorderRadius
                                                                .circular(Dimensions
                                                                .radiusDefault),
                                                          ),
                                                          child: DropDownMultiSelect(
                                                              options:
                                                              optionsConditionFurniture,
                                                              whenEmpty: '',
                                                              decoration: const InputDecoration(
                                                                  fillColor:
                                                                  AppPalette
                                                                      .primary,
                                                                  counterStyle: TextStyle(
                                                                      color: AppPalette
                                                                          .primary)),
                                                              selectedValues: filterCubit
                                                                  .selectedOptionConditionHomeFurniture,
                                                              onChanged: (value) {
                                                                setState(() {
                                                                  filterCubit
                                                                      .selectedOptionConditionHomeFurniture =
                                                                      value;
                                                                  filterCubit
                                                                      .selectedOptionsValueConditionHomeFurniture =
                                                                  '';
                                                                  for (var element in filterCubit
                                                                      .selectedOptionConditionHomeFurniture) {
                                                                    if (filterCubit
                                                                        .selectedOptionsValueConditionHomeFurniture ==
                                                                        '') {
                                                                      filterCubit
                                                                          .selectedOptionsValueConditionHomeFurniture =
                                                                          filterCubit
                                                                              .selectedOptionsValueConditionHomeFurniture +
                                                                              '' +
                                                                              element;
                                                                    } else if (filterCubit
                                                                        .selectedOptionsValueConditionHomeFurniture !=
                                                                        '') {
                                                                      filterCubit
                                                                          .selectedOptionsValueConditionHomeFurniture =
                                                                          filterCubit
                                                                              .selectedOptionsValueConditionHomeFurniture +
                                                                              ',' +
                                                                              element;
                                                                    }
                                                                  }
                                                                });
                                                              }),
                                                        ),
                                                        15.heightBox,
                                                        Row(
                                                          children: [
                                                            Text(
                                                              LocaleKeys.type.tr(),
                                                              style: const TextStyle(
                                                                  color: AppPalette
                                                                      .black,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                            ),
                                                          ],
                                                        ),
                                                        10.heightBox,
                                                        Container(
                                                          decoration: BoxDecoration(
                                                            color: AppPalette
                                                                .lightPrimary,
                                                            borderRadius: BorderRadius
                                                                .circular(Dimensions
                                                                .radiusDefault),
                                                          ),
                                                          child: DropDownMultiSelect(
                                                              options:
                                                              optionsTypeHomeFurniture,
                                                              whenEmpty: '',
                                                              decoration: const InputDecoration(
                                                                  fillColor:
                                                                  AppPalette
                                                                      .primary,
                                                                  counterStyle: TextStyle(
                                                                      color: AppPalette
                                                                          .primary)),
                                                              selectedValues: filterCubit
                                                                  .selectedOptionHomeFurniture,
                                                              onChanged: (value) {
                                                                filterCubit
                                                                    .selectedOptionHomeFurniture =
                                                                    value;
                                                                filterCubit
                                                                    .selectedOptionsValueHomeFurniture =
                                                                '';
                                                                for (var element in filterCubit
                                                                    .selectedOptionHomeFurniture) {
                                                                  if (filterCubit
                                                                      .selectedOptionsValueHomeFurniture ==
                                                                      '') {
                                                                    filterCubit
                                                                        .selectedOptionsValueHomeFurniture =
                                                                        filterCubit
                                                                            .selectedOptionsValueHomeFurniture +
                                                                            '' +
                                                                            element;
                                                                  } else if (filterCubit
                                                                      .selectedOptionsValueHomeFurniture !=
                                                                      '') {
                                                                    filterCubit
                                                                        .selectedOptionsValueHomeFurniture =
                                                                        filterCubit
                                                                            .selectedOptionsValueHomeFurniture +
                                                                            ',' +
                                                                            element;
                                                                  }
                                                                }
                                                                // translator.translate('${filterCubit.selectedOptionsValueHomeFurniture}', to: 'en')
                                                                //     .then((result){
                                                                //   print("Source: typeBusiness ${filterCubit.selectedOptionsValueHomeFurniture}\nTranslated: $result");
                                                                //   typeHomeFurnitureTranslate  = result.toString();
                                                                //   print('Translated: kids $typeHomeFurnitureTranslate');
                                                                //
                                                                // });
                                                              }),
                                                        ),
                                                        10.heightBox
                                                      ],
                                                    )
                                                        : Container()
                                                        : Container(),
                                                    ////// Home Fashion
                                                    filterCubit.selectedMainCategory !=
                                                        null
                                                        ? filterCubit
                                                        .selectedMainCategory!.name!.en!
                                                        .contains('Fashion')
                                                        ? Column(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Text(
                                                              LocaleKeys.condition
                                                                  .tr(),
                                                              style: const TextStyle(
                                                                  color: AppPalette
                                                                      .black,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                            ),
                                                          ],
                                                        ),
                                                        10.heightBox,
                                                        Container(
                                                          decoration: BoxDecoration(
                                                            color: AppPalette
                                                                .lightPrimary,
                                                            borderRadius: BorderRadius
                                                                .circular(Dimensions
                                                                .radiusDefault),
                                                          ),
                                                          child: DropDownMultiSelect(
                                                              options: optionsConditionFashion,
                                                              whenEmpty: '',
                                                              selectedValues: filterCubit.selectedOptionConditionFashion,
                                                              onChanged: (value) {
                                                                setState(() {

                                                                  filterCubit.selectedOptionConditionFashion = value;

                                                                  for (var element in filterCubit.selectedOptionConditionFashion) {

                                                                    if (filterCubit.selectedOptionsValueConditionFashion == '') {
                                                                      filterCubit
                                                                          .selectedOptionsValueConditionFashion =
                                                                          filterCubit
                                                                              .selectedOptionsValueConditionFashion +
                                                                              '' +
                                                                              element;
                                                                    } else if (filterCubit
                                                                        .selectedOptionsValueConditionFashion !=
                                                                        '') {
                                                                      filterCubit
                                                                          .selectedOptionsValueConditionFashion =
                                                                          filterCubit
                                                                              .selectedOptionsValueConditionFashion +
                                                                              ',' +
                                                                              element;
                                                                    }
                                                                  }

                                                                });
                                                              }),
                                                        ),
                                                        15.heightBox,
                                                        Row(
                                                          children: [
                                                            Text(
                                                              LocaleKeys.type.tr(),
                                                              style: const TextStyle(
                                                                  color: AppPalette
                                                                      .black,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                            ),
                                                          ],
                                                        ),
                                                        10.heightBox,
                                                        Container(
                                                          decoration: BoxDecoration(
                                                            color: AppPalette
                                                                .lightPrimary,
                                                            borderRadius: BorderRadius
                                                                .circular(Dimensions
                                                                .radiusDefault),
                                                          ),
                                                          child: DropDownMultiSelect(
                                                              options:
                                                              optionsTypeFashion,
                                                              whenEmpty: '',
                                                              decoration: const InputDecoration(
                                                                  fillColor:
                                                                  AppPalette
                                                                      .primary,
                                                                  counterStyle: TextStyle(
                                                                      color: AppPalette
                                                                          .primary)),
                                                              selectedValues: filterCubit
                                                                  .selectedOptionFashion,
                                                              onChanged: (value) {
                                                                filterCubit.selectedOptionFashion = value;
                                                                filterCubit.selectedOptionsValueFashion = '';
                                                                for (var element in filterCubit
                                                                    .selectedOptionFashion) {
                                                                  if (filterCubit
                                                                      .selectedOptionsValueFashion ==
                                                                      '') {
                                                                    filterCubit
                                                                        .selectedOptionsValueFashion =
                                                                        filterCubit
                                                                            .selectedOptionsValueFashion +
                                                                            '' +
                                                                            element;
                                                                  } else if (filterCubit
                                                                      .selectedOptionsValueFashion !=
                                                                      '') {
                                                                    filterCubit
                                                                        .selectedOptionsValueFashion =
                                                                        filterCubit
                                                                            .selectedOptionsValueFashion +
                                                                            ',' +
                                                                            element;
                                                                  }
                                                                }
                                                                // translator
                                                                //     .translate('${filterCubit.selectedOptionsValueFashion}', to: 'en')
                                                                //     .then((result){
                                                                //   print("Source: typeBusiness ${filterCubit.selectedOptionsValueFashion}\nTranslated: $result");
                                                                //   typeFashionTranslate  = result.toString();
                                                                //   print('Translated: kids $kidsTranslate');
                                                                //
                                                                // });
                                                              }),
                                                        ),
                                                        10.heightBox,
                                                      ],
                                                    )
                                                        : Container()
                                                        : Container(),
                                                    ////// Kids & Babies
                                                    filterCubit.selectedMainCategory !=
                                                        null
                                                        ? filterCubit
                                                        .selectedMainCategory!.name!.en!
                                                        .contains('Kids & Babies')
                                                        ? Column(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Text(
                                                              LocaleKeys.condition
                                                                  .tr(),
                                                              style: const TextStyle(
                                                                  color: AppPalette
                                                                      .black,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                            ),
                                                          ],
                                                        ),
                                                        10.heightBox,
                                                        Container(
                                                          decoration: BoxDecoration(
                                                            color: AppPalette
                                                                .lightPrimary,
                                                            borderRadius: BorderRadius
                                                                .circular(Dimensions
                                                                .radiusDefault),
                                                          ),
                                                          child: DropDownMultiSelect(
                                                              options: optionsConditionTypeKids,
                                                              whenEmpty: '',
                                                              selectedValues: filterCubit.selectedOptionConditionKids,
                                                              onChanged: (value) {
                                                                setState(() {

                                                                  filterCubit.selectedOptionConditionKids = value;

                                                                  for (var element in filterCubit.selectedOptionConditionKids) {

                                                                    if (filterCubit.selectedOptionsValueConditionKids == '') {
                                                                      filterCubit
                                                                          .selectedOptionsValueConditionKids =
                                                                          filterCubit
                                                                              .selectedOptionsValueConditionKids +
                                                                              '' +
                                                                              element;
                                                                    } else if (filterCubit
                                                                        .selectedOptionsValueConditionKids !=
                                                                        '') {
                                                                      filterCubit
                                                                          .selectedOptionsValueConditionKids =
                                                                          filterCubit
                                                                              .selectedOptionsValueConditionKids +
                                                                              ',' +
                                                                              element;
                                                                    }
                                                                  }

                                                                });
                                                              }),
                                                        ),
                                                        15.heightBox,
                                                        Row(
                                                          children: [
                                                            Text(
                                                              LocaleKeys.type.tr(),
                                                              style: const TextStyle(
                                                                  color: AppPalette
                                                                      .black,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                            ),
                                                          ],
                                                        ),
                                                        10.heightBox,
                                                        Container(
                                                          decoration: BoxDecoration(
                                                            color: AppPalette
                                                                .lightPrimary,
                                                            borderRadius: BorderRadius
                                                                .circular(Dimensions
                                                                .radiusDefault),
                                                          ),
                                                          child: DropDownMultiSelect(
                                                              options:
                                                              optionsTypeKids,
                                                              whenEmpty: '',
                                                              decoration: const InputDecoration(
                                                                  fillColor:
                                                                  AppPalette
                                                                      .primary,
                                                                  counterStyle: TextStyle(
                                                                      color: AppPalette
                                                                          .primary)),
                                                              selectedValues: filterCubit
                                                                  .selectedOptionKids,
                                                              onChanged: (value)  async{

                                                                filterCubit
                                                                    .selectedOptionKids =
                                                                    value;
                                                                filterCubit
                                                                    .selectedOptionsValueKids =
                                                                '';

                                                                for (var element in filterCubit.selectedOptionKids) {
                                                                  if (filterCubit.selectedOptionsValueKids == '') {
                                                                    filterCubit.selectedOptionsValueKids =
                                                                        filterCubit.selectedOptionsValueKids + '' + element;
                                                                    //   print('Translated: kids ${await filterCubit.selectedOptionsValueKids.translate(to: 'en')}');
                                                                  } else if (filterCubit.selectedOptionsValueKids != '') {
                                                                    //  print('Translated: kids  ${await filterCubit.selectedOptionsValueKids.translate(to: 'en')}');
                                                                    filterCubit
                                                                        .selectedOptionsValueKids =
                                                                        filterCubit
                                                                            .selectedOptionsValueKids +
                                                                            ',' +
                                                                            element;
                                                                  }
                                                                }
                                                                // translator
                                                                //     .translate('${filterCubit.selectedOptionsValueKids}', to: 'en')
                                                                //     .then((result){
                                                                //   print("Source: typeKidsss ${filterCubit.selectedOptionsValueKids}\nTranslated: $result");
                                                                //   kidsTranslate  = result.toString();
                                                                //   print('Translated: Source: typeKidsss $kidsTranslate');
                                                                //
                                                                // });
                                                              }),
                                                        ),
                                                        10.heightBox,
                                                      ],
                                                    )
                                                        : Container()
                                                        : Container(),
                                                    ////// Books, Sports & Hobbies Category
                                                    filterCubit.selectedMainCategory !=
                                                        null
                                                        ? filterCubit
                                                        .selectedMainCategory!.name!.en!
                                                        .contains(
                                                        'Books, Sports & Hobbies')
                                                        ? Column(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Text(
                                                              LocaleKeys.condition
                                                                  .tr(),
                                                              style: const TextStyle(
                                                                  color: AppPalette
                                                                      .black,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                            ),
                                                          ],
                                                        ),
                                                        10.heightBox,
                                                        Container(
                                                          decoration: BoxDecoration(
                                                            color: AppPalette
                                                                .lightPrimary,
                                                            borderRadius: BorderRadius
                                                                .circular(Dimensions
                                                                .radiusDefault),
                                                          ),
                                                          child: DropDownMultiSelect(
                                                              options: optionsConditionBooks,
                                                              whenEmpty: '',
                                                              selectedValues: filterCubit.selectedOptionBooks,
                                                              onChanged: (value) {
                                                                setState(() {

                                                                  filterCubit.selectedOptionBooks = value;

                                                                  for (var element in filterCubit.selectedOptionBooks) {

                                                                    if (filterCubit.selectedOptionsValueConditionBooks == '') {
                                                                      filterCubit
                                                                          .selectedOptionsValueConditionBooks =
                                                                          filterCubit
                                                                              .selectedOptionsValueConditionBooks +
                                                                              '' +
                                                                              element;
                                                                    } else if (filterCubit
                                                                        .selectedOptionsValueConditionBooks !=
                                                                        '') {
                                                                      filterCubit
                                                                          .selectedOptionsValueConditionBooks =
                                                                          filterCubit
                                                                              .selectedOptionsValueConditionBooks +
                                                                              ',' +
                                                                              element;
                                                                    }
                                                                  }

                                                                });
                                                              }),
                                                        ),
                                                        15.heightBox,
                                                        Row(
                                                          children: [
                                                            Text(
                                                              LocaleKeys.type.tr(),
                                                              style: const TextStyle(
                                                                  color: AppPalette
                                                                      .black,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                            ),
                                                          ],
                                                        ),
                                                        10.heightBox,
                                                        Container(
                                                          decoration: BoxDecoration(
                                                            color: AppPalette
                                                                .lightPrimary,
                                                            borderRadius: BorderRadius
                                                                .circular(Dimensions
                                                                .radiusDefault),
                                                          ),
                                                          child: DropDownMultiSelect(
                                                              options:
                                                              optionsTypeBooks,
                                                              whenEmpty: '',
                                                              decoration: const InputDecoration(
                                                                  fillColor:
                                                                  AppPalette
                                                                      .primary,
                                                                  counterStyle: TextStyle(
                                                                      color: AppPalette
                                                                          .primary)),
                                                              selectedValues: filterCubit
                                                                  .selectedOptionBooks,
                                                              onChanged: (value) {
                                                                filterCubit
                                                                    .selectedOptionBooks =
                                                                    value;
                                                                filterCubit
                                                                    .selectedOptionsValueBooks =
                                                                '';
                                                                for (var element in filterCubit
                                                                    .selectedOptionBooks) {
                                                                  if (filterCubit
                                                                      .selectedOptionsValueBooks ==
                                                                      '') {
                                                                    filterCubit
                                                                        .selectedOptionsValueBooks =
                                                                        filterCubit
                                                                            .selectedOptionsValueBooks +
                                                                            '' +
                                                                            element;
                                                                  } else if (filterCubit
                                                                      .selectedOptionsValueBooks !=
                                                                      '') {
                                                                    filterCubit
                                                                        .selectedOptionsValueBooks =
                                                                        filterCubit
                                                                            .selectedOptionsValueBooks +
                                                                            ',' +
                                                                            element;
                                                                  }
                                                                }
                                                                // translator
                                                                //     .translate('${filterCubit.selectedOptionsValueBooks}', to: 'en')
                                                                //     .then((result){
                                                                //   print("Source: typeBusiness ${filterCubit.selectedOptionsValueBooks}\nTranslated: $result");
                                                                //   typeBooksTranslate  = result.toString();
                                                                //   print('Translated: kids $typeBooksTranslate');
                                                                //
                                                                // });
                                                              }),
                                                        ),
                                                        10.heightBox,
                                                      ],
                                                    )
                                                        : Container()
                                                        : Container(),
                                                    ////// Business - Industrial - Agriculture Category
                                                    filterCubit.selectedMainCategory !=
                                                        null
                                                        ? filterCubit
                                                        .selectedMainCategory!.name!.en!
                                                        .contains(
                                                        'Business - Industrial - Agriculture')
                                                        ? Column(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Text(
                                                              LocaleKeys.condition
                                                                  .tr(),
                                                              style: const TextStyle(
                                                                  color: AppPalette
                                                                      .black,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                            ),
                                                          ],
                                                        ),
                                                        10.heightBox,
                                                        Container(
                                                          decoration: BoxDecoration(
                                                            color: AppPalette
                                                                .lightPrimary,
                                                            borderRadius: BorderRadius
                                                                .circular(Dimensions
                                                                .radiusDefault),
                                                          ),
                                                          child: DropDownMultiSelect(
                                                              options: optionsConditionTypeBusiness,
                                                              whenEmpty: '',
                                                              selectedValues: filterCubit.selectedOptionConditionBusiness,
                                                              onChanged: (value) {
                                                                setState(() {

                                                                  filterCubit.selectedOptionConditionBusiness = value;

                                                                  for (var element in filterCubit.selectedOptionConditionBusiness) {

                                                                    if (filterCubit.selectedOptionsValueConditionBusiness == '') {
                                                                      filterCubit
                                                                          .selectedOptionsValueConditionBusiness =
                                                                          filterCubit
                                                                              .selectedOptionsValueConditionBusiness +
                                                                              '' +
                                                                              element;
                                                                    } else if (filterCubit
                                                                        .selectedOptionsValueConditionBusiness !=
                                                                        '') {
                                                                      filterCubit
                                                                          .selectedOptionsValueConditionBusiness =
                                                                          filterCubit
                                                                              .selectedOptionsValueConditionBusiness +
                                                                              ',' +
                                                                              element;
                                                                    }
                                                                  }

                                                                });
                                                              }),
                                                        ),
                                                        15.heightBox,
                                                        Row(
                                                          children: [

                                                            Text(
                                                              LocaleKeys.type.tr(),
                                                              style: const TextStyle(
                                                                  color: AppPalette
                                                                      .black,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                            ),
                                                          ],
                                                        ),
                                                        10.heightBox,
                                                        Container(
                                                          decoration: BoxDecoration(
                                                            color: AppPalette
                                                                .lightPrimary,
                                                            borderRadius: BorderRadius
                                                                .circular(Dimensions
                                                                .radiusDefault),
                                                          ),
                                                          child: DropDownMultiSelect(
                                                              options:
                                                              optionsTypeBusiness,
                                                              whenEmpty: '',
                                                              decoration: const InputDecoration(
                                                                  fillColor:
                                                                  AppPalette
                                                                      .primary,
                                                                  counterStyle: TextStyle(
                                                                      color: AppPalette
                                                                          .primary)),
                                                              selectedValues: filterCubit
                                                                  .selectedOptionBusiness,
                                                              onChanged: (value) {
                                                               setState(() {
                                                                 filterCubit
                                                                     .selectedOptionBusiness =
                                                                     value;
                                                                 filterCubit
                                                                     .selectedOptionsValueBusiness =
                                                                 '';
                                                                 for (var element in filterCubit
                                                                     .selectedOptionBusiness) {
                                                                   if (filterCubit
                                                                       .selectedOptionsValueBusiness ==
                                                                       '') {
                                                                     filterCubit
                                                                         .selectedOptionsValueBusiness =
                                                                         filterCubit
                                                                             .selectedOptionsValueBusiness +
                                                                             '' +
                                                                             element;
                                                                   } else if (filterCubit
                                                                       .selectedOptionsValueBusiness !=
                                                                       '') {
                                                                     filterCubit
                                                                         .selectedOptionsValueBusiness =
                                                                         filterCubit
                                                                             .selectedOptionsValueBusiness +
                                                                             ',' +
                                                                             element;
                                                                   }
                                                                 }
                                                               });
                                                                // translator
                                                                //     .translate('${filterCubit.selectedOptionsValueBusiness}', to: 'en')
                                                                //     .then((result){
                                                                //   print("Source: typeBusiness ${filterCubit.selectedOptionsValueBusiness}\nTranslated: $result");
                                                                //   typeBusinessTranslate  = result.toString();
                                                                //   print('Translated: kids $typeBusinessTranslate');
                                                                //
                                                                // });
                                                              }),
                                                        ),
                                                        10.heightBox,
                                                      ],
                                                    )
                                                        : Container()
                                                        : Container(),
                                                    ////// Vehicles
                                                    filterCubit.selectedMainCategory !=
                                                        null
                                                        ? filterCubit
                                                        .selectedMainCategory!.name!.en!
                                                        .contains('Vehicles')
                                                        ? Column(
                                                      children: [
                                                        CustomButtonWidget(
                                                            title: addProductController
                                                                .selectedBrand ==
                                                                null
                                                                ? LocaleKeys.brand
                                                                .tr()
                                                                : context.locale
                                                                .languageCode
                                                                .contains(
                                                                'en')
                                                                ? addProductController
                                                                .selectedBrand!
                                                                .brandName !=
                                                                null
                                                                ? '${addProductController
                                                                .selectedBrand!
                                                                .brandName
                                                                ?.en!}'
                                                                : LocaleKeys
                                                                .category
                                                                .tr()
                                                                : context.locale
                                                                .languageCode
                                                                .contains(
                                                                'ar')
                                                                ? addProductController
                                                                .selectedBrand!
                                                                .brandName !=
                                                                null
                                                                ? '${addProductController
                                                                .selectedBrand!
                                                                .brandName
                                                                ?.ar!}'
                                                                : LocaleKeys
                                                                .category
                                                                .tr()
                                                                : context
                                                                .locale
                                                                .languageCode
                                                                .contains(
                                                                'tr')
                                                                ? addProductController
                                                                .selectedBrand!
                                                                .brandName !=
                                                                null
                                                                ? '${addProductController
                                                                .selectedBrand!
                                                                .brandName
                                                                ?.tr!}'
                                                                : LocaleKeys.category
                                                                .tr()
                                                                : context.locale
                                                                .languageCode.contains(
                                                                'de')
                                                                ? addProductController
                                                                .selectedBrand!
                                                                .brandName !=
                                                                null
                                                                ? '${addProductController
                                                                .selectedBrand!
                                                                .brandName
                                                                ?.de!}'
                                                                : LocaleKeys.category
                                                                .tr()
                                                                : LocaleKeys.brand.tr(),
                                                            onTap: () =>
                                                                Navigator.of(context)
                                                                    .push(
                                                                    MaterialPageRoute(
                                                                      builder: (context) =>
                                                                          ChooseOneBrandScreen(
                                                                            governmentId: widget
                                                                                .governmentId,
                                                                            governmentName: widget
                                                                                .governmentName,
                                                                            fromPrice:
                                                                            fromPriceController
                                                                                .text,
                                                                            toPrice:
                                                                            toPriceController
                                                                                .text,
                                                                            cityId:
                                                                            widget
                                                                                .cityId,
                                                                            cityName: widget
                                                                                .cityName,
                                                                            areaId:
                                                                            widget
                                                                                .areaId,
                                                                            tokiloMetresType:
                                                                            widget
                                                                                .tokiloMetresType,
                                                                            fromkiloMetresType:
                                                                            widget
                                                                                .fromkiloMetresType,
                                                                            toDownPayment:
                                                                            toDownPaymentController
                                                                                .text,
                                                                            fromDownPayment:
                                                                            fromDownPaymentController
                                                                                .text,
                                                                            toArea:
                                                                            toAreaPropertiesController
                                                                                .text,
                                                                            fromArea:
                                                                            fromAreaPropertiesController
                                                                                .text,
                                                                            bedroom: widget
                                                                                .bedroom,
                                                                            bathroom: widget
                                                                                .bathroom,
                                                                            toYear:
                                                                            widget
                                                                                .toYear,
                                                                            fromYear: widget
                                                                                .fromYear,
                                                                            locationUser: locationUserController.text,
                                                                            amenitiesType: widget
                                                                                .amenitiesType,
                                                                            bodyType: widget
                                                                                .bodyType,
                                                                            colorType: widget
                                                                                .colorType,
                                                                            engineCapacityType:
                                                                            widget
                                                                                .engineCapacityType,
                                                                            fuelType: widget
                                                                                .fuelType,
                                                                            kiloMetresType: widget
                                                                                .fromkiloMetresType,
                                                                            levelType: widget
                                                                                .levelType,
                                                                            data:
                                                                            'filterScreen',
                                                                            areaName: widget
                                                                                .areaName,
                                                                            nameProduct: '',
                                                                            description: '',
                                                                          ),
                                                                    ))),
                                                        15.heightBox,
                                                        if (addProductController
                                                            .selectedBrand !=
                                                            null)
                                                          15.heightBox,
                                                        addProductState is GetOptionLoadingState
                                                            ?
                                                        const CircularProgressIndicator()
                                                            :
                                                        addProductState is GetOptionSuccessState
                                                            ?
                                                        addProductState.brandModelCarModel!.data != null
                                                            ?
                                                        Column(
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  LocaleKeys.modelName
                                                                      .tr(),
                                                                  style: const TextStyle(
                                                                      color: AppPalette
                                                                          .black,
                                                                      fontWeight: FontWeight
                                                                          .w500),),
                                                              ],
                                                            ),
                                                            10.heightBox,
                                                            Container(
                                                              decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius
                                                                      .circular(15),
                                                                  border: Border.all(
                                                                      color: AppPalette
                                                                          .primary,
                                                                      width: 1)
                                                              ),
                                                              child:
                                                              DropDownMultiSelect(
                                                                  options: addProductState.brandModelCarModel?.data?.length == 0  ? [] :
                                                                  addProductState.brandModelCarModel!.data![0].optionsLabel!,
                                                                  whenEmpty: LocaleKeys.modelbrandName.tr(),
                                                                  selectedValues: addProductController
                                                                      .selectedOptionBrandModel,
                                                                  onChanged: (value) {
                                                                    setState(() {
                                                                      addProductController
                                                                          .selectedOptionsValueBrandModel =
                                                                          value
                                                                              .toString();
                                                                      addProductController
                                                                          .selectedOptionsValueBrandModel =
                                                                      '';
                                                                      for (var element in addProductController
                                                                          .selectedOptionBrandModel) {
                                                                        addProductController.selectedOptionsValueBrandModel =
                                                                            addProductController
                                                                                .selectedOptionsValueBrandModel +
                                                                                ',' +
                                                                                element;
                                                                      }
                                                                    });
                                                                    // translator.translate('${addProductController.selectedOptionsValueBrandModel}', to: 'en')
                                                                    //     .then((result){
                                                                    //   print("Source: typeBusiness ${addProductController.selectedOptionsValueBrandModel}\nTranslated: $result");
                                                                    //   brandNameFilter  = result.toString();
                                                                    //   print('Translated: kids $brandNameFilter');
                                                                    //
                                                                    // });
                                                                  }),

                                                            ),
                                                            const SizedBox(
                                                              height: 5,
                                                            ),
                                                          ],
                                                        )
                                                            : const CircularProgressIndicator()
                                                            : Container(),
                                                        15.heightBox,
                                                        Row(
                                                          children: [
                                                            Text(
                                                              LocaleKeys.fuelType
                                                                  .tr(),
                                                              style: const TextStyle(
                                                                  color: AppPalette
                                                                      .black,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                            ),
                                                          ],
                                                        ),
                                                        10.heightBox,
                                                        Container(
                                                          decoration: BoxDecoration(
                                                            color: AppPalette
                                                                .lightPrimary,
                                                            borderRadius: BorderRadius
                                                                .circular(Dimensions
                                                                .radiusDefault),
                                                          ),
                                                          child: DropDownMultiSelect(
                                                              options: optionsFuelTypeVehicles,
                                                              whenEmpty: '',
                                                              decoration: const InputDecoration(
                                                                  fillColor:
                                                                  AppPalette
                                                                      .primary,
                                                                  counterStyle: TextStyle(
                                                                      color: AppPalette
                                                                          .primary)),
                                                              selectedValues: filterCubit
                                                                  .selectedOptionFuelTypeVehicles,
                                                              onChanged: (value) {
                                                                filterCubit
                                                                    .selectedOptionFuelTypeVehicles =
                                                                    value;
                                                                filterCubit
                                                                    .selectedOptionsValueFuelTypeVehicles =
                                                                '';
                                                                for (var element in filterCubit
                                                                    .selectedOptionFuelTypeVehicles) {
                                                                  if (filterCubit
                                                                      .selectedOptionsValueFuelTypeVehicles ==
                                                                      '') {
                                                                    filterCubit
                                                                        .selectedOptionsValueFuelTypeVehicles =
                                                                        filterCubit
                                                                            .selectedOptionsValueFuelTypeVehicles +
                                                                            '' +
                                                                            element;
                                                                  } else if (filterCubit
                                                                      .selectedOptionsValueFuelTypeVehicles !=
                                                                      '') {
                                                                    filterCubit
                                                                        .selectedOptionsValueFuelTypeVehicles =
                                                                        filterCubit
                                                                            .selectedOptionsValueFuelTypeVehicles +
                                                                            ',' +
                                                                            element;
                                                                  }
                                                                }
                                                                // translator.translate('${filterCubit.selectedOptionsValueFuelTypeVehicles}', to: 'en')
                                                                //     .then((result){
                                                                //   print("Source: typeBusiness ${filterCubit.selectedOptionsValueFuelTypeVehicles}\nTranslated: $result");
                                                                //   fuelTypeTranslate  = result.toString();
                                                                //   print('Translated: kids $fuelTypeTranslate');
                                                                //
                                                                // });
                                                              }),
                                                        ),
                                                        15.heightBox,
                                                        Padding(
                                                          padding: EdgeInsets.symmetric(
                                                              horizontal: Dimensions
                                                                  .paddingSizeExtraExtraSmall),
                                                          child: Row(
                                                            children: [
                                                              Text(
                                                                LocaleKeys.year.tr(),
                                                                style: const TextStyle(
                                                                    color: AppPalette
                                                                        .black,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                    fontSize: 15),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        10.heightBox,
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                              child:
                                                              CustomButtonWidget(
                                                                  title: widget.fromYear == null
                                                                      ? LocaleKeys.from.tr()
                                                                      : widget.fromYear!,
                                                                  onTap: () {
                                                                    // Navigator.push(context, MaterialPageRoute(
                                                                    //     builder: (context) => ChooseFuelTypeAddProductScreen()));
                                                                    Navigator.push(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                            builder: (
                                                                                context) =>
                                                                                ChooseYearScreen(
                                                                                  governmentId: widget
                                                                                      .governmentId,
                                                                                  governmentName: widget
                                                                                      .governmentName,
                                                                                  fromPrice: fromPriceController
                                                                                      .text,
                                                                                  toPrice: toPriceController
                                                                                      .text,
                                                                                  cityId: widget
                                                                                      .cityId,
                                                                                  intentYear: 'fromYear',
                                                                                  cityName: widget
                                                                                      .cityName,
                                                                                  areaId: widget
                                                                                      .areaId,
                                                                                  tokiloMetresType: widget
                                                                                      .tokiloMetresType,
                                                                                  fromkiloMetresType: widget
                                                                                      .fromkiloMetresType,
                                                                                  toDownPayment: toDownPaymentController
                                                                                      .text,
                                                                                  fromDownPayment: fromDownPaymentController
                                                                                      .text,
                                                                                  toArea: toAreaPropertiesController
                                                                                      .text,
                                                                                  fromArea: fromAreaPropertiesController
                                                                                      .text,
                                                                                  bedroom: widget
                                                                                      .bedroom,
                                                                                  bathroom: widget
                                                                                      .bathroom,
                                                                                  toYear: widget
                                                                                      .toYear,
                                                                                  fromYear: widget
                                                                                      .fromYear,
                                                                                  locationUser: locationUserController.text,
                                                                                  amenitiesType: widget
                                                                                      .amenitiesType,
                                                                                  bodyType: widget
                                                                                      .bodyType,
                                                                                  colorType: widget
                                                                                      .colorType,
                                                                                  engineCapacityType: widget
                                                                                      .engineCapacityType,
                                                                                  fuelType: widget
                                                                                      .fuelType,
                                                                                  kiloMetresType: widget
                                                                                      .fromkiloMetresType,
                                                                                  levelType: widget
                                                                                      .levelType,
                                                                                  areaName: widget
                                                                                      .areaName,
                                                                                )));
                                                                  }),
                                                            ),
                                                            10.widthBox,
                                                            Expanded(
                                                              child:
                                                              CustomButtonWidget(
                                                                  title: widget.toYear == null
                                                                      ? LocaleKeys.to.tr()
                                                                      : widget.toYear!,
                                                                  onTap: () {
                                                                    if(widget.fromYear == null){
                                                                      AwesomeDialog(
                                                                        context: context,
                                                                        btnOkText: LocaleKeys.ok.tr(),
                                                                        btnCancelText: LocaleKeys.cancel.tr(),
                                                                        dialogType: DialogType.warning,
                                                                        animType: AnimType.RIGHSLIDE,
                                                                        title: LocaleKeys.warning.tr(),
                                                                        desc: LocaleKeys.pleaseSelectYearFirst.tr(),
                                                                        btnCancelOnPress: () {
                                                                          //  _getCurrentLocation();
                                                                        },
                                                                        btnOkOnPress: () {
                                                                          // _getCurrentLocation();
                                                                        },
                                                                      ).show();
                                                                    }else {
                                                                      Navigator.push(
                                                                          context,
                                                                          MaterialPageRoute(
                                                                              builder: (
                                                                                  context) =>
                                                                                  ChooseYearScreen(
                                                                                    governmentId: widget
                                                                                        .governmentId,
                                                                                    governmentName: widget
                                                                                        .governmentName,
                                                                                    fromPrice: fromPriceController
                                                                                        .text,
                                                                                    toPrice: toPriceController
                                                                                        .text,
                                                                                    cityId: widget
                                                                                        .cityId,
                                                                                    intentYear: 'toYear',
                                                                                    cityName: widget
                                                                                        .cityName,
                                                                                    areaId: widget
                                                                                        .areaId,
                                                                                    toYear: widget
                                                                                        .toYear,
                                                                                    fromYear: widget
                                                                                        .fromYear,
                                                                                    tokiloMetresType: widget
                                                                                        .tokiloMetresType,
                                                                                    fromkiloMetresType: widget
                                                                                        .fromkiloMetresType,
                                                                                    toDownPayment: toDownPaymentController
                                                                                        .text,
                                                                                    fromDownPayment: fromDownPaymentController
                                                                                        .text,
                                                                                    toArea: toAreaPropertiesController
                                                                                        .text,
                                                                                    fromArea: fromAreaPropertiesController
                                                                                        .text,
                                                                                    bedroom: widget
                                                                                        .bedroom,
                                                                                    bathroom: widget
                                                                                        .bathroom,
                                                                                    locationUser: locationUserController.text,
                                                                                    amenitiesType: widget
                                                                                        .amenitiesType,
                                                                                    bodyType: widget
                                                                                        .bodyType,
                                                                                    colorType: widget
                                                                                        .colorType,
                                                                                    engineCapacityType: widget
                                                                                        .engineCapacityType,
                                                                                    fuelType: widget
                                                                                        .fuelType,
                                                                                    kiloMetresType: widget
                                                                                        .fromkiloMetresType,
                                                                                    levelType: widget
                                                                                        .levelType,
                                                                                    areaName: widget
                                                                                        .areaName,
                                                                                  )));
                                                                    }

                                                                  }),
                                                            ),
                                                          ],
                                                        ),
                                                        15.heightBox,
                                                        Padding(
                                                          padding: EdgeInsets.symmetric(
                                                              horizontal: Dimensions
                                                                  .paddingSizeExtraExtraSmall),
                                                          child: Row(
                                                            children: [
                                                              Text(
                                                                LocaleKeys.kilometers
                                                                    .tr(),
                                                                style: const TextStyle(
                                                                    color: AppPalette
                                                                        .black,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                    fontSize: 15),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        10.heightBox,
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                              child:
                                                              CustomButtonWidget(
                                                                  title: widget
                                                                      .fromkiloMetresType ==
                                                                      null
                                                                      ? LocaleKeys
                                                                      .from
                                                                      .tr()
                                                                      : widget
                                                                      .fromkiloMetresType!,
                                                                  onTap: () {
                                                                    // Navigator.push(context, MaterialPageRoute(
                                                                    //     builder: (context) => ChooseFuelTypeAddProductScreen()));
                                                                    Navigator.push(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                            builder: (
                                                                                context) =>
                                                                                ChooseFromKilometersScreen(
                                                                                  governmentId: widget
                                                                                      .governmentId,
                                                                                  governmentName: widget
                                                                                      .governmentName,
                                                                                  fromPrice: fromPriceController
                                                                                      .text,
                                                                                  toPrice: toPriceController
                                                                                      .text,
                                                                                  cityId: widget
                                                                                      .cityId,
                                                                                  cityName: widget
                                                                                      .cityName,
                                                                                  areaId: widget
                                                                                      .areaId,
                                                                                  tokiloMetresType: widget
                                                                                      .tokiloMetresType,
                                                                                  fromkiloMetresType: widget
                                                                                      .fromkiloMetresType,
                                                                                  toDownPayment: toDownPaymentController
                                                                                      .text,
                                                                                  fromDownPayment: fromDownPaymentController
                                                                                      .text,
                                                                                  toArea: toAreaPropertiesController
                                                                                      .text,
                                                                                  fromArea: fromAreaPropertiesController
                                                                                      .text,
                                                                                  bedroom: widget
                                                                                      .bedroom,
                                                                                  bathroom: widget
                                                                                      .bathroom,
                                                                                  toYear: widget
                                                                                      .toYear,
                                                                                  fromYear: widget
                                                                                      .fromYear,
                                                                                  locationUser: locationUserController.text,
                                                                                  amenitiesType: widget
                                                                                      .amenitiesType,
                                                                                  bodyType: widget
                                                                                      .bodyType,
                                                                                  colorType: widget
                                                                                      .colorType,
                                                                                  engineCapacityType: widget
                                                                                      .engineCapacityType,
                                                                                  fuelType: widget
                                                                                      .fuelType,
                                                                                  kiloMetresType: widget
                                                                                      .fromkiloMetresType,
                                                                                  levelType: widget
                                                                                      .levelType,
                                                                                  areaName: widget
                                                                                      .areaName,
                                                                                )));
                                                                  }),
                                                            ),
                                                            10.widthBox,
                                                            Expanded(
                                                              child:
                                                              CustomButtonWidget(
                                                                  title: widget.tokiloMetresType == null
                                                                      ? LocaleKeys.to.tr()
                                                                      : widget.tokiloMetresType!,
                                                                  onTap: () {
                                                                    // Navigator.push(context, MaterialPageRoute(
                                                                    //     builder: (context) => ChooseFuelTypeAddProductScreen()));
                                                                    if(widget.fromkiloMetresType == null){
                                                                      AwesomeDialog(
                                                                        context: context,
                                                                        btnOkText: LocaleKeys.ok.tr(),
                                                                        btnCancelText: LocaleKeys.cancel.tr(),
                                                                        dialogType: DialogType.warning,
                                                                        animType: AnimType.RIGHSLIDE,
                                                                        title: LocaleKeys.warning.tr(),
                                                                        desc: LocaleKeys.pleaseSelectKiloMetersFirst.tr(),
                                                                        btnCancelOnPress: () {
                                                                          //  _getCurrentLocation();
                                                                        },
                                                                        btnOkOnPress: () {
                                                                          // _getCurrentLocation();
                                                                        },
                                                                      ).show();
                                                                    }else {
                                                                      Navigator.push(
                                                                          context,
                                                                          MaterialPageRoute(
                                                                              builder: (
                                                                                  context) =>
                                                                                  ChooseToKilometersScreen(
                                                                                    governmentId: widget
                                                                                        .governmentId,
                                                                                    governmentName: widget
                                                                                        .governmentName,
                                                                                    fromPrice: fromPriceController
                                                                                        .text,
                                                                                    toPrice: toPriceController
                                                                                        .text,
                                                                                    cityId: widget
                                                                                        .cityId,
                                                                                    cityName: widget
                                                                                        .cityName,
                                                                                    areaId: widget
                                                                                        .areaId,
                                                                                    tokiloMetresType: widget
                                                                                        .tokiloMetresType,
                                                                                    fromkiloMetresType: widget
                                                                                        .fromkiloMetresType,
                                                                                    toDownPayment: toDownPaymentController
                                                                                        .text,
                                                                                    fromDownPayment: fromDownPaymentController
                                                                                        .text,
                                                                                    toArea: toAreaPropertiesController
                                                                                        .text,
                                                                                    fromArea: fromAreaPropertiesController
                                                                                        .text,
                                                                                    bedroom: widget
                                                                                        .bedroom,
                                                                                    bathroom: widget
                                                                                        .bathroom,
                                                                                    toYear: widget
                                                                                        .toYear,
                                                                                    fromYear: widget
                                                                                        .fromYear,
                                                                                    locationUser: locationUserController.text,
                                                                                    amenitiesType: widget
                                                                                        .amenitiesType,
                                                                                    bodyType: widget
                                                                                        .bodyType,
                                                                                    colorType: widget
                                                                                        .colorType,
                                                                                    engineCapacityType: widget
                                                                                        .engineCapacityType,
                                                                                    fuelType: widget
                                                                                        .fuelType,
                                                                                    kiloMetresType: widget
                                                                                        .fromkiloMetresType,
                                                                                    levelType: widget
                                                                                        .levelType,
                                                                                    areaName: widget
                                                                                        .areaName,
                                                                                  )));
                                                                    }



                                                                  }),
                                                            ),
                                                          ],
                                                        ),
                                                        15.heightBox,
                                                        Row(
                                                          children: [
                                                            Text(
                                                              LocaleKeys
                                                                  .transmissionType
                                                                  .tr(),
                                                              style: const TextStyle(
                                                                  color: AppPalette
                                                                      .black,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                            ),
                                                          ],
                                                        ),
                                                        10.heightBox,
                                                        Container(
                                                          decoration: BoxDecoration(
                                                            color: AppPalette
                                                                .lightPrimary,
                                                            borderRadius: BorderRadius
                                                                .circular(Dimensions
                                                                .radiusDefault),
                                                          ),
                                                          child: DropDownMultiSelect(
                                                              options:
                                                              optionsTransmissionTypeVehicles,
                                                              whenEmpty: '',
                                                              decoration: const InputDecoration(
                                                                  fillColor:
                                                                  AppPalette
                                                                      .primary,
                                                                  counterStyle: TextStyle(
                                                                      color: AppPalette
                                                                          .primary)),
                                                              selectedValues: filterCubit
                                                                  .selectedOptionTransmissionTypeVehicles,
                                                              onChanged: (value) {
                                                                filterCubit
                                                                    .selectedOptionTransmissionTypeVehicles =
                                                                    value;
                                                                filterCubit
                                                                    .selectedOptionsValueTransmissionTypeVehicles =
                                                                '';
                                                                for (var element in filterCubit
                                                                    .selectedOptionTransmissionTypeVehicles) {
                                                                  if (filterCubit
                                                                      .selectedOptionsValueTransmissionTypeVehicles ==
                                                                      '') {
                                                                    filterCubit
                                                                        .selectedOptionsValueTransmissionTypeVehicles =
                                                                        filterCubit
                                                                            .selectedOptionsValueTransmissionTypeVehicles +
                                                                            '' +
                                                                            element;
                                                                  } else if (filterCubit
                                                                      .selectedOptionsValueTransmissionTypeVehicles !=
                                                                      '') {
                                                                    filterCubit
                                                                        .selectedOptionsValueTransmissionTypeVehicles =
                                                                        filterCubit
                                                                            .selectedOptionsValueTransmissionTypeVehicles +
                                                                            ',' +
                                                                            element;
                                                                  }
                                                                }
                                                                // translator.translate('${filterCubit.selectedOptionsValueTransmissionTypeVehicles}', to: 'en')
                                                                //     .then((result){
                                                                //   print("Source: typeBusiness ${filterCubit.selectedOptionsValueTransmissionTypeVehicles}\nTranslated: $result");
                                                                //   transmissionVehiclesTranslate  = result.toString();
                                                                //   print('Translated: kids $transmissionVehiclesTranslate');
                                                                //
                                                                // });
                                                              }),
                                                        ),
                                                        15.heightBox,
                                                        Row(
                                                          children: [
                                                            Text(
                                                                LocaleKeys.condition
                                                                    .tr(),
                                                                style: const TextStyle(
                                                                    color: AppPalette
                                                                        .black,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w500)),
                                                          ],
                                                        ),
                                                        10.heightBox,
                                                        Container(
                                                          decoration: BoxDecoration(
                                                            color: AppPalette
                                                                .lightPrimary,
                                                            borderRadius: BorderRadius
                                                                .circular(Dimensions
                                                                .radiusDefault),
                                                          ),
                                                          child: DropDownMultiSelect(
                                                              options:
                                                              optionsConditionVehicles,
                                                              whenEmpty: '',
                                                              decoration: const InputDecoration(
                                                                  fillColor:
                                                                  AppPalette
                                                                      .primary,
                                                                  counterStyle: TextStyle(
                                                                      color: AppPalette
                                                                          .primary)),
                                                              selectedValues: filterCubit
                                                                  .selectedOptionConditionVehicles,
                                                              onChanged: (value) {
                                                                setState(() {
                                                                  filterCubit
                                                                      .selectedOptionConditionVehicles =
                                                                      value;
                                                                  filterCubit
                                                                      .selectedOptionsValueConditionVehicles =
                                                                  '';
                                                                  for (var element in filterCubit
                                                                      .selectedOptionConditionVehicles) {
                                                                    if (filterCubit
                                                                        .selectedOptionsValueConditionVehicles ==
                                                                        '') {
                                                                      filterCubit
                                                                          .selectedOptionsValueConditionVehicles =
                                                                          filterCubit
                                                                              .selectedOptionsValueConditionVehicles +
                                                                              '' +
                                                                              element;
                                                                    } else if (filterCubit
                                                                        .selectedOptionsValueConditionVehicles !=
                                                                        '') {
                                                                      filterCubit
                                                                          .selectedOptionsValueConditionVehicles =
                                                                          filterCubit
                                                                              .selectedOptionsValueConditionVehicles +
                                                                              ',' +
                                                                              element;
                                                                    }
                                                                  }
                                                                });
                                                              }),
                                                        ),
                                                      ],
                                                    )
                                                        : Container()
                                                        : Container(),
                                                    ////// Electronics
                                                    filterCubit.selectedMainCategory !=
                                                        null
                                                        ? filterCubit
                                                        .selectedMainCategory!.name!.en!
                                                        .contains('Electronics')
                                                        ? Column(
                                                      children: [
                                                        15.heightBox,
                                                        CustomButtonWidget(
                                                            title: addProductController
                                                                .selectedBrand ==
                                                                null
                                                                ? LocaleKeys.brand
                                                                .tr()
                                                                : context.locale
                                                                .languageCode
                                                                .contains(
                                                                'en')
                                                                ? addProductController
                                                                .selectedBrand!
                                                                .brandName !=
                                                                null
                                                                ? '${addProductController
                                                                .selectedBrand!
                                                                .brandName
                                                                ?.en!}'
                                                                : LocaleKeys
                                                                .category
                                                                .tr()
                                                                : context.locale
                                                                .languageCode
                                                                .contains(
                                                                'ar')
                                                                ? addProductController
                                                                .selectedBrand!
                                                                .brandName !=
                                                                null
                                                                ? '${addProductController
                                                                .selectedBrand!
                                                                .brandName
                                                                ?.ar!}'
                                                                : LocaleKeys
                                                                .category
                                                                .tr()
                                                                : context
                                                                .locale
                                                                .languageCode
                                                                .contains(
                                                                'tr')
                                                                ? addProductController
                                                                .selectedBrand!
                                                                .brandName !=
                                                                null
                                                                ? '${addProductController
                                                                .selectedBrand!
                                                                .brandName
                                                                ?.tr!}'
                                                                : LocaleKeys.category
                                                                .tr()
                                                                : context.locale
                                                                .languageCode.contains(
                                                                'de')
                                                                ? addProductController
                                                                .selectedBrand!
                                                                .brandName !=
                                                                null
                                                                ? '${addProductController
                                                                .selectedBrand!
                                                                .brandName
                                                                ?.de!}'
                                                                : LocaleKeys.category
                                                                .tr()
                                                                : ' ',
                                                            onTap: () =>
                                                                Navigator.of(context)
                                                                    .push(
                                                                    MaterialPageRoute(
                                                                      builder: (context) =>
                                                                          ChooseOneBrandScreen(
                                                                            governmentId: widget
                                                                                .governmentId,
                                                                            governmentName: widget
                                                                                .governmentName,
                                                                            fromPrice:
                                                                            fromPriceController
                                                                                .text,
                                                                            toPrice:
                                                                            toPriceController
                                                                                .text,
                                                                            cityId:
                                                                            widget
                                                                                .cityId,
                                                                            cityName: widget
                                                                                .cityName,
                                                                            areaId:
                                                                            widget
                                                                                .areaId,
                                                                            tokiloMetresType:
                                                                            widget
                                                                                .tokiloMetresType,
                                                                            fromkiloMetresType:
                                                                            widget
                                                                                .fromkiloMetresType,
                                                                            toDownPayment:
                                                                            toDownPaymentController
                                                                                .text,
                                                                            fromDownPayment:
                                                                            fromDownPaymentController
                                                                                .text,
                                                                            toArea:
                                                                            toAreaPropertiesController
                                                                                .text,
                                                                            fromArea:
                                                                            fromAreaPropertiesController
                                                                                .text,
                                                                            bedroom: widget
                                                                                .bedroom,
                                                                            bathroom: widget
                                                                                .bathroom,
                                                                            toYear:
                                                                            widget
                                                                                .toYear,
                                                                            fromYear: widget
                                                                                .fromYear,
                                                                            locationUser: locationUserController.text,
                                                                            amenitiesType: widget
                                                                                .amenitiesType,
                                                                            bodyType: widget
                                                                                .bodyType,
                                                                            colorType: widget
                                                                                .colorType,
                                                                            engineCapacityType:
                                                                            widget
                                                                                .engineCapacityType,
                                                                            fuelType: widget
                                                                                .fuelType,
                                                                            kiloMetresType: widget
                                                                                .fromkiloMetresType,
                                                                            levelType: widget
                                                                                .levelType,
                                                                            data:
                                                                            'filterScreen',
                                                                            areaName: widget
                                                                                .areaName,
                                                                            nameProduct: '',
                                                                            description: '',
                                                                          ),
                                                                    ))),
                                                        15.heightBox,
                                                        Row(
                                                          children: [
                                                            Text(
                                                              LocaleKeys.warranty
                                                                  .tr(),
                                                              style: const TextStyle(
                                                                  color: AppPalette
                                                                      .black,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                            ),
                                                          ],
                                                        ),
                                                        10.heightBox,
                                                        Container(
                                                          decoration: BoxDecoration(
                                                            color: AppPalette
                                                                .lightPrimary,
                                                            borderRadius: BorderRadius
                                                                .circular(Dimensions
                                                                .radiusDefault),
                                                          ),
                                                          child: DropDownMultiSelect(
                                                              options:
                                                              optionsWarrantyElectronics,
                                                              whenEmpty: '',
                                                              selectedValues: filterCubit
                                                                  .selectedOptionWarrantyElectronics,
                                                              onChanged: (value) {
                                                                setState(() {
                                                                  filterCubit
                                                                      .selectedOptionWarrantyElectronics =
                                                                      value;
                                                                  filterCubit
                                                                      .selectedOptionsValueWarrantyElectronics =
                                                                  '';
                                                                  for (var element in filterCubit
                                                                      .selectedOptionWarrantyElectronics) {
                                                                    if (filterCubit
                                                                        .selectedOptionsValueWarrantyElectronics ==
                                                                        '') {
                                                                      filterCubit
                                                                          .selectedOptionsValueWarrantyElectronics =
                                                                          filterCubit
                                                                              .selectedOptionsValueWarrantyElectronics +
                                                                              '' + element;
                                                                    } else if (filterCubit
                                                                        .selectedOptionsValueWarrantyElectronics !=
                                                                        '') {
                                                                      filterCubit
                                                                          .selectedOptionsValueWarrantyElectronics =
                                                                          filterCubit
                                                                              .selectedOptionsValueWarrantyElectronics +
                                                                              ',' +
                                                                              element;
                                                                    }
                                                                  }
                                                                });
                                                              }),
                                                        ),
                                                        15.heightBox,
                                                        Row(
                                                          children: [
                                                            Text(
                                                              LocaleKeys.condition
                                                                  .tr(),
                                                              style: const TextStyle(
                                                                  color: AppPalette
                                                                      .black,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                            ),
                                                          ],
                                                        ),
                                                        10.heightBox,
                                                        Container(
                                                          decoration: BoxDecoration(
                                                            color: AppPalette
                                                                .lightPrimary,
                                                            borderRadius: BorderRadius
                                                                .circular(Dimensions
                                                                .radiusDefault),
                                                          ),
                                                          child: DropDownMultiSelect(
                                                              options: optionsConditionElectronics,
                                                              whenEmpty: '',
                                                              selectedValues: filterCubit.selectedOptionConditionElectronics,
                                                              onChanged: (value) {
                                                                setState(() {

                                                                  filterCubit.selectedOptionConditionElectronics = value;

                                                                  for (var element in filterCubit.selectedOptionConditionElectronics) {

                                                                    if (filterCubit.selectedOptionsValueConditionElectronics == '') {
                                                                      filterCubit
                                                                          .selectedOptionsValueConditionElectronics =
                                                                          filterCubit
                                                                              .selectedOptionsValueConditionElectronics +
                                                                              '' +
                                                                              element;
                                                                    } else if (filterCubit
                                                                        .selectedOptionsValueConditionElectronics !=
                                                                        '') {
                                                                      filterCubit
                                                                          .selectedOptionsValueConditionElectronics =
                                                                          filterCubit
                                                                              .selectedOptionsValueConditionElectronics +
                                                                              ',' +
                                                                              element;
                                                                    }
                                                                  }

                                                                });
                                                              }),
                                                        ),
                                                      ],
                                                    )
                                                        : Container()
                                                        : Container(),
                                                    ////// Vehicles
                                                    filterCubit.selectedMainCategory !=
                                                        null
                                                        ? filterCubit
                                                        .selectedMainCategory!.name!.en!
                                                        .contains('Vehicles')
                                                        ? Column(
                                                      children: [
                                                        15.heightBox,
                                                        Row(
                                                          children: [
                                                            Text(
                                                              LocaleKeys.color.tr(),
                                                              style: const TextStyle(
                                                                  color: AppPalette
                                                                      .black,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                            ),
                                                          ],
                                                        ),
                                                        10.heightBox,
                                                        Container(
                                                          decoration: BoxDecoration(
                                                            color: AppPalette
                                                                .lightPrimary,
                                                            borderRadius: BorderRadius
                                                                .circular(Dimensions
                                                                .radiusDefault),
                                                          ),
                                                          child: DropDownMultiSelect(
                                                              options:
                                                              optionsColorVehicles,
                                                              whenEmpty: '',
                                                              decoration: const InputDecoration(
                                                                  fillColor: AppPalette
                                                                      .primary,
                                                                  counterStyle: TextStyle(
                                                                      color: AppPalette
                                                                          .primary)),
                                                              selectedValues: filterCubit
                                                                  .selectedOptionColorVehicles,
                                                              onChanged: (value) {
                                                                setState(() {
                                                                  filterCubit
                                                                      .selectedOptionColorVehicles =
                                                                      value;
                                                                  filterCubit
                                                                      .selectedOptionsValueColorVehicles =
                                                                  '';
                                                                  for (var element in filterCubit
                                                                      .selectedOptionColorVehicles) {
                                                                    if (filterCubit
                                                                        .selectedOptionsValueColorVehicles ==
                                                                        '') {
                                                                      filterCubit
                                                                          .selectedOptionsValueColorVehicles =
                                                                          filterCubit
                                                                              .selectedOptionsValueColorVehicles +
                                                                              '' +
                                                                              element;
                                                                    } else if (filterCubit
                                                                        .selectedOptionsValueColorVehicles !=
                                                                        '') {
                                                                      filterCubit
                                                                          .selectedOptionsValueColorVehicles =
                                                                          filterCubit
                                                                              .selectedOptionsValueColorVehicles +
                                                                              ',' +
                                                                              element;
                                                                    }
                                                                  }
                                                                });
                                                                // translator.translate('${filterCubit.selectedOptionsValueColorVehicles}', to: 'en')
                                                                //     .then((result){
                                                                //   print("Source: typeBusiness ${filterCubit.selectedOptionsValueColorVehicles}\nTranslated: $result");
                                                                //   colorVehiclesTranslate  = result.toString();
                                                                //   print('Translated: kids $colorVehiclesTranslate');
                                                                //
                                                                // });
                                                              }),
                                                        ),
                                                        15.heightBox,
                                                        Row(
                                                          children: [
                                                            Text(
                                                              LocaleKeys.bodyType
                                                                  .tr(),
                                                              style: const TextStyle(
                                                                  color: AppPalette
                                                                      .black,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                            ),
                                                          ],
                                                        ),
                                                        10.heightBox,
                                                        Container(
                                                          decoration: BoxDecoration(
                                                            color: AppPalette
                                                                .lightPrimary,
                                                            borderRadius: BorderRadius
                                                                .circular(Dimensions
                                                                .radiusDefault),
                                                          ),
                                                          child: DropDownMultiSelect(
                                                              options:
                                                              optionsBodyTypeVehicles,
                                                              whenEmpty: '',
                                                              decoration: const InputDecoration(
                                                                  fillColor:
                                                                  AppPalette
                                                                      .primary,
                                                                  counterStyle: TextStyle(
                                                                      color: AppPalette
                                                                          .primary)),
                                                              selectedValues: filterCubit
                                                                  .selectedOptionBodyTypeVehicles,
                                                              onChanged: (value) {
                                                                filterCubit
                                                                    .selectedOptionBodyTypeVehicles =
                                                                    value;
                                                                filterCubit
                                                                    .selectedOptionsValueBodyTypeVehicles =
                                                                '';
                                                                for (var element in filterCubit
                                                                    .selectedOptionBodyTypeVehicles) {
                                                                  if (filterCubit
                                                                      .selectedOptionsValueBodyTypeVehicles ==
                                                                      '') {
                                                                    filterCubit
                                                                        .selectedOptionsValueBodyTypeVehicles =
                                                                        filterCubit
                                                                            .selectedOptionsValueBodyTypeVehicles +
                                                                            '' +
                                                                            element;
                                                                  } else if (filterCubit
                                                                      .selectedOptionsValueBodyTypeVehicles !=
                                                                      '') {
                                                                    filterCubit
                                                                        .selectedOptionsValueBodyTypeVehicles =
                                                                        filterCubit
                                                                            .selectedOptionsValueBodyTypeVehicles +
                                                                            ',' +
                                                                            element;
                                                                  }
                                                                }
                                                                // translator.translate('${filterCubit.selectedOptionsValueBodyTypeVehicles}', to: 'en')
                                                                //     .then((result){
                                                                //   print("Source: typeBusiness ${filterCubit.selectedOptionsValueBodyTypeVehicles}\nTranslated: $result");
                                                                //   bodyTypeTranslate  = result.toString();
                                                                //   print('Translated: kids $bodyTypeTranslate');
                                                                //
                                                                // });
                                                              }),
                                                        ),
                                                        15.heightBox,
                                                        Row(
                                                          children: [
                                                            Text(
                                                              LocaleKeys
                                                                  .engineCapacity
                                                                  .tr(),
                                                              style: const TextStyle(
                                                                  color: AppPalette
                                                                      .black,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                            ),
                                                          ],
                                                        ),
                                                        10.heightBox,
                                                        Container(
                                                          decoration: BoxDecoration(
                                                            color: AppPalette
                                                                .lightPrimary,
                                                            borderRadius: BorderRadius
                                                                .circular(Dimensions
                                                                .radiusDefault),
                                                          ),
                                                          child: DropDownMultiSelect(
                                                              options:
                                                              optionsEngineCapacityVehicles,
                                                              whenEmpty: '',
                                                              decoration: const InputDecoration(
                                                                  fillColor:
                                                                  AppPalette
                                                                      .primary,
                                                                  counterStyle: TextStyle(
                                                                      color: AppPalette
                                                                          .primary)),
                                                              selectedValues: filterCubit
                                                                  .selectedOptionEngineCapacityVehicles,
                                                              onChanged: (value) {
                                                                filterCubit
                                                                    .selectedOptionEngineCapacityVehicles =
                                                                    value;
                                                                filterCubit
                                                                    .selectedOptionsValueEngineCapacityVehicles =
                                                                '';
                                                                for (var element in filterCubit
                                                                    .selectedOptionEngineCapacityVehicles) {
                                                                  if (filterCubit
                                                                      .selectedOptionsValueEngineCapacityVehicles ==
                                                                      '') {
                                                                    filterCubit
                                                                        .selectedOptionsValueEngineCapacityVehicles =
                                                                        filterCubit
                                                                            .selectedOptionsValueEngineCapacityVehicles +
                                                                            '' +
                                                                            element;
                                                                  } else if (filterCubit
                                                                      .selectedOptionsValueEngineCapacityVehicles !=
                                                                      '') {
                                                                    filterCubit
                                                                        .selectedOptionsValueEngineCapacityVehicles =
                                                                        filterCubit
                                                                            .selectedOptionsValueEngineCapacityVehicles +
                                                                            ',' +
                                                                            element;
                                                                  }
                                                                }
                                                                // translator.translate('${filterCubit.selectedOptionsValueEngineCapacityVehicles}', to: 'en')
                                                                //     .then((result){
                                                                //   print("Source: typeBusiness ${filterCubit.selectedOptionsValueEngineCapacityVehicles}\nTranslated: $result");
                                                                //   engineCapacityTypeTranslate  = result.toString();
                                                                //   print('Translated: kids $engineCapacityTypeTranslate');
                                                                //
                                                                // });
                                                              }),
                                                        ),
                                                        15.heightBox,
                                                      ],
                                                    )
                                                        : Container()
                                                        : Container(),
                                                    // CustomButtonWidget(
                                                    //     title: filterCubit.getSelectedColorsAsAString(),
                                                    //     onTap: () =>
                                                    //         Navigator.of(context).push(MaterialPageRoute(
                                                    //           builder: (context) => ChooseColorScreen(),
                                                    //         ))),
                                                    // 13.heightBox,
                                                    // CustomButtonWidget(
                                                    //     title: LocaleKeys.brand.tr(),
                                                    //     onTap: () =>
                                                    //         Navigator.of(context).push(MaterialPageRoute(
                                                    //           builder: (context) => ChooseBrandSearchWidget(),
                                                    //         ))),
                                                  ],
                                                )
                                                //      : Container(),
                                              ]),
                                        ),
                                        13.heightBox,
                                        state is FilterLocationLoadingState ?  const Center(
                                          child: CircularProgressIndicator(
                                            color: AppPalette.primary,
                                          ),
                                        ) : Container(),
                                        13.heightBox,
                                        CustomButton(
                                          buttonText: LocaleKeys.apply.tr(),
                                          onPressed: () async {
                                            if (filterCubit.selectedMainCategory ==
                                                null) {
                                              AwesomeDialog(
                                                context: context,
                                                dialogType: DialogType.ERROR,
                                                btnOkText: LocaleKeys.ok.tr(),
                                                btnCancelText: LocaleKeys.cancel.tr(),
                                                animType: AnimType.RIGHSLIDE,
                                                title: LocaleKeys.error.tr(),
                                                desc: LocaleKeys
                                                    .pleaseSelectMainCategoryFirst.tr(),
                                                btnCancelOnPress: () {},
                                                btnOkOnPress: () {},
                                              ).show();
                                            } else {
                                              brandId =
                                              '${addProductController.selectedBrand ==
                                                  null
                                                  ? ''
                                                  : addProductController.selectedBrand
                                                  ?.id}';
                                              brandName =
                                              '${addProductController.selectedBrand ==
                                                  null
                                                  ? ''
                                                  : context.locale.languageCode
                                                  .contains('en') ? addProductController.selectedBrand?.brandName?.en :
                                              context.locale.languageCode
                                                  .contains('ar') ? addProductController
                                                  .selectedBrand?.brandName?.ar :
                                              context.locale.languageCode
                                                  .contains('tr') ? addProductController
                                                  .selectedBrand?.brandName?.tr :
                                              context.locale.languageCode
                                                  .contains('de') ? addProductController
                                                  .selectedBrand?.brandName?.de : ''}';
                                              subCategoryId =
                                              '${filterCubit.selectedSubCategory == null
                                                  ? ' '
                                                  : filterCubit.selectedSubCategory
                                                  ?.id}';

                                              print(
                                                  'selectedOptionsValueWarrantyElectronics');
                                              print(filterCubit
                                                  .selectedOptionsValueWarrantyElectronics);

                                              if (dropdownValue == '0') {
                                                print(
                                                    'selectedOptionsValueWarrantyElectronics');
                                                if(locationUserController.text != ''){

                                                  if(widget.governmentName == null){

                                                    AwesomeDialog(
                                                      context: context,
                                                      btnOkText: LocaleKeys.ok.tr(),
                                                      btnCancelText: LocaleKeys.cancel.tr(),
                                                      dialogType: DialogType.warning,
                                                      animType: AnimType.RIGHSLIDE,
                                                      title: LocaleKeys.warning.tr(),
                                                      desc: LocaleKeys.selectYourLocation.tr(),
                                                      btnCancelOnPress: () {
                                                        //  _getCurrentLocation();
                                                      },
                                                      btnOkOnPress: () {
                                                        // _getCurrentLocation();
                                                      },
                                                    ).show();
                                                  }else {

                                                    if (filterCubit.selectedMainCategory!.name!.en!.contains('Vehicles')) {

                                                      // print('statusUser is');
                                                      // print('brandId id $brandId');
                                                      // print('selectedBrand fuelType ${filterCubit.selectedOptionsValueFuelTypeVehicles}');
                                                      // print('selectedBrand year ${widget
                                                      //     .fromYear}');
                                                      // print('selectedBrand kilo ${widget
                                                      //     .kiloMetresType}');
                                                      // print('selectedBrand trans ${filterCubit
                                                      //     .selectedOptionsValueTransmissionTypeVehicles}');
                                                      // print('selectedBrand color ${filterCubit
                                                      //     .selectedOptionsValueColorVehicles}');
                                                      // print(
                                                      //     'selectedBrand bodyType ${filterCubit
                                                      //         .selectedOptionsValueBodyTypeVehicles}');
                                                      // print('selectedBrand engin ${filterCubit
                                                      //     .selectedOptionsValueEngineCapacityVehicles}');
                                                      // print(
                                                      //     'selectedBrand model ${addProductController
                                                      //         .dropdownValueBrand}');
                                                      // print(
                                                      //     'selectedSubCategory id ${filterCubit
                                                      //         .selectedOptionsValueConditionAllCategory}');
                                                      // print(
                                                      //     'selectedCategory id $dropdownValue');

                                                      print('selectedCategory id ${filterCubit.selectedMainCategory!.name!.en}');
                                                      print('selectedCategory id ${filterCubit.selectedMainCategory!.id}');
                                                      print('selectedCategory id ${filterCubit.selectedSubCategory?.id}');

                                                      if (filterCubit.selectedSubCategory?.id != null) {

                                                        if(widget.fromYear == null && widget.toYear == null){
                                                          print('fromYear == null');
                                                          Navigator.of(context).push(
                                                              MaterialPageRoute(
                                                                builder: (context) =>
                                                                    FilterResultScreen(
                                                                      categoryId: filterCubit.selectedMainCategory?.id.toString(),
                                                                      categoryName: filterCubit.selectedMainCategory?.name?.en,
                                                                      subCategory: filterCubit.selectedSubCategory?.id.toString(),
                                                                      brandId: brandId,
                                                                      brandName: brandName,
                                                                      brandModel: addProductController.selectedBrand,
                                                                      latitude: null,
                                                                      longitude: null,
                                                                      locationUser: locationUserController.text,
                                                                      fuelType: filterCubit.selectedOptionsValueFuelTypeVehicles,
                                                                      bodyType: filterCubit.selectedOptionsValueBodyTypeVehicles,
                                                                      engineCapacityType: filterCubit.selectedOptionsValueEngineCapacityVehicles,
                                                                      fromYear: widget.fromYear,
                                                                      toKilometersType: widget.tokiloMetresType,
                                                                      toYear: widget.toYear,
                                                                      fromKilometersType: widget.fromkiloMetresType,
                                                                      transmissionVehicles: filterCubit.selectedOptionsValueTransmissionTypeVehicles,
                                                                      colorVehicles: filterCubit.selectedOptionsValueColorVehicles,
                                                                      status: filterCubit.selectedOptionsValueConditionVehicles,
                                                                      distance: dropdownValue,
                                                                      governmentId: widget.governmentId,
                                                                      governmentName: widget.governmentName,
                                                                      fromPrice: fromPriceController.text,
                                                                      toPrice: toPriceController.text,
                                                                      cityId: widget.cityId,
                                                                      cityName: widget.cityName,
                                                                      areaId: widget.areaId,
                                                                      data: 'filterScreen',
                                                                      areaName: widget.areaName,
                                                                      nameProduct: '',
                                                                      description: '',
                                                                    ),
                                                              ));

                                                        }else if (widget.fromYear != null && widget.toYear == null){
                                                          print('fromYear == nulls');
                                                          AwesomeDialog(
                                                            context: context,
                                                            btnOkText: LocaleKeys.ok.tr(),
                                                            btnCancelText: LocaleKeys.cancel.tr(),
                                                            dialogType: DialogType.warning,
                                                            animType: AnimType.RIGHSLIDE,
                                                            title: LocaleKeys.warning.tr(),
                                                            desc: LocaleKeys.pleaseSelectYearFirst.tr(),
                                                            btnCancelOnPress: () {
                                                              //  _getCurrentLocation();
                                                            },
                                                            btnOkOnPress: () {
                                                              // _getCurrentLocation();
                                                            },
                                                          ).show();

                                                        } else if(widget.fromYear != null && widget.toYear != null){
                                                          print('fromYear == nullsss');
                                                          if(widget.fromYear!.compareTo(widget.toYear!) >=  0){
                                                            print('fromYear == nullssddds');
                                                            AwesomeDialog(
                                                              context: context,
                                                              btnOkText: LocaleKeys.ok.tr(),
                                                              btnCancelText: LocaleKeys.cancel.tr(),
                                                              dialogType: DialogType.warning,
                                                              animType: AnimType.RIGHSLIDE,
                                                              title: LocaleKeys.warning.tr(),
                                                              desc: LocaleKeys.pleaseSelectYearFirst.tr(),
                                                              btnCancelOnPress: () {
                                                                //  _getCurrentLocation();
                                                              },
                                                              btnOkOnPress: () {
                                                                // _getCurrentLocation();
                                                              },
                                                            ).show();
                                                          }else if(widget.fromYear!.compareTo(widget.toYear!) < 0){


                                                            if(widget.fromkiloMetresType == null && widget.tokiloMetresType == null){
                                                              print('fromkiloMetresType == null');
                                                              Navigator.of(context).push(
                                                                  MaterialPageRoute(
                                                                    builder: (context) =>
                                                                        FilterResultScreen(
                                                                          categoryId: filterCubit.selectedMainCategory?.id.toString(),
                                                                          categoryName: filterCubit.selectedMainCategory?.name?.en,
                                                                          subCategory: filterCubit.selectedSubCategory?.id.toString(),
                                                                          brandId: brandId,
                                                                          brandName: brandName,
                                                                          brandModel: addProductController.selectedBrand,
                                                                          latitude: null,
                                                                          longitude: null,
                                                                          locationUser: locationUserController.text,
                                                                          fuelType: filterCubit.selectedOptionsValueFuelTypeVehicles,
                                                                          bodyType: filterCubit.selectedOptionsValueBodyTypeVehicles,
                                                                          engineCapacityType: filterCubit.selectedOptionsValueEngineCapacityVehicles,
                                                                          fromYear: widget.fromYear,
                                                                          toKilometersType: widget.tokiloMetresType,
                                                                          toYear: widget.toYear,
                                                                          fromKilometersType: widget.fromkiloMetresType,
                                                                          transmissionVehicles: filterCubit.selectedOptionsValueTransmissionTypeVehicles,
                                                                          colorVehicles: filterCubit.selectedOptionsValueColorVehicles,
                                                                          status: filterCubit.selectedOptionsValueConditionVehicles,
                                                                          distance: dropdownValue,
                                                                          governmentId: widget.governmentId,
                                                                          governmentName: widget.governmentName,
                                                                          fromPrice: fromPriceController.text,
                                                                          toPrice: toPriceController.text,
                                                                          cityId: widget.cityId,
                                                                          cityName: widget.cityName,
                                                                          areaId: widget.areaId,
                                                                          data: 'filterScreen',
                                                                          areaName: widget.areaName,
                                                                          nameProduct: '',
                                                                          description: '',
                                                                        ),
                                                                  ));

                                                            }else if (widget.fromkiloMetresType != null && widget.tokiloMetresType == null){
                                                              print('fromkiloMetresType == nulls');
                                                              AwesomeDialog(
                                                                context: context,
                                                                btnOkText: LocaleKeys.ok.tr(),
                                                                btnCancelText: LocaleKeys.cancel.tr(),
                                                                dialogType: DialogType.warning,
                                                                animType: AnimType.RIGHSLIDE,
                                                                title: LocaleKeys.warning.tr(),
                                                                desc: LocaleKeys.pleaseSelectKiloMetersFirst.tr(),
                                                                btnCancelOnPress: () {
                                                                  //  _getCurrentLocation();
                                                                },
                                                                btnOkOnPress: () {
                                                                  // _getCurrentLocation();
                                                                },
                                                              ).show();

                                                            } else if(widget.fromkiloMetresType != null && widget.tokiloMetresType != null){
                                                              print('fromkiloMetresType == nullsss');
                                                              if(widget.fromkiloMetresType!.compareTo(widget.tokiloMetresType!) >= 0){
                                                                print('fromkiloMetresType == nullssddds');
                                                                AwesomeDialog(
                                                                  context: context,
                                                                  btnOkText: LocaleKeys.ok.tr(),
                                                                  btnCancelText: LocaleKeys.cancel.tr(),
                                                                  dialogType: DialogType.warning,
                                                                  animType: AnimType.RIGHSLIDE,
                                                                  title: LocaleKeys.warning.tr(),
                                                                  desc: LocaleKeys.pleaseSelectKiloMetersFirst.tr(),
                                                                  btnCancelOnPress: () {
                                                                    //  _getCurrentLocation();
                                                                  },
                                                                  btnOkOnPress: () {
                                                                    // _getCurrentLocation();
                                                                  },
                                                                ).show();
                                                              }else if(widget.fromkiloMetresType!.compareTo(widget.tokiloMetresType!) < 0){
                                                                Navigator.of(context).push(
                                                                    MaterialPageRoute(
                                                                      builder: (context) =>
                                                                          FilterResultScreen(
                                                                            categoryId: filterCubit.selectedMainCategory?.id.toString(),
                                                                            categoryName: filterCubit.selectedMainCategory!.name!.en,
                                                                            subCategory: filterCubit.selectedSubCategory?.id.toString(),
                                                                            brandId: brandId,
                                                                            brandName: brandName,
                                                                            brandModel: addProductController.selectedBrand,
                                                                            latitude: null,
                                                                            longitude: null,
                                                                            locationUser: locationUserController.text,
                                                                            fuelType: filterCubit.selectedOptionsValueFuelTypeVehicles,
                                                                            bodyType: filterCubit.selectedOptionsValueBodyTypeVehicles,
                                                                            engineCapacityType: filterCubit.selectedOptionsValueEngineCapacityVehicles,
                                                                            fromYear: widget.fromYear,
                                                                            toKilometersType: widget.tokiloMetresType,
                                                                            toYear: widget.toYear,
                                                                            fromKilometersType: widget.fromkiloMetresType,
                                                                            transmissionVehicles: filterCubit.selectedOptionsValueTransmissionTypeVehicles,
                                                                            colorVehicles: filterCubit.selectedOptionsValueColorVehicles,
                                                                            status: filterCubit.selectedOptionsValueConditionVehicles,
                                                                            distance: dropdownValue,
                                                                            governmentId: widget.governmentId,
                                                                            governmentName: widget.governmentName,
                                                                            fromPrice: fromPriceController.text,
                                                                            toPrice: toPriceController.text,
                                                                            cityId: widget.cityId,
                                                                            cityName: widget.cityName,
                                                                            areaId: widget.areaId,
                                                                            data: 'filterScreen',
                                                                            areaName: widget.areaName,
                                                                            nameProduct: '',
                                                                            description: '',
                                                                          ),
                                                                    ));

                                                              }

                                                            }
                                                          }
                                                        }

                                                      } else {
                                                        AwesomeDialog(
                                                          context: context,
                                                          btnOkText: LocaleKeys.ok.tr(),
                                                          btnCancelText: LocaleKeys.cancel.tr(),
                                                          dialogType: DialogType.warning,
                                                          animType: AnimType.RIGHSLIDE,
                                                          title: LocaleKeys.warning.tr(),
                                                          desc: LocaleKeys
                                                              .pleaseSelectSubCategoryFirst
                                                              .tr(),
                                                          btnCancelOnPress: () {
                                                            //  _getCurrentLocation();
                                                          },
                                                          btnOkOnPress: () {
                                                            // _getCurrentLocation();
                                                          },
                                                        ).show();
                                                      }
                                                    }
                                                    else if (filterCubit.selectedMainCategory!.name!.en!.contains('Properties')) {


                                                      // print('selectedSubCategory id ${filterCubit
                                                      //     .selectedOptionsValueConditionElectronics}');
                                                      print('selectedCategory id $dropdownValue');
                                                      print('selectedCategory id ${filterCubit.selectedOptionsValueWarrantyElectronics}');

                                                      if (filterCubit.selectedSubCategory?.id != null) {

                                                        Navigator.of(context).push(
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                                  FilterResultScreen(
                                                                    categoryId: filterCubit.selectedMainCategory?.id.toString(),
                                                                    categoryName: filterCubit.selectedMainCategory?.name?.en,
                                                                    subCategory: filterCubit.selectedSubCategory?.id.toString(),
                                                                    latitude: null,
                                                                    longitude: null,
                                                                    distance: dropdownValue,
                                                                    locationUser: locationUserController.text,
                                                                    fromArea: fromAreaPropertiesController.text,
                                                                    toArea: toAreaPropertiesController.text,
                                                                    //  status: filterCubit.selectedOptionsValueConditionAllCategory,
                                                                    typeProperties: filterCubit.selectedOptionsValueTypeProperties,
                                                                    typeApartment: filterCubit.selectedOptionsValueTypeApartmentProperties,
                                                                    bedroom: filterCubit.selectedOptionsValueBedroomProperties,
                                                                    bathroom: filterCubit.selectedOptionsValueBathRoomProperties,
                                                                    levelType: filterCubit.selectedOptionsValueLevelProperties,
                                                                    // statusApartment: filterCubit.selectedOptionsValueTypeApartmentProperties,
                                                                    furnishedProperties: filterCubit.selectedOptionsValueFurnishedProperties,
                                                                    amenitiesType: filterCubit.selectedOptionsValueAmenitiesProperties,
                                                                    fromDownPayment: fromDownPaymentController.text,
                                                                    toDownPayment: toDownPaymentController.text,
                                                                    governmentId: widget.governmentId,
                                                                    governmentName: widget.governmentName,
                                                                    fromPrice: fromPriceController.text,
                                                                    toPrice: toPriceController.text,
                                                                    cityId: widget.cityId,
                                                                    cityName: widget.cityName,
                                                                    areaId: widget.areaId,
                                                                    data: 'filterScreen',
                                                                    areaName: widget.areaName,
                                                                    nameProduct: '',
                                                                    description: '',
                                                                  ),
                                                            ));


                                                      } else {
                                                        AwesomeDialog(
                                                          context: context,
                                                          btnOkText: LocaleKeys.ok.tr(),
                                                          btnCancelText: LocaleKeys.cancel.tr(),
                                                          dialogType: DialogType.warning,
                                                          animType: AnimType.RIGHSLIDE,
                                                          title: LocaleKeys.warning.tr(),
                                                          desc: LocaleKeys
                                                              .pleaseSelectSubCategoryFirst
                                                              .tr(),
                                                          btnCancelOnPress: () {
                                                            //  _getCurrentLocation();
                                                          },
                                                          btnOkOnPress: () {
                                                            // _getCurrentLocation();
                                                          },
                                                        ).show();
                                                      }
                                                    }
                                                    else if (filterCubit.selectedMainCategory!.name!.en!.contains('Electronics')) {


                                                      if (filterCubit.selectedSubCategory?.id != null) {
                                                        // CacheHelper.saveData(key: 'statusUser',
                                                        //     value: filterCubit
                                                        //         .selectedOptionsValueConditionAllCategory);

                                                        Navigator.of(context).push(
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                                  FilterResultScreen(
                                                                    categoryId: filterCubit.selectedMainCategory?.id.toString(),
                                                                    categoryName: filterCubit.selectedMainCategory?.name?.en,
                                                                    subCategory: filterCubit.selectedSubCategory?.id.toString(),
                                                                    brandId: brandId,
                                                                    brandName: brandName,
                                                                    locationUser: locationUserController.text,
                                                                    brandModel: addProductController.selectedBrand,
                                                                    latitude: null,
                                                                    longitude: null,
                                                                    status: filterCubit.selectedOptionsValueConditionElectronics,
                                                                    distance: dropdownValue,
                                                                    warrantyElectronic: filterCubit.selectedOptionsValueWarrantyElectronics,
                                                                    governmentId: widget.governmentId,
                                                                    governmentName: widget.governmentName,
                                                                    fromPrice: fromPriceController.text,
                                                                    toPrice: toPriceController.text,
                                                                    cityId: widget.cityId,
                                                                    cityName: widget.cityName,
                                                                    areaId: widget.areaId,
                                                                    data: 'filterScreen',
                                                                    areaName: widget.areaName,
                                                                    nameProduct: '',
                                                                    description: '',
                                                                  ),
                                                            ));

                                                      } else {
                                                        AwesomeDialog(
                                                          context: context,
                                                          btnOkText: LocaleKeys.ok.tr(),
                                                          btnCancelText: LocaleKeys.cancel.tr(),
                                                          dialogType: DialogType.warning,
                                                          animType: AnimType.RIGHSLIDE,
                                                          title: LocaleKeys.warning.tr(),
                                                          desc: LocaleKeys
                                                              .pleaseSelectSubCategoryFirst
                                                              .tr(),
                                                          btnCancelOnPress: () {
                                                            //  _getCurrentLocation();
                                                          },
                                                          btnOkOnPress: () {
                                                            // _getCurrentLocation();
                                                          },
                                                        ).show();
                                                      }
                                                    }
                                                    else if (filterCubit.selectedMainCategory!.name!.en!.contains('Fashion')) {

                                                      print('FashionName');
                                                      print(filterCubit.selectedMainCategory?.name?.en);
                                                      print(filterCubit.selectedOptionsValueFashion);

                                                      if (filterCubit.selectedSubCategory?.id !=
                                                          null) {

                                                        Navigator.of(context).push(
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                                  FilterResultScreen(
                                                                    categoryId: filterCubit.selectedMainCategory?.id.toString(),
                                                                    categoryName: filterCubit.selectedMainCategory?.name?.en,
                                                                    subCategory: filterCubit.selectedSubCategory?.id.toString(),
                                                                    distance: dropdownValue,
                                                                    locationUser: locationUserController.text,
                                                                    typeFashion: filterCubit.selectedOptionsValueFashion,
                                                                    status: filterCubit.selectedOptionsValueConditionFashion,
                                                                    governmentId: widget.governmentId,
                                                                    governmentName: widget.governmentName,
                                                                    fromPrice: fromPriceController.text,
                                                                    toPrice: toPriceController.text,
                                                                    cityId: widget.cityId,
                                                                    cityName: widget.cityName,
                                                                    areaId: widget.areaId,
                                                                    areaName: widget.areaName,
                                                                  ),
                                                            ));


                                                        // final input = filterCubit.selectedOptionsValueFashion;
                                                        //
                                                        // print("Source: $input");
                                                        //
                                                        // translator
                                                        //     .translate(filterCubit
                                                        //     .selectedOptionsValueFashion == ''
                                                        //     ? '-'
                                                        //     : input, to: 'en')
                                                        //     .then((result) {
                                                        //
                                                        //
                                                        //   print(
                                                        //       "Source: $input\nTranslated: $result");
                                                        // });


                                                      } else {
                                                        AwesomeDialog(
                                                          context: context,
                                                          btnOkText: LocaleKeys.ok.tr(),
                                                          btnCancelText: LocaleKeys.cancel.tr(),
                                                          dialogType: DialogType.warning,
                                                          animType: AnimType.RIGHSLIDE,
                                                          title: LocaleKeys.warning.tr(),
                                                          desc: LocaleKeys
                                                              .pleaseSelectSubCategoryFirst
                                                              .tr(),
                                                          btnCancelOnPress: () {
                                                            //  _getCurrentLocation();
                                                          },
                                                          btnOkOnPress: () {
                                                            // _getCurrentLocation();
                                                          },
                                                        ).show();
                                                      }
                                                    }
                                                    else if (filterCubit.selectedMainCategory!.name!.en!.contains('Home Furniture')) {

                                                      if (filterCubit.selectedSubCategory?.id != null) {


                                                        Navigator.of(context).push(
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    FilterResultScreen(
                                                                      categoryId: filterCubit.selectedMainCategory?.id.toString(),
                                                                      categoryName: filterCubit.selectedMainCategory?.name?.en,
                                                                      subCategory: filterCubit.selectedSubCategory?.id.toString(),
                                                                      typeHomeFurniture: filterCubit.selectedOptionsValueHomeFurniture,
                                                                      latitude: null,
                                                                      longitude: null,
                                                                      status: filterCubit.selectedOptionsValueConditionHomeFurniture,
                                                                      locationUser: locationUserController.text,
                                                                      distance: dropdownValue,
                                                                      governmentId: widget.governmentId,
                                                                      governmentName: widget.governmentName,
                                                                      fromPrice: fromPriceController.text,
                                                                      toPrice: toPriceController.text,
                                                                      cityId: widget.cityId,
                                                                      cityName: widget.cityName,
                                                                      areaId: widget.areaId,
                                                                      areaName: widget.areaName,
                                                                    )));

                                                      } else {
                                                        AwesomeDialog(
                                                          context: context,
                                                          btnOkText: LocaleKeys.ok.tr(),
                                                          btnCancelText: LocaleKeys.cancel.tr(),
                                                          dialogType: DialogType.warning,
                                                          animType: AnimType.RIGHSLIDE,
                                                          title: LocaleKeys.warning.tr(),
                                                          desc: LocaleKeys
                                                              .pleaseSelectSubCategoryFirst
                                                              .tr(),
                                                          btnCancelOnPress: () {
                                                            //  _getCurrentLocation();
                                                          },
                                                          btnOkOnPress: () {
                                                            // _getCurrentLocation();
                                                          },
                                                        ).show();
                                                      }
                                                    }
                                                    else if (filterCubit.selectedMainCategory!.name!.en!.contains('Books, Sports & Hobbies')) {

                                                      if (filterCubit.selectedSubCategory?.id != null) {
                                                        Navigator.of(context).push(
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    FilterResultScreen(
                                                                      categoryId: filterCubit.selectedMainCategory?.id.toString(),
                                                                      categoryName: filterCubit.selectedMainCategory?.name?.en,
                                                                      subCategory: filterCubit.selectedSubCategory?.id.toString(),
                                                                      typeBooks: filterCubit.selectedOptionsValueBooks,
                                                                      latitude: null,
                                                                      longitude: null,
                                                                      status: filterCubit.selectedOptionsValueConditionBooks,
                                                                      locationUser: locationUserController.text,
                                                                      distance: dropdownValue,
                                                                      governmentId: widget.governmentId,
                                                                      governmentName: widget.governmentName,
                                                                      fromPrice: fromPriceController.text,
                                                                      toPrice: toPriceController.text,
                                                                      cityId: widget.cityId,
                                                                      cityName: widget.cityName,
                                                                      areaId: widget.areaId,
                                                                      areaName: widget.areaName,
                                                                    )));

                                                      } else {
                                                        AwesomeDialog(
                                                          context: context,
                                                          btnOkText: LocaleKeys.ok.tr(),
                                                          btnCancelText: LocaleKeys.cancel.tr(),
                                                          dialogType: DialogType.warning,
                                                          animType: AnimType.RIGHSLIDE,
                                                          title: LocaleKeys.warning.tr(),
                                                          desc: LocaleKeys
                                                              .pleaseSelectSubCategoryFirst
                                                              .tr(),
                                                          btnCancelOnPress: () {
                                                            //  _getCurrentLocation();
                                                          },
                                                          btnOkOnPress: () {
                                                            // _getCurrentLocation();
                                                          },
                                                        ).show();
                                                      }
                                                    }
                                                    else if (filterCubit.selectedMainCategory!.name!.en!.contains('Kids & Babies')) {
                                                      if (filterCubit.selectedSubCategory?.id != null) {

                                                        print('Translated: kids selectedss ${filterCubit.selectedOptionsValueKids}');

                                                        Navigator.of(context).push(
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    FilterResultScreen(
                                                                      categoryId: filterCubit.selectedMainCategory?.id.toString(),
                                                                      categoryName: filterCubit.selectedMainCategory?.name?.en,
                                                                      subCategory: filterCubit.selectedSubCategory?.id.toString(),
                                                                      latitude: null,
                                                                      longitude: null,
                                                                      status: filterCubit.selectedOptionsValueConditionKids,
                                                                      locationUser: locationUserController.text,
                                                                      typeKids: filterCubit.selectedOptionsValueKids,
                                                                      distance: dropdownValue,
                                                                      governmentId: widget.governmentId,
                                                                      governmentName: widget.governmentName,
                                                                      fromPrice: fromPriceController.text,
                                                                      toPrice: toPriceController.text,
                                                                      cityId: widget.cityId,
                                                                      cityName: widget.cityName,
                                                                      areaId: widget.areaId,
                                                                      areaName: widget.areaName,
                                                                    )));

                                                      } else {
                                                        AwesomeDialog(
                                                          context: context,
                                                          btnOkText: LocaleKeys.ok.tr(),
                                                          btnCancelText: LocaleKeys.cancel.tr(),
                                                          dialogType: DialogType.warning,
                                                          animType: AnimType.RIGHSLIDE,
                                                          title: LocaleKeys.warning.tr(),
                                                          desc: LocaleKeys
                                                              .pleaseSelectSubCategoryFirst
                                                              .tr(),
                                                          btnCancelOnPress: () {
                                                            //  _getCurrentLocation();
                                                          },
                                                          btnOkOnPress: () {
                                                            // _getCurrentLocation();
                                                          },
                                                        ).show();
                                                      }
                                                    }
                                                    else if (filterCubit.selectedMainCategory!.name!.en!.contains('Business - Industrial - Agriculture')) {
                                                      // if (filterCubit.selectedOptionsValueConditionAllCategory == 'Used') {statusUser = '0';
                                                      // } else if (filterCubit
                                                      //     .selectedOptionsValueConditionAllCategory ==
                                                      //     'New') {
                                                      //   statusUser = '1';
                                                      // } else {
                                                      //   statusUser = '';
                                                      // }

                                                      if (filterCubit.selectedSubCategory?.id !=
                                                          null) {

                                                        Navigator.of(context).push(
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    FilterResultScreen(
                                                                      categoryId: filterCubit.selectedMainCategory?.id.toString(),
                                                                      categoryName: filterCubit.selectedMainCategory?.name?.en,
                                                                      subCategory: filterCubit.selectedSubCategory?.id.toString(),
                                                                      typeBusiness: filterCubit.selectedOptionsValueBusiness,
                                                                      latitude: null,
                                                                      longitude: null,
                                                                      status: filterCubit.selectedOptionsValueConditionBusiness,
                                                                      locationUser: locationUserController.text,
                                                                      distance: dropdownValue,
                                                                      governmentId: widget.governmentId,
                                                                      governmentName: widget.governmentName,
                                                                      fromPrice: fromPriceController.text,
                                                                      toPrice: toPriceController.text,
                                                                      cityId: widget.cityId,
                                                                      cityName: widget.cityName,
                                                                      areaId: widget.areaId,
                                                                      areaName: widget.areaName,
                                                                    )));

                                                      } else {
                                                        AwesomeDialog(
                                                          context: context,
                                                          btnOkText: LocaleKeys.ok.tr(),
                                                          btnCancelText: LocaleKeys.cancel.tr(),
                                                          dialogType: DialogType.warning,
                                                          animType: AnimType.RIGHSLIDE,
                                                          title: LocaleKeys.warning.tr(),
                                                          desc: LocaleKeys
                                                              .pleaseSelectSubCategoryFirst
                                                              .tr(),
                                                          btnCancelOnPress: () {
                                                            //  _getCurrentLocation();
                                                          },
                                                          btnOkOnPress: () {
                                                            // _getCurrentLocation();
                                                          },
                                                        ).show();
                                                      }
                                                    }

                                                  }

                                                }else {

                                                  if (filterCubit.selectedMainCategory!.name!.en!.contains('Vehicles')) {

                                                    // print('statusUser is');
                                                    // print('brandId id $brandId');
                                                    // print('selectedBrand fuelType ${filterCubit.selectedOptionsValueFuelTypeVehicles}');
                                                    // print('selectedBrand year ${widget
                                                    //     .fromYear}');
                                                    // print('selectedBrand kilo ${widget
                                                    //     .kiloMetresType}');
                                                    // print('selectedBrand trans ${filterCubit
                                                    //     .selectedOptionsValueTransmissionTypeVehicles}');
                                                    // print('selectedBrand color ${filterCubit
                                                    //     .selectedOptionsValueColorVehicles}');
                                                    // print(
                                                    //     'selectedBrand bodyType ${filterCubit
                                                    //         .selectedOptionsValueBodyTypeVehicles}');
                                                    // print('selectedBrand engin ${filterCubit
                                                    //     .selectedOptionsValueEngineCapacityVehicles}');
                                                    // print(
                                                    //     'selectedBrand model ${addProductController
                                                    //         .dropdownValueBrand}');
                                                    // print(
                                                    //     'selectedSubCategory id ${filterCubit
                                                    //         .selectedOptionsValueConditionAllCategory}');
                                                    // print(
                                                    //     'selectedCategory id $dropdownValue');

                                                    print('selectedCategory id ${filterCubit.selectedMainCategory!.name!.en}');
                                                    print('selectedCategory id ${filterCubit.selectedMainCategory!.id}');
                                                    print('selectedCategory id ${filterCubit.selectedSubCategory?.id}');

                                                    if (filterCubit.selectedSubCategory?.id != null) {

                                                      if(widget.fromYear == null && widget.toYear == null){
                                                        print('fromYear == null');
                                                        Navigator.of(context).push(
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                                  FilterResultScreen(
                                                                    categoryId: filterCubit.selectedMainCategory?.id.toString(),
                                                                    categoryName: filterCubit.selectedMainCategory?.name?.en,
                                                                    subCategory: filterCubit.selectedSubCategory?.id.toString(),
                                                                    brandId: brandId,
                                                                    brandName: brandName,
                                                                    brandModel: addProductController.selectedBrand,
                                                                    latitude: null,
                                                                    longitude: null,
                                                                    locationUser: locationUserController.text,
                                                                    fuelType: filterCubit.selectedOptionsValueFuelTypeVehicles,
                                                                    bodyType: filterCubit.selectedOptionsValueBodyTypeVehicles,
                                                                    engineCapacityType: filterCubit.selectedOptionsValueEngineCapacityVehicles,
                                                                    fromYear: widget.fromYear,
                                                                    toKilometersType: widget.tokiloMetresType,
                                                                    toYear: widget.toYear,
                                                                    fromKilometersType: widget.fromkiloMetresType,
                                                                    transmissionVehicles: filterCubit.selectedOptionsValueTransmissionTypeVehicles,
                                                                    colorVehicles: filterCubit.selectedOptionsValueColorVehicles,
                                                                    status: filterCubit.selectedOptionsValueConditionVehicles,
                                                                    distance: dropdownValue,
                                                                    governmentId: widget.governmentId,
                                                                    governmentName: widget.governmentName,
                                                                    fromPrice: fromPriceController.text,
                                                                    toPrice: toPriceController.text,
                                                                    cityId: widget.cityId,
                                                                    cityName: widget.cityName,
                                                                    areaId: widget.areaId,
                                                                    data: 'filterScreen',
                                                                    areaName: widget.areaName,
                                                                    nameProduct: '',
                                                                    description: '',
                                                                  ),
                                                            ));

                                                      }else if (widget.fromYear != null && widget.toYear == null){
                                                        print('fromYear == nulls');
                                                        AwesomeDialog(
                                                          context: context,
                                                          btnOkText: LocaleKeys.ok.tr(),
                                                          btnCancelText: LocaleKeys.cancel.tr(),
                                                          dialogType: DialogType.warning,
                                                          animType: AnimType.RIGHSLIDE,
                                                          title: LocaleKeys.warning.tr(),
                                                          desc: LocaleKeys.pleaseSelectYearFirst.tr(),
                                                          btnCancelOnPress: () {
                                                            //  _getCurrentLocation();
                                                          },
                                                          btnOkOnPress: () {
                                                            // _getCurrentLocation();
                                                          },
                                                        ).show();

                                                      } else if(widget.fromYear != null && widget.toYear != null){
                                                        print('fromYear == nullsss');
                                                        if(widget.fromYear!.compareTo(widget.toYear!) >=  0){
                                                          print('fromYear == nullssddds');
                                                          AwesomeDialog(
                                                            context: context,
                                                            btnOkText: LocaleKeys.ok.tr(),
                                                            btnCancelText: LocaleKeys.cancel.tr(),
                                                            dialogType: DialogType.warning,
                                                            animType: AnimType.RIGHSLIDE,
                                                            title: LocaleKeys.warning.tr(),
                                                            desc: LocaleKeys.pleaseSelectYearFirst.tr(),
                                                            btnCancelOnPress: () {
                                                              //  _getCurrentLocation();
                                                            },
                                                            btnOkOnPress: () {
                                                              // _getCurrentLocation();
                                                            },
                                                          ).show();
                                                        }else if(widget.fromYear!.compareTo(widget.toYear!) < 0){


                                                          if(widget.fromkiloMetresType == null && widget.tokiloMetresType == null){
                                                            print('fromkiloMetresType == null');
                                                            Navigator.of(context).push(
                                                                MaterialPageRoute(
                                                                  builder: (context) =>
                                                                      FilterResultScreen(
                                                                        categoryId: filterCubit.selectedMainCategory?.id.toString(),
                                                                        categoryName: filterCubit.selectedMainCategory?.name?.en,
                                                                        subCategory: filterCubit.selectedSubCategory?.id.toString(),
                                                                        brandId: brandId,
                                                                        brandName: brandName,
                                                                        brandModel: addProductController.selectedBrand,
                                                                        latitude: null,
                                                                        longitude: null,
                                                                        locationUser: locationUserController.text,
                                                                        fuelType: filterCubit.selectedOptionsValueFuelTypeVehicles,
                                                                        bodyType: filterCubit.selectedOptionsValueBodyTypeVehicles,
                                                                        engineCapacityType: filterCubit.selectedOptionsValueEngineCapacityVehicles,
                                                                        fromYear: widget.fromYear,
                                                                        toKilometersType: widget.tokiloMetresType,
                                                                        toYear: widget.toYear,
                                                                        fromKilometersType: widget.fromkiloMetresType,
                                                                        transmissionVehicles: filterCubit.selectedOptionsValueTransmissionTypeVehicles,
                                                                        colorVehicles: filterCubit.selectedOptionsValueColorVehicles,
                                                                        status: filterCubit.selectedOptionsValueConditionVehicles,
                                                                        distance: dropdownValue,
                                                                        governmentId: widget.governmentId,
                                                                        governmentName: widget.governmentName,
                                                                        fromPrice: fromPriceController.text,
                                                                        toPrice: toPriceController.text,
                                                                        cityId: widget.cityId,
                                                                        cityName: widget.cityName,
                                                                        areaId: widget.areaId,
                                                                        data: 'filterScreen',
                                                                        areaName: widget.areaName,
                                                                        nameProduct: '',
                                                                        description: '',
                                                                      ),
                                                                ));

                                                          }else if (widget.fromkiloMetresType != null && widget.tokiloMetresType == null){
                                                            print('fromkiloMetresType == nulls');
                                                            AwesomeDialog(
                                                              context: context,
                                                              btnOkText: LocaleKeys.ok.tr(),
                                                              btnCancelText: LocaleKeys.cancel.tr(),
                                                              dialogType: DialogType.warning,
                                                              animType: AnimType.RIGHSLIDE,
                                                              title: LocaleKeys.warning.tr(),
                                                              desc: LocaleKeys.pleaseSelectKiloMetersFirst.tr(),
                                                              btnCancelOnPress: () {
                                                                //  _getCurrentLocation();
                                                              },
                                                              btnOkOnPress: () {
                                                                // _getCurrentLocation();
                                                              },
                                                            ).show();

                                                          } else if(widget.fromkiloMetresType != null && widget.tokiloMetresType != null){
                                                            print('fromkiloMetresType == nullsss');
                                                            if(widget.fromkiloMetresType!.compareTo(widget.tokiloMetresType!) >= 0){
                                                              print('fromkiloMetresType == nullssddds');
                                                              AwesomeDialog(
                                                                context: context,
                                                                btnOkText: LocaleKeys.ok.tr(),
                                                                btnCancelText: LocaleKeys.cancel.tr(),
                                                                dialogType: DialogType.warning,
                                                                animType: AnimType.RIGHSLIDE,
                                                                title: LocaleKeys.warning.tr(),
                                                                desc: LocaleKeys.pleaseSelectKiloMetersFirst.tr(),
                                                                btnCancelOnPress: () {
                                                                  //  _getCurrentLocation();
                                                                },
                                                                btnOkOnPress: () {
                                                                  // _getCurrentLocation();
                                                                },
                                                              ).show();
                                                            }else if(widget.fromkiloMetresType!.compareTo(widget.tokiloMetresType!) < 0){
                                                              Navigator.of(context).push(
                                                                  MaterialPageRoute(
                                                                    builder: (context) =>
                                                                        FilterResultScreen(
                                                                          categoryId: filterCubit.selectedMainCategory?.id.toString(),
                                                                          categoryName: filterCubit.selectedMainCategory!.name!.en,
                                                                          subCategory: filterCubit.selectedSubCategory?.id.toString(),
                                                                          brandId: brandId,
                                                                          brandName: brandName,
                                                                          brandModel: addProductController.selectedBrand,
                                                                          latitude: null,
                                                                          longitude: null,
                                                                          locationUser: locationUserController.text,
                                                                          fuelType: filterCubit.selectedOptionsValueFuelTypeVehicles,
                                                                          bodyType: filterCubit.selectedOptionsValueBodyTypeVehicles,
                                                                          engineCapacityType: filterCubit.selectedOptionsValueEngineCapacityVehicles,
                                                                          fromYear: widget.fromYear,
                                                                          toKilometersType: widget.tokiloMetresType,
                                                                          toYear: widget.toYear,
                                                                          fromKilometersType: widget.fromkiloMetresType,
                                                                          transmissionVehicles: filterCubit.selectedOptionsValueTransmissionTypeVehicles,
                                                                          colorVehicles: filterCubit.selectedOptionsValueColorVehicles,
                                                                          status: filterCubit.selectedOptionsValueConditionVehicles,
                                                                          distance: dropdownValue,
                                                                          governmentId: widget.governmentId,
                                                                          governmentName: widget.governmentName,
                                                                          fromPrice: fromPriceController.text,
                                                                          toPrice: toPriceController.text,
                                                                          cityId: widget.cityId,
                                                                          cityName: widget.cityName,
                                                                          areaId: widget.areaId,
                                                                          data: 'filterScreen',
                                                                          areaName: widget.areaName,
                                                                          nameProduct: '',
                                                                          description: '',
                                                                        ),
                                                                  ));

                                                            }

                                                          }
                                                        }
                                                      }

                                                    } else {
                                                      AwesomeDialog(
                                                        context: context,
                                                        btnOkText: LocaleKeys.ok.tr(),
                                                        btnCancelText: LocaleKeys.cancel.tr(),
                                                        dialogType: DialogType.warning,
                                                        animType: AnimType.RIGHSLIDE,
                                                        title: LocaleKeys.warning.tr(),
                                                        desc: LocaleKeys
                                                            .pleaseSelectSubCategoryFirst
                                                            .tr(),
                                                        btnCancelOnPress: () {
                                                          //  _getCurrentLocation();
                                                        },
                                                        btnOkOnPress: () {
                                                          // _getCurrentLocation();
                                                        },
                                                      ).show();
                                                    }
                                                  }
                                                  else if (filterCubit.selectedMainCategory!.name!.en!.contains('Properties')) {


                                                    // print('selectedSubCategory id ${filterCubit
                                                    //     .selectedOptionsValueConditionElectronics}');
                                                    print('selectedCategory id $dropdownValue');
                                                    print('selectedCategory id ${filterCubit.selectedOptionsValueWarrantyElectronics}');

                                                    if (filterCubit.selectedSubCategory?.id != null) {

                                                      Navigator.of(context).push(
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                FilterResultScreen(
                                                                  categoryId: filterCubit.selectedMainCategory?.id.toString(),
                                                                  categoryName: filterCubit.selectedMainCategory?.name?.en,
                                                                  subCategory: filterCubit.selectedSubCategory?.id.toString(),
                                                                  latitude: null,
                                                                  longitude: null,
                                                                  distance: dropdownValue,
                                                                  locationUser: locationUserController.text,
                                                                  fromArea: fromAreaPropertiesController.text,
                                                                  toArea: toAreaPropertiesController.text,
                                                                  //  status: filterCubit.selectedOptionsValueConditionAllCategory,
                                                                  typeProperties: filterCubit.selectedOptionsValueTypeProperties,
                                                                  typeApartment: filterCubit.selectedOptionsValueTypeApartmentProperties,
                                                                  bedroom: filterCubit.selectedOptionsValueBedroomProperties,
                                                                  bathroom: filterCubit.selectedOptionsValueBathRoomProperties,
                                                                  levelType: filterCubit.selectedOptionsValueLevelProperties,
                                                                  // statusApartment: filterCubit.selectedOptionsValueTypeApartmentProperties,
                                                                  furnishedProperties: filterCubit.selectedOptionsValueFurnishedProperties,
                                                                  amenitiesType: filterCubit.selectedOptionsValueAmenitiesProperties,
                                                                  fromDownPayment: fromDownPaymentController.text,
                                                                  toDownPayment: toDownPaymentController.text,
                                                                  governmentId: widget.governmentId,
                                                                  governmentName: widget.governmentName,
                                                                  fromPrice: fromPriceController.text,
                                                                  toPrice: toPriceController.text,
                                                                  cityId: widget.cityId,
                                                                  cityName: widget.cityName,
                                                                  areaId: widget.areaId,
                                                                  data: 'filterScreen',
                                                                  areaName: widget.areaName,
                                                                  nameProduct: '',
                                                                  description: '',
                                                                ),
                                                          ));


                                                    } else {
                                                      AwesomeDialog(
                                                        context: context,
                                                        btnOkText: LocaleKeys.ok.tr(),
                                                        btnCancelText: LocaleKeys.cancel.tr(),
                                                        dialogType: DialogType.warning,
                                                        animType: AnimType.RIGHSLIDE,
                                                        title: LocaleKeys.warning.tr(),
                                                        desc: LocaleKeys
                                                            .pleaseSelectSubCategoryFirst
                                                            .tr(),
                                                        btnCancelOnPress: () {
                                                          //  _getCurrentLocation();
                                                        },
                                                        btnOkOnPress: () {
                                                          // _getCurrentLocation();
                                                        },
                                                      ).show();
                                                    }
                                                  }
                                                  else if (filterCubit.selectedMainCategory!.name!.en!.contains('Electronics')) {


                                                    if (filterCubit.selectedSubCategory?.id != null) {
                                                      // CacheHelper.saveData(key: 'statusUser',
                                                      //     value: filterCubit
                                                      //         .selectedOptionsValueConditionAllCategory);

                                                      Navigator.of(context).push(
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                FilterResultScreen(
                                                                  categoryId: filterCubit.selectedMainCategory?.id.toString(),
                                                                  categoryName: filterCubit.selectedMainCategory?.name?.en,
                                                                  subCategory: filterCubit.selectedSubCategory?.id.toString(),
                                                                  brandId: brandId,
                                                                  brandName: brandName,
                                                                  locationUser: locationUserController.text,
                                                                  brandModel: addProductController.selectedBrand,
                                                                  latitude: null,
                                                                  longitude: null,
                                                                  status: filterCubit.selectedOptionsValueConditionElectronics,
                                                                  distance: dropdownValue,
                                                                  warrantyElectronic: filterCubit.selectedOptionsValueWarrantyElectronics,
                                                                  governmentId: widget.governmentId,
                                                                  governmentName: widget.governmentName,
                                                                  fromPrice: fromPriceController.text,
                                                                  toPrice: toPriceController.text,
                                                                  cityId: widget.cityId,
                                                                  cityName: widget.cityName,
                                                                  areaId: widget.areaId,
                                                                  data: 'filterScreen',
                                                                  areaName: widget.areaName,
                                                                  nameProduct: '',
                                                                  description: '',
                                                                ),
                                                          ));

                                                    } else {
                                                      AwesomeDialog(
                                                        context: context,
                                                        btnOkText: LocaleKeys.ok.tr(),
                                                        btnCancelText: LocaleKeys.cancel.tr(),
                                                        dialogType: DialogType.warning,
                                                        animType: AnimType.RIGHSLIDE,
                                                        title: LocaleKeys.warning.tr(),
                                                        desc: LocaleKeys
                                                            .pleaseSelectSubCategoryFirst
                                                            .tr(),
                                                        btnCancelOnPress: () {
                                                          //  _getCurrentLocation();
                                                        },
                                                        btnOkOnPress: () {
                                                          // _getCurrentLocation();
                                                        },
                                                      ).show();
                                                    }
                                                  }
                                                  else if (filterCubit.selectedMainCategory!.name!.en!.contains('Fashion')) {

                                                    print('FashionName');
                                                    print(filterCubit.selectedMainCategory?.name?.en);
                                                    print(filterCubit.selectedOptionsValueFashion);

                                                    if (filterCubit.selectedSubCategory?.id !=
                                                        null) {

                                                      Navigator.of(context).push(
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                FilterResultScreen(
                                                                  categoryId: filterCubit.selectedMainCategory?.id.toString(),
                                                                  categoryName: filterCubit.selectedMainCategory?.name?.en,
                                                                  subCategory: filterCubit.selectedSubCategory?.id.toString(),
                                                                  distance: dropdownValue,
                                                                  locationUser: locationUserController.text,
                                                                  typeFashion: filterCubit.selectedOptionsValueFashion,
                                                                  status: filterCubit.selectedOptionsValueConditionFashion,
                                                                  governmentId: widget.governmentId,
                                                                  governmentName: widget.governmentName,
                                                                  fromPrice: fromPriceController.text,
                                                                  toPrice: toPriceController.text,
                                                                  cityId: widget.cityId,
                                                                  cityName: widget.cityName,
                                                                  areaId: widget.areaId,
                                                                  areaName: widget.areaName,
                                                                ),
                                                          ));


                                                      // final input = filterCubit.selectedOptionsValueFashion;
                                                      //
                                                      // print("Source: $input");
                                                      //
                                                      // translator
                                                      //     .translate(filterCubit
                                                      //     .selectedOptionsValueFashion == ''
                                                      //     ? '-'
                                                      //     : input, to: 'en')
                                                      //     .then((result) {
                                                      //
                                                      //
                                                      //   print(
                                                      //       "Source: $input\nTranslated: $result");
                                                      // });


                                                    } else {
                                                      AwesomeDialog(
                                                        context: context,
                                                        btnOkText: LocaleKeys.ok.tr(),
                                                        btnCancelText: LocaleKeys.cancel.tr(),
                                                        dialogType: DialogType.warning,
                                                        animType: AnimType.RIGHSLIDE,
                                                        title: LocaleKeys.warning.tr(),
                                                        desc: LocaleKeys
                                                            .pleaseSelectSubCategoryFirst
                                                            .tr(),
                                                        btnCancelOnPress: () {
                                                          //  _getCurrentLocation();
                                                        },
                                                        btnOkOnPress: () {
                                                          // _getCurrentLocation();
                                                        },
                                                      ).show();
                                                    }
                                                  }
                                                  else if (filterCubit.selectedMainCategory!.name!.en!.contains('Home Furniture')) {

                                                    if (filterCubit.selectedSubCategory?.id != null) {


                                                      Navigator.of(context).push(
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  FilterResultScreen(
                                                                    categoryId: filterCubit.selectedMainCategory?.id.toString(),
                                                                    categoryName: filterCubit.selectedMainCategory?.name?.en,
                                                                    subCategory: filterCubit.selectedSubCategory?.id.toString(),
                                                                    typeHomeFurniture: filterCubit.selectedOptionsValueHomeFurniture,
                                                                    latitude: null,
                                                                    longitude: null,
                                                                    status: filterCubit.selectedOptionsValueConditionHomeFurniture,
                                                                    locationUser: locationUserController.text,
                                                                    distance: dropdownValue,
                                                                    governmentId: widget.governmentId,
                                                                    governmentName: widget.governmentName,
                                                                    fromPrice: fromPriceController.text,
                                                                    toPrice: toPriceController.text,
                                                                    cityId: widget.cityId,
                                                                    cityName: widget.cityName,
                                                                    areaId: widget.areaId,
                                                                    areaName: widget.areaName,
                                                                  )));

                                                    } else {
                                                      AwesomeDialog(
                                                        context: context,
                                                        btnOkText: LocaleKeys.ok.tr(),
                                                        btnCancelText: LocaleKeys.cancel.tr(),
                                                        dialogType: DialogType.warning,
                                                        animType: AnimType.RIGHSLIDE,
                                                        title: LocaleKeys.warning.tr(),
                                                        desc: LocaleKeys
                                                            .pleaseSelectSubCategoryFirst
                                                            .tr(),
                                                        btnCancelOnPress: () {
                                                          //  _getCurrentLocation();
                                                        },
                                                        btnOkOnPress: () {
                                                          // _getCurrentLocation();
                                                        },
                                                      ).show();
                                                    }
                                                  }
                                                  else if (filterCubit.selectedMainCategory!.name!.en!.contains('Books, Sports & Hobbies')) {

                                                    if (filterCubit.selectedSubCategory?.id != null) {
                                                      Navigator.of(context).push(
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  FilterResultScreen(
                                                                    categoryId: filterCubit.selectedMainCategory?.id.toString(),
                                                                    categoryName: filterCubit.selectedMainCategory?.name?.en,
                                                                    subCategory: filterCubit.selectedSubCategory?.id.toString(),
                                                                    typeBooks: filterCubit.selectedOptionsValueBooks,
                                                                    latitude: null,
                                                                    longitude: null,
                                                                    status: filterCubit.selectedOptionsValueConditionBooks,
                                                                    locationUser: locationUserController.text,
                                                                    distance: dropdownValue,
                                                                    governmentId: widget.governmentId,
                                                                    governmentName: widget.governmentName,
                                                                    fromPrice: fromPriceController.text,
                                                                    toPrice: toPriceController.text,
                                                                    cityId: widget.cityId,
                                                                    cityName: widget.cityName,
                                                                    areaId: widget.areaId,
                                                                    areaName: widget.areaName,
                                                                  )));

                                                    } else {
                                                      AwesomeDialog(
                                                        context: context,
                                                        btnOkText: LocaleKeys.ok.tr(),
                                                        btnCancelText: LocaleKeys.cancel.tr(),
                                                        dialogType: DialogType.warning,
                                                        animType: AnimType.RIGHSLIDE,
                                                        title: LocaleKeys.warning.tr(),
                                                        desc: LocaleKeys
                                                            .pleaseSelectSubCategoryFirst
                                                            .tr(),
                                                        btnCancelOnPress: () {
                                                          //  _getCurrentLocation();
                                                        },
                                                        btnOkOnPress: () {
                                                          // _getCurrentLocation();
                                                        },
                                                      ).show();
                                                    }
                                                  }
                                                  else if (filterCubit.selectedMainCategory!.name!.en!.contains('Kids & Babies')) {
                                                    if (filterCubit.selectedSubCategory?.id != null) {

                                                      print('Translated: kids selectedss ${filterCubit.selectedOptionsValueKids}');

                                                      Navigator.of(context).push(
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  FilterResultScreen(
                                                                    categoryId: filterCubit.selectedMainCategory?.id.toString(),
                                                                    categoryName: filterCubit.selectedMainCategory?.name?.en,
                                                                    subCategory: filterCubit.selectedSubCategory?.id.toString(),
                                                                    latitude: null,
                                                                    longitude: null,
                                                                    status: filterCubit.selectedOptionsValueConditionKids,
                                                                    locationUser: locationUserController.text,
                                                                    typeKids: filterCubit.selectedOptionsValueKids,
                                                                    distance: dropdownValue,
                                                                    governmentId: widget.governmentId,
                                                                    governmentName: widget.governmentName,
                                                                    fromPrice: fromPriceController.text,
                                                                    toPrice: toPriceController.text,
                                                                    cityId: widget.cityId,
                                                                    cityName: widget.cityName,
                                                                    areaId: widget.areaId,
                                                                    areaName: widget.areaName,
                                                                  )));

                                                    } else {
                                                      AwesomeDialog(
                                                        context: context,
                                                        btnOkText: LocaleKeys.ok.tr(),
                                                        btnCancelText: LocaleKeys.cancel.tr(),
                                                        dialogType: DialogType.warning,
                                                        animType: AnimType.RIGHSLIDE,
                                                        title: LocaleKeys.warning.tr(),
                                                        desc: LocaleKeys
                                                            .pleaseSelectSubCategoryFirst
                                                            .tr(),
                                                        btnCancelOnPress: () {
                                                          //  _getCurrentLocation();
                                                        },
                                                        btnOkOnPress: () {
                                                          // _getCurrentLocation();
                                                        },
                                                      ).show();
                                                    }
                                                  }
                                                  else if (filterCubit.selectedMainCategory!.name!.en!.contains('Business - Industrial - Agriculture')) {
                                                    // if (filterCubit.selectedOptionsValueConditionAllCategory == 'Used') {statusUser = '0';
                                                    // } else if (filterCubit
                                                    //     .selectedOptionsValueConditionAllCategory ==
                                                    //     'New') {
                                                    //   statusUser = '1';
                                                    // } else {
                                                    //   statusUser = '';
                                                    // }

                                                    if (filterCubit.selectedSubCategory?.id !=
                                                        null) {

                                                      Navigator.of(context).push(
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  FilterResultScreen(
                                                                    categoryId: filterCubit.selectedMainCategory?.id.toString(),
                                                                    categoryName: filterCubit.selectedMainCategory?.name?.en,
                                                                    subCategory: filterCubit.selectedSubCategory?.id.toString(),
                                                                    typeBusiness: filterCubit.selectedOptionsValueBusiness,
                                                                    latitude: null,
                                                                    longitude: null,
                                                                    status: filterCubit.selectedOptionsValueConditionBusiness,
                                                                    locationUser: locationUserController.text,
                                                                    distance: dropdownValue,
                                                                    governmentId: widget.governmentId,
                                                                    governmentName: widget.governmentName,
                                                                    fromPrice: fromPriceController.text,
                                                                    toPrice: toPriceController.text,
                                                                    cityId: widget.cityId,
                                                                    cityName: widget.cityName,
                                                                    areaId: widget.areaId,
                                                                    areaName: widget.areaName,
                                                                  )));

                                                    } else {
                                                      AwesomeDialog(
                                                        context: context,
                                                        btnOkText: LocaleKeys.ok.tr(),
                                                        btnCancelText: LocaleKeys.cancel.tr(),
                                                        dialogType: DialogType.warning,
                                                        animType: AnimType.RIGHSLIDE,
                                                        title: LocaleKeys.warning.tr(),
                                                        desc: LocaleKeys
                                                            .pleaseSelectSubCategoryFirst
                                                            .tr(),
                                                        btnCancelOnPress: () {
                                                          //  _getCurrentLocation();
                                                        },
                                                        btnOkOnPress: () {
                                                          // _getCurrentLocation();
                                                        },
                                                      ).show();
                                                    }
                                                  }

                                                }

                                              }
                                              else {

                                                if(widget.governmentName == null){
                                                  AwesomeDialog(
                                                    context: context,
                                                    btnOkText: LocaleKeys.ok.tr(),
                                                    btnCancelText: LocaleKeys.cancel.tr(),
                                                    dialogType: DialogType.warning,
                                                    animType: AnimType.RIGHSLIDE,
                                                    title: LocaleKeys.warning.tr(),
                                                    desc: LocaleKeys.selectYourLocation.tr(),
                                                    btnCancelOnPress: () {
                                                      //  _getCurrentLocation();
                                                    },
                                                    btnOkOnPress: () {
                                                      // _getCurrentLocation();
                                                    },
                                                  ).show();
                                                } else {
                                                  print('dropdownValue is $dropdownValue');
                                                  print('location lat is ${filterCubit.mapLocationModel?.lat.toString()}');
                                                  print('location lng is ${filterCubit.mapLocationModel?.lat.toString()}');

                                                  if (filterCubit.selectedMainCategory!.name!.en!.contains('Vehicles')) {

                                                    // print('statusUser is');
                                                    // print('brandId id $brandId');
                                                    // print('selectedBrand fuelType ${filterCubit.selectedOptionsValueFuelTypeVehicles}');
                                                    // print('selectedBrand year ${widget
                                                    //     .fromYear}');
                                                    // print('selectedBrand kilo ${widget
                                                    //     .kiloMetresType}');
                                                    // print('selectedBrand trans ${filterCubit
                                                    //     .selectedOptionsValueTransmissionTypeVehicles}');
                                                    // print('selectedBrand color ${filterCubit
                                                    //     .selectedOptionsValueColorVehicles}');
                                                    // print(
                                                    //     'selectedBrand bodyType ${filterCubit
                                                    //         .selectedOptionsValueBodyTypeVehicles}');
                                                    // print('selectedBrand engin ${filterCubit
                                                    //     .selectedOptionsValueEngineCapacityVehicles}');
                                                    // print(
                                                    //     'selectedBrand model ${addProductController
                                                    //         .dropdownValueBrand}');
                                                    // print(
                                                    //     'selectedSubCategory id ${filterCubit
                                                    //         .selectedOptionsValueConditionAllCategory}');
                                                    // print(
                                                    //     'selectedCategory id $dropdownValue');

                                                    print('selectedCategory id ${filterCubit.selectedMainCategory!.name!.en}');
                                                    print('selectedCategory id ${filterCubit.selectedMainCategory!.id}');
                                                    print('selectedCategory id ${filterCubit.selectedSubCategory?.id}');

                                                    if (filterCubit.selectedSubCategory?.id != null) {

                                                      if(widget.fromYear == null && widget.toYear == null){
                                                        print('fromYear == null');
                                                        Navigator.of(context).push(
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                                  FilterResultScreen(
                                                                    categoryId: filterCubit.selectedMainCategory?.id.toString(),
                                                                    categoryName: filterCubit.selectedMainCategory?.name?.en,
                                                                    subCategory: filterCubit.selectedSubCategory?.id.toString(),
                                                                    brandId: brandId,
                                                                    brandName: brandName,
                                                                    locationUser: locationUserController.text,
                                                                    brandModel: addProductController.selectedBrand,
                                                                    latitude: filterCubit.mapLocationModel?.lat.toString(),
                                                                    longitude: filterCubit.mapLocationModel?.lng.toString(),
                                                                    fuelType: filterCubit.selectedOptionsValueFuelTypeVehicles,
                                                                    bodyType: filterCubit.selectedOptionsValueBodyTypeVehicles,
                                                                    engineCapacityType: filterCubit.selectedOptionsValueEngineCapacityVehicles,
                                                                    fromYear: widget.fromYear,
                                                                    toKilometersType: widget.tokiloMetresType,
                                                                    toYear: widget.toYear,
                                                                    fromKilometersType: widget.fromkiloMetresType,
                                                                    transmissionVehicles: filterCubit.selectedOptionsValueTransmissionTypeVehicles,
                                                                    colorVehicles: filterCubit.selectedOptionsValueColorVehicles,
                                                                    status: filterCubit.selectedOptionsValueConditionVehicles,
                                                                    distance: dropdownValue,
                                                                    governmentId: widget.governmentId,
                                                                    governmentName: widget.governmentName,
                                                                    fromPrice: fromPriceController.text,
                                                                    toPrice: toPriceController.text,
                                                                    cityId: widget.cityId,
                                                                    cityName: widget.cityName,
                                                                    areaId: widget.areaId,
                                                                    data: 'filterScreen',
                                                                    areaName: widget.areaName,
                                                                    nameProduct: '',
                                                                    description: '',
                                                                  ),
                                                            ));

                                                      }else if (widget.fromYear != null && widget.toYear == null){
                                                        print('fromYear == nulls');
                                                        AwesomeDialog(
                                                          context: context,
                                                          btnOkText: LocaleKeys.ok.tr(),
                                                          btnCancelText: LocaleKeys.cancel.tr(),
                                                          dialogType: DialogType.warning,
                                                          animType: AnimType.RIGHSLIDE,
                                                          title: LocaleKeys.warning.tr(),
                                                          desc: LocaleKeys.pleaseSelectYearFirst.tr(),
                                                          btnCancelOnPress: () {
                                                            //  _getCurrentLocation();
                                                          },
                                                          btnOkOnPress: () {
                                                            // _getCurrentLocation();
                                                          },
                                                        ).show();

                                                      } else if(widget.fromYear != null && widget.toYear != null){
                                                        print('fromYear == nullsss');
                                                        if(widget.fromYear!.compareTo(widget.toYear!) >=  0){
                                                          print('fromYear == nullssddds');
                                                          AwesomeDialog(
                                                            context: context,
                                                            btnOkText: LocaleKeys.ok.tr(),
                                                            btnCancelText: LocaleKeys.cancel.tr(),
                                                            dialogType: DialogType.warning,
                                                            animType: AnimType.RIGHSLIDE,
                                                            title: LocaleKeys.warning.tr(),
                                                            desc: LocaleKeys.pleaseSelectYearFirst.tr(),
                                                            btnCancelOnPress: () {
                                                              //  _getCurrentLocation();
                                                            },
                                                            btnOkOnPress: () {
                                                              // _getCurrentLocation();
                                                            },
                                                          ).show();
                                                        }else if(widget.fromYear!.compareTo(widget.toYear!) < 0){


                                                          if(widget.fromkiloMetresType == null && widget.tokiloMetresType == null){
                                                            print('fromkiloMetresType == null');
                                                            Navigator.of(context).push(
                                                                MaterialPageRoute(
                                                                  builder: (context) =>
                                                                      FilterResultScreen(
                                                                        categoryId: filterCubit.selectedMainCategory?.id.toString(),
                                                                        categoryName: filterCubit.selectedMainCategory?.name?.en,
                                                                        subCategory: filterCubit.selectedSubCategory?.id.toString(),
                                                                        brandId: brandId,
                                                                        brandName: brandName,
                                                                        locationUser: locationUserController.text,
                                                                        brandModel: addProductController.selectedBrand,
                                                                        latitude: filterCubit.mapLocationModel?.lat.toString(),
                                                                        longitude: filterCubit.mapLocationModel?.lng.toString(),
                                                                        fuelType: filterCubit.selectedOptionsValueFuelTypeVehicles,
                                                                        bodyType: filterCubit.selectedOptionsValueBodyTypeVehicles,
                                                                        engineCapacityType: filterCubit.selectedOptionsValueEngineCapacityVehicles,
                                                                        fromYear: widget.fromYear,
                                                                        toKilometersType: widget.tokiloMetresType,
                                                                        toYear: widget.toYear,
                                                                        fromKilometersType: widget.fromkiloMetresType,
                                                                        transmissionVehicles: filterCubit.selectedOptionsValueTransmissionTypeVehicles,
                                                                        colorVehicles: filterCubit.selectedOptionsValueColorVehicles,
                                                                        status: filterCubit.selectedOptionsValueConditionVehicles,
                                                                        distance: dropdownValue,
                                                                        governmentId: widget.governmentId,
                                                                        governmentName: widget.governmentName,
                                                                        fromPrice: fromPriceController.text,
                                                                        toPrice: toPriceController.text,
                                                                        cityId: widget.cityId,
                                                                        cityName: widget.cityName,
                                                                        areaId: widget.areaId,
                                                                        data: 'filterScreen',
                                                                        areaName: widget.areaName,
                                                                        nameProduct: '',
                                                                        description: '',
                                                                      ),
                                                                ));

                                                          }else if (widget.fromkiloMetresType != null && widget.tokiloMetresType == null){
                                                            print('fromkiloMetresType == nulls');
                                                            AwesomeDialog(
                                                              context: context,
                                                              btnOkText: LocaleKeys.ok.tr(),
                                                              btnCancelText: LocaleKeys.cancel.tr(),
                                                              dialogType: DialogType.warning,
                                                              animType: AnimType.RIGHSLIDE,
                                                              title: LocaleKeys.warning.tr(),
                                                              desc: LocaleKeys.pleaseSelectKiloMetersFirst.tr(),
                                                              btnCancelOnPress: () {
                                                                //  _getCurrentLocation();
                                                              },
                                                              btnOkOnPress: () {
                                                                // _getCurrentLocation();
                                                              },
                                                            ).show();

                                                          } else if(widget.fromkiloMetresType != null && widget.tokiloMetresType != null){
                                                            print('fromkiloMetresType == nullsss');
                                                            if(widget.fromkiloMetresType!.compareTo(widget.tokiloMetresType!) >= 0){
                                                              print('fromkiloMetresType == nullssddds');
                                                              AwesomeDialog(
                                                                context: context,
                                                                btnOkText: LocaleKeys.ok.tr(),
                                                                btnCancelText: LocaleKeys.cancel.tr(),
                                                                dialogType: DialogType.warning,
                                                                animType: AnimType.RIGHSLIDE,
                                                                title: LocaleKeys.warning.tr(),
                                                                desc: LocaleKeys.pleaseSelectKiloMetersFirst.tr(),
                                                                btnCancelOnPress: () {
                                                                  //  _getCurrentLocation();
                                                                },
                                                                btnOkOnPress: () {
                                                                  // _getCurrentLocation();
                                                                },
                                                              ).show();
                                                            }else if(widget.fromkiloMetresType!.compareTo(widget.tokiloMetresType!) < 0){
                                                              Navigator.of(context).push(
                                                                  MaterialPageRoute(
                                                                    builder: (context) =>
                                                                        FilterResultScreen(
                                                                          categoryId: filterCubit.selectedMainCategory?.id.toString(),
                                                                          categoryName: filterCubit.selectedMainCategory!.name!.en,
                                                                          subCategory: filterCubit.selectedSubCategory?.id.toString(),
                                                                          brandId: brandId,
                                                                          brandName: brandName,
                                                                          locationUser: locationUserController.text,
                                                                          brandModel: addProductController.selectedBrand,
                                                                          latitude: filterCubit.mapLocationModel?.lat.toString(),
                                                                          longitude: filterCubit.mapLocationModel?.lng.toString(),
                                                                          fuelType: filterCubit.selectedOptionsValueFuelTypeVehicles,
                                                                          bodyType: filterCubit.selectedOptionsValueBodyTypeVehicles,
                                                                          engineCapacityType: filterCubit.selectedOptionsValueEngineCapacityVehicles,
                                                                          fromYear: widget.fromYear,
                                                                          toKilometersType: widget.tokiloMetresType,
                                                                          toYear: widget.toYear,
                                                                          fromKilometersType: widget.fromkiloMetresType,
                                                                          transmissionVehicles: filterCubit.selectedOptionsValueTransmissionTypeVehicles,
                                                                          colorVehicles: filterCubit.selectedOptionsValueColorVehicles,
                                                                          status: filterCubit.selectedOptionsValueConditionVehicles,
                                                                          distance: dropdownValue,
                                                                          governmentId: widget.governmentId,
                                                                          governmentName: widget.governmentName,
                                                                          fromPrice: fromPriceController.text,
                                                                          toPrice: toPriceController.text,
                                                                          cityId: widget.cityId,
                                                                          cityName: widget.cityName,
                                                                          areaId: widget.areaId,
                                                                          data: 'filterScreen',
                                                                          areaName: widget.areaName,
                                                                          nameProduct: '',
                                                                          description: '',
                                                                        ),
                                                                  ));

                                                            }

                                                          }
                                                        }
                                                      }

                                                    } else {
                                                      AwesomeDialog(
                                                        context: context,
                                                        btnOkText: LocaleKeys.ok.tr(),
                                                        btnCancelText: LocaleKeys.cancel.tr(),
                                                        dialogType: DialogType.warning,
                                                        animType: AnimType.RIGHSLIDE,
                                                        title: LocaleKeys.warning.tr(),
                                                        desc: LocaleKeys
                                                            .pleaseSelectSubCategoryFirst
                                                            .tr(),
                                                        btnCancelOnPress: () {
                                                          //  _getCurrentLocation();
                                                        },
                                                        btnOkOnPress: () {
                                                          // _getCurrentLocation();
                                                        },
                                                      ).show();
                                                    }
                                                  }
                                                  else if (filterCubit.selectedMainCategory!.name!.en!.contains('Properties')) {


                                                    // print('selectedSubCategory id ${filterCubit
                                                    //     .selectedOptionsValueConditionElectronics}');
                                                    print('selectedCategory id $dropdownValue');
                                                    print('selectedCategory id ${filterCubit.selectedOptionsValueWarrantyElectronics}');

                                                    if (filterCubit.selectedSubCategory?.id != null) {

                                                      Navigator.of(context).push(
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                FilterResultScreen(
                                                                  categoryId: filterCubit.selectedMainCategory?.id.toString(),
                                                                  categoryName: filterCubit.selectedMainCategory?.name?.en,
                                                                  subCategory: filterCubit.selectedSubCategory?.id.toString(),
                                                                  latitude: filterCubit.mapLocationModel?.lat.toString(),
                                                                  longitude: filterCubit.mapLocationModel?.lng.toString(),
                                                                  distance: dropdownValue,
                                                                  locationUser: locationUserController.text,
                                                                  fromArea: fromAreaPropertiesController.text,
                                                                  toArea: toAreaPropertiesController.text,
                                                                  //  status: filterCubit.selectedOptionsValueConditionAllCategory,
                                                                  typeProperties: filterCubit.selectedOptionsValueTypeProperties,
                                                                  typeApartment: filterCubit.selectedOptionsValueTypeApartmentProperties,
                                                                  bedroom: filterCubit.selectedOptionsValueBedroomProperties,
                                                                  bathroom: filterCubit.selectedOptionsValueBathRoomProperties,
                                                                  levelType: filterCubit.selectedOptionsValueLevelProperties,
                                                                  // statusApartment: filterCubit.selectedOptionsValueTypeApartmentProperties,
                                                                  furnishedProperties: filterCubit.selectedOptionsValueFurnishedProperties,
                                                                  amenitiesType: filterCubit.selectedOptionsValueAmenitiesProperties,
                                                                  fromDownPayment: fromDownPaymentController.text,
                                                                  toDownPayment: toDownPaymentController.text,
                                                                  governmentId: widget.governmentId,
                                                                  governmentName: widget.governmentName,
                                                                  fromPrice: fromPriceController.text,
                                                                  toPrice: toPriceController.text,
                                                                  cityId: widget.cityId,
                                                                  cityName: widget.cityName,
                                                                  areaId: widget.areaId,
                                                                  data: 'filterScreen',
                                                                  areaName: widget.areaName,
                                                                  nameProduct: '',
                                                                  description: '',
                                                                ),
                                                          ));


                                                    } else {
                                                      AwesomeDialog(
                                                        context: context,
                                                        btnOkText: LocaleKeys.ok.tr(),
                                                        btnCancelText: LocaleKeys.cancel.tr(),
                                                        dialogType: DialogType.warning,
                                                        animType: AnimType.RIGHSLIDE,
                                                        title: LocaleKeys.warning.tr(),
                                                        desc: LocaleKeys
                                                            .pleaseSelectSubCategoryFirst
                                                            .tr(),
                                                        btnCancelOnPress: () {
                                                          //  _getCurrentLocation();
                                                        },
                                                        btnOkOnPress: () {
                                                          // _getCurrentLocation();
                                                        },
                                                      ).show();
                                                    }
                                                  }
                                                  else if (filterCubit.selectedMainCategory!.name!.en!.contains('Electronics')) {


                                                    if (filterCubit.selectedSubCategory?.id != null) {
                                                      // CacheHelper.saveData(key: 'statusUser',
                                                      //     value: filterCubit
                                                      //         .selectedOptionsValueConditionAllCategory);

                                                      Navigator.of(context).push(
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                FilterResultScreen(
                                                                  categoryId: filterCubit.selectedMainCategory?.id.toString(),
                                                                  categoryName: filterCubit.selectedMainCategory?.name?.en,
                                                                  subCategory: filterCubit.selectedSubCategory?.id.toString(),
                                                                  brandId: brandId,
                                                                  brandName: brandName,
                                                                  locationUser: locationUserController.text,
                                                                  brandModel: addProductController.selectedBrand,
                                                                  latitude: filterCubit.mapLocationModel?.lat.toString(),
                                                                  longitude: filterCubit.mapLocationModel?.lng.toString(),
                                                                  status: filterCubit.selectedOptionsValueConditionElectronics,
                                                                  distance: dropdownValue,
                                                                  warrantyElectronic: filterCubit.selectedOptionsValueWarrantyElectronics,
                                                                  governmentId: widget.governmentId,
                                                                  governmentName: widget.governmentName,
                                                                  fromPrice: fromPriceController.text,
                                                                  toPrice: toPriceController.text,
                                                                  cityId: widget.cityId,
                                                                  cityName: widget.cityName,
                                                                  areaId: widget.areaId,
                                                                  data: 'filterScreen',
                                                                  areaName: widget.areaName,
                                                                  nameProduct: '',
                                                                  description: '',
                                                                ),
                                                          ));

                                                    } else {
                                                      AwesomeDialog(
                                                        context: context,
                                                        btnOkText: LocaleKeys.ok.tr(),
                                                        btnCancelText: LocaleKeys.cancel.tr(),
                                                        dialogType: DialogType.warning,
                                                        animType: AnimType.RIGHSLIDE,
                                                        title: LocaleKeys.warning.tr(),
                                                        desc: LocaleKeys
                                                            .pleaseSelectSubCategoryFirst
                                                            .tr(),
                                                        btnCancelOnPress: () {
                                                          //  _getCurrentLocation();
                                                        },
                                                        btnOkOnPress: () {
                                                          // _getCurrentLocation();
                                                        },
                                                      ).show();
                                                    }
                                                  }
                                                  else if (filterCubit.selectedMainCategory!.name!.en!.contains('Fashion')) {

                                                    print('FashionName');
                                                    print(filterCubit.selectedMainCategory?.name?.en);
                                                    print(filterCubit.selectedOptionsValueFashion);

                                                    if (filterCubit.selectedSubCategory?.id !=
                                                        null) {

                                                      Navigator.of(context).push(
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                FilterResultScreen(
                                                                  categoryId: filterCubit.selectedMainCategory?.id.toString(),
                                                                  categoryName: filterCubit.selectedMainCategory?.name?.en,
                                                                  subCategory: filterCubit.selectedSubCategory?.id.toString(),
                                                                  distance: dropdownValue,
                                                                  status: filterCubit.selectedOptionsValueConditionFashion,
                                                                  locationUser: locationUserController.text,
                                                                  typeFashion: filterCubit.selectedOptionsValueFashion,
                                                                  governmentId: widget.governmentId,
                                                                  governmentName: widget.governmentName,
                                                                  fromPrice: fromPriceController.text,
                                                                  toPrice: toPriceController.text,
                                                                  cityId: widget.cityId,
                                                                  cityName: widget.cityName,
                                                                  areaId: widget.areaId,
                                                                  areaName: widget.areaName,
                                                                ),
                                                          ));


                                                      // final input = filterCubit.selectedOptionsValueFashion;
                                                      //
                                                      // print("Source: $input");
                                                      //
                                                      // translator
                                                      //     .translate(filterCubit
                                                      //     .selectedOptionsValueFashion == ''
                                                      //     ? '-'
                                                      //     : input, to: 'en')
                                                      //     .then((result) {
                                                      //
                                                      //
                                                      //   print(
                                                      //       "Source: $input\nTranslated: $result");
                                                      // });


                                                    } else {
                                                      AwesomeDialog(
                                                        context: context,
                                                        btnOkText: LocaleKeys.ok.tr(),
                                                        btnCancelText: LocaleKeys.cancel.tr(),
                                                        dialogType: DialogType.warning,
                                                        animType: AnimType.RIGHSLIDE,
                                                        title: LocaleKeys.warning.tr(),
                                                        desc: LocaleKeys
                                                            .pleaseSelectSubCategoryFirst
                                                            .tr(),
                                                        btnCancelOnPress: () {
                                                          //  _getCurrentLocation();
                                                        },
                                                        btnOkOnPress: () {
                                                          // _getCurrentLocation();
                                                        },
                                                      ).show();
                                                    }
                                                  }
                                                  else if (filterCubit.selectedMainCategory!.name!.en!.contains('Home Furniture')) {

                                                    if (filterCubit.selectedSubCategory?.id != null) {


                                                      Navigator.of(context).push(
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  FilterResultScreen(
                                                                    categoryId: filterCubit.selectedMainCategory?.id.toString(),
                                                                    categoryName: filterCubit.selectedMainCategory?.name?.en,
                                                                    subCategory: filterCubit.selectedSubCategory?.id.toString(),
                                                                    typeHomeFurniture: filterCubit.selectedOptionsValueHomeFurniture,
                                                                    latitude: filterCubit.mapLocationModel?.lat.toString(),
                                                                    longitude: filterCubit.mapLocationModel?.lng.toString(),
                                                                    distance: dropdownValue,
                                                                    status: filterCubit.selectedOptionsValueConditionHomeFurniture,
                                                                    locationUser: locationUserController.text,
                                                                    governmentId: widget.governmentId,
                                                                    governmentName: widget.governmentName,
                                                                    fromPrice: fromPriceController.text,
                                                                    toPrice: toPriceController.text,
                                                                    cityId: widget.cityId,
                                                                    cityName: widget.cityName,
                                                                    areaId: widget.areaId,
                                                                    areaName: widget.areaName,
                                                                  )));

                                                    } else {
                                                      AwesomeDialog(
                                                        context: context,
                                                        btnOkText: LocaleKeys.ok.tr(),
                                                        btnCancelText: LocaleKeys.cancel.tr(),
                                                        dialogType: DialogType.warning,
                                                        animType: AnimType.RIGHSLIDE,
                                                        title: LocaleKeys.warning.tr(),
                                                        desc: LocaleKeys
                                                            .pleaseSelectSubCategoryFirst
                                                            .tr(),
                                                        btnCancelOnPress: () {
                                                          //  _getCurrentLocation();
                                                        },
                                                        btnOkOnPress: () {
                                                          // _getCurrentLocation();
                                                        },
                                                      ).show();
                                                    }
                                                  }
                                                  else if (filterCubit.selectedMainCategory!.name!.en!.contains('Books, Sports & Hobbies')) {

                                                    if (filterCubit.selectedSubCategory?.id != null) {
                                                      Navigator.of(context).push(
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  FilterResultScreen(
                                                                    categoryId: filterCubit.selectedMainCategory?.id.toString(),
                                                                    categoryName: filterCubit.selectedMainCategory?.name?.en,
                                                                    subCategory: filterCubit.selectedSubCategory?.id.toString(),
                                                                    typeBooks: filterCubit.selectedOptionsValueBooks,
                                                                    latitude: filterCubit.mapLocationModel?.lat.toString(),
                                                                    longitude: filterCubit.mapLocationModel?.lng.toString(),
                                                                    distance: dropdownValue,
                                                                    status: filterCubit.selectedOptionsValueConditionBooks,
                                                                    locationUser: locationUserController.text,
                                                                    governmentId: widget.governmentId,
                                                                    governmentName: widget.governmentName,
                                                                    fromPrice: fromPriceController.text,
                                                                    toPrice: toPriceController.text,
                                                                    cityId: widget.cityId,
                                                                    cityName: widget.cityName,
                                                                    areaId: widget.areaId,
                                                                    areaName: widget.areaName,
                                                                  )));

                                                    } else {
                                                      AwesomeDialog(
                                                        context: context,
                                                        btnOkText: LocaleKeys.ok.tr(),
                                                        btnCancelText: LocaleKeys.cancel.tr(),
                                                        dialogType: DialogType.warning,
                                                        animType: AnimType.RIGHSLIDE,
                                                        title: LocaleKeys.warning.tr(),
                                                        desc: LocaleKeys
                                                            .pleaseSelectSubCategoryFirst
                                                            .tr(),
                                                        btnCancelOnPress: () {
                                                          //  _getCurrentLocation();
                                                        },
                                                        btnOkOnPress: () {
                                                          // _getCurrentLocation();
                                                        },
                                                      ).show();
                                                    }
                                                  }
                                                  else if (filterCubit.selectedMainCategory!.name!.en!.contains('Kids & Babies')) {
                                                    if (filterCubit.selectedSubCategory?.id != null) {


                                                      Navigator.of(context).push(
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  FilterResultScreen(
                                                                    categoryId: filterCubit.selectedMainCategory?.id.toString(),
                                                                    categoryName: filterCubit.selectedMainCategory?.name?.en,
                                                                    subCategory: filterCubit.selectedSubCategory?.id.toString(),
                                                                    latitude: filterCubit.mapLocationModel?.lat.toString(),
                                                                    longitude: filterCubit.mapLocationModel?.lng.toString(),
                                                                    typeKids: filterCubit.selectedOptionsValueKids,
                                                                    distance: dropdownValue,
                                                                    status: filterCubit.selectedOptionsValueConditionKids,
                                                                    locationUser: locationUserController.text,
                                                                    governmentId: widget.governmentId,
                                                                    governmentName: widget.governmentName,
                                                                    fromPrice: fromPriceController.text,
                                                                    toPrice: toPriceController.text,
                                                                    cityId: widget.cityId,
                                                                    cityName: widget.cityName,
                                                                    areaId: widget.areaId,
                                                                    areaName: widget.areaName,
                                                                  )));

                                                    } else {
                                                      AwesomeDialog(
                                                        context: context,
                                                        btnOkText: LocaleKeys.ok.tr(),
                                                        btnCancelText: LocaleKeys.cancel.tr(),
                                                        dialogType: DialogType.warning,
                                                        animType: AnimType.RIGHSLIDE,
                                                        title: LocaleKeys.warning.tr(),
                                                        desc: LocaleKeys
                                                            .pleaseSelectSubCategoryFirst
                                                            .tr(),
                                                        btnCancelOnPress: () {
                                                          //  _getCurrentLocation();
                                                        },
                                                        btnOkOnPress: () {
                                                          // _getCurrentLocation();
                                                        },
                                                      ).show();
                                                    }
                                                  }
                                                  else if (filterCubit.selectedMainCategory!.name!.en!.contains('Business - Industrial - Agriculture')) {
                                                    // if (filterCubit.selectedOptionsValueConditionAllCategory == 'Used') {statusUser = '0';
                                                    // } else if (filterCubit
                                                    //     .selectedOptionsValueConditionAllCategory ==
                                                    //     'New') {
                                                    //   statusUser = '1';
                                                    // } else {
                                                    //   statusUser = '';
                                                    // }

                                                    if (filterCubit.selectedSubCategory?.id !=
                                                        null) {

                                                      Navigator.of(context).push(
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  FilterResultScreen(
                                                                    categoryId: filterCubit.selectedMainCategory?.id.toString(),
                                                                    categoryName: filterCubit.selectedMainCategory?.name?.en,
                                                                    subCategory: filterCubit.selectedSubCategory?.id.toString(),
                                                                    typeBusiness: filterCubit.selectedOptionsValueBusiness,
                                                                    latitude: filterCubit.mapLocationModel?.lat.toString(),
                                                                    longitude: filterCubit.mapLocationModel?.lng.toString(),
                                                                    distance: dropdownValue,
                                                                    status: filterCubit.selectedOptionsValueConditionBusiness,
                                                                    locationUser: locationUserController.text,
                                                                    governmentId: widget.governmentId,
                                                                    governmentName: widget.governmentName,
                                                                    fromPrice: fromPriceController.text,
                                                                    toPrice: toPriceController.text,
                                                                    cityId: widget.cityId,
                                                                    cityName: widget.cityName,
                                                                    areaId: widget.areaId,
                                                                    areaName: widget.areaName,
                                                                  )));

                                                    } else {
                                                      AwesomeDialog(
                                                        context: context,
                                                        btnOkText: LocaleKeys.ok.tr(),
                                                        btnCancelText: LocaleKeys.cancel.tr(),
                                                        dialogType: DialogType.warning,
                                                        animType: AnimType.RIGHSLIDE,
                                                        title: LocaleKeys.warning.tr(),
                                                        desc: LocaleKeys
                                                            .pleaseSelectSubCategoryFirst
                                                            .tr(),
                                                        btnCancelOnPress: () {
                                                          //  _getCurrentLocation();
                                                        },
                                                        btnOkOnPress: () {
                                                          // _getCurrentLocation();
                                                        },
                                                      ).show();
                                                    }
                                                  }

                                                  // if(state is FilterSuccessLocationState){
                                                  //   if (filterCubit.selectedMainCategory!.name!.en!.contains('Vehicles')) {
                                                  //
                                                  //     print('statusUser is');
                                                  //     print('brandId id $brandId');
                                                  //     print('selectedBrand fuelType ${filterCubit.selectedOptionsValueFuelTypeVehicles}');
                                                  //     print('selectedBrand year ${widget
                                                  //         .fromYear}');
                                                  //     print('selectedBrand kilo ${widget
                                                  //         .kiloMetresType}');
                                                  //     print('selectedBrand trans ${filterCubit
                                                  //         .selectedOptionsValueTransmissionTypeVehicles}');
                                                  //     print('selectedBrand color ${filterCubit
                                                  //         .selectedOptionsValueColorVehicles}');
                                                  //     print(
                                                  //         'selectedBrand bodyType ${filterCubit
                                                  //             .selectedOptionsValueBodyTypeVehicles}');
                                                  //     print('selectedBrand engin ${filterCubit
                                                  //         .selectedOptionsValueEngineCapacityVehicles}');
                                                  //     print(
                                                  //         'selectedBrand model ${addProductController
                                                  //             .dropdownValueBrand}');
                                                  //     print(
                                                  //         'selectedSubCategory id ${filterCubit
                                                  //             .selectedOptionsValueConditionAllCategory}');
                                                  //     print(
                                                  //         'selectedCategory id $dropdownValue');
                                                  //     print('selectedCategory id ${filterCubit
                                                  //         .selectedOptionsValueWarrantyElectronics}');
                                                  //
                                                  //     if (filterCubit.selectedSubCategory?.id != null) {
                                                  //
                                                  //       Navigator.of(context).push(
                                                  //           MaterialPageRoute(
                                                  //             builder: (context) =>
                                                  //                 FilterResultScreen(
                                                  //                   categoryId: filterCubit.selectedMainCategory?.id.toString(),
                                                  //                   categoryName: filterCubit.selectedMainCategory?.name?.en,
                                                  //                   subCategory: filterCubit.selectedSubCategory?.id.toString(),
                                                  //                   brandId: brandId,
                                                  //                   brandName: brandName,
                                                  //                   brandModel: addProductController.selectedBrand,
                                                  //                   latitude: null,
                                                  //                   longitude: null,
                                                  //                   fuelType: filterCubit.selectedOptionsValueFuelTypeVehicles,
                                                  //                   bodyType: filterCubit.selectedOptionsValueBodyTypeVehicles,
                                                  //                   engineCapacityType: filterCubit.selectedOptionsValueEngineCapacityVehicles,
                                                  //                   fromYear: widget.fromYear,
                                                  //                   tokiloMetresType: widget.tokiloMetresType,
                                                  //                   toYear: widget.toYear,
                                                  //                   fromkiloMetresType: widget.fromkiloMetresType,
                                                  //                   transmissionVehicles: filterCubit.selectedOptionsValueTransmissionTypeVehicles,
                                                  //                   colorVehicles: filterCubit.selectedOptionsValueColorVehicles,
                                                  //                   status: filterCubit.selectedOptionsValueConditionAllCategory,
                                                  //                   distance: dropdownValue,
                                                  //                   governmentId: widget.governmentId,
                                                  //                   governmentName: widget.governmentName,
                                                  //                   fromPrice: fromPriceController.text,
                                                  //                   toPrice: toPriceController.text,
                                                  //                   cityId: widget.cityId,
                                                  //                   cityName: widget.cityName,
                                                  //                   areaId: widget.areaId,
                                                  //                   data: 'filterScreen',
                                                  //                   areaName: widget.areaName,
                                                  //                   nameProduct: '',
                                                  //                   description: '',
                                                  //                 ),
                                                  //           ));
                                                  //
                                                  //     } else {
                                                  //       AwesomeDialog(
                                                  //         context: context,
                                                  //         btnOkText: LocaleKeys.ok.tr(),
                                                  //         btnCancelText: LocaleKeys.cancel.tr(),
                                                  //         dialogType: DialogType.warning,
                                                  //         animType: AnimType.RIGHSLIDE,
                                                  //         title: LocaleKeys.warning.tr(),
                                                  //         desc: LocaleKeys
                                                  //             .pleaseSelectSubCategoryFirst
                                                  //             .tr(),
                                                  //         btnCancelOnPress: () {
                                                  //           //  _getCurrentLocation();
                                                  //         },
                                                  //         btnOkOnPress: () {
                                                  //           // _getCurrentLocation();
                                                  //         },
                                                  //       ).show();
                                                  //     }
                                                  //   }
                                                  //   else if (filterCubit.selectedMainCategory!.name!.en!.contains('Properties')) {
                                                  //
                                                  //
                                                  //     print('selectedSubCategory id ${filterCubit
                                                  //         .selectedOptionsValueConditionAllCategory}');
                                                  //     print('selectedCategory id $dropdownValue');
                                                  //     print('selectedCategory id ${filterCubit.selectedOptionsValueWarrantyElectronics}');
                                                  //
                                                  //     if (filterCubit.selectedSubCategory?.id != null) {
                                                  //
                                                  //       Navigator.of(context).push(
                                                  //           MaterialPageRoute(
                                                  //             builder: (context) =>
                                                  //                 FilterResultScreen(
                                                  //                   categoryId: filterCubit.selectedMainCategory?.id.toString(),
                                                  //                   categoryName: filterCubit.selectedMainCategory?.name?.en,
                                                  //                   subCategory: filterCubit.selectedSubCategory?.id.toString(),
                                                  //                   latitude: null,
                                                  //                   longitude: null,
                                                  //                   distance: dropdownValue,
                                                  //                   fromArea: fromAreaPropertiesController.text,
                                                  //                   toArea: toAreaPropertiesController.text,
                                                  //                   status: filterCubit.selectedOptionsValueConditionAllCategory,
                                                  //                   typeProperties: filterCubit.selectedOptionsValueTypeProperties,
                                                  //                   bedroom: filterCubit.selectedOptionsValueBedroomProperties,
                                                  //                   bathroom: filterCubit.selectedOptionsValueBathRoomProperties,
                                                  //                   levelType: filterCubit.selectedOptionsValueLevelProperties,
                                                  //                   statusApartment: filterCubit.selectedOptionsValueTypeApartmentProperties,
                                                  //                   furnishedProperties: filterCubit.selectedOptionsValueFurnishedProperties,
                                                  //                   amenitiesType: filterCubit.selectedOptionsValueAmenitiesProperties,
                                                  //                   fromDownPayment: fromDownPaymentController.text,
                                                  //                   toDownPayment: toDownPaymentController.text,
                                                  //                   governmentId: widget.governmentId,
                                                  //                   governmentName: widget.governmentName,
                                                  //                   fromPrice: fromPriceController.text,
                                                  //                   toPrice: toPriceController.text,
                                                  //                   cityId: widget.cityId,
                                                  //                   cityName: widget.cityName,
                                                  //                   areaId: widget.areaId,
                                                  //                   data: 'filterScreen',
                                                  //                   areaName: widget.areaName,
                                                  //                   nameProduct: '',
                                                  //                   description: '',
                                                  //                 ),
                                                  //           ));
                                                  //
                                                  //
                                                  //     } else {
                                                  //       AwesomeDialog(
                                                  //         context: context,
                                                  //         btnOkText: LocaleKeys.ok.tr(),
                                                  //         btnCancelText: LocaleKeys.cancel.tr(),
                                                  //         dialogType: DialogType.warning,
                                                  //         animType: AnimType.RIGHSLIDE,
                                                  //         title: LocaleKeys.warning.tr(),
                                                  //         desc: LocaleKeys
                                                  //             .pleaseSelectSubCategoryFirst
                                                  //             .tr(),
                                                  //         btnCancelOnPress: () {
                                                  //           //  _getCurrentLocation();
                                                  //         },
                                                  //         btnOkOnPress: () {
                                                  //           // _getCurrentLocation();
                                                  //         },
                                                  //       ).show();
                                                  //     }
                                                  //   }
                                                  //   else if (filterCubit.selectedMainCategory!.name!.en!.contains('Electronics')) {
                                                  //
                                                  //     print('location result');
                                                  //     print('${state.mapLocationModel?.lat}');
                                                  //     print('location lng');
                                                  //     print('${state.mapLocationModel?.lng}');
                                                  //     print('location lat');
                                                  //     print(filterCubit.selectedMainCategory!.name!.en);
                                                  //     print(dropdownValue);
                                                  //     print(filterCubit.selectedOptionsValueConditionAllCategory);
                                                  //     print(filterCubit.selectedOptionsValueWarrantyElectronics);
                                                  //     print(addProductController.selectedBrand);
                                                  //     print(addProductController.selectedBrand?.id);
                                                  //
                                                  //     if (filterCubit.selectedSubCategory?.id != null) {
                                                  //
                                                  //       if (dropdownValue == '0'){
                                                  //         AwesomeDialog(
                                                  //           context: context,
                                                  //           btnOkText: LocaleKeys.ok.tr(),
                                                  //           btnCancelText: LocaleKeys.cancel.tr(),
                                                  //           dialogType: DialogType.warning,
                                                  //           animType: AnimType.RIGHSLIDE,
                                                  //           title: LocaleKeys.warning.tr(),
                                                  //           desc: LocaleKeys.location.tr(),
                                                  //           btnCancelOnPress: () {
                                                  //             //  _getCurrentLocation();
                                                  //           },
                                                  //           btnOkOnPress: () {
                                                  //             // _getCurrentLocation();
                                                  //           },
                                                  //         ).show();
                                                  //       }else {
                                                  //         Navigator.of(context).push(
                                                  //             MaterialPageRoute(
                                                  //               builder: (context) =>
                                                  //                   FilterResultScreen(
                                                  //                     categoryId: filterCubit.selectedMainCategory?.id.toString(),
                                                  //                     categoryName: filterCubit.selectedMainCategory?.name?.en,
                                                  //                     subCategory: filterCubit.selectedSubCategory?.id.toString(),
                                                  //                     brandId: brandId,
                                                  //                     brandName: brandName,
                                                  //                     brandModel: addProductController.selectedBrand,
                                                  //                     latitude: state.mapLocationModel?.lat.toString(),
                                                  //                     longitude: state.mapLocationModel?.lng.toString(),
                                                  //                     status: filterCubit.selectedOptionsValueConditionAllCategory,
                                                  //                     distance: dropdownValue,
                                                  //                     warrantyElectronic: filterCubit.selectedOptionsValueWarrantyElectronics,
                                                  //                     governmentId: widget.governmentId,
                                                  //                     governmentName: widget.governmentName,
                                                  //                     fromPrice: fromPriceController.text,
                                                  //                     toPrice: toPriceController.text,
                                                  //                     cityId: widget.cityId,
                                                  //                     cityName: widget.cityName,
                                                  //                     areaId: widget.areaId,
                                                  //                     data: 'filterScreen',
                                                  //                     areaName: widget.areaName,
                                                  //                     nameProduct: '',
                                                  //                     description: '',
                                                  //                   ),
                                                  //             ));
                                                  //       }
                                                  //
                                                  //     } else {
                                                  //       AwesomeDialog(
                                                  //         context: context,
                                                  //         btnOkText: LocaleKeys.ok.tr(),
                                                  //         btnCancelText: LocaleKeys.cancel.tr(),
                                                  //         dialogType: DialogType.warning,
                                                  //         animType: AnimType.RIGHSLIDE,
                                                  //         title: LocaleKeys.warning.tr(),
                                                  //         desc: LocaleKeys
                                                  //             .pleaseSelectSubCategoryFirst
                                                  //             .tr(),
                                                  //         btnCancelOnPress: () {
                                                  //           //  _getCurrentLocation();
                                                  //         },
                                                  //         btnOkOnPress: () {
                                                  //           // _getCurrentLocation();
                                                  //         },
                                                  //       ).show();
                                                  //     }
                                                  //   }
                                                  //   else if (filterCubit.selectedMainCategory!.name!.en!.contains('Fashion')) {
                                                  //
                                                  //     print('FashionName');
                                                  //     print('${state.mapLocationModel?.lat}');
                                                  //     print('location lng');
                                                  //     print('${state.mapLocationModel?.lng}');
                                                  //     print('location lat');
                                                  //     print(filterCubit.selectedMainCategory!.name!.en);
                                                  //     print(dropdownValue);
                                                  //     print(filterCubit.selectedOptionsValueConditionAllCategory);
                                                  //     print(filterCubit.selectedOptionsValueWarrantyElectronics);
                                                  //     print(addProductController.selectedBrand);
                                                  //     print(addProductController.selectedBrand?.id);
                                                  //
                                                  //     if (filterCubit.selectedSubCategory?.id !=
                                                  //         null) {
                                                  //
                                                  //       Navigator.of(context).push(
                                                  //           MaterialPageRoute(
                                                  //             builder: (context) =>
                                                  //                 FilterResultScreen(
                                                  //                   categoryId: filterCubit.selectedMainCategory?.id.toString(),
                                                  //                   categoryName: filterCubit.selectedMainCategory?.name?.en,
                                                  //                   subCategory: filterCubit.selectedSubCategory?.id.toString(),
                                                  //                   distance: dropdownValue,
                                                  //                   latitude: state.mapLocationModel?.lat.toString(),
                                                  //                   longitude: state.mapLocationModel?.lng.toString(),
                                                  //                   typeFashion: filterCubit.selectedOptionsValueFashion,
                                                  //                   governmentId: widget.governmentId,
                                                  //                   governmentName: widget.governmentName,
                                                  //                   fromPrice: fromPriceController.text,
                                                  //                   toPrice: toPriceController.text,
                                                  //                   cityId: widget.cityId,
                                                  //                   cityName: widget.cityName,
                                                  //                   areaId: widget.areaId,
                                                  //                   areaName: widget.areaName,
                                                  //                 ),
                                                  //           ));
                                                  //
                                                  //
                                                  //       // final input = filterCubit.selectedOptionsValueFashion;
                                                  //       //
                                                  //       // print("Source: $input");
                                                  //       //
                                                  //       // translator
                                                  //       //     .translate(filterCubit
                                                  //       //     .selectedOptionsValueFashion == ''
                                                  //       //     ? '-'
                                                  //       //     : input, to: 'en')
                                                  //       //     .then((result) {
                                                  //       //
                                                  //       //
                                                  //       //   print(
                                                  //       //       "Source: $input\nTranslated: $result");
                                                  //       // });
                                                  //
                                                  //
                                                  //     } else {
                                                  //       AwesomeDialog(
                                                  //         context: context,
                                                  //         btnOkText: LocaleKeys.ok.tr(),
                                                  //         btnCancelText: LocaleKeys.cancel.tr(),
                                                  //         dialogType: DialogType.warning,
                                                  //         animType: AnimType.RIGHSLIDE,
                                                  //         title: LocaleKeys.warning.tr(),
                                                  //         desc: LocaleKeys
                                                  //             .pleaseSelectSubCategoryFirst
                                                  //             .tr(),
                                                  //         btnCancelOnPress: () {
                                                  //           //  _getCurrentLocation();
                                                  //         },
                                                  //         btnOkOnPress: () {
                                                  //           // _getCurrentLocation();
                                                  //         },
                                                  //       ).show();
                                                  //     }
                                                  //   }
                                                  //   else if (filterCubit.selectedMainCategory!.name!.en!.contains('Home Furniture')) {
                                                  //
                                                  //     if (filterCubit.selectedSubCategory?.id != null) {
                                                  //
                                                  //
                                                  //       Navigator.of(context).push(
                                                  //           MaterialPageRoute(
                                                  //               builder: (context) =>
                                                  //                   FilterResultScreen(
                                                  //                     categoryId: filterCubit.selectedMainCategory?.id.toString(),
                                                  //                     categoryName: filterCubit.selectedMainCategory?.name?.en,
                                                  //                     subCategory: filterCubit.selectedSubCategory?.id.toString(),
                                                  //                     typeHomeFurniture: filterCubit.selectedOptionsValueHomeFurniture,
                                                  //                     latitude: state.mapLocationModel?.lat.toString(),
                                                  //                     longitude: state.mapLocationModel?.lng.toString(),
                                                  //                     distance: dropdownValue,
                                                  //                     governmentId: widget.governmentId,
                                                  //                     governmentName: widget.governmentName,
                                                  //                     fromPrice: fromPriceController.text,
                                                  //                     toPrice: toPriceController.text,
                                                  //                     cityId: widget.cityId,
                                                  //                     cityName: widget.cityName,
                                                  //                     areaId: widget.areaId,
                                                  //                     areaName: widget.areaName,
                                                  //                   )));
                                                  //
                                                  //     } else {
                                                  //       AwesomeDialog(
                                                  //         context: context,
                                                  //         btnOkText: LocaleKeys.ok.tr(),
                                                  //         btnCancelText: LocaleKeys.cancel.tr(),
                                                  //         dialogType: DialogType.warning,
                                                  //         animType: AnimType.RIGHSLIDE,
                                                  //         title: LocaleKeys.warning.tr(),
                                                  //         desc: LocaleKeys
                                                  //             .pleaseSelectSubCategoryFirst
                                                  //             .tr(),
                                                  //         btnCancelOnPress: () {
                                                  //           //  _getCurrentLocation();
                                                  //         },
                                                  //         btnOkOnPress: () {
                                                  //           // _getCurrentLocation();
                                                  //         },
                                                  //       ).show();
                                                  //     }
                                                  //   }
                                                  //   else if (filterCubit.selectedMainCategory!.name!.en!.contains('Books, Sports & Hobbies')) {
                                                  //
                                                  //     if (filterCubit.selectedSubCategory?.id != null) {
                                                  //       Navigator.of(context).push(
                                                  //           MaterialPageRoute(
                                                  //               builder: (context) =>
                                                  //                   FilterResultScreen(
                                                  //                     categoryId: filterCubit.selectedMainCategory?.id.toString(),
                                                  //                     categoryName: filterCubit.selectedMainCategory?.name?.en,
                                                  //                     subCategory: filterCubit.selectedSubCategory?.id.toString(),
                                                  //                     typeBooks: filterCubit.selectedOptionsValueBooks,
                                                  //                     latitude: state.mapLocationModel?.lat.toString(),
                                                  //                     longitude: state.mapLocationModel?.lng.toString(),
                                                  //                     distance: dropdownValue,
                                                  //                     governmentId: widget.governmentId,
                                                  //                     governmentName: widget.governmentName,
                                                  //                     fromPrice: fromPriceController.text,
                                                  //                     toPrice: toPriceController.text,
                                                  //                     cityId: widget.cityId,
                                                  //                     cityName: widget.cityName,
                                                  //                     areaId: widget.areaId,
                                                  //                     areaName: widget.areaName,
                                                  //                   )));
                                                  //
                                                  //     } else {
                                                  //       AwesomeDialog(
                                                  //         context: context,
                                                  //         btnOkText: LocaleKeys.ok.tr(),
                                                  //         btnCancelText: LocaleKeys.cancel.tr(),
                                                  //         dialogType: DialogType.warning,
                                                  //         animType: AnimType.RIGHSLIDE,
                                                  //         title: LocaleKeys.warning.tr(),
                                                  //         desc: LocaleKeys
                                                  //             .pleaseSelectSubCategoryFirst
                                                  //             .tr(),
                                                  //         btnCancelOnPress: () {
                                                  //           //  _getCurrentLocation();
                                                  //         },
                                                  //         btnOkOnPress: () {
                                                  //           // _getCurrentLocation();
                                                  //         },
                                                  //       ).show();
                                                  //     }
                                                  //   }
                                                  //   else if (filterCubit.selectedMainCategory!.name!.en!.contains('Kids & Babies')) {
                                                  //     if (filterCubit.selectedSubCategory?.id !=
                                                  //         null) {
                                                  //
                                                  //       Navigator.of(context).push(
                                                  //           MaterialPageRoute(
                                                  //               builder: (context) =>
                                                  //                   FilterResultScreen(
                                                  //                     categoryId: filterCubit.selectedMainCategory?.id.toString(),
                                                  //                     categoryName: filterCubit.selectedMainCategory?.name?.en,
                                                  //                     subCategory: filterCubit.selectedSubCategory?.id.toString(),
                                                  //                     latitude: state.mapLocationModel?.lat.toString(),
                                                  //                     longitude: state.mapLocationModel?.lng.toString(),
                                                  //                     typeKids: filterCubit.selectedOptionsValueKids,
                                                  //                     distance: dropdownValue,
                                                  //                     governmentId: widget.governmentId,
                                                  //                     governmentName: widget.governmentName,
                                                  //                     fromPrice: fromPriceController.text,
                                                  //                     toPrice: toPriceController.text,
                                                  //                     cityId: widget.cityId,
                                                  //                     cityName: widget.cityName,
                                                  //                     areaId: widget.areaId,
                                                  //                     areaName: widget.areaName,
                                                  //                   )));
                                                  //
                                                  //     } else {
                                                  //       AwesomeDialog(
                                                  //         context: context,
                                                  //         btnOkText: LocaleKeys.ok.tr(),
                                                  //         btnCancelText: LocaleKeys.cancel.tr(),
                                                  //         dialogType: DialogType.warning,
                                                  //         animType: AnimType.RIGHSLIDE,
                                                  //         title: LocaleKeys.warning.tr(),
                                                  //         desc: LocaleKeys
                                                  //             .pleaseSelectSubCategoryFirst
                                                  //             .tr(),
                                                  //         btnCancelOnPress: () {
                                                  //           //  _getCurrentLocation();
                                                  //         },
                                                  //         btnOkOnPress: () {
                                                  //           // _getCurrentLocation();
                                                  //         },
                                                  //       ).show();
                                                  //     }
                                                  //   }
                                                  //   else if (filterCubit.selectedMainCategory!.name!.en!.contains('Business - Industrial - Agriculture')) {
                                                  //
                                                  //     if (filterCubit.selectedSubCategory?.id !=
                                                  //         null) {
                                                  //
                                                  //       Navigator.of(context).push(
                                                  //           MaterialPageRoute(
                                                  //               builder: (context) =>
                                                  //                   FilterResultScreen(
                                                  //                     categoryId: filterCubit.selectedMainCategory?.id.toString(),
                                                  //                     categoryName: filterCubit.selectedMainCategory?.name?.en,
                                                  //                     subCategory: filterCubit.selectedSubCategory?.id.toString(),
                                                  //                     typeBusiness: filterCubit.selectedOptionsValueBusiness,
                                                  //                     latitude: state.mapLocationModel?.lat.toString(),
                                                  //                     longitude: state.mapLocationModel?.lng.toString(),
                                                  //                     distance: dropdownValue,
                                                  //                     governmentId: widget.governmentId,
                                                  //                     governmentName: widget.governmentName,
                                                  //                     fromPrice: fromPriceController.text,
                                                  //                     toPrice: toPriceController.text,
                                                  //                     cityId: widget.cityId,
                                                  //                     cityName: widget.cityName,
                                                  //                     areaId: widget.areaId,
                                                  //                     areaName: widget.areaName,
                                                  //                   )));
                                                  //
                                                  //     } else {
                                                  //       AwesomeDialog(
                                                  //         context: context,
                                                  //         btnOkText: LocaleKeys.ok.tr(),
                                                  //         btnCancelText: LocaleKeys.cancel.tr(),
                                                  //         dialogType: DialogType.warning,
                                                  //         animType: AnimType.RIGHSLIDE,
                                                  //         title: LocaleKeys.warning.tr(),
                                                  //         desc: LocaleKeys
                                                  //             .pleaseSelectSubCategoryFirst
                                                  //             .tr(),
                                                  //         btnCancelOnPress: () {
                                                  //           //  _getCurrentLocation();
                                                  //         },
                                                  //         btnOkOnPress: () {
                                                  //           // _getCurrentLocation();
                                                  //         },
                                                  //       ).show();
                                                  //     }
                                                  //   }
                                                  //
                                                  // }


                                                }

                                              }
                                            }
                                          },
                                          height: 48.h,
                                          fontSize: Dimensions.fontSizeLarge,
                                        ),
                                      ],
                                    );
                                  }))));
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


