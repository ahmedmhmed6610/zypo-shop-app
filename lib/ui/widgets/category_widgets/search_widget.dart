import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop/business_logic/categories_cubit/categories_cubit.dart';
import 'package:shop/business_logic/filter_cubit/filter_cubit.dart';
import 'package:shop/utils/app_palette.dart';
import 'package:shop/utils/app_size_boxes.dart';
import 'package:shop/utils/dimensions.dart';

import '../../../data/models/category_model.dart';
import '../../../data/models/product_model.dart';
import '../../screens/filter_screens/choose_categories_screens/sub_category_screen.dart';

class SearchWidget extends StatefulWidget {
   CategoryModel? category;
   List<ProductModel> products = [];
   SearchWidget({Key? key,required this.category,required this.products}) : super(key: key);

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: BlocBuilder<CategoriesCubit, CategoriesState>(
        builder: (context, state){
          CategoriesCubit categoriesCubit = CategoriesCubit.get(context);
          return  BlocBuilder<FilterCubit,FilterState>(
            builder: (context,state){
              FilterCubit filterCubit = FilterCubit.get(context);
              return  Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      textAlignVertical: TextAlignVertical.center,
                      onChanged: (text){
                        text = text.toLowerCase();
                        setState(() {
                          widget.products.where((element){
                            var productTitle = element.name!.toLowerCase();
                            return productTitle.contains(text);
                          });
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Search for product . . .',
                        filled: true,
                        fillColor: AppPalette.lightPrimary,
                        prefixIcon: Container(
                            padding: EdgeInsets.all(
                              Dimensions.paddingSize,
                            ),
                            child: SvgPicture.asset("assets/images/svg/search.svg")),
                        contentPadding: EdgeInsets.zero,
                        border: UnderlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        disabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                  7.widthBox,
                  GestureDetector(
                    onTap: (){
                      // CustomFlutterToast(category!.id);
                      // CustomFlutterToast(category!.name);

                      filterCubit.selectMainCategory(
                          category: widget.category!);
                      categoriesCubit.setSelectedParent(
                          widget.category!.id!);
                      filterCubit.selectedColorsModel = [];
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => SubCategoryScreen(
                              category: widget.category!)));

                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: AppPalette.primary),
                      padding: EdgeInsets.symmetric(
                        vertical: Dimensions.paddingSize,
                        horizontal: Dimensions.paddingSizeDefault,
                      ),
                      child:
                      SvgPicture.asset("assets/images/svg/filter.svg",color: AppPalette.white,),
                    ),
                  ),
                ],
              );
            },
          );
        }
      ),
    );
  }
}
