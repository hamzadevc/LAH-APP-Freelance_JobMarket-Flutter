import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:job_application/old/companyCreateJob.dart';
class Questions extends StatefulWidget {
  @override
  _QuestionsState createState() => _QuestionsState();
}

class _QuestionsState extends State<Questions> {


  List questions=[
    'How many employees do You need?',
    'Write Date that you need the employee in?',
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

              Text("Required Questions",style: TextStyle(fontWeight: FontWeight.bold,
              fontSize: 33
              ),),
                


                SizedBox(height: 50,),
              Text(questions[0]),
              TextField(onChanged: ((value){

              }),
              decoration: InputDecoration(hintText: "Write your answer here ..",
              border: OutlineInputBorder(),prefixIcon: Icon(FontAwesomeIcons.penAlt)

              ),

              ),

              SizedBox(height: 20,),


                Text(questions[1]),
                TextField(onChanged: ((value){

                }),
                  decoration: InputDecoration(hintText: "Write your answer here ..",
                      border: OutlineInputBorder(),prefixIcon: Icon(FontAwesomeIcons.penAlt)

                  ),

                ),
                SizedBox(height: 20,),


              Text(questions[2]),
                TextField(onChanged: ((value){

                }),
                  decoration: InputDecoration(hintText: "Write your answer here ..",
                      border: OutlineInputBorder(),prefixIcon: Icon(FontAwesomeIcons.penAlt)

                  ),

                ),
                SizedBox(height: 20,),
              Text(questions[3]),
                TextField(onChanged: ((value){

                }),
                  decoration: InputDecoration(hintText: "Write your answer here ..",
                      border: OutlineInputBorder(),prefixIcon: Icon(FontAwesomeIcons.penAlt)

                  ),

                ),
                SizedBox(height: 20,),
              Text(questions[4]),
                TextField(onChanged: ((value){

                }),
                  decoration: InputDecoration(hintText: "Write your answer here ..",
                      border: OutlineInputBorder(),prefixIcon: Icon(FontAwesomeIcons.penAlt)

                  ),

                ),
                SizedBox(height: 20,),


                InkWell(
                  onTap: ()
                  {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CreateJob()),
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

              ],),
          ),
        ),
      ),
    );
  }
}
