import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final String title;
  final String imgPath;
  final Function onTap;

  CustomCard(
      {@required this.title, @required this.imgPath, @required this.onTap});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      padding: EdgeInsets.symmetric(vertical: 10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.black,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ListTile(
        dense: true,
        onTap: onTap,
        leading: Image.asset(
          imgPath,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: Colors.black,
            fontSize: 21.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
