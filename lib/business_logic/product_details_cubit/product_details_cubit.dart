import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/data/models/product_details_model.dart';
import 'package:shop/data/webservices/api_services/products_services.dart';

import '../../data/models/show_details_product_model.dart';
import '../../data/webservices/api_services/my_favorite_user_service.dart';

part 'product_details_state.dart';

enum ConditionProduct { newProduct, used }

enum WarrantyProduct { yes, no }

enum TransmissionTypeProduct { manual, automatic }

enum FinishedProduct { yes, no }

enum TypeHomeFurnitureProduct { fullBathroom, sink, toilet, showerRoomTub,towels, waterMixersShowerHeads, mirrorsShelvesOtherAccessories }

enum TypeHomeFashionProduct { nightwear, swimwear, dresses, weddingApparel, pulloverCoatsJackets, blouseTshirtsTops, trousersLeggingsJeans }

enum TypeKidsProduct { bathTub, diaper, shampooSoaps, skincare, siliconeNippleProtectors, sterilizerTools, toiletTrainingSeat, other }

enum TypeBooksProduct { antiques, aRT, collectibles, oldCurrencies, pensWritingInstruments, other }

enum TypeBusinessProduct  { seeds, crops, farmMachinery, pesticides, other }

enum StatusPropertiesProduct  { finished, notFinished, coreShell, semiFinished }

class ProductDetailsCubit extends Cubit<ProductDetailsState>
    with ProductsServices {
  ProductDetailsCubit() : super(ProductDetailsInitial());

  static ProductDetailsCubit get(BuildContext context) =>
      BlocProvider.of(context);

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

  ConditionProduct condition = ConditionProduct.newProduct;
  WarrantyProduct warranty = WarrantyProduct.yes;
  TransmissionTypeProduct transmissionType = TransmissionTypeProduct.manual;
  FinishedProduct finished = FinishedProduct.yes;


  Map<int, ProductDetailsModel> productDetails = {};
  Map<int, bool> productDetailsLoading = {};


  List<ShowDetailsProductResponseModel>? showDetailsProductResponseModel;

  changeCondition() {
    if (condition == ConditionProduct.newProduct) {
      condition = ConditionProduct.used;
    } else {
      condition = ConditionProduct.newProduct;
    }
    emit(ChangeConditionProductState());
  }

  getProductDetailsUser(String productId){
    emit(LoadingProductDetailsState());
    ProductsServices.getProductDetails(productId).then((value){
      showDetailsProductResponseModel = value?.data;
      emit(SuccessProductDetailsState(value?.data));
    });
  }

  getProductDetails({required int productId}) async {
    productDetailsLoading[productId] = true;
    emit(LoadingProductDetailsState());
    await getProductDetailsFromApi(productId: productId).then((value) {
      showDetailsProductResponseModel = value.data["data"][0];
      var data = value.data["data"][0];
      productDetails[productId] = ProductDetailsModel.fromJson(data);
      emit(SuccessProductDetailsState(data));
    }).catchError((e) {
      productDetailsLoading[productId] = false;
      emit(ErrorProductDetailsState(error: e.toString()));
    });
  }

  addSubscribeUser(String favoriteUserId){
    emit(SubscribeUserDetailsLoadingState());
    MyFavoriteUserService.setSubscribeUser(favoriteUserId).then((value){

      emit(SubscribeUserDetailsSuccessfullyState(value?.message));
    });
  }

  deleteSubscribeUser(String favoriteUserId){
    emit(SubscribeUserDetailsLoadingState());
    print('favoriteUserId');
    print(favoriteUserId);
    MyFavoriteUserService.deleteSubscribeUser(favoriteUserId).then((value){
      print('success message');
      print(value?.message);
      emit(SubscribeUserDetailsSuccessfullyState(value?.message));
    });
  }


}
