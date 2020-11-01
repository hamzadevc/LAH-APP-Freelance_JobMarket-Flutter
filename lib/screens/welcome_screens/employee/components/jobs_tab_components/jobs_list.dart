import 'package:flutter/material.dart';
import 'package:job_application/modals/job.dart';
import 'package:job_application/screens/welcome_screens/employee/components/jobs_tab_components/recommended_for_you.dart';
import 'package:job_application/services/job_service.dart';
import 'job_card.dart';

class JobsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 100,
            child: ListView(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              children: [
                Padding(
                  padding:
                      EdgeInsets.only(right: 32, left: 32, top: 8, bottom: 20),
                  child: Text(
                    "Available \nJobs",
                    style: TextStyle(
                        fontSize: 32, fontWeight: FontWeight.bold, height: 1.2),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                "Recommended For you",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          RecommendedForYou(),
          // recommended jobs horizontal lists

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                "Recently added",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          StreamBuilder<List<Job>>(
            stream: JobService().getAllJobStream(),
            builder: (ctx, snapshot) {
              List<Job> jobs = snapshot.data;
              if (snapshot.hasData) {
                return Container(
                  height: 500,
                  child: jobs.isEmpty
                      ? AssetImage('assets/images/emptyList.png')
                      : ListView.builder(
                          physics: BouncingScrollPhysics(),
                          itemCount: jobs.length,
                          itemBuilder: (BuildContext ctx, int index) {
                            return JobCard(
                              jId: jobs[index].id,
                              cId: jobs[index].companyId,
                            );
                          },
                        ),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
