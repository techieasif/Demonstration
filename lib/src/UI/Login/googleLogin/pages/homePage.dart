import 'package:assignmentwebkulasif/src/UI/Login/googleLogin/AuthService/GoogleLoginService.dart';
import 'package:flutter/material.dart';
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Home page"),
            RaisedButton(
              child: Text("Log out"),
              onPressed: (){
                AuthProvider().logOut();
              },
            )
          ],
        ),
      ),
    );
  }
}