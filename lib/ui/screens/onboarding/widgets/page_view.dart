import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'steps_button_arrow.dart';
import '../page_view_item.dart';
import '../../../../utils/dimensions.dart';
import '../../../../utils/app_size_boxes.dart';

class PageViewComponent extends StatelessWidget {
  const PageViewComponent(
      {Key? key,
      required this.page,
      required this.index,
      required this.pages,
      required this.pageController})
      : super(key: key);
  final PageViewModel page;
  final int index;
  final List<PageViewModel> pages;
  final PageController pageController;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Card(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: Colors.white,
                width: 1.r,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(
                  50.r,
                ),
                bottomRight: Radius.circular(
                  50.r,
                ),
              ),
            ),
            child: Padding(
              padding:  EdgeInsets.symmetric(vertical: 10.r),
              child: Column(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: SvgPicture.asset(
                      page.image,
                      height: 229.h,
                      width: 262.w,
                    ),
                  ),
                  60.heightBox,
                  Expanded(
                    flex: 1,
                    child: Text(
                      page.title,
                      style: Theme.of(context).textTheme.headline1,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.paddingSizeDefault - 2.r,
                      ),
                      child: Text(
                        page.body,
                        style: Theme.of(context).textTheme.headline2,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Dimensions.paddingSizeDefault,
            vertical: 50.h,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SmoothPageIndicator(
                controller: pageController,
                count: pages.length,
                axisDirection: Axis.horizontal,
                effect: const ExpandingDotsEffect(
                  dotColor: Color(
                    0xFFFFFFFF,
                  ),
                  paintStyle: PaintingStyle.fill,
                  activeDotColor: Color(
                    0xFF455A64,
                  ),
                ),
              ),
              StepsContainer(
                page: index,
                list: pages,
                controller: pageController,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
