import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:job_application/screens/welcome_screens/company/companyCreateJob.dart';
import 'package:job_application/screens/welcome_screens/company/components/date_picker.dart';

class Questions extends StatefulWidget {
  @override
  _QuestionsState createState() => _QuestionsState();
}

class _QuestionsState extends State<Questions> {

  String _empNeed;
  String _numDays;
  Timestamp _inDate;
  String _numHours;
  String _price;

  List questions = [
    'How many employees do You need?',
    'WHen Do you need the employee in?',
    'How many days?',
    'How many hours per days?',
    'Price per Hour?'
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Required Questions",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 33),
                ),
                SizedBox(
                  height: 50,
                ),
                Text(questions[0]),
                TextField(
                  keyboardType: TextInputType.number,
                  onChanged: ((value) {
                    _empNeed = value;
                  }),
                  decoration: InputDecoration(
                      hintText: "Write your answer here ..",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(FontAwesomeIcons.penAlt)),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(questions[1]),
                CustomDatePicker(
                  onChanged: (val){
                    _inDate = val;
                  },
                  question: questions[1],
                ),
                SizedBox(
                  height: 20,
                ),
                Text(questions[2]),
                TextField(
                  keyboardType: TextInputType.number,
                  onChanged: ((value) {
                    _numDays = value;
                  }),
                  decoration: InputDecoration(
                      hintText: "Write your answer here ..",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(FontAwesomeIcons.penAlt)),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(questions[3]),
                TextField(
                  onChanged: ((value) {
                    _numHours = value;
                  }),
                  decoration: InputDecoration(
                      hintText: "Write your answer here ..",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(FontAwesomeIcons.penAlt)),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(questions[4]),
                TextField(
                  onChanged: ((value) {
                    _price = value;
                  }),
                  decoration: InputDecoration(
                      hintText: "Write your answer here ..",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(FontAwesomeIcons.penAlt)),
                ),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CreateJob(
                        empNeed: _empNeed,
                        inDate: _inDate,
                        numDays: _numDays,
                        numHours: _numHours,
                        price: _price,
                      )),
                    );
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.red[500],
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "NEXT",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
