import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import './welcome_screens/company/companyCreateJob.dart';
import './welcome_screens/company/components/date_picker.dart';

// ignore: must_be_immutable
class Questions extends StatefulWidget {
  // String term;
  // Questions(this.term);
  @override
  _QuestionsState createState() => _QuestionsState();
}

class _QuestionsState extends State<Questions> {
  // String term;
  // _QuestionsState(this.term);
  String _empNeed;
  String _numDays;
  DateTime _inDate;
  String _numHours;
  String _price;


  List rquestions = [
    'How many professionals do You need?', //0
    'When Do you need the professionals in?', //1
    'How many days?', //2
    'How many hours per days?', //3
    'Price per Hour?', //4 //freelaunce questions ended here
    // 'The company has to prepare their own contract',
    // 'How long the contract will be (minimum 1 month)', //5
    // 'Position', //6
    // 'Short explanation about the job or position', //7
    // 'Requirements', //8
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
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  "Required Questions",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 33),
                ),
                SizedBox(
                  height: 50,
                ),
                // questions
                Text(rquestions[0]),
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
                Text(rquestions[1]),

                  CustomDatePicker(
                    onChanged: (DateTime val) {
                      _inDate = val;
                      print('EMP NEED: $_inDate');
                    },
                    question: rquestions[1],
                  ),


                  SizedBox(
                    height: 20,
                  ),

                Text(rquestions[2]),

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
                Text(rquestions[3]),
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
                Text(rquestions[4]),
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
                      MaterialPageRoute(
                        builder: (context) => CreateJob(
                          empNeed: _empNeed,
                          inDate: _inDate,
                          numDays: _numDays,
                          numHours: _numHours,
                          price: _price,
                          // jobType: widget.term,
                        ),
                      ),
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
