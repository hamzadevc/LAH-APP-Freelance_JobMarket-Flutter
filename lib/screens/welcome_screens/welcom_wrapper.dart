import 'package:flutter/material.dart';
import '../../modals/employeeInfo.dart';
import '../welcome_screens/company/companyWelcome.dart';
import '../welcome_screens/employee/Welcome.dart';
import '../../services/auth_service.dart';

class WelcomeWrapper extends StatefulWidget {
  final String uid;
  WelcomeWrapper({this.uid});
  @override
  _WelcomeWrapperState createState() => _WelcomeWrapperState();
}

class _WelcomeWrapperState extends State<WelcomeWrapper> {
  SessionType _sessionType;
  bool _isLoading = false;

  @override
  void initState() {
    _getSessionUser(widget.uid);
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
    if (_isLoading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            backgroundColor: Colors.black87,
          ),
        ),
      );
    } else {
      return _sessionType == SessionType.COMPANY ? CWelcome(_sessionType) : Welcome(_sessionType);
    }
  }
}
