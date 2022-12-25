import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop/business_logic/categories_cubit/categories_cubit.dart';
import 'package:shop/data/internet_connectivity/error_screens_connection.dart';
import 'package:shop/ui/screens/categories_screens/category_screen.dart';
import 'package:shop/ui/screens/layout/app_layout.dart';
import 'package:shop/ui/widgets/home_widgets/category_list_item_widget.dart';

import '../../../utils/app_palette.dart';

class BuildCategoriesList extends StatefulWidget {
  BuildCategoriesList({Key? key}) : super(key: key);

  @override
  State<BuildCategoriesList> createState() => _BuildCategoriesListState();
}

class _BuildCategoriesListState extends State<BuildCategoriesList> {

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<CategoriesCubit, CategoriesState>(
      builder: (context, state) {
        CategoriesCubit cubit = CategoriesCubit.get(context);
        return cubit.parentLoading
            ? const Center(
          child: CircularProgressIndicator(
              color: AppPalette.primary),) :
        cubit.categories == null ?
            ErrorScreenConnection(
              onPressed: ()=> Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => AppLayout())),
            )
            : cubit.categories.isEmpty
                ? Container()
                : SizedBox(
                    height: 93.h,
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => CategoryListItemWidget(
                        categoryListItemModel: cubit.categories[index],
                        onTap: () {
                          cubit.setSelectedParent(cubit.categories[index].id!);

                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => CategoryScreen(
                                category: cubit.categories[index]),
                          ));
                        },
                      ),
                      itemCount: cubit.categories.length,
                    ),
                  );
      },
    );
  }
}
