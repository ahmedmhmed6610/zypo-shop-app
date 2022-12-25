import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shop/business_logic/notification_cubit/notification_cubit.dart';
import 'package:shop/utils/LoadingWidget.dart';
import 'package:shop/utils/app_size_boxes.dart';

import '../../../business_logic/app_layout_cubit/app_layout_cubit.dart';
import '../../../data/internet_connectivity/no_internet.dart';
import '../../../helpers/app_local_storage.dart';
import '../../../translations/locale_keys.g.dart';
import '../../../utils/Themes.dart';
import '../../../utils/app_palette.dart';
import '../../../utils/components.dart';
import '../../../utils/dimensions.dart';
import '../filter_screens/widget_custom.dart';
import '../layout/app_layout.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {

  String imageUser = 'https://img.freepik.com/free-photo/excited-man-celebrating-victory-rejoicing-making-fist-pump-gesture-winning-looking-satisfied-saying-yes-achieve-goal-standing-light-turquoise-wall_1258-23890.jpg?w=1060&t=st=1660172869~exp=1660173469~hmac=0ed5bff0eaf4351e4f8be5777ffbcc142793655b001ccf3f66e9743a45634605';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  loadData() {
    BlocProvider.of<NotificationCubit>(context, listen: false)
        .getNotificationUser();

  }
  String? lottie;
  @override
  Widget build(BuildContext context) {
    final stateProductConnection = context.watch<AppLayoutCubit>().state;
    return Scaffold(
      backgroundColor: AppPalette.primary,
      body: CustomAppBar(
        onTap: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => AppLayout()));
        },
        title: LocaleKeys.notification.tr(),
        widgetCustom:  stateProductConnection is ConnectionSuccess ?
        RefreshIndicator(
          onRefresh: ()async {
            loadData();
          },
          child: BlocConsumer<NotificationCubit, NotificationState>(
            listener: (BuildContext context, notificationState) async {
              // _handleLoginListener(context, addProductState);
            },
            builder: (context, notificationState) {
              return BlocConsumer<AppLayoutCubit, AppLayoutState>(
                listener: (context, state) {
                  if (state is ConnectionSuccess){
                    if(notificationState is NotificationSuccessfullyState){
                      notificationState.notificationResponseModel!.isNotEmpty ?
                      Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 10.h,vertical: 10.w),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: notificationState.notificationResponseModel!.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return  Padding(
                              padding:  EdgeInsets.symmetric(horizontal: 10.h,vertical: 10.w),
                              child: InkWell(
                                onTap: (){
                                  showNotification(context, lottie,
                                      notificationState.notificationResponseModel![index].productId.toString());
                                },
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)
                                  ),
                                  elevation: 3.0,
                                  color: AppPalette.white,
                                  shadowColor: AppPalette.white,
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: SizedBox(
                                      height: 110,
                                      child: Row(
                                        children: [
                                          notificationState.notificationResponseModel![index].prodcut == null ?
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Container(
                                              width: 40.h,
                                              height: 42.h,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: NetworkImage(imageUser),
                                                      fit: BoxFit.cover),
                                                  borderRadius: BorderRadius.circular(Dimensions.radiusSmall)),
                                            ),
                                          ) :  Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Container(
                                              width: 40.h,
                                              height: 42.h,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: NetworkImage('${notificationState.notificationResponseModel![index].title}}'),
                                                      fit: BoxFit.cover),
                                                  borderRadius: BorderRadius.circular(Dimensions.radiusSmall)),
                                            ),
                                          ),
                                          5.widthBox,
                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  '${notificationState.notificationResponseModel![index].title}',
                                                  style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
                                                ),
                                                12.heightBox,
                                                Text(
                                                  '${notificationState.notificationResponseModel![index].details}',
                                                  overflow: TextOverflow.ellipsis,
                                                  style: const TextStyle(fontWeight: FontWeight.normal,fontSize: 13),),
                                                10.heightBox,
                                                Row(
                                                  children: [
                                                    const Icon(Icons.timer_rounded,color: AppPalette.primary,),
                                                    3.widthBox,
                                                    Text(
                                                      '${notificationState.notificationResponseModel![index].title}',
                                                      style: const TextStyle(fontWeight: FontWeight.normal,fontSize: 13),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          5.widthBox,
                                          Padding(
                                            padding:  const EdgeInsets.all(5.0),
                                            child:  AppLocalStorage.language!.contains('en') ?
                                            const Icon(Icons.chevron_left,color: AppPalette.primary,) :
                                            const Icon(Icons.chevron_right,color: AppPalette.primary,),
                                          )

                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },),
                      ) :
                      Center(
                        child: SvgPicture.asset("assets/images/svg/addProduct.svg",
                            fit: BoxFit.contain),
                      );

                    }else if(notificationState is NotificationErrorState){
                      LoadingWidget(data: '${notificationState.error}',);
                    }
                    const Center(
                      child: CircularProgressIndicator(),
                    );

                  }else if (state is ConnectionFailure){
                    NoInternetConnectionScreen(appLayoutState: state,);
                  }
                },
                builder: (context, state) {
                  if(state is ConnectionFailure){
                    return  NoInternetConnectionScreen(appLayoutState: state,);
                  }
                  else if(state is ConnectionSuccess){
                    if(notificationState is NotificationSuccessfullyState){
                      return notificationState.notificationResponseModel!.isNotEmpty ?
                      Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 10.h,vertical: 10.w),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: notificationState.notificationResponseModel!.length,
                          itemBuilder: (context, index) {
                            return  Padding(
                              padding:  EdgeInsets.symmetric(horizontal: 10.h,vertical: 10.w),
                              child: InkWell(
                                onTap: (){
                                  // print('notificationResponseModel');
                                  // print(notificationState.notificationResponseModel![index].productId);
                                  // print(notificationState.notificationResponseModel![index].title);
                                  // print(notificationState.notificationResponseModel![index].details);
                                  // print(notificationState.notificationResponseModel![index].prodcut);
                                  showNotification(context, lottie,
                                      notificationState.notificationResponseModel![index].productId.toString());
                                },
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)
                                  ),
                                  elevation: 3.0,
                                  color: AppPalette.white,
                                  shadowColor: AppPalette.white,
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: SizedBox(
                                      height: 110,
                                      child: Row(
                                        children: [
                                          notificationState.notificationResponseModel![index].prodcut == null ?
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Container(
                                              width: 40.h,
                                              height: 42.h,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: NetworkImage(imageUser),
                                                      fit: BoxFit.cover),
                                                  borderRadius: BorderRadius.circular(Dimensions.radiusSmall)),
                                            ),
                                          ) :  Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Container(
                                              width: 40.h,
                                              height: 42.h,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: NetworkImage('${notificationState.notificationResponseModel![index].title}}'),
                                                      fit: BoxFit.cover),
                                                  borderRadius: BorderRadius.circular(Dimensions.radiusSmall)),
                                            ),
                                          ),
                                          5.widthBox,
                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  '${notificationState.notificationResponseModel![index].title}',
                                                  style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
                                                ),
                                                12.heightBox,
                                                Text(
                                                  '${notificationState.notificationResponseModel![index].details}',
                                                  overflow: TextOverflow.ellipsis,
                                                  style: const TextStyle(fontWeight: FontWeight.normal,fontSize: 13),),
                                                10.heightBox,
                                                Row(
                                                  children: [
                                                    const Icon(Icons.timer_rounded,color: AppPalette.primary,),
                                                    3.widthBox,
                                                    Text(
                                                      '${notificationState.notificationResponseModel![index].title}',
                                                      style: const TextStyle(fontWeight: FontWeight.normal,fontSize: 13),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          5.widthBox,
                                          Padding(
                                            padding:  const EdgeInsets.all(5.0),
                                            child:  AppLocalStorage.language!.contains('en') ?
                                            const Icon(Icons.chevron_left,color: AppPalette.primary,) :
                                            const Icon(Icons.chevron_right,color: AppPalette.primary,),
                                          )

                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },),
                      ) :
                      Center(
                        child: SvgPicture.asset("assets/images/svg/addProduct.svg",
                            fit: BoxFit.contain),
                      );

                    }else if(notificationState is NotificationErrorState){
                      LoadingWidget(data: '${notificationState.error}',);
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
        ) : NoInternetConnectionScreen(appLayoutState: stateProductConnection),),
    );
  }
}
