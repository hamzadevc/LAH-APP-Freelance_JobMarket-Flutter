import 'package:flutter/material.dart';
import 'package:job_application/selectionScreen.dart';
class LanguageSelect extends StatefulWidget {
  @override
  _LanguageSelectState createState() => _LanguageSelectState();
}

class _LanguageSelectState extends State<LanguageSelect> {
  @override
  Widget build(BuildContext context) {
    return

      Scaffold(
backgroundColor: Colors.grey.shade300,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
          Text("Select Language",style: TextStyle(
            color: Colors.black,
            fontSize: 25,
            fontWeight: FontWeight.bold

          ),),

          SizedBox(height: 22,),
          FlatButton(child:


          Text("Polish",style: TextStyle(
              color: Colors.white

          ),),

color: Colors.black,
            onPressed: (){

            }
            ,),
          FlatButton(child:


          Text("English",style: TextStyle(
              color: Colors.white

          ),),
            color: Colors.black,
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SelectCategory()),
              );
            }
            ,)

        ],),
      ),
    );
  }
}
