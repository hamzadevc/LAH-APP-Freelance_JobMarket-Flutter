import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String title;
  final Function onChanged;
  final TextEditingController controller;
  final IconData icon;
  final Function validator;
  final TextInputType inputType;

  CustomTextField(
      {@required this.title,
      @required this.icon,
      @required this.onChanged,
      @required this.inputType,
      this.validator,
      this.controller});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 32),
      child: Material(
        elevation: 4.0,
        borderRadius: BorderRadius.all(Radius.circular(30)),
        child: TextFormField(
          keyboardType: inputType,
          controller: controller,
          onChanged: onChanged,
          validator: validator,
          cursorColor: Colors.blue,
          decoration: InputDecoration(
              hintText: title,
              prefixIcon: Material(
                elevation: 0,
                borderRadius: BorderRadius.all(Radius.circular(30)),
                child: Icon(
                  icon,
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
