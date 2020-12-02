import 'package:flutter/material.dart';
import 'package:job_application/modals/employeeInfo.dart';
import 'package:job_application/modals/job.dart';
import 'package:job_application/modals/user_profile.dart';
import 'package:job_application/services/database_service.dart';
import 'package:job_application/services/job_service.dart';
import 'package:provider/provider.dart';

import 'jobViewX.dart';

class RecommendedForYou extends StatefulWidget {
  @override
  _RecommendedForYouState createState() => _RecommendedForYouState();
}

class _RecommendedForYouState extends State<RecommendedForYou> {
  bool _isLoading = false;
  UserProfile _userProfile;
  @override
  void initState() {
    var user = Provider.of<User>(context, listen: false);
    _getSessionType(user.uId);
    super.initState();
  }

  _toggleIsLoading() {
    if (mounted) {
      setState(() {
        _isLoading = !_isLoading;
      });
    }
  }

  _getSessionType(String uId) async {
    _toggleIsLoading();
    _userProfile = await UserProfile(uId: uId).getUserFromSharedPrefs();
    if (_userProfile == null)
      _userProfile = await DatabaseService(uId: uId).getUser();
    _toggleIsLoading();
  }

  _getTypeFunction(String uId) {
    if (_isLoading) return JobService(uId: uId).getAllJobStream();
    if (_userProfile?.sessionType == 0)
      return JobService(uId: uId).getContractJobsStream();
    else
      return JobService(uId: uId).getFreelanceJobsStream();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return _isLoading
        ? Text('')
        : StreamBuilder<List<Job>>(
            stream: JobService(uId: user.uId).getAllJobStream(),
            builder: (context, snapshot) {
              List<Job> jobs = snapshot.data;
              if (snapshot.hasData) {
                return Container(
                  height: 150,
                  margin: EdgeInsets.only(left: 10.0),
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: jobs.length,
                    itemBuilder: (BuildContext ctx, int index) {
                      return jobs.isEmpty
                          ? Container(
                              child: Text(
                                "No Job Found...",
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          : (jobs[index].status == 2
                              ? Text('')
                              : GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => JobViewX(
                                          cId: jobs[index].companyId,
                                          bidPrice: jobs[index].bidPrice,
                                          cDes: jobs[index].description,
                                          cQualification:
                                              jobs[index].qualifications,
                                          cLoc: jobs[index].location,
                                          cTitle: jobs[index].title,
                                          cTye: jobs[index].type,
                                          docID: jobs[index].id,
                                          canApply: jobs[index].status < 1,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    width: 200,
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                    padding: EdgeInsets.all(14),
                                    margin: EdgeInsets.only(right: 14),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            StreamBuilder<UserProfile>(
                                              stream: DatabaseService(
                                                      uId:
                                                          jobs[index].companyId)
                                                  .getUserStream(),
                                              builder: (ctx, snapshot) {
                                                UserProfile userProfile =
                                                    snapshot.data;
                                                return Container(
                                                  height: 60,
                                                  width: 60,
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: userProfile == null
                                                          ? AssetImage(
                                                              'assets/images/mylogo.png')
                                                          : NetworkImage(
                                                              userProfile
                                                                  ?.imgUrl),
                                                      fit: BoxFit.fitWidth,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(10),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                            SizedBox(
                                              width: 6.0,
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                color: Colors.grey[200],
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(10),
                                                ),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 12,
                                                  vertical: 4,
                                                ),
                                                child: Text(
                                                  jobs[index].type == 0
                                                      ? 'LABOR CONTRACT'
                                                      : 'FREELANCER',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 10,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              jobs[index].title,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12,
                                                color: Colors.white,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            Text(
                                              '\$${jobs[index].bidPrice}/hr',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ));
                    },
                  ),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.black87,
                  ),
                );
              }
            },
          );
  }
}
