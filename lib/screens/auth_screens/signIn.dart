import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:job_application/modals/employeeInfo.dart';
import 'package:job_application/screens/auth_screens/signUp.dart';
import 'package:job_application/services/auth_service.dart';
import 'package:job_application/services/database_service.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../../modals/user_profile.dart';
import 'Components/WaveClipPath.dart';
import 'Components/custom_password_field.dart';
import 'Components/custom_text_fields.dart';

class SignIn extends StatefulWidget {
  final SessionType sessionType;
  SignIn({this.sessionType});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool showSpinner = false;
  String email;
  String password;

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
                WaveClipPath(),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            CustomTextField(
              title: "Email",
              onChanged: (String value) {
                email = value.trim();
              },
            ),
            SizedBox(
              height: 20,
            ),
            PasswordField(
              title: "Password",
              onChanged: (String value) {
                password = value.trim();
              },
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
                        User user = await Auth()
                            .signIn(email, password, widget.sessionType);
                        // Save User Data in Shared Prefs
                        if(user != null) {
                          UserProfile userProfile =
                          await DatabaseService(uId: user?.uId).getUser();
                          await userProfile.saveUserInSharedPrefs();
                        }else{
                          Fluttertoast.showToast(
                              msg: "Email is not registered.",
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
                        setState(
                          () {
                            showSpinner = false;
                          },
                        );
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
                child: Text('Forgot Password?'),
              ),
            ),
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignUp(
                          sessionType: widget.sessionType,
                        ),
                      ),
                    );
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
