import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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

  String _getStatus(int status) {
    if (status == 0) return 'PENDING';
    if (status == 1) return 'PROCESSING';
    if (status == 2) return 'REJECTED';
    if (status == 3)
      return 'COMPLETED';
    else
      return 'ERROR';
  }

  Color _getStatusColor(int status) {
    if (status == 0) return Colors.yellowAccent;
    if (status == 1) return Colors.deepOrange;
    if (status == 2) return Colors.redAccent;
    if (status == 3)
      return Colors.greenAccent;
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
          color: Colors.grey,
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
