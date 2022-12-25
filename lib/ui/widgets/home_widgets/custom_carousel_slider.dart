import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shop/data/internet_connectivity/no_internet.dart';
import 'package:shop/ui/screens/product_details_screen/image_details_zoom_screen.dart';
import 'package:shop/ui/widgets/common_widgets/custom_image.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../business_logic/app_layout_cubit/app_layout_cubit.dart';
import '../../../data/models/slider_model.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/app_palette.dart';
import '../../../utils/dimensions.dart';

class CustomCarouselSlider extends StatefulWidget {
  CustomCarouselSlider({Key? key, required this.sliderResponseModel})
      : super(key: key);
  List<SliderResponseModel>? sliderResponseModel;

  @override
  State<CustomCarouselSlider> createState() => _CustomCarouselSliderState();
}

class _CustomCarouselSliderState extends State<CustomCarouselSlider> {
  String profileImage =
      "https://img.freepik.com/free-vector/cute-gentleman-character-illustration_24877-60133.jpg?t=st=1658505623~exp=1658506223~hmac=3ee77155aae3cea1d1f3d7eccb20aa72617e4dfb894551a6223da59d10b52718&w=740";

  List<String> profileImageList = [
    'assets/images/product_sold.png',
    'assets/images/product_sold.png',
    'assets/images/product_sold.png',
    // "https://img.freepik.com/free-vector/cute-gentleman-character-illustration_24877-"
    //     "60133.jpg?t=st=1658505623~exp=1658506223~hmac=3ee77155aae3cea1d1f3d7eccb20aa72617e4dfb894551a6223da59d10b52718&w=740",
    // "https://img.freepik.com/free-vector/cute-gentleman-character-illustration_24877-"
    //     "60133.jpg?t=st=1658505623~exp=1658506223~hmac=3ee77155aae3cea1d1f3d7eccb20aa72617e4dfb894551a6223da59d10b52718&w=740",
  ];


  Future<void> _dialogBuilder(BuildContext context,String imageDetails) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          //  title: const Text('Basic dialog title'),
          content: InteractiveViewer(
            maxScale: 2.5,
            child: Container(
              height: 250.h,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                image: DecorationImage(
                    image: CachedNetworkImageProvider(imageDetails),
                    fit: BoxFit.fill),
              ),
            ),
          ),
        );
      },
    );
  }

  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<AppLayoutCubit>(context).checkUserConnection();
    BlocProvider.of<AppLayoutCubit>(context).checkConnectionInternet();
  }
  @override
  Widget build(BuildContext context) {
    final stateConnectionInternet = context.watch<AppLayoutCubit>().state;
    return
    stateConnectionInternet is ConnectionFailure ?
      NoInternetConnectionScreen(appLayoutState: stateConnectionInternet) :
      widget.sliderResponseModel == null ?
      Card(
        color: AppPalette.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15)),
        child: Container(
            height: 150.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
            ),
            child:  CarouselSlider(
                items: profileImageList.map((e) => ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: InkWell(
                      onTap: () {
                        //  _dialogBuilder(context,'${e.bannerImagePath}/${e.image?.name}');
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) =>
                        //           ImageDetailsZoomScreen(
                        //               imageDetails:
                        //                   '${e.bannerImagePath}/${e.image?.name}'),
                        //     ));

                        // print(' link ${e.link}');
                        // print('${e.bannerImagePath}/${e.image?.name}');
                        //
                        // _launchURL(e.link);

                      },
                      child: FadeInImage(
                        image: AssetImage(e),
                        height: 150.h,
                        width: Get.width,
                        fit: BoxFit.cover,
                        placeholder: const AssetImage(
                            'assets/images/loader.gif'),
                      )),
                ))
                    .toList(),
                options: CarouselOptions(
                  height: 200,
                  aspectRatio: 2.0,
                  viewportFraction: 1.1,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration: const Duration(seconds: 1),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  scrollDirection: Axis.horizontal,
                ))),
      ) :
      widget.sliderResponseModel!.isNotEmpty ?
      Card(
        color: AppPalette.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15)),
        child: Container(
            height: 150.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
            ),
            child:  Swiper(
              physics: const PageScrollPhysics(),
              control: const SwiperPagination(
                  margin: EdgeInsets.all(0), builder: SwiperPagination.dots),
              itemCount: widget.sliderResponseModel!.length,
              autoplay: true,
              axisDirection: AxisDirection.right,
              itemBuilder: (BuildContext context, int index) {
                return FadeInImage(
                  image: NetworkImage('${widget.sliderResponseModel![index].bannerImagePath}/${widget.sliderResponseModel![index].image?.name}'),
                  height: 150.h,
                  width: Get.width,
                  fit: BoxFit.cover,
                  placeholder: const AssetImage(
                      'assets/images/loader.gif'),
                );
              },)),
      ) :
      Card(
      color: AppPalette.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15)),
      child: Container(
          height: 150.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
          ),
          child:  CarouselSlider(
              items: profileImageList.map((e) => ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: InkWell(
                    onTap: () {
                      //  _dialogBuilder(context,'${e.bannerImagePath}/${e.image?.name}');
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (context) =>
                      //           ImageDetailsZoomScreen(
                      //               imageDetails:
                      //                   '${e.bannerImagePath}/${e.image?.name}'),
                      //     ));

                      // print(' link ${e.link}');
                      // print('${e.bannerImagePath}/${e.image?.name}');
                      //
                      // _launchURL(e.link);

                    },
                    child: FadeInImage(
                      image: AssetImage(e),
                      height: 150.h,
                      width: Get.width,
                      fit: BoxFit.cover,
                      placeholder: const AssetImage(
                          'assets/images/loader.gif'),
                    )),
              ))
                  .toList(),
              options: CarouselOptions(
                height: 200,
                aspectRatio: 2.0,
                viewportFraction: 1.1,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(seconds: 1),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
              ))),
    );
  }
}
