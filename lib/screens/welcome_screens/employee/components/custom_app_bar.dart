import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:job_application/screens/questions.dart';

class CustomAppBar extends StatefulWidget {
  final GlobalKey<ScaffoldState> key;
  CustomAppBar({this.key});
  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  bool isSearch = false;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black,
      actions: <Widget>[
        isSearch
            ? Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              onPressed: () {
                setState(() {
                  isSearch = false;
                });
              },
              icon: new FaIcon(
                FontAwesomeIcons.timesCircle,
              ),
            ),
          ),
        )
            : Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              onPressed: () {
                setState(() {
                  isSearch = true;
                });
              },
              icon: new FaIcon(
                FontAwesomeIcons.search,
                size: 18,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Questions()),
              );
            },
            icon: new Icon(
              Icons.filter_list,
              color: Colors.white,
            ),
          ),
        )
      ],
      leading: Padding(
        padding: const EdgeInsets.only(top: 18.0),
        child: IconButton(
          onPressed: () {
            widget.key.currentState.openDrawer();
          },
          icon: Icon(Icons.dehaze),
        ),
      ),
      bottom: TabBar(
        tabs: <Widget>[
          Tab(
            child: Row(
              children: <Widget>[
                Icon(FontAwesomeIcons.paperPlane, color: Colors.white),
                SizedBox(
                  width: 10,
                ),
                Text('Applied ', style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
          Tab(
            child: Row(
              children: <Widget>[
                Icon(FontAwesomeIcons.briefcase, color: Colors.white),
                SizedBox(
                  width: 10,
                ),
                Text('Jobs', style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
          Tab(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(FontAwesomeIcons.checkCircle, color: Colors.white),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.01,
                ),
                Text('Completed',
                    style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
        ],
      ),
      title: !isSearch
          ? Text(
        "LAH App",
        style: TextStyle(fontFamily: 'Spicy Rice'),
      )
          : Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: TextField(
          onChanged: (value) {
            // myfilter(value);
          },
          style: TextStyle(color: Colors.white, fontSize: 18),
          decoration: InputDecoration(
            hintText: "Search Jobs",
            hintStyle: TextStyle(color: Colors.white),
            icon: new Icon(
              Icons.search,
              color: Colors.white,
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white70),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
          ),
        ),
      ),
      centerTitle: true,
    );
  }
}
