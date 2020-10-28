import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
class ViewJob extends StatefulWidget {
  @override
  _ViewJobState createState() => _ViewJobState();
  String type;
  String location;
  String title;
  String description;
  String qualification;
  String cimg;
  String cname;
  String status = '';


  ViewJob(this.type,this.location,this.title,this.description,this.qualification,this.cimg,this.cname,this.status);

}

class _ViewJobState extends State<ViewJob> {
  TextStyle infoStyle=TextStyle(fontSize: 15,fontWeight: FontWeight.bold,
      color: Colors.white);
  TextStyle infoStyle1=TextStyle(fontSize: 15,
      color: Colors.white);

  TextStyle heading=TextStyle(fontSize: 25,fontWeight: FontWeight.bold,
      color: Colors.black);



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Padding(

        padding: const EdgeInsets.all(8.0),
        child: FlatButton(


          shape:   RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
       onPressed: (){

       },
          color: Colors.grey,
          child:
          Text(widget.status,style: infoStyle,),
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
                height:230,
              ),

              Positioned.fill(
                top: 50,
                child: Align(

                  alignment: Alignment.center,
                  child: Column(
                    children: <Widget>[
                      CircleAvatar(


                        child:

                        Image.network(widget.cimg),
                        radius: 50,
                        backgroundColor: Colors.transparent,


                      ),

                      SizedBox(height: 20,),
                      Row(

                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[

                          Text("Type",style: infoStyle1,),
                          Text("Level",style: infoStyle1),
                          Text("Location",style: infoStyle1),
                        ],),

                      SizedBox(height: 5,),
                      Row(

                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[

                          Text(widget.type,style: infoStyle),
                          Text("Entry",style: infoStyle,),
                          Text(widget.location,style: infoStyle),
                        ],),





                    ],



                  ),
                ),
              )
              ,
              Positioned(
                left: 20,
                top: 40,
                child:   Align(

                    alignment: Alignment.bottomLeft,
                    child: InkWell(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Icon(FontAwesomeIcons.arrowLeft,color: Colors.white,))),
              )

            ],
          ),


          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 20),
            child:   Container(
              height: MediaQuery.of(context).size.height/2,
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: <Widget>[

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: <Widget>[

                      Text(widget.cname,style: heading,),
                      SizedBox(height: 8,),
                      Text(widget.title,style: TextStyle(
                          fontWeight: FontWeight.bold
                      ),),
                      SizedBox(height: 12,),
                      Text("Description",style: heading,),
                      SizedBox(height: 8,),
                      Text(widget.description),
                      SizedBox(height: 8,),
                      Text("Qualifications",style: heading,),
                      SizedBox(height: 8,),
                      Text(widget.qualification),




                    ],),




                ],



              ),
            ),
          )
          ,


        ],
      ),
    );
  }
}
