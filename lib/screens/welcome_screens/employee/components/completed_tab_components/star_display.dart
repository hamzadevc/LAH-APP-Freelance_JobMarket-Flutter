import 'package:flutter/material.dart';

class StarDisplay extends StatelessWidget {
  final double value;
  final Color color;
  const StarDisplay({Key key, this.value = 0, this.color = Colors.yellowAccent})
      : assert(value != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Icon(
          index < value ? Icons.star : Icons.star_border,
          color: color,
        );
      }),
    );
  }
}
