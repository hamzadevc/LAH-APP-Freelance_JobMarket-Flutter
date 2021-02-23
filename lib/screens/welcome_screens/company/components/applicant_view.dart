import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../modals/job.dart';
import '../../../../modals/user_profile.dart';
import '../../../welcome_screens/company/components/pdf_view.dart';
import '../../../../services/database_service.dart';
import '../../../../services/job_service.dart';
import '../../../../services/review_service.dart';
import '../../../../wrapper.dart';
import 'package:quick_feedback/quick_feedback.dart';

class ApplicantView extends StatefulWidget {
  final String aId;
  final String aName;
  final String cvLink;
  final String email;
  final int status;
  final int type;
  final String cId;
  final String jId;
  final bool empReviewed;
  final bool compReviewed;
  final Timestamp acceptTime;
  final int numDays;

  ApplicantView({
    this.status,
    this.type,
    this.cvLink,
    this.email,
    this.aId,
    this.aName,
    this.cId,
    this.jId,
    this.compReviewed,
    this.empReviewed,
    this.numDays,
    this.acceptTime,
  });
  @override
  _ApplicantViewState createState() => _ApplicantViewState();
}

class _ApplicantViewState extends State<ApplicantView> {
  TextStyle infoStyle =
      TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white);
  TextStyle infoStyle1 = TextStyle(fontSize: 15, color: Colors.white);
  UserProfile _profile;
  UserProfile _employeeProfile;
  Job _job;
  bool _isLoading = false;

  _toggleLoading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  @override
  void initState() {
    _getJobDetail(widget.aId);
    super.initState();
  }

  _getJobDetail(String aId) async {
    _toggleLoading();
    _profile = await DatabaseService(uId: aId).getUser();
    _employeeProfile = await DatabaseService(uId: widget.aId).getUser();
    _job = await JobService(jId: widget.jId).getJob();
    _toggleLoading();
  }

  TextStyle heading =
      TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black);
  Future _showFeedback(context,
      {String senderId, String takerId, String jid}) async {
    await showDialog(
      context: context,
      builder: (context) {
        return QuickFeedback(
          title: 'Leave a feedback', // Title of dialog
          showTextBox: true, // default false
          textBoxHint:
              'Share your feedback', // Feedback text field hint text default: Tell us more
          submitText: 'SUBMIT', // submit button text default: SUBMIT
          onSubmitCallback: (feedback) async {
            String rating = '${feedback['rating']}';
            String review = feedback['feedback'];

            await ReviewService(
              senderId: senderId,
              takerId: takerId,
            ).createReview(
              feedback: review,
              rating: rating,
              jId: widget.jId,
            );

            await DatabaseService(uId: takerId).updateRating(
              rating: rating,
              feedback: review,
            );

            await JobService(jId: jid, uId: takerId)
                .changeApplicantStatus(status: 4, isCompReview: true);

            // remove from job document
            if(widget.empReviewed && widget.compReviewed) {
              await JobService(
                jId: widget.jId,
              ).removeApplicantsWithJobs(
                  applicantId:
                  widget.aId);
            }

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (ctx) => Wrapper(),
              ),
            );
          },
          askLaterText: 'LATER',
          onAskLaterCallback: () {
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  String _getStatus(int status) {
    if (status == 0) return 'PENDING';
    if (status == 1) return 'PROCESSING';
    if (status == 2) return 'REJECTED';
    if (status == 3) return 'COMPLETED';
    if (status == 4)
      return 'Applicant Reviewed';
    else
      return 'ERROR';
  }

  Color _getStatusColor(int status) {
    if (status == 0) return Colors.orangeAccent;
    if (status == 1) return Colors.deepOrange;
    if (status == 2) return Colors.redAccent;
    if (status == 3) return Colors.green;
    if (status == 4)
      return Colors.green;
    else
      return Colors.redAccent;
  }

  String _getJobType(int type) {
    if (type == 0) return 'CONTRACT';
    if (type == 1)
      return 'FREELANCER';
    else
      return 'ERROR';
  }

  int _getEndTime() {
    var acceptTime = widget.acceptTime.toDate();
    var newTime = DateTime(
      acceptTime.year,
      acceptTime.month,
      acceptTime.day + int.parse(_job.numDays),
      acceptTime.hour,
      acceptTime.minute,
      acceptTime.second,
    );

    var dur = newTime.microsecondsSinceEpoch;
    print('DUR: $dur');
    print('NUM DAYS: ${widget.numDays}');
    return dur;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FlatButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          onPressed: () {},
          color: Colors.grey[200],
          child: Text(
            _getStatus(widget.status),
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: _getStatusColor(widget.status),
            ),
          ),
        ),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.black54,
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.black87, Colors.black87],
                          ),
                        ),
                        height: 230,
                      ),
                      Positioned.fill(
                        top: 50,
                        child: Align(
                          alignment: Alignment.center,
                          child: Column(
                            children: <Widget>[
                              CircleAvatar(
                                child: Image.network(_profile.imgUrl),
                                radius: 50,
                                backgroundColor: Colors.transparent,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Text(
                                    "Type",
                                    style: infoStyle1,
                                  ),
                                  Text(_getJobType(widget.type),
                                      style: infoStyle),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Text(
                                    "Average Rating",
                                    style: infoStyle1,
                                  ),
                                  Text(_profile.avgRating ?? '0.0',
                                      style: infoStyle),
                                  Text('(${_profile.allRatings.length} Reviews)',
                                      style: infoStyle),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 20,
                        top: 40,
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              FontAwesomeIcons.arrowLeft,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 20),
                    child: Container(
                      height: MediaQuery.of(context).size.height / 2,
                      child: ListView(
                        physics: BouncingScrollPhysics(),
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              if (widget.status > 0 && widget.status != 2)
                                Wrap(
                                  children: <Widget>[
                                    Text('Remaining Time: ', style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0,
                                    ),),
                                    SizedBox(width: 5.0,),
                                    // CountdownTimer(

                                    //   // endTime: (_getEndTime() / 1000).floor(),
                                    //   // daysSymbol: Text("days"),
                                    //   // hoursSymbol: Text("hrs "),
                                    //   // minSymbol: Text("min "),
                                    //   // secSymbol: Text("sec"),
                                    // ),
                                  ],
                                ),
                              Text(
                                widget.aName,
                                style: heading,
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                widget.email,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (ctx) => PDFView(
                                        link: widget.cvLink,
                                      ),
                                    ),
                                  );
                                },
                                child: Text(
                                  "Resume",
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0,
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),

                              if (widget.status == 3)
                                Container(
                                  child: Center(
                                    child: FlatButton(
                                      onPressed: () async {
                                        await _showFeedback(
                                          context,
                                          takerId: _profile.uId,
                                          senderId: widget.cId,
                                          jid: widget.jId,
                                        );
                                      },
                                      color: Colors.grey[200],
                                      child: Text('Give Feedback'),
                                    ),
                                  ),
                                ),
                              //Text(widget.qualification),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
