import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String title;
  final Function onChanged;
  final TextEditingController controller;

  CustomTextField(
      {@required this.title, @required this.onChanged, this.controller});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 32),
      child: Material(
        elevation: 4.0,
        borderRadius: BorderRadius.all(Radius.circular(30)),
        child: TextField(
          controller: controller,
          onChanged: onChanged,
          cursorColor: Colors.blue,
          decoration: InputDecoration(
              hintText: title,
              prefixIcon: Material(
                elevation: 0,
                borderRadius: BorderRadius.all(Radius.circular(30)),
                child: Icon(
                  Icons.email,
                  color: Colors.black,
                ),
              ),
              border: InputBorder.none,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 25, vertical: 13)),
        ),
      ),
    );
  }
}