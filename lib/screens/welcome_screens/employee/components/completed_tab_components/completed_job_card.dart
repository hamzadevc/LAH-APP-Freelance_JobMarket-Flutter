import 'package:expandable/expandable.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import '../../../../../modals/review.dart';
import '../../../../../modals/user_profile.dart';
import '../../../../welcome_screens/employee/components/completed_tab_components/star_display.dart';
import '../../../../../services/database_service.dart';
import '../../../../../services/review_service.dart';

class CompletedCard extends StatefulWidget {
  final String cId;
  final String uId;
  final String rating;
  final String feedback;

  CompletedCard({
    this.uId,
    this.cId,
    this.rating,
    this.feedback,
  });

  @override
  _CompletedCardState createState() => _CompletedCardState();
}

class _CompletedCardState extends State<CompletedCard> {
  UserProfile _jobProfile;
  UserReview _review;
  bool _isLoading = false;

  @override
  void initState() {
    _getJobDetail(widget.uId, widget.cId);
    super.initState();
  }

  _toggleLoading() {
    if(mounted) {
      setState(() {
        _isLoading = !_isLoading;
      });
    }
  }

  _getJobDetail(String uid, String cId) async {
    _toggleLoading();
    _jobProfile = await DatabaseService(uId: cId).getUser();
    _review = await ReviewService(takerId: widget.cId, senderId: widget.uId)
        .getReview();
    _toggleLoading();
  }

  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * 0.22 +
                    (widget.feedback.length * 0.1),
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: ListView(
                    shrinkWrap: true,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          CircleAvatar(
                            backgroundColor: Colors.transparent,
                            radius: 20,
                            child: _isLoading
                                ? Image.asset('assets/images/mylogo.png')
                                : Image.network(
                                    _jobProfile.imgUrl,
                                  ),
                          ),
                          Text(
                            "Company Review",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 25,
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            'Rating: ',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          StarDisplay(
                            value: double.parse(widget.rating),
                          ),
                        ],
                      ),
                      SingleChildScrollView(
                        child: Container(
                          child: ListTile(
                            title: Text(
                              'Feedback',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            subtitle: ExpandableText(
                              widget.feedback,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                              expandText: 'show more',
                              collapseText: 'show less',
                              maxLines: 1,
                              linkColor: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  decoration: new BoxDecoration(
                    gradient: new LinearGradient(
                      colors: [Colors.black, Colors.black],
                      begin: const FractionalOffset(0.0, 0.0),
                      end: const FractionalOffset(1.0, 0.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp,
                    ),
                  ),
                ),
              ),
              if (_review != null)
                ScrollOnExpand(
                  scrollOnExpand: true,
                  scrollOnCollapse: false,
                  child: ExpandablePanel(
                    theme: const ExpandableThemeData(
                      headerAlignment: ExpandablePanelHeaderAlignment.center,
                      tapBodyToCollapse: true,
                    ),
                    header: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "Your Review",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    expanded: Column(
                      children: <Widget>[
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              'Rating: ',
                              style: TextStyle(
                                color: Colors.black87,
                              ),
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            StarDisplay(
                              value: double.parse(_review.rating),
                              color: Colors.black54,
                            ),
                          ],
                        ),
                        SingleChildScrollView(
                          child: Container(
                            child: ListTile(
                              title: Text(
                                'Feedback',
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              subtitle: ExpandableText(
                                _review.feedback,
                                style: TextStyle(
                                  color: Colors.black87,
                                ),
                                expandText: 'show more',
                                collapseText: 'show less',
                                maxLines: 1,
                                linkColor: Colors.blue,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    builder: (_, collapsed, expanded) {
                      return Padding(
                        padding:
                            EdgeInsets.only(left: 10, right: 10, bottom: 10),
                        child: Expandable(
                          collapsed: collapsed,
                          expanded: expanded,
                          theme: const ExpandableThemeData(crossFadePoint: 0),
                        ),
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
