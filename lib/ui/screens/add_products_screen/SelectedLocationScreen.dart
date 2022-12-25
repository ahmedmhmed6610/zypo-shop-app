// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:shop/ui/screens/add_products_screen/select_your_location/auto_complete_prediction_model.dart';
// import 'package:shop/ui/screens/add_products_screen/select_your_location/network_utility.dart';
// import 'package:shop/ui/screens/add_products_screen/select_your_location/place_auto_complete_response.dart';
// import 'package:shop/utils/app_palette.dart';
// import 'package:shop/utils/app_size_boxes.dart';
//
// import '../../../helpers/cache_helper.dart';
// import '../../../translations/locale_keys.g.dart';
// import '../../../utils/styles.dart';
// import '../../widgets/My_products_widgets/add_product_widgets/input_text_form_field.dart';
// import '../../widgets/app_text.dart';
// import '../../widgets/app_text_field.dart';
// import '../../widgets/filter_widgets/choose_location_widgets/choose_location_search_widget.dart';
// import '../filter_screens/filter_screen.dart';
//
//
// class SelectedLocationScreen extends StatefulWidget {
//   SelectedLocationScreen({Key? key, this.data, this.areaName,required this.locationUser,
//     required this.fromPrice,required this.toPrice,required this.nameProduct,required this.description,
//     required this.bodyType,required this.engineCapacityType,required this.colorType,required this.fuelType,
//     required this.levelType,required this.kiloMetresType,required this.amenitiesType,this.whatsAppNumber,
//     this.fromYear,this.toYear,this.bathroom,this.bedroom,this.fromArea,this.toArea,this.fromDownPayment,
//     this.toDownPayment,this.fromkiloMetresType,this.tokiloMetresType,this.brandId,this.status,
//     this.typeApartment,this.statusApartment,this.typeFashion,this.typeWarrannt,this.typeCondtion,
//     this.typeHomeFurniture,this.typeBooks,this.typeKids,this.typeBusiness,this.warrantyElectronic,this.transmissionVehicles,
//     this.area,this.downPayment,this.year,this.productId, this.governmentId, this.governmentName, this.cityId, this.cityName, this.areaId}) : super(key: key);
//
//   final String? data;
//   final String? governmentId,governmentName,productId,whatsAppNumber;
//   final String? cityId,cityName,year,area,downPayment,typeCondtion,typeWarrannt,
//       typeApartment,statusApartment,typeFashion,typeHomeFurniture,
//       typeBooks,typeKids,typeBusiness,warrantyElectronic,transmissionVehicles;
//   final String? areaId,areaName,fuelType,amenitiesType,bodyType,colorType,engineCapacityType,kiloMetresType,levelType;
//   final String? locationUser,fromPrice,toPrice,nameProduct,description;
//   String? brandId,fromDownPayment,toDownPayment;
//   String? status,fromYear,toYear,bedroom,bathroom;
//   String? fromArea,toArea,fromkiloMetresType,tokiloMetresType;
//
//   @override
//   _SelectedLocationScreenState createState() => _SelectedLocationScreenState();
// }
//
// class _SelectedLocationScreenState extends State<SelectedLocationScreen> {
//
//   String? location;
//   LatLng? latlong;
//   String? myLocation,myLocationFirst;
//   LocationPermission? permission;
//   bool isSelectedMyLocation = true;
//   bool isSelectedLocation = false;
//   String googleApikey = "AIzaSyBZD6gk02Nv1rwUyxplxahW690rtRm1mu0";
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     myLocation = CacheHelper.getData(key: 'location');
//     print('myLocation');
//     print(myLocation);
//      isSelectedMyLocation = true;
//      isSelectedLocation = false;
//   }
//   void getMyLocationFromPlacesFirst(double lat,double lang)async {
//
//     List<Placemark> newPlace = await placemarkFromCoordinates(lat, lang);
//     // this is all you need
//     Placemark placeMark = newPlace[0];
//
//     // name county
//     String? name = placeMark.name;
//     // state name
//     String? locality = placeMark.locality;
//     // governorate name
//     String? administrativeArea = placeMark.administrativeArea;
//     //
//     String? administrativeSub = placeMark.subAdministrativeArea;
//     // postal code
//     String? postalCode = placeMark.postalCode;
//     // country name
//     String? country = placeMark.country;
//     String? thoroughfare = placeMark.street;
//     // street details
//     String? street = placeMark.street;
//     location = '$locality - $postalCode - $street';
//     if (kDebugMode) {
//
//       print('location is search $lat');
//       print('location is search $lang');
//
//       print(administrativeArea);
//       print(locality);
//       print('$administrativeSub - $street');
//       print(postalCode);
//       print(country);
//       print(street);
//       print('lat location');
//       print(lat);
//       print('lan location');
//       print(lang);
//       print('postalCode');
//       print(postalCode);
//       print(location);
//     }
//
//     CacheHelper.saveData(key: 'postalCode', value: '$postalCode');
//     CacheHelper.saveData(key: 'latitude', value: lat.toString());
//     CacheHelper.saveData(key: 'longitude', value: lang.toString());
//     CacheHelper.saveData(key: 'location', value: location);
//
//    // Navigator.pushReplacementNamed(context, AppRoutesName.home);
//
//   }
//   void getMyLocationFromPlaces(double lat,double lang)async {
//
//     List<Placemark> newPlace = await placemarkFromCoordinates(lat, lang);
//     // this is all you need
//     Placemark placeMark = newPlace[0];
//
//     // name county
//     String? name = placeMark.name;
//     // state name
//     String? locality = placeMark.locality;
//     // governorate name
//     String? administrativeArea = placeMark.administrativeArea;
//     //
//     String? administrativeSub = placeMark.subAdministrativeArea;
//     // postal code
//     String? postalCode = placeMark.postalCode;
//     // country name
//     String? country = placeMark.country;
//     String? thoroughfare = placeMark.street;
//     // street details
//     String? street = placeMark.street;
//     location = '$locality - $postalCode - $street';
//     if (kDebugMode) {
//       print('location is search $lat');
//       print('location is search $lang');
//
//       print(administrativeArea);
//       print(locality);
//       print('$administrativeSub - $street');
//       print(postalCode);
//       print(country);
//       print(street);
//       print('lat location');
//       print(lat);
//       print('lan location');
//       print(lang);
//       print('postalCode');
//       print(postalCode);
//       print(location);
//     }
//
//     CacheHelper.saveData(key: 'postalCode', value: '$postalCode');
//     CacheHelper.saveData(key: 'latitude', value: lat.toString());
//     CacheHelper.saveData(key: 'longitude', value: lang.toString());
//     CacheHelper.saveData(key: 'location', value: location);
//
//     if (postalCode !=''){
//      // Navigator.pushReplacementNamed(context, AppRoutesName.home);
//     }else {
//      // CustomFlutterToast('An dieser Adresse gibt es keine Postleitzahl', AppColors.red, AppColors.white);
//     }
//
//   }
//
//   List<AutocompletePrediction>? placePrediction = [];
//
//   void placeAutoComplete(String query) async{
//
//     String googleApikey = "AIzaSyDg24ADy7FQdpJr5wP6t7LuLE6Mp3XCE64";
//     Uri uri = Uri.parse("https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$query&key=$googleApikey&sensor=true");
//
//     String? response = await NetworkUtility.fetchUrl(uri);
//
//     if(response != null){
//       PlaceAutocompleteResponse autocompleteResponse = PlaceAutocompleteResponse.ParceAutocompleteResult(response);
//       if(autocompleteResponse.predictions != null){
//         setState(() {
//           placePrediction = autocompleteResponse.predictions;
//         });
//       }
//       print('response location is');
//       print(query);
//       print(googleApikey);
//       print(response);
//     }
//
//   }
//
//   TextEditingController selectYourLocation = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(LocaleKeys.chooseLocation.tr()),
//         elevation: 0.0,
//         leading: InkWell(
//           onTap: (){
//             Navigator.of(context).pushReplacement(MaterialPageRoute(
//                 builder: (context) => FilterScreen(
//                   fromPrice: widget.fromPrice,
//                   toPrice: widget.toPrice,
//                   levelType: widget.levelType,
//                   fromYear: widget.fromYear,
//                   toYear: widget.toYear,
//                   bathroom: widget.bathroom,
//                   bedroom: widget.bedroom,
//                   fromArea: widget.fromArea,
//                   toArea: widget.toArea,
//                   fromDownPayment: widget.fromDownPayment,
//                   toDownPayment: widget.toDownPayment,
//                   fromkiloMetresType: widget.fromkiloMetresType,
//                   tokiloMetresType: widget.tokiloMetresType,
//                   kiloMetresType: widget.kiloMetresType,
//                   amenitiesType: widget.amenitiesType,
//                   fuelType: widget.fuelType,
//                   engineCapacityType: widget.engineCapacityType,
//                   colorType: widget.colorType,
//                   bodyType: widget.bodyType,
//                   locationUser: '',)));
//
//           },
//           child: const Icon(Icons.arrow_back_ios,
//               size: 20.0, color: AppPalette.black),
//         ),
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               25.heightBox,
//               Padding(
//                 padding:  EdgeInsets.symmetric(horizontal: 10.w),
//                 child: AppTextField(
//                   onTextChange: (value){
//                     placeAutoComplete('$value');
//                   },
//                   onTap: () async{
//                     // var place = await PlacesAutocomplete.show(
//                     //     context: context,
//                     //     apiKey: googleApikey,
//                     //     mode: Mode.fullscreen,
//                     //     decoration: InputDecoration(),
//                     //     types: [],
//                     //     strictbounds: false,
//                     //     components: [Component(Component.country, 'de')],
//                     //     //google_map_webservice package
//                     //     onError: (err) {
//                     //       print(err);
//                     //     });
//                     // // displayPrediction(p: place, context: context);
//                     //
//                     // final plist = GoogleMapsPlaces(
//                     //   apiKey: googleApikey,
//                     //   apiHeaders: await const GoogleApiHeaders().getHeaders(),
//                     //   //from google_api_headers package
//                     // );
//                     // String placeid = place?.placeId ?? "0";
//                     // final detail = await plist.getDetailsByPlaceId(placeid);
//                     // final geometry = detail.result.geometry!;
//                     // final lat = geometry.location.lat;
//                     // final lang = geometry.location.lng;
//                     // getMyLocationFromPlaces(lat, lang);
//                     // print('placeId');
//                     // print(place?.placeId);
//
//                   },
//                   initialValue: '',
//                   hint: LocaleKeys.selectYourLocation.tr(),
//                   suffixWidget: const Icon(Icons.search),
//                   name: 'search-textfield',
//                   textType: TextInputType.text,
//                   inputAction: TextInputAction.done,
//                   // validator: FormBuilderValidators.compose([
//                   //   FormBuilderValidators.required(errorText: AppString.pleaseEnterYourFirstName),
//                   // ]),
//                 )
//               ),
//              10.heightBox,
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 10.w),
//                 child: GestureDetector(
//                   onTap: () async{
//                     permission = await Geolocator.checkPermission();
//                     if (permission == LocationPermission.denied) {
//                       permission = await Geolocator.requestPermission();
//                       if (permission == LocationPermission.deniedForever) {
//                         return Future.error('Location Not Available');
//                       }
//                     }else {
//                       Position position = await Geolocator.getCurrentPosition(
//                           desiredAccuracy: LocationAccuracy.high);
//                       getMyLocationFromPlacesFirst(position.latitude, position.longitude);
//                     }
//
//                   },
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       AppText(
//                         text: LocaleKeys.currentLocation.tr(),
//                         textStyle: TextStyle(color: Colors.black, fontSize: 16.h),
//                         textAlign: TextAlign.center,
//                       ),
//                       15.widthBox,
//                       Image.asset('assets/images/navigation.png',color: AppPalette.primary,width: 25,height: 25,)
//                     //  Icon(Icons.my_location,size: 35,color: AppColors.greenLight,)
//                     ],
//                   ),
//                 ),
//               ),
//               10.heightBox,
//               Padding(
//                 padding:  EdgeInsets.symmetric(horizontal: 10.w),
//                 child: Divider(height: 3.h,color: AppPalette.black,),
//               ),
//               5.heightBox,
//               placePrediction!.isNotEmpty ?
//               ListView.builder(
//                 shrinkWrap: true,
//                   itemCount: placePrediction!.length,
//                   itemBuilder: (context, index){
//                   return GestureDetector(
//                     onTap: () async{
//                       // ChIJ2V-Mo_l1nkcRfZixfUq4DAE
//                       print('placePrediction is ${placePrediction![index].reference}');
//                       print('lat is');
//                       final plist = GoogleMapsPlaces(
//                         apiKey: googleApikey,
//                         apiHeaders: await const GoogleApiHeaders().getHeaders(),
//                         //from google_api_headers package
//                       );
//                       String placeid = placePrediction![index].reference ?? "0";
//                       final detail = await plist.getDetailsByPlaceId(placeid);
//                       final geometry = detail.result.geometry!;
//                       final lat = geometry.location.lat;
//                       final lang = geometry.location.lng;
//                       print('lat is $lat');
//                       print('lat is $lang');
//
//                       getMyLocationFromPlaces(lat,lang);
//
//                     //  Navigator.pushNamed(context, AppRoutesName.home);
//                     },
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Row(
//                         children:  [
//                          const Icon(Icons.location_on,size: 25,color: AppPalette.primary),
//                           5.widthBox,
//                           Expanded(
//                             flex: 3,
//                             child: AppText(
//                               text: '${placePrediction![index].description}',
//                               maxLines: 2,
//                               textOverflow: TextOverflow.ellipsis,
//                               textStyle: TextStyle(color: Colors.black, fontSize: 16.h),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                   },) :
//               Padding(
//                 padding: const EdgeInsets.all(5.0),
//                 child: Row(
//                   children:  [
//                   //  const Icon(Icons.location_on,size: 25,color: AppColors.greenLight),
//                     5.widthBox,
//                     AppText(
//                       text: '',
//                       maxLines: 2,
//                       textOverflow: TextOverflow.ellipsis,
//                       textStyle: TextStyle(color: Colors.black, fontSize: 16.h),
//                       textAlign: TextAlign.center,
//                     ),
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//
// }
