import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:shop/helpers/components.dart';
import 'package:shop/translations/locale_keys.g.dart';
import 'package:shop/ui/screens/add_products_screen/add_product_screen.dart';
import 'package:shop/ui/widgets/My_products_widgets/add_button_widget.dart';
import 'package:shop/utils/app_palette.dart';
import 'package:shop/utils/app_size_boxes.dart';
import 'package:shop/utils/styles.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../helpers/app_local_storage.dart';
import '../../../libraries/dialog_widget.dart';
import '../../../utils/dimensions.dart';
import '../../screens/auth/login_screen.dart';
import 'add_button_widget2.dart';

class AddNewProductWidget extends StatelessWidget {
  AddNewProductWidget({Key? key,required this.colorBackground,required this.colorText}) : super(key: key);

  String? lottie;
  Color? colorBackground;
  Color? colorText;
  @override
  Widget build(BuildContext context) {
    return AddButtonWidget2(
      onTap: () {
        print('click button');
        if (AppLocalStorage.token == null){
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
                      title: LocaleKeys.youHaveToLoginFirst.tr(),
                      msg: LocaleKeys.loginAndSellBuy.tr(),
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
                              // addProductCubit.deleteProductItem(context,productId: product.id.toString(),isSold: '0');
                              Navigator.pop(context);
                            },
                            text: LocaleKeys.cancel.tr(),
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
                              //  addProductCubit.deleteProductItem(context,productId: product.id.toString(),isSold: '1');
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const LoginScreen()));
                            },
                            text: LocaleKeys.login.tr(),
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
        }else {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => AddProductScreen(),
          ));
        }
      },
      colorBackground: colorBackground,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add_circle_outline_rounded,color: AppPalette.primary,size: 22.sp,),
            5.widthBox,
            Text(
              LocaleKeys.addNewProduct.tr(),
              style: AppTextStyles.poppinsRegular.copyWith(
                color: colorText,
                fontFamily: Fonts.poppins,
                fontWeight: FontWeight.w400,
                fontSize: Dimensions.fontSizeLarge,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
