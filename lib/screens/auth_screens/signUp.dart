import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:job_application/modals/employeeInfo.dart';
import 'package:job_application/screens/auth_screens/signIn.dart';
import 'package:job_application/services/auth_service.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'Components/WaveClipPath.dart';
import 'Components/custom_password_field.dart';
import 'Components/custom_text_fields.dart';

class SignUp extends StatefulWidget {
  final SessionType sessionType;
  SignUp({this.sessionType});
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool showSpinner = false;
  String email;
  String password;
  String cPassword;
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
            PasswordField(
              title: "Confirm Password",
              onChanged: (String value) {
                cPassword = value.trim();
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
                    "Sign Up",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 18),
                  ),
                  onPressed: () async {
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
                        Auth().signUp(email, password, widget.sessionType);
                        Fluttertoast.showToast(
                          msg: "Verification Email Sent.",
                          toastLength: Toast.LENGTH_LONG,
                        );
                        Fluttertoast.showToast(
                          msg: "Successfully Signed Up",
                          toastLength: Toast.LENGTH_LONG,
                        );
                        setState(() {
                          showSpinner = false;
                        });
                      } catch (e) {
                        print(e);

                        Fluttertoast.showToast(
                          msg: 'email address already in use',
                          toastLength: Toast.LENGTH_LONG,
                        );

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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Already have an Account ? ",
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
                        builder: (context) => SignIn(
                          sessionType: widget.sessionType,
                        ),
                      ),
                    );
                  },
                  child: Text(
                    "Sign IN ",
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
}
