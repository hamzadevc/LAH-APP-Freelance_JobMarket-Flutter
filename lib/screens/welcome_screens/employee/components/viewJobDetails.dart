import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_countdown_timer/index.dart';
// import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
// import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../modals/employeeInfo.dart';
import '../../../../services/database_service.dart';
import '../../../../services/job_service.dart';
import '../../../../services/review_service.dart';
import '../../../../wrapper.dart';
import 'package:provider/provider.dart';
import 'package:quick_feedback/quick_feedback.dart';

class ViewJob extends StatefulWidget {
  final String jId;
  final String cId;
  final int status;
  final String uImgUrl;
  final String location;
  final String title;
  final String cName;
  final String description;
  final String qualification;
  final int type;
  final bool empReviewed;
  final bool compReviewed;
  final Timestamp acceptTime;
  final int numDays;
  ViewJob({
    this.jId,
    this.cId,
    this.status,
    this.uImgUrl,
    this.title,
    this.type,
    this.qualification,
    this.description,
    this.location,
    this.cName,
    this.compReviewed,
    this.empReviewed,
    this.acceptTime,
    this.numDays,
  });
  @override
  _ViewJobState createState() => _ViewJobState();
}

class _ViewJobState extends State<ViewJob> {
  TextStyle infoStyle =
      TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white);
  TextStyle infoStyle1 = TextStyle(fontSize: 15, color: Colors.white);

  TextStyle heading =
      TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black);

  // CountdownTimerController controller;

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
            );

            await DatabaseService(uId: takerId).updateCompanyRating(
              rating: rating,
              feedback: review,
            );

            await JobService(jId: jid, uId: takerId)
                .changeApplicantReviewStatus(status: 4, isEmpReview: true);

            // remove from job document
            if (widget.empReviewed && widget.compReviewed) {
              await JobService(
                jId: widget.jId,
              ).removeApplicantsWithJobs(applicantId: senderId);
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
      return 'COMPANY REVIEWED';
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

  String readTimestamp(int timestamp) {
    print(timestamp);
    var now = new DateTime.now();
    var date = new DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    var diff = date.difference(now);
    var time =
        '${diff.inDays} days | ${diff.inMinutes} minutes | ${diff.inSeconds} seconds';

    return time;
  }

  int _getEndTime() {
    var acceptTime = widget.acceptTime.toDate();
    var newTime = DateTime(
      acceptTime.year,
      acceptTime.month,
      acceptTime.day + widget.numDays,
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
    var user = Provider.of<User>(context);
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
      body: Column(
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
                        child: Image.network(widget.uImgUrl),
                        radius: 50,
                        backgroundColor: Colors.transparent,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(
                            "Type",
                            style: infoStyle1,
                          ),
                          Text("Level", style: infoStyle1),
                          Text("Location", style: infoStyle1),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(_getJobType(widget.type), style: infoStyle),
                          Text(
                            "Entry",
                            style: infoStyle,
                          ),
                          Text(widget.location, style: infoStyle),
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
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
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
                            Text(
                              'Remaining Time: ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                              ),
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            CountdownTimer(
                              // controller: controller,
                              endTime: (_getEndTime() / 1000).floor(),
                              widgetBuilder: (_, CurrentRemainingTime time) {
                                return Text(
                  'days: [ ${time.days} ], hours: [ ${time.hours} ], min: [ ${time.min} ], sec: [ ${time.sec} ]');
                              },
                              // daysSymbol: Text("days"),
                              // hoursSymbol: Text("hrs "),
                              // minSymbol: Text("min "),
                              // secSymbol: Text("sec"),
                            ),
                          ],
                        ),
                      Text(
                        widget.cName,
                        style: heading,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        widget.title,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Text(
                        "Description",
                        style: heading,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(widget.description),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Qualifications",
                        style: heading,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(widget.qualification),
                      if (widget.status >= 3)
                        Container(
                          child: Center(
                            child: FlatButton(
                              onPressed: () async {
                                await _showFeedback(
                                  context,
                                  takerId: widget.cId,
                                  senderId: user.uId,
                                  jid: widget.jId,
                                );
                              },
                              color: Colors.grey[200],
                              child: Text('Give Feedback'),
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
