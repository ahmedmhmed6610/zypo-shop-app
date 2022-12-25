import 'package:flutter/material.dart';
import 'package:shop/utils/strings.dart';
import '../../../utils/app_palette.dart';
import '../../../utils/images.dart';
import '../../../utils/size_config.dart';
import 'page_view_item.dart';
import 'widgets/page_view.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<PageViewModel> onBoardingPages = <PageViewModel>[
    PageViewModel(
      Images.onBoarding1,
      AppStrings.onBoardingTitle1,
      AppStrings.onBoardingBody1,
    ),
    PageViewModel(
      Images.onBoarding2,
      AppStrings.onBoardingTitle2,
      AppStrings.onBoardingBody2,
    ),
    PageViewModel(
      Images.loginImageChild,
      AppStrings.onBoardingTitle3,
      AppStrings.onBoardingBody3,
    )
  ];

  PageController pageController = PageController();
  bool isLast = false;
  int page = 0;

  @override
  Widget build(BuildContext context) {
    pageController.addListener(() {
      setState(() {
        page = pageController.page!.round();
      });
    });

    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppPalette.primary,
        body: PageView.builder(
          physics: const BouncingScrollPhysics(),
          onPageChanged: (int index) {
            if (index == onBoardingPages.length - 1) {
              setState(() {
                isLast = true;
              });
            } else {
              setState(() {
                isLast = false;
              });
            }
          },
          controller: pageController,
          itemBuilder: (BuildContext context, int index) =>
              PageViewComponent(
            page: onBoardingPages[index],
            pageController: pageController,
            pages: onBoardingPages,
            index: index,
          ),
          itemCount: onBoardingPages.length,
        ),
      ),
    );
  }
}
