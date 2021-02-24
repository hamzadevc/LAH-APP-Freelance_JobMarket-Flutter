import 'dart:math';
import 'package:flutter/material.dart';
import 'package:lah_project/screens/welcome_screens/company/companyCategory.dart';
import './modals/employeeInfo.dart';
import './screens/chat/chat_screen.dart';
import './screens/profile_screen/editProfile.dart';
import './screens/wallet_screen/wallet.dart';
import './services/auth_service.dart';
import 'package:provider/provider.dart';

class CustomDrawer {
  static buildDrawer(BuildContext context, SessionType sessionType) {
    print("dsd");
    return Drawer(
      child: Container(
        padding: const EdgeInsets.only(left: 40.0, right: 40),
        decoration: new BoxDecoration(
          gradient: new LinearGradient(
            colors: [
              Colors.black.withOpacity(0.9),
              Colors.black.withOpacity(0.9)
            ],
            begin: const FractionalOffset(
              0.0,
              0.0,
            ),
            end: const FractionalOffset(
              1.0,
              0.0,
            ),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp,
          ),
        ),
        width: 200,
        child: SafeArea(
          /// ---------------------------
          /// Building scrolling  content for drawer .
          /// ---------------------------

          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                /// ---------------------------
                /// Building header for drawer .
                /// ---------------------------

                SizedBox(height: 50.0),

                /// ---------------------------
                /// Building header title for drawer .
                /// ---------------------------

                Text(
                  "Main Menu",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                /// ---------------------------
                /// Building items list  for drawer .
                /// ---------------------------

                SizedBox(height: 30.0),

                _buildDivider(),
                InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditProfile(sessionType),
                        ),
                      );
                    },
                    child: _buildRow(
                      Icons.person,
                      "Profile",
                    )),
                // _buildDivider(),
                //
                // GestureDetector(
                //   onTap: () {
                //     Navigator.of(context).push(
                //       MaterialPageRoute(
                //         builder: (ctx) => ChatScreen()
                //       )
                //     );
                //   },
                //   child: _buildRow(
                //     Icons.message,
                //     "Messages",
                //   ),
                // ),

                _buildDivider(),
                if(sessionType == SessionType.EMPLOYEE)
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Wallet(),
                        ),
                      );
                    },
                    child: _buildRow(
                      Icons.attach_money,
                      "Wallet",
                    ),
                  ),

                // _buildDivider(),
                if(sessionType == SessionType.COMPANY)
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CompanyCategory(),
                        ),
                      );
                    },
                    child: _buildRow(
                      Icons.create,
                      "Create Request",
                    ),
                  ),

                _buildDivider(),

                InkWell(
                  onTap: () {
                    User user = Provider.of<User>(context, listen: false);
                    Auth().logOut(uId: user.uId);
                  },
                  child: _buildRow(
                    Icons.settings_power,
                    "Logout",
                  ),
                ),
                _buildDivider(),
                SizedBox(
                  height: 30,
                ),
                Image.asset(
                  "assets/images/mylogo.png",
                  height: 88,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static Divider _buildDivider() {
    return Divider(
      color: Colors.grey.shade600,
    );
  }

  static Widget _buildRow(IconData icon, String title,
      {bool showBadge = false}) {
    final TextStyle tStyle = TextStyle(color: Colors.white, fontSize: 16.0);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.white,
          ),
          SizedBox(width: 10.0),
          Text(
            title,
            style: tStyle,
          ),
          Spacer(),
          if (showBadge)
            Material(
              color: Colors.deepOrange,
              elevation: 5.0,
              shadowColor: Colors.red,
              borderRadius: BorderRadius.circular(5.0),
              child: Container(
                width: 25,
                height: 25,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Text(
                  "0",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
