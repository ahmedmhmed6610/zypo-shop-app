import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/business_logic/filter_cubit/filter_cubit.dart';
import 'package:shop/translations/locale_keys.g.dart';
import 'package:shop/ui/widgets/My_products_widgets/add_product_widgets/input_text_form_field.dart';
import 'package:shop/utils/app_palette.dart';
import 'package:shop/utils/app_size_boxes.dart';
import 'package:shop/utils/dimensions.dart';

class YearWidget extends StatelessWidget {
  YearWidget({Key? key,required this.fromYearController,required this.toYearController}) : super(key: key);

  TextEditingController fromYearController = TextEditingController();
  TextEditingController toYearController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterCubit, FilterState>(
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.paddingSizeExtraExtraSmall),
              child: Text(
                LocaleKeys.year.tr(),
                style: const TextStyle(color: AppPalette.black,fontWeight: FontWeight.normal,fontSize: 15),
              ),
            ),
            10.heightBox,
            Row(
              children: [
                Expanded(
                  child: InputTextFormField(
                    hintText: LocaleKeys.from.tr(),
                    textInputType: TextInputType.number,
                    textEditingController: fromYearController,
                    validator: (val) {},
                  ),
                ),
                10.widthBox,
                Expanded(
                  child: InputTextFormField(
                    hintText: LocaleKeys.to.tr(),
                    textInputType: TextInputType.number,
                    textEditingController: toYearController,
                    validator: (val) {},
                  ),
                )
              ],
            ),
          ],
        );
      },
    );
  }
}
