import 'package:flutter/cupertino.dart';
import 'package:flutter_side_navbar/src/models/side_item_model.dart';

class FocusSideItem extends StatefulWidget {
  final Function() onTap;
  final BoxDecoration decoration;
  final bool reversed;
  final SideItemModel item;

  const FocusSideItem({
    required this.decoration,
    required this.onTap,
    required this.reversed,
    required this.item,
  });

  @override
  _FocusSideItemState createState() => _FocusSideItemState();
}

class _FocusSideItemState extends State<FocusSideItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: widget.decoration
              .copyWith(color: widget.item.focusBackgroundColor),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                widget.item.icon,
                color: widget.item.focusIconColor,
              ),
              SizedBox(
                height: 16,
              ),
              Flexible(
                child: Container(
                  child: RotatedBox(
                    quarterTurns: widget.reversed ? 3 : 1,
                    child: Text(
                      widget.item.iconTitle ?? "",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: widget.item.focusTextColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
