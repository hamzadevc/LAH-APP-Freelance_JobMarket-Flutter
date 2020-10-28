import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:job_application/old/Welcome.dart';
import 'package:job_application/old/signUp.dart';
import 'package:job_application/services/auth_service.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'CRUD.dart';
import 'companyWelcome.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool showSpinner = false;
  String email;
  String password;
  final _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    // TODO: implement dispose
    CRUD.fetchProfileData();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    loggedinuser();
    super.initState();
  }

  loggedinuser() async {
    await FirebaseAuth.instance.currentUser().then((firebaseUser) {
      if (firebaseUser == null) {
        //signed out
      } else if (firebaseUser != null) {
        //signed in
        CRUD.myuserid = firebaseUser.uid;
        print(firebaseUser.uid);
        CRUD.AddData();
        if (CRUD.type == "Employee") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Welcome()),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CWelcome()),
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: ListView(
          children: <Widget>[
            Stack(
              children: <Widget>[
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
                        Text("Follow Me "),
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
                  onChanged: (String value) {
                    email = value.trim();
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
                  onChanged: (String value) {
                    password = value.trim();
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
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                    color: Colors.black),
                child: FlatButton(
                  child: Text(
                    "Login",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 18),
                  ),
                  onPressed: () async {
                    if (email == null || password == null) {
                      Fluttertoast.showToast(
                        msg: "Fields cannot be empty",
                      );
                      return;
                    }
                    if (email.contains("@") == false) {
                      print(email.contains("@"));
                      Fluttertoast.showToast(
                        msg: "Email not valid",
                      );
                      return;
                    }

                    if (email != null && password != null) {
                      setState(() {
                        showSpinner = true;
                      });

                      try {
                        FirebaseUser newuser =
                            (await _auth.signInWithEmailAndPassword(
                                    email: email, password: password))
                                .user;

                        Auth().signIn(email, password);///TODO Start From Here....

                        if (newuser != null &&
                            newuser.isEmailVerified == true) {
                          CRUD.email = email;
                          print("sIrddd" + newuser.uid);
                          if (CRUD.type == "Employee") {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Welcome()),
                            );
                          } else {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CWelcome()),
                            );
                          }
                        } else {
                          Fluttertoast.showToast(
                              msg: "Please Verify Your Email.",
                              gravity: ToastGravity.CENTER);
                        }
                        setState(() {
                          showSpinner = false;
                        });
                      } catch (e) {
                        print(e);

                        Fluttertoast.showToast(
                            msg: "Incorrect email or password",
                            gravity: ToastGravity.CENTER);

                        setState(() {
                          showSpinner = false;
                        });
                      }
                    }
                  },
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
                child: InkWell(
                    onTap: () {
                      _asyncInputDialog(context);
                    },
                    child: Text('Forgot Password?'))),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Don't have an Account ? ",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.normal),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignUp()));
                  },
                  child: Text(
                    "Sign Up ",
                    style: TextStyle(
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        decoration: TextDecoration.underline),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<String> _asyncInputDialog(BuildContext context) async {
    String email = '';
    return showDialog<String>(
      context: context,
      barrierDismissible:
          false, // dialog is dismissible with a tap on the barrier
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text(
            'Enter Your Email Address',
            style: TextStyle(color: Colors.black87),
          ),
          content: new Row(
            children: <Widget>[
              new Expanded(
                  child: new TextField(
                style: TextStyle(color: Colors.black87, fontSize: 20),
                cursorColor: Colors.black87,
                keyboardType: TextInputType.emailAddress,
                autofocus: true,
                decoration: new InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black87),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  labelText: 'Email : ',
                  hintText: 'xyz@example.com',
                  hintStyle: TextStyle(color: Colors.grey),
                ),
                onChanged: (value) {
                  email = value;
                },
              ))
            ],
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'Cancel',
              ),
              color: Colors.red,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              color: Colors.green,
              child: Text(
                'Send',
              ),
              onPressed: () {
                if (email != null && email.contains("@")) {
                  final _auth = FirebaseAuth.instance;
                  _auth.sendPasswordResetEmail(email: email).then(
                    (onValue) {
                      Fluttertoast.showToast(
                        msg: "Email Sent",
                        toastLength: Toast.LENGTH_LONG,
                      );
                    },
                  );

                  Navigator.of(context).pop();
                } else {
                  Fluttertoast.showToast(
                    msg: "Email not Valid",
                    toastLength: Toast.LENGTH_LONG,
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }
}
