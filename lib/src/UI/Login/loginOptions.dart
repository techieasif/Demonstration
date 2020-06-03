import 'package:assignmentwebkulasif/src/UI/Login/facebookLogin/FbLoginScreen.dart';
import 'package:assignmentwebkulasif/src/appStyles/containerDecoration.dart';
import 'package:assignmentwebkulasif/src/UI/Login/PhoneLogin/pages/phoneLoginForm.dart';
import 'package:assignmentwebkulasif/src/UI/Login/googleLogin/googleSignIn.dart';
import 'package:flutter/material.dart';

import 'PhoneLogin/pages/phoneLoginNew.dart';
import 'googleLogin/pages/auth.dart';

class LoginOptionsScreen extends StatelessWidget {
  static const loginOptions = '/login-option';
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Center(
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
            children: <Widget>[
              loginOption(
                () {
//                  Navigator.pushNamed(context, PhoneLoginForm.phoneLoginForm);
                Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                },
                Colors.green,
                "Phone Login",
              ),
              loginOption(() {
                Navigator.push(context, MaterialPageRoute(builder: (context) => FBLogin()));
              }, Colors.blue, "Facebook Login"),
              loginOption(() {
                Navigator.push(context, MaterialPageRoute(builder: (context) => AuthGoogle()));
              }, Colors.deepOrange, "Google Login")
            ],
          ),
        ),
      ),
    );
  }

  Widget loginOption(VoidCallback fun, Color color, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18.0),
      child: RaisedButton(
        color: color,
        padding: const EdgeInsets.all(16),
        onPressed: fun,
        child: Text(
          title,
          style: titleStyle.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
