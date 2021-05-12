import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_side_navbar/src/models/models.dart';
import 'package:flutter_side_navbar/src/widgets/widgets.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:visibility_detector/visibility_detector.dart';

class SideNavbar extends StatefulWidget {
  final List<SideItemModel> pages;
  final double navigationWidth;
  final Color navigationBackgroundColor;
  final BoxDecoration decorationItem;
  final bool reversed;
  final bool appBarIsShown;
  final EdgeInsets? padding;
  final EdgeInsets? paddingNavigation;
  final bool shrinkWrap;
  final AutoScrollController? controller;
  final ScrollPhysics? physics;

  SideNavbar({
    Key? key,
    required this.pages,
    this.navigationWidth = 75,
    this.navigationBackgroundColor = Colors.white10,
    this.padding,
    this.paddingNavigation = const EdgeInsets.all(10),
    this.reversed = false,
    this.shrinkWrap = false,
    this.appBarIsShown = false,
    this.controller,
    this.physics,
    BoxDecoration? decoration,
  })  : decorationItem = decoration ?? BoxDecoration(),
        super(key: key);

  @override
  _SideNavbarState createState() => _SideNavbarState();
}

class _SideNavbarState extends State<SideNavbar> {
  late AutoScrollController _controller;
  GlobalKey _keyList = GlobalKey();
  double position = 0;

  @override
  void initState() {
    _controller = widget.controller ??
        AutoScrollController(
          viewportBoundaryGetter: () => Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
          axis: Axis.vertical,
        );
    for (SideItemModel item in widget.pages) {
      if (item.page != null) {
        item.mostVisible = true;
        break;
      }
    }
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.reversed) {
      return Container(
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(seconds: 1),
              curve: Curves.fastOutSlowIn,
              top: position,
              left: 0,
              child: _getNavigationColumn(context),
            ),
            Container(
              margin: EdgeInsets.only(left: widget.navigationWidth),
              child: _getPagesColumn(),
            ),
          ],
        ),
      );
    }
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          _getPagesColumn(),
          AnimatedPositioned(
            duration: const Duration(seconds: 1),
            curve: Curves.fastOutSlowIn,
            top: position,
            right: 0,
            child: _getNavigationColumn(context),
          ),
        ],
      ),
    );
  }

  _getSizes() {
    BuildContext? currentCtxt = _keyList.currentContext;
    if (currentCtxt == null) return;
    final RenderBox? renderBox = currentCtxt.findRenderObject() as RenderBox;
    final pos = renderBox!.localToGlobal(Offset.zero);

    double paddingNav = widget.paddingNavigation != null ? widget.paddingNavigation!.top : 0;
    final double paddingMedia = MediaQuery.of(context).padding.top + MediaQuery.of(context).padding.bottom;
    double navigationPos = (-pos.dy < -(widget.appBarIsShown ? kToolbarHeight : 0) - 12 - paddingNav) ? 0 : (-pos.dy + (widget.appBarIsShown ? kToolbarHeight : 0) + paddingNav + paddingMedia + 12);

    if (navigationPos + MediaQuery.of(context).size.height > renderBox.size.height) {
      navigationPos = renderBox.size.height - MediaQuery.of(context).size.height + (widget.appBarIsShown ? kToolbarHeight : 0) + paddingNav;
    }

    if (this.mounted && navigationPos != position) {
      setState(() => position = navigationPos);
    }
  }

  _defineMostVisiblePage() {
    SideItemModel? mostItemVisible;
    SideItemModel? lastMostItemVisible;

    for (SideItemModel item in widget.pages) {
      if (item.mostVisible) {
        lastMostItemVisible = item;
      }
      item.mostVisible = false;

      if (item.page != null && (mostItemVisible == null || item.visibilityPercentage > mostItemVisible.visibilityPercentage)) {
        mostItemVisible = item;
      }
    }
    mostItemVisible?.mostVisible = true;
    if (mostItemVisible != lastMostItemVisible && this.mounted) {
      setState(() {});
      lastMostItemVisible?.lostFocus?.call();
      mostItemVisible?.onMostVisible?.call();
    }
  }

  Widget _getPagesColumn() {
    return Container(
      key: _keyList,
      width: MediaQuery.of(context).size.width - widget.navigationWidth,
      child: ListView.builder(
        physics: widget.physics,
        padding: widget.padding,
        shrinkWrap: widget.shrinkWrap,
        controller: _controller,
        scrollDirection: Axis.vertical,
        itemCount: widget.pages.length,
        itemBuilder: (context, index) {
          return VisibilityDetector(
            key: Key('INDEX-flutter-side-navbar-$index'),
            onVisibilityChanged: (visibilityInfo) {
              _getSizes();
              widget.pages[index].visibilityPercentage = visibilityInfo.visibleFraction * 100;
              _defineMostVisiblePage();
            },
            child: AutoScrollTag(
              key: ValueKey(index),
              controller: _controller,
              index: index,
              child: widget.pages[index].page ?? Container(),
            ),
          );
        },
      ),
    );
  }

  Widget _getNavigationColumn(BuildContext context) {
    List<Widget> list = [];

    for (SideItemModel item in widget.pages) {
      int index = widget.pages.indexOf(item);

      if (item.mostVisible) {
        list.add(
          Flexible(
            child: FocusSideItem(
              onTap: () {
                item.onTap?.call();
                _controller.scrollToIndex(index, preferPosition: AutoScrollPosition.begin);
                _controller.highlight(index);
              },
              reversed: widget.reversed,
              decoration: widget.decorationItem,
              item: item,
            ),
          ),
        );
      } else {
        list.add(
          Flexible(
            flex: 0,
            child: DefaultSideItem(
              decoration: widget.decorationItem,
              onTap: () {
                item.onTap?.call();
                _controller.scrollToIndex(index, preferPosition: AutoScrollPosition.begin);
                _controller.highlight(index);
              },
              item: item,
            ),
          ),
        );
      }
    }

    final double paddingMedia = MediaQuery.of(context).padding.top + MediaQuery.of(context).padding.bottom;
    final double paddingNavigation = widget.paddingNavigation != null ? (widget.paddingNavigation!.top + widget.paddingNavigation!.bottom) : 0.0;
    final heightContainer = MediaQuery.of(context).size.height - paddingMedia - paddingNavigation - (widget.appBarIsShown ? kToolbarHeight : 0);
    return Container(
      height: heightContainer,
      padding: widget.paddingNavigation,
      width: widget.navigationWidth,
      color: widget.navigationBackgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: list,
      ),
    );
  }
}
