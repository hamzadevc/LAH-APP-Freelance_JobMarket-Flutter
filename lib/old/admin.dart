import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
class AdminPanel extends StatefulWidget {
  @override
  _AdminPanelState createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  @override
  Widget build(BuildContext context) {
    return  Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Colors.deepPurple],
          ),
        ),

        child: Padding(
          padding: const EdgeInsets.only(left:8.0),
          child: Column(
mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Admin Portal", style:  GoogleFonts.ubuntuMono(
                textStyle: TextStyle(fontSize: 50
                    ,color: Colors.black),

              ),),

              SizedBox(height: 30,),
              Row(
                children: <Widget>[
                  buildCard("Registered Companies","20",0.2),
                  buildCard("Registered Employees","50",0.5),
                ],
              ),
              Row(
                children: <Widget>[
                  buildCard("Total Jobs offerings","80",0.8),
                  buildCard("Jobs Completed","40",0.4),
                ],
              )

            //         Expanded(
//           child: Container(
//             child: Row(children: <Widget>[
//               Expanded(
//                   child: Card(
//                     color: Colors.white,
//                     child: Container(
//
//                       child: Text("Total Companies"),),
//                   )),
//               Expanded(child: Card(
//                   color: Colors.white,
//                   child: Container(child: Text("Total Employees"),))),
//               Expanded(child: Card(
//
//                   color: Colors.white,
//                   child: Card(
//                       color: Colors.white,
//                       child: Container(child: Text("Total Job Offerings"),)))),
//               Expanded(child: Card(
//                   color: Colors.white,
//                   child: Container(child: Text("Total Jobs Completed "),))),
//
//
//             ],),
//           ),
//         )

          ],),
        ),



    );
  }




  Card buildCard(String title,String number,double percent) {
    return Card(
      margin: EdgeInsets.all(10),
      elevation: 20,
color: Colors.transparent,


      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.indigoAccent, Colors.deepPurple],
              ),
            ),
            height: 200,
            width: 160,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[


//    Image.asset(img
//    ,width: 80,
//    height: 80,
//    ),
                  Text(title, style:  GoogleFonts.ubuntu(
                    textStyle: TextStyle(fontSize: 20
                        ,color: Colors.white,fontWeight: FontWeight.bold),

                  ),),
                  SizedBox(height: 10,),
                  new CircularPercentIndicator(
                    radius: 100.0,
                    lineWidth: 7.0,
                    percent:percent,
                    center: new Text(number,  style:GoogleFonts.pacifico(
                      textStyle: TextStyle(fontSize: 30
                          ,color: Colors.yellow),

                    ),),
                    progressColor: Colors.pink,
                  )
                  ,

                ],),
            ),

          ),
        ),
      ),


    );
  }













}
