import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/business_logic/filter_cubit/filter_cubit.dart';
import 'package:shop/business_logic/my_products_cubit/my_products_cubit.dart';
import 'package:shop/translations/locale_keys.g.dart';
import 'package:shop/ui/widgets/My_products_widgets/add_product_widgets/condition_widget.dart';
import 'package:shop/utils/app_palette.dart';
import 'package:shop/utils/app_size_boxes.dart';
import 'package:shop/utils/dimensions.dart';
import 'package:shop/utils/styles.dart';

class FilterConditionWidget extends StatelessWidget {
  FilterConditionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterCubit, FilterState>(
      builder: (context, state) {
        FilterCubit filterCubit = FilterCubit.get(context);
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.paddingSizeExtraExtraSmall),
              child: Text(
                LocaleKeys.condition.tr(),
                style: AppTextStyles.poppinsLight
                    .copyWith(color: AppPalette.black),
              ),
            ),
            5.heightBox,
            Row(
              children: [
                ConditionWidget(
                  title: LocaleKeys.newProd.tr(),
                  color: filterCubit.condition == Condition.newProduct
                      ? AppPalette.primary
                      : AppPalette.lightPrimary,
                  onTap: filterCubit.changeCondition,
                  textColor: filterCubit.condition == Condition.newProduct
                      ? AppPalette.white
                      : AppPalette.black,
                ),
                8.widthBox,
                ConditionWidget(
                  title: LocaleKeys.used.tr(),
                  color: filterCubit.condition == Condition.used
                      ? AppPalette.primary
                      : AppPalette.lightPrimary,
                  onTap: filterCubit.changeCondition,
                  textColor: filterCubit.condition == Condition.used
                      ? AppPalette.white
                      : AppPalette.black,
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
