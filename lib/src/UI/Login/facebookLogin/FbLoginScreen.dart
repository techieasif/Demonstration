import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;

//
//class FBLoginScreen extends StatefulWidget {
//  @override
//  _FBLoginScreenState createState() => _FBLoginScreenState();
//}
//
//class _FBLoginScreenState extends State<FBLoginScreen> {
//  bool _isLoggedIn = false;
//  bool error = false;
//  String errorMsg = "";
//
//  FacebookLogin fbLogin = FacebookLogin();
//var userData;
//  _login() {
//    fbLogin
//        .logIn(['email', 'public_profile'])
//        .then((result) {
//          switch(result.status){
//            case FacebookLoginStatus.loggedIn:
//              FirebaseAuth.instance.signInWithCustomToken(token: result.accessToken.token).then((value){
//
//              }).catchError((onError){
//
//              });
//          }
//    })
//        .catchError((onError) {});
//  }
//
////  _logout() {
////    _googleSignIn.signOut();
////    setState(() {
////      _isLoggedIn = false;
////    });
////  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      body: error
//          ? errorWidget
//          : Center(
//              child: _isLoggedIn
//                  ? Column(
//                      mainAxisAlignment: MainAxisAlignment.center,
//                      children: <Widget>[
////                        Image.network(
////                          _googleSignIn.currentUser.photoUrl,
////                          height: 50.0,
////                          width: 50.0,
////                        ),
////                        Padding(
////                          padding: const EdgeInsets.all(8.0),
////                          child: Text(_googleSignIn.currentUser.displayName),
////                        ),
////                        Padding(
////                          padding: const EdgeInsets.all(8.0),
////                          child: Text(_googleSignIn.currentUser.email),
////                        ),
////                        OutlineButton(
////                          child: Text("Logout"),
////                          onPressed: () {
////                            Navigator.pop(context);
////                            _logout();
////                          },
////                        )
//                      ],
//                    )
//                  : Center(
//                      child: OutlineButton(
//                        child: Text("Login with Google"),
//                        onPressed: () {
//                          _login();
//                        },
//                      ),
//                    ),
//            ),
//    );
//  }
//
//  Widget errorWidget() {
//    return Center(
//      child: Column(
//        mainAxisSize: MainAxisSize.min,
//        children: <Widget>[
//          Padding(
//            padding: const EdgeInsets.all(8.0),
//            child: Text("$errorMsg"),
//          ),
//          OutlineButton(child: Text("Retry"), onPressed: _login),
//        ],
//      ),
//    );
//  }
//}

class FBLogin extends StatefulWidget {
  @override
  _FBLoginState createState() => _FBLoginState();
}

class _FBLoginState extends State<FBLogin> {
  bool _isLoggedIn = false;
  Map userProfile;
  final facebookLogin = FacebookLogin();

  _loginWithFB() async {
    final result = await facebookLogin.logIn(['email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final token = result.accessToken.token;
        final graphResponse = await http.get(
            'https://graph.facebook.com/v2.12/me?fields=name,picture,email&access_token=${token}');
        final profile = JSON.jsonDecode(graphResponse.body);
        print(profile);
        setState(() {
          userProfile = profile;
          _isLoggedIn = true;
        });
        break;

      case FacebookLoginStatus.cancelledByUser:
        setState(() => _isLoggedIn = false);
        break;
      case FacebookLoginStatus.error:
        setState(() => _isLoggedIn = false);
        break;
    }
  }

  _logout() {
    facebookLogin.logOut();
    setState(() {
      _isLoggedIn = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
          child: _isLoggedIn
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.network(
                      userProfile["picture"]["data"]["url"],
                      height: 50.0,
                      width: 50.0,
                    ),
                    Text(userProfile["name"]),
                    OutlineButton(
                      child: Text("Logout"),
                      onPressed: () {
                        _logout();
                      },
                    )
                  ],
                )
              : Center(
                  child: OutlineButton(
                    child: Text("Login with Facebook"),
                    onPressed: () {
                      _loginWithFB();
                    },
                  ),
                ),
      ),
    );
  }
}
