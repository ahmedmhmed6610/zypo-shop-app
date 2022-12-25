import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shop/business_logic/filter_cubit/filter_cubit.dart';
import 'package:shop/translations/locale_keys.g.dart';
import 'package:shop/ui/widgets/My_products_widgets/add_product_widgets/input_text_form_field.dart';
import 'package:shop/utils/app_palette.dart';
import 'package:shop/utils/app_size_boxes.dart';
import 'package:shop/utils/dimensions.dart';

class PriceWidget extends StatelessWidget {
  PriceWidget({Key? key,required this.fromPriceController,required this.toPriceController}) : super(key: key);

  TextEditingController fromPriceController = TextEditingController();
  TextEditingController toPriceController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterCubit, FilterState>(
      builder: (context, state) {
        return  Row(
          children: [
            Expanded(
              child: InputTextFormField(
                hintText: LocaleKeys.fromPrice.tr(),
                textEditingController: fromPriceController,
                textInputType: TextInputType.number,
                onChanged: (String? value){

                },
                suffixIcon: Container(
                    padding: EdgeInsets.all(
                      Dimensions.paddingSize,
                    ),
                    child: SvgPicture.asset(
                      "assets/images/svg/doller.svg",
                      color: AppPalette.black,
                    )),
                validator: (val) {
                  if (val.isEmpty) {
                    return "enter price";
                  }
                },
              ),
            ),
            15.widthBox,
            Expanded(
              child: InputTextFormField(
                hintText: LocaleKeys.toPrice.tr(),
                textEditingController: toPriceController,
                textInputType: TextInputType.number,
                suffixIcon: Container(
                    padding: EdgeInsets.all(
                      Dimensions.paddingSize,
                    ),
                    child: SvgPicture.asset(
                      "assets/images/svg/doller.svg",
                      color: AppPalette.black,
                    )),
                validator: (val) {
                  if (val.isEmpty) {
                    return "enter price";
                  }
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
