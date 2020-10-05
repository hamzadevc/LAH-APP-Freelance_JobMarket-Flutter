import 'package:flutter/material.dart';
import 'package:job_application/companyCreateJob.dart';
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
            Text("What Do You Want",style: TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.bold

            ),),

            SizedBox(height: 22,),
            FlatButton(child:


            Text("Freelancer",style: TextStyle(
                color: Colors.white

            ),),

              color: Colors.black,
              onPressed: (){

              }
              ,),
            FlatButton(child:


            Text("Labour",style: TextStyle(
                color: Colors.white

            ),),
              color: Colors.black,
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CreateJob()),
                );
              }
              ,)

          ],),
      ),
    );
  }
}
