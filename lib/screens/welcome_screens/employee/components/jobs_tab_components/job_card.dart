import 'package:flutter/material.dart';
import 'package:job_application/modals/employeeInfo.dart';
import 'package:job_application/modals/job.dart';
import 'package:job_application/modals/user_profile.dart';
import 'package:job_application/screens/welcome_screens/employee/components/jobs_tab_components/jobViewX.dart';
import 'package:job_application/services/database_service.dart';
import 'package:job_application/services/job_service.dart';
import 'package:provider/provider.dart';

class JobCard extends StatefulWidget {
  final String jId;
  final String cId;

  JobCard({this.cId, this.jId});
  @override
  _JobCardState createState() => _JobCardState();
}

class _JobCardState extends State<JobCard> {
  Job _job;
  UserProfile _userProfile;
  UserProfile _companyProfile;
  DatabaseService _databaseService;
  bool _isLoading = false;

  TextStyle companyStyle = TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
  TextStyle jobTitleStyle = TextStyle(
      fontSize: 18, color: Colors.blueAccent, fontWeight: FontWeight.bold);
  TextStyle infoStyle =
      TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white);

  @override
  void initState() {
    var user = Provider.of<User>(context, listen: false);
    _getJobDetail(user.uId);
    super.initState();
  }

  _toggleLoading() {
    if(mounted) {
      setState(() {
        _isLoading = !_isLoading;
      });
    }
  }

  _getJobDetail(String uid) async {
    _toggleLoading();
    _job = await JobService(jId: widget.jId, companyId: widget.cId).getJob();
    _databaseService = DatabaseService(uId: uid);
    _userProfile = await _databaseService.getUser();
    _companyProfile = await DatabaseService(uId: widget.cId).getUser();
    _toggleLoading();
  }

  String _getType(int type) {
    if (type == 0)
      return 'LABOR CONTRACT';
    else
      return 'FREELANCER';
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(
            child: Text(''),
          )
        : Container(
            //padding: EdgeInsets.only(top: 100,bottom: 100),
            padding: const EdgeInsets.only(left: 15, right: 15, bottom: 5),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              color: Colors.white,
              elevation: 5,
              child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    Text(
                      _userProfile?.name ?? '',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Expanded(
                            flex: 2,
                            child: Container(
                              child: Text(
                                _job?.title ?? '',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.blueAccent,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              child: CircleAvatar(
                                child: _companyProfile?.imgUrl == null
                                    ? Image.asset('assets/images/mylogo.png')
                                    : Image.network(_companyProfile?.imgUrl),
                                radius: 25,
                                backgroundColor: Colors.transparent,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Type ",
                          style: TextStyle(color: Colors.black87),
                        ),
                        Text(" |  "),
                        Text(
                          _getType(_job?.type ?? 0),
                          textAlign: TextAlign.left,
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        StreamBuilder<int>(
                          stream: JobService(jId: _job.id)
                              .getCountFromJobApplicantsStream(_job.type),
                          builder: (ctx, snapshot) {
                            return Flexible(
                              child: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                child: Text(
                                  "Applicants : ${snapshot.data ?? 0}",
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            );
                          },
                        ),
                        Flexible(
                          child: FlatButton(
                            splashColor: Colors.blueAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => JobViewX(
                                    cImg: _userProfile?.imgUrl ?? '',
                                    cname: _userProfile?.name ?? '',
                                    cTye: _job?.type ?? 0,
                                    cLoc: _job?.location ?? '',
                                    cTitle: _job?.title ?? '',
                                    cDes: _job?.description ?? '',
                                    cQualification: _job?.qualifications ?? '',
                                    docID: _job?.id ?? '',
                                    cId: _job?.companyId ?? '',
                                    bidPrice: _job?.bidPrice ?? '',
                                    canApply: _job.status < 1,
                                    neededEmployees: int.parse(_job?.limit ?? '0'),
                                    totalEmployees: _job.allApplicants?.length ?? 0,
                                  ),
                                ),
                              );
                            },
                            color: Colors.black,
                            child: Text(
                              "view",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
