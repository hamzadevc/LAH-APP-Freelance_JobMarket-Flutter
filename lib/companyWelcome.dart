import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:job_application/CRUD.dart';
import 'package:job_application/companyCategory.dart';
import 'package:job_application/companyCreateJob.dart';
import 'package:job_application/jobView.dart';

import 'package:job_application/customDrawer.dart';

class CWelcome extends StatefulWidget {
  @override
  _CWelcomeState createState() => _CWelcomeState();
}

class _CWelcomeState extends State<CWelcome> {

  bool isSearch=false;
  GlobalKey<ScaffoldState> key1 = GlobalKey<ScaffoldState>();
  TextStyle Companystyle=TextStyle(fontSize: 25,fontWeight: FontWeight.bold);
  TextStyle jobTitlestyle=TextStyle(fontSize: 18,
      color: Colors.blueAccent,fontWeight: FontWeight.bold);
  TextStyle infoStyle=TextStyle(fontSize: 15,fontWeight: FontWeight.bold,
      color: Colors.white);



  @override
  void initState() {
    // TODO: implement initState
    CRUD.fetchProfileData();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    print(CRUD.type);
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          key: key1,
          drawer: CustomDrawer.buildDrawer(context),
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(100.0),
            child: AppBar(

              backgroundColor: Colors.black,
//              actions: <Widget>[
//                isSearch?
//                Padding(
//                  padding: const EdgeInsets.only(right:8.0),
//                  child: Align(
//                    alignment: Alignment.centerLeft,
//
//                    child: IconButton(
//                      onPressed: (){
//                        setState(() {
//
//                          isSearch=false;
//
//                        });
//
//                      },
//                      icon: new FaIcon(
//
//                        FontAwesomeIcons.timesCircle,),
//                    ),
//                  ),
//                ):
//                Padding(
//                  padding: const EdgeInsets.only(right:8.0),
//                  child: Align(
//                    alignment: Alignment.centerLeft,
//
//                    child: IconButton(
//                      onPressed: (){
//                        setState(() {
//
//                          isSearch=true;
//
//
//                        });
//
//                      },
//                      icon: new FaIcon(
//
//                        FontAwesomeIcons.search,),
//                    ),
//                  ),
//                )
//
//
//
//
//
//              ],



              leading: Padding(
                padding: const EdgeInsets.only(top: 18.0),
                child: IconButton(
                  onPressed: () {
                    key1.currentState.openDrawer();
                  },
                  icon: Icon(Icons.dehaze),
                ),
              ),

//            appBar: PreferredSize(
//              preferredSize: Size.fromHeight(65.0),
//              child: AppBar(
//                leading: Padding(
//                  padding: const EdgeInsets.only(top: 18.0),
//                  child: IconButton(
//                    onPressed: () {
//                      key1.currentState.openDrawer();
//                    },
//                    icon: ImageIcon(
//                      AssetImage("assets/images/menu.png"),
//                      size: 30,
//                      color: Colors.white,
//                    ),
//                  ),
//                ),
//                title: Padding(
//                  padding: const EdgeInsets.only(top: 18.0),
//                  child: Text(
//                    "Read Nomi",
//                    style: TextStyle(
//                        color: Colors.white,
//                        fontWeight: FontWeight.bold,
//                        fontSize: 22),
//                  ),
//                ),
//                centerTitle: true,
//                backgroundColor: Color(0xff0087E3),
//                actions: <Widget>[
//                  GestureDetector(
//                    onTap: () {
//                      CRUD.logOut();
//                      Navigator.pushNamed(context, '/signin');
//                    },
//                    child: Padding(
//                      padding: const EdgeInsets.only(top: 25.0),
//                      child: Text(AppLocalizations.of(context).translate('logout'),
//                          style: TextStyle(color: Colors.white, fontSize: 18)),
//                    ),
//                  ),
//                  SizedBox(
//                    width: 5,
//                  ),
//                  Padding(
//                    padding: const EdgeInsets.only(right: 4.0, top: 20),
//                    child: ImageIcon(
//                      AssetImage(
//                        "assets/images/right_arrow.png",
//                      ),
//                      size: 12,
//                      color: Colors.red,
//                    ),
//                  )
//                ],
//              ),
//            ),
              bottom: TabBar(
                tabs: <Widget>[
                  Tab(
                    child: Row(
                      children: <Widget>[
                        Icon(FontAwesomeIcons.male, color: Colors.white),
                        SizedBox(width: 10,),
                        Text('Applicants ', style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                  Tab(
                    child: Row(
                      children: <Widget>[
                        Icon(FontAwesomeIcons.briefcase, color: Colors.white),
                        SizedBox(width: 10,),
                        Text('Our Jobs', style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                ],
              ),

              title: !isSearch? Text("LAH App",style: TextStyle(
                  fontFamily: 'Spicy Rice'
              ),

              ):Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: TextField(
                  onChanged:(value){
                    // myfilter(value);

                  } ,
                  style: TextStyle(color: Colors.white,fontSize: 18),

                  decoration: InputDecoration(hintText:"Search Jobs",hintStyle:TextStyle(
                      color: Colors.white
                  ),
                    icon: new Icon(Icons.search,color: Colors.white,),

                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white70),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),



                ),
              )

              ,centerTitle: true,

            ),


          ),

          body: TabBarView(
            children: <Widget>[
              StreamBuilder(
    stream:  Firestore.instance.collection("jobs")//.where('c_id',arrayContains: CRUD.myuserid)
        .snapshots(),
    builder: (context, snapshot) {
      if (snapshot.hasData ) {
print("ultaaaassaa  "+snapshot.data.documents.length.toString());



     for (int index = 0; index < snapshot.data.documents.length; index++) {
      String title = snapshot.data.documents[index]['job_title'];
      String cid = snapshot.data.documents[index]['c_id'];

      String docid=snapshot.data.documents[index].documentID;

      print(snapshot.data.documents[index]['job_title']);
     // print(snapshot.data.documents[1]['job_title']);
      //print(cid);
    //  print(docid);

      if(cid!=null)
      {
        return StreamBuilder(
              stream:  Firestore.instance.collection("jobs").document(docid).collection('Applicants')
                  .snapshots(),
              builder: (context, snapshot) {

                print("333ultaaaassaa"+snapshot.data.documents.length.toString());


                if (snapshot.hasData) {

                  return ListView.builder(

//           separatorBuilder: (context, index) {
//             return Divider();
//           },
                      padding: EdgeInsets.all(10),
                      physics: BouncingScrollPhysics(),
                      itemCount:snapshot.data.documents.length,
                      itemBuilder: (BuildContext ctxt, int index) {
                        String applicantName = snapshot.data.documents[index]['employee_name'];

                        return ListTile(
                          title: Text(applicantName),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(title),

                              Row(

                                children: <Widget>[

                                  Expanded(

                                    child:   FlatButton(child: Text('Accept',
                                      style: TextStyle(color: Colors.white),),
                                      onPressed: ()
                                      {

                                      },
                                      color: Colors.grey,
                                    ),
                                  ),

                                  SizedBox(width: 5,),
                                  Expanded(
                                    child:   FlatButton(child: Text('Decline',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                      onPressed: ()
                                      {

                                      },
                                      color: Colors.red,
                                    ),
                                  ),

                                  SizedBox(width: 5,),

                                  Expanded(
                                    child:   FlatButton(child: Text('Mark As Complete',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                      onPressed: ()
                                      {

                                      },
                                      color: Colors.black87,
                                    ),
                                  ),

                                ],)

                            ],),
                          trailing: Icon(Icons.message),
                        );
                      }

                  );
                }

                 return Text('No Applicant');



              }

          );
      }

return Container();
    }




      }

else
  {
    return CircularProgressIndicator();
  }


return Container();
    }
              ),

              Stack(children: <Widget>[






                StreamBuilder(
    stream:  Firestore.instance.collection("jobs").where('c_id',isEqualTo: CRUD.myuserid)
        .snapshots(),
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        return ListView.builder(
            padding: EdgeInsets.all(10),
            physics: BouncingScrollPhysics(),
        itemCount: snapshot.data.documents.length,
    itemBuilder: (BuildContext ctxt, int index) {

      String title = snapshot.data.documents[index]['job_title'];
      String type = snapshot.data.documents[index]['type'];


      return JobCard(title,type);
    }





        );
      }

      else{
        return Center(
          child: Text('LOADING',
            style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),

          ),
        );
      }

    }


                ),

                Padding(
                  padding: const EdgeInsets.only(bottom:30,right: 20),
                  child: Align(

                    alignment: Alignment.bottomRight,
                    child: FloatingActionButton(
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => CompanyCategory()),
                        );
                      },
tooltip: "Add New Job",
elevation: 10,
                      child:

                    Icon(FontAwesomeIcons.pen),

                      backgroundColor: Colors.blue,
                    ),
                  ),
                ),


              ],)



            ],
          ),
        ),
      ),
    );
  }

  Widget JobCard(title,type) {
    return Container(
      height: MediaQuery.of(context).size.height/3.9,
      //padding: EdgeInsets.only(top: 100,bottom: 100),
      padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 6),
      child: Card(

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        color: Colors.white.withOpacity(0.88),
        elevation: 5,
        child: Column(
//crossAxisAlignment: CrossAxisAlignment.start,
// crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[

            Text(CRUD.name,style: Companystyle,
              textAlign: TextAlign.left,),
            SizedBox(height: 8,),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(

                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Container(
                      child: Text(title,style: jobTitlestyle,


                      ),
                    ),
                  ),

                  Expanded(
                    flex: 1,
                    child: Container(
                      child: CircleAvatar(child:
                      Image.network(CRUD.imgUrl),
                        radius: 25,
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                  )

                ],
              ),
            ),
            SizedBox(height: 5,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Type ",style: TextStyle(

                    color: Colors.black87

                ),


                ),

                Text(" |  "),


                Text(type,textAlign: TextAlign.left,)
              ],),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Expanded(
                    flex: 0,
                    child: Icon(FontAwesomeIcons.userTie,color: Colors.black,)),
                Expanded(

                  child: Text("Applicants : 6",
                    style: TextStyle(color: Colors.deepPurple,fontWeight: FontWeight.bold),

                  ),
                ),
//                Flexible(
//
//                  child: FlatButton(
//                    splashColor: Colors.blueAccent,
//                    shape:   RoundedRectangleBorder(
//                      borderRadius: BorderRadius.circular(15.0),
//                    ),
//                    onPressed: ()
//                    {
////                      Navigator.push(
////                        context,
////                        MaterialPageRoute(builder: (context) => JobView()),
////                      );
//                    },
//                    color: Colors.black,
//                    child:
//                    Text("Edit ",style: infoStyle,),
//                  ),
//                ),


                Flexible(

                  child:

                  Icon(FontAwesomeIcons.trash, color:
                    Colors.purple
                    ,)
                )
              ],
            )

          ],
        ),
      ),
    );
  }
}
