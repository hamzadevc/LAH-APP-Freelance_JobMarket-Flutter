import 'package:flutter/material.dart';
class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        decoration: new BoxDecoration(
            gradient: new LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.indigoAccent, Colors.deepPurple],
            )),
          child: new ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  //=========================================
                  // Profile Image With Camera Icon & Name
                  //=========================================
                  GestureDetector(

                      onTap:(){
//                        Navigator.push(
//                          context,
//                          MaterialPageRoute(builder: (context) => editInfo()),
//                        );
                      },
                      child: Icon(Icons.edit,color: Colors.white,)),
                  Container(
                    height: 250.0,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 20.0),
                          child: Stack(
                              fit: StackFit.loose,
                              alignment: AlignmentDirectional.center,
                              children: <Widget>[
                                //================
                                //Profile Image
                                //================
                                _buildProfileImage(),

                                //=============
                                //Camera Icon
                                //=============
                                Padding(
                                    padding:
                                    EdgeInsets.only(top: 100.0, right: 90.0),
                                    child: new Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        GestureDetector(
                                          onTap:(){
                                           // chooseFile();
                                            setState(() {
                                          //    showSpinner = false;
                                            });

                                          },

                                          child: new CircleAvatar(

                                            backgroundColor: Colors.grey,
                                            radius: 20.0,
                                            child: new Icon(
                                              Icons.camera_alt,
                                              color: Colors.white,
                                              size: 20,
                                            ),
                                          ),
                                        )
                                      ],
                                    )),
                              ]),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 30),
                          child: Text("Moin Khan",style: TextStyle(fontSize: 20,color: Colors.white)),
                        ),
                      ],
                    ),
                  ),


                  Divider(height: 5,color: Colors.grey,),
                  //=============
                  //     Info
                  //=============
                  Container(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 25.0),
                      child:  Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 25.0),
                              child: Text(
                                  'E-Mail',
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,color: Colors.white)
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 6.0),
                              child:  Text("moinkhan603@gmail.com",  style: TextStyle(
                                  color: Colors.white))),

                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 25.0),
                              child: Text(
                                  '923065217552',
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,color: Colors.white)
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 6.0),
                              child:  Text("555333666",  style: TextStyle(
                                  color: Colors.white))),

                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 25.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      child: new Text(
                                        'Country',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,color: Colors.white),
                                      ),
                                    ),
                                    flex: 2,
                                  ),
                                  Expanded(
                                    child: Container(
                                      child: new Text(
                                        'City',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,color: Colors.white),
                                      ),
                                    ),
                                    flex: 2,
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 2.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      child: new Text("Pakistan",  style: TextStyle(
                                          color: Colors.white),),
                                    ),
                                    flex: 2,
                                  ),
                                  Expanded(
                                    child: Container(
                                      child: new Text("Islamabad",  style: TextStyle(
                                          color: Colors.white)),
                                    ),
                                    flex: 2,
                                  ),
                                ],
                              )),
                        ],
                      ),
                    ),
                  ),


                  //===================
                  //Bottom Section
                  //===================



                ],
              ),
            ],
          ),
        ),

    );
  }


  _buildProfileImage() {
    return Container(
        width: 140.0,
        height: 140.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(width: 4, color: Colors.grey),
          image: DecorationImage(
            image: NetworkImage("https://image.flaticon.com/icons/png/512/0/93.png"),
            fit: BoxFit.cover,
          ),
        ));
  }

}
