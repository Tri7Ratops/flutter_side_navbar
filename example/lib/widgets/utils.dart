import 'package:flutter/material.dart';

class Utils {
  static Widget getContainer({required double height, required Color color, double margeVertical = 10.0}) {
    return Container(
      height: height,
      width: double.infinity,
      color: color,
      margin: EdgeInsets.only(bottom: margeVertical),
    );
  }
}