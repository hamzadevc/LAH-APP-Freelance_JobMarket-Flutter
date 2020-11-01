
import 'package:flutter/material.dart';
import 'package:job_application/wrapper.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    print('Home INIT');
    _controller = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );

    super.initState();

    _controller.forward();
    new Future.delayed(
      const Duration(seconds: 9),
          () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Wrapper()),
      ),
    );
    print('HOME INIT Ends');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 50,
          ),
          Image.asset(
            "assets/images/undrawpic.png",
            height: 250,
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: RotationTransition(
              turns: Tween(begin: 1.2, end: 2.2).animate(_controller),
              child: Image.asset(
                "assets/images/mylogo.png",
                height: 120,
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            "LAH APP",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          )
        ],
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}