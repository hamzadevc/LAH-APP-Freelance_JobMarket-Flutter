import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:job_application/modals/employeeInfo.dart';
import 'package:job_application/modals/job.dart';
import 'package:job_application/modals/job_applicant.dart';
import 'package:job_application/modals/user_profile.dart';
import 'package:job_application/customDrawer.dart';
import 'package:job_application/screens/welcome_screens/company/components/applicant_view.dart';
import 'package:job_application/services/database_service.dart';
import 'package:job_application/services/job_service.dart';
import 'package:provider/provider.dart';
import 'companyCategory.dart';

class CWelcome extends StatefulWidget {
  @override
  _CWelcomeState createState() => _CWelcomeState();
}

class _CWelcomeState extends State<CWelcome> {
  bool isSearch = false;
  bool _isLoading = false;
  UserProfile _userProfile;
  GlobalKey<ScaffoldState> key1 = GlobalKey<ScaffoldState>();
  TextStyle companyStyle = TextStyle(fontSize: 25, fontWeight: FontWeight.bold);
  TextStyle jobTitleStyle = TextStyle(
      fontSize: 18, color: Colors.blueAccent, fontWeight: FontWeight.bold);
  TextStyle infoStyle =
      TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white);

  @override
  void initState() {
    var user = Provider.of<User>(context, listen: false);
    _getUserData(user.uId);
    super.initState();
  }

  _toggleIsLoading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  _getUserData(String uid) async {
    _toggleIsLoading();
    _userProfile = await DatabaseService(uId: uid).getUser();
    _toggleIsLoading();
  }

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<User>(context);
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          key: key1,
          drawer: CustomDrawer.buildDrawer(context),
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(100.0),
            child: AppBar(
              backgroundColor: Colors.black,
              leading: Padding(
                padding: const EdgeInsets.only(top: 18.0),
                child: IconButton(
                  onPressed: () {
                    key1.currentState.openDrawer();
                  },
                  icon: Icon(Icons.dehaze),
                ),
              ),
              bottom: TabBar(
                tabs: <Widget>[
                  Tab(
                    child: Row(
                      children: <Widget>[
                        Icon(FontAwesomeIcons.male, color: Colors.white),
                        SizedBox(
                          width: 10,
                        ),
                        Text('Applicants ',
                            style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                  Tab(
                    child: Row(
                      children: <Widget>[
                        Icon(FontAwesomeIcons.briefcase, color: Colors.white),
                        SizedBox(
                          width: 10,
                        ),
                        Text('Our Jobs', style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                ],
              ),
              title: Text(
                "LAH",
                style: TextStyle(fontFamily: 'Spicy Rice'),
              ),
              // title: !isSearch
              //     ? Text(
              //         "LAH",
              //         style: TextStyle(fontFamily: 'Spicy Rice'),
              //       )
              //     : Padding(
              //         padding: const EdgeInsets.only(top: 8.0),
              //         child: TextField(
              //           onChanged: (value) {
              //             // myfilter(value);
              //           },
              //           style: TextStyle(color: Colors.white, fontSize: 18),
              //           decoration: InputDecoration(
              //             hintText: "Search Jobs",
              //             hintStyle: TextStyle(color: Colors.white),
              //             icon: new Icon(
              //               Icons.search,
              //               color: Colors.white,
              //             ),
              //             enabledBorder: UnderlineInputBorder(
              //               borderSide: BorderSide(color: Colors.white70),
              //             ),
              //             focusedBorder: UnderlineInputBorder(
              //               borderSide: BorderSide(color: Colors.white),
              //             ),
              //           ),
              //         ),
              //       ),
              centerTitle: true,
            ),
          ),
          body: _isLoading
              ? Container(
                  child: Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.white,
                    ),
                  ),
                )
              : TabBarView(
                  children: <Widget>[
                    StreamBuilder<UserProfile>(
                      stream: DatabaseService(uId: user.uId).getUserStream(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          UserProfile allApplicants = snapshot.data;
                          return (allApplicants.allApplicants == null ||
                                  allApplicants.allApplicants.isEmpty)
                              ? Center(
                                  child: Container(
                                    margin: EdgeInsets.all(10.0),
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                          'assets/images/emptyList.png',
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : ListView.builder(
                                  padding: EdgeInsets.all(10),
                                  physics: BouncingScrollPhysics(),
                                  itemCount: allApplicants.allApplicants.length,
                                  itemBuilder: (BuildContext ctx, int index) {
                                    return StreamBuilder<JobApplicant>(
                                      stream: JobService(
                                              uId: allApplicants.uId,
                                              jId: allApplicants.allApplicants[index])
                                          .getUserJobApplicationStream(),
                                      builder: (ctx, snapshot) {
                                        if (snapshot.hasData) {
                                          JobApplicant jobApplicant =
                                              snapshot.data;
                                          return jobApplicant.status == 4
                                              ? Text('')
                                              : ListTile(
                                                  title: GestureDetector(
                                                    onTap: () {
                                                      Navigator.of(context)
                                                          .push(
                                                        MaterialPageRoute(
                                                          builder: (ctx) =>
                                                              ApplicantView(
                                                            status: jobApplicant
                                                                .status,
                                                            type: jobApplicant
                                                                .type,
                                                            aId: jobApplicant
                                                                .employeeId,
                                                            aName: jobApplicant
                                                                .employeeName,
                                                            email: jobApplicant
                                                                .email,
                                                            cvLink: jobApplicant
                                                                .cvLink,
                                                            jId: jobApplicant
                                                                .jobId,
                                                            cId: user.uId,
                                                            compReviewed:
                                                                jobApplicant
                                                                    .isCompanyReviewed,
                                                            empReviewed:
                                                                jobApplicant
                                                                    .isEmployeeReviewed,
                                                            acceptTime:
                                                                jobApplicant
                                                                    .acceptTime,
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                    child: Text(
                                                      jobApplicant.employeeName,
                                                    ),
                                                  ),
                                                  subtitle: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      Text(
                                                        jobApplicant.jobTitle,
                                                      ),
                                                      Row(
                                                        children: <Widget>[
                                                          if (jobApplicant
                                                                  .status ==
                                                              0)
                                                            Expanded(
                                                              child: FlatButton(
                                                                child: Text(
                                                                  'Accept',
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                ),
                                                                onPressed:
                                                                    () async {
                                                                  var status =
                                                                      ApplicantStatus
                                                                          .PROCESSING
                                                                          .index;
                                                                  // Change applicant status
                                                                  await JobService(
                                                                    jId: jobApplicant
                                                                        .jobId,
                                                                    companyId:
                                                                        user.uId,
                                                                    uId: jobApplicant
                                                                        .employeeId,
                                                                  ).changeApplicantStatus(
                                                                    status:
                                                                        status,
                                                                  );

                                                                  // change job status
                                                                  await JobService(
                                                                    jId: jobApplicant
                                                                        .jobId,
                                                                  ).changeJobStatus(
                                                                    status: JobStatus
                                                                        .ON_PROGRESS
                                                                        .index,
                                                                  );
                                                                  await JobService(
                                                                    jId: jobApplicant
                                                                        .jobId,
                                                                  ).addApplicantsWithJobs(
                                                                    applicantId:
                                                                        jobApplicant
                                                                            .id,
                                                                  );
                                                                  await JobService(
                                                                    jId: jobApplicant
                                                                        .jobId,
                                                                    uId:
                                                                        jobApplicant
                                                                            .id,
                                                                  ).updateAcceptTime();

                                                                },
                                                                color: Colors
                                                                    .blueGrey,
                                                              ),
                                                            ),
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          if (jobApplicant
                                                                  .status <
                                                              1)
                                                            Expanded(
                                                              child: FlatButton(
                                                                child: Text(
                                                                  'Decline',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                                onPressed:
                                                                    () async {
                                                                  var status =
                                                                      ApplicantStatus
                                                                          .REJECTED
                                                                          .index;
                                                                  await JobService(
                                                                    jId: jobApplicant
                                                                        .jobId,
                                                                    companyId:
                                                                        user.uId,
                                                                    uId: jobApplicant
                                                                        .employeeId,
                                                                  ).changeApplicantStatus(
                                                                    status:
                                                                        status,
                                                                  );

                                                                  await JobService(
                                                                    jId: jobApplicant
                                                                        .jobId,
                                                                    companyId:
                                                                        user.uId,
                                                                    uId: jobApplicant
                                                                        .employeeId,
                                                                  ).deleteApplicant();

                                                                  await DatabaseService(
                                                                          uId: jobApplicant
                                                                              .employeeId)
                                                                      .updateUserApplications(
                                                                    jId: jobApplicant
                                                                        .jobId,
                                                                  );
                                                                  await DatabaseService(
                                                                          uId: jobApplicant
                                                                              .employeeId)
                                                                      .removeUserApplications(
                                                                          jId: jobApplicant
                                                                              .jobId);
                                                                },
                                                                color:
                                                                    Colors.red,
                                                              ),
                                                            ),
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          if (jobApplicant
                                                                      .status >
                                                                  0 &&
                                                              jobApplicant
                                                                      .status <
                                                                  3)
                                                            Expanded(
                                                              child: FlatButton(
                                                                child: Text(
                                                                  'Mark As Complete',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                                onPressed:
                                                                    () async {
                                                                  var status =
                                                                      ApplicantStatus
                                                                          .COMPLETED
                                                                          .index;
                                                                  await JobService(
                                                                    jId: jobApplicant
                                                                        .jobId,
                                                                    companyId:
                                                                        user.uId,
                                                                    uId: jobApplicant
                                                                        .employeeId,
                                                                  ).changeApplicantStatus(
                                                                    status:
                                                                        status,
                                                                  );

                                                                  // change job status
                                                                  await JobService(
                                                                    jId: jobApplicant
                                                                        .jobId,
                                                                  ).changeJobStatus(
                                                                    status: JobStatus
                                                                        .COMPLETED
                                                                        .index,
                                                                  );

                                                                  await DatabaseService(
                                                                    uId: jobApplicant
                                                                        .employeeId,
                                                                  ).updateJobStatusInCompanyProfile(
                                                                    jId: jobApplicant
                                                                        .jobId,
                                                                    cId: jobApplicant
                                                                        .companyId,
                                                                    completed:
                                                                        true,
                                                                  );

                                                                  await JobService(
                                                                    jId: jobApplicant
                                                                        .jobId,
                                                                  ).updateCompletedTime();
                                                                  // remove from user document
                                                                  await DatabaseService(
                                                                          uId: jobApplicant
                                                                              .employeeId)
                                                                      .removeUserApplications(
                                                                          jId: jobApplicant
                                                                              .jobId);
                                                                },
                                                                color: Colors
                                                                    .greenAccent,
                                                              ),
                                                            ),
                                                          if (jobApplicant
                                                                  .status ==
                                                              3)
                                                            Expanded(
                                                              child: Card(
                                                                child:
                                                                    Container(
                                                                  margin: EdgeInsets
                                                                      .all(
                                                                          15.0),
                                                                  child: Center(
                                                                    child: Text(
                                                                      'Completed',
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                color: Colors
                                                                    .greenAccent,
                                                              ),
                                                            )
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                  //trailing: Icon(Icons.message),
                                                );
                                        } else {
                                          return Text('');
                                        }
                                      },
                                    );
                                  },
                                );
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                    Stack(
                      children: <Widget>[
                        StreamBuilder<List<Job>>(
                          stream: JobService(companyId: user.uId)
                              .getAllCompanyJobStream(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              List<Job> companyJobs = snapshot.data;
                              return companyJobs.isEmpty
                                  ? Center(
                                      child: Container(
                                        margin: EdgeInsets.all(10.0),
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                          image: AssetImage(
                                            'assets/images/emptyList.png',
                                          ),
                                        )),
                                      ),
                                    )
                                  : ListView.builder(
                                      padding: EdgeInsets.all(10),
                                      physics: BouncingScrollPhysics(),
                                      itemCount: companyJobs.length,
                                      itemBuilder:
                                          (BuildContext ctx, int index) {
                                        return jobCard(
                                          userProfile: _userProfile,
                                          title: companyJobs[index].title,
                                          type: companyJobs[index].type,
                                          imgUrl: _userProfile.imgUrl,
                                          name: _userProfile.name,
                                          jId: companyJobs[index].id,
                                          status: companyJobs[index].status,
                                        );
                                      },
                                    );
                            } else {
                              return Center(
                                child: Text(
                                  'LOADING',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 30, right: 20),
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: FloatingActionButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CompanyCategory(),
                                  ),
                                );
                              },
                              tooltip: "Add New Job",
                              elevation: 10,
                              child: Icon(FontAwesomeIcons.pen),
                              backgroundColor: Colors.blue,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Widget jobCard({
    UserProfile userProfile,
    String title,
    String name,
    String imgUrl,
    int type,
    String companyId,
    String jId,
    int status,
  }) {
    return Container(
      height: MediaQuery.of(context).size.height / 3.9,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        color: Colors.white.withOpacity(0.88),
        elevation: 5,
        child: Column(
          children: <Widget>[
            Text(
              name ?? 'Company',
              style: companyStyle,
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
                        title,
                        style: jobTitleStyle,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      child: CircleAvatar(
                        child: userProfile.imgUrl == null
                            ? Image.asset('assets/images/mylogo.png')
                            : Image.network(
                                userProfile.imgUrl,
                                fit: BoxFit.cover,
                              ),
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
                  type == 0 ? "LABOR CONTRACT" : "FREELANCER",
                  textAlign: TextAlign.left,
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Expanded(
                  flex: 0,
                  child: Icon(
                    FontAwesomeIcons.userTie,
                    color: Colors.black,
                  ),
                ),
                status != 2
                    ? StreamBuilder<int>(
                        stream: JobService(jId: jId, uId: userProfile.uId)
                            .getCountFromJobApplicantsStream(type),
                        builder: (ctx, snapshot) {
                          return Expanded(
                            child: Text(
                              "Applicants : ${snapshot.data ?? 0}",
                              style: TextStyle(
                                color: Colors.deepPurple,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        },
                      )
                    : Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3.0),
                          color: Colors.grey[200],
                        ),
                        child: Text(
                          'COMPLETED',
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                Flexible(
                  child: GestureDetector(
                    onTap: () async {
                      await JobService(jId: jId).deleteJob();
                    },
                    child: Icon(
                      FontAwesomeIcons.trash,
                      color: Colors.purple,
                    ),
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
