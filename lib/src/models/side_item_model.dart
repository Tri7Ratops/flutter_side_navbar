import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SideItemModel extends Equatable {
  final Widget? page;
  final IconData icon;
  final String? iconTitle;
  final Function()? onTap;
  final Function()? onMostVisible;
  final Function()? lostFocus;
  final Color defaultIconColor;
  final Color focusBackgroundColor;
  final Color focusIconColor;
  final Color focusTextColor;

  double visibilityPercentage = 0.0;
  bool mostVisible = false;
  GlobalKey keyFlex = GlobalKey();
  bool animationDone = false;

  SideItemModel({
    required this.page,
    required this.icon,
    this.iconTitle,
    this.onMostVisible,
    this.lostFocus,
    this.onTap,
    this.defaultIconColor = Colors.black,
    this.focusBackgroundColor = Colors.white,
    this.focusIconColor = Colors.black,
    this.focusTextColor = Colors.black,
  });

  @override
  List<Object?> get props => [
    page,
    icon,
    iconTitle,
    visibilityPercentage,
    mostVisible,
    onMostVisible,
    lostFocus,
    focusBackgroundColor,
    keyFlex,
  ];
}
