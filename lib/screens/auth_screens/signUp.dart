import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../modals/employeeInfo.dart';
import '../../modals/user_profile.dart';
import '../../screens/auth_screens/Components/check_box.dart';
import '../../screens/auth_screens/signIn.dart';
import '../../services/auth_service.dart';
import '../../services/database_service.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'Components/WaveClipPath.dart';
import 'Components/custom_password_field.dart';
import 'Components/custom_text_fields.dart';
import 'Components/doc_pdf_view.dart';
import 'Components/date_picker_dob.dart';

class SignUp extends StatefulWidget {
  final SessionType sessionType;
  SignUp({this.sessionType});
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  var key = GlobalKey<FormState>();
  bool showSpinner = false;
  bool termsOfUse = false;
  bool privacyPolicy = false;
  String email;
  String password;
  String cPassword;
  String name;
  String sname;
  String number;
  String address;
  String ibn;
  String bank;
  String dob;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      backgroundColor: Color(0xffffffff),
      body: Form(
        key: key,
        child: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: ListView(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  WaveClipPath(),
                ],
              ),
              CustomTextField(
                inputType: TextInputType.name,
                title: "First Name",
                icon: Icons.person,
                onChanged: (String value) {
                  name = value;
                },
                validator: (String value) {
                  if (value.isEmpty) {
                    return '*Required';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 20,
              ),
              CustomTextField(
                inputType: TextInputType.name,
                title: "Last Name",
                icon: Icons.person,
                onChanged: (String value) {
                  sname = value;
                },
                validator: (String value) {
                  if (value.isEmpty) {
                    return '*Required';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 20,
              ),
              CustomTextField(
                inputType: TextInputType.emailAddress,
                title: "Email",
                icon: Icons.email,
                onChanged: (String value) {
                  email = value.trim();
                },
                validator: (String value) {
                  if (value.isEmpty) {
                    return '*Required';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 20,
              ),
              CustomTextField(
                inputType: TextInputType.number,
                title: "Phone Number",
                icon: Icons.phone,
                onChanged: (String value) {
                  number = value;
                },
              ),
              SizedBox(
                height: 20,
              ),
              CustomTextField(
                inputType: TextInputType.text,
                title: "Address",
                icon: Icons.home,
                onChanged: (String value) {
                  address = value;
                },
                validator: (String value) {
                  if (value.isEmpty) {
                    return '*Required';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 20,
              ),
              CustomDate(
                onChanged: (DateTime val) {
                    dob = val.toString();
                },
                question: 'Date of Birth',
              ),
              SizedBox(height:  20,),
              CustomTextField(
                inputType: TextInputType.number,
                title: "IBAN or Bank Account Number",
                icon: Icons.confirmation_number,
                onChanged: (String value) {
                  ibn = value;
                },
                validator: (String value) {
                  if (value.isEmpty) {
                    return '*Required';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 20,
              ),
              CustomTextField(
                inputType: TextInputType.text,
                title: "Bank Name",
                icon: Icons.business_center,
                onChanged: (String value) {
                  bank = value;
                },
                validator: (String value) {
                  if (value.isEmpty) {
                    return '*Required';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 25,
              ),
              PasswordField(
                inputType: TextInputType.text,
                title: "Password",
                onChanged: (String value) {
                  password = value.trim();
                },
                validator: (String value) {
                  if (value.isEmpty) {
                    return '*Required';
                  }
                  return null;
                },
              ),
              CheckboxField(
                onChanged: (val) {
                  setState(() {
                    termsOfUse = val;
                  });
                },
                value: termsOfUse,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) => PDFView(
                        path: 'assets/documents/app-terms.pdf',
                      ),
                    ),
                  );
                },
                title: Text(
                  'Terms of Use.',
                  style: TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              CheckboxField(
                onChanged: (val) {
                  setState(() {
                    privacyPolicy = val;
                  });
                },
                value: privacyPolicy,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) => PDFView(
                        path: 'assets/documents/privacy-policy.pdf',
                      ),
                    ),
                  );
                },
                title: Text(
                  'Privacy Policy.',
                  style: TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
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
                    onPressed: (privacyPolicy && termsOfUse)
                        ? () async {
                            if (key.currentState.validate()) {
                              key.currentState.save();
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
                                  User user = await Auth().signUp(
                                    name,
                                    sname,
                                    email,
                                    number,
                                    '',
                                    address,
                                    dob,
                                    ibn,
                                    bank,
                                    password, '', '', '',
                                    widget.sessionType,
                                    '','','','','','',
                                  );
                                  Fluttertoast.showToast(
                                    msg: "Verification Email Sent.",
                                    toastLength: Toast.LENGTH_LONG,
                                  );
                                  if (user != null) {
                                    UserProfile userProfile =
                                        await DatabaseService(uId: user?.uId)
                                            .getUser();
                                    await userProfile.saveUserInSharedPrefs();
                                    Navigator.of(context).pop();
                                  } else {
                                    Fluttertoast.showToast(
                                        msg: "Email is not registered.",
                                        gravity: ToastGravity.CENTER);
                                  }
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
                            }
                          }
                        : null,
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
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
