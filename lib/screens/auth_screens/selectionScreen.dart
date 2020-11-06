import 'package:flutter/material.dart';
import 'package:job_application/modals/employeeInfo.dart';
import 'package:job_application/screens/auth_screens/signIn.dart';

import 'Components/WaveClipPath.dart';
import 'Components/custom_card.dart';

import 'package:job_application/widgets/button_material.dart';

class SelectCategory extends StatefulWidget {
  @override
  _SelectCategoryState createState() => _SelectCategoryState();
}

class _SelectCategoryState extends State<SelectCategory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          WaveClipPath(),
          Center(
            child: Container(
              margin: EdgeInsets.only(top: 100),

              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  MaterialButtonShape(
                    text: 'EMPLOYEE',
                    // icon: Icons.home,
                    icon: Icons.person_outline,
                    color: Colors.black54,
                    textColor: Colors.white,
                    iconColor: Colors.black,
                    iconSize: 40.0,
                    width: 250,
                    height: 70,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignIn(
                            sessionType: SessionType.EMPLOYEE,
                          ),
                        ),
                      );
                    },
                  ),

                  MaterialButtonShape(
                    text: 'BUSINESS',
                    icon: Icons.home_repair_service_outlined,
                    color: Colors.black54,
                    textColor: Colors.white,
                    iconColor: Colors.black,
                    iconSize: 40.0,
                    width: 250,
                    height: 70,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignIn(
                            sessionType: SessionType.COMPANY,
                          ),
                        ),
                      );
                    },
                  ),
                  // MaterialButtonShape(
                  //   text: 'Feed',
                  //   icon: Icons.rss_feed,
                  //   color: Colors.blueAccent,
                  //   textColor: Colors.white,
                  //   iconColor: Colors.blue,
                  //   iconSize: 40.0,
                  //   width: 200,
                  //   height: 70,
                  // ),
                  // MaterialButtonShape(
                  //   text: 'Friends',
                  //   icon: Icons.person_add,
                  //   color: Colors.orange,
                  //   textColor: Colors.white,
                  //   iconColor: Colors.orangeAccent,
                  //   iconSize: 40.0,
                  //   width: 200,
                  //   height: 70,
                  // ),
                ],
              ),

              // child: Column(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: <Widget>[
              //     CustomCard(
              //       title: 'Register As Employee',
              //       imgPath:  "assets/images/contract.png",
              //       onTap: () {
              //         Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //             builder: (context) => SignIn(
              //               sessionType: SessionType.EMPLOYEE,
              //             ),
              //           ),
              //         );
              //       },
              //     ),
              //     SizedBox(
              //       height: 20,
              //     ),
              //     CustomCard(
              //       title: 'Register As Company',
              //       imgPath: "assets/images/company.png",
              //       onTap: () {
              //         Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //             builder: (context) => SignIn(
              //               sessionType: SessionType.COMPANY,
              //             ),
              //           ),
              //         );
              //       },
              //     ),
              //   ],
              // ),
            ),
          ),
        ],
      ),
    );
  }
}
