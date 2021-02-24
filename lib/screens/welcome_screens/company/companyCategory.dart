import 'package:flutter/material.dart';
import './companyCreateJob.dart';
import '../../../screens/questions.dart';

class CompanyCategory extends StatefulWidget {
  @override
  _CompanyCategoryState createState() => _CompanyCategoryState();
}

class _CompanyCategoryState extends State<CompanyCategory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Text(
                "Choose the type of contract",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 23,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 22,
            ),
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
            )
          ],
        ),
      ),
    );
  }
}
