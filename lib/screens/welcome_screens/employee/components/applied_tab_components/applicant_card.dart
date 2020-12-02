import 'package:flutter/material.dart';
import 'package:job_application/modals/employeeInfo.dart';
import 'package:job_application/modals/job.dart';
import 'package:job_application/modals/job_applicant.dart';
import 'package:job_application/modals/user_profile.dart';
import 'package:job_application/screens/welcome_screens/employee/components/viewJobDetails.dart';
import 'package:job_application/services/database_service.dart';
import 'package:job_application/services/job_service.dart';
import 'package:provider/provider.dart';

class ApplicantCard extends StatefulWidget {
  final String jId;
  final String cId;
  final String title;
  final int type;
  final int status;

  ApplicantCard({
    this.status,
    this.cId,
    this.type,
    this.jId,
    this.title,
  });
  @override
  _ApplicantCardState createState() => _ApplicantCardState();
}

class _ApplicantCardState extends State<ApplicantCard> {
  Job _job;
  UserProfile _userProfile;
  UserProfile _jobProfile;
  JobApplicant _applicant;
  bool _isLoading = false;

  @override
  void initState() {
    var user = Provider.of<User>(context, listen: false);
    _getJobDetail(user.uId, widget.cId);
    super.initState();
  }

  _toggleLoading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  _getJobDetail(String uid, String cId) async {
    _toggleLoading();
    _job = await JobService(jId: widget.jId, companyId: widget.cId).getJob();
    _applicant =
        await JobService(jId: widget.jId, companyId: widget.cId, uId: uid)
            .getJobApplicant();
    _userProfile = await DatabaseService(uId: uid).getUser();
    _jobProfile = await DatabaseService(uId: cId).getUser();
    _toggleLoading();
  }

  String _getStatus(int status) {
    if (status == 0) return 'PENDING';
    if (status == 1) return 'PROCESSING';
    if (status == 2)
      return 'REJECTED';
    else
      return 'COMPLETED';
  }

  Color _getStatusColor(int status) {
    if (status == 0) return Colors.deepOrangeAccent;
    if (status == 1) return Colors.yellowAccent;
    if (status == 2)
      return Colors.redAccent;
    else
      return Colors.green;
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(
            child: Text(''),
          )
        : InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ViewJob(
                    jId: widget.jId,
                    cId: widget.cId,
                    status: widget.status,
                    title: _job.title,
                    cName: _userProfile.name,
                    description: _job.description,
                    location: _job.location,
                    qualification: _job.qualifications,
                    type: _job.type,
                    uImgUrl: _userProfile.imgUrl,
                    empReviewed: _applicant?.isEmployeeReviewed ?? false,
                    compReviewed: _applicant?.isCompanyReviewed ?? false,
                    acceptTime: _applicant.acceptTime,
                    numDays: int.parse(_job.numDays),
                  ),
                ),
              );
            },
            child: Container(
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.symmetric(vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: _jobProfile?.imgUrl == null
                                ? AssetImage('assets/images/mylogo.png')
                                : NetworkImage(_jobProfile?.imgUrl),
                            fit: BoxFit.fitWidth,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 22,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.title,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                // widget.type == 0 ? 'CONTRACT' : 'FREELANCER',
                                _jobProfile?.name ?? '',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Icon(
                        Icons.more_vert,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              _getStatus(
                                widget.status,
                              ),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: _getStatusColor(
                                  widget.status,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: Center(
                            child: Text(
                              '\$ ${_job?.bidPrice ?? 0} /h', // add bid price here
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
  }
}
