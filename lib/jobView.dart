import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'CRUD.dart';
class JobView extends StatefulWidget {

String cimg;
String cname;
String ctye;
String cloc;
String ctitle;
String cdes;
String cqual;
String docID;
  JobView(this.cimg, this.cname,this.ctye, this.cloc, this.ctitle, this.cdes, this.cqual,
      this.docID);

  @override
  _JobViewState createState() => _JobViewState();
}


class _JobViewState extends State<JobView> {


  String btntxt="Apply";

  String path="sd";
  TextStyle infoStyle=TextStyle(fontSize: 15,fontWeight: FontWeight.bold,
      color: Colors.white);
  TextStyle infoStyle1=TextStyle(fontSize: 15,
      color: Colors.white);

  TextStyle heading=TextStyle(fontSize: 25,fontWeight: FontWeight.bold,
      color: Colors.black);


@override
  void initState() {
    // TODO: implement initState


check();

  super.initState();
  }
  @override
  Widget build(BuildContext context) {



    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      bottomNavigationBar: Padding(

        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        child: FlatButton(

          splashColor: Colors.blueAccent,
          shape:   RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          onPressed: ()
          {

ApplyForJob();

//            Navigator.push(
//              context,
//              MaterialPageRoute(builder: (context) => JobView()),
//            );
          },
          color: Colors.black,
          child:
          Text(btntxt,style: infoStyle,),
        ),
      ),
      body: Column(


        children: <Widget>[
          Stack(
            children: <Widget>[

              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.black, Colors.black],
                  ),
                ),
              height:230,
              ),

              Positioned.fill(
top: 50,
                child: Align(

alignment: Alignment.center,
                  child: Column(
                    children: <Widget>[
                      CircleAvatar(


                        child:

                        Image.network(widget.cimg),
                      radius: 50,
                        backgroundColor: Colors.transparent,


                      ),

SizedBox(height: 20,),
                      Row(

                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[

                        Text("Type",style: infoStyle1,),
                        Text("Level",style: infoStyle1),
                        Text("Location",style: infoStyle1),
                      ],),

                      SizedBox(height: 5,),
                      Row(

                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[

                        Text(widget.ctye,style: infoStyle),
                        Text("Entry",style: infoStyle,),
                        Text(widget.cloc,style: infoStyle),
                      ],),





                    ],



                  ),
                ),
              )
,
Positioned(
  left: 20,
  top: 40,
  child:   Align(

      alignment: Alignment.bottomLeft,
      child: InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          child: Icon(FontAwesomeIcons.arrowLeft,color: Colors.white,))),
)

            ],
          ),


Padding(
  padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 20),
  child:   Container(
    height: MediaQuery.of(context).size.height/2,
    child: ListView(
physics: BouncingScrollPhysics(),
      children: <Widget>[

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: <Widget>[

            Text(widget.cname,style: heading,),
            SizedBox(height: 8,),
            Text(widget.ctitle,style: TextStyle(
              fontWeight: FontWeight.bold
            ),),
            SizedBox(height: 12,),
            Text("Description",style: heading,),
            SizedBox(height: 8,),
            Text(widget.cdes),
            SizedBox(height: 8,),
            Text("Qualifications",style: heading,),
            SizedBox(height: 8,),
            Text(widget.cqual),


            SizedBox(height: 15,),
            Row(
              children: <Widget>[

                Text("Upload Your CV",style: TextStyle(color: Colors.indigo,

                fontWeight: FontWeight.bold

                ),),


                IconButton(
                  tooltip: "Upload Your CV",
                  icon: Icon(FontAwesomeIcons.upload),
                  onPressed: (){

                    uploadCV();


                  }
                  ,
                  color: Colors.indigoAccent,
                ),



              ],
            ),

            Text(path,),
            SizedBox(height: 5,),
            Row(
              children: <Widget>[

                Text("Add Your Medical test",style: TextStyle(color: Colors.indigo,

                    fontWeight: FontWeight.bold

                ),),


                IconButton(
                  tooltip: "Add report",
                  icon: Icon(FontAwesomeIcons.idCard),
                  onPressed: (){}
                  ,
                  color: Colors.indigoAccent,
                ),




              ],
            )

          ],),




      ],



    ),
  ),
)
,


        ],
      ),
    );
  }

  void uploadCV() async{


    FilePickerResult result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: [ 'pdf', 'doc'],
    );

    if(result != null)  {
      File file = File(result.files.single.path);

      setState(() {
        path=file.toString();
      });

    }
  }

  void ApplyForJob() async{


    final QuerySnapshot resultQuery=await Firestore.instance.collection("jobs").document(widget.docID)
        .collection("Applicants").where('employee_id',isEqualTo: CRUD.myuserid).getDocuments();

    final List<DocumentSnapshot> documentSnapshot=resultQuery.documents;

    print(documentSnapshot.length);

    if(documentSnapshot.length==0)
    {

      Firestore.instance.collection("jobs").document(widget.docID)
          .collection("Applicants").document()
          .setData({

        'employee_id':CRUD.myuserid,
        'employee_name':CRUD.name,
        'email':CRUD.email,
        'phone_number':CRUD.mobileNumber,
         'employee_CV':""


      }).then((value) {

        print('data added');

      }).catchError((onError){

        print('Failed to add data');

      });

    }
else{
  setState(() {
    btntxt="Applied";
  });
    }







  }

  void check() async{


    final QuerySnapshot resultQuery=await Firestore.instance.collection("jobs").document(widget.docID)
        .collection("Applicants").where('employee_id',isEqualTo: CRUD.myuserid).getDocuments();

    final List<DocumentSnapshot> documentSnapshot=resultQuery.documents;

    if(documentSnapshot.length!=0)
      {

        setState(() {
          btntxt="Applied";
        });

      }


  }
}

    