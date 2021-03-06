import 'package:flutter/material.dart';
import './modals/employeeInfo.dart';
import './screens/auth_screens/selectionScreen.dart';
import './screens/welcome_screens/welcom_wrapper.dart';
import 'package:provider/provider.dart';


class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    if (user != null) {
      return WelcomeWrapper(uid: user.uId);
    } else {
      return Container(
        child: SelectCategory(),
      );
    }
  }
}
