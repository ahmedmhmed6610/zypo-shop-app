import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:shop/business_logic/filter_cubit/filter_cubit.dart';
import 'package:shop/business_logic/my_favorite_user_cubit/my_favorite_user_cubit.dart';
import 'package:shop/ui/screens/user_products_screen/home_user_favorite_products_screen.dart';
import 'package:shop/utils/app_size_boxes.dart';

import '../../../business_logic/app_layout_cubit/app_layout_cubit.dart';
import '../../../data/internet_connectivity/no_internet.dart';
import '../../../helpers/app_local_storage.dart';
import '../../../helpers/call_helper.dart';
import '../../../libraries/dialog_widget.dart';
import '../../../translations/locale_keys.g.dart';
import '../../../utils/LoadingWidget.dart';
import '../../../utils/Themes.dart';
import '../../../utils/app_palette.dart';
import '../../../utils/dimensions.dart';
import '../../widgets/My_products_widgets/add_button_widget.dart';
import '../../widgets/common_widgets/rating_widget.dart';
import '../auth/login_screen.dart';
import '../layout/app_layout.dart';

class MyFavoriteUserScreen extends StatefulWidget {
  MyFavoriteUserScreen({Key? key, required this.userId}) : super(key: key);
  String? userId;

  @override
  _MyFavoriteUserScreenState createState() => _MyFavoriteUserScreenState();
}

class _MyFavoriteUserScreenState extends State<MyFavoriteUserScreen> {
  String imageUser =
      'https://img.freepik.com/free-photo/excited-man-celebrating-victory-rejoicing-making-fist-pump-gesture-winning-looking-satisfied-saying-yes-achieve-goal-standing-light-turquoise-wall_1258-23890.jpg?w=1060&t=st=1660172869~exp=1660173469~hmac=0ed5bff0eaf4351e4f8be5777ffbcc142793655b001ccf3f66e9743a45634605';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  loadData() {
    BlocProvider.of<MyFavoriteUserCubit>(context, listen: false)
        .getMyFavoriteUser(widget.userId.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.myFavoriteUser.tr()),
        elevation: 0.0,
        leading: InkWell(
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => AppLayout()));
          },
          child: const Icon(Icons.arrow_back_ios,
              size: 20.0, color: AppPalette.black),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          loadData();
        },
        child: BlocConsumer<MyFavoriteUserCubit, MyFavoriteUserState>(
          listener: (BuildContext context, notificationState) async {
            _handleFavoriteUserListener(context, notificationState);
          },
          builder: (context, notificationState) {
            return BlocConsumer<AppLayoutCubit, AppLayoutState>(
              listener: (context, state) {
                if (state is ConnectionSuccess) {
                  if (notificationState is MyFavoriteUserSuccessfullyState) {
                     notificationState.myFavoriteResponseModel!.isNotEmpty
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
                                        notificationState
                                            .myFavoriteResponseModel![
                                        index]
                                            .user!.photo ==
                                            null
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
                                              imageUrl: imageUser,
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
                                              imageUrl:  '${notificationState.myFavoriteResponseModel![index]
                                                  .user!.photo}}',
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
                        : Center(
                      child: SvgPicture.asset(
                          "assets/images/svg/addProduct.svg",
                          fit: BoxFit.contain),
                    );
                  } else if (notificationState is MyFavoriteUserErrorState) {
                    LoadingWidget(
                      data: '${notificationState.error}',
                    );
                  }
                  const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is ConnectionFailure) {
                  NoInternetConnectionScreen(
                    appLayoutState: state,
                  );
                }
              },
              builder: (context, state) {
                if (state is ConnectionFailure) {
                  return NoInternetConnectionScreen(
                    appLayoutState: state,
                  );
                } else if (state is ConnectionSuccess) {
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
                                              notificationState
                                                          .myFavoriteResponseModel![
                                                              index]
                                                          .user!.photo ==
                                                      null
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
                                                      imageUrl:  '${notificationState.myFavoriteResponseModel![index]
                                                          .user!.photo}}',
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
                        : Center(
                            child: SvgPicture.asset(
                                "assets/images/svg/addProduct.svg",
                                fit: BoxFit.contain),
                          );
                  } else if (notificationState is MyFavoriteUserErrorState) {
                    LoadingWidget(
                      data: '${notificationState.error}',
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Scaffold(
                    body: Center(
                  child: AnimatedTextKit(
                    animatedTexts: [
                      WavyAnimatedText(LocaleKeys.markety.tr(),
                          textStyle: TextStyle(
                              fontSize: 20.0.sp,
                              color: Themes.colorApp13,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins-bold')),
                    ],
                    isRepeatingAnimation: true,
                    totalRepeatCount: 6,
                    onTap: () {},
                  ),
                ));
              },
            );
          },
        ),
      ),
    );
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
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => MyFavoriteUserScreen(userId: widget.userId)));
    }
  }
}
