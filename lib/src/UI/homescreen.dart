import 'package:assignmentwebkulasif/src/UI/Login/loginOptions.dart';
import 'package:assignmentwebkulasif/src/shared_wigets/optionWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../shared_wigets/background_gradient.dart';
import 'CreateShow/selectMultipleImages.dart';
import 'Download/downloadPage.dart';
import 'TrackMe/googleMapPage.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          backgroundGradient,
          grid(context, screenSize),
        ],
      ),
    );
  }

  Widget grid(BuildContext context, Size screenSize) {
    return Align(
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
             OptionWidget(fun: (){
              Navigator.pushNamed(context, LoginOptionsScreen.loginOptions);
             }, title: "Login", screenSize: screenSize,key: UniqueKey()),
             OptionWidget(fun: (){

               Navigator.push(context, MaterialPageRoute(builder: (context)=> SelectMultipleImages()));
             }, title: "Create Show", screenSize: screenSize,key: UniqueKey()),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
             OptionWidget(fun: (){

               Navigator.push(context, MaterialPageRoute(builder: (context)=> MapsScreen()));
             }, title: "Track Me", screenSize: screenSize,key: UniqueKey()),
             OptionWidget(fun: (){
               Navigator.push(context, MaterialPageRoute(builder: (context)=> DownloadImage()));
             }, title: "Download", screenSize: screenSize,key: UniqueKey()),


            ],
          ),
        ],
      ),
    );
  }
}
