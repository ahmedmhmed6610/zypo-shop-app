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

class AddNewProductWidgetFavorite extends StatelessWidget {
  AddNewProductWidgetFavorite({Key? key,required this.title,required this.onTap,
    required this.colorBackground,required this.colorText}) : super(key: key);

  String? lottie;
  String? title;
  Color? colorBackground;
  Color? colorText;
  void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return AddButtonWidget2(
      onTap: onTap,
      colorBackground: colorBackground,
      child: Center(
        child: Text(
          title!,
          style: AppTextStyles.poppinsRegular.copyWith(
            color: colorText,
            fontFamily: Fonts.poppins,
            fontWeight: FontWeight.w400,
            fontSize: Dimensions.fontSizeDefault,
          ),
        ),
      ),
    );
  }
}
