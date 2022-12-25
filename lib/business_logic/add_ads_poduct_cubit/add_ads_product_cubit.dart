
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/data/webservices/api_services/add_ads_product_service.dart';

import '../../translations/locale_keys.g.dart';

part 'add_ads_product_state.dart';

class AddAdsProductCubit extends Cubit<AddAdsProductState> {
  AddAdsProductCubit() : super(AddAdsProductInitial());

  static AddAdsProductCubit get(BuildContext context) => BlocProvider.of(context);

  addAdsProductUser(BuildContext context,String link, File image){
    emit(AddAdsProductLoading());
    AddAdsProductService.addAdsProductUser(context, link, image).then((value){
      if(value?.type == 'success'){
        emit(AddAdsProductSuccessfully(value?.message));
      }else {
        emit(AddAdsProductSuccessfully(value?.message));
      }
    }).catchError((onError){
      emit(AddAdsProductSuccessfully(onError));
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
}
