import 'package:flutter/material.dart';

import '../../wrapper.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>  with TickerProviderStateMixin {
  AnimationController _controller;
  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
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
            "LAH",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          )
        ],
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
