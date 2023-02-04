import 'package:flutter/material.dart';
import 'package:horror_story/models/catalog_item.dart';
import 'package:horror_story/models/story.dart';
import 'package:horror_story/utils/size_manager.dart';
import 'package:intl/intl.dart';

class ItemButton extends StatelessWidget {
  final Story item;
  final Color backgroundColor;
  final Color color;
  final Color detailsColor;
  final VoidCallback onPressed;

  const ItemButton({
    Key key,
    this.item,
    this.color,
    this.backgroundColor,
    this.detailsColor,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return item.catalogType != CatalogType.Future
        ? _renderButton(context, item)
        : Container(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(
                  Icons.lock,
                  color: backgroundColor,
                  size: SizeManager.of(context).transformX(34),
                ),
                SizedBox(
                  width: SizeManager.of(context).transformX(10),
                ),
                Text(
                  DateFormat('MMM. dd').format(DateTime.now()).toUpperCase(),
                  style: TextStyle(
                    color: detailsColor,
                    fontFamily: 'Montserrat',
                    fontSize: SizeManager.of(context).transformX(28),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
  }

  Widget _renderButton(BuildContext context, Story item) {
    var text = item.catalogType == CatalogType.Locked ? 'unlock' : 'read';
    return TextButton(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          item.catalogType == CatalogType.Locked
              ? Icon(
                  Icons.lock,
                  color: color,
                )
              : SizedBox(),
          Text(
            text.toUpperCase(),
            style: TextStyle(
              color: color,
              fontFamily: 'Montserrat',
              fontSize: SizeManager.of(context).transformX(28),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      style: TextButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 18),
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      onPressed: onPressed,
    );
  }
}
