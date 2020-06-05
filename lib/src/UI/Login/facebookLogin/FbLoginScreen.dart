import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;

class FBLogin extends StatefulWidget {
  @override
  _FBLoginState createState() => _FBLoginState();
}

class _FBLoginState extends State<FBLogin> {
  bool _isLoggedIn = false;
  bool showLoader = true;
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
          showLoader = false;
        });
        break;

      case FacebookLoginStatus.cancelledByUser:
        setState(() {
          showLoader = false;
          _isLoggedIn = false;
        });
        break;
      case FacebookLoginStatus.error:
        setState(() {
          showLoader = false;
          _isLoggedIn = false;
        });
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
  void initState() {
    _loginWithFB();
    super.initState();
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
                      Navigator.pop(context);
                      _logout();
                    },
                  )
                ],
              )
            : showLoader
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Center(
                    child: !_isLoggedIn
                        ? Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text("Something went wrong"),
                              SizedBox(
                                height: 20,
                              ),
                              OutlineButton(
                                child: Text("Try Again"),
                                onPressed: () {
                                  _loginWithFB();
                                },
                              ),
                            ],
                          )
                        : ("logging ..")),
      ),
    );
  }
}
