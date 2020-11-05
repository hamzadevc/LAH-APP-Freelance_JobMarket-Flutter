import 'package:flutter/material.dart';
import 'package:job_application/modals/employeeInfo.dart';
import 'package:job_application/modals/job_applicant.dart';
import 'package:job_application/screens/welcome_screens/employee/components/completed_tab_components/completed_job_card.dart';
import 'package:job_application/services/database_service.dart';
import 'package:job_application/services/job_service.dart';
import 'package:provider/provider.dart';

class CompletedJobsList extends StatefulWidget {
  @override
  _CompletedJobsListState createState() => _CompletedJobsListState();
}

class _CompletedJobsListState extends State<CompletedJobsList> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return Container(
      child: StreamBuilder<List<dynamic>>(
        stream: DatabaseService(uId: user.uId).getCompletedJobs(),
        builder: (ctx, snapshot) {
          if (snapshot.hasData) {
            List<dynamic> jobApplicants = snapshot.data;
            return ListView.builder(
              itemCount: jobApplicants.length,
              itemBuilder: (ctx, i) {
                return StreamBuilder<JobApplicant>(
                  stream: JobService(uId: user.uId, jId: jobApplicants[i])
                      .getAllUserCompletedJobApplicationStream(),
                  builder: (ctx, snapshot) {
                    if (snapshot.hasData) {
                      JobApplicant applicant = snapshot.data;
                      return applicant == null ? Text('') : CompletedCard();
                    } else {
                      return Text('');
                    }
                  },
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
    );
  }
}
