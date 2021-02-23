import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class CustomDate extends StatefulWidget {
  final Function onChanged;
  final String question;
  CustomDate({this.onChanged, this.question});
  @override
  _CustomDateState createState() => _CustomDateState();
}

class _CustomDateState extends State<CustomDate> {
  String _date;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Material(
        elevation: 4.0,
        borderRadius: BorderRadius.all(Radius.circular(30)),
        child: InkWell(
            onTap: () {
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
              // mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.date_range,
                          // size: 18.0,
                          color: Colors.black,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            " ${_date ?? widget.question}",
                            style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                                // fontSize: 12.0
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
            ),
            // color: Colors.white,
          ),
      ),
    );
  }
}
