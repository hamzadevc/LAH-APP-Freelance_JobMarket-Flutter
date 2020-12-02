import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:job_application/modals/employeeInfo.dart';
import 'package:job_application/screens/welcome_screens/employee/components/completed_tab_components/completed_job_list.dart';
import 'package:job_application/screens/welcome_screens/employee/components/jobs_tab_components/jobs_list.dart';
import 'package:provider/provider.dart';

import '../../../customDrawer.dart';
import '../../questions.dart';
import 'components/applied_tab_components/applied_jobs_list.dart';
import 'components/completed_tab_components/completed_job_card.dart';

class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  bool isSearch = false;
  GlobalKey<ScaffoldState> key1 = GlobalKey<ScaffoldState>();
  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 60 * 60;
  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<User>(context);
    return SafeArea(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          key: key1,
          backgroundColor: Colors.white.withOpacity(0.9),
          drawer: CustomDrawer.buildDrawer(context),
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(100.0),
            child: AppBar(
              backgroundColor: Colors.black,
              actions: <Widget>[
                // isSearch
                //     ? Padding(
                //   padding: const EdgeInsets.only(right: 8.0),
                //   child: Align(
                //     alignment: Alignment.centerLeft,
                //     child: IconButton(
                //       onPressed: () {
                //         setState(() {
                //           isSearch = false;
                //         });
                //       },
                //       icon: new FaIcon(
                //         FontAwesomeIcons.timesCircle,
                //       ),
                //     ),
                //   ),
                // )
                //     : Padding(
                //   padding: const EdgeInsets.only(right: 8.0),
                //   child: Align(
                //     alignment: Alignment.centerLeft,
                //     child: IconButton(
                //       onPressed: () {
                //         setState(() {
                //           isSearch = true;
                //         });
                //       },
                //       icon: new FaIcon(
                //         FontAwesomeIcons.search,
                //         size: 18,
                //       ),
                //     ),
                //   ),
                // ),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: IconButton(
                //     onPressed: () {
                //       Navigator.push(
                //         context,
                //         MaterialPageRoute(builder: (context) => Questions()),
                //       );
                //     },
                //     icon: GestureDetector(
                //       onTap: () {
                //
                //       },
                //       child: new Icon(
                //         Icons.filter_list,
                //         color: Colors.white,
                //       ),
                //     ),
                //   ),
                // )
              ],
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
                        Icon(FontAwesomeIcons.paperPlane, color: Colors.white),
                        SizedBox(
                          width: 10,
                        ),
                        Text('Applied ', style: TextStyle(color: Colors.white)),
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
                        Text('Jobs', style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                  Tab(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(FontAwesomeIcons.checkCircle, color: Colors.white),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.01,
                        ),
                        Text('Completed',
                            style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                ],
              ),
              title: !isSearch
                  ? Text(
                "LAH",
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
          body: TabBarView(
            children: <Widget>[
              AppliedJobsList(
                uId: user.uId,
              ),
              JobsList(),
              CompletedJobsList(),
            ],
          ),
        ),
      ),
    );
  }
}
