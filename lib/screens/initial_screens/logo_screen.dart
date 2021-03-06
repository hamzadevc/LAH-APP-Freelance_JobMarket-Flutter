import 'dart:async';
import 'package:flutter/material.dart';
import '../../screens/initial_screens/splash_screen.dart';
import 'package:video_player/video_player.dart';

class LogoScreen extends StatefulWidget {
  LogoScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LogoScreenState createState() => _LogoScreenState();
}

class _LogoScreenState extends State<LogoScreen> with TickerProviderStateMixin {
  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5),
            ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) =>
                    SplashScreen()
            )
        )
    );

    _controller = VideoPlayerController.asset('assets/LAH4K_02.mp4')
      ..initialize().then((_) {
        // Once the video has been loaded we play the video and set looping to true.
        _controller.play();
        _controller.setLooping(true);
        _controller.setVolume(0.0);
        _controller.play();
        // Ensure the first frame is shown after the video is initialized.
        //setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SizedBox.expand(
          child: FittedBox(
            // If your background video doesn't look right, try changing the BoxFit property.
            // BoxFit.fill created the look I was going for.
            fit: BoxFit.fill,
            child: SizedBox(
              width: _controller.value.size?.width ?? 0,
              height: _controller.value.size?.height ?? 0,
              child: VideoPlayer(_controller),
            ),
          ),
        ),
      )
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}