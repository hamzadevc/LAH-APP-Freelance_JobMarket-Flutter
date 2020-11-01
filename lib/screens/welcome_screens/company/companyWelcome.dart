import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:job_application/modals/employeeInfo.dart';
import 'package:job_application/modals/job.dart';
import 'package:job_application/modals/job_applicant.dart';
import 'package:job_application/modals/user_profile.dart';

import 'package:job_application/customDrawer.dart';
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
    var user = Provider.of<User>(context);
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
              title: !isSearch
                  ? Text(
                      "LAH App",
                      style: TextStyle(fontFamily: 'Spicy Rice'),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: TextField(
                        onChanged: (value) {
                          // myfilter(value);
                        },
                        style: TextStyle(color: Colors.white, fontSize: 18),
                        decoration: InputDecoration(
                          hintText: "Search Jobs",
                          hintStyle: TextStyle(color: Colors.white),
                          icon: new Icon(
                            Icons.search,
                            color: Colors.white,
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white70),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
              centerTitle: true,
            ),
          ),
          body: _isLoading
              ? Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.black87,
                  ),
                )
              : TabBarView(
                  children: <Widget>[
                    StreamBuilder<List<JobApplicant>>(
                      stream: JobService(companyId: user.uId)
                          .getAllJobApplicantsStream(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List<JobApplicant> jobApplicants = snapshot.data;
                          return (jobApplicants.isEmpty ||
                                  jobApplicants == null)
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
                                  itemCount: jobApplicants.length,
                                  itemBuilder: (BuildContext ctx, int index) {
                                    return ListTile(
                                      title: Text(
                                          jobApplicants[index].employeeName),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(jobApplicants[index].jobTitle),
                                          Row(
                                            children: <Widget>[
                                              Expanded(
                                                child: FlatButton(
                                                  child: Text(
                                                    'Accept',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  onPressed: () async {
                                                    var status = JobStatus
                                                        .PROCESSING.index;
                                                    await JobService(
                                                      jId: jobApplicants[index]
                                                          .jobId,
                                                      companyId: user.uId,
                                                      uId: jobApplicants[index]
                                                          .employeeId,
                                                    ).changeApplicantStatus(
                                                      status: status,
                                                    );
                                                  },
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Expanded(
                                                child: FlatButton(
                                                  child: Text(
                                                    'Decline',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  onPressed: () async {
                                                    var status = JobStatus
                                                        .REJECTED.index;
                                                    await JobService(
                                                      jId: jobApplicants[index]
                                                          .jobId,
                                                      companyId: user.uId,
                                                      uId: jobApplicants[index]
                                                          .employeeId,
                                                    ).changeApplicantStatus(
                                                      status: status,
                                                    );
                                                  },
                                                  color: Colors.red,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Expanded(
                                                child: FlatButton(
                                                  child: Text(
                                                    'Mark As Complete',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  onPressed: () async {
                                                    var status = JobStatus
                                                        .COMPLETED.index;
                                                    await JobService(
                                                      jId: jobApplicants[index]
                                                          .jobId,
                                                      companyId: user.uId,
                                                      uId: jobApplicants[index]
                                                          .employeeId,
                                                    ).changeApplicantStatus(
                                                      status: status,
                                                    );
                                                  },
                                                  color: Colors.black87,
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                      trailing: Icon(Icons.message),
                                    );
                                  },
                                );
                        } else {
                          return CircularProgressIndicator();
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
                                          title: companyJobs[index].title,
                                          type: companyJobs[index].type,
                                          imgUrl: _userProfile.imgUrl,
                                          name: _userProfile.name,
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

                                    ///TODO fix create job start from here
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
    String title,
    String name,
    String imgUrl,
    int type,
    String companyId,
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
              name,
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
                        child: Image.network(imgUrl),
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
                  type == 0 ? "CONTRACT" : "FREELANCER",
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
                StreamBuilder<int>(
                  stream: JobService(companyId: companyId)
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
                ),
                Flexible(
                  child: Icon(
                    FontAwesomeIcons.trash,
                    color: Colors.purple,
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
