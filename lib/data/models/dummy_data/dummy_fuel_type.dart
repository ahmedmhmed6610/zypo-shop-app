import 'package:easy_localization/easy_localization.dart';
import 'package:shop/data/color_model.dart';
import 'package:shop/translations/locale_keys.g.dart';

List<ColorModel> dummyFuelType = [
  ColorModel(id: 1, color: LocaleKeys.benzine.tr()),
  ColorModel(id: 2, color: LocaleKeys.diesel.tr()),
  ColorModel(id: 3, color: LocaleKeys.electricity.tr()),
  ColorModel(id: 4, color: LocaleKeys.hypride.tr()),
  ColorModel(id: 5, color: LocaleKeys.naturalGas.tr()),
];
