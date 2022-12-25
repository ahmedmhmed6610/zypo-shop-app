import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:shop/business_logic/my_products_cubit/my_products_cubit.dart';
import 'package:shop/business_logic/my_products_cubit/my_products_state.dart';
import 'package:shop/data/internet_connectivity/error_screens_connection.dart';
import 'package:shop/data/models/response_user_model.dart';
import 'package:shop/translations/locale_keys.g.dart';
import 'package:shop/ui/screens/layout/app_layout.dart';
import 'package:shop/ui/widgets/My_products_widgets/my_product_item.dart';
import 'package:shop/utils/LoadingWidget.dart';
import 'package:http/http.dart' as http;
import '../../../data/models/MyProductUserModel.dart';
import '../../../data/models/product_model.dart';
import '../../../data/webservices/api_constants.dart';
import '../../../helpers/app_local_storage.dart';
import '../../../helpers/logger_helper.dart';
import '../../../libraries/dialog_widget.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/app_palette.dart';
import '../../../utils/dimensions.dart';

class MyProductsGridWidget extends StatefulWidget {
  const MyProductsGridWidget({Key? key}) : super(key: key);

  @override
  State<MyProductsGridWidget> createState() => _MyProductsGridWidgetState();
}

class _MyProductsGridWidgetState extends State<MyProductsGridWidget> {

  ScrollController scrollController = ScrollController();

  handelNextList(int pageNumberPagination,AddProductCubit addProductCubit) {
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.position.pixels) {
        addProductCubit.getMyProductUser(refresh: true);
      }
    });
  }

  String? lottie;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // AddProductCubit addProductController = AddProductCubit.get(context);
    // handelNextList(addProductController.myProductUserResponseModel!.meta!.lastPage!, addProductController);
    // loadDataProduct();
    BlocProvider.of<AddProductCubit>(context, listen: false)
        .getMyProductUser(refresh: true);
    // print('token is ${AppLocalStorage.token}');
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddProductCubit, AddProductState>(
      builder: (context, state) {
        AddProductCubit addProductCubit = AddProductCubit.get(context);
        //  print("list is ${addProductCubit.myProductUserResponseModel!.data!.length}");
        if(state is GetProductsErrorState){
          ErrorScreenConnection(onPressed: ()=>
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => AppLayout())),);
        }else if(state is GetMyProductsSuccessState){
          print("getMyProducts is list ${state.myProductUserResponseModel!.length}");

          if(state.myProductUserResponseModel == null){
            ErrorScreenConnection(onPressed: ()=>
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => AppLayout())),);
          }else {
            if (state.myProductUserResponseModel!.isEmpty) {
              return Padding(
                padding:  EdgeInsets.symmetric(horizontal: 10.r),
                child: Center(
                    child: SvgPicture.asset("assets/images/svg/addProduct.svg",
                        fit: BoxFit.contain),
                ),
              );
            } else {
              return Padding(
                padding:  EdgeInsets.symmetric(horizontal: 7.r),
                child: AlignedGridView.count(
                  physics:
                  const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  crossAxisSpacing: 0,
                  mainAxisSpacing: 0,
                  itemCount:state.myProductUserResponseModel!.length,
                    itemBuilder: (context, index) {
                      print('addProductCubit.myProductUserResponseModel');
                      print(state.myProductUserResponseModel!.length);
                      return MyProductGridItem(
                        product: state.myProductUserResponseModel!.elementAt(index),
                        onDelete: () async {
                          final ProductModel product = state.myProductUserResponseModel!.elementAt(index);
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
                                      title: LocaleKeys.areYouSureYouWantToDeleteThisProduct.tr(),
                                      msg: state.myProductUserResponseModel![index].name,
                                      titleStyle: const TextStyle(
                                        color: Colors.blueGrey,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      actions: [
                                        Padding(
                                          padding:
                                          EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
                                          child: IconsButton(
                                            onPressed: () async {
                                              addProductCubit.deleteProductItem(context,productId: product.id.toString(),isSold: '0');

                                            },
                                            text: LocaleKeys.delete.tr(),
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
                                          EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
                                          child: IconsButton(
                                            onPressed: () {
                                              addProductCubit.deleteProductItem(context,productId: product.id.toString(),isSold: '1');

                                            },
                                            text: LocaleKeys.productSold.tr(),
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
                      );
                    }),
              );

            }
          }

        }
        return const Center(child: CircularProgressIndicator(color: AppPalette.primary));
      },
    );
  }

  loadDataProduct() {
    BlocProvider.of<AddProductCubit>(context, listen: false)
        .getMyProductUser();
  }



  Future<ResponseModel> deleteProduct(productId, isSold) async {
    LoggerHelper.loggerNoStack.i('Api Call : ${AppConstants.baseUrl}${ApiConstants.addProductUrl}/$productId');
    final response = await http.delete(
      Uri.parse('${AppConstants.baseUrl}${ApiConstants.addProductUrl}/$productId'),
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        'Authorization': AppLocalStorage.token!,
      },
      encoding: Encoding.getByName('utf-8'),
      body: {"is_sold": isSold},

    );

    if (response.statusCode == 200) {
      var responseBody = json.decode(response.body);

      return ResponseModel.fromJson(responseBody);
    } else {
      throw Exception("Can't load data${response.statusCode}");
    }

  }

}
