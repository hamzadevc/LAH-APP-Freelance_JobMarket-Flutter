import 'package:flutter/material.dart';
import 'package:job_application/modals/employeeInfo.dart';
import 'package:job_application/screens/welcome_screens/employee/Welcome.dart';
import 'package:job_application/screens/auth_screens/selectionScreen.dart';
import 'package:job_application/services/auth_service.dart';
import 'package:provider/provider.dart';

import 'screens/welcome_screens/company/companyWelcome.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  SessionType _sessionType;
  bool _isLoading = false;
  @override
  void initState() {
    final user = Provider.of<User>(context, listen: false);
    _getSessionUser(user?.uId);
    super.initState();
  }

  _toggleLoading() => setState(() {
        _isLoading = !_isLoading;
      });

  _getSessionUser(String uId) async {
    _toggleLoading();
    _sessionType = await Auth().getUserSession(uId: uId);
    _toggleLoading();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    if (_isLoading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            backgroundColor: Colors.black87,
          ),
        ),
      );
    } else {
      if (user != null && _sessionType != null) {
        return _sessionType == SessionType.COMPANY ? CWelcome() : Welcome();
      } else {
        return Container(
          child: SelectCategory(),
        );
      }
    }
  }
}
