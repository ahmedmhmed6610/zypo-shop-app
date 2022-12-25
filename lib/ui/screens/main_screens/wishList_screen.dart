import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shop/business_logic/app_ui_cubit/app_ui_cubit.dart';
import 'package:shop/business_logic/wishlist_cubit/wishlist_cubit.dart';
import 'package:shop/business_logic/wishlist_cubit/wishlist_state.dart';
import 'package:shop/helpers/cache_helper.dart';
import 'package:shop/translations/locale_keys.g.dart';
import 'package:shop/ui/widgets/products_grid_widget.dart';
import 'package:shop/ui/widgets/products_list_wiget.dart';
import 'package:shop/ui/widgets/wishlist_widgets/empty_wishlist_widget.dart';
import 'package:shop/utils/app_palette.dart';
import 'package:shop/utils/app_size_boxes.dart';

import '../../../business_logic/app_layout_cubit/app_layout_cubit.dart';
import '../../../business_logic/filter_cubit/filter_cubit.dart';
import '../../../business_logic/home_cubit/home_cubit.dart';
import '../../../business_logic/my_favorite_user_cubit/my_favorite_user_cubit.dart';
import '../../../data/internet_connectivity/no_internet.dart';
import '../../../helpers/app_local_storage.dart';
import '../../../helpers/call_helper.dart';
import '../../../utils/LoadingWidget.dart';
import '../../../utils/Themes.dart';
import '../../../utils/dimensions.dart';
import '../../../utils/styles.dart';
import '../../widgets/My_products_widgets/add_button_widget.dart';
import '../../widgets/My_products_widgets/add_new_product_widget.dart';
import '../../widgets/My_products_widgets/add_new_product_widget_favorite.dart';
import '../../widgets/common_widgets/appbar_search_row.dart';
import '../../widgets/common_widgets/rating_widget.dart';
import '../layout/app_layout.dart';
import '../my_favorite_user_screen/my_favorite_user_screen.dart';
import '../user_products_screen/home_user_favorite_products_screen.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({Key? key}) : super(key: key);

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  // Timer? timer;

  String? userId;

  @override
  void initState() {
    // TODO: implement initState
    // CheckUserConnection();
    //  timer = Timer.periodic(const Duration(seconds: 3), (Timer t) => CheckUserConnection());
    super.initState();
    userId = CacheHelper.getData(key: 'UserId');
    print('userId personal');
    print(userId);
    if (userId != null) {
      BlocProvider.of<MyFavoriteUserCubit>(context, listen: false)
          .getMyFavoriteUser('$userId');
    }
    //  BlocProvider.of<WishlistCubit>(context).getWishList(refresh: true);
  }

  bool? isFavoriteProduct = true;
  bool? isFavoriteUser = false;

  String imageUser =
      'https://img.freepik.com/free-photo/excited-man-celebrating-victory-rejoicing-making-fist-pump-gesture-winning-looking-satisfied-saying-yes-achieve-goal-standing-light-turquoise-wall_1258-23890.jpg?w=1060&t=st=1660172869~exp=1660173469~hmac=0ed5bff0eaf4351e4f8be5777ffbcc142793655b001ccf3f66e9743a45634605';

  @override
  Widget build(BuildContext context) {
    final notificationState = context.watch<MyFavoriteUserCubit>().state;
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          color: AppPalette.primary,
          child: Column(
            children: [
              25.heightBox,
              BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  HomeCubit homeCubit = HomeCubit.get(context);
                  return  AppBarSearchRow(
                      productModel:
                      homeCubit.recommendationProducts.products);
                },
              ),
              15.heightBox,
              Container(
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                    color: AppPalette.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25))),
                child: Column(
                  children: [
                    25.heightBox,
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.r),
                      child: Row(
                        children: [
                          Expanded(
                              child: AddNewProductWidgetFavorite(
                                title: LocaleKeys.myFavoriteProduct.tr(),
                                onTap: () {
                                  setState(() {
                                    isFavoriteProduct = true;
                                    isFavoriteUser = false;
                                  });
                                },
                                colorBackground: isFavoriteProduct == true
                                    ? AppPalette.primary
                                    : AppPalette.shadowColor2,
                                colorText: isFavoriteProduct == true
                                    ? AppPalette.white
                                    : AppPalette.black,
                              )),
                          10.widthBox,
                          Expanded(
                              child: AddNewProductWidgetFavorite(
                                title: LocaleKeys.myFavoriteUser.tr(),
                                onTap: () {
                                  setState(() {
                                    isFavoriteProduct = false;
                                    isFavoriteUser = true;
                                  });
                                },
                                colorBackground: isFavoriteUser == true
                                    ? AppPalette.primary
                                    : AppPalette.shadowColor2,
                                colorText: isFavoriteUser == true
                                    ? AppPalette.white
                                    : AppPalette.black,
                              )),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: isFavoriteProduct!,
                      child: Expanded(
                        child: BlocBuilder<WishlistCubit, WishlistState>(
                          builder: (context, state) {
                            WishlistCubit wishListController =
                            WishlistCubit.get(context);
                            return  SingleChildScrollView(
                              child: Column(
                                children: [
                                  wishListController.wishList.loadingProducts
                                      ? const Center(
                                    child: CircularProgressIndicator(
                                        color: AppPalette.primary),
                                  )
                                      : wishListController
                                      .wishList.products.isEmpty ||
                                      AppLocalStorage.token == null
                                      ? const EmptyWishListWidget()
                                      : BlocBuilder<AppUiCubit, AppUiState>(
                                    builder: (context, state) {
                                      AppUiCubit appUICubit =
                                      AppUiCubit.get(context);
                                      return Column(
                                        children: [
                                          25.heightBox,
                                          Padding(
                                            padding:
                                            EdgeInsets.symmetric(
                                              horizontal: Dimensions
                                                  .paddingSizeDefault,
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .start,
                                              children: [
                                                Container(
                                                  child: Text(
                                                    LocaleKeys
                                                        .myFavoriteProduct
                                                        .tr(),
                                                    maxLines: 1,
                                                    overflow:
                                                    TextOverflow
                                                        .ellipsis,
                                                    style: AppTextStyles
                                                        .poppinsMedium
                                                        .copyWith(
                                                        color: Colors
                                                            .black,
                                                        fontWeight:
                                                        FontWeight
                                                            .normal,
                                                        fontFamily:
                                                        Fonts
                                                            .poppins),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: appUICubit
                                                      .toggleView,
                                                  child: Icon(
                                                      appUICubit
                                                          .isGrid
                                                          ? Icons
                                                          .list_sharp
                                                          : Icons
                                                          .grid_view_sharp,
                                                      color:
                                                      AppPalette
                                                          .black),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                            EdgeInsets.symmetric(
                                              horizontal: Dimensions
                                                  .paddingSizeDefault,
                                            ),
                                            child: appUICubit.isGrid
                                                ? ProductsGridWidget(
                                                products:
                                                wishListController
                                                    .wishList
                                                    .products)
                                                : ProductListWidget(
                                                products:
                                                wishListController
                                                    .wishList
                                                    .products),
                                          ),
                                          55.heightBox,
                                        ],
                                      );
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Visibility(
                        visible: isFavoriteUser!,
                        child: Expanded(
                          child: BlocConsumer<MyFavoriteUserCubit, MyFavoriteUserState>(
                            listener: (BuildContext context, notificationState) async {
                              _handleFavoriteUserListener(context, notificationState);
                            },
                            builder: (context, notificationState) {
                              if (notificationState is MyFavoriteUserSuccessfullyState) {
                                return notificationState.myFavoriteResponseModel!.isNotEmpty
                                    ? Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: notificationState
                                        .myFavoriteResponseModel!.length,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () {
                                          BlocProvider.of<FilterCubit>(context)
                                              .getUserProducts(notificationState
                                              .myFavoriteResponseModel![index]
                                              .user!
                                              .id
                                              .toString());
                                          Navigator.of(context)
                                              .push(MaterialPageRoute(
                                            builder: (context) =>
                                                HomeUserFavoriteProductsScreen(
                                                    myFavoriteResponseModel:
                                                    notificationState
                                                        .myFavoriteResponseModel![
                                                    index]),
                                          ));
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 10),
                                          child: Card(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(15)),
                                            elevation: 3.0,
                                            color: AppPalette.white,
                                            shadowColor: AppPalette.white,
                                            child: Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: SizedBox(
                                                height: 110,
                                                child: Row(
                                                  children: [
                                                    notificationState.myFavoriteResponseModel![index].user!.photo == null
                                                        ? Padding(
                                                      padding:
                                                      const EdgeInsets
                                                          .all(5.0),
                                                      child: Container(
                                                        width: 55.h,
                                                        height: 65.h,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                            BorderRadius.circular(
                                                                Dimensions
                                                                    .radiusSmall)),
                                                        child: CachedNetworkImage(
                                                          fit: BoxFit.cover,
                                                          imageUrl:  imageUser,
                                                          placeholder: (context, url) => Image.asset('assets/images/loader.gif'),
                                                          errorWidget: (context, url, error) => new Icon(Icons.error),
                                                        ),
                                                      ),
                                                    )
                                                        : Padding(
                                                      padding:
                                                      const EdgeInsets
                                                          .all(5.0),
                                                      child: Container(
                                                          width: 55.h,
                                                          height: 65.h,
                                                          decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.circular(
                                                                  Dimensions
                                                                      .radiusSmall)),
                                                          child: CachedNetworkImage(
                                                            fit: BoxFit.cover,
                                                            imageUrl:  '${notificationState.myFavoriteResponseModel![index].user?.userImagePath}/'
                                                                '${notificationState.myFavoriteResponseModel![index].user!.photo}',
                                                            placeholder: (context, url) => Image.asset('assets/images/loader.gif'),
                                                            errorWidget: (context, url, error) => new Icon(Icons.error),
                                                          )
                                                      ),
                                                    ),
                                                    5.widthBox,
                                                    Expanded(
                                                      child: Column(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Text(
                                                                '${notificationState.myFavoriteResponseModel![index].user!.firstName}',
                                                                style: const TextStyle(
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                    fontSize: 15),
                                                              ),
                                                              5.widthBox,
                                                              Text(
                                                                '${notificationState.myFavoriteResponseModel![index].user!.lastName}',
                                                                style: const TextStyle(
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                    fontSize: 15),
                                                              ),
                                                            ],
                                                          ),
                                                          12.heightBox,
                                                          Row(
                                                            children: [
                                                              Text(
                                                                '${notificationState.myFavoriteResponseModel![index].user!.productsCount}',
                                                                overflow: TextOverflow.ellipsis,
                                                                style: const TextStyle(
                                                                    fontWeight: FontWeight.normal,
                                                                    fontSize: 13),
                                                              ),
                                                              5.widthBox,
                                                              Text(
                                                                LocaleKeys.products.tr(),
                                                                overflow: TextOverflow.ellipsis,
                                                                style: const TextStyle(
                                                                    fontWeight: FontWeight.normal,
                                                                    fontSize: 13),
                                                              ),
                                                            ],
                                                          ),
                                                          10.heightBox,
                                                          RatingWidget(rate: 5),
                                                          5.heightBox,
                                                        ],
                                                      ),
                                                    ),
                                                    5.widthBox,
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets.all(
                                                          5.0),
                                                      child: Row(
                                                        children: [
                                                          Card(
                                                            shadowColor:
                                                            AppPalette.white,
                                                            elevation: 2.0,
                                                            color:
                                                            AppPalette.white,
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius: BorderRadius.circular(10)),
                                                            child: Container(
                                                              width: 40.h,
                                                              height: 40.h,
                                                              child: Center(
                                                                child: IconButton(
                                                                    color:
                                                                    AppPalette
                                                                        .white,
                                                                    onPressed:
                                                                        () async {
                                                                      print('favorite user');
                                                                      print(notificationState.
                                                                      myFavoriteResponseModel![index].user!.id);

                                                                      BlocProvider.of<MyFavoriteUserCubit>(context).
                                                                      deleteSubscribeUser(notificationState.
                                                                      myFavoriteResponseModel![index].user!.id.toString());

                                                                    },
                                                                    icon:
                                                                    const Icon(
                                                                      Icons
                                                                          .favorite,
                                                                      color: AppPalette
                                                                          .primary,
                                                                    )),
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 5.h,
                                                          ),
                                                          AddButtonWidget(
                                                            child: IconButton(
                                                                color: AppPalette
                                                                    .primary,
                                                                onPressed:
                                                                    () async {
                                                                  await callNumber(
                                                                      phoneNumber:
                                                                      '${notificationState.myFavoriteResponseModel![index].user!.id}');
                                                                },
                                                                icon: SvgPicture
                                                                    .asset(
                                                                  "assets/images/svg/phoneCall.svg",
                                                                  fit: BoxFit
                                                                      .scaleDown,
                                                                  color:
                                                                  AppPalette
                                                                      .white,
                                                                )),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                )
                                    : Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 15.r),
                                      child: Column(
                                        children: [
                                          SvgPicture.asset(
                                          "assets/images/svg/addProduct.svg",
                                          fit: BoxFit.contain),
                                        ],
                                      ),
                                    );
                              } else if (notificationState is MyFavoriteUserErrorState) {
                                LoadingWidget(
                                  data: '${notificationState.error}',
                                );
                              }
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                          ),
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  load() {
    BlocProvider.of<WishlistCubit>(context, listen: false)
        .getWishList(refresh: true);
  }

  void _handleFavoriteUserListener(
      BuildContext context, MyFavoriteUserState state) {
    if (state is SubscribeUserErrorState) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.warning,
        animType: AnimType.rightSlide,
        btnOkText: LocaleKeys.ok.tr(),
        btnCancelText: LocaleKeys.cancel.tr(),
        title: LocaleKeys.error.tr(),
        desc: state.error,
        btnCancelOnPress: () {},
        btnOkOnPress: () {},
      ).show();
    } else if (state is SubscribeUserSuccessfullyState) {
      // CustomFlutterToast(state.loginModel?.user?.token);
      // CustomFlutterToast(state.loginModel?.user?.userName);
      // CustomFlutterToast(state.loginModel?.user?.phoneNumber);
      // CustomFlutterToast(state.loginModel?.user?.userEmail);
      //  CacheHelper().setToken('${state.loginModel?.user?.token}');
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => AppLayout()));
    }
  }
}
