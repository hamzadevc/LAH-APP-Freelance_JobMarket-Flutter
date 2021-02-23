import 'package:flutter/material.dart';

class PasswordField extends StatelessWidget {
  final String title;
  final Function onChanged;
  final TextEditingController controller;
  final Function validator;

  PasswordField(
      {this.controller, 
      @required this.validator,
      @required this.title, 
      @required this.onChanged});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 32),
      child: Material(
        elevation: 4.0,
        borderRadius: BorderRadius.all(Radius.circular(30)),
        child: TextFormField(
          controller: controller,
          obscureText: true,
          onChanged: onChanged,
          validator: validator,
          cursorColor: Colors.blue,
          decoration: InputDecoration(
              hintText: title,
              prefixIcon: Material(
                elevation: 0,
                borderRadius: BorderRadius.all(Radius.circular(30)),
                child: Icon(
                  Icons.lock,
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
