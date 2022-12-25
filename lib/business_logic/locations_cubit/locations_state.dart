// ignore_for_file: must_be_immutable

part of 'locations_cubit.dart';

@immutable
abstract class LocationsState {}

class LocationsInitial extends LocationsState {}

class GovernmentLoadingState extends LocationsState {}

class GovernmentSuccessState extends LocationsState{
  GovernmentModel? governmentModel;
  GovernmentSuccessState(this.governmentModel);
}

class GovernmentErrorState extends LocationsState {
  String? error;
  GovernmentErrorState(this.error);
}

// city state
class CityLoadingState extends LocationsState {}

class CitySuccessState extends LocationsState{
  CitiesModel? citiesModel;
  CitySuccessState(this.citiesModel);
}

class CityErrorState extends LocationsState {
  String? error;
  CityErrorState(this.error);
}


// area state
class AreaLoadingState extends LocationsState {}

class AreaSuccessState extends LocationsState{
  AreaModel? areaModel;
  AreaSuccessState(this.areaModel);
}

class AreaErrorState extends LocationsState {
  String? error;
  AreaErrorState(this.error);
}

