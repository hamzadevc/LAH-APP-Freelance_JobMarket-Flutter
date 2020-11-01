import 'package:flutter/material.dart';
import 'package:job_application/modals/job_applicant.dart';
import 'package:job_application/screens/welcome_screens/employee/components/applied_tab_components/applicant_card.dart';
import 'package:job_application/services/job_service.dart';

class AppliedJobsList extends StatelessWidget {
  final String uId;
  AppliedJobsList({this.uId});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                right: 32,
                left: 0,
                top: 40,
                bottom: 32,
              ),
              child: Text(
                "Your \napplications",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  height: 1.2,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 32, left: 32, bottom: 8),
              child: Container(
                height: MediaQuery.of(context).size.height / 2,
                child: StreamBuilder<List<JobApplicant>>(
                  stream: JobService(uId: uId).getAllUserJobApplicationStream(),
                  builder: (ctx, snapShot) {
                    if (snapShot.hasData) {
                      List<JobApplicant> applications = snapShot.data;
                      return applications.isEmpty
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
                              physics: BouncingScrollPhysics(),
                              itemCount: applications.length,
                              itemBuilder: (ctx, index) {
                                return ApplicantCard(
                                  type: applications[index].type,
                                  title: applications[index].jobTitle,
                                  status: applications[index].status,
                                  cId: applications[index].companyId,
                                  jId: applications[index].jobId,
                                );
                              },
                            );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.black87,
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
