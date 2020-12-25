import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:job_application/modals/employeeInfo.dart';
import 'package:job_application/modals/job_applicant.dart';
import 'package:job_application/modals/user_profile.dart';
import 'package:job_application/services/database_service.dart';
import 'package:job_application/services/documents_service.dart';
import 'package:job_application/services/job_service.dart';
import 'package:provider/provider.dart';

class JobViewX extends StatefulWidget {
  @override
  _JobViewXState createState() => _JobViewXState();

  final String cImg;
  final String cname;
  final int cTye;
  final String cLoc;
  final String cTitle;
  final String cDes;
  final String cQualification;
  final String docID;
  final String cId;
  final String bidPrice;
  final bool canApply;
  final int totalEmployees;
  final int neededEmployees;

  JobViewX({
    this.cImg,
    this.cname,
    this.cTye,
    this.cLoc,
    this.cTitle,
    this.cDes,
    this.cQualification,
    this.docID,
    this.cId,
    this.bidPrice,
    this.canApply,
    this.neededEmployees,
    this.totalEmployees,
  });
}

class _JobViewXState extends State<JobViewX> {
  String _cvUrl;
  String _fileName;
  bool _isLoading = false;
  bool _isUploading = false;
  UserProfile _userProfile;

  @override
  void initState() {
    //var user = Provider.of<User>(context, listen: false);
    _getCompanyProfile(widget.cId);
    super.initState();
  }

  _toggleIsLoading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  _toggleIsUpLoading() {
    setState(() {
      _isUploading = !_isUploading;
    });
  }

  _getCompanyProfile(String uId) async {
    _toggleIsLoading();
    _userProfile = await DatabaseService(uId: uId).getUser();
    _toggleIsLoading();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          (_userProfile?.name ?? widget.cname) ?? '',
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
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.black87,
              ),
            )
          : Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  )),
              child: Padding(
                padding: EdgeInsets.all(40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        height: MediaQuery.of(context).size.width * 0.2,
                        width: MediaQuery.of(context).size.width * 0.2,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: _userProfile?.imgUrl == null
                                ? AssetImage('assets/images/mylogo.png')
                                : NetworkImage(_userProfile.imgUrl),
                            fit: BoxFit.fill,
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
                        widget.cTitle,
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
                        _userProfile.name,
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
                                widget.cTye == 0
                                    ? 'LABOR CONTRACT'
                                    : 'FREELANCER',
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
                                '\$${widget.bidPrice}/hr',
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
                      widget?.cQualification ?? '',
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
                                      widget?.cDes ?? '',
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
                            InkWell(
                              onTap: _isUploading
                                  ? null
                                  : () async {
                                      if (widget.canApply) {
                                        try {
                                          var params = await uploadCV(user.uId);
                                          setState(() {
                                            _fileName = params[0];
                                            _cvUrl = params[1];
                                          });
                                        } catch (e) {
                                          Fluttertoast.showToast(
                                              msg: "Failed to upload cv",
                                              backgroundColor:
                                                  Colors.redAccent);
                                        }
                                      } else {
                                        Fluttertoast.showToast(
                                          msg: "Cannot Apply for this job...",
                                          backgroundColor: Colors.redAccent,
                                        );
                                      }
                                    },
                              child: Container(
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
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Center(
                                      child: Text(
                                        _isUploading
                                            ? 'UpLoading...'
                                            : (_fileName ?? "Upload CV"),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        StreamBuilder<bool>(
                          stream: JobService(
                                  uId: user.uId,
                                  companyId: widget.cId,
                                  jId: widget.docID)
                              .isAlreadyApplied(),
                          builder: (ctx, snapshot) {
                            if (snapshot.hasData) {
                              bool canApply = snapshot.data;
                              return Expanded(
                                child: InkWell(
                                  onTap: _isUploading
                                      ? null
                                      : () async {
                                          if (user.uId == widget.cId) {
                                            Fluttertoast.showToast(
                                              msg:
                                                  'Sorry! Job owner cannot apply',
                                              backgroundColor: Colors.redAccent,
                                            );
                                            return;
                                          }
                                          if (widget.canApply && canApply) {
                                            try {
                                              UserProfile userProfile =
                                                  await UserProfile()
                                                      .getUserFromSharedPrefs();
                                              if (_cvUrl != null) {
                                                if (widget.totalEmployees <
                                                    widget.neededEmployees) {
                                                  _toggleIsLoading();
                                                  await JobService(
                                                    jId: widget.docID,
                                                    uId: userProfile.uId,
                                                  ).applyForJob(
                                                    name: userProfile.name,
                                                    email: userProfile.email,
                                                    status: ApplicantStatus
                                                        .PENDING.index,
                                                    jobTitle: widget.cTitle,
                                                    appliedDate:
                                                        Timestamp.now(),
                                                    type: widget.cTye,
                                                    cvLink: _cvUrl ?? '',
                                                    employeeId: userProfile.uId,
                                                    phoneNumber: userProfile
                                                        .mobileNumber,
                                                    companyId: widget.cId,
                                                  );

                                                  await DatabaseService(
                                                    uId: userProfile.uId,
                                                  ).updateEmployeeIdInCompanyProfile(
                                                      jId: widget.docID,
                                                      cId: widget.cId,
                                                      completed: false);
                                                  _toggleIsLoading();
                                                } else {
                                                  Fluttertoast.showToast(
                                                      msg: "No Vacancy Left!!!",
                                                      backgroundColor:
                                                          Colors.yellow);
                                                }
                                              } else {
                                                Fluttertoast.showToast(
                                                    msg: "Please Upload CV!",
                                                    backgroundColor:
                                                        Colors.yellow);
                                              }
                                            } catch (e) {
                                              print(e);
                                              if (_isLoading)
                                                _toggleIsLoading();
                                            }
                                          } else {
                                            Fluttertoast.showToast(
                                                msg: "Already Applied",
                                                backgroundColor: Colors.yellow);
                                          }
                                        },
                                  child: Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: Colors.red[500],
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        getFunctionName(canApply),
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              return Center(
                                child: CircularProgressIndicator(
                                  backgroundColor: Colors.black54,
                                ),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  String getFunctionName(bool canApply) {
    if (!widget.canApply) return "NOT AVAILABLE";
    if (widget.totalEmployees >= widget.neededEmployees)
      return "No Vacancy Left..";
    else if (canApply)
      return "APPLY NOW";
    else
      return 'APPLIED';
  }

  Future<List<String>> uploadCV(String uid) async {
    FilePickerResult result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc'],
    );
    try {
      if (result != null) {
        _toggleIsUpLoading();
        File file = File(result.files.single.path);
        String fileName = result.names[0];
        String url = await DocumentService(uId: uid)
            .savePdf(file.readAsBytesSync(), fileName);
        _toggleIsUpLoading();
        return [fileName, url];
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      _toggleIsUpLoading();
      return null;
    }
  }
}
