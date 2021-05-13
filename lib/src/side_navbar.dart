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
  final Duration duration;

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
    this.duration = const Duration(milliseconds: 400),
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
    WidgetsBinding.instance!.addPostFrameCallback((_) => setState(() {}));
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
            duration: widget.duration,
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
    BuildContext? currentCxt = _keyList.currentContext;
    if (currentCxt == null) return;
    final RenderBox? renderBox = currentCxt.findRenderObject() as RenderBox;
    final pos = renderBox!.localToGlobal(Offset.zero);

    double paddingNav = widget.paddingNavigation != null ? widget.paddingNavigation!.top : 0;
    final double paddingMedia = MediaQuery.of(context).padding.top + MediaQuery.of(context).padding.bottom;

    double posi = -pos.dy;
    double basicPos = (widget.appBarIsShown ? AppBar().preferredSize.height : 0) + paddingNav + paddingMedia;

    double posiTrue = widget.shrinkWrap && widget.appBarIsShown ? 0 : paddingMedia;
    double posiFalse = -pos.dy + (widget.shrinkWrap ? AppBar().preferredSize.height - (widget.appBarIsShown ? -14 : 28) : 0) + 8 + paddingNav;

    double navigationPos = (posi < basicPos) ? posiTrue : posiFalse;

    if (navigationPos != posiTrue && navigationPos + MediaQuery.of(context).size.height >= renderBox.size.height) {
      navigationPos = renderBox.size.height - MediaQuery.of(context).size.height + (widget.appBarIsShown || widget.shrinkWrap ? AppBar().preferredSize.height : 0) + paddingNav + paddingMedia + 8;
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
      if (this.mounted) setState(() {});
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

    BuildContext? currentCxt = _keyList.currentContext;
    if (currentCxt == null) {
      return Container();
    }
    final double paddingMedia = MediaQuery.of(context).padding.top + MediaQuery.of(context).padding.bottom;
    final double paddingNavigation = widget.paddingNavigation != null ? (widget.paddingNavigation!.top + widget.paddingNavigation!.bottom) : 0.0;

    final RenderBox? renderBox = currentCxt.findRenderObject() as RenderBox;
    final heightContainerConstraint = renderBox!.constraints.maxHeight - paddingMedia;
    final heightContainer = MediaQuery.of(context).size.height - paddingMedia - paddingNavigation - (widget.appBarIsShown || widget.shrinkWrap ? kToolbarHeight : 0);

    return Container(
      height: heightContainerConstraint.isInfinite ? heightContainer : heightContainerConstraint,
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
