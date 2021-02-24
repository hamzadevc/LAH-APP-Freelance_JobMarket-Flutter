import 'dart:io';
import '../welcome_screens/employee/components/completed_tab_components/star_display.dart';
import '../../modals/employeeInfo.dart';
import '../../services/database_service.dart';
import 'package:path/path.dart' as Path;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import '../../modals/user_profile.dart';

class EditProfile extends StatefulWidget {
  SessionType sessionType;
  EditProfile(this.sessionType);
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile>
    with SingleTickerProviderStateMixin {
  bool showSpinner = false;
  bool _static = true;
  String _name;
  String _email;
  String _mobileNumber;
  String _imgUrl;
  String _address;
  String _dob;
  String _accountNo;
  String _bank;
  int _type;
  String _secondNumber;
  String _nip;
  String _krs;
  String _rperson;
  // FocusNode myFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return Scaffold(
      body: StreamBuilder<UserProfile>(
        stream: DatabaseService(uId: user.uId).getUserStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserProfile userProfile = snapshot.data;
            return ModalProgressHUD(
              inAsyncCall: showSpinner,
              child: Container(
                color: Colors.grey.shade300,
                child: ListView(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Container(
                          height: 250.0,
                          color: Colors.grey.shade300,
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(top: 20.0),
                                child: Stack(
                                  fit: StackFit.loose,
                                  children: <Widget>[
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                            width: 140.0,
                                            height: 140.0,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                image: userProfile?.imgUrl ==
                                                        null
                                                    ? AssetImage(
                                                        'assets/images/mylogo.png')
                                                    : NetworkImage(
                                                        userProfile.imgUrl),
                                                fit: BoxFit.cover,
                                              ),
                                            )),
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: 90.0, right: 100.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          CircleAvatar(
                                            backgroundColor: Colors.black,
                                            radius: 25.0,
                                            child: InkWell(
                                              onTap: () {
                                                chooseFile(user.uId);
                                              },
                                              child: Icon(
                                                Icons.camera_alt,
                                                color: Colors.white,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    'Rating ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5.0,
                                  ),
                                  StarDisplay(
                                    value: double.parse(
                                        userProfile?.avgRating ?? '0.0'),
                                    color: Colors.black,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        Container(
                          color: Colors.grey.shade300,
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 25.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: 25.0, right: 25.0, top: 25.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Text(
                                              'Personal Information',
                                              style: TextStyle(
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            _static
                                                ? _getEditIcon()
                                                : Container(),
                                          ],
                                        )
                                      ],
                                    )),
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: 25.0, right: 25.0, top: 25.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Text(
                                              'Name',
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )),
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: 25.0, right: 25.0, top: 2.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        Flexible(
                                          child: TextField(
                                            controller: TextEditingController()
                                              ..text = userProfile.name,
                                            onChanged: (value) {
                                              _name = value;
                                              print(value);
                                            },
                                            decoration: const InputDecoration(
                                              hintText: "Enter Your Name",
                                            ),
                                            enabled: false,
                                            // autofocus: !_static,
                                          ),
                                        ),
                                      ],
                                    )),
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: 25.0, right: 25.0, top: 25.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Text(
                                              'Email ID',
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )),
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: 25.0, right: 25.0, top: 2.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        Flexible(
                                          child: TextField(
                                            controller: TextEditingController()
                                              ..text = userProfile.email,
                                            onChanged: (value) {
                                              _email = value;
                                            },
                                            decoration: const InputDecoration(
                                                hintText: "Enter Email ID"),
                                            enabled: false,
                                          ),
                                        ),
                                      ],
                                    )),
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: 25.0, right: 25.0, top: 25.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Text(
                                              'Mobile',
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )),
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: 25.0, right: 25.0, top: 2.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        Flexible(
                                          child: TextField(
                                            controller: TextEditingController()
                                              ..text = userProfile.mobileNumber,
                                            onChanged: (value) {
                                              _mobileNumber = value;
                                            },
                                            decoration: const InputDecoration(
                                                hintText:
                                                    "Enter Mobile Number"),
                                            enabled: !_static,
                                          ),
                                        ),
                                      ],
                                    )),
                                if (widget.sessionType == SessionType.COMPANY)
                                  Padding(
                                      padding: EdgeInsets.only(
                                          left: 25.0, right: 25.0, top: 25.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: <Widget>[
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Text(
                                                'Secondary Mobile Number',
                                                style: TextStyle(
                                                    fontSize: 16.0,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )),
                                if (widget.sessionType == SessionType.COMPANY)
                                  Padding(
                                      padding: EdgeInsets.only(
                                          left: 25.0, right: 25.0, top: 2.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: <Widget>[
                                          Flexible(
                                            child: TextField(
                                              controller:
                                                  TextEditingController()
                                                    ..text = userProfile.phone2,
                                              onChanged: (value) {
                                                _secondNumber = value;
                                              },
                                              decoration: const InputDecoration(
                                                  hintText:
                                                      "Enter Secondary Mobile Number"),
                                              enabled: !_static,
                                            ),
                                          ),
                                        ],
                                      )),
                                if (widget.sessionType == SessionType.EMPLOYEE)
                                  Padding(
                                      padding: EdgeInsets.only(
                                          left: 25.0, right: 25.0, top: 25.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: <Widget>[
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Text(
                                                'AGE',
                                                style: TextStyle(
                                                    fontSize: 16.0,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )),
                                if (widget.sessionType == SessionType.EMPLOYEE)
                                  Padding(
                                      padding: EdgeInsets.only(
                                          left: 25.0, right: 25.0, top: 2.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: <Widget>[
                                          Flexible(
                                            child: TextField(
                                              controller:
                                                  TextEditingController()
                                                    ..text = userProfile.dob,
                                              keyboardType:
                                                  TextInputType.number,
                                              onChanged: (value) {
                                                _dob = value;
                                              },
                                              decoration: const InputDecoration(
                                                  hintText: "E.g 18"),
                                              enabled: false,
                                            ),
                                          ),
                                        ],
                                      )),
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: 25.0, right: 25.0, top: 25.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Text(
                                              'Address',
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )),
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: 25.0, right: 25.0, top: 2.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        Flexible(
                                          child: TextField(
                                            controller: TextEditingController()
                                              ..text = userProfile.address,
                                            onChanged: (value) {
                                              _address = value;
                                            },
                                            decoration: const InputDecoration(
                                                hintText: "Enter Address"),
                                            enabled: false,
                                          ),
                                        ),
                                      ],
                                    )),
                                if (widget.sessionType == SessionType.EMPLOYEE)
                                  Padding(
                                      padding: EdgeInsets.only(
                                          left: 25.0, right: 25.0, top: 25.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: <Widget>[
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Text(
                                                'Bank Name',
                                                style: TextStyle(
                                                    fontSize: 16.0,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )),
                                if (widget.sessionType == SessionType.EMPLOYEE)
                                  Padding(
                                      padding: EdgeInsets.only(
                                          left: 25.0, right: 25.0, top: 2.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: <Widget>[
                                          Flexible(
                                            child: TextField(
                                              controller:
                                                  TextEditingController()
                                                    ..text = userProfile.bank,
                                              onChanged: (value) {
                                                _bank = value;
                                              },
                                              decoration: const InputDecoration(
                                                  hintText: "Bank Name"),
                                              enabled: false,
                                            ),
                                          ),
                                        ],
                                      )),
                                if (widget.sessionType == SessionType.EMPLOYEE)
                                  Padding(
                                      padding: EdgeInsets.only(
                                          left: 25.0, right: 25.0, top: 25.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: <Widget>[
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Text(
                                                'IBAN or Bank Account Number',
                                                style: TextStyle(
                                                    fontSize: 16.0,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )),
                                if (widget.sessionType == SessionType.EMPLOYEE)
                                  Padding(
                                      padding: EdgeInsets.only(
                                          left: 25.0, right: 25.0, top: 2.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: <Widget>[
                                          Flexible(
                                            child: TextField(
                                              controller:
                                                  TextEditingController()
                                                    ..text =
                                                        userProfile.accountNo,
                                              onChanged: (value) {
                                                _accountNo = value;
                                              },
                                              decoration: const InputDecoration(
                                                  hintText: "Account No"),
                                              enabled: false,
                                            ),
                                          ),
                                        ],
                                      )),
                                if (widget.sessionType == SessionType.COMPANY)
                                  Padding(
                                      padding: EdgeInsets.only(
                                          left: 25.0, right: 25.0, top: 25.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: <Widget>[
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Text(
                                                'NIP',
                                                style: TextStyle(
                                                    fontSize: 16.0,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )),
                                if (widget.sessionType == SessionType.COMPANY)
                                  Padding(
                                      padding: EdgeInsets.only(
                                          left: 25.0, right: 25.0, top: 2.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: <Widget>[
                                          Flexible(
                                            child: TextField(
                                              controller:
                                                  TextEditingController()
                                                    ..text = userProfile.nip,
                                              onChanged: (value) {
                                                _nip = value;
                                              },
                                              decoration: const InputDecoration(
                                                  hintText: "NIP"),
                                              enabled: false,
                                            ),
                                          ),
                                        ],
                                      )),
                                if (widget.sessionType == SessionType.COMPANY)
                                  Padding(
                                      padding: EdgeInsets.only(
                                          left: 25.0, right: 25.0, top: 25.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: <Widget>[
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Text(
                                                'KRS',
                                                style: TextStyle(
                                                    fontSize: 16.0,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )),
                                if (widget.sessionType == SessionType.COMPANY)
                                  Padding(
                                      padding: EdgeInsets.only(
                                          left: 25.0, right: 25.0, top: 2.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: <Widget>[
                                          Flexible(
                                            child: TextField(
                                              controller:
                                                  TextEditingController()
                                                    ..text = userProfile.krs,
                                              onChanged: (value) {
                                                _krs = value;
                                              },
                                              decoration: const InputDecoration(
                                                  hintText: "KRS"),
                                              enabled: false,
                                            ),
                                          ),
                                        ],
                                      )),
                                if (widget.sessionType == SessionType.COMPANY)
                                  Padding(
                                      padding: EdgeInsets.only(
                                          left: 25.0, right: 25.0, top: 25.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: <Widget>[
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Text(
                                                'Responsible Person',
                                                style: TextStyle(
                                                    fontSize: 16.0,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )),
                                if (widget.sessionType == SessionType.COMPANY)
                                  Padding(
                                      padding: EdgeInsets.only(
                                          left: 25.0, right: 25.0, top: 2.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: <Widget>[
                                          Flexible(
                                            child: TextField(
                                              controller:
                                                  TextEditingController()
                                                    ..text =
                                                        userProfile.resPerson,
                                              onChanged: (value) {
                                                _rperson = value;
                                              },
                                              decoration: const InputDecoration(
                                                  hintText:
                                                      "Responsible Person"),
                                              enabled: false,
                                            ),
                                          ),
                                        ],
                                      )),
                                !_static
                                    ? Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 45.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Expanded(
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    right: 10.0),
                                                child: Container(
                                                  child: RaisedButton(
                                                    child: Text("Save"),
                                                    textColor: Colors.white,
                                                    color: Colors.green,
                                                    onPressed: () async {
                                                      await DatabaseService(
                                                              uId: userProfile
                                                                  .uId)
                                                          .updateUser(
                                                        name: _name ?? userProfile.name,
                                                        imgUrl: _imgUrl ?? userProfile.imgUrl,
                                                        dob: _dob ?? userProfile.dob,
                                                        mobileNumber: _mobileNumber ?? userProfile.mobileNumber,
                                                        address: _address ?? userProfile.address,
                                                        email: _email ?? userProfile.email,
                                                        type: _type ??userProfile.sessionType,
                                                        bank: _bank ?? userProfile.bank,
                                                        nip:  _nip ?? userProfile.nip,
                                                        krs: _krs ?? userProfile.krs,
                                                        phone2: _secondNumber ?? userProfile.phone2,
                                                        resPerson: _rperson ?? userProfile.resPerson,

                                                      );
                                                      Fluttertoast.showToast(
                                                          msg: "Data Updated");

                                                      setState(() {
                                                        _static = true;
                                                        FocusScope.of(context)
                                                            .requestFocus(
                                                                FocusNode());
                                                      });
                                                    },
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20.0),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              flex: 2,
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding:
                                                    EdgeInsets.only(left: 10.0),
                                                child: Container(
                                                  child: RaisedButton(
                                                    child: Text("Cancel"),
                                                    textColor: Colors.white,
                                                    color: Colors.red,
                                                    onPressed: () {
                                                      setState(() {
                                                        _static = true;
                                                        FocusScope.of(context)
                                                            .requestFocus(
                                                                FocusNode());
                                                      });
                                                    },
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20.0)),
                                                  ),
                                                ),
                                              ),
                                              flex: 2,
                                            ),
                                          ],
                                        ),
                                      )
                                    : Container(),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    //myFocusNode.dispose();
    super.dispose();
  }

  Widget _getEditIcon() {
    return GestureDetector(
      child: CircleAvatar(
        backgroundColor: Colors.black,
        radius: 14.0,
        child: Icon(
          Icons.edit,
          color: Colors.white,
          size: 16.0,
        ),
      ),
      onTap: () {
        setState(
          () {
            _static = false;
          },
        );
      },
    );
  }

  void chooseFile(String uId) async {
    ImagePicker imagePicker = ImagePicker();
    PickedFile selected =
        await imagePicker.getImage(source: ImageSource.gallery);

    File img = File(selected.path);

    setState(() {
      showSpinner = true;
    });

    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('Recent/$uId/${Path.basename(selected.path)}}');
    StorageUploadTask uploadTask = storageReference.putFile(img);
    await uploadTask.onComplete;
    print('File Uploaded');
    storageReference.getDownloadURL().then(
      (fileURL) async {
        setState(() {
          showSpinner = false;
        });

        await DatabaseService(uId: uId).updateUserProfileImageLink(
          imgUrl: fileURL,
        );
      },
    );
  }
}
