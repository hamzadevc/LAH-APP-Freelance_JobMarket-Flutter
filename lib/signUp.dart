import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:job_application/admin.dart';
import 'package:job_application/signIn.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'CRUD.dart';
class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool showSpinner=false;
  String email;
  String password;
  String Cpassword;
  final _auth=FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(


        backgroundColor: Color(0xffffffff),
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: (

              ListView(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
//    ClipPath(
//    clipper: WaveClipper2(),
//    child: Container(
//    child: Column(),
//    width: double.infinity,
//    height: 300,
//    decoration: BoxDecoration(
//    gradient: LinearGradient(
//    colors: [Color(0xffFEDF77), Color(0xffFEDF77)])),
//    ),
//    ),
//    ClipPath(
//    clipper: WaveClipper3(),
//    child: Container(
//    child: Column(),
//    width: double.infinity,
//    height: 300,
//    decoration: BoxDecoration(
//    gradient: LinearGradient(
//    colors: [Color(0xff000000), Color(0xff000000)])),
//    ),
//    ),
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
                              Text(

                                "Follow Me "

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
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32),
                    child: Material(
                      elevation: 4.0,
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      child: TextField(
                        onChanged: (String value){
                          email=value.trim();

                        },
                        cursorColor: Colors.blue,
                        decoration: InputDecoration(
                            hintText: "Email",
                            prefixIcon: Material(
                              elevation: 0,
                              borderRadius: BorderRadius.all(Radius.circular(30)),
                              child: Icon(
                                Icons.email,
                                color: Colors.black,
                              ),
                            ),
                            border: InputBorder.none,
                            contentPadding:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 13)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32),
                    child: Material(
                      elevation: 4.0,
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      child: TextField(
                        obscureText: true,
                        onChanged: (String value){
                          password=value.trim();
                        },
                        cursorColor: Colors.blue,
                        decoration: InputDecoration(
                            hintText: "Password",
                            prefixIcon: Material(
                              elevation: 0,
                              borderRadius: BorderRadius.all(Radius.circular(30)),
                              child: Icon(
                                Icons.lock,
                                color: Colors.black,
                              ),
                            ),
                            border: InputBorder.none,
                            contentPadding:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 13)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32),
                    child: Material(
                      elevation: 4.0,
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      child: TextField(
                        obscureText: true,
                        onChanged: (String value){
                          Cpassword=value.trim();
                        },
                        cursorColor: Colors.blue,
                        decoration: InputDecoration(
                            hintText: "Confirm Password",
                            prefixIcon: Material(
                              elevation: 0,
                              borderRadius: BorderRadius.all(Radius.circular(30)),
                              child: Icon(
                                Icons.lock,
                                color: Colors.black,
                              ),
                            ),
                            border: InputBorder.none,
                            contentPadding:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 13)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),



                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 32),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(100)),
                            color: Colors.black),
                        child: FlatButton(

                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 18),
                          ),
                          onPressed: () async
                          {


                            if (email == null || password == null) {
                              Fluttertoast.showToast(
                                msg: "Fields cannot be empty",
                                toastLength: Toast.LENGTH_LONG,
                              );
                              return;
                            }
                            if (email.contains("@") == false) {
                              print(email.contains("@"));
                              Fluttertoast.showToast(
                                msg: "Email not valid",
                                toastLength: Toast.LENGTH_LONG,
                              );
                              return;
                            }

                            if (email != null && password != null) {
                              setState(() {
                                showSpinner = true;
                              });

                              try {
                                FirebaseUser newuser = (await _auth
                                    .createUserWithEmailAndPassword(
                                    email: email,
                                    password: password))
                                    .user;

                                if (newuser != null) {
                                  try {
                                    await newuser
                                        .sendEmailVerification();
                                    Fluttertoast.showToast(
                                      msg: "Verification Email Sent.",
                                      toastLength: Toast.LENGTH_LONG,
                                    );
                                  } catch (e) {
                                    print(
                                        "An error occured while trying to send email  verification");
                                    print(e.message);
                                  }
                                  CRUD.email = email;

                                  // sendVerificationMail(newuser);
                                  Fluttertoast.showToast(
                                    msg: "Successfully Signed Up",
                                    toastLength: Toast.LENGTH_LONG,
                                  );
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            SignIn()),
                                  );
                                }
                                setState(() {
                                  showSpinner = false;
                                });
                              } catch (e) {
                                print(e);

                                Fluttertoast.showToast(
                                  msg:
                                  'Data not correct or email address already in use',
                                  toastLength: Toast.LENGTH_LONG,
                                );

                                setState(() {
                                  showSpinner = false;
                                });
                              }
                            }



                          },
                        ),
                      )),

                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Already have an Account ? ", style: TextStyle(color:Colors.black,fontSize: 12 ,fontWeight: FontWeight.normal),),
                      GestureDetector
                        (
                          onTap: () {

//                            Navigator.push(
//                                context,
//                                MaterialPageRoute(builder: (context) => SignupScreen()));



                          },

                          child: Text("Sign IN ", style: TextStyle(color:Colors.blueAccent, fontWeight: FontWeight.w500,fontSize: 12, decoration: TextDecoration.underline ))),

                    ],
                  )


                ],
              )),
        ));
  }
}

class WaveClipper1 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0.0, size.height - 50);

    var firstEndPoint = Offset(size.width * 0.6, size.height - 29 - 50);
    var firstControlPoint = Offset(size.width * .25, size.height - 60 - 50);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondEndPoint = Offset(size.width, size.height - 60);
    var secondControlPoint = Offset(size.width * 0.84, size.height - 50);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}