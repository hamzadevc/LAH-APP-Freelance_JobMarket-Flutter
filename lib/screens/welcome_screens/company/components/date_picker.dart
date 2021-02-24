import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class CustomDatePicker extends StatefulWidget {
  final Function onChanged;
  final String question;
  CustomDatePicker({this.onChanged, this.question});
  @override
  _CustomDatePickerState createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  String _date;
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      elevation: 4.0,
      onPressed: () {
        DatePicker.showDatePicker(
          context,
          theme: DatePickerTheme(
            containerHeight: 210.0,
          ),
          showTitleActions: true,
          minTime: DateTime.now(),
          maxTime: DateTime(2022, 12, 31),
          onConfirm: (date) {
            print('confirm $date');
            _date = '${date.year} - ${date.month} - ${date.day}';
            setState(() {});
            widget.onChanged(date);
          },
          currentTime: DateTime.now(),
          locale: LocaleType.en,
        );
      },
      child: Container(
        alignment: Alignment.center,
        height: 50.0,
        // width: ,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.date_range,
                        size: 18.0,
                        color: Colors.teal,
                      ),
                      Text(
                        " ${_date ?? widget.question}",
                        style: TextStyle(
                            color: Colors.teal,
                            fontWeight: FontWeight.bold,
                            fontSize: 12.0),
                      ),
                    ],
                  ),
                )
              ],
            ),
            // Icon(
            //   Icons.add,
            //   color: Colors.teal,
            // ),
            // Text(
            //   "  Change",
            //   style: TextStyle(
            //       color: Colors.teal,
            //       fontWeight: FontWeight.bold,
            //       fontSize: 15.0),
            // ),
          ],
        ),
      ),
      color: Colors.white,
    );
  }
}
