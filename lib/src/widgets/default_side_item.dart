import 'package:flutter/cupertino.dart';
import 'package:flutter_side_navbar/src/models/models.dart';

class DefaultSideItem extends StatelessWidget {
  final Function() onTap;
  final BoxDecoration decoration;
  final SideItemModel item;

  const DefaultSideItem({
    required this.decoration,
    required this.onTap,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: decoration,
        child: Icon(
          item.icon,
          color: item.defaultIconColor,
        ),
      ),
    );
  }
}
