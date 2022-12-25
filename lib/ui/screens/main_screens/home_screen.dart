import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shop/business_logic/app_ui_cubit/app_ui_cubit.dart';
import 'package:shop/business_logic/home_cubit/home_cubit.dart';
import 'package:shop/data/internet_connectivity/error_screens_connection.dart';
import 'package:shop/translations/locale_keys.g.dart';
import 'package:shop/ui/screens/layout/app_layout.dart';
import 'package:shop/ui/widgets/home_widgets/build_categories_list.dart';
import 'package:shop/ui/widgets/products_grid_widget.dart';
import 'package:shop/ui/widgets/products_list_wiget.dart';
import 'package:shop/utils/app_palette.dart';
import '../../../business_logic/categories_cubit/categories_cubit.dart';
import '../../../business_logic/my_products_cubit/my_products_cubit.dart';
import '../../../business_logic/profile_cubit/profile_cubit.dart';
import '../../../data/models/product_model.dart';
import '../../../helpers/app_local_storage.dart';
import '../../widgets/app_pull_to_refresh.dart';
import '../../widgets/home_widgets/custom_carousel_slider.dart';
import 'package:shop/utils/dimensions.dart';
import '../../../utils/app_size_boxes.dart';
import '../../widgets/common_widgets/appbar_search_row.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {



  // Timer? timer;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // CheckUserConnection();
    //  timer = Timer.periodic(Duration(seconds: 3), (Timer t) => CheckUserConnection());
    // print("language is ${context.locale}");
    setState(() {
      loadData();
      loadDataBanners();
      loadDataProduct();
      loadDataProduct2();
      AppLocalStorage.token != null ?
      loadDataProfile() : null ;
    });
    // translationText();
  }

  loadData() {
    BlocProvider.of<CategoriesCubit>(context, listen: false)
        .getParentCategories();

  }

  loadDataBanners() {
    BlocProvider.of<HomeCubit>(context, listen: false)
        .getSliderHome();

  }

  loadDataProduct() {
    BlocProvider.of<HomeCubit>(context, listen: false).getRecommendationProducts();

  }
  loadDataProfile() {
    BlocProvider.of<ProfileCubit>(context, listen: false)
        .getUserProfile();
  }

  loadDataProduct2() {
    BlocProvider.of<AddProductCubit>(context, listen: false).getMyProductUser();
    // getCurrentLocation();
  }

  ScrollController scrollController = ScrollController();

  handelNextList(int pageNumberPagination,HomeCubit homeCubit) {
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.position.pixels) {
        homeCubit.getRecommendationProducts(refresh: true);
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding:  const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  HomeCubit homeCubit = HomeCubit.get(context);
                  return RefreshIndicator(
                    onRefresh: ()async {
                    //  homeCubit.getRecommendationProducts(refresh: true);
                      loadData();
                      loadDataProduct();
                      loadDataBanners();
                      loadDataProduct2();
                      AppLocalStorage.token != null ?
                      loadDataProfile() : null ;
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        25.heightBox,
                        AppBarSearchRow(productModel: homeCubit.recommendationProducts.products),
                        15.heightBox,
                        state is SliderLoadingState ?
                        const Center(
                          child: CircularProgressIndicator(
                              color: AppPalette.primary),
                        ) :
                        CustomCarouselSlider(
                          sliderResponseModel: homeCubit.sliderResponseModel,
                        ),
                        25.heightBox,
                        // Padding(
                        //   padding: const EdgeInsets.symmetric(
                        //    // horizontal: Dimensions.paddingSizeDefault,
                        //   ),
                        //   child: Text(
                        //     LocaleKeys.whatAreYouLookingFor.tr(),
                        //     style: Theme.of(context).textTheme.headline3,
                        //   ),
                        // ),
                        // 14.heightBox,
                        BuildCategoriesList(),
                        25.heightBox,
                        homeCubit.recommendationProducts.loadingProducts
                            ? const Center(
                          child: CircularProgressIndicator(
                              color: AppPalette.primary),
                        ) : homeCubit.recommendationProducts.products == null ?
                        ErrorScreenConnection(onPressed: (){
                          loadData();
                          loadDataBanners();
                          BlocProvider.of<HomeCubit>(context, listen: false)
                              .getRecommendationProducts(refresh: true);
                          AppLocalStorage.token != null ?
                          loadDataProfile() : null ;
                        },) :
                        homeCubit.recommendationProducts.products.isEmpty ?
                        ErrorScreenConnection(onPressed: (){
                          loadData();
                          loadDataBanners();
                          BlocProvider.of<HomeCubit>(context, listen: false)
                              .getRecommendationProducts(refresh: true);
                          AppLocalStorage.token != null ?
                          loadDataProfile() : null ;
                        },) :
                        BlocBuilder<AppUiCubit, AppUiState>(
                          builder: (context, state) {
                            AppUiCubit appUICubit = AppUiCubit.get(context);
                            return ListView(
                              shrinkWrap: true,
                              controller: scrollController,
                              physics: const ScrollPhysics(),
                              padding: EdgeInsets.zero,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: Dimensions.paddingSizeDefault,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      GestureDetector(
                                        child: Text(
                                          LocaleKeys.newRecommendations.tr(),
                                          style:
                                          Theme.of(context).textTheme.headline3,
                                        ),
                                        onTap: () async{
                                          // translationText();
                                        } ,
                                      ),
                                      InkWell(
                                        onTap: appUICubit.toggleView,
                                        child: Icon(
                                            appUICubit.isGrid
                                                ? Icons.list_sharp
                                                : Icons.grid_view_sharp,
                                            color: AppPalette.black),
                                      ),
                                    ],
                                  ),
                                ),
                                // 20.heightBox,
                                Padding(
                                    padding: const EdgeInsets.symmetric(
                                    //  horizontal: Dimensions.paddingSizeDefault,
                                    ),
                                    child: appUICubit.isGrid
                                        ? ProductsGridWidget(
                                      products: homeCubit.recommendationProducts.products,
                                    )
                                        : ProductListWidget(
                                        products: homeCubit.recommendationProducts.products)),
                                65.heightBox,
                              ],
                            );
                          },
                        )
                      ],
                    ),
                  );

                },
              )
            ],
          ),
        ),
      ),
    );
  }



}
