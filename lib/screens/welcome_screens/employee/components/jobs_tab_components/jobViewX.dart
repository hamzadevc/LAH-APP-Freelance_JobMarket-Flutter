import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:job_application/modals/employeeInfo.dart';
import 'package:job_application/modals/job_applicant.dart';
import 'package:job_application/modals/user_profile.dart';
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
  });
}

class _JobViewXState extends State<JobViewX> {
  String _cvUrl;
  String _fileName;
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
          widget.cname,
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
      body: Container(
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
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(widget.cImg),
                      fit: BoxFit.fitWidth,
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
                  widget.cLoc,
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
                          widget.cTye == 0 ? 'CONTRACT' : 'FREELANCER',
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
                widget.cQualification,
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
                                widget.cDes,
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
                        onTap: () async {
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
                                  backgroundColor: Colors.redAccent);
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
                                  _fileName ?? "Upload CV",
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
                children: <Widget>[
                  StreamBuilder<bool>(
                    stream: JobService(uId: user.uId, companyId: widget.cId)
                        .isAlreadyApplied(),
                    builder: (ctx, snapshot) {
                      return Expanded(
                        child: InkWell(
                          onTap: () async {
                            if (widget.canApply) {
                              UserProfile userProfile =
                                  await UserProfile().getUserFromSharedPrefs();
                              if (!snapshot.data) {
                                if (_cvUrl != null) {
                                  await JobService(
                                          jId: widget.docID,
                                          uId: userProfile.uId)
                                      .applyForJob(
                                    name: userProfile.name,
                                    email: userProfile.email,
                                    status: ApplicantStatus.PENDING.index,
                                    jobTitle: widget.cTitle,
                                    appliedDate: Timestamp.now(),
                                    type: widget.cTye,
                                    cvLink: _cvUrl ?? '',
                                    employeeId: userProfile.uId,
                                    phoneNumber: userProfile.mobileNumber,
                                  );
                                } else {
                                  Fluttertoast.showToast(
                                      msg: "Please Upload CV!",
                                      backgroundColor: Colors.yellow);
                                }
                              }
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
                                widget.canApply
                                    ? (snapshot.data ? "APPLIED" : "APPLY NOW")
                                    : "NOT AVAILABLE",
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

  Future<List<String>> uploadCV(String uid) async {
    FilePickerResult result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc'],
    );
    if (result != null) {
      File file = File(result.files.single.path);
      String fileName = result.names[0];
      String url = await DocumentService(uId: uid)
          .savePdf(file.readAsBytesSync(), fileName);
      return [fileName, url];
    } else {
      return null;
    }
  }
}
