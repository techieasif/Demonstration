import 'package:assignmentwebkulasif/src/UI/Login/googleLogin/widgets/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'homePage.dart';
import 'loginPage.dart';
class AuthGoogle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (context,AsyncSnapshot<FirebaseUser> snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting)
          return LoadingWidget();
        if(!snapshot.hasData || snapshot.data == null){
          return LoginPage();
        }
        print("LOGIN DATA: ${snapshot.data.displayName}");
        return HomePage();
      },
    );
  }
}
