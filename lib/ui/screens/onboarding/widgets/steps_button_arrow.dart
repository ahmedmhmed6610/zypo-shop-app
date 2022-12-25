import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop/utils/dimensions.dart';
import '../../../../helpers/app_local_storage.dart';
import '../../../../utils/app_constants.dart';
import '../page_view_item.dart';

class StepsContainer extends StatelessWidget {
  const StepsContainer({
    Key? key,
    required this.page,
    required List<PageViewModel> list,
    required PageController controller,
  })  : _list = list,
        _controller = controller,
        super(key: key);

  final int page;
  final List<PageViewModel> _list;
  final PageController _controller;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (page < _list.length && page != _list.length - 1) {
          _controller.animateToPage(page + 1,
              duration: const Duration(microseconds: 500),
              curve: Curves.easeInCirc);
        } else {
          await AppLocalStorage.saveValue(
              AppConstants.onBoardingSeen, true);
          Navigator.of(context).pushNamed(AppConstants.appLayout);
        }
      },
      child: CircleAvatar(
        minRadius: Dimensions.radiusExtraExtraLarge,
        backgroundColor: const Color(0xFF455A64),
        child: Icon(
          Icons.keyboard_arrow_right,
          color: Colors.white,
          size: 35.0.sp,
        ),
      ),
    );
  }
}
