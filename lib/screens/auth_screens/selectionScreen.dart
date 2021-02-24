import 'package:flutter/material.dart';
import '../../modals/employeeInfo.dart';
import '../../screens/auth_screens/signIn.dart';
import 'Components/WaveClipPath.dart';
import '../../widgets/button_material.dart';

class SelectCategory extends StatefulWidget {
  @override
  _SelectCategoryState createState() => _SelectCategoryState();
}

class _SelectCategoryState extends State<SelectCategory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          WaveClipPath(),
          Center(
            child: Container(
              margin: EdgeInsets.only(top: 100),

              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  SizedBox(height: 20,),
                  MaterialButtonShape(
                    text: 'LAH For Professionals',
                    icon: Icons.person_outline,
                    color: Colors.black,
                    textColor: Colors.white,
                    iconColor: Colors.black,
                    iconSize: 40.0,
                    width: 250,
                    height: 70,
                    onClick: () {
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
                    text: 'LAH for Business',
                    icon: Icons.business,
                    color: Colors.black,
                    textColor: Colors.white,
                    iconColor: Colors.black,
                    iconSize: 40.0,
                    width: 250,
                    height: 70,
                    onClick: () {
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
