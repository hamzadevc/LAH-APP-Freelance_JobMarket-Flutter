import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'CRUD.dart';
class JobViewX extends StatefulWidget {
  @override
  _JobViewXState createState() => _JobViewXState();


  String cimg;
  String cname;
  String ctye;
  String cloc;
  String ctitle;
  String cdes;
  String cqual;
  String docID;
  JobViewX(this.cimg, this.cname,this.ctye, this.cloc, this.ctitle, this.cdes, this.cqual,
      this.docID);

}

class _JobViewXState extends State<JobViewX> {

  String btntxt="Apply Now";

  @override
  void initState() {
    // TODO: implement initState


    check();

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(widget.cname
         ,
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50),
              topRight: Radius.circular(50),
            )
        ),
        child: Padding(
          padding: EdgeInsets.all(40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Center(
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(widget.cimg),
                      fit: BoxFit.fitWidth,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: 32,
              ),

              Center(
                child: Text(
                 widget.ctitle,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              SizedBox(
                height: 16,
              ),

              Center(
                child: Text(
                  widget.cloc,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
              ),

              SizedBox(
                height: 32,
              ),

              Row(
                children: [

                  Expanded(
                    child: Container(
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          widget.ctye,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),

                  Expanded(
                    child: Container(
                      child: Center(
                        child: Text(
                          r"$" + "75" + "/h",
                          style: TextStyle(
                            fontSize: 36,
                          ),
                        ),
                      ),
                    ),
                  ),

                ],
              ),

              SizedBox(
                height: 32,
              ),

              Text(
                "Qualifications",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(
                height: 16,
              ),

              Expanded(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          children: [

                            Container(
                              width: 4,
                              height: 4,
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                shape: BoxShape.circle,
                              ),
                            ),

                            SizedBox(
                              width: 16,
                            ),

                            Flexible(
                              child: Text(
                                widget.cdes,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                ),
                              ),
                            ),

                          ],
                        ),
                      ),

                      Container(
                        height: 45,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            Icon(FontAwesomeIcons.fileUpload),
                            SizedBox(width: 20,),

                            Center(
                              child: Text(
                                "Upload CV",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                    ],
                  ),
                ),
              ),

              SizedBox(
                height: 16,
              ),

              Row(
                children: [

                  Container(
                    height: 60,
                    width: 60,
                    child: Center(
                      child: Icon(
                        Icons.favorite_border,
                        size: 28,
                      ),
                    ),
                  ),

                  SizedBox(
                    width: 16,
                  ),

                  Expanded(
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.red[500],
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          btntxt,
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

            ],
          ),
        ),
      ),
    );
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
