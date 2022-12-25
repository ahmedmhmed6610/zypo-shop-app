// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shop/business_logic/my_products_cubit/my_products_state.dart';
import 'package:shop/data/models/brand_model.dart';
import 'package:shop/data/models/category_model.dart';
import 'package:shop/data/models/dummy_data/dummy_amenities.dart';
import 'package:shop/data/models/dummy_data/dummy_kilometers.dart';
import 'package:shop/data/models/dummy_data/dummy_level.dart';
import 'package:shop/data/models/location_model.dart';
import 'package:shop/data/models/product_page.dart';
import 'package:shop/data/webservices/api_services/add_product_services.dart';
import 'package:shop/data/webservices/api_services/product_service.dart';
import 'package:shop/helpers/app_local_storage.dart';
import 'package:shop/translations/locale_keys.g.dart';
import 'package:shop/ui/screens/add_products_screen/change_product_screen2.dart';
import 'package:shop/ui/screens/edit_images_product_screen/edit_images_product_screen.dart';
import 'package:shop/ui/screens/layout/app_layout.dart';
import 'package:shop/ui/widgets/common_widgets/dialogs/success_dialog.dart';
import 'package:shop/utils/app_palette.dart';

import '../../data/color_model.dart';
import '../../data/models/MyProductUserModel.dart';
import '../../data/models/dummy_data/dummy_body_type.dart';
import '../../data/models/dummy_data/dummy_colors.dart';
import '../../data/models/dummy_data/dummy_engine_capacity.dart';
import '../../data/models/dummy_data/dummy_fuel_type.dart';
import '../../data/models/product_model.dart';
import '../../data/models/response_user_model.dart';
import '../../data/webservices/api_constants.dart';
import '../../data/webservices/api_services/home_services.dart';
import '../../helpers/dio_helper.dart';
import '../../ui/base/custom_toast.dart';
import '../../ui/screens/add_products_screen/product_sold_screen.dart';

enum Condition { newProduct, used }

enum Warranty { yes, no }

enum TransmissionType { manual, automatic }

enum Finished { yes, no }

enum TypeHomeFurniture { fullBathroom, sink, toilet, showerRoomTub,towels, waterMixersShowerHeads, mirrorsShelvesOtherAccessories }

enum TypeHomeFashion { nightwear, swimwear, dresses, weddingApparel, pulloverCoatsJackets, blouseTshirtsTops, trousersLeggingsJeans }

enum TypeKids { bathTub, diaper, shampooSoaps, skincare, siliconeNippleProtectors, sterilizerTools, toiletTrainingSeat, other }

enum TypeBooks { antiques, aRT, collectibles, oldCurrencies, pensWritingInstruments, other }

enum TypeBusiness  { seeds, crops, farmMachinery, pesticides, other }

enum StatusProperties  { finished, notFinished, coreShell, semiFinished }

class AddProductCubit extends Cubit<AddProductState> with AddProductServices {
  AddProductCubit() : super(AddProductInitial()) {
    getMyProductUser();
  }

  static AddProductCubit get(BuildContext context) => BlocProvider.of(context);


  File? image1;
  File? image2;
  File? image3;
  File? image4;
  File? image5;
  String? fileName;
  List<String>? imagesList;
  List<File> images = [];


  //// Type Electronics
  bool isVisibleWarrantyYes = false;
  bool isVisibleWarrantyNo = false;

  //// Type Electronics
  bool isVisibleManual = false;
  bool isVisibleAutomatic = false;

  ////  Properties
  bool isVisibleFinished = false;
  bool isVisibleNotFinished = false;
  bool isVisibleCoreShell = false;
  bool isVisibleSemiFinished = false;

  bool isVisibleFurnishedProperties = false;
  bool isVisibleNotFurnishedProperties = false;


  //// Type Properties
  bool isVisibleApartment = false;
  bool isVisibleDuplex = false;
  bool isVisiblePenthouse = false;
  bool isVisibleStudio = false;

  ////// Fashion
  bool isVisibleNightwear = false;
  bool isVisibleSwimwear = false;
  bool isVisibleDresses = false;
  bool isVisibleWeddingApparel = false;
  bool isVisiblePulloverCoatsJackets = false;
  bool isVisibleBlouseTShairt = false;
  bool isVisibleTrousers = false;

  ////// Home Furniture
  bool isVisibleBedroom = false;
  bool isVisibleSink = false;
  bool isVisibleToilet = false;
  bool isVisibleShower = false;
  bool isVisibleTowels = false;
  bool isVisibleWaterMix = false;
  bool isVisibleMirrors = false;

  ////// Books
  bool isVisibleAntiques = false;
  bool isVisibleArt = false;
  bool isVisibleCollectibles = false;
  bool isVisibleOldCurrencies = false;
  bool isVisiblePens = false;
  bool isVisibleOther = false;

  ////// Kids
  bool isVisibleBathTub = false;
  bool isVisibleDiaper = false;
  bool isVisibleShampoo = false;
  bool isVisibleSkincare = false;
  bool isVisibleSilicone = false;
  bool isVisibleSterilizerTools = false;
  bool isVisibleToiletKids = false;
  bool isVisibleOtherKids = false;

  ////// Business
  bool isVisibleSeeds = false;
  bool isVisibleCrops = false;
  bool isVisibleFarmMachinery = false;
  bool isVisiblePesticides = false;
  bool isVisibleOtherBusiness = false;

  String? dropdownValueBrand;
  String? carModelList;

  ////// Veh
  List<String> selectedOptionBrandModel = [];
  String selectedOptionsValueBrandModel = '';

  Condition condition = Condition.newProduct;
  Warranty warranty = Warranty.yes;
  TransmissionType transmissionType = TransmissionType.manual;
  Finished finished = Finished.yes;


  final ImagePicker _picker = ImagePicker();
  List<dynamic> optionListProduct = [];

  // List<ProductModel> myProducts = [
  //   products[0],
  //   products[1],
  //   products[2],
  //   products[3],
  // ];
  ProductPage myProducts = ProductPage.empty();
  CategoryModel? selectedMainCat;
  CategoryModel? selectedSubCat;
  BrandModel? selectedBrand;
  LocationModel? selectedLocation;
  bool loading = false;
  bool loadingUpdate = false;
  bool isLoadingProduct = false;
  MyProductUserModel? myProductUserResponseModel;

  ResponseModel? responseModel;

  List<ColorModel> selectedColorsModel = [];
  List<ColorModel> addProductCubitColors = dummyColors;
  List<ColorModel> addProductCubitKiloMeters = dummyKiloMeters;
  List<ColorModel> addProductLevel = dummyLevel;
  List<ColorModel> addProductAmenities = dummyAmenities;
  List<ColorModel> addProductCubitEngineCapacity = dummyEngineCapacity;
  List<ColorModel> addProductCubitBodyType = dummyBodyType;
  List<ColorModel> addProductCubitFuelType = dummyFuelType;



  clearOptionProduct(){
    //// Type Electronics
    isVisibleWarrantyYes = false;
    isVisibleWarrantyNo = false;

    //// Type Electronics
    isVisibleManual = false;
    isVisibleAutomatic = false;

    ////  Properties
    isVisibleFinished = false;
    isVisibleNotFinished = false;
    isVisibleCoreShell = false;
    isVisibleSemiFinished = false;

    isVisibleFurnishedProperties = false;
    isVisibleNotFurnishedProperties = false;


    //// Type Properties
    isVisibleApartment = false;
    isVisibleDuplex = false;
    isVisiblePenthouse = false;
    isVisibleStudio = false;

    ////// Fashion
    isVisibleNightwear = false;
    isVisibleSwimwear = false;
    isVisibleDresses = false;
    isVisibleWeddingApparel = false;
    isVisiblePulloverCoatsJackets = false;
    isVisibleBlouseTShairt = false;
    isVisibleTrousers = false;

    ////// Home Furniture
    isVisibleBedroom = false;
    isVisibleSink = false;
    isVisibleToilet = false;
    isVisibleShower = false;
    isVisibleTowels = false;
    isVisibleWaterMix = false;
    isVisibleMirrors = false;

    ////// Books
    isVisibleAntiques = false;
    isVisibleArt = false;
    isVisibleCollectibles = false;
    isVisibleOldCurrencies = false;
    isVisiblePens = false;
    isVisibleOther = false;

    ////// Kids
    isVisibleBathTub = false;
    isVisibleDiaper = false;
    isVisibleShampoo = false;
    isVisibleSkincare = false;
    isVisibleSilicone = false;
    isVisibleSterilizerTools = false;
    isVisibleToiletKids = false;
    isVisibleOtherKids = false;

    ////// Business
    isVisibleSeeds = false;
    isVisibleCrops = false;
    isVisibleFarmMachinery = false;
    isVisiblePesticides = false;
    isVisibleOtherBusiness = false;

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

  changeWarranty() {
    if (warranty == Warranty.yes) {
      warranty = Warranty.no;
      // print('warranty status is $warranty is 0');
    } else {
      warranty = Warranty.yes;
      //   print('Warranty status is $warranty is 1');
    }
    emit(ChangeWarrantyAddProductState());
  }

  changeFinished() {
    if (finished == Finished.yes) {
      finished = Finished.no;
      // print('warranty status is $finished is 0');
    } else {
      finished = Finished.yes;
      // print('Warranty status is $finished is 1');
    }
    emit(ChangeFinishedAddProductState());
  }

  changeTransmissionType() {
    if (transmissionType == TransmissionType.manual) {
      transmissionType = TransmissionType.automatic;
      // print('warranty status is $transmissionType is 0');
    } else {
      transmissionType = TransmissionType.manual;
      // print('Warranty status is $transmissionType is 1');
    }
    emit(ChangeTransmissionTypeAddProductState());
  }

  List<MyProductUserResponseModel>? myProductsUser;
  MyProductUserModel? ordersPaginated;
  int pageNumberPagination = 1;

  void paginateOrders(int pageNumberPagination) {

    // print("paginateOrders");
    emit(GetProductsLoadingState());
    isLoadingProduct = true;
    DioHelper.getData(
        uri: ApiConstants.addProductUrl,
        token: AppLocalStorage.token,
        query: {'page': pageNumberPagination}).then((value){
      ordersPaginated = MyProductUserModel.fromJson(value.data);

      myProductUserResponseModel = value;
      isLoadingProduct = false;
      emit(GetProductsSuccessState2(myProductUserResponseModel?.data));
    }).catchError((error) {
      //  print("getMyProductUser22222");
      //  print(error.toString());
    });
  }

  ProductPage recommendationProducts = ProductPage.empty();

  getMyProductUser({bool refresh = false}) async{
    //   print("getMyProductUser");
    List<ProductModel> _products = [];
    if (refresh) {
      recommendationProducts = ProductPage.empty();
    }
    if (recommendationProducts.currentPage != 0) {
      if (recommendationProducts.currentPage >=
          recommendationProducts.totalPages!) {
        return;
      }
    }
    recommendationProducts.currentPage != 0
        ? recommendationProducts.loadingPagination = true
        : recommendationProducts.loadingProducts = true;
    emit(GetProductsLoadingState());
    recommendationProducts.currentPage++;
    isLoadingProduct = true;
    await HomeServices.getMyProductsFromAPI(
      query: {'page': recommendationProducts.currentPage},
    ).then((value) {
      print('currentPage');
      print(recommendationProducts.currentPage);
      var data = value.data['data'];
      print('currentPage');
      print(data);
      print(value.data['data']);
      _products.clear();
      if (data.isNotEmpty) {
        print("products $value \n ${value.data}");
        print('token response ${AppLocalStorage.token}');
        print('token response ${value.data['data']}');
        print('token response list $data');
        value.data['data'].forEach((element) {
          _products.add(ProductModel.fromJson(element));
        });
      } else {
        // print('list is empty');
        _products = [];
      }
      recommendationProducts.totalPages = value.data["meta"]["last_page"];
      if (_products.isNotEmpty) {
        recommendationProducts.products.addAll(_products);
      }
      recommendationProducts.loadingPagination = false;
      recommendationProducts.loadingProducts = false;
      emit(GetMyProductsSuccessState(recommendationProducts.products));
      if (recommendationProducts.currentPage !=
          recommendationProducts.totalPages) {
       // getMyProductUser();
      }
    }).catchError((e) {
      print("myProducts $e");
      print("token response error $e");
      recommendationProducts.loadingPagination = false;
      recommendationProducts.loadingProducts = false;
      emit(GetProductsErrorState(error: e.toString()));
    });

  }

  renewProductStatus(BuildContext context,String productId) {
    emit(GetOptionLoadingState());
    AddProductServices.renewProduct(context,productId).then((value) {
      responseModel = value;
      if (responseModel?.success == true) {
        // print('renew product item');
        // print(responseModel?.message);
      } else {
        //print('not renew product item');
      }

    }).catchError((onError) {
      // print('list of error ${onError.toString()}');
      //  CustomFlutterToast(onError.toString());
      emit(GetOptionErrorState(onError.toString()));
    });
  }


  getModelFromVehicle(String brandId) {
    emit(GetOptionLoadingState());
    AddProductServices.getModelFromVehicle(brandId).then((value) {
      // optionModel = value;
      // print('list of length ${value?.data![0].options!.join(',')}');
      // print('list of length length ${value?.data!.length}');
      // print('list of length ${value?.data![0].inputName}');
      // print('list of length ${value?.data![0].inputLabel}');
      // print('list of length ${value?.data![0].inputType}');
      emit(GetOptionSuccessState(value));
    }).catchError((onError) {
      // print('list of error ${onError.toString()}');
      //  CustomFlutterToast(onError.toString());
      emit(GetOptionErrorState(onError.toString()));
    });
  }

  getOptionFromCategories(String categoryId) {
    emit(GetOptionLoadingState());
    AddProductServices.getOptionOfCategory(categoryId).then((value) {
      // optionModel = value;
      //  setOption(value);
      //   print('list of length ${value?.data!.length}');
      //   print('list of length length ${value?.data!.length}');
      // print('list of length ${value?.data![0].inputName}');
      // print('list of length ${value?.data![0].inputLabel}');
      // print('list of length ${value?.data![0].inputType}');
      //  emit(GetOptionSuccessState(value));
    }).catchError((onError) {
      // print('list of error ${onError.toString()}');
      //   CustomFlutterToast(onError.toString());
      emit(GetOptionErrorState(onError.toString()));
    });
  }

  // getMyProducts({refresh = false}) async {
  //   List<ProductModel> _products = [];
  //   if (refresh) {
  //     myProducts = ProductPage.empty();
  //   }
  //   if (myProducts.currentPage != 0) {
  //     if (myProducts.currentPage >= myProducts.totalPages!) {
  //       return;
  //     }
  //   }
  //   myProducts.currentPage != 0
  //       ? myProducts.loadingPagination = true
  //       : myProducts.loadingProducts = true;
  //   emit(GetProductsLoadingState());
  //   myProducts.currentPage++;
  //   await getProductsFromApi(
  //     query: {'page': myProducts.currentPage},
  //   ).then((value) {
  //     print("products $value \n ${value.data}");
  //     var data = value.data['data'];
  //     _products.clear();
  //     if (data.isNotEmpty) {
  //       data.forEach((element) {
  //         _products.add(ProductModel.fromJson(element));
  //       });
  //     } else {
  //       _products = [];
  //     }
  //     myProducts.totalPages = value.data["meta"]["last_page"];
  //     if (_products.isNotEmpty) {
  //       myProducts.products.addAll(_products);
  //     }
  //     print("myProducts ${myProducts.products.length}");
  //     myProducts.loadingPagination = false;
  //     myProducts.loadingProducts = false;
  //     emit(GetProductsSuccessState());
  //     if (myProducts.currentPage != myProducts.totalPages) {
  //       getMyProducts();
  //     }
  //   }).catchError((e) {
  //     print("myProducts $e");
  //     myProducts.loadingPagination = false;
  //     myProducts.loadingProducts = false;
  //     emit(GetProductsErrorState(error: e.toString()));
  //   });
  // }

  selectMainCat({required CategoryModel category}) {
    selectedMainCat = category;
    selectedSubCat = null;
    emit(SelectMainCatState());
  }

  isMainCatSelected({required CategoryModel category}) {
    if (selectedMainCat != null) {
      if (selectedMainCat!.id == category.id) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  selectSubCat({required CategoryModel? category}) {
    selectedSubCat = category;
    emit(SelectSubCatState());
  }

  isSubCatSelected({required CategoryModel category}) {
    if (selectedSubCat != null) {
      if (selectedSubCat!.id == category.id) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  selectBrand({required BrandModel brandModel}) {
    selectedBrand = brandModel;
    emit(SelectOnlyBrandState());
  }

  isBrandSelected({required BrandModel brandModel}) {
    if (selectedBrand != null) {
      if (selectedBrand!.id == brandModel.id) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  selectLocation({required LocationModel location}) {
    selectedLocation = location;
    emit(SelectProductLocationState());
  }

  changeCondition() {
    if (condition == Condition.newProduct) {
      condition = Condition.used;
    } else {
      condition = Condition.newProduct;
    }
    emit(ChangeConditionState());
  }

  pickProductImage() async {
    images = [];
    List<XFile>? _images = await _picker.pickMultiImage() ?? [];

    for (int index = 0; index <= 5; index++) {
      //  print(index);
      images.add(File(_images[index].path));
      emit(PickProductImagesState());
    }

    // emit(PickProductImagesState());
  }

  // deleteProduct(MyProductUserResponseModel product, String isSold) async {
  //   deleteProductFromApi(productId: product.id!, is_sold: isSold);
  // }



  deleteProductItem(context,
      {required String productId, required String isSold}) async {
    // print('loading delete product item');
    // print('product id ${productId}');
    // print('sold product $isSold');
    // print('sold ${AppLocalStorage.token}');
    AddProductServices.deleteProductFromApi(context, productId, isSold)
        .then((value) {
      responseModel = value;
      if (responseModel?.success == true) {
        // print('deleted product item');
        if(isSold.contains('1')){
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => const ProductSoldScreen()));
        }else {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => AppLayout()));
        }

      } else {
        //  print('not deleted product item');
      }
    });
  }

  bool productsContain({required int productId}) {
    bool ret = false;
    for (var element in myProducts.products) {
      if (element.id == productId) {
        ret = true;
      }
    }
    return ret;
  }

  // addNewProduct(
  //     BuildContext context,
  //     String nameOfProductController,
  //     String newPriceController,
  //     String oldPriceController,
  //     String locationController,
  //     String description,
  //     String selectedMainCat,
  //     String selectedSubCat,
  //     String brandController,
  //     String governmentController,
  //     String cityController,
  //     String areaController,
  //     String statusController) {
  //   loading = true;
  //   emit(AddProductLoadingState());
  //   print('loading');
  //
  //   AddProductServices.addProductFromApi(FormData.fromMap(Icons.perm_data_setting)).then((value) {
  //     print('successsss');
  //    if(value?.success == true){
  //      SuccessAlertDialog.showConfirmationDialog(context,
  //          title: '${value?.message}',
  //          confirmLabel: "Done",
  //          imageUrl: "assets/images/svg/addProduct.svg", onTap: () {
  //            Navigator.of(context).pushReplacement(MaterialPageRoute(
  //              builder: (context) => AppLayout(),
  //            ));
  //            clearCache();
  //          });
  //      print('successsss ${value?.message}');
  //      loading = false;
  //      emit(AddProductSuccessState());
  //    }else {
  //      CustomFlutterToast(value?.message);
  //    }
  //   }).catchError((onError) {
  //     print("successsss ${onError.toString()}");
  //     loading = false;
  //     emit(AddProductErrorState(error: onError.toString()));
  //   });
  // }

  updateImageProduct(BuildContext context, String query,File image){
    loadingUpdate = true;
    emit(UpdateImageLoadingState());
    // print('images file');
    // print(image);
    ProductService.updateImageProduct(context, query, image).then((value){
      if(value?.success == true){
        loadingUpdate = false;
        emit(UpdateImageSuccessState(value?.message));
        SuccessAlertDialog.showConfirmationDialog(context,
            title: '${value?.message}',
            confirmLabel: "Done",
            imageUrl: "assets/images/svg/addProduct.svg", onTap: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => ChangeProductScreen2(),
              ));
            });
      }else {
        // print("successsss ${onError.toString()}");
        loadingUpdate = false;
        emit(UpdateImageErrorState(onError.toString()));
      }
    }).catchError((onError) {
      // print("successsss22 ${onError.toString()}");
      loadingUpdate = false;
      emit(UpdateImageErrorState(onError.toString()));
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
    });
  }

  deleteImageProduct(BuildContext context, String query){
    loadingUpdate = true;
    emit(UpdateImageLoadingState());
    ProductService.deleteImageProduct(context, query).then((value){
      if(value?.success == true) {
        loadingUpdate = false;
        //   CustomFlutterToast(value?.message);
        emit(UpdateImageSuccessState(value?.message));
        // SuccessAlertDialog.showConfirmationDialog(context,
        //     title: '${value?.message}',
        //     confirmLabel: "Done",
        //     imageUrl: "assets/images/svg/addProduct.svg", onTap: () {
        //       Navigator.of(context).pushReplacement(MaterialPageRoute(
        //         builder: (context) => ChangeProductScreen2(),
        //       ));
        //     });
      }else {
        //  print("successsss ${onError.toString()}");
        loadingUpdate = false;
        emit(UpdateImageErrorState(value?.message));
      }
    }).catchError((onError) {
      // print("successsss22 ${onError.toString()}");
      loadingUpdate = false;
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
    });
  }
  updateProductVehicles(
      BuildContext context, String query,
      String categoryName, String nameOfProduct, String newPrice, String oldPrice, String whatsAppNumber,
      String status, String governmentId, String cityId, String areaId, String location, String brandId,
      String longitude, String latitude,  String description,
      String optionValueFuelTypeAr, String optionValueYearAr, String optionValueKiloMeterAr,
      String optionValueTransmissionTypeAr, String optionValueColorTypeAr, String optionValueBodyTypeAr,
      String optionValueEngineCapacityTypeAr, String optionValueModelBrandAr, String optionValueFuelType,
      String optionValueYear, String optionValueKiloMeter, String optionValueTransmissionType, String optionValueColorType,
      String optionValueBodyType, String optionValueEngineCapacityType,
      String optionValueModelBrand,
      ) {

    loadingUpdate = true;
    emit(AddProductLoadingState());
    print('loading optionValueFuelType');
    print(optionValueFuelType);
    print(optionValueFuelTypeAr);
    print('loading');


    ProductService.updateVehiclesProduct(context, query, categoryName , nameOfProduct, newPrice,
      oldPrice, whatsAppNumber ,status,governmentId,cityId,areaId,
      location,brandId,longitude,latitude, description,
      optionValueFuelTypeAr, optionValueYearAr, optionValueKiloMeterAr,
      optionValueTransmissionTypeAr, optionValueColorTypeAr, optionValueBodyTypeAr,
      optionValueEngineCapacityTypeAr, optionValueModelBrandAr, optionValueFuelType, optionValueYear, optionValueKiloMeter,
      optionValueTransmissionType, optionValueColorType, optionValueBodyType, optionValueEngineCapacityType,
      optionValueModelBrand,)
        .then((value) {
      loadingUpdate = false;
      // print('successsss');
      SuccessAlertDialog.showConfirmationDialog(context,
          title: 'Successfully updated product ',
          confirmLabel: "Done",
          imageUrl: "assets/images/svg/addProduct.svg", onTap: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => AppLayout(),
            ));
            // clearCache();
          });

      emit(AddProductSuccessState());
    }).catchError((onError) {
      // print("successsss ${onError.toString()}");
      loadingUpdate = false;
      emit(AddProductErrorState(error: onError.toString()));
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
    });
  }

  updateProductProperties(
      BuildContext context, String query,
      String categoryName, String nameOfProduct, String newPrice, String oldPrice, String whatsAppNumber,
      String status, String governmentId,
      String cityId, String areaId, String location, String brandId, String longitude, String latitude,  String description,
      String optionValueTypeApartmentAr, String optionValueDownPaymentAr, String optionValueAmenitiesAr,
      String optionValueBedroomAr, String optionValueBathroomAr, String optionValueAreaAr, String optionValueLevelAr,
      String optionValueFurnishedAr, String optionValueStatusAr,
      String optionValueTypeApartment, String optionValueDownPayment, String optionValueAmenities,
      String optionValueBedroom, String optionValueBathroom, String optionValueArea, String optionValueLevel,
      String optionValueFurnished, String optionValueStatus,
      ) {

    loadingUpdate = true;
    emit(AddProductLoadingState());
    // print('loading');

    ProductService.updatePropertiesProduct(context, query, categoryName , nameOfProduct, newPrice,
      oldPrice, whatsAppNumber,status,governmentId,cityId,areaId,
      location,brandId,longitude,latitude, description, optionValueTypeApartmentAr, optionValueDownPaymentAr, optionValueAmenitiesAr,
      optionValueBedroomAr, optionValueBathroomAr, optionValueAreaAr,
      optionValueLevelAr, optionValueFurnishedAr, optionValueStatusAr, optionValueTypeApartment,
      optionValueDownPayment,optionValueAmenities,
      optionValueBedroom, optionValueBathroom, optionValueArea,
      optionValueLevel, optionValueFurnished, optionValueStatus,)
        .then((value) {

      loadingUpdate = false;
      // print('successsss');
      SuccessAlertDialog.showConfirmationDialog(context,
          title: 'Successfully updated product ',
          confirmLabel: "Done",
          imageUrl: "assets/images/svg/addProduct.svg", onTap: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => AppLayout(),
            ));
            //  clearCache();
          });

      emit(AddProductSuccessState());
    }).catchError((onError) {
      // print("successsss ${onError.toString()}");
      loadingUpdate = false;
      emit(AddProductErrorState(error: onError.toString()));
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
    });
  }

  updateProductElectronics(
      BuildContext context, String query,
      String categoryName, String nameOfProduct, String newPrice, String oldPrice, String whatsAppNumber, String status, String governmentId,
      String cityId, String areaId, String location, String brandId, String longitude, String latitude,  String description,
      String optionValueWarrantyAr, String optionValueWarranty,) {
    print('whatsApp number $whatsAppNumber');
    loadingUpdate = true;
    emit(AddProductLoadingState());
    //print('loading');

    ProductService.updateElectronicsProduct(context, query, categoryName , nameOfProduct, newPrice,
      oldPrice, whatsAppNumber, status,governmentId,cityId,areaId,
      location,brandId,longitude,latitude, description, optionValueWarrantyAr,optionValueWarranty,
    )
        .then((value) {
      loadingUpdate = false;
      // print('successsss');
      print('whatsApp number $whatsAppNumber');
      SuccessAlertDialog.showConfirmationDialog(context,
          title: 'Successfully updated product ',
          confirmLabel: "Done",
          imageUrl: "assets/images/svg/addProduct.svg", onTap: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => AppLayout(),
            ));
            //   clearCache();
          });

      emit(AddProductSuccessState());
    }).catchError((onError) {
      //   print("successsss ${onError.toString()}");
      loadingUpdate = false;
      emit(AddProductErrorState(error: onError.toString()));
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
    });
  }

  updateProductHomeFashion(
      BuildContext context, String query,
      String categoryName, String nameOfProduct, String newPrice, String oldPrice, String whatsAppNumber, String status,
      String governmentId, String cityId, String areaId, String location, String brandId,
      String longitude, String latitude,  String description, String optionValueHomeFashionAr,String optionValueHomeFashion,) {

    loadingUpdate = true;
    emit(AddProductLoadingState());
    print('loadinggggggg');
    print(query);
    print(nameOfProduct);
    print(newPrice);
    print(oldPrice);
    print(whatsAppNumber);
    print(status);
    print(governmentId);
    print(cityId);
    print(areaId);
    print(location);
    print(brandId);
    print(longitude);
    print(latitude);
    print(description);
    print(optionValueHomeFashionAr);
    print(optionValueHomeFashion);

    ProductService.updateHomeFashionProduct(context, query, categoryName , nameOfProduct, newPrice,
      oldPrice, whatsAppNumber, status,governmentId,cityId,areaId,
      location,brandId,longitude,latitude, description, optionValueHomeFashionAr,optionValueHomeFashion,
    )
        .then((value) {
      loadingUpdate = false;
      // print('successsss');
      SuccessAlertDialog.showConfirmationDialog(context,
          title: 'Successfully updated product ',
          confirmLabel: "Done",
          imageUrl: "assets/images/svg/addProduct.svg", onTap: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => AppLayout(),
            ));
            //  clearCache();
          });

      emit(AddProductSuccessState());
    }).catchError((onError) {
      print("successsss ${onError.toString()}");
      loadingUpdate = false;
      emit(AddProductErrorState(error: onError.toString()));
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
    });
  }

  updateProductHomeFurniture(
      BuildContext context, String query,
      String categoryName, String nameOfProduct, String newPrice, String oldPrice, String whatsAppNumber,
      String status, String governmentId, String cityId, String areaId, String location, String brandId,
      String longitude, String latitude,  String description,
      String optionValueFurnitureAr,String optionValueFurniture,) {

    loadingUpdate = true;
    emit(AddProductLoadingState());
    //  print('loading');
    print('statusUser $status');
    print(status);
    ProductService.updateHomeFurnitureProduct(context, query, categoryName , nameOfProduct, newPrice,
      oldPrice, whatsAppNumber, status,governmentId,cityId,areaId,
      location,brandId,longitude,latitude, description, optionValueFurnitureAr,optionValueFurniture,
    ).then((value) {
      loadingUpdate = false;
      //  print('successsss');
      SuccessAlertDialog.showConfirmationDialog(context,
          title: 'Successfully updated product ',
          confirmLabel: "Done",
          imageUrl: "assets/images/svg/addProduct.svg", onTap: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => AppLayout(),
            ));
            //  clearCache();
          });

      emit(AddProductSuccessState());
    }).catchError((onError) {
      // print("successsss ${onError.toString()}");
      loadingUpdate = false;
      emit(AddProductErrorState(error: onError.toString()));
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
    });
  }

  updateProductBooks(
      BuildContext context, String query,
      String categoryName, String nameOfProduct, String newPrice, String oldPrice, String whatsAppNumber, String status,
      String governmentId, String cityId, String areaId, String location, String brandId, String longitude,
      String latitude,  String description,
      String optionValueBooksAr, String optionValueBooks) {

    loadingUpdate = true;
    emit(AddProductLoadingState());
    // print('loading');

    ProductService.updateBooksProduct(context, query, categoryName , nameOfProduct, newPrice,
      oldPrice, whatsAppNumber, status,governmentId,cityId,areaId,
      location,brandId,longitude,latitude, description, optionValueBooksAr,optionValueBooks,
    )
        .then((value) {
      loadingUpdate = false;
      //  print('successsss');
      SuccessAlertDialog.showConfirmationDialog(context,
          title: 'Successfully updated product ',
          confirmLabel: "Done",
          imageUrl: "assets/images/svg/addProduct.svg", onTap: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => AppLayout(),
            ));
            // clearCache();
          });

      emit(AddProductSuccessState());
    }).catchError((onError) {
      // print("successsss ${onError.toString()}");
      loadingUpdate = false;
      emit(AddProductErrorState(error: onError.toString()));
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
    });
  }

  updateProductKids(
      BuildContext context, String query,
      String categoryName, String nameOfProduct, String newPrice, String oldPrice, String whatsAppNumber, String status, String governmentId,
      String cityId, String areaId, String location, String brandId, String longitude,
      String latitude,  String description,
      String optionValueKidsAr,
      String optionValueKids) {

    loadingUpdate = true;
    emit(AddProductLoadingState());
    // print('loading');

    ProductService.updateKidsProduct(context, query, categoryName , nameOfProduct, newPrice,
      oldPrice, whatsAppNumber, status,governmentId,cityId,areaId,
      location,brandId,longitude,latitude, description, optionValueKidsAr,optionValueKids,
    )
        .then((value) {
      loadingUpdate = false;
      //  print('successsss');
      SuccessAlertDialog.showConfirmationDialog(context,
          title: 'Successfully updated product ',
          confirmLabel: "Done",
          imageUrl: "assets/images/svg/addProduct.svg", onTap: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => AppLayout(),
            ));
            // clearCache();
          });

      emit(AddProductSuccessState());
    }).catchError((onError) {
      //  print("successsss ${onError.toString()}");
      loadingUpdate = false;
      emit(AddProductErrorState(error: onError.toString()));
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
    });
  }

  updateProductBusiness(
      BuildContext context, String query,
      String categoryName, String nameOfProduct, String newPrice, String oldPrice, String whatsAppNumber, String status, String governmentId,
      String cityId, String areaId, String location, String brandId, String longitude, String latitude,  String description,
      String optionValueBusinessAr,
      String optionValueBusiness) {

    loadingUpdate = true;
    emit(AddProductLoadingState());
    //print('loading');

    ProductService.updateBusinessProduct(context, query, categoryName , nameOfProduct, newPrice,
      oldPrice, whatsAppNumber, status,governmentId,cityId,areaId,
      location,brandId,longitude,latitude, description, optionValueBusinessAr,optionValueBusiness,)
        .then((value) {
      loadingUpdate = false;
      // CustomFlutterToast(optionValueBusiness);
      //  CustomFlutterToast(optionRequestBusiness);

      //  print('successsss');
      SuccessAlertDialog.showConfirmationDialog(context,
          title: 'Successfully updated product ',
          confirmLabel: "Done",
          imageUrl: "assets/images/svg/addProduct.svg", onTap: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => AppLayout(),
            ));
            // clearCache();
          });

      emit(AddProductSuccessState());
    }).catchError((onError) {
      // print("successsss ${onError.toString()}");
      loadingUpdate = false;
      emit(AddProductErrorState(error: onError.toString()));
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
    });
  }


  addProduct(
      BuildContext context,
      String nameOfProductController,
      String oldPriceController,
      String newPriceController,
      String whatsAppNumberController,
      String locationController,
      String description,
      String governmentController,
      String cityController,
      String areaController,
      String statusController,
      String longitude,
      String latitude,
      ///option Vehicles
      String optionValueFuelTypeAr,
      String optionValueYearAr,
      String optionValueKiloMeterAr,
      String optionValueTransmissionTypeAr,
      String optionValueColorTypeAr,
      String optionValueBodyTypeAr,
      String optionValueEngineCapacityTypeAr,
      String optionValueModelBrandAr,

      String optionValueFuelType,
      String optionValueYear,
      String optionValueKiloMeter,
      String optionValueTransmissionType,
      String optionValueColorType,
      String optionValueBodyType,
      String optionValueEngineCapacityType,
      String optionValueModelBrand,
      ///option  properties
      String optionValueTypeApartmentAr,
      String optionValueDownPaymentAr,
      String optionValueAmenitiesAr,
      String optionValueBedroomAr,
      String optionValueBathroomAr,
      String optionValueAreaAr,
      String optionValueLevelAr,
      String optionValueFurnishedAr,
      String optionValueStatusAr,

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
      String optionValueWarrantyAr,
      String optionValueWarranty,
      /// Home Furniture
      String optionValueFurnitureAr,
      String optionValueFurniture,
      /// Home Fashion
      String optionValueHomeFashionAr,
      String optionValueHomeFashion,
      /// Books
      String optionValueBooksAr,
      String optionValueBooks,
      /// Kids
      String optionValueKidsAr,
      String optionValueKids,
      /// Business
      String optionValueBusinessAr,
      String optionValueBusiness,
      ) async {


    print('response is ');
    print(optionValueFuelTypeAr);
    print(optionValueFuelType);
    print(optionValueYearAr);
    print(optionValueYear);
    print(optionValueKiloMeterAr);
    print(optionValueKiloMeter);
    print(optionValueTransmissionTypeAr);
    print(optionValueTransmissionType);
    print(optionValueColorTypeAr);
    print(optionValueColorType);
    print(optionValueBodyTypeAr);
    print(optionValueBodyType);
    print(optionValueEngineCapacityTypeAr);
    print(optionValueEngineCapacityType);

    print(nameOfProductController);
    print(oldPriceController);
    print(newPriceController);
    print(locationController);
    print(description);
    print(governmentController);
    print(cityController);
    print(areaController);
    print(statusController);


    // print("done 1");
    Map<String, dynamic> _data = {};
    if (selectedMainCat != null) {
      // print("done 2");
      if (images.isNotEmpty) {
        if (selectedSubCat != null) {

          //print('Main Category');
          //  print(selectedMainCat!.name!.en!);
          if(selectedMainCat!.name!.en!.contains('Vehicles')){
            //   CustomFlutterToast(selectedMainCat!.name!.en);

            print('response Vehicles is ');
            print(optionValueFuelType);
            print(optionValueYear);
            print(optionValueKiloMeter);
            print(optionValueTransmissionType);
            print(optionValueColorType);
            print(optionValueBodyType);
            print(optionValueEngineCapacityType);
            print(optionValueModelBrand);

            if (selectedBrand != null) {
              _data = {
                'name': nameOfProductController.trim(),
                'price': newPriceController,
                "old_price": newPriceController,
                "whats_number": whatsAppNumberController,
                "location": locationController,
                "description": description,
                "category_id": selectedMainCat!.id,
                "sub_category_id": selectedSubCat!.id,
                "country_id": governmentController,
                "state_id": cityController,
                "status": statusController,
                "brand_id": selectedBrand!.id,
                "longitude": longitude,
                "latitude": latitude,
                'options[fuelType]' : optionValueFuelType,
                'options[year]' : optionValueYear != '' ? optionValueYear : 'null',
                'options[kiloMeter]' :  optionValueKiloMeter != '' ? optionValueKiloMeter : 'null',
                'options[transmissionType]' : optionValueTransmissionType != '' ? optionValueTransmissionType : 'null',
                'options[colorType]' : optionValueColorType != '' ? optionValueColorType : 'null',
                'options[bodyType]' : optionValueBodyType != '' ? optionValueBodyType : 'null',
                'options[engineCapacity]' : optionValueEngineCapacityType != '' ? optionValueEngineCapacityType : 'null',
                'options[ModelCarBrand]' : optionValueModelBrand != null ? optionValueModelBrand : 'null',
                ///// option arabic
                'options_ar[fuelType]' : optionValueFuelTypeAr != '' ? optionValueFuelTypeAr : 'null',
                'options_ar[year]' : optionValueYearAr != '' ? optionValueYearAr : 'null',
                'options_ar[kiloMeter]' :  optionValueKiloMeterAr != '' ? optionValueKiloMeterAr : 'null',
                'options_ar[transmissionType]' : optionValueTransmissionTypeAr != '' ? optionValueTransmissionTypeAr : 'null',
                'options_ar[colorType]' : optionValueColorTypeAr != '' ? optionValueColorTypeAr : 'null',
                'options_ar[bodyType]' : optionValueBodyTypeAr != '' ? optionValueBodyTypeAr : 'null',
                'options_ar[engineCapacity]' : optionValueEngineCapacityTypeAr != '' ? optionValueEngineCapacityTypeAr : 'null',
                'options_ar[ModelCarBrand]' : optionValueModelBrandAr != null ? optionValueModelBrandAr : 'null'
              };
              // print('images file list');
              // print(images.length);
              for (int i = 0; i < images.length; i++) {
                // print('images file list');
                // print(images[i]);
                _data["images[$i]"] = await MultipartFile.fromFile(
                  images[i].path,
                  filename: images[i].path.split('/').last,
                );
              }
              loading = true;
              emit(AddProductLoadingState());
              await addProductFromApi(FormData.fromMap(_data)).then((value) {
                //todo getproduct
                if (value.data["success"] == true) {
                  // print('successsss update');
                  // print(value.data['message']);
                  // CustomFlutterToast(value.data['message']);
                  SuccessAlertDialog.showConfirmationDialog(context,
                      title: LocaleKeys.productCreatedSuccessfully.tr(),
                      confirmLabel: LocaleKeys.back.tr(),
                      imageUrl: "assets/images/svg/addProduct.svg", onTap: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => AppLayout(),
                        ));
                      });
                  loading = false;
                  clearOptionProduct();
                  selectedMainCat = null;
                  selectedSubCat = null;
                  selectedBrand = null;
                  selectedLocation = null;
                  emit(AddProductSuccessState());
                } else {
                  loading = false;
                  // print('successsss error');
                  // print('successsss error${value.data["message"]}');
                  // print('successsss error${value.data["data"]}');
                  // CustomFlutterToast(value.data["data"]);
                  // snackBar = CustomToast(
                  //     header: value.data["message"], body: value.data["data"]);
                  // ScaffoldMessenger.of(context).showSnackBar(snackBar!);
                }
              }).catchError((e) {
                // print("done error ${e.toString()}");
                print('successsss2 ${e.toString()}');
                loading = false;
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
                //  emit(AddProductErrorState(error: e.toString()));
              });

            }else {
              loading = false;
              AwesomeDialog(
                context: context,
                dialogType: DialogType.ERROR,
                animType: AnimType.RIGHSLIDE,
                btnOkText: LocaleKeys.ok.tr(),
                btnCancelText: LocaleKeys.cancel.tr(),
                title: LocaleKeys.error.tr(),
                desc: LocaleKeys.pleaseSelectBrandFirst.tr(),
                btnCancelOnPress: () {},
                btnOkOnPress: () {},
              ).show();

            }
          }
          else if(selectedMainCat!.name!.en!.contains('Properties')){


            _data = {
              'name': nameOfProductController.trim(),
              'price': newPriceController,
              "old_price": newPriceController,
              "whats_number": whatsAppNumberController,
              "location": locationController,
              "description": description,
              "category_id": selectedMainCat!.id,
              "sub_category_id": selectedSubCat!.id,
              "country_id": governmentController,
              "state_id": cityController,
              "status": '0',
              "longitude": longitude,
              "latitude": latitude,
              'options[TypeApartment]' : optionValueTypeApartment ,
              'options[DownPayment]' : optionValueDownPayment != '' ? optionValueDownPayment : 'null',
              'options[Amenities]' : optionValueAmenities ,
              'options[Bedroom]' :  optionValueBedroom != '' ? optionValueBedroom : 'null',
              'options[Bathroom]' :  optionValueBathroom != '' ? optionValueBathroom : 'null',
              'options[Area]' :  optionValueArea != '' ? optionValueArea : 'null',
              'options[Level]' :  optionValueLevel,
              'options[Furnished]' : optionValueFurnished,
              'options[Status]' : optionValueStatus,
              ///// option arabic
              'options_ar[TypeApartment]' : optionValueTypeApartmentAr ,
              'options_ar[DownPayment]' : optionValueDownPaymentAr != '' ? optionValueDownPaymentAr : 'null',
              'options_ar[Amenities]' : optionValueAmenitiesAr ,
              'options_ar[Bedroom]' :  optionValueBedroomAr != '' ? optionValueBedroomAr : 'null',
              'options_ar[Bathroom]' :  optionValueBathroomAr != '' ? optionValueBathroomAr : 'null',
              'options_ar[Area]' :  optionValueAreaAr != '' ? optionValueAreaAr : 'null',
              'options_ar[Level]' :  optionValueLevelAr,
              'options_ar[Furnished]' : optionValueFurnishedAr,
              'options_ar[Status]' : optionValueStatusAr,

            };

            if (selectedBrand != null) {
              _data["brand_id"] = selectedBrand!.id;
            }
            // print('images file list');
            // print(images.length);
            for (int i = 0; i < images.length; i++) {
              // print('images file list');
              // print(images[i]);
              _data["images[$i]"] = await MultipartFile.fromFile(
                images[i].path,
                filename: images[i].path.split('/').last,
              );
            }
            loading = true;
            emit(AddProductLoadingState());
            await addProductFromApi(FormData.fromMap(_data)).then((value) {
              //todo getproduct
              if (value.data["success"] == true) {
                // print('successsss update');
                // print(value.data['message']);
                //    CustomFlutterToast(value.data['message']);
                SuccessAlertDialog.showConfirmationDialog(context,
                    title: LocaleKeys.productCreatedSuccessfully.tr(),
                    confirmLabel: LocaleKeys.back.tr(),
                    imageUrl: "assets/images/svg/addProduct.svg", onTap: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => AppLayout(),
                      ));
                    });
                loading = false;
                clearOptionProduct();
                selectedMainCat = null;
                selectedSubCat = null;
                selectedBrand = null;
                selectedLocation = null;
                emit(AddProductSuccessState());
              } else {
                loading = false;
                // print('successsss error');
                AwesomeDialog(
                  context: context,
                  btnOkText: LocaleKeys.ok.tr(),
                  btnCancelText: LocaleKeys.cancel.tr(),
                  dialogType: DialogType.ERROR,
                  animType: AnimType.RIGHSLIDE,
                  title: value.data["message"],
                  desc: '${value.data["data"]}',
                  btnCancelOnPress: () {},
                  btnOkOnPress: () {},
                ).show();

              }
            }).catchError((e) {
              print("done error ${e.toString()}");
              print('successsss2 ${e.toString()}');
              loading = false;
              AwesomeDialog(
                context: context,
                dialogType: DialogType.warning,
                animType: AnimType.RIGHSLIDE,
                title: LocaleKeys.warning.tr(),
                btnOkText: LocaleKeys.ok.tr(),
                btnCancelText: LocaleKeys.cancel.tr(),
                body: Text(e.toString()),
                desc: LocaleKeys.internetConnection.tr(),
                btnCancelOnPress: () {},
                btnOkOnPress: () {},
              ).show();
              //  emit(AddProductErrorState(error: e.toString()));

            });

          }
          else if(selectedMainCat!.name!.en!.contains('Electronics')){

            print('whatsAppNumberController');
            print(whatsAppNumberController);

            if (selectedBrand != null) {
              _data = {
                'name': nameOfProductController.trim(),
                'price': newPriceController,
                "old_price": newPriceController,
                "whats_number": whatsAppNumberController,
                "location": locationController,
                "description": description,
                "category_id": selectedMainCat!.id,
                "sub_category_id": selectedSubCat!.id,
                "country_id": governmentController,
                "state_id": cityController,
                "status": statusController,
                "longitude": longitude,
                "brand_id": selectedBrand!.id,
                "latitude": latitude,
                'options[warranty]' : optionValueWarranty,
                'options_ar[warranty]' : optionValueWarrantyAr
              };

              // print('images file list');
              // print(images.length);
              for (int i = 0; i < images.length; i++) {
                //   print('images file list');
                //    print(images[i]);
                _data["images[$i]"] = await MultipartFile.fromFile(
                  images[i].path,
                  filename: images[i].path.split('/').last,
                );
              }
              loading = true;
              emit(AddProductLoadingState());
              await addProductFromApi(FormData.fromMap(_data)).then((value) {
                //todo getproduct
                if (value.data["success"] == true) {
                  //  print('successsss update');
                  //  print(value.data['message']);
                  //   CustomFlutterToast(value.data['message']);
                  SuccessAlertDialog.showConfirmationDialog(context,
                      title: LocaleKeys.productCreatedSuccessfully.tr(),
                      confirmLabel: LocaleKeys.back.tr(),
                      imageUrl: "assets/images/svg/addProduct.svg", onTap: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => AppLayout(),
                        ));
                      });
                  loading = false;
                  clearOptionProduct();
                  selectedMainCat = null;
                  selectedSubCat = null;
                  selectedBrand = null;
                  selectedLocation = null;
                  emit(AddProductSuccessState());
                } else {
                  loading = false;
                  // print('successsss error');
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.ERROR,
                    animType: AnimType.RIGHSLIDE,
                    btnOkText: LocaleKeys.ok.tr(),
                    btnCancelText: LocaleKeys.cancel.tr(),
                    title: value.data["message"],
                    desc: '${value.data["data"]}',
                    btnCancelOnPress: () {},
                    btnOkOnPress: () {},
                  ).show();
                }
              }).catchError((e) {
                // print("done error ${e.toString()}");
                //  print('successsss2 ${e.toString()}');
                loading = false;
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
                emit(AddProductErrorState(error: e.toString()));
              });

            }else {
              loading = false;
              AwesomeDialog(
                context: context,
                dialogType: DialogType.ERROR,
                animType: AnimType.RIGHSLIDE,
                btnOkText: LocaleKeys.ok.tr(),
                btnOkColor: AppPalette.primary,
                btnCancelText: LocaleKeys.cancel.tr(),
                title: LocaleKeys.error.tr(),
                desc: LocaleKeys.pleaseSelectBrandFirst.tr(),
                btnCancelOnPress: () {},
                btnOkOnPress: () {},
              ).show();

            }


          }
          else if(selectedMainCat!.name!.en!.contains('Fashion')){

            // print('optionRequestHomeFashion');
            // print(optionRequestHomeFashion);
            // print(optionValueHomeFashion);

            _data = {
              'name': nameOfProductController.trim(),
              'price': newPriceController,
              "old_price": newPriceController,
              "whats_number": whatsAppNumberController,
              "location": locationController,
              "description": description,
              "category_id": selectedMainCat!.id,
              "sub_category_id": selectedSubCat!.id,
              "country_id": governmentController,
              "state_id": cityController,
              "status": statusController,
              "longitude": longitude,
              "latitude": latitude,
              'options[HomeFashionType]' : optionValueHomeFashion,
              'options_ar[HomeFashionType]' : optionValueHomeFashionAr,
            };

            if (selectedBrand != null) {
              _data["brand_id"] = selectedBrand!.id;
            }
            //   print('images file list');
            //   print(images.length);
            for (int i = 0; i < images.length; i++) {
              //   print('images file list');
              //   print(images[i]);
              _data["images[$i]"] = await MultipartFile.fromFile(
                images[i].path,
                filename: images[i].path.split('/').last,
              );
            }
            loading = true;
            emit(AddProductLoadingState());
            await addProductFromApi(FormData.fromMap(_data)).then((value) {
              //todo getproduct
              if (value.data["success"] == true) {
                //   print('successsss update');
                //    print(value.data['message']);
                // CustomFlutterToast(value.data['message']);
                SuccessAlertDialog.showConfirmationDialog(context,
                    title: LocaleKeys.productCreatedSuccessfully.tr(),
                    confirmLabel: LocaleKeys.back.tr(),
                    imageUrl: "assets/images/svg/addProduct.svg", onTap: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => AppLayout(),
                      ));
                    });
                loading = false;
                clearOptionProduct();
                selectedMainCat = null;
                selectedSubCat = null;
                selectedBrand = null;
                selectedLocation = null;
                emit(AddProductSuccessState());
              } else {
                loading = false;
                //  print('successsss error');
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.ERROR,
                  animType: AnimType.RIGHSLIDE,
                  btnOkText: LocaleKeys.ok.tr(),
                  btnCancelText: LocaleKeys.cancel.tr(),
                  title: value.data["message"],
                  desc: '${value.data["data"]}',
                  btnCancelOnPress: () {},
                  btnOkOnPress: () {},
                ).show();
              }
            }).catchError((e) {
              // print("done error ${e.toString()}");
              //   print('successsss2 ${e.toString()}');
              loading = false;
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
              emit(AddProductErrorState(error: e.toString()));
            });

          }
          else if(selectedMainCat!.name!.en!.contains('Home Furniture')){

            //  print('response is is ');
            //  print(optionRequestHomeFashion);
            //  print(optionValueHomeFashion);

            _data = {
              'name': nameOfProductController.trim(),
              'price': newPriceController,
              "old_price": newPriceController,
              "whats_number": whatsAppNumberController,
              "location": locationController,
              "description": description,
              "category_id": selectedMainCat!.id,
              "sub_category_id": selectedSubCat!.id,
              "country_id": governmentController,
              "state_id": cityController,
              "status": statusController,
              "longitude": longitude,
              "latitude": latitude,
              'options[furnitureType]' : optionValueFurniture,
              'options_ar[furnitureType]' : optionValueFurnitureAr
            };

            if (selectedBrand != null) {
              _data["brand_id"] = selectedBrand!.id;
            }
            //  print('images file list');
            //   print(images.length);
            for (int i = 0; i < images.length; i++) {
              //    print('images file list');
              //    print(images[i]);
              _data["images[$i]"] = await MultipartFile.fromFile(
                images[i].path,
                filename: images[i].path.split('/').last,
              );
            }
            loading = true;
            emit(AddProductLoadingState());
            await addProductFromApi(FormData.fromMap(_data)).then((value) {
              //todo getproduct
              if (value.data["success"] == true) {
                //     print('successsss update');
                //     print(value.data['message']);
                //  CustomFlutterToast(value.data['message']);
                SuccessAlertDialog.showConfirmationDialog(context,
                    title: LocaleKeys.productCreatedSuccessfully.tr(),
                    confirmLabel: LocaleKeys.back.tr(),
                    imageUrl: "assets/images/svg/addProduct.svg", onTap: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => AppLayout(),
                      ));
                    });
                loading = false;
                clearOptionProduct();
                selectedMainCat = null;
                selectedSubCat = null;
                selectedBrand = null;
                selectedLocation = null;
                emit(AddProductSuccessState());
              } else {
                loading = false;
                //   print('successsss error');
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.ERROR,
                  animType: AnimType.RIGHSLIDE,
                  btnOkText: LocaleKeys.ok.tr(),
                  btnCancelText: LocaleKeys.cancel.tr(),
                  title: value.data["message"],
                  desc: '${value.data["data"]}',
                  btnCancelOnPress: () {},
                  btnOkOnPress: () {},
                ).show();
              }
            }).catchError((e) {
              // print("done error ${e.toString()}");
              //    print('successsss2 ${e.toString()}');
              loading = false;
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
              emit(AddProductErrorState(error: e.toString()));
            });

          }
          else if(selectedMainCat!.name!.en!.contains('Books, Sports & Hobbies')){

            _data = {
              'name': nameOfProductController.trim(),
              'price': newPriceController,
              "old_price": newPriceController,
              "whats_number": whatsAppNumberController,
              "location": locationController,
              "description": description,
              "category_id": selectedMainCat!.id,
              "sub_category_id": selectedSubCat!.id,
              "country_id": governmentController,
              "state_id": cityController,
              "status": statusController,
              "longitude": longitude,
              "latitude": latitude,
              'options[BooksType]' : optionValueBooks,
              'options_ar[BooksType]' : optionValueBooksAr
            };
            if (selectedBrand != null) {
              _data["brand_id"] = selectedBrand!.id;
            }
            //  print('images file list');
            //  print(images.length);
            for (int i = 0; i < images.length; i++) {
              //    print('images file list');
              //     print(images[i]);
              _data["images[$i]"] = await MultipartFile.fromFile(
                images[i].path,
                filename: images[i].path.split('/').last,
              );
            }
            loading = true;
            emit(AddProductLoadingState());
            await addProductFromApi(FormData.fromMap(_data)).then((value) {
              //todo getproduct
              if (value.data["success"] == true) {
                //   print('successsss update');
                //   print(value.data['message']);
                //  CustomFlutterToast(value.data['message']);
                SuccessAlertDialog.showConfirmationDialog(context,
                    title: LocaleKeys.productCreatedSuccessfully.tr(),
                    confirmLabel: LocaleKeys.back.tr(),
                    imageUrl: "assets/images/svg/addProduct.svg", onTap: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => AppLayout(),
                      ));
                    });
                loading = false;
                clearOptionProduct();
                selectedMainCat = null;
                selectedSubCat = null;
                selectedBrand = null;
                selectedLocation = null;
                emit(AddProductSuccessState());
              } else {
                loading = false;
                //   print('successsss error');
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.ERROR,
                  animType: AnimType.RIGHSLIDE,
                  btnOkText: LocaleKeys.ok.tr(),
                  btnCancelText: LocaleKeys.cancel.tr(),
                  title: value.data["message"],
                  desc: '${value.data["data"]}',
                  btnCancelOnPress: () {},
                  btnOkOnPress: () {},
                ).show();
              }
            }).catchError((e) {
              // print("done error ${e.toString()}");
              // print('successsss2 ${e.toString()}');
              loading = false;
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
              emit(AddProductErrorState(error: e.toString()));
            });

          }
          else if(selectedMainCat!.name!.en!.contains('Kids & Babies')){

            _data = {
              'name': nameOfProductController.trim(),
              'price': newPriceController,
              "old_price": newPriceController,
              "whats_number": whatsAppNumberController,
              "location": locationController,
              "description": description,
              "category_id": selectedMainCat!.id,
              "sub_category_id": selectedSubCat!.id,
              "country_id": governmentController,
              "state_id": cityController,
              "status": statusController,
              "longitude": longitude,
              "latitude": latitude,
              'options[KidsType]' : optionValueKids,
              'options_ar[KidsType]' : optionValueKidsAr
            };
            if (selectedBrand != null) {
              _data["brand_id"] = selectedBrand!.id;
            }
            //  print('images file list');
            //   print(images.length);
            for (int i = 0; i < images.length; i++) {
              //    print('images file list');
              //     print(images[i]);
              _data["images[$i]"] = await MultipartFile.fromFile(
                images[i].path,
                filename: images[i].path.split('/').last,
              );
            }
            loading = true;
            emit(AddProductLoadingState());
            await addProductFromApi(FormData.fromMap(_data)).then((value) {
              //todo getproduct
              if (value.data["success"] == true) {
                //      print('successsss update');
                //     print(value.data['message']);
                //  CustomFlutterToast(value.data['message']);
                SuccessAlertDialog.showConfirmationDialog(context,
                    title: LocaleKeys.productCreatedSuccessfully.tr(),
                    confirmLabel: LocaleKeys.back.tr(),
                    imageUrl: "assets/images/svg/addProduct.svg", onTap: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => AppLayout(),
                      ));
                    });
                loading = false;
                clearOptionProduct();
                selectedMainCat = null;
                selectedSubCat = null;
                selectedBrand = null;
                selectedLocation = null;
                emit(AddProductSuccessState());
              } else {
                loading = false;
                //  print('successsss error');
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.ERROR,
                  animType: AnimType.RIGHSLIDE,
                  btnOkText: LocaleKeys.ok.tr(),
                  btnCancelText: LocaleKeys.cancel.tr(),
                  title: value.data["message"],
                  desc: '${value.data["data"]}',
                  btnCancelOnPress: () {},
                  btnOkOnPress: () {},
                ).show();
              }
            }).catchError((e) {
              // print("done error ${e.toString()}");
              //  print('successsss2 ${e.toString()}');
              loading = false;
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
              emit(AddProductErrorState(error: e.toString()));
            });

          }
          else if(selectedMainCat!.name!.en!.contains('Business - Industrial - Agriculture')){

            _data = {
              'name': nameOfProductController.trim(),
              'price': newPriceController,
              "old_price": newPriceController,
              "whats_number": whatsAppNumberController,
              "location": locationController,
              "description": description,
              "category_id": selectedMainCat!.id,
              "sub_category_id": selectedSubCat!.id,
              "country_id": governmentController,
              "state_id": cityController,
              "status": statusController,
              "longitude": longitude,
              "latitude": latitude,
              'options[BusinessType]' : optionValueBusiness,
              'options_ar[BusinessType]' : optionValueBusinessAr
            };
            if (selectedBrand != null) {
              _data["brand_id"] = selectedBrand!.id;
            }
            // print('images file list');
            //  print(images.length);
            for (int i = 0; i < images.length; i++) {
              //   print('images file list');
              //   print(images[i]);
              _data["images[$i]"] = await MultipartFile.fromFile(
                images[i].path,
                filename: images[i].path.split('/').last,
              );
            }
            loading = true;
            emit(AddProductLoadingState());
            await addProductFromApi(FormData.fromMap(_data)).then((value) {
              //todo getproduct
              if (value.data["success"] == true) {
                //    print('successsss update');
                //    print(value.data['message']);
                //    CustomFlutterToast(value.data['message']);
                SuccessAlertDialog.showConfirmationDialog(context,
                    title: LocaleKeys.productCreatedSuccessfully.tr(),
                    confirmLabel: LocaleKeys.back.tr(),
                    imageUrl: "assets/images/svg/addProduct.svg", onTap: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => AppLayout(),
                      ));
                    });
                loading = false;
                clearOptionProduct();
                selectedMainCat = null;
                selectedSubCat = null;
                selectedBrand = null;
                selectedLocation = null;
                emit(AddProductSuccessState());
              } else {
                loading = false;
                //  print('successsss error');
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.ERROR,
                  animType: AnimType.RIGHSLIDE,
                  btnOkText: LocaleKeys.ok.tr(),
                  btnCancelText: LocaleKeys.cancel.tr(),
                  title: value.data["message"],
                  desc: '${value.data["data"]}',
                  btnCancelOnPress: () {},
                  btnOkOnPress: () {},
                ).show();
              }
            }).catchError((e) {
              // print("done error ${e.toString()}");
              //  print('successsss2 ${e.toString()}');
              loading = false;
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
              emit(AddProductErrorState(error: e.toString()));
            });

          }

        } else {
          loading = false;
          AwesomeDialog(
            context: context,
            dialogType: DialogType.ERROR,
            animType: AnimType.RIGHSLIDE,
            btnOkText: LocaleKeys.ok.tr(),
            btnCancelText: LocaleKeys.cancel.tr(),
            title: LocaleKeys.error.tr(),
            desc: LocaleKeys.pleaseSelectSubCategoryFirst.tr(),
            btnCancelOnPress: () {},
            btnOkOnPress: () {},
          ).show();
        }
      } else {
        loading = false;
        AwesomeDialog(
          context: context,
          dialogType: DialogType.ERROR,
          animType: AnimType.RIGHSLIDE,
          title: LocaleKeys.error.tr(),
          btnOkText: LocaleKeys.ok.tr(),
          btnCancelText: LocaleKeys.cancel.tr(),
          desc: LocaleKeys.imageRequired.tr(),
          btnCancelOnPress: () {},
          btnOkOnPress: () {},
        ).show();
      }
    } else {
      loading = false;
      AwesomeDialog(
        context: context,
        dialogType: DialogType.ERROR,
        animType: AnimType.RIGHSLIDE,
        btnOkText: LocaleKeys.ok.tr(),
        btnCancelText: LocaleKeys.cancel.tr(),
        title: LocaleKeys.error.tr(),
        desc: LocaleKeys.selectMainCategory.tr(),
        btnCancelOnPress: () {},
        btnOkOnPress: () {},
      ).show();
    }
  }

  clearCache() {
    images = [];
    selectedMainCat = null;
    selectedSubCat = null;
    selectedBrand = null;
    selectedLocation = null;
  }
}
