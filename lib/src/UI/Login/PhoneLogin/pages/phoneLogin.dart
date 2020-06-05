import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'userPage.dart';
import '../../../../../src/Helpers/formValidators.dart';
import '../../../../../src/appStyles/textFieldDecorations.dart';
import '../../../../../src/shared_wigets/themeChange.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String phoneNo, otpSent, verificationId;
  final _phoneFormKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _autoValidate = false;
  TextEditingController phoneController;

  @override
  void initState() {
    super.initState();
    phoneController = TextEditingController();
  }


  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Phone Login with FireBase'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.lightbulb_outline),
            onPressed: () {
              changeTheme(context);
            },
          )
        ],
      ),
      body: Form(
        key: _phoneFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                  style: Theme.of(context).textTheme.bodyText1,
                  autovalidate: _autoValidate,
                  keyboardType: TextInputType.text,
                  validator: FormValidators.phoneNumberValidator,
                  decoration:
                      textFieldDecoration(hintText: "Phone ", context: context),
                  onChanged: (value) {
                    this.phoneNo = value;
                  }),
            ),
            SizedBox(height: 10.0),
            RaisedButton(
              onPressed: () {
                if (_phoneFormKey.currentState.validate()) {
                  verifyPhone();
                } else {
                  setState(() {
                    _autoValidate = true;
                  });
                }
              },
              child: Text(
                'Verify',
                style: TextStyle(color: Colors.white),
              ),
              elevation: 7.0,
              color: Colors.green,
            )
          ],
        ),
      ),
    );
  }

//verifying phone with firebase
  Future<void> verifyPhone() async {
    final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verId) {
      this.verificationId = verId;
    };
    final PhoneCodeSent smsCodeSent = (String verId, [int forceCodeResend]) {
      this.verificationId = verId;
      otpDialog(context).then((value) {
        print("Code Sent");
      });
    };
    final PhoneVerificationCompleted verifiedSuccess = (AuthCredential auth) {};
    final PhoneVerificationFailed verifyFailed = (AuthException e) {
      print('${e.message}');
    };
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: "+91" + phoneNo,
      timeout: const Duration(seconds: 5),
      verificationCompleted: verifiedSuccess,
      verificationFailed: verifyFailed,
      codeSent: smsCodeSent,
      codeAutoRetrievalTimeout: autoRetrieve,
    );
  }

//used to get otp input from user
  Future<bool> otpDialog(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter OTP'),
          content: TextFormField(
              style: Theme.of(context).textTheme.bodyText1,
              autovalidate: _autoValidate,
              keyboardType: TextInputType.text,
              decoration:
                  textFieldDecoration(hintText: "OTP ", context: context),
              onChanged: (value) {
                this.otpSent = value;
              }),
          contentPadding: EdgeInsets.all(10.0),
          actions: <Widget>[
            FlatButton(
                onPressed: () {
                  FirebaseAuth.instance.currentUser().then((user) {
                    if (user != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => UserPage()),
                      );

                      Navigator.of(context).pop();
                    } else {
                      Navigator.of(context).pop();
                      signIn(otpSent);
                    }
                  });
                },
                child: Text(
                  'SUBMIT',
                  style: TextStyle(color: Colors.green),
                ))
          ],
        );
      },
    );
  }

//performing sign in
  Future<void> signIn(String smsCode) async {
    final AuthCredential credential = PhoneAuthProvider.getCredential(
      verificationId: verificationId,
      smsCode: smsCode,
    );
    await FirebaseAuth.instance.signInWithCredential(credential).then((user) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => UserPage(),
        ),
      );
    }).catchError((e) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text("$e"),
      ));

      print("error at phone sign in function: $e");
    });
  }
}
