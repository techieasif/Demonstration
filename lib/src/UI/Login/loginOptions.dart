import 'package:flutter/material.dart';
import '../../../src/UI/Login/facebookLogin/FbLoginScreen.dart';
import '../../../src/UI/Login/googleLogin/googleSignIn.dart';
import '../../../src/appStyles/containerDecoration.dart';
import '../../../src/shared_wigets/themeChange.dart';
import 'PhoneLogin/pages/phoneLogin.dart';

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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                },
                Colors.green,
                "Phone Login",
              ),
              loginOption(() {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => FBLogin()));
              }, Colors.blue, "Facebook Login"),
              loginOption(() {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => GoogleLoginScreen()));
              }, Colors.deepOrange, "Google Login"),
              FlatButton(
                onPressed: (){
                  changeTheme(context);
                },
                child: Icon(Icons.lightbulb_outline),
              )
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
