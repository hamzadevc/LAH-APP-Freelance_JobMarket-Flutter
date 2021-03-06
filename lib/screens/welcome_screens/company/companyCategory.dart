import 'package:flutter/material.dart';
import '../../questions.dart';

categoryDialog(BuildContext context) {
  showDialog(
      useSafeArea: true,
      useRootNavigator: true,
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Center(
            child: Text(
              "Choose the type of contract",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 23,
                  fontWeight: FontWeight.bold),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FlatButton(
                child: Text(
                  "Short Term",
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.black,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Questions(),
                    ),
                  );
                },
              ),
              FlatButton(
                child: Text(
                  "Long Term",
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.black,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Questions(),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      });
}
