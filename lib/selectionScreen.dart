import 'package:flutter/material.dart';
import 'package:job_application/signUp.dart';
import 'CRUD.dart';
import 'companyWelcome.dart';
import 'package:job_application/signIn.dart';

class SelectCategory extends StatefulWidget {
  @override
  _SelectCategoryState createState() => _SelectCategoryState();
}

class _SelectCategoryState extends State<SelectCategory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          ClipPath(
            clipper: WaveClipper1(),
            child: Container(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 40,
                  ),
                  Image.asset(
                    "assets/images/mylogo.png",
                    height: 150,
                  ),
                  SizedBox(
                    height: 20,
                  ),

                ],
              ),
              width: double.infinity,
              height: 300,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Color(0xff000000), Color(0xff000000)])),
            ),
          ),
          Center(
            child: Container(
              margin: EdgeInsets.only(top: 100),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 8.0),
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: ListTile(
                     dense: true,
                      onTap: () {
                        CRUD.type = "Employee";
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignIn()),
                        );
                      },
                      leading: Image.asset(
                        "assets/images/contract.png",
                      ),
                      title: Text('Register As Employee', style: TextStyle(
                        color: Colors.black,
                        fontSize: 21.0,
                        fontWeight: FontWeight.bold,
                      ),),
                    ),
                  ),

                     SizedBox(height: 20,),
                     Container(
                    margin: EdgeInsets.symmetric(horizontal: 8.0),
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black,

                      ),

                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: ListTile(
                      dense: true,
                      onTap: (){
                        CRUD.type = "Company";
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignIn()),
                        );
                      },
                      leading: Image.asset(
                        "assets/images/company.png",
                      ),
                      title: Text('Register As Company', style: TextStyle(
                        color: Colors.black,
                        fontSize: 21.0,
                        fontWeight: FontWeight.bold,
                      ),),
                    ),
                  ),


//                  Row(
//                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                    children: [
//                      Image.asset(
//                        "assets/images/contract.png",
//                        height: 70,
//                      ),
//                      Padding(
//                          padding: EdgeInsets.only(right: 24),
//                          child: Container(
//                            decoration: BoxDecoration(
//                                borderRadius:
//                                    BorderRadius.all(Radius.circular(100)),
//                                color: Colors.black),
//                            child: FlatButton(
//                              child: Text(
//                                "Register As Employee",
//                                style: TextStyle(
//                                    color: Colors.white,
//                                    fontWeight: FontWeight.w700,
//                                    fontSize: 18),
//                              ),
//                              onPressed: () {
//                                CRUD.type = "Employee";
//                                Navigator.push(
//                                  context,
//                                  MaterialPageRoute(
//                                      builder: (context) => SignIn()),
//                                );
//
////    if(email==null||password==null)
////    {
////    print('xxx');
////    Toast.show(
////    "feilds cannot be empty",
////
////    context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM,backgroundColor:Colors.red);
////
////    }
////    else {
////    setState(() {
////    showSpinner = true;
////    });
////    try {
////    final newuser = await _auth.signInWithEmailAndPassword
////    (email: email, password: password);
////    if (newuser != null) {
////    Navigator.push(
////    context,
////    MaterialPageRoute(builder: (context) => wlcm()),
////    );
////    }
////    setState(() {
////    showSpinner = false;
////    });
////    }
////    catch (e) {
////    print(e);
////    setState(() {
////    showSpinner = false;
////    });
////    }
////    }
////
//                              },
//                            ),
//                          )),
//                    ],
//                  ),
//                  SizedBox(
//                    height: 10,
//                  ),
//                  Row(
//                    children: [
//                      Image.asset(
//                        "assets/images/company.png",
//                        height: 70,
//                      ),
//                      Padding(
//                          padding: EdgeInsets.symmetric(horizontal: 32),
//                          child: Container(
//                            decoration: BoxDecoration(
//                                borderRadius:
//                                    BorderRadius.all(Radius.circular(100)),
//                                color: Colors.black),
//                            child: FlatButton(
//                              child: Text(
//                                "Register As Company",
//                                style: TextStyle(
//                                    color: Colors.white,
//                                    fontWeight: FontWeight.w700,
//                                    fontSize: 18),
//                              ),
//                              onPressed: () {
//                                CRUD.type = "Company";
//                                Navigator.push(
//                                  context,
//                                  MaterialPageRoute(
//                                      builder: (context) => SignIn()),
//                                );
//
////    if(email==null||password==null)
////    {
////    print('xxx');
////    Toast.show(
////    "feilds cannot be empty",
////
////    context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM,backgroundColor:Colors.red);
////
////    }
////    else {
////    setState(() {
////    showSpinner = true;
////    });
////    try {
////    final newuser = await _auth.signInWithEmailAndPassword
////    (email: email, password: password);
////    if (newuser != null) {
////    Navigator.push(
////    context,
////    MaterialPageRoute(builder: (context) => wlcm()),
////    );
////    }
////    setState(() {
////    showSpinner = false;
////    });
////    }
////    catch (e) {
////    print(e);
////    setState(() {
////    showSpinner = false;
////    });
////    }
////    }
////
//                              },
//                            ),
//                          )),
//                    ],
//                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
