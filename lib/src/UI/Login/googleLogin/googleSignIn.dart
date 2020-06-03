import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleLoginScreen extends StatefulWidget {
  @override
  _GoogleLoginScreenState createState() => _GoogleLoginScreenState();
}

class _GoogleLoginScreenState extends State<GoogleLoginScreen> {
  bool _isLoggedIn = false;
  bool error = false;
  String errorMsg = "";

  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  _login() async {
    try {
      await _googleSignIn.signIn();
      setState(() {
        _isLoggedIn = true;
      });
    } catch (err) {
      setState(() {
        error = true;
        errorMsg = err?.toString();
      });
    }
  }

  _logout() {
    _googleSignIn.signOut();
    setState(() {
      _isLoggedIn = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: error
          ? errorWidget
          : Center(
              child: _isLoggedIn
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.network(
                          _googleSignIn.currentUser.photoUrl,
                          height: 50.0,
                          width: 50.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(_googleSignIn.currentUser.displayName),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(_googleSignIn.currentUser.email),
                        ),
                        OutlineButton(
                          child: Text("Logout"),
                          onPressed: () {
                            Navigator.pop(context);
                            _logout();
                          },
                        )
                      ],
                    )
                  : Center(
                      child: OutlineButton(
                        child: Text("Login with Google"),
                        onPressed: () {
                          _login();
                        },
                      ),
                    ),
            ),
    );
  }

  Widget errorWidget() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("$errorMsg"),
          ),
          OutlineButton(child: Text("Retry"), onPressed: _login),
        ],
      ),
    );
  }
}
