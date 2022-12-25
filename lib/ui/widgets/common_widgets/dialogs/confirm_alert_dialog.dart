import 'package:flutter/material.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:shop/libraries/dialog_widget.dart';
import 'package:shop/utils/app_palette.dart';
import 'package:shop/utils/dimensions.dart';

import '../../../../business_logic/my_products_cubit/my_products_cubit.dart';
import '../../../../data/models/product_model.dart';

class ConfirmAlertDialog extends StatelessWidget {
  String? title;
  String? msg;
  String? lottie;
  String? confirmationButton;
  String? cancelButton;
  ProductModel? productModel;
  AddProductCubit? addProductCubit;

  ConfirmAlertDialog(
      {Key? key,
       this.addProductCubit,
       this.productModel,
      required this.title,
      this.msg,
      this.lottie,
      required this.confirmationButton,
      required this.cancelButton})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimensions.radiusDefault)),
      alignment: Alignment.bottomCenter,
      insetPadding: EdgeInsets.symmetric(
          vertical: Dimensions.paddingSize, horizontal: Dimensions.paddingSize),
      child: CustomDialogWidget(
        msgStyle: const TextStyle(height: 2),
        title: title,
        msg: msg,
        titleStyle: const TextStyle(
          color: Colors.blueGrey,
          overflow: TextOverflow.ellipsis,
        ),
        actions: [
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
            child: IconsButton(
              onPressed: () => Navigator.of(context).pop(false),
              text: cancelButton!,
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
               // addProductCubit!.deleteProduct(productModel!, '1');
              },
              text: confirmationButton!,
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
    );
  }
}
