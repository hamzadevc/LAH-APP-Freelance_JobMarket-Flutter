import 'package:flutter/material.dart';

class MaterialButtonShape extends StatelessWidget {
  const MaterialButtonShape({
    Key key,
    this.width,
    this.height,
    this.text,
    this.icon,
    this.color,
    this.textColor,
    this.iconColor,
    this.iconSize = 30,
    this.onClick,
  }) : super(key: key);

  final double width;
  final double height;
  final String text;
  final IconData icon;
  final Color color;
  final Color textColor;
  final Color iconColor;
  final double iconSize;
  final Function onClick;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Container(
        width: width,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  offset: Offset(0.0, 20.0),
                  blurRadius: 30.0,
                  color: Colors.black12)
            ],
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(22.0),
                topLeft: Radius.circular(42.0),
                bottomRight: Radius.circular(22.0),
                bottomLeft: Radius.circular(42.0))),
        child: Row(
          children: <Widget>[
            Container(
              height: height,
              width: width - 45.0,
              alignment: Alignment.center,
              //padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
              child: Text(
                '${text}',
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    .apply(color: textColor),
              ),
              decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(42.0),
                      topLeft: Radius.circular(42.0),
                      bottomRight: Radius.circular(width))),
            ),
            Icon(
              icon,
              size: iconSize,
              color: iconColor,
            )
          ],
        ),
      ),
    );
  }
}