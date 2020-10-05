import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
class Questions extends StatefulWidget {
  @override
  _QuestionsState createState() => _QuestionsState();
}

class _QuestionsState extends State<Questions> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.all(20),
          child: Column(

            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

            Text("Required Questions",style: TextStyle(fontWeight: FontWeight.bold,
            fontSize: 33
            ),),
              


              SizedBox(height: 50,),
            Text("What type of job you want"),
            TextField(onChanged: ((value){

            }),
            decoration: InputDecoration(hintText: "Write your answer here ..",
            border: OutlineInputBorder(),prefixIcon: Icon(FontAwesomeIcons.penAlt)

            ),

            ),

            SizedBox(height: 20,),

            Text("What type of job you want"),
              TextField(onChanged: ((value){

              }),
                decoration: InputDecoration(hintText: "Write your answer here ..",
                    border: OutlineInputBorder(),prefixIcon: Icon(FontAwesomeIcons.penAlt)

                ),

              ),
              SizedBox(height: 20,),
            Text("What type of job you want"),
              TextField(onChanged: ((value){

              }),
                decoration: InputDecoration(hintText: "Write your answer here ..",
                    border: OutlineInputBorder(),prefixIcon: Icon(FontAwesomeIcons.penAlt)

                ),

              ),
              SizedBox(height: 20,),
            Text("What type of job you want"),
              TextField(onChanged: ((value){

              }),
                decoration: InputDecoration(hintText: "Write your answer here ..",
                    border: OutlineInputBorder(),prefixIcon: Icon(FontAwesomeIcons.penAlt)

                ),

              ),
              SizedBox(height: 20,),


              Flexible(
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
                      "SUBMIT",
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
    );
  }
}
