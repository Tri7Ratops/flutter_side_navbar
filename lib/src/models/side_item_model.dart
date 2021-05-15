import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SideItemModel extends Equatable {
  /// Widget to show
  final Widget? page;

  /// Icon showed according to the page in the navigation
  final IconData icon;

  /// Used as a complement of the icon
  final String? iconTitle;

  /// Used for specific development when the user click on the icon in the navigation
  final Function()? onTap;

  /// Used for specific development when the widget is the most visible
  final Function()? onMostVisible;

  /// Used for specific development when the widget lost focus
  final Function()? lostFocus;

  /// Default color of the icon when the page is not the most visible
  final Color defaultIconColor;

  /// Background color of the navigation item when the corresponding page is focused
  final Color focusBackgroundColor;

  /// Icon color of the navigation item when the corresponding page is focused
  final Color focusIconColor;

  /// Text color of the navigation item when the corresponding page is focused
  final Color focusTextColor;

  /// Visibility percentage shown of the page (From 0.0 to 100%)
  double visibilityPercentage = 0.0;

  /// If the page is the most visible, mostVisible = true
  bool mostVisible = false;

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

  /// You can compare your side_item_model thanks to Equatable plugin
  ///
  /// For more information:
  /// https://pub.dev/packages/equatable
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
      ];
}
