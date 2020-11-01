import 'package:flutter/material.dart';
import 'package:job_application/modals/employeeInfo.dart';
import 'package:job_application/screens/welcome_screens/employee/components/jobs_tab_components/jobs_list.dart';
import 'package:job_application/screens/welcome_screens/employee/components/custom_app_bar.dart';
import 'package:provider/provider.dart';

import '../../../customDrawer.dart';
import 'components/applied_tab_components/applied_jobs_list.dart';
import 'components/completed_tab_components/completed_job_card.dart';

class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  GlobalKey<ScaffoldState> key1 = GlobalKey<ScaffoldState>();
  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 60 * 60;
  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<User>(context);
    return SafeArea(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: Colors.white.withOpacity(0.9),
          key: key1,
          drawer: CustomDrawer.buildDrawer(context),
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(100.0),
            child: CustomAppBar(
              key: key1,
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              AppliedJobsList(
                uId: user.uId,
              ),
              JobsList(),
              ListView(
                physics: const BouncingScrollPhysics(),
                children: <Widget>[
                  CompletedCard(),
                  CompletedCard(),
                  CompletedCard(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
