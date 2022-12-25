import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppPullToRefresh extends StatefulWidget {
  AppPullToRefresh(
      {Key? key,
      required this.child,
      this.onLoading,
      this.onRefresh,
      this.ordersNoMore})
      : super(key: key);
  final Widget child;
  final Function? onRefresh;
  final Function? onLoading;
  bool? ordersNoMore;
  @override
  _AppPullToRefreshState createState() => _AppPullToRefreshState();
}

class _AppPullToRefreshState extends State<AppPullToRefresh> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  @override
  void dispose() {
    super.dispose();
    _refreshController.dispose();
  }

  void _onRefresh() {
    if (widget.onRefresh != null) {
      widget.onRefresh!();
    }
    _refreshController.refreshCompleted();
  }

  void _onLoading() {
    if (widget.onLoading != null) {
      widget.onLoading!();
    }
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(

      child: SmartRefresher(
          controller: _refreshController,
          onRefresh: _onRefresh,
          onLoading: _onLoading,
          enablePullUp: true,
          footer:
              CustomFooter(builder: (BuildContext context, LoadStatus? mode) {
            Widget body;
            if (widget.ordersNoMore!) {
              body = const Text('No more Data');
            } else if (mode == LoadStatus.idle) {
              body = const Text('pull up load');
            } else if (mode == LoadStatus.loading) {
              body = const CupertinoActivityIndicator();
            } else if (mode == LoadStatus.failed) {
              body = const Text('Load Failed!Click retry!');
            } else if (mode == LoadStatus.canLoading) {
              body = const CupertinoActivityIndicator();
            } else {
              body = const Text('No more Data');
            }
            return SizedBox(
              height: 55.0.h,
              child: Center(child: body),
            );
          }),
          physics: const BouncingScrollPhysics(),
          child: widget.child),
    );
  }
}
