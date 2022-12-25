import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/data/models/area_model.dart';
import 'package:shop/data/models/government_model.dart';
import 'package:shop/data/webservices/api_services/location_service.dart';

import '../../data/models/cities_model.dart';

part 'locations_state.dart';

class LocationsCubit extends Cubit<LocationsState> {
  LocationsCubit() : super(LocationsInitial()){
  //  getGovernment();
  }
  static LocationsCubit get(BuildContext context) => BlocProvider.of(context);

  GovernmentModel? governmentModel;
  CitiesModel? citiesModel;
  AreaModel? areaModel;

  getGovernment (){
    print('Dio error....');
    print('loading....');
    emit(GovernmentLoadingState());
    LocationService.getGovernment().then((value){
      governmentModel = value;
     print('list is length ${value?.message!.length}');
     print('list is government ${value?.message![0].name}');
      emit(GovernmentSuccessState(value));
    }).catchError((onError){
    //  print('error ${onError.toString()}');
      emit(GovernmentErrorState(onError.toString()));
    });
  }

  getCityOfGovernment(String governmentId){
    emit(CityLoadingState());
    LocationService.getCityOfGovernment(governmentId).then((value){
      citiesModel = value;
      // print(value?.data!.cities!.length);
      // print(value?.data!.cities![0].name);
      // print(value?.data!.name);
      emit(CitySuccessState(value));
    }).catchError((onError){
      emit(CityErrorState(onError.toString()));
    });
  }

  getAreaOfCity(String cityId){
    emit(AreaLoadingState());
    LocationService.getAreaOfCities(cityId).then((value){
      areaModel = value;
      // print(' list length area ${value?.data!.areas!.length}');
      // print('list of name area  ${value?.data!.areas![0].name}');
      emit(AreaSuccessState(value));
    }).catchError((onError){
      emit(AreaErrorState(onError.toString()));
    });
  }


}





