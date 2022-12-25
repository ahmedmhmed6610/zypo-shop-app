import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/business_logic/my_products_cubit/my_products_cubit.dart';
import 'package:shop/data/color_model.dart';
import 'package:shop/data/models/brand_model.dart';
import 'package:shop/data/models/category_model.dart';
import 'package:shop/data/models/dummy_data/dummy_colors.dart';
import 'package:shop/data/models/location_model.dart';
import 'package:shop/data/models/mapLocationModel.dart';
import 'package:shop/translations/locale_keys.g.dart';

import '../../data/models/MyProductUserModel.dart';
import '../../data/models/dummy_data/dummy_body_type.dart';
import '../../data/models/dummy_data/dummy_engine_capacity.dart';
import '../../data/models/dummy_data/dummy_fuel_type.dart';
import '../../data/models/dummy_data/dummy_kilometers.dart';
import '../../data/webservices/api_services/fliter_product_service.dart';

part 'filter_state.dart';

class FilterCubit extends Cubit<FilterState> {
  FilterCubit() : super(FilterInitial());

  Condition condition = Condition.newProduct;
  Warranty warranty = Warranty.yes;
  TransmissionType transmissionType = TransmissionType.manual;
  Finished finished = Finished.yes;
  StatusProperties statusProperties = StatusProperties.finished;

  static FilterCubit get(BuildContext context) => BlocProvider.of(context);
  CategoryModel? selectedMainCategory;
  CategoryModel? selectedSubCategory;
  BrandModel? selectedBrand;
  LocationModel? selectedLocation;
  List<BrandModel> selectedBrandsModel = [];

  List<ColorModel> selectedColorsModel = [];
  List<ColorModel> filterColors = dummyColors;
  List<ColorModel> filterKiloMeters = dummyKiloMeters;
  List<ColorModel> filterEngineCapacity = dummyEngineCapacity;
  List<ColorModel> filterBodyType = dummyBodyType;
  List<ColorModel> filterFuelType = dummyFuelType;

  ////// Condition
  List<String> selectedOptionConditionElectronics = [];
  String selectedOptionsValueConditionElectronics = '';


  ////// location
  List<String> selectedOptionDistanceLocation = [];
  String selectedOptionsValueDistanceLocation = '';

  ////// Electronics
  List<String> selectedOptionWarrantyElectronics = [];
  String selectedOptionsValueWarrantyElectronics = '';

  ////// Fashion
  List<String> selectedOptionFashion = [];
  String selectedOptionsValueFashion = '';

  List<String> selectedOptionConditionFashion = [];
  String selectedOptionsValueConditionFashion = '';

  ////// HomeFurniture
  List<String> selectedOptionHomeFurniture = [];
  String selectedOptionsValueHomeFurniture = '';

  List<String> selectedOptionConditionHomeFurniture = [];
  String selectedOptionsValueConditionHomeFurniture = '';

  ////// Books
  List<String> selectedOptionBooks = [];
  String selectedOptionsValueBooks = '';

  List<String> selectedOptionConditionBooks = [];
  String selectedOptionsValueConditionBooks = '';

  ////// Kids
  List<String> selectedOptionKids = [];
  String selectedOptionsValueKids = '';

  List<String> selectedOptionConditionKids = [];
  String selectedOptionsValueConditionKids = '';

  ////// Business
  List<String> selectedOptionBusiness = [];
  String selectedOptionsValueBusiness = '';

  List<String> selectedOptionConditionBusiness = [];
  String selectedOptionsValueConditionBusiness = '';

  ////// Vehicles
  List<String> selectedOptionFuelTypeVehicles = [];
  String selectedOptionsValueFuelTypeVehicles = '';

  List<String> selectedOptionConditionVehicles = [];
  String selectedOptionsValueConditionVehicles = '';

  List<String> selectedOptionTransmissionTypeVehicles = [];
  String selectedOptionsValueTransmissionTypeVehicles = '';

  ////// Properties
  List<String> selectedOptionTypeApartmentProperties = [];
  String selectedOptionsValueTypeApartmentProperties = '';

  List<String> selectedOptionTypeProperties = [];
  String selectedOptionsValueTypeProperties = '';

  List<String> selectedOptionFurnishedProperties = [];
  String selectedOptionsValueFurnishedProperties = '';

  /// Vehicles
  List<String> selectedOptionColorVehicles = [];
  String selectedOptionsValueColorVehicles = '';

  List<String> selectedOptionBodyTypeVehicles = [];
  String selectedOptionsValueBodyTypeVehicles = '';

  List<String> selectedOptionEngineCapacityVehicles = [];
  String selectedOptionsValueEngineCapacityVehicles = '';

  List<String> selectedOptionAmenitiesProperties = [];
  String selectedOptionsValueAmenitiesProperties = '';

  List<String> selectedOptionBedroomProperties = [];
  String selectedOptionsValueBedroomProperties = '';

  List<String> selectedOptionBathRoomProperties = [];
  String selectedOptionsValueBathRoomProperties = '';

  List<String> selectedOptionLevelProperties = [];
  String selectedOptionsValueLevelProperties = '';

  changeCondition() {
    if (condition == Condition.newProduct) {
      condition = Condition.used;
    //  print('condition status is $condition is 0');
    } else {
      condition = Condition.newProduct;
     // print('condition status is $condition is 1');
    }
    emit(ChangeConditionState());
  }

  List<MyProductUserResponseModel>? myProductUserResponseModel;


  getFilterProducts(
    String categoryId,
    String categoryName,
    String subCategoryId,
    String brandId,
    String governmentId,
    String cityId,
    String areaId,
    String priceMin,
    String priceMax,
    String status,
    String latitude,
    String longitude,
    String float,

    ///option Vehicles
    String optionValueFuelType,
    String optionValueYear,
    String optionValueKiloMeter,
    String optionValueTransmissionType,
    String optionValueColorType,
    String optionValueBodyType,
    String optionValueEngineCapacityType,
    String optionValueModelBrand,

    ///option  properties
    String optionValueTypeApartment,
    String optionValueDownPayment,
    String optionValueAmenities,
    String optionValueBedroom,
    String optionValueBathroom,
    String optionValueArea,
    String optionValueLevel,
    String optionValueFurnished,
    String optionValueStatus,

    /// Electronics
    String optionValueWarranty,

    /// Home Furniture
    String optionValueFurniture,

    /// Home Fashion
    String optionValueHomeFashion,

    /// Books
    String optionValueBooks,

    /// Kids
    String optionValueKids,

    /// Business
    String optionValueBusiness,
  ) {
    emit(FilterLoadingState());
    print('categoryId');
    print(categoryId);
    print(categoryName);
    print(subCategoryId);
    print(latitude);
    print(longitude);

    FilterProductService.getOptionOfCategory(
      categoryId,
      categoryName,
      subCategoryId,
      brandId,
      governmentId,
      cityId,
      areaId,
      priceMin,
      priceMax,
      status,
      latitude,
      longitude,
      float,
      ///option Vehicles
      optionValueFuelType,
      optionValueYear,
      optionValueKiloMeter,
      optionValueTransmissionType,
      optionValueColorType,
      optionValueBodyType,
      optionValueEngineCapacityType,
      optionValueModelBrand,

      ///option  properties
      optionValueTypeApartment,
      optionValueDownPayment,
      optionValueAmenities,
      optionValueBedroom,
      optionValueBathroom,
      optionValueArea,
      optionValueLevel,
      optionValueFurnished,
      optionValueStatus,

      /// Electronics
      optionValueWarranty,

      /// Home Furniture
      optionValueFurniture,

      /// Home Fashion
      optionValueHomeFashion,

      /// Books
      optionValueBooks,

      /// Kids
      optionValueKids,

      /// Business
      optionValueBusiness,
    ).then((value) {
      print('optionRequestWarranty is here');
      print(optionValueWarranty);
      // print('optionValueFuelType');
      // print(optionValueFuelType);
      // print('optionValueModelBrand');
      // print(optionValueModelBrand);
      // print('optionValueYear');
      // print(optionValueYear);
      // print('optionValueKiloMeter');
      // print(optionValueKiloMeter);
      // print('optionValueTransmissionType');
      // print(optionValueTransmissionType);
      // print('optionValueColorType');
      // print(optionValueColorType);
      // print('optionValueBodyType');
      // print(optionValueBodyType);
      // print('optionValueEngineCapacityType');
      // print(optionValueEngineCapacityType);
      myProductUserResponseModel = value?.data;
      emit(FilterSuccessState(myProductUserResponseModel));
    }).catchError((onError){
      print('error has ${onError.toString()}');
    });
  }


  LocationResponseModel? mapLocationModel;

  getLocationWithMap(String governorate,String city,String area) {
    emit(FilterLocationLoadingState());
    FilterProductService.getLocationFromMap(governorate,city,area).then((value) {
      mapLocationModel = value?.locationResponseModel;
       print('your location lat and lng');
       print('${mapLocationModel?.lat}');
       print('${mapLocationModel?.lng}');

      // CustomFlutterToast('${myProductUserResponseModel![0].name}');
      emit(FilterSuccessLocationState(mapLocationModel));
    }).catchError((onError){
      print('error is ');
      print(onError.toString());
      emit(FilterLocationErrorState(onError.toString()));
    });
  }

  getUserProducts(String productId) {
    emit(FilterLoadingState());
    FilterProductService.getUserProducts(productId).then((value) {
      myProductUserResponseModel = value?.data;
      // CustomFlutterToast('${myProductUserResponseModel!.length}');
      // CustomFlutterToast('${myProductUserResponseModel![0].name}');
      emit(FilterSuccessState(myProductUserResponseModel));
    });
  }

  selectMainCategory({required CategoryModel category}) {
    selectedMainCategory = category;
    selectedSubCategory = null;
    emit(SelectMainCategoryState());
  }

  selectSubCategory({required CategoryModel? category}) {
    selectedSubCategory = category;
    emit(SelectSubCategoryState());
  }

  selectLocation({required LocationModel location}) {
    selectedLocation = location;
    emit(SelectLocationState());
  }

  selectColorToFilter({required ColorModel color}) {
    if (selectedColorsModel.contains(color)) {
      selectedColorsModel.removeWhere((element) => element.id == color.id);
    } else {
      selectedColorsModel.insert(0, color);
    }
    emit(SelectColorState());
  }

  isColorSelected({required ColorModel color}) {
    if (selectedColorsModel.contains(color)) {
      return true;
    } else {
      return false;
    }
  }

  isSelected({required CategoryModel category}) {
    if (selectedMainCategory != null) {
      if (selectedMainCategory!.id == category.id) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  isSubCategorySelected({required CategoryModel category}) {
    if (selectedSubCategory != null) {
      if (selectedSubCategory!.id == category.id) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  getSelectedColorsAsAString() {
    String colors = '';
    if (selectedColorsModel.isEmpty) {
      return LocaleKeys.color.tr();
    } else {
      for (var element in selectedColorsModel) {
        colors += "${element.color}, ";
      }
      return colors;
    }
  }
}
