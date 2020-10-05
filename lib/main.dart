import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:job_application/languageSelect.dart';
import 'package:job_application/selectionScreen.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: GoogleFonts.montserratTextTheme(),
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with TickerProviderStateMixin{
  AnimationController _controller;

  @override
  void initState() {
    // TODO: implement initState
    _controller = AnimationController(
      duration: const Duration(seconds: 9),
      vsync: this,
    );

    super.initState();

    _controller.forward();
    new Future.delayed(
        const Duration(seconds: 9),
            () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>SelectCategory()),
        ));

  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(

      body:  Column(
mainAxisAlignment: MainAxisAlignment.start,
        children: [

          SizedBox(height: 50,),
           Image.asset("assets/images/undrawpic.png",







            height: 250,







          ),
SizedBox(height: 20,),
              Center(
                child: RotationTransition(



            turns: Tween(begin: 1.2, end: 2.2).animate(_controller),



            child:   Image.asset("assets/images/mylogo.png",







            height: 120,







            ),



          ),
              ),


SizedBox(height: 30,),


          Text("LAH APP",style: TextStyle(fontWeight: FontWeight.bold,

          fontSize: 30

          ),)

        ],

      ),
       // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
