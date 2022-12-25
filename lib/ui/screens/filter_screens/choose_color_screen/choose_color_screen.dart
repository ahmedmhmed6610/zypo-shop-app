import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop/business_logic/filter_cubit/filter_cubit.dart';
import 'package:shop/translations/locale_keys.g.dart';
import 'package:shop/ui/base/custom_button.dart';
import 'package:shop/ui/screens/filter_screens/filter_screen.dart';
import 'package:shop/ui/widgets/filter_widgets/choose_color_screen/choose_color_search_widget.dart';
import 'package:shop/utils/app_palette.dart';
import 'package:shop/utils/app_size_boxes.dart';
import 'package:shop/utils/dimensions.dart';
import 'package:shop/utils/styles.dart';

import '../../../widgets/My_products_widgets/add_product_widgets/custom_button_widget.dart';

class ChooseColorScreen extends StatefulWidget {
  ChooseColorScreen(
      {Key? key, this.governmentId, this.governmentName, this.cityId, this.cityName,
        this.areaId, this.areaName, this.locationUser, this.fromPrice, this.toPrice,
        this.fromArea,this.toArea,this.bedroom,this.bathroom,
        this.fromkiloMetresType,this.tokiloMetresType,this.fromDownPayment,this.toDownPayment,
        this.fuelType, this.bodyType, this.amenitiesType, this.colorType, this.engineCapacityType, this.kiloMetresType,
        this.levelType,this.fromYear,this.toYear}) : super(key: key);

  String? governmentId, governmentName;
  String? cityId, cityName;
  String? areaId, areaName;
  String? locationUser;
  String? brandId,fromDownPayment,toDownPayment;
  String? status,fromYear,toYear,bedroom,bathroom;
  String? fromPrice, toPrice,fromArea,toArea;
  String? kiloMetresType,fuelType, amenitiesType, bodyType, colorType, engineCapacityType,
      fromkiloMetresType,tokiloMetresType, levelType;

  @override
  State<ChooseColorScreen> createState() => _ChooseColorScreenState();
}

class _ChooseColorScreenState extends State<ChooseColorScreen> {

 // static List<ColorModel> colorsList = [
 //    ColorModel(id: 1, color: LocaleKeys.all.tr()),
 //    ColorModel(id: 2, color: LocaleKeys.green.tr()),
 //    ColorModel(id: 3, color: LocaleKeys.brown.tr()),
 //    ColorModel(id: 4, color: LocaleKeys.blue.tr()),
 //    ColorModel(id: 5, color: LocaleKeys.yellow.tr()),
 //    ColorModel(id: 6, color: LocaleKeys.white.tr()),
 //    ColorModel(id: 7, color: LocaleKeys.cohly.tr()),
 //    ColorModel(id: 8, color: LocaleKeys.nebety.tr()),
 //    ColorModel(id: 9, color: LocaleKeys.gary.tr()),
 //  ];

 //  final _items = colorsList
 //      .map((colorList) => MultiSelectItem<ColorModel?>(colorList, colorList!.color))
 //      .toList();
 //  List<ColorModel?> colorModelItemAdd = [];
 //  List<ColorModel?> colorModelItemRemove = [];
 // final _multiSelectKey = GlobalKey<FormFieldState>();
 // String Preligion = "";

  Map<String, bool>? colorsList = {
    LocaleKeys.green.tr(): false,
    LocaleKeys.brown.tr(): false,
    LocaleKeys.blue.tr(): false,
    LocaleKeys.yellow.tr(): false,
    LocaleKeys.white.tr(): false,
    LocaleKeys.cohly.tr(): false,
    LocaleKeys.nebety.tr(): false,
    LocaleKeys.gary.tr(): false,
  };

 var tmpArray = [];

  getCheckboxItems(){

    colorsList!.forEach((key, value) {
      if(value == true)
      {
        tmpArray.add(key);
      }
    });

    // Printing all selected items on Terminal screen.
    widget.colorType = tmpArray.join(',');
    // print('tmpArray');
    // print(tmpArray);
    // print(widget.colorType);



    // Here you will get all your selected Checkbox items.

    // Clear array after use.
    tmpArray.clear();
  }

 @override
 void initState() {
   super.initState();

   // Printing all selected items on Terminal screen.
   // print('tmpArray');
   // print(tmpArray);
   // Here you will get all your selected Checkbox items.

   // Clear array after use.
   tmpArray.clear();

 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.filter.tr()),
        elevation: 0.0,
        leading: InkWell(
          onTap: () =>  Navigator.push(context, MaterialPageRoute
            (builder: (context) => FilterScreen(
              governmentId: widget
                  .governmentId,
              governmentName: widget
                  .governmentName,
              fromPrice: widget.fromPrice,
              toPrice: widget.toPrice,
              cityId: widget.cityId,
              fromYear: widget.fromYear,
              toYear: widget.toYear,
              bathroom: widget.bathroom,
              bedroom: widget.bedroom,
              fromArea: widget.fromArea,
              locationUser: widget.locationUser,
              toArea: widget.toArea,
              fromDownPayment: widget.fromDownPayment,
              toDownPayment: widget.toDownPayment,
              fromkiloMetresType: widget.fromkiloMetresType,
              tokiloMetresType: widget.tokiloMetresType,
              cityName: widget.cityName,
              areaId: widget.areaId,
              amenitiesType: widget.amenitiesType,
              bodyType: widget.bodyType,
              colorType: widget.colorType,
              engineCapacityType: widget.engineCapacityType,
              fuelType: widget.fuelType,
              kiloMetresType: widget.kiloMetresType,
              levelType: widget.levelType,
              areaName: widget.areaName))),
          child: const Icon(Icons.arrow_back_ios,
              size: 20.0, color: AppPalette.black),
        ),
      ),
      body: BlocBuilder<FilterCubit, FilterState>(
        builder: (context, state) {
          return Container(
            padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  LocaleKeys.chooseColor.tr(),
                  style: AppTextStyles.poppinsMedium
                      .copyWith(color: AppPalette.black),
                ),
                10.heightBox,
                ChooseColorSearchWidget(),
                5.heightBox,
                CustomButtonWidget(
                    title: 'Get Selected Checkbox Items',
                    onTap: () => getCheckboxItems()),
                5.heightBox,
                Expanded(
                  child :
                  ListView(
                    children: colorsList!.keys.map((String key) {
                      return  CheckboxListTile(
                        title: Text(key),
                        value: colorsList![key],
                        activeColor: Colors.pink,
                        checkColor: Colors.white,
                        onChanged: (bool? value) {
                          setState(() {
                            colorsList![key] = value!;
                          });
                        },
                      );
                    }).toList(),
                  ),
                ),
                // Expanded(
                //   child:  MultiSelectDialogField(
                //     items: _items,
                //     onSaved: (color){
                //       color = colorModelItem;
                //     },
                //     initialValue: _items,
                //     searchIcon: Icon(Icons.search),
                //     searchHint: 'search color',
                //     searchable: true,
                //     title: Text(LocaleKeys.color.tr()),
                //     selectedColor: Colors.blue,
                //     decoration: BoxDecoration(
                //       color: Colors.blue.withOpacity(0.1),
                //       borderRadius: BorderRadius.all(Radius.circular(40)),
                //       border: Border.all(
                //         color: Colors.blue,
                //         width: 2,
                //       ),
                //     ),
                //     buttonIcon: Icon(
                //       Icons.pets,
                //       color: Colors.blue,
                //     ),
                //     buttonText: Text(
                //       LocaleKeys.color.tr(),
                //       style: TextStyle(
                //         color: Colors.blue[800],
                //         fontSize: 16,
                //       ),
                //     ),
                //     onConfirm: (colorModel) {
                //       colorModel = colorsList;
                //       print('color selected');
                //       print(colorModelItem);
                //     },
                //   ),
                // ),
                // Container(
                //   child: Column(
                //     children: <Widget>[
                //       MultiSelectBottomSheetField<ColorModel?>(
                //         initialChildSize: 0.7,
                //         maxChildSize: 0.95,
                //         listType: MultiSelectListType.CHIP,
                //         checkColor: Colors.pink,
                //         selectedColor: Colors.pink,
                //         selectedItemsTextStyle: const TextStyle(
                //           fontSize: 25,
                //           color: Colors.white,
                //         ),
                //         unselectedColor: Colors.greenAccent[200],
                //         buttonIcon: const Icon(
                //           Icons.add,
                //           color: Colors.pinkAccent,
                //         ),
                //         searchHintStyle: const TextStyle(
                //           fontSize: 20,
                //         ),
                //         searchable: true,
                //         buttonText: Text(
                //           '$Preligion', //"????",
                //           style: const TextStyle(
                //             fontSize: 18,
                //             color: Colors.grey,
                //           ),
                //           overflow: TextOverflow.ellipsis,
                //           maxLines: 5,
                //         ),
                //         title: const Text(
                //           "Religions",
                //           style: TextStyle(
                //             fontSize: 25,
                //             color: Colors.pink,
                //           ),
                //         ),
                //         items: _items,
                //         onConfirm: (values) {
                //           setState(() {
                //             colorModelItemAdd = values;
                //           });
                //           print('selected : ${colorModelItemAdd}');
                //
                //
                //           for (var item in colorModelItemAdd) {
                //             print("${item!.id} ${item.color}");
                //             Preligion = "$Preligion ${item.color}";
                //             print('Preligion');
                //             print(Preligion);
                //           }
                //
                //           /*senduserdata(
                //     'partnerreligion', '${_selectedItems2.toString()}');*/
                //         },
                //         chipDisplay: MultiSelectChipDisplay(
                //           textStyle: const TextStyle(
                //             fontSize: 18,
                //             color: Colors.black,
                //           ),
                //           onTap: (value) {
                //             setState(() {
                //               colorModelItemAdd.remove(value);
                //             });
                //
                //             print('removed: ${colorModelItemAdd.toString()}');
                //           },
                //         ),
                //       ),
                //       colorModelItemAdd.isEmpty
                //           ? MultiSelectChipDisplay(
                //         onTap: (item) {
                //           setState(() {
                //             colorModelItemRemove.remove(item);
                //             print('removed below: ${colorModelItemRemove.toString()} $item');
                //           });
                //           _multiSelectKey.currentState!.validate();
                //         },
                //       )
                //           : MultiSelectChipDisplay(),
                //     ],
                //   ),
                // ),
                5.heightBox,
                CustomButton(
                  buttonText: LocaleKeys.apply.tr(),
                  onPressed: () {
                    getCheckboxItems();
                    Navigator.push(context, MaterialPageRoute
                      (builder: (context) => FilterScreen(
                        governmentId: widget
                            .governmentId,
                        governmentName: widget
                            .governmentName,
                        fromPrice: widget.fromPrice,
                        toPrice: widget.toPrice,
                        cityId: widget.cityId,
                        fromYear: widget.fromYear,
                        toYear: widget.toYear,
                        bathroom: widget.bathroom,
                        bedroom: widget.bedroom,
                        fromArea: widget.fromArea,
                        toArea: widget.toArea,
                        locationUser: widget.locationUser,
                        fromDownPayment: widget.fromDownPayment,
                        toDownPayment: widget.toDownPayment,
                        fromkiloMetresType: widget.fromkiloMetresType,
                        tokiloMetresType: widget.tokiloMetresType,
                        cityName: widget.cityName,
                        areaId: widget.areaId,
                        amenitiesType: widget.amenitiesType,
                        bodyType: widget.bodyType,
                        colorType: widget.colorType,
                        engineCapacityType: widget.engineCapacityType,
                        fuelType: widget.fuelType,
                        kiloMetresType: widget.kiloMetresType,
                        levelType: widget.levelType,
                        areaName: widget.areaName)));
                  },
                  height: 48.h,
                  fontSize: Dimensions.fontSizeLarge,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
