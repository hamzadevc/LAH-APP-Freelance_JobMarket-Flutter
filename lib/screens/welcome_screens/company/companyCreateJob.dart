import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:job_application/modals/employeeInfo.dart';
import 'package:job_application/services/job_service.dart';
import 'package:job_application/wrapper.dart';
import 'package:provider/provider.dart';

class CreateJob extends StatefulWidget {
  final String empNeed;
  final String numDays;
  final DateTime inDate;
  final String numHours;
  final String price;

  CreateJob({
    @required this.numHours,
    @required this.numDays,
    @required this.empNeed,
    @required this.inDate,
    @required this.price,
  });

  @override
  _CreateJobState createState() => _CreateJobState();
}

class _CreateJobState extends State<CreateJob>
    with SingleTickerProviderStateMixin {
  List<ListItem> _dropdownItems = [
    ListItem(0, "Contract"),
    ListItem(1, "Freelancer"),
  ];

  List<DropdownMenuItem<ListItem>> _dropdownMenuItems;
  ListItem _selectedItem;

  List<DropdownMenuItem<ListItem>> buildDropDownMenuItems(List listItems) {
    List<DropdownMenuItem<ListItem>> items = List();
    for (ListItem listItem in listItems) {
      items.add(
        DropdownMenuItem(
          child: Text(listItem.name),
          value: listItem,
        ),
      );
    }
    return items;
  }

  @override
  void initState() {
    _dropdownMenuItems = buildDropDownMenuItems(_dropdownItems);
    _selectedItem = _dropdownMenuItems[0].value;
    super.initState();
  }

  String title;
  String description;
  String qualification;
  String location;
  int type;
  bool showSpinner = false;
  // File _image;
  bool _isLoading = false;
  final FocusNode myFocusNode = FocusNode();

  _toggleLoading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return Scaffold(
      bottomNavigationBar: FlatButton(
        padding: EdgeInsets.all(15),
        onPressed: () async {
          await createJob(user.uId);
        },
        child: Text(
          "Create Job",
          style: TextStyle(color: Colors.white),
        ),
        color: Colors.black,
      ),
      backgroundColor: Colors.grey.shade200,
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.black87,
              ),
            )
          : ListView(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      color: Colors.grey.shade200,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 25.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 25.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Text(
                                        'Please fill the Information',
                                        style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: 25.0,
                                right: 25.0,
                                top: 25.0,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Text(
                                        'Job Title',
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: 25.0,
                                right: 25.0,
                                top: 2.0,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Flexible(
                                    child: TextField(
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        hintText: "Enter Job title",
                                      ),
                                      onChanged: ((value) {
                                        title = value;
                                      }),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: 25.0,
                                right: 25.0,
                                top: 25.0,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Text(
                                        'Description',
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: 25.0,
                                right: 25.0,
                                top: 2.0,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Flexible(
                                    child: TextField(
                                      onChanged: ((value) {
                                        description = value;
                                      }),
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        hintText: "Enter Description",
                                      ),
                                      maxLines: 4,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: 25.0,
                                right: 25.0,
                                top: 25.0,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Text(
                                        'Qualification Required',
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: 25.0,
                                right: 25.0,
                                top: 2.0,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Flexible(
                                    child: TextField(
                                      onChanged: ((value) {
                                        qualification = value;
                                      }),
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        hintText: "Enter Qualifications",
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: 25.0,
                                right: 25.0,
                                top: 25.0,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Text(
                                        'Location',
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 2.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Flexible(
                                    child: TextField(
                                      onChanged: ((value) {
                                        location = value;
                                      }),
                                      decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          hintText: "Enter Location"),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 25.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      child: Text(
                                        'Enter Type',
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    flex: 2,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 2.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Flexible(
                                    child: Padding(
                                      padding: EdgeInsets.only(right: 10.0),
                                      child: DropdownButton<ListItem>(
                                        value: _selectedItem,
                                        items: _dropdownMenuItems,
                                        onChanged: (value) {
                                          setState(
                                            () {
                                              _selectedItem = value;
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                    flex: 2,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myFocusNode.dispose();
    super.dispose();
  }

  Future createJob(String uid) async {
    _toggleLoading();
    await JobService(uId: uid).createJob(
      title: title,
      description: description,
      location: location,
      qualification: qualification,
      jobType: _selectedItem.value,
      companyId: uid,
      creationTime: Timestamp.now(),
      bidPrice: widget.price,
      numHr: widget.numHours,
      needDate: widget.inDate,
      limit: widget.empNeed,
      numDays: widget.numDays,
    );
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => Wrapper(),
      ),
      (Route<dynamic> route) => false,
    );
    _toggleLoading();
  }
}

class ListItem {
  int value;
  String name;

  ListItem(this.value, this.name);
}
