import 'package:flutter/material.dart';

class CheckboxField extends StatelessWidget {
  final Text title;
  final Function onTap;
  final Function onChanged;
  final bool value;

  CheckboxField({
    this.title,
    this.onTap,
    this.onChanged,
    this.value,
  });

  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        title: GestureDetector(
          onTap: onTap,
          child: title,
        ),
        trailing: Checkbox(
          onChanged: onChanged,
          value: value,
        ),
      ),
    );
  }
}
